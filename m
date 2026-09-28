Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D56CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBA4z-0007lP-0k; Mon, 28 Sep 2026 08:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBA4x-0007kp-7U
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBA4v-00052a-BK
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790597008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=198HLUE7nj8MuKtdpZw6KT9sUJQ17m+O7A96pp/kfMo=;
 b=bw9SP+ZdGWtPz/pOHkn2pFgSyOIVTHKcGFiek1LbmPUooww4zqKuAZ4pImRoqFmPMoWYF4
 +VDUL7z0zKgaVyPxj2Xnc/F9G7HsijNOiWAQEhD1+MPfd8xR+1wq/Rm8R/hrdum231Xa6c
 RH5prmaWP/7quIpsELyjSb1zLdopB94=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-Igh5X9UDNmy09h7qq2N4bg-1; Mon,
 28 Sep 2026 08:03:24 -0400
X-MC-Unique: Igh5X9UDNmy09h7qq2N4bg-1
X-Mimecast-MFC-AGG-ID: Igh5X9UDNmy09h7qq2N4bg_1790597002
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C1D619539BD; Mon, 28 Sep 2026 12:03:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A62A1956087; Mon, 28 Sep 2026 12:03:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B4B921E6A04; Mon, 28 Sep 2026 14:03:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@oss.qualcomm.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
In-Reply-To: <aro93NuZBXYGbD33@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 28 Sep 2026 11:13:48 +0100")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
Date: Mon, 28 Sep 2026 14:03:19 +0200
Message-ID: <87se2tfurc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
>> query-targets lists each linked target, including none, with its
>> arch, endianness, and the machines that target accepts.
>>=20
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>  hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
>>  qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 65 insertions(+)
>
>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 6aaa2af709a..d8cdea6203e 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -307,6 +307,41 @@
>>  ##
>>  { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
>>=20=20
>> +##
>> +# @TargetMachines:
>> +#
>> +# One registered system target and the machines that can run on it.
>> +#
>> +# @arch: the target architecture
>> +#
>> +# @endianness: the target endianness
>> +#
>> +# @machines: machine type names, not aliases
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'TargetMachines',
>> +  'data': { 'arch': 'SysEmuTarget',
>> +            'endianness': 'EndianMode',
>> +            'machines': ['str'] } }
>
> We already have  'QemuTargetInfo' struct which is used
> with 'query-target', that should also be used with the
> new 'query-targets' command.
>
> We need to add the 'endianness' field to QemuTargetInfo.
>
> I don't think that we need to report machines though.
> We already have 'query-machines' which gives much broader
> information on the machines. "MachineInfo" needs to
> gain
>
>    "targets": ["SysEmuTarget"]
>
> to list which target(s) a machine can be used with.

Do we need query-targets at all?  What information does it provide that
cannot easily be computed from query-machines once we add @target and
@endiannes to MachineInfo?

>> +
>> +##
>> +# @query-targets:
>> +#
>> +# Return each target linked into this QEMU binary and the machines
>> +# whose availability check accepts that target.
>> +#
>> +# Since: 11.2
>> +#
>> +# .. qmp-example::
>> +#
>> +#     -> { "execute": "query-targets" }
>> +#     <- { "return": [ { "arch": "aarch64", "endianness": "little",
>> +#                        "machines": [ "virt" ] } ] }
>> +##
>> +{ 'command': 'query-targets',
>> +  'returns': ['TargetMachines'] }
>
>
> With regards,
> Daniel


