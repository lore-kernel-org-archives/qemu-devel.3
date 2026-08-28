Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77F3C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpOW-0006F6-RI; Fri, 28 Aug 2026 01:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzpOU-0006Dl-8q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 01:44:50 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzpOQ-0005N9-Gj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 01:44:50 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so380062766b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895884; cv=none;
 d=google.com; s=arc-20260327;
 b=nWgGdFvbRczorz5LWuPy3RM13eZzdm/2vEK/NV1CslFbwb0wyRpXqe1BmlqZxcsSpT
 E60+ZDKZDijJXqZMGPpdTu7/2ovQiLrTcmwi9KGn1HF5TV9JvEZ2i8bNtxbiLwE+w1zp
 TbwZSauSmVCqaQO8UlX1cofAqNtrY129G4yrfRw2pVLQveqZfQClLnRSypjtxj6kQIoL
 TLNRlWD8KEYYZ1PTizUrcYMAa74sO+bEHiHL3d9phE7X/whk8q+Mg3FAZ1MBgOPWhTvQ
 1J2kGumbXFHmjF32leBT1GPHFTak7KyfOY5Qd7nZyuKnTbcverUAwDqeVv4lvOyLsEQt
 pGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xclwLkLVRxbn4Oeg5EdOyoBN23HEZDWzCEZ1snetFkg=;
 fh=hsnWwW0raEkFQIEDL2CMrjx70Q6Cid/oPP09vuInTiw=;
 b=e8yDapZFkuNDw/giA46+HDQDKKqonRuuQeyOyZjX2pv1QIr3Y9eQENJIk0vdCwBrdP
 NSgBmhopPwxqkPVUG8YTTp3CbqmNZCaiy3ft17UbQTwP7dMxPgx67OAm/ntLbzGd/TXi
 oR8hktN0KC1rmTccwxeqCmMClH0VUmgmJqnk7lj+4LlQXtM0ryUxX/NyBnqhlH/ImevE
 8FzfV0PxUtwCQtfe+dfxv4AMD/pFni2EAlv73fUeTPsGQt/rGfv9S6SMpJuhMFVBzqFk
 +j0b7JUSvrUlO5kkSEoWypduHIy0YaGHuZL1GtTuhNRN660EO0mFxEptjvCO1dV88Co1
 lHxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787895884; x=1788500684; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xclwLkLVRxbn4Oeg5EdOyoBN23HEZDWzCEZ1snetFkg=;
 b=QJC3W0zxwCm/n43OezcqqQKQ7LSSwC0hDd42WxtNqzbBnxHA8PFXGBkaIe57QKbdNs
 Hptd5oHoNkuI4TPd1y2zF1hWLn74yeNsajotnubGAdMtlze5B4mdoXCSIZkUn32SY+K9
 Cg6s/Fa56yuUYOtH9EDj36cDgua7jEQCJKRghImaXh6mrOzEvbEP+ofIfLNPg5w8WEYC
 ANB3kvPS1ptgNieQVGOlU5oWIUec+KN4UUX8MCI2SQ2fSYhBN4jY8lIqDx8EuQBVQRhr
 PCVl4yRGMQmbiLGO8FXMDWB5wKYz9COw8hl5Qq83hHcUjCVL8J+SwizxXYf52z+LP2uH
 mX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787895884; x=1788500684;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xclwLkLVRxbn4Oeg5EdOyoBN23HEZDWzCEZ1snetFkg=;
 b=j7viKHJ09uu3FE+1sRy86Y0M7VCYE9o0N53qkDvOrvM/0Wd+YQ7KHuJuLP+9FnfCKd
 YAeqYwklkb0iM/7/piHnYZ503V9hDX52RiJmKTISwLHLVX0C0+wtjxBzHaddwqB9pFq0
 KKb05RuOlZO4XtIySw8mIKhTIS4fjvYPgnp21VroPsjoQ7iahIlFL45FW+6bk/ShhhB9
 k4yq1pZADYrcyqrhFj0sd14vdI4BYAw5odDZOxuN07Iz1Y4s2pbrGoQlmQ/bePpoxzf8
 zF5YfMo8qIhfQVElB57rytpMM/istFIVpZHBePs+d9T/kqsU50qEE86H284gKRflsGCD
 p8ig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rod7Eqddc08I8BwkmbjdFJcNqxCVCs4YVwEcIOhooNvBKxiCBQKzeGu0/kZGI7CWFjzrO9L43kNIpHx@nongnu.org
X-Gm-Message-State: AFuF++kg0gSVV2fC5gv2wznD4nvc3PIuTvyF8K6ByEEzjkXFAJHMKiLs
 fmw2DA0zpucbr/b4AHHSGqiGez4bcjYPYkRUhAu/NXYIakv/1gusima0DpQZWFkwfE0GsH2zwQt
 jfBQu3EisA6EzmRVJRPOwNuKjfpJ13zg=
X-Gm-Gg: AR+sD12ujX7QrOkLfUIa2Aj+gZtEvAKdoW/JoKbEtGPrrkzcskXVMbykC5HFe/uNlIY
 slz17PhLTlT/TpNxO1rwiOv2Zkz8hpndLpLMogX7yZYbtYTupmuqaxQ+hroTF/RqJ9KiCDEVgpQ
 6XrPDrZKuQiFNwJn6I8INuouUL76ks75NNRGBM8XE+55zW4zD0wttqX4dCapKhZ4rblu1qqQt59
 ZHnSGbk2N98ObiXVlOOdFSgY+fGpy5jVZjKt7Nj2vvsz+F3MvyB3X+z8Q8yzgh1mQEVRG2bvXKj
 eQi4DTscUWRg4BJTElN9b1dkDm7G4h6Xpa6Nb1qwUrel
X-Received: by 2002:a17:907:9b8d:b0:c25:5081:a9f7 with SMTP id
 a640c23a62f3a-c255081ace9mr352089166b.14.1787895884041; Thu, 27 Aug 2026
 22:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <CABgObfa4QiBKuj7o06RL+egm_QOX03hpP9PAHoeKYOr9wwGvFA@mail.gmail.com>
In-Reply-To: <CABgObfa4QiBKuj7o06RL+egm_QOX03hpP9PAHoeKYOr9wwGvFA@mail.gmail.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 28 Aug 2026 13:44:30 +0800
X-Gm-Features: AcwNN1X1GOaj0QRVxiPqghu_RCWMtblSNbD_bINUi2HuZL8Vyf_lbN_vGb5HcNQ
Message-ID: <CAE2XoE_KZYdo40HLdtxCWSa4q0nh1ZBiukCB3PdjeMLD6vfAYQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>, 
 Alistair Francis <alistair.francis@wdc.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-s390x@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Aurelien Jarno <aurelien@aurel32.net>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: multipart/alternative; boundary="0000000000001053ea065a14f372"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000001053ea065a14f372
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 1:59=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Wed, Aug 26, 2026 at 2:33=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com>
wrote:
> > With the clean break with the past, we also have the
> > ability to tackle various long standing design mistakes
> > present in qemu-system-$TARGET instead of carrying them
> > over into the new binary.



Paolo also said keeping qemu-system-riscv64 as a real binary, not a
symlink, is a valid objection.

v2 already takes that part:

  https://patchew.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/

What v2 changed relative to v1:

- qemu-system-$TARGET is still a separately linked binary. qemu-system
  is extra, from the ARM + RISC-V union. v1 installed
  qemu-system-{arm,aarch64,riscv32,riscv64} as symlinks; that is gone.
- Bare qemu-system always requires -target. There is no unique-
  TargetInfo fallback.
- Dropped little- and big-endian TargetInfo variants from this series.
  One TargetInfo per target_name. Endian variants are later work.
- No qemu-systemw for the combined binary, so a Windows GUI twin does
  not block enabling modules later.

qemu-system -target aarch64 -M virt ...
qemu-system-riscv64 -M virt ...

The per-target binaries should keep the same QOM list and RSS as today.
The extra RAM and incomplete filtering only apply to the extra
qemu-system binary.

v2 still uses -target and TYPE_TARGET_SPECIFIC on that combined binary.
It does not drop legacy CLI, and it does not mark qemu-system
experimental. I treated those as later work, not required to stop
replacing qemu-system-$TARGET with a symlink.


The v2 still based on TYPE_TARGET_SPECIFIC  changes from Pierrick Bouvier,
it's a great changes that
get target-info-def.c to be generic, so maybe we can review the v2 version
instead.

The v2 version can be merged without affecting existing qemu-system-*. if
something wrong v2, tell me in v2 patches.


>
> I am not sure about this. Overall most (not all) of the complexity of
> command-line processing and legacy arguments is kept at bay, and
> contained within board code - and boards do not have to support it.
>
> The complexity that is left is tied to -drive, mostly due to
> differences between hot-unplug in -drive and -blockdev. And honestly
> I'd be very much opposed to dropping -drive because using -blockdev
> correctly is *extremely* hard and barely documented.
>
> If we want a clean break, we need to drop the command line completely
> and just have a QMP monitor on stdin/stdout
> (https://wiki.qemu.org/User:Paolo_Bonzini/Machine_init_sequence).
> Start small adding just accel-new and machine-new, and add QMP
> equivalents of command line objects as needed.
>
> That said, I understand that this is just an idea and not the crux of
> the disagreement.
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001053ea065a14f372
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Aug 28, 2026 at 1:59=E2=80=AFAM Paolo Bonz=
ini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; =
wrote:<br>&gt;<br>&gt; On Wed, Aug 26, 2026 at 2:33=E2=80=AFPM Daniel P. Be=
rrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com<=
/a>&gt; wrote:<br>&gt; &gt; With the clean break with the past, we also hav=
e the<br>&gt; &gt; ability to tackle various long standing design mistakes<=
br>&gt; &gt; present in qemu-system-$TARGET instead of carrying them<br>&gt=
; &gt; over into the new binary.<br><br><br><br>Paolo also said keeping qem=
u-system-riscv64 as a real binary, not a<br>symlink, is a valid objection.<=
br><br>v2 already takes that part:<br><br>=C2=A0 <a href=3D"https://patchew=
.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/">https://patchew.org=
/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/</a><br><br>What v2 chang=
ed relative to v1:<br><br>- qemu-system-$TARGET is still a separately linke=
d binary. qemu-system<br>=C2=A0 is extra, from the ARM + RISC-V union. v1 i=
nstalled<br>=C2=A0 qemu-system-{arm,aarch64,riscv32,riscv64} as symlinks; t=
hat is gone.<br>- Bare qemu-system always requires -target. There is no uni=
que-<br>=C2=A0 TargetInfo fallback.<br>- Dropped little- and big-endian Tar=
getInfo variants from this series.<br>=C2=A0 One TargetInfo per target_name=
. Endian variants are later work.<br>- No qemu-systemw for the combined bin=
ary, so a Windows GUI twin does<br>=C2=A0 not block enabling modules later.=
<br><br>qemu-system -target aarch64 -M virt ...<br>qemu-system-riscv64 -M v=
irt ...<br><br>The per-target binaries should keep the same QOM list and RS=
S as today.<br>The extra RAM and incomplete filtering only apply to the ext=
ra<br>qemu-system binary.<br><br>v2 still uses -target and TYPE_TARGET_SPEC=
IFIC on that combined binary.<br>It does not drop legacy CLI, and it does n=
ot mark qemu-system<br>experimental. I treated those as later work, not req=
uired to stop<br>replacing qemu-system-$TARGET with a symlink.<br><br><br>T=
he v2 still based on TYPE_TARGET_SPECIFIC =C2=A0changes from Pierrick Bouvi=
er, it&#39;s a great changes that<br>get target-info-def.c to be generic, s=
o maybe we can review the v2 version instead.<br><br>The v2 version can be =
merged without affecting existing qemu-system-*. if something wrong v2, tel=
l me in v2 patches.<br><br><br>&gt;<br>&gt; I am not sure about this. Overa=
ll most (not all) of the complexity of<br>&gt; command-line processing and =
legacy arguments is kept at bay, and<br>&gt; contained within board code - =
and boards do not have to support it.<br>&gt;<br>&gt; The complexity that i=
s left is tied to -drive, mostly due to<br>&gt; differences between hot-unp=
lug in -drive and -blockdev. And honestly<br>&gt; I&#39;d be very much oppo=
sed to dropping -drive because using -blockdev<br>&gt; correctly is *extrem=
ely* hard and barely documented.<br>&gt;<br>&gt; If we want a clean break, =
we need to drop the command line completely<br>&gt; and just have a QMP mon=
itor on stdin/stdout<br>&gt; (<a href=3D"https://wiki.qemu.org/User:Paolo_B=
onzini/Machine_init_sequence">https://wiki.qemu.org/User:Paolo_Bonzini/Mach=
ine_init_sequence</a>).<br>&gt; Start small adding just accel-new and machi=
ne-new, and add QMP<br>&gt; equivalents of command line objects as needed.<=
br>&gt;<br>&gt; That said, I understand that this is just an idea and not t=
he crux of<br>&gt; the disagreement.<br>&gt;<br>&gt; Paolo<br>&gt;<br><br><=
br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<=
br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yong=
gang Luo</div>

--0000000000001053ea065a14f372--

