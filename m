Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E8710FC456
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAcfk-00081i-Ic; Wed, 08 Apr 2026 19:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcfe-00081A-Ai
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:50:54 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcfc-0004U0-In
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:50:54 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so132983a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775692251; cv=none;
 d=google.com; s=arc-20240605;
 b=dG1I4Qt2iEaGeI3Uce7E9NDvosDAjtAcsGODvOHK481GC0WqThLGaOpb7XVcPObX6p
 iPh/E3IsjO52gQ2Ee/Wh1f/+UeVmmVQBB4eQvBLQXeBUPzK31FpOz2hjxvRmVGHSuzwF
 40SGN1cTgc/2swZcAMU6JTN0QMF/mf73NITxRiHZtP2Yga1xse7dB3iRLyvhYyasV7Zz
 R9yZ5PgY+x8mS3UiF93QJou9UyKQahoiRaABuBlsom/esp6r6mpWeAvtyZfrLsHoavEn
 Pd4OY0GcaUbc59LDuRcLWtUcCYgZRneqBrMhFw9yQqxBZFjR1rybiD7lhkKRBtjdlmbE
 Tv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u/WGsQ5rq0OojHisYPCTDH8LA3g49gUaI+vAkkagQhA=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=kfhA8v5nKlrGqGwmyqUj+Y/VwGUkPWENhzqGVciyWRW41ZzV/Zw0k9mXrivtbOXOVI
 xSmRhPIG/gZISzOHXYWdo7y8lBwfGVOdqJZm6Sqh3zx4sdwjs5dJQCelwFFMAjMG5UyM
 sb7yOXUsgKZX4eYhIwCHjdEcMsoOrS/CjFVv/WkNe/hnls8/jE8fIIhinhFFZRYeHOJU
 OmfPNteoX9FX0PYD7howriY/gz+AOf8oFy9bxdjv70lMS/40nB5GWuc82WNX3fUkKKRH
 4oLuEv4VCkjvVKU88FQN7+iXA19k20QWoEYbFslr3MOhOBOuSxqlVGCVtgRZlQcnLuQ5
 5k4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775692251; x=1776297051; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u/WGsQ5rq0OojHisYPCTDH8LA3g49gUaI+vAkkagQhA=;
 b=AgUl/wlUFfndFtObxd8W5K/aEgDc83BspCzhqXxDKSA8r8gT8IdOFYqBLaaaZfPKG2
 BJFxlLCbvC/0XqtMhgYGYhaEgpaPEv2HXWrU1rtB9FAnDlqUOyBOUTBbK+TlACXUwtO4
 MMqCx6rVd93R+pNFhaaM10egkXu1I00PoUYlKKSkRNwqHj3qUcqCLQprt0I1d9HyROFk
 mP/llau9XqFnrtctVIV8Vunt1SMFqo6fdYwM1oihc2ukAS9oar3uR6BLYa+A88r1J4ZM
 Y6RRVoNvGyMnkEwteQGFJlbTlgC4N0KwcEt5zNGiSnxXlnuMEKebSU+eVFd2pVZbynwC
 nERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775692251; x=1776297051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/WGsQ5rq0OojHisYPCTDH8LA3g49gUaI+vAkkagQhA=;
 b=FX83jNipRkps+Xj7vyLd0zWfcvgkbCPBkGFeDn3dTd/TYO4YcyP3/Pmk7dZBXsAhPd
 JnsHFp8mHkbn6p9Lww6lIM23R9nWeXOLSv1THB0I1al11A42o8g2zRKq/ZvZK1QtwOSC
 TcUkKBP0In9kmf6dJjT8MZ0cuoHQpuXfe3Wbdr5qSeULgzRV67PIuCcXov9afZZSspLO
 48ZTTx/yCbk65KQoTsguznVxedeP7SEOlyzOBANdFTG/Q87rtTwERZRMm3ePZ+YZ5y9x
 c91k4jL5sCipZFCPkwVr6NOsFM5MoAsnhv/wQ8+FGlX6NP6npK+ErqgTeZH3tezIvTEU
 bdcQ==
X-Gm-Message-State: AOJu0YyxtT+P7a8n5WowbYi4GUxQtobTmI08W+iUYW9rDYp5VkKhwv3y
 PkuTSuEmfmrC1t++hWlKEgBB/x6IgXdM75QGOv8glvrC1QGw+Dyy4vdqtU/9hcutY56pZj4hFZe
 0GsW4JY58+QQnJ95uw3MVuljBm87QjRE=
X-Gm-Gg: AeBDietGbPklMWVWGoHFQIaoRiEDBdiV+2EcyW9PMJSLga9IAj7h+gaaxhxgpv3IKjN
 KrpcsoD2PLyWGPr9HO/Xvc89Jz13KX13O9lTXdvAP8jJ0hlPpzxhX6doARh3cMF6ryu/JS94hls
 k8Eh7mBlZMzAtL9hB36DxVfEqxvUVfRI+BMuECjyZWP7IAe9J974Jj63qCOJEFh/P0ke/dKQoTd
 2+U45HUmAyqFrM7e+0AmayvAT6USNHSE4c1fqdePuxJ8g0l0IlMS0Ua5Bcj4k/kDqOI0spgcNz+
 S6ulJrVboUmGnjJxLZW0cSSRAT1+T+OeflWgfT4=
X-Received: by 2002:a17:903:17cf:b0:2b2:45b7:307f with SMTP id
 d9443c01a7336-2b2817d8a45mr234348725ad.9.1775692250962; Wed, 08 Apr 2026
 16:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <9518dd95bde0a79b7d74bf1f2a15577bfaadb976.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <9518dd95bde0a79b7d74bf1f2a15577bfaadb976.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 17:50:39 -0600
X-Gm-Features: AQROBzCKjI63F_yxAgFgzmODmuyGLrerI53x7U4OTrC4oTOOpP43WAPLIlHO_5w
Message-ID: <CAATN3NovHf3Lwm_vwxYpDT6TwRitK2s2tD5iOgQeO_6Vv4+rug@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] target/hexagon: add v68 HVX IEEE float compare
 insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000d95ea1064efb91ba"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x530.google.com
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

--000000000000d95ea1064efb91ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point compare instructions:
> - V6_vgthf, V6_vgtsf: greater-than compare
> - V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and
> - V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
> - V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           |  4 ++
>  target/hexagon/mmvec/macros.h                |  3 +
>  target/hexagon/mmvec/hvx_ieee_fp.c           | 48 +++++++++++++++
>  target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
>  target/hexagon/imported/mmvec/ext.idef       | 61 ++++++++++++++++++++
>  5 files changed, 126 insertions(+)
>
> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h
> b/target/hexagon/mmvec/hvx_ieee_fp.h
> index d55837b756..ad854b905d 100644
> --- a/target/hexagon/mmvec/hvx_ieee_fp.h
> +++ b/target/hexagon/mmvec/hvx_ieee_fp.h
> @@ -25,4 +25,8 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2,
> float_status *fp_status);
>  int32_t conv_w_sf(float32 a, float_status *fp_status);
>  int16_t conv_h_hf(float16 a, float_status *fp_status);
>
> +/* IEEE - FP compare instructions */
> +uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
> +uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
>

Use float32/float16 instead of uint32_t/uint16_t for the args.  That's what
the implementations below use.
The return type should be bool.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000d95ea1064efb91ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point compare instructions:<br>
- V6_vgthf, V6_vgtsf: greater-than compare<br>
- V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and<br>
- V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or<br>
- V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 4 ++<br>
=C2=A0target/hexagon/mmvec/macros.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 +<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 48 +++++++++++++++<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 10 ++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 61=
 ++++++++++++++++++++<br>
=C2=A05 files changed, 126 insertions(+)<br>
<br>
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_=
ieee_fp.h<br>
index d55837b756..ad854b905d 100644<br>
--- a/target/hexagon/mmvec/hvx_ieee_fp.h<br>
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h<br>
@@ -25,4 +25,8 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status=
 *fp_status);<br>
=C2=A0int32_t conv_w_sf(float32 a, float_status *fp_status);<br>
=C2=A0int16_t conv_h_hf(float16 a, float_status *fp_status);<br>
<br>
+/* IEEE - FP compare instructions */<br>
+uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<br>
+uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<br><=
/blockquote><div><br></div><div>Use float32/float16 instead of uint32_t/uin=
t16_t for the args.=C2=A0 That&#39;s what the implementations below use.</d=
iv><div>The return type should be bool.</div><div>=C2=A0</div><div>Otherwis=
e</div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpso=
n@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div><br></div></div></d=
iv>

--000000000000d95ea1064efb91ba--

