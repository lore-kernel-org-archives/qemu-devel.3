Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACA5C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgRJ-0002Dt-QK; Wed, 07 May 2025 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCgRI-0002Dj-4b
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCgRF-0003uv-Uz
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746630719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkFcI6VVbSviliWAszQGwyZLi8kvw6p5P/9fHjPNIgk=;
 b=hIbkF/A5wRbVzI7V/2WCyc1Eju0PkBkbwxLDTBNkUU3vWto5NFxtzuyPNsXWRbZdMnYjyt
 VdtULXGhrC6zD1ibb9pihILg6Yqe4+Z//ZWXNaBXrqyMtjnZWH3lp5Vk8R4AWpgB2rn5xe
 EuTq1O+FXLur0aC7ZvI22cFfj46p/QQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-bGchAD3_OySBSeRgdrq2LA-1; Wed,
 07 May 2025 11:11:56 -0400
X-MC-Unique: bGchAD3_OySBSeRgdrq2LA-1
X-Mimecast-MFC-AGG-ID: bGchAD3_OySBSeRgdrq2LA_1746630708
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4F441955DC5; Wed,  7 May 2025 15:11:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E934918003FC; Wed,  7 May 2025 15:11:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29F0721E6768; Wed, 07 May 2025 17:11:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Mark Burton
 <mburton@qti.qualcomm.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Alessandro Di Federico <ale@rev.ng>,  Alistair Francis
 <alistair.francis@wdc.com>,  Anton Johansson <anjo@rev.ng>,  Brian Cain
 <bcain@quicinc.com>,  "Daniel P. Berrange" <berrange@redhat.com>,  Chao
 Peng <chao.p.peng@linux.intel.com>,  Neo Jia <cjia@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>,  "Wedgwood, Chris" <cw@f00f.org>,
 dhedde@kalrayinc.com,  Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Auger Eric
 <eric.auger@redhat.com>,  Felipe Franciosi <felipe@nutanix.com>,
 iggy@theiggy.com,  Warner Losh <imp@bsdimp.com>,  Jan Kiszka
 <jan.kiszka@web.de>,  Jason Gunthorpe <jgg@nvidia.com>,  Jidong Xiao
 <jidong.xiao@gmail.com>,  Jim Shu <jim.shu@sifive.com>,  Joao Martins
 <joao.m.martins@oracle.com>,  Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>,  Luc Michel <luc@lmichel.fr>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Max Chou
 <max.chou@sifive.com>,  Meirav Dean <mdean@redhat.com>,
 mimu@linux.vnet.ibm.com,  "Ho, Nelson" <nelson.ho@windriver.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  Wei Wang <wei.w.wang@intel.com>,  z.huo@139.com,  LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  "Wu, Zhiyong"
 <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
In-Reply-To: <5ce00003-4105-40c7-954b-63336a4325d5@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 30 Apr 2025 16:36:11
 +0200")
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
 <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
 <87a57ydj8y.fsf@pond.sub.org>
 <5ce00003-4105-40c7-954b-63336a4325d5@linaro.org>
Date: Wed, 07 May 2025 17:11:39 +0200
Message-ID: <87plgkihg4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 30/4/25 12:41, Markus Armbruster wrote:

[...]

>> Pierrick's stated goal is to have no noticable differences between the
>> single binary and the qemu-system-<target> it covers.
>>=20
>> We have two external interfaces to worry about: QMP and the command
>> line.  Let's ignore the latter for now.
>>=20
>> Target-specific differences in *syntax* come from QAPI schema
>> conditionals with target-specific conditions.  Example:
>>=20
>>      { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInf=
o'],
>>        'if': { 'any': [ 'TARGET_PPC',
>>                         'TARGET_ARM',
>>                         'TARGET_I386',
>>                         'TARGET_S390X',
>>                         'TARGET_MIPS',
>>                         'TARGET_LOONGARCH64',
>>                         'TARGET_RISCV' ] } }
>>=20
>> This command is only defined for some targets.
>>=20
>> The value of query-qmp-schema reflects this: it has
>> query-cpu-definitions exactly when the condition is satisfied.  The
>> condition is evaluated at compile-time, because that's how QAPI schema
>> 'if' works.
>>=20
>> Say we drop the condition and instead add an equivalent run-time
>> condition to command registration.  This preserves behavior of command
>> execution.  But query-qmp-schema now has query-cpu-definitions *always*.
>> This is a noticable difference.  It may break management applications
>> that use query-qmp-schema to probe for the command.
>>=20
>> Moreover, conditionals aren't limited to commands.  Example:
>>=20
>>      { 'struct': 'CpuModelExpansionInfo',
>>        'data': { 'model': 'CpuModelInfo',
>>                  'deprecated-props' : { 'type': ['str'],
>> --->                                   'if': 'TARGET_S390X' } },
>>        'if': { 'any': [ 'TARGET_S390X',
>>                         'TARGET_I386',
>>                         'TARGET_ARM',
>>                         'TARGET_LOONGARCH64',
>>                         'TARGET_RISCV' ] } }
>>=20
>> Here we have a conditional member.

[...]

> IMHO conditionals should only depend on host / static configuration
> features, not features modifiable from the command line.

This is how the QAPI schema works now.

>                                                          (I'm always
> confused by KVM features published in the schema, but then you start
> your binary with -accel=3Dtcg and still can run KVM specific commands
> via QMP, returning errors).

Not exactly a ringing endorsement for keeping the QAPI schema work the
way it does now, isn't it?  ;)

The problem at hand is QAPI-generated files in a single binary.

Pierrick posted "[RFC PATCH 0/3] single-binary: make QAPI generated
files common".  The patches are flawed, but that's alright for RFC.

In review, I pointed out three possible solutions, and discussed their
pros and cons:

(1) Drop target-specific conditionals.

(2) Replace them by run-time checks.

(3) Have target-specific QAPI-generated code for multiple targets
    coexist in the single binary.

Both (1) and (3) keep the QAPI schema work as it does now.

Pierrick's patches are an incomplete attempt at (2).

Daniel made a case for (1).  You and I actually discussed (1) before,
and I encouraged you to explore it.

We can certainly discuss this some more, but I'd prefer to review a
working solution instead.


