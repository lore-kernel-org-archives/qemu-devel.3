Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92FCD58CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4mCD-0007id-H4; Mon, 23 Mar 2026 16:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4mC6-0007iN-Cd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 16:48:14 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4mC4-00073V-G0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 16:48:14 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35b95e21ccaso2359680a91.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774298891; cv=none;
 d=google.com; s=arc-20240605;
 b=PYFNet5qd4Rcofq4kNGFERA241/huWiMb3SJN1PKSZpw0L8PydWXVRseTc/FKwMTp2
 YR2PrpMMmNyaZvaGIggE4ABFuQkfCAjJLbg5chhyUz3jQ550APHolkAErhOJOvc9EO+A
 8NBVKJtGJp2Rwj5882VnueTjvtEnsqLvw0G8m0o5Rd/kmhxX3ilNHo4HR5yExX6aGZCX
 DRLGkjsps3iJaggvfA7qhAWtoJ8YRLHwnzM5C0lukOFCuxd9fnYvO2umax0nzXm94eeV
 uA5XmI7uKWyL8/fTW2a8mJgTcL2AaDQX7e6uFQTQP/NRNDOrivmc+jqhKCcjgbKWIJzA
 zXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7ULII5Lfx9OnusFCcZFjOt8Wl9xaBWDbNZBH8IMCdP0=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=P7rF7DvPnXe8k+Yml+hmFnl/FX5yjJjXsCxnyujxJeADqb2p4qRpQ/EDs/ncHqfgjm
 cM8dRVqtWBXJYWJBiaNHTfoQAnONmufyOFqF9sgQmDvusl0tGrBvV40nuzxxoTO00FMk
 omCeXJG3WfG6oF7mm4pR6l8qYBI2ghWIFFDssPIPll/QLS5rwekHn5LQ4we3/+Wt/z6A
 /YUGyYtV4ciEUv/8gpI8Bc1v59Re6BAdDZZvJ+/oI2q4ERBIaihFcTPK3A5wIlxygjRf
 MkHEccBItXapzL/8DpI00XYqD8RdPp+5SyuElD1UwxMBR7nMMFKIr9q5aM9fLGA8hM+J
 7eug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774298891; x=1774903691; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ULII5Lfx9OnusFCcZFjOt8Wl9xaBWDbNZBH8IMCdP0=;
 b=Hrs6NH79j6F8NaASCKFzoNPDvUvEOeN1QWJ3FoCmJLi9LewkL/wyqkmoE5h2g0VEc3
 WykTu6s+VX2yiFlWRE/ccw6Ai7puoJo7ar1iLL62P0MSNneV+ztW3hMPSQDoDj2pI4g2
 tTtxKSb92vzPPuiC/ERma0Dquk7cvhXdJdWMuQltx2CLw533qNmZuhq7Rp+PtOX1xsO2
 MWjPfgyge8K2RyvkCpQoUuerl3MaSsvh5teFUFwH1tjjaVIcxOqY+zjKCowySXNmdQgF
 lmTjc16Vbsx+hf5ZxC4/SAcbgOnfXBSQ4L0ifzUM8KyeUwsfSR9rQFQXSyAw30ieyhCg
 8jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774298891; x=1774903691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ULII5Lfx9OnusFCcZFjOt8Wl9xaBWDbNZBH8IMCdP0=;
 b=iEjhTdFwPEgAe0f5jff+QsB146W2kXid9jHxk+a+iAayT2168UHvI4bRXvh0Z8e796
 dbXA5TUVD87mz80A0b5cOuQLKExHpepsAfr8VWWgn03ZIO0sjNKaAmxF85cdvLaZNN3r
 qU39yS9w5vnr4nigXmoYPPZjwSd8xluuky5M0kgZWgcS5AfwbQfPmG9a6Gw63a9/b2QW
 4iFxdtG5IYMrWzhlR2RY6UcUZ1esavAJvdFiCcihG533Bp3QmwJHa3mh4FiP72n9qvwr
 2gSk31hAV/V3oD9q24kDYWgNvgV1o1qVNTkiRJw7PSeaPck48w1LGEVwWcAkVfZWs3pr
 tm3g==
X-Gm-Message-State: AOJu0Yy98FAZKyUDoG31iI+3HukE/8Cv9ZrWLR+NwzpA2t308PY7YgHB
 1cBu86A2N0j5uZCexhB87PbhxqNXLAuS9hABKTTzKvh/Npj1ZfkN4tlNGcZZSnL8SQXYwEeSY87
 qGo8tqlCKN8zN1eXiOS5VhUszfnT70bY=
X-Gm-Gg: ATEYQzwUVBPneCExAHz4FLmSl2s2arFr8kSCiNBN9U0Ypy4KkkKJ7oQttVSP70kAHIb
 BZovPIZnVIcIEVs6+IZ6dloR8f88JiEY6mlcJ8tWtX6IBoB/8tz1yPZHAHjOaZfF0kBw1m4Uvse
 jKjhN7rdJdN+MAW7OUTiH2XRYBAEnN6GO2TFTPRWQCG+1/cANK7yVJF4IxkXUOmCC0eQW5EoLnZ
 eZ6MRBqXXEkLxy5JeiaJI02GI1MDXcM7NsGC4CgwA6uqZBIiw0X9xOHFFgwBI4jz4CogSF/zo27
 x/JgH2bHHQrwOxLLzdaxi97cjOY5sbyA5AEtpwY=
X-Received: by 2002:a17:902:d491:b0:2b0:6ba2:3d78 with SMTP id
 d9443c01a7336-2b0a4d80232mr7480245ad.3.1774298890819; Mon, 23 Mar 2026
 13:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <4895991dcd597b052869e2275d5f0056dfc2368b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <4895991dcd597b052869e2275d5f0056dfc2368b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 23 Mar 2026 14:47:59 -0600
X-Gm-Features: AaiRm53Echdc8k_hmlizoMjL0Il9e7-KdXXbsSmlxZRmqzMbWstf5TdeXkez-QI
Message-ID: <CAATN3No1pf9Xty8NOCmO2_YJg0TKjJ3NoUcPBvG9fHTf8Dr7kw@mail.gmail.com>
Subject: Re: [PATCH 05/13] target/hexagon: add v68 HVX IEEE float min/max insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000001cddc4064db727a9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102f.google.com
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

--0000000000001cddc4064db727a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point min/max instructions:
> - vfmin_hf, vfmin_sf: IEEE floating-point minimum
> - vfmax_hf, vfmax_sf: IEEE floating-point maximum
> - vmax_hf, vmax_sf: qfloat IEEE maximum
> - vmin_hf, vmin_sf: qfloat IEEE minimum
>
> The Hexagon qfloat variants are similar to the IEEE-754 ones, but they
> handle NaN slightly differently. See comment on kvx_ieee.h
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/kvx_ieee.h              | 12 +++++
>  target/hexagon/mmvec/kvx_ieee.c              | 46 ++++++++++++++++++++
>  target/hexagon/imported/mmvec/encode_ext.def | 11 +++++
>  target/hexagon/imported/mmvec/ext.idef       | 28 +++++++++++-
>  4 files changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/target/hexagon/mmvec/kvx_ieee.h
> b/target/hexagon/mmvec/kvx_ieee.h
> index e92ddebeb9..78f546eb8e 100644
> --- a/target/hexagon/mmvec/kvx_ieee.h
> +++ b/target/hexagon/mmvec/kvx_ieee.h
> @@ -44,4 +44,16 @@ uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t
> a3, uint16_t a4,
>  uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a=
3,
>                        uint16_t a4, float_status *fp_status);
>
> +/* IEEE - FP min/max instructions */
> +uint32_t fp_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
> +uint32_t fp_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
> +uint16_t fp_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
> +uint16_t fp_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
> +
> +/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller
> than -INF */
> +uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
> +uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
> +uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
> +uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
>

Why are we including Qfloat stuff in a patch series for IEEE float?


> +
>  #endif
> diff --git a/target/hexagon/imported/mmvec/encode_ext.def
> b/target/hexagon/imported/mmvec/encode_ext.def
> index 4ce87d09fd..23fbb75743 100644
> --- a/target/hexagon/imported/mmvec/encode_ext.def
> +++ b/target/hexagon/imported/mmvec/encode_ext.def
> @@ -823,4 +823,15 @@
> DEF_ENC(V6_vsub_sf_hf,"00011111100vvvvvPP1uuuuu101ddddd")
>  DEF_ENC(V6_vadd_hf_hf,"00011111101vvvvvPP1uuuuu111ddddd")
>  DEF_ENC(V6_vsub_hf_hf,"00011111011vvvvvPP1uuuuu000ddddd")
>
> +/* IEEE FP min/max instructions */
> +DEF_ENC(V6_vfmin_hf,"00011100011vvvvvPP1uuuuu000ddddd")
> +DEF_ENC(V6_vfmin_sf,"00011100011vvvvvPP1uuuuu001ddddd")
> +DEF_ENC(V6_vfmax_hf,"00011100011vvvvvPP1uuuuu010ddddd")
> +DEF_ENC(V6_vfmax_sf,"00011100011vvvvvPP1uuuuu011ddddd")
> +DEF_ENC(V6_vmax_sf,"00011111110vvvvvPP1uuuuu001ddddd")
> +DEF_ENC(V6_vmin_sf,"00011111110vvvvvPP1uuuuu010ddddd")
> +DEF_ENC(V6_vmax_hf,"00011111110vvvvvPP1uuuuu011ddddd")
> +DEF_ENC(V6_vmin_hf,"00011111110vvvvvPP1uuuuu100ddddd")
> +DEF_ENC(V6_vcvt_ub_hf,"00011111110vvvvvPP1uuuuu101ddddd")
>

Minor nit - this is a conversion instruction and is repeated in patch 7.
Remove it from this patch.

Thanks,
Taylor

--0000000000001cddc4064db727a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point min/max instructions:<br>
- vfmin_hf, vfmin_sf: IEEE floating-point minimum<br>
- vfmax_hf, vfmax_sf: IEEE floating-point maximum<br>
- vmax_hf, vmax_sf: qfloat IEEE maximum<br>
- vmin_hf, vmin_sf: qfloat IEEE minimum<br>
<br>
The Hexagon qfloat variants are similar to the IEEE-754 ones, but they<br>
handle NaN slightly differently. See comment on kvx_ieee.h<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 12 +++++<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 46 ++++++++++++++++++++<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 11 +++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 28=
 +++++++++++-<br>
=C2=A04 files changed, 96 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_iee=
e.h<br>
index e92ddebeb9..78f546eb8e 100644<br>
--- a/target/hexagon/mmvec/kvx_ieee.h<br>
+++ b/target/hexagon/mmvec/kvx_ieee.h<br>
@@ -44,4 +44,16 @@ uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3,=
 uint16_t a4,<br>
=C2=A0uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_=
t a3,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint16_t a4, float_status *fp_status);<br>
<br>
+/* IEEE - FP min/max instructions */<br>
+uint32_t fp_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<br>
+uint32_t fp_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<br>
+uint16_t fp_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<br>
+uint16_t fp_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<br>
+<br>
+/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than=
 -INF */<br>
+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<br>
+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<br>
+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<br>
+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<br>=
</blockquote><div><br></div><div>Why are we including Qfloat stuff in a pat=
ch series for IEEE float?</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
+<br>
=C2=A0#endif<br>diff --git a/target/hexagon/imported/mmvec/encode_ext.def b=
/target/hexagon/imported/mmvec/encode_ext.def<br>
index 4ce87d09fd..23fbb75743 100644<br>
--- a/target/hexagon/imported/mmvec/encode_ext.def<br>
+++ b/target/hexagon/imported/mmvec/encode_ext.def<br>
@@ -823,4 +823,15 @@ DEF_ENC(V6_vsub_sf_hf,&quot;00011111100vvvvvPP1uuuuu10=
1ddddd&quot;)<br>
=C2=A0DEF_ENC(V6_vadd_hf_hf,&quot;00011111101vvvvvPP1uuuuu111ddddd&quot;)<b=
r>
=C2=A0DEF_ENC(V6_vsub_hf_hf,&quot;00011111011vvvvvPP1uuuuu000ddddd&quot;)<b=
r>
<br>
+/* IEEE FP min/max instructions */<br>
+DEF_ENC(V6_vfmin_hf,&quot;00011100011vvvvvPP1uuuuu000ddddd&quot;)<br>
+DEF_ENC(V6_vfmin_sf,&quot;00011100011vvvvvPP1uuuuu001ddddd&quot;)<br>
+DEF_ENC(V6_vfmax_hf,&quot;00011100011vvvvvPP1uuuuu010ddddd&quot;)<br>
+DEF_ENC(V6_vfmax_sf,&quot;00011100011vvvvvPP1uuuuu011ddddd&quot;)<br>
+DEF_ENC(V6_vmax_sf,&quot;00011111110vvvvvPP1uuuuu001ddddd&quot;)<br>
+DEF_ENC(V6_vmin_sf,&quot;00011111110vvvvvPP1uuuuu010ddddd&quot;)<br>
+DEF_ENC(V6_vmax_hf,&quot;00011111110vvvvvPP1uuuuu011ddddd&quot;)<br>
+DEF_ENC(V6_vmin_hf,&quot;00011111110vvvvvPP1uuuuu100ddddd&quot;)<br>
+DEF_ENC(V6_vcvt_ub_hf,&quot;00011111110vvvvvPP1uuuuu101ddddd&quot;)<br></b=
lockquote><div><br></div><div>Minor nit - this is a conversion instruction =
and is repeated in patch 7.=C2=A0 Remove it from this patch.</div><div>=C2=
=A0</div><div>Thanks,</div><div>Taylor</div><div><br></div></div></div>

--0000000000001cddc4064db727a9--

