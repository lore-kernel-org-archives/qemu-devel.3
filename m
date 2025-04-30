Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F657C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4sp-0007xn-Ms; Wed, 30 Apr 2025 06:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uA4sl-0007we-Ar
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uA4sh-0004Eb-KU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746009693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6zJaCkloOT7meEjDo+zSa1cYbag/t0xH4JUf0KFuLtk=;
 b=Uto610mwDxv8vujGbVdtJ25YfAr5daFMITLHllg03s4QGXmhx29mOFz+7JeXDNYrq6R9HQ
 NidY8e08POl9P5ZO+NLBL82qKM9mmbx9YX0OwdWxgvMN4dwkJWh5Gnh/v6C7CuPtbijvrN
 AFaQWlVXWmohzNBiCMwTnFHDE+Y95yo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-TO4o7q4eO0CPFPw8Qhq48Q-1; Wed,
 30 Apr 2025 06:41:30 -0400
X-MC-Unique: TO4o7q4eO0CPFPw8Qhq48Q-1
X-Mimecast-MFC-AGG-ID: TO4o7q4eO0CPFPw8Qhq48Q_1746009685
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F276F1800264; Wed, 30 Apr 2025 10:41:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C26A195608D; Wed, 30 Apr 2025 10:41:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF75721E66C2; Wed, 30 Apr 2025 12:41:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
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
In-Reply-To: <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
 (Paolo Bonzini's message of "Tue, 29 Apr 2025 16:24:49 +0200")
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
 <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
Date: Wed, 30 Apr 2025 12:41:17 +0200
Message-ID: <87a57ydj8y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il lun 28 apr 2025, 14:58 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>=
 ha
> scritto:
>
>> On 28/4/25 13:05, Alex Benn=C3=A9e wrote:
>> >
>> > Hi,
>> >
>> > The KVM/QEMU community call is at:
>> >
>> > https://meet.jit.si/kvmcallmeeting
>> > @
>> > 29/04/2025 14:00 UTC
>> >
>> > Are there any agenda items for the sync-up?
>> >
>>
>> For single binary / heterogeneous emulation, we'd like QAPI to
>> be "feature-agnostic". In particular, using the example of KVM
>> accelerator, whether a binary can run with it built-in or not
>> should be is irrelevant for management applications: they should
>> only check if it is used (enabled).
>>
>> The following series is adding KVM specific structures and commands:
>>
>> https://lore.kernel.org/qemu-devel/20250409082649.14733-2-zhao1.liu@inte=
l.com/
>> It could be interesting to discuss if this can be avoided. But this
>> can also be discussed on the mailing list (as it is still currently).
>>
>
> Would it be possible to just mark the commands as "do not autoregister" a=
nd
> then do the registration (for example) at machine/accelerator/CPU creatio=
n?
>
> I think qemu-ga already has a similar run-time registration model but I
> don't know why QEMU does not use it.

I think we covered this to a degree in

    Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files c=
ommon
    Message-ID: <87a584b69n.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87a584b69n.fsf@pond.sub.org/

But let me try to give you a shorter argument.

Pierrick's stated goal is to have no noticable differences between the
single binary and the qemu-system-<target> it covers.

We have two external interfaces to worry about: QMP and the command
line.  Let's ignore the latter for now.

Target-specific differences in *syntax* come from QAPI schema
conditionals with target-specific conditions.  Example:

    { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
      'if': { 'any': [ 'TARGET_PPC',
                       'TARGET_ARM',
                       'TARGET_I386',
                       'TARGET_S390X',
                       'TARGET_MIPS',
                       'TARGET_LOONGARCH64',
                       'TARGET_RISCV' ] } }

This command is only defined for some targets.

The value of query-qmp-schema reflects this: it has
query-cpu-definitions exactly when the condition is satisfied.  The
condition is evaluated at compile-time, because that's how QAPI schema
'if' works.

Say we drop the condition and instead add an equivalent run-time
condition to command registration.  This preserves behavior of command
execution.  But query-qmp-schema now has query-cpu-definitions *always*.
This is a noticable difference.  It may break management applications
that use query-qmp-schema to probe for the command.

Moreover, conditionals aren't limited to commands.  Example:

    { 'struct': 'CpuModelExpansionInfo',
      'data': { 'model': 'CpuModelInfo',
                'deprecated-props' : { 'type': ['str'],
--->                                   'if': 'TARGET_S390X' } },
      'if': { 'any': [ 'TARGET_S390X',
                       'TARGET_I386',
                       'TARGET_ARM',
                       'TARGET_LOONGARCH64',
                       'TARGET_RISCV' ] } }

Here we have a conditional member.

Another example: the KVM PMU filter series linked above wants to define

    { 'enum': 'KvmPmuEventFormat',
      'data': ['raw', 'x86-select-umask', 'x86-masked-entry'] }

The enum makes sense only when we have CONFIG_KVM.  Member @raw makes
sense regardless of target then.  The other two only for TARGET_I386.

We could elect to forgo such conditionals.  The main disadvantage is
loss of precision in query-qmp-schema.  Which may or may not matter, and
may or may not box us into corners.

Pierrick volunteered to explore evaluating target-specific QAPI-Schem
conditionals at run-time instead of compile-time.  This would preserve
the value of query-qmp-schema, unlike conditional command registration.

Finally, syntax isn't everything.  We need to preserve behavior, too.
But that's a separate topic.


