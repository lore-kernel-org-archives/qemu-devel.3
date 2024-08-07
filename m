Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54110C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbb7B-000565-LP; Wed, 07 Aug 2024 03:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sbb78-0004vk-UR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:29:43 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sbb76-0008On-Ks
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:29:42 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so21388831fa.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723015777; x=1723620577; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lFoHXjri5UUfmp4JVeCMLpKxnEp23sWozOlDq7FxaVo=;
 b=OrJJQUm2WBwGQMj/FvHuhGQsAex2SWqMGg3NswND/7a0SM+1+/RQ2jrneco82uj+Jp
 aLqMJRBIj2pBOZnG2jYSbW9nE4umh1m8r0uD5OjksBiNTHO3kW3gM7j38MVvLMxN8Klb
 mCLi0AV+iv//riQ8NQNOt+Fj+8NZ0lWL8IYyuZZL/hGCZ4K292GzfCUlA+rblkvGjHhU
 YRlLfdrLxAwq5pi3GbC1SoccrnM8fbnwbUlRJjYRQR990obsNyLk9KbYoD3SOnhfGV7h
 LjhAPPPyX10Whu1Y9eo4UpClWTMc6WMMB3jjwfClhrdAym37yjHCK/qNbGNZm/W1cCFp
 OQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723015777; x=1723620577;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lFoHXjri5UUfmp4JVeCMLpKxnEp23sWozOlDq7FxaVo=;
 b=q+cbxJNozs6Nwch1z74GeTMSsAzBkW9OAErhZtckoUzqYpiskscXpHWCav3V79k5JO
 HuC0Xju++Hina533gUE76GGpdIKc+otf+iERYYUSx/EdviP9zytTxWklKcBoES2HrAPF
 doZRqLh4R4+ACevx9Fnx8LOQ6FNWD0+Mf7ZKTbrWjNJMnbwLjibCU1NrfiftcpMvQ6Jd
 Y88wXFunHXptyH1I4A57yhkoJ9uON8YEjrBp2gi0l2S3rDouBGpX4r9dXxNKm53WYA8Q
 FzUyRUDi/NdFgIA/6aHur7O97LSui/rmW8n59mgBLNXoHpkSgdp7d3r23Ez1A/nHkC87
 G7xg==
X-Gm-Message-State: AOJu0YyA8HKWSt2Tq4452dGSlArlwZx/wqzPYe2+WNf8qX89sj7HeO3u
 RXobHg45slhURw7B5vqytmenPo4YHV0y0OkscJxynwRjd8Nb77vftEvp0PiuNVKN0D4TjhArqiw
 t/qhix0bHa6QzqbuRsse8evlZAY9kHRkppY/J67TsYD4rkny4
X-Google-Smtp-Source: AGHT+IEqYKO96JOAu84cTJCzyWnYBZb3jARnxE3t+kdIcs1R5bKGHNHV/jMt9jJ0NBk5V2EL75+IgzdAoTF5uo6c9L4=
X-Received: by 2002:a05:651c:cc:b0:2f0:20cd:35fc with SMTP id
 38308e7fff4ca-2f15aa86feemr112470391fa.7.1723015776421; Wed, 07 Aug 2024
 00:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240722175004.23666-1-jason.chien@sifive.com>
In-Reply-To: <20240722175004.23666-1-jason.chien@sifive.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Wed, 7 Aug 2024 15:29:24 +0800
Message-ID: <CADr__8quCHZMsN3CK_mY8x8xBkmNK=8POwEK0eV0swKdwx8b1A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add a property to set vl to ceil(AVL/2)
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004be33a061f12df57"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=jason.chien@sifive.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000004be33a061f12df57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

Jason Chien <jason.chien@sifive.com> =E6=96=BC 2024=E5=B9=B47=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:50=E5=AF=AB=E9=81=93=EF=BC=9A

> RVV spec allows implementations to set vl with values within
> [ceil(AVL/2),VLMAX] when VLMAX < AVL < 2*VLMAX. This commit adds a
> property "rvv_vl_half_avl" to enable setting vl =3D ceil(AVL/2). This
> behavior helps identify compiler issues and bugs.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---
>  target/riscv/cpu.c           | 1 +
>  target/riscv/cpu_cfg.h       | 1 +
>  target/riscv/vector_helper.c | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..8f21171ffa 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2687,6 +2687,7 @@ static Property riscv_cpu_properties[] =3D {
>
>      DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false=
),
>      DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false=
),
> +    DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl,
> false),
>
>      /*
>       * write_misa() is marked as experimental for now so mark
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8b272fb826..96fe26d4ea 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -127,6 +127,7 @@ struct RISCVCPUConfig {
>      bool ext_smepmp;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
> +    bool rvv_vl_half_avl;
>
>      uint32_t mvendorid;
>      uint64_t marchid;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 1b4d5a8e37..825312552b 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -75,6 +75,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env,
> target_ulong s1,
>      vlmax =3D vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
>      if (s1 <=3D vlmax) {
>          vl =3D s1;
> +    } else if (s1 < 2 * vlmax && cpu->cfg.rvv_vl_half_avl) {
> +        vl =3D (s1 + 1) >> 1;
>      } else {
>          vl =3D vlmax;
>      }
> --
> 2.43.2
>
>

--0000000000004be33a061f12df57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.c=
om">jason.chien@sifive.com</a>&gt; =E6=96=BC 2024=E5=B9=B47=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:50=E5=AF=AB=E9=81=93=EF=BC=9A=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">RVV spec allows=
 implementations to set vl with values within<br>
[ceil(AVL/2),VLMAX] when VLMAX &lt; AVL &lt; 2*VLMAX. This commit adds a<br=
>
property &quot;rvv_vl_half_avl&quot; to enable setting vl =3D ceil(AVL/2). =
This<br>
behavior helps identify compiler issues and bugs.<br>
<br>
Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com" ta=
rget=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A0target/riscv/vector_helper.c | 2 ++<br>
=C2=A03 files changed, 4 insertions(+)<br>
<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index a90808a3ba..8f21171ffa 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -2687,6 +2687,7 @@ static Property riscv_cpu_properties[] =3D {<br>
<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;rvv_ta_all_1s&quot;, RISCVCPU, c=
fg.rvv_ta_all_1s, false),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;rvv_ma_all_1s&quot;, RISCVCPU, c=
fg.rvv_ma_all_1s, false),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;rvv_vl_half_avl&quot;, RISCVCPU, cfg.=
rvv_vl_half_avl, false),<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * write_misa() is marked as experimental for now so ma=
rk<br>
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h<br>
index 8b272fb826..96fe26d4ea 100644<br>
--- a/target/riscv/cpu_cfg.h<br>
+++ b/target/riscv/cpu_cfg.h<br>
@@ -127,6 +127,7 @@ struct RISCVCPUConfig {<br>
=C2=A0 =C2=A0 =C2=A0bool ext_smepmp;<br>
=C2=A0 =C2=A0 =C2=A0bool rvv_ta_all_1s;<br>
=C2=A0 =C2=A0 =C2=A0bool rvv_ma_all_1s;<br>
+=C2=A0 =C2=A0 bool rvv_vl_half_avl;<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint32_t mvendorid;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t marchid;<br>
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c<br=
>
index 1b4d5a8e37..825312552b 100644<br>
--- a/target/riscv/vector_helper.c<br>
+++ b/target/riscv/vector_helper.c<br>
@@ -75,6 +75,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ul=
ong s1,<br>
=C2=A0 =C2=A0 =C2=A0vlmax =3D vext_get_vlmax(cpu-&gt;cfg.vlenb, vsew, lmul)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (s1 &lt;=3D vlmax) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vl =3D s1;<br>
+=C2=A0 =C2=A0 } else if (s1 &lt; 2 * vlmax &amp;&amp; cpu-&gt;cfg.rvv_vl_h=
alf_avl) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vl =3D (s1 + 1) &gt;&gt; 1;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vl =3D vlmax;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div>

--0000000000004be33a061f12df57--

