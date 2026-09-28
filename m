Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DABC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7KT-0002NE-AV; Mon, 28 Sep 2026 05:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB7KP-0002MO-Ft
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB7KN-00048u-K7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790586434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4kIHcUlBMtS1AuR/EVbxmsk9yZqA/j/g113fZSdW0k=;
 b=YUJayMgydZSjE9wSDaS0vVIKVe6NGu+x8lxfaz6jzGpbJr9asGrBEfqN518Vo2VC4/6BEh
 pqLPwQgVTWE5KPdfg7wvcA18d7WBrJ1d40rq3hDwNtkPiRYaPcYYQwUI8OdzFSryWEMWAl
 BM3ZJryWWb9FMd3/XOb1hZ7uaI2qRRo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-6J-X5N2LMh2uH7RIYrltSQ-1; Mon,
 28 Sep 2026 05:07:10 -0400
X-MC-Unique: 6J-X5N2LMh2uH7RIYrltSQ-1
X-Mimecast-MFC-AGG-ID: 6J-X5N2LMh2uH7RIYrltSQ_1790586428
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1899118512EE; Mon, 28 Sep 2026 09:07:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25C4F30000E3; Mon, 28 Sep 2026 09:07:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C497121E6A04; Mon, 28 Sep 2026 11:07:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v4 07/55] tests/unit: add test-target-info
In-Reply-To: <20260926070057.1234-8-luoyonggang@gmail.com> (Yonggang Luo's
 message of "Sat, 26 Sep 2026 15:00:06 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-8-luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 11:07:04 +0200
Message-ID: <87zex1hhhj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Yonggang Luo <luoyonggang@gmail.com> writes:

> Collect each target-info-def.c object in target_info_def_objects,
> keyed by target dir. Link every value so constructors fill the
> list. Assert target_info() is not NULL and target_info_list() has
> one entry per linked object.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Doesn't compile for me:

../tests/unit/meson.build:47:37: ERROR: Unknown method "values" in object <=
[DictHolder] holds [dict]: {'aarch64-linux-user': <ExtractedObjects 'qemu-a=
arch64-linux-user': [<File: target-info-def.c (not built)>]>, 'aarch64_be-l=
inux-user': <ExtractedObjects 'qemu-aarch64_be-linux-user': [<File: target-=
info-def.c (not built)>]>, 'alpha-linux-user': <ExtractedObjects 'qemu-alph=
a-linux-user': [<File: target-info-def.c (not built)>]>, 'arm-linux-user': =
<ExtractedObjects 'qemu-arm-linux-user': [<File: target-info-def.c (not bui=
lt)>]>, 'armeb-linux-user': <ExtractedObjects 'qemu-armeb-linux-user': [<Fi=
le: target-info-def.c (not built)>]>, 'hexagon-linux-user': <ExtractedObjec=
ts 'qemu-hexagon-linux-user': [<File: target-info-def.c (not built)>]>, 'hp=
pa-linux-user': <ExtractedObjects 'qemu-hppa-linux-user': [<File: target-in=
fo-def.c (not built)>]>, 'i386-linux-user': <ExtractedObjects 'qemu-i386-li=
nux-user': [<File: target-info-def.c (not built)>]>, 'loongarch64-linux-use=
r': <ExtractedObjects 'qemu-loongarch64-linux-user': [<File: target-info-de=
f.c (not built)>]>, 'm68k-linux-user': <ExtractedObjects 'qemu-m68k-linux-u=
ser': [<File: target-info-def.c (not built)>]>, 'microblaze-linux-user': <E=
xtractedObjects 'qemu-microblaze-linux-user': [<File: target-info-def.c (no=
t built)>]>, 'microblazeel-linux-user': <ExtractedObjects 'qemu-microblazee=
l-linux-user': [<File: target-info-def.c (not built)>]>, 'mips-linux-user':=
 <ExtractedObjects 'qemu-mips-linux-user': [<File: target-info-def.c (not b=
uilt)>]>, 'mips64-linux-user': <ExtractedObjects 'qemu-mips64-linux-user': =
[<File: target-info-def.c (not built)>]>, 'mips64el-linux-user': <Extracted=
Objects 'qemu-mips64el-linux-user': [<File: target-info-def.c (not built)>]=
>, 'mipsel-linux-user': <ExtractedObjects 'qemu-mipsel-linux-user': [<File:=
 target-info-def.c (not built)>]>, 'mipsn32-linux-user': <ExtractedObjects =
'qemu-mipsn32-linux-user': [<File: target-info-def.c (not built)>]>, 'mipsn=
32el-linux-user': <ExtractedObjects 'qemu-mipsn32el-linux-user': [<File: ta=
rget-info-def.c (not built)>]>, 'or1k-linux-user': <ExtractedObjects 'qemu-=
or1k-linux-user': [<File: target-info-def.c (not built)>]>, 'ppc-linux-user=
': <ExtractedObjects 'qemu-ppc-linux-user': [<File: target-info-def.c (not =
built)>]>, 'ppc64-linux-user': <ExtractedObjects 'qemu-ppc64-linux-user': [=
<File: target-info-def.c (not built)>]>, 'ppc64le-linux-user': <ExtractedOb=
jects 'qemu-ppc64le-linux-user': [<File: target-info-def.c (not built)>]>, =
'riscv32-linux-user': <ExtractedObjects 'qemu-riscv32-linux-user': [<File: =
target-info-def.c (not built)>]>, 'riscv64-linux-user': <ExtractedObjects '=
qemu-riscv64-linux-user': [<File: target-info-def.c (not built)>]>, 's390x-=
linux-user': <ExtractedObjects 'qemu-s390x-linux-user': [<File: target-info=
-def.c (not built)>]>, 'sh4-linux-user': <ExtractedObjects 'qemu-sh4-linux-=
user': [<File: target-info-def.c (not built)>]>, 'sh4eb-linux-user': <Extra=
ctedObjects 'qemu-sh4eb-linux-user': [<File: target-info-def.c (not built)>=
]>, 'sparc-linux-user': <ExtractedObjects 'qemu-sparc-linux-user': [<File: =
target-info-def.c (not built)>]>, 'sparc32plus-linux-user': <ExtractedObjec=
ts 'qemu-sparc32plus-linux-user': [<File: target-info-def.c (not built)>]>,=
 'sparc64-linux-user': <ExtractedObjects 'qemu-sparc64-linux-user': [<File:=
 target-info-def.c (not built)>]>, 'x86_64-linux-user': <ExtractedObjects '=
qemu-x86_64-linux-user': [<File: target-info-def.c (not built)>]>, 'xtensa-=
linux-user': <ExtractedObjects 'qemu-xtensa-linux-user': [<File: target-inf=
o-def.c (not built)>]>, 'xtensaeb-linux-user': <ExtractedObjects 'qemu-xten=
saeb-linux-user': [<File: target-info-def.c (not built)>]>, 'aarch64-softmm=
u': <ExtractedObjects 'qemu-aarch64-softmmu': [<File: target-info-def.c (no=
t built)>]>, 'alpha-softmmu': <ExtractedObjects 'qemu-alpha-softmmu': [<Fil=
e: target-info-def.c (not built)>]>, 'arm-softmmu': <ExtractedObjects 'qemu=
-arm-softmmu': [<File: target-info-def.c (not built)>]>, 'avr-softmmu': <Ex=
tractedObjects 'qemu-avr-softmmu': [<File: target-info-def.c (not built)>]>=
, 'hexagon-softmmu': <ExtractedObjects 'qemu-hexagon-softmmu': [<File: targ=
et-info-def.c (not built)>]>, 'hppa-softmmu': <ExtractedObjects 'qemu-hppa-=
softmmu': [<File: target-info-def.c (not built)>]>, 'i386-softmmu': <Extrac=
tedObjects 'qemu-i386-softmmu': [<File: target-info-def.c (not built)>]>, '=
loongarch64-softmmu': <ExtractedObjects 'qemu-loongarch64-softmmu': [<File:=
 target-info-def.c (not built)>]>, 'm68k-softmmu': <ExtractedObjects 'qemu-=
m68k-softmmu': [<File: target-info-def.c (not built)>]>, 'microblaze-softmm=
u': <ExtractedObjects 'qemu-microblaze-softmmu': [<File: target-info-def.c =
(not built)>]>, 'mips-softmmu': <ExtractedObjects 'qemu-mips-softmmu': [<Fi=
le: target-info-def.c (not built)>]>, 'mips64-softmmu': <ExtractedObjects '=
qemu-mips64-softmmu': [<File: target-info-def.c (not built)>]>, 'mips64el-s=
oftmmu': <ExtractedObjects 'qemu-mips64el-softmmu': [<File: target-info-def=
.c (not built)>]>, 'mipsel-softmmu': <ExtractedObjects 'qemu-mipsel-softmmu=
': [<File: target-info-def.c (not built)>]>, 'or1k-softmmu': <ExtractedObje=
cts 'qemu-or1k-softmmu': [<File: target-info-def.c (not built)>]>, 'ppc-sof=
tmmu': <ExtractedObjects 'qemu-ppc-softmmu': [<File: target-info-def.c (not=
 built)>]>, 'ppc64-softmmu': <ExtractedObjects 'qemu-ppc64-softmmu': [<File=
: target-info-def.c (not built)>]>, 'riscv32-softmmu': <ExtractedObjects 'q=
emu-riscv32-softmmu': [<File: target-info-def.c (not built)>]>, 'riscv64-so=
ftmmu': <ExtractedObjects 'qemu-riscv64-softmmu': [<File: target-info-def.c=
 (not built)>]>, 'rx-softmmu': <ExtractedObjects 'qemu-rx-softmmu': [<File:=
 target-info-def.c (not built)>]>, 's390x-softmmu': <ExtractedObjects 'qemu=
-s390x-softmmu': [<File: target-info-def.c (not built)>]>, 'sh4-softmmu': <=
ExtractedObjects 'qemu-sh4-softmmu': [<File: target-info-def.c (not built)>=
]>, 'sh4eb-softmmu': <ExtractedObjects 'qemu-sh4eb-softmmu': [<File: target=
-info-def.c (not built)>]>, 'sparc-softmmu': <ExtractedObjects 'qemu-sparc-=
softmmu': [<File: target-info-def.c (not built)>]>, 'sparc64-softmmu': <Ext=
ractedObjects 'qemu-sparc64-softmmu': [<File: target-info-def.c (not built)=
>]>, 'tricore-softmmu': <ExtractedObjects 'qemu-tricore-softmmu': [<File: t=
arget-info-def.c (not built)>]>, 'x86_64-softmmu': <ExtractedObjects 'qemu-=
x86_64-softmmu': [<File: target-info-def.c (not built)>]>, 'xtensa-softmmu'=
: <ExtractedObjects 'qemu-xtensa-softmmu': [<File: target-info-def.c (not b=
uilt)>]>, 'xtensaeb-softmmu': <ExtractedObjects 'qemu-xtensaeb-softmmu': [<=
File: target-info-def.c (not built)>]>}> of type DictHolder.

I have meson 1.8.5.


