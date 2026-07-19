Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64E1C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 21:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlYy3-0000of-55; Sun, 19 Jul 2026 17:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wlYxy-0000nd-TG
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:22:31 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wlYxx-0007Il-8U
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:22:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ccdb73f0e1so53916245ad.3
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 14:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784496146; cv=none;
 d=google.com; s=arc-20260327;
 b=jSbUGNHKjQAZR94o2YNh7dZ+rT+5L01HIWTMZlbYIjNpFxqEbpZEcYlDruF9DN2uNy
 6B2EK1Hkby01+2kGfpGvsn2DBt7QJIjHSfNJ9yWaS++p83yH+ELcJ6gGFdN+dt6tHknO
 eaLf2pqsUMJ5z9a8x5XWSWQiODlQtobuQqJO7ZgXgFrlD9zn3ocA57pht/YWuP+e5rBV
 IZjgSrcwJXuFXYaWl8X+L2erdyiisSnXGn7a57/qQNT9yYrsclKxpl9DSMPY28Sj1xq8
 hK8b36avOYkgmQJ0Nt+bEbTSMV6dA+FbVT0IHlpq8cfba50k3hnuuVbv1P1PWxMzq3GS
 zm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CuU8qJPy95WIyMZfrstdxP8ocKoCxNdcr2uMXoVVX1M=;
 fh=JuLQCNmMiksbImbnJAcswwnmIBEA9QO04KFWdo98ljw=;
 b=S2ToVNiYOceyy93zB0vGe32i2+RFwHsLgFCueik/oypUsSeEYPjfYChY/OFLTkV4KO
 dnyMJw9gjA4Hhw7zYShthtXS6PiBTqNB5hVKjJ7dBXZSHqCAq/dQIEt0NvHFuI5C6e1p
 tfVu9ClxYXeEyR9Ddwf74mrSlw4AL8hidepMNUSsj2QoOc1hgKvBhgQNWsh6OknDiUNu
 lIVaRgB+3A4iVtPcY1e6mWTBllRVdNsy4BxlyWSgPaDoAX1Mjf5Ylx6+E9mQnB/vv+q/
 WsiHQYHNuuysoRZUq9yZJBqH0revUPUF9VsM7qBZdfO67LxdHx5sPE7ZbjREAq0rjBTL
 j9+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784496146; x=1785100946; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CuU8qJPy95WIyMZfrstdxP8ocKoCxNdcr2uMXoVVX1M=;
 b=NxRPnSd6lQOVaHrHpl/S9OBUoD3fogTfo2Yd/DVo/eFkY6lnyKTvaf8dPJGxk6+CqA
 f1murvfbuiwAguNB0Z3AV8jEA9lq/6dVWneLaw2T4PdBL6WWwp/U7QFVGiSn4sBe6Gzq
 PyB2/A/97uLbugUa5JRf+GY5hZKlLuhWcBR5p9b5CYenFEpvmxU7KV3Mk3ZXELcWXXyo
 kj9AYPVNUgEK+xne+TGcVo10itVdaQWQ0MGJ+HWgXYbz4dpA3TW2YFiKL8Or6q/wwfgo
 96f6O4szbPlFI/RY/Hp8F47pwcB1LScYKAOnDFNmVQBdlwzacJQDSWalWFI8tg/ma6n8
 Kt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784496146; x=1785100946;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CuU8qJPy95WIyMZfrstdxP8ocKoCxNdcr2uMXoVVX1M=;
 b=bKZ10kreUPRBVpZNp4nlUrqa4sMaBWiSJwYj0ktSCm72Eo/jzMhNU8Sq5M8Qgu0Awl
 wnxCcNyK6PNP4nEjS/TTYDsETrQwoBS6tYIyjWBpfo2O+E7eYfNMDHcFgeLG6jjVJK1A
 28jpUbJEs0aXirkifORiww2Z7xS8GmVMRB8b5OZnnaZWzdz5PvYMfl37Mlo45GIX26DG
 V2BfWZbURI76KLYZF/V2RwEk/xOw0hx5GLkl+t5LuaBqm0ajWfY3thaYza2jHrmU4eq5
 iYebM4e1VpsqbQeHOx4267F1q2esWEDhvry/mC5iDNeFpOy/u+TcWyAvyydnQFtrLyHn
 hPIw==
X-Gm-Message-State: AOJu0YyLhUus7e/8yweA3Z+nZ2EU3sF0CcjTWoon/zO48bamIMy5obK4
 P8qCUu+Y43ydUN1zvBabJZBaj9eGaUo1QqGK5Ngzu9bSCvu4PKIUduRHzbonxx9PLPCY2gcrsm4
 ENnxhIKee/ked8Mb65Yp0rqPJUMsk7Gs=
X-Gm-Gg: AfdE7clkWexRp0jXAoiOLqs8FYJ0cJ4zkaThtcXkpyWe+oRXLMQC+YU6/KfI7XoR7VY
 uB/quMmyRBj1iotsd++lucNsoSApplMri5nBZg7+pN6YLCzzxwMDHCuhuShnORQMMQm9hMlN3q1
 HKvkBdB2UEBg0SJ3S7p3bslmT0etpsNt72jRestu3i6SpKxth/NIyZiN8Vh/YG5JyYKazDrgBfC
 s5qwpqxBNBEZDvYn1HUNarvQ2xxRVTuxJ0ty0yQAGMy0rvWUFlWjUXz67jDmUbTr2OlNApXZ6oX
 WqSEH3NAb8IFNjFXAw==
X-Received: by 2002:a17:903:440c:b0:2ca:1594:451e with SMTP id
 d9443c01a7336-2cf3496b583mr132868965ad.31.1784496146450; Sun, 19 Jul 2026
 14:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260715185701.1287176-2-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sun, 19 Jul 2026 15:22:15 -0600
X-Gm-Features: AUfX_mwSNz86-DlifFQGwvVzpZiUYXFjL_GLk9dADDnUwINYPh1At1EUgkxQbPQ
Message-ID: <CAATN3NrUvUQGhiynN2j33T-YHCAr8ZWuUKsRbm6p2u=-pMNMcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] target/hexagon: initialize deferred sreg-write
 temps to current value
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="000000000000e98d7b0656fd6278"
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000e98d7b0656fd6278
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 12:57=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> Unconditionally allocate and initialize the temp to the sreg's current
> value for every logged sreg write, rather than only allocating
> when need_commit is set or the register is SSR.
>
> Without this, reading a deferred sreg write within the same packet
> before it is committed can observe an uninitialized temp instead
> of the register's pre-packet value.
>

Do you have an example where this happens?  I searched the code and only
found references to t_sreg_new_value guarded by ctx->need_commit except
gen_sreg_writes which should have an early exit if ctx->need_commit is set
(similar to gen_reg_writes).

The special handling of SSR could be cleaned up.  Consider making writes to
SSR set ctx->need_commit.

Also, consider creating a function similar to get_result_gpr to centralize
all the checking (e.g., in gen_log_sreg_write).


>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 77235916f4b..28a171bf623 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -615,9 +615,10 @@ static void gen_start_packet(DisasContext *ctx)
>      }
>      for (i =3D 0; i < ctx->sreg_log_idx; i++) {
>          int reg_num =3D ctx->sreg_log[i];
> -        if (reg_num < HEX_SREG_GLB_START &&
> -            (ctx->need_commit || reg_num =3D=3D HEX_SREG_SSR)) {
> +        if (reg_num < HEX_SREG_GLB_START) {
>              ctx->t_sreg_new_value[reg_num] =3D tcg_temp_new();
> +            tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num],
> +                          hex_t_sreg[reg_num]);
>          }
>      }
>      for (i =3D 0; i < NUM_GREGS; i++) {
> --
> 2.34.1
>
>

--000000000000e98d7b0656fd6278
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 15,=
 2026 at 12:57=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Unconditionally allocate and initia=
lize the temp to the sreg&#39;s current<br>
value for every logged sreg write, rather than only allocating<br>
when need_commit is set or the register is SSR.<br>
<br>
Without this, reading a deferred sreg write within the same packet<br>
before it is committed can observe an uninitialized temp instead<br>
of the register&#39;s pre-packet value.<br></blockquote><div><br></div><div=
>Do you have an example where this happens?=C2=A0 I searched the code and o=
nly found references to t_sreg_new_value guarded by ctx-&gt;need_commit exc=
ept gen_sreg_writes which should have an early exit if ctx-&gt;need_commit =
is set (similar to gen_reg_writes).</div><div><br></div><div>The special ha=
ndling of SSR could be cleaned up.=C2=A0 Consider making writes to SSR set =
ctx-&gt;need_commit.</div><div><br></div><div>Also, consider creating a fun=
ction similar to get_result_gpr to centralize all the checking (e.g., in ge=
n_log_sreg_write).</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qu=
alcomm.com" target=3D"_blank">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/translate.c | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br>
index 77235916f4b..28a171bf623 100644<br>
--- a/target/hexagon/translate.c<br>
+++ b/target/hexagon/translate.c<br>
@@ -615,9 +615,10 @@ static void gen_start_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ctx-&gt;sreg_log_idx; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int reg_num =3D ctx-&gt;sreg_log[i];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_num &lt; HEX_SREG_GLB_START &amp;&amp;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ctx-&gt;need_commit || reg_num =
=3D=3D HEX_SREG_SSR)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_num &lt; HEX_SREG_GLB_START) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;t_sreg_new_value[re=
g_num] =3D tcg_temp_new();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(ctx-&gt;t_sreg_ne=
w_value[reg_num],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 hex_t_sreg[reg_num]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; NUM_GREGS; i++) {<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000e98d7b0656fd6278--

