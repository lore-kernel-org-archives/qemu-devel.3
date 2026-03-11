Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0751FD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09FH-0007Sd-DC; Tue, 10 Mar 2026 22:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09FA-0007S8-TF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:24:17 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09F9-0003OV-7N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:24:16 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-661be3380adso8162718a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773195852; cv=none;
 d=google.com; s=arc-20240605;
 b=gjdCFB8puFotp4FWluAvXXUwZH9F2qys0/3WSxJVzTaC1IA94dklhg1hwX0+7o4R/l
 5XUPm+c/MnxvS4/eTQKNrVwMxCLMIWhG9mVcmGxnH31tiyNkTrl9A8WH0ObKDEAXqVcw
 6HHu4zlojuj++TlZOXWJjbYUph13P4RBSgIPq+NghK3EUJwfXZJWa+t7KuZY6KvUmtGQ
 hfz08WqOniIltZGuXUUyGT749mquGGpPDObt1Wnh+za3srV+zk6pqShz3ACLuCDXWwl/
 k4dKu7aEDiR0HTOBSRczQfs/gudzTkkPL8mu6UcDXQEGIXc6ILOAZigwLZA7XkLJCcoG
 OyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5y8kNFjXygzc5Q7WyG2I2ug27mRKKvGhBbM19y1MidQ=;
 fh=ybYiV9RTOFSKEH2bLIBq3Mn1/PZ7+JiMV8qNBkyQbaY=;
 b=BJ/0K3bqcGgSy1eTYNCxWD7Awy8AwVq97ctrOXls8vGj2qpg6MG9V8o254LPRZdQxP
 2cUBZwMk1FNIfr8J0PE3t24eQwfzRsBrGtJhav25Gq5iT5MIfFbLcFz7/cwuafR5Rjgo
 Ey7iFEHVLKa8u02mQq3USj1fvOwAsxZ/yQq82HmqfFIZ0KKaE/xmqq7QcnlitVDaFtEu
 C9jmvmmjTwKrQQZNCXZqA5bIGMz4j23KS37iR7Xu/lFusxeByutw9B3pLKmzcCW2tA6Q
 I6EYV412efRkdg6lbGFELK34fpM6GNKSLxdH9aKDfA3lFCziE66YS7QzxaH0USRXg6YB
 4F7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773195852; x=1773800652; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5y8kNFjXygzc5Q7WyG2I2ug27mRKKvGhBbM19y1MidQ=;
 b=I9Mz2uLgOADm7c0ANGNvsyVNzvanHfz6YXoRVoGB7R4VL0XhRAelzApvNCPrGjPxa6
 Z+lCOfc45Y+Xkbl1camUfA4lGtP6PFoYnnUbVb6XHpK7UZdAcSkHls1CkNkvO4Lw+RIs
 QspgTPW+TDZLTFAPY6Qt7jNKoTbsFztGtWKgs45xfgsm9AFe0sAKLMdVFiwMhZHAfwON
 V6neHg2VQcKwHdkpnhxGp6s12AaNqht+APRT11zTzllTq+kIf5AsnzAn9w+MnCuZY2H5
 1/PFLTHz2AoJcQLOlxtTFVx2QKtzicarkg1Ydt24Y1EDw7GbjGre8/dOqWG7qjC+E4dL
 8AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773195852; x=1773800652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y8kNFjXygzc5Q7WyG2I2ug27mRKKvGhBbM19y1MidQ=;
 b=Seft9ySVMlz/cocYyvAkNOowlWgTTTBXJE2Yy+h+r0LrRIJz35clp1pXI3gKjhrpXL
 h0yOWwhqdMirZ2yjwS5ahLsDo3iuA3/xXTYeG1tuFslSKdCFHxRoB1FYQAy8tLw6hNf3
 lIwR7YRXEAugTJ4Kk37AT8Gtbx8Q3fF7PlDLMVNytZZUv9NNde1bhkMK96Xzd15OCOVc
 v1+kLxPqjUWl3aVMdSoBE5dqy9UOsgjXW0EHfaBSjVnOu7UNj/U6ekHBzZgzvTgdx5xK
 Jssh3V9CHzv227nODy8/9Yfgm25DKI5LQb794F7yPJYogdQeIysiCtkYg4RyHhdDsdz4
 sZog==
X-Gm-Message-State: AOJu0YyFMBUuB97QTfAJDvuJkcGFDeOQjJEOeuoGxpDxo3ANrO9f8udH
 DM024ORK3kqG4+frwZ70UJK183gm4BFczOnIoO02Bxz/KqjU7xD4NvhQi1LVs3ajPCYuGwLTzzO
 KgwPBsXp5cAM9wdsF9g5EQJWklP6AwppZ6R9SM0BGVVnWE81gBj8D5KitXw==
X-Gm-Gg: ATEYQzyN0W8b7EplJTo/7cSdZurY+5o113evmEr77t1W3acJDMJ2Zfk2Iq6Td38LNJx
 YBROruTHLiDAs+QCfPxpZDg9TxOkNXLXFrzWaZQ9kvjm466AJwl2wxIPx3I2pLgWC7wzCBKUL3r
 b/geNMMBhAheHw2xylnWsCCkFlS4OfbYpDiKBjLbOyg/KFDX0kpa41fnqSQ8DxTscqj70Q81L7h
 mD4W6MhaEYBvwfiHGOg52P9uu4Je0RxzTTkt0eKwmr5Kyj6jVmKzuKj0R3wSFYe9Jrj5BoEHp8U
 LvG06E5jpQ==
X-Received: by 2002:a05:6402:f11:b0:662:ac65:19e7 with SMTP id
 4fb4d7f45d1cf-663194c1bb9mr243156a12.10.1773195851441; Tue, 10 Mar 2026
 19:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260204023055.589588-1-frank.chang@sifive.com>
In-Reply-To: <20260204023055.589588-1-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 11 Mar 2026 10:24:00 +0800
X-Gm-Features: AaiRm51USm6qz64duHiL3o7Qirh-7-aRSLOgcixSiDWLrDn88CIEsdjuNTHFjOY
Message-ID: <CAE_xrPjMreR4ipnnqTLgRUFFsjVRp8oEdD0ZA0OHejjn98fqUA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Mask xepc[0] only when Zc* extension is
 enabled
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d7b75a064cb654d5"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000d7b75a064cb654d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

Thanks,
Frank Chang

On Wed, Feb 4, 2026 at 10:31=E2=80=AFAM <frank.chang@sifive.com> wrote:

> From: Frank Chang <frank.chang@sifive.com>
>
> IALIGN is 16 when the CPU supports the Zc* extension. We should only
> mask xepc[0] when the Zc* extension is enabled.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/internals.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 35b923c4bf5..d2a77c41047 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -160,9 +160,15 @@ static inline float16 check_nanbox_bf16(CPURISCVStat=
e
> *env, uint64_t f)
>
>  static inline target_ulong get_xepc_mask(CPURISCVState *env)
>  {
> -    /* When IALIGN=3D32, both low bits must be zero.
> -     * When IALIGN=3D16 (has C extension), only bit 0 must be zero. */
> -    if (riscv_has_ext(env, RVC)) {
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    /*
> +     * When IALIGN=3D32, both low bits must be zero.
> +     * When IALIGN=3D16 (has C or Zc* extensions), only bit 0 must be ze=
ro.
> +     */
> +    if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca ||
> +        cpu->cfg.ext_zcb || cpu->cfg.ext_zcd || cpu->cfg.ext_zce ||
> +        cpu->cfg.ext_zcf || cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) {
>          return ~(target_ulong)1;
>      } else {
>          return ~(target_ulong)3;
> --
> 2.43.0
>
>

--000000000000d7b75a064cb654d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gentle=C2=A0<span class=3D"gmail-il"><span class=3D"gmail-=
il">ping</span></span>.<div><br></div><div>Thanks,</div><div>Frank Chang</d=
iv></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Feb 4, 2026 at 10:31=E2=80=AFAM &lt;<a hre=
f=3D"mailto:frank.chang@sifive.com">frank.chang@sifive.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Frank Chang=
 &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chan=
g@sifive.com</a>&gt;<br>
<br>
IALIGN is 16 when the CPU supports the Zc* extension. We should only<br>
mask xepc[0] when the Zc* extension is enabled.<br>
<br>
Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" ta=
rget=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/internals.h | 12 +++++++++---<br>
=C2=A01 file changed, 9 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/target/riscv/internals.h b/target/riscv/internals.h<br>
index 35b923c4bf5..d2a77c41047 100644<br>
--- a/target/riscv/internals.h<br>
+++ b/target/riscv/internals.h<br>
@@ -160,9 +160,15 @@ static inline float16 check_nanbox_bf16(CPURISCVState =
*env, uint64_t f)<br>
<br>
=C2=A0static inline target_ulong get_xepc_mask(CPURISCVState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 /* When IALIGN=3D32, both low bits must be zero.<br>
-=C2=A0 =C2=A0 =C2=A0* When IALIGN=3D16 (has C extension), only bit 0 must =
be zero. */<br>
-=C2=A0 =C2=A0 if (riscv_has_ext(env, RVC)) {<br>
+=C2=A0 =C2=A0 RISCVCPU *cpu =3D env_archcpu(env);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* When IALIGN=3D32, both low bits must be zero.<br>
+=C2=A0 =C2=A0 =C2=A0* When IALIGN=3D16 (has C or Zc* extensions), only bit=
 0 must be zero.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (riscv_has_ext(env, RVC) || cpu-&gt;cfg.ext_zca ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zcb || cpu-&gt;cfg.ext_zcd || =
cpu-&gt;cfg.ext_zce ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zcf || cpu-&gt;cfg.ext_zcmp ||=
 cpu-&gt;cfg.ext_zcmt) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ~(target_ulong)1;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ~(target_ulong)3;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000d7b75a064cb654d5--

