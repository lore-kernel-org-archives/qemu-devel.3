Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132C9F483F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4mVv-0003td-Ci; Mon, 23 Mar 2026 17:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4mVr-0003t9-Qd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:08:39 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4mVp-0002ao-Lq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:08:39 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-358ed696623so1535026a91.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 14:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774300114; cv=none;
 d=google.com; s=arc-20240605;
 b=jc0mdihpM1sKMteQ1mP1Hkw58XBq7pqEDfx0AjcMWfv2NDKsJ1s46eKLUipSqoxZWY
 C4g7Zoo79HJAucFwHW7AYxwVD2w+VkpqDuheKBy+C878x4TzauW1+0/Dq6XrNhlPQW3d
 65pR5ChwEdY6RyItKSO7O7z6YU/6xaCeX6KrgvOqkYW9EcE47F6gcTt297PdWWyU7Prn
 Cc80ijc3p08VlBY1GGt5fFoazOv+CJ8Z0pIQXEGLFNpqd/k6r2XXu9A01/Wb1DUSK+dn
 XVraPWKSHt5CrIFc6Mvd81gN69EHDesuV3dgl9hdvXxUSPseik4AC7jW07H+YDDT0DLv
 AfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aOJooXeokofRy3rggJOnKK07eHCeLYU8N6p9hgmPeg8=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=N0J3Y1MIsBiA+bP+c7sekPcSOv0ZW6G946zhJ0humyGUWnHJBmAzjDZW7Ob1bAARxp
 8u9Um5m9pLf29JPcJMJY+MuBNB3PvuH6DwZSkOfQGikUPW5bano18B8T0/jm0gwZH/Pr
 2JkxCEFcq5lt5wnuSpjEwOWUakfgRLguZx1Mfkx41ynOzDnxy1TR/lSfrdJOMP1AIyBH
 QQ99GtJaX0YILY+sX3L1BzGjxEpdPamMubLljYPqskVqCi1Z2u7+Vg6ju7D8gWmFqKAc
 aVLrEL7SuNDg9vR+Zd1GqoVAM01XSOIUL/qCgVPu+357lhebkG3uRNnp2pglWMH6aQsy
 TXpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774300114; x=1774904914; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aOJooXeokofRy3rggJOnKK07eHCeLYU8N6p9hgmPeg8=;
 b=ABpsIyqKietQMFQl2w+YvidlRqYj6dqKCerNjLkJp0m+omLAoTE8onsVzPSpXCHQf1
 f6mEh4Ujg0slT6d0hBxoeQOP2qYCTq8bb0QG8uSDRfpuKUAXBmqy1ht3HJbioosSTU9m
 w194yTHb/Wku56+OhSTJR3oXvq+T0PwccXwkOcDxie5xHWJph/iTk7EOv7jGkxIl0M8r
 1+oz7ebZc82tjwTgH3hImotzrggcERNAK64TSQiF4/adL2JYnca1tQYxuB/pe8cXGAsE
 7gkHZA5XbKyidojMVLl+WF09jX36K8cMc5ndpX2HFF5iA79AcwipJxRp9T0Wmftrm9QI
 695Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774300114; x=1774904914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOJooXeokofRy3rggJOnKK07eHCeLYU8N6p9hgmPeg8=;
 b=iBUVhEb0tWE1Y3P29Q/NEKZllK3q19n+CfccOSqBq1LN7qauSHA9Y1Dw+SSMIwBMRu
 xo2KgSODtMp0YjJd95ib4XLxORLhYC/zfbJC3BI+Lqt3qG5KMhtAdquj0BOmKnLrEbP0
 vi9wMt8k2Uvgmt57uWjNMGpU6G5rc4ifPpxJdNGYJDR2sj732QKCqefrNrxcJAv4pRoB
 C1680y2CEYcxhVNqAUaa9jB2kY3sidqtjA7gXUeRDSseBBd+0SqPvEwixTkggLzMdFtY
 /AlQynEdrECTZ3lYqgM/fyar78x5FRad1eeOzd4DLMu3StSRXdLykuw13HMNBjSkEF21
 ydEg==
X-Gm-Message-State: AOJu0Yzejf6t1cEP49K8fijYp22gLc8dWiL7CVIKv44dZKZntaENZm4c
 sj1/ls+SJIhx6E11uda8rr04grnn9oYkm/mSraSWgyZNzDEznn//ewRiZuG33mngSUFMgAKktMV
 N+nJuqRFaWDGMf4JcJQyCHT+nnqNwA2gHk5UoAZQ=
X-Gm-Gg: ATEYQzzrcn7Rqe+rdCg5sScGkP1qiO5pycoJ6VdXnsx9jpyaJlrlP8g8l6J2H+AbxfF
 lMbTCU9VYTXvvBlvCDYR3ngghrYyq2B6oJzUqBJr4u5LAjdMJu3iUHfSqOpQZ5ZXQ0RFvjP1uQr
 Ag1D++twHswvP1GVkF1hASBbf+n4kmkjh5S1XV911tJprha0UYzrByDgt9Ru01pOiMTZhK18Dfa
 iHUEkMxA69Y0CpG1n0HXdMC5M7ONS6Qd5VXhv51pkDpE4egdPDlzL57fPM+3xJHAICaHSvvldso
 v8s527PPvFkaVt9ctGOtxpun2+/i7rTQRqfPxMM=
X-Received: by 2002:a17:90a:d010:b0:359:ff8a:ee55 with SMTP id
 98e67ed59e1d1-35bd2bf6b36mr10127810a91.14.1774300114492; Mon, 23 Mar 2026
 14:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <c47bfbfbd95829c8493be298a9fb1f49a6584308.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <c47bfbfbd95829c8493be298a9fb1f49a6584308.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 23 Mar 2026 15:08:23 -0600
X-Gm-Features: AaiRm51keyiIZXVyQtP_ewSungcH02C9ENtN0XC1WnsgCCF7pfBG9ecvr68hOCA
Message-ID: <CAATN3NpxMXer5jUD=kpf7aYK8QXRMcxjhzdZXDvPtix=UYK1HA@mail.gmail.com>
Subject: Re: [PATCH 06/13] target/hexagon: add v68 HVX IEEE float misc insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000000c9e46064db77035"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1029.google.com
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

--0000000000000c9e46064db77035
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point miscellaneous instructions:
> - vassign_fp (vfmv): vector move
> - vfneg_hf, vfneg_sf: vector floating-point negate
> - vabs_hf, vabs_sf: vector absolute value
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/kvx_ieee.h              |  3 +++
>  target/hexagon/imported/mmvec/encode_ext.def |  7 +++++++
>  target/hexagon/imported/mmvec/ext.idef       | 14 ++++++++++++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/target/hexagon/mmvec/kvx_ieee.h
> b/target/hexagon/mmvec/kvx_ieee.h
> index 78f546eb8e..263feb7e94 100644
> --- a/target/hexagon/mmvec/kvx_ieee.h
> +++ b/target/hexagon/mmvec/kvx_ieee.h
> @@ -13,6 +13,9 @@
>  #define FP32_DEF_NAN      0x7FFFFFFF
>  #define FP16_DEF_NAN      0x7FFF
>
> +#define signF32UI(a) ((bool)((uint32_t)(a) >> 31))
> +#define signF16UI(a) ((bool)((uint16_t)(a) >> 15))
>

Use softfloat routines here
    !float32_is_neg
    !float16_is_neg

Actually, these aren't needed.  See below.


> diff --git a/target/hexagon/imported/mmvec/ext.idef
> b/target/hexagon/imported/mmvec/ext.idef
> index 43153366b1..5ef5baa404 100644
> --- a/target/hexagon/imported/mmvec/ext.idef
> +++ b/target/hexagon/imported/mmvec/ext.idef
> @@ -3018,6 +3018,20 @@
> ITERATOR_INSN_ANY_SLOT_2SRC(16,vmax_hf,"Vd32.hf=3Dvmax(Vu32.hf,Vv32.hf)",=
 \
>  ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,"Vd32.hf=3Dvmin(Vu32.hf,Vv32.hf)"=
, \
>      "Vector min of hf input", VdV.hf[i] =3D qf_min_hf(VuV.hf[i], VvV.hf[=
i],
> &env->fp_status))
>
> +/* IEEE FP move, negate, abs instructions */
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vassign_fp, "Vd32.w=3Dvfmv(Vu32.w)"=
, \
> +    "Vector IEEE move", VdV.w[i]  =3D VuV.w[i])
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfneg_hf, "Vd32.hf=3Dvfneg(Vu32.hf)=
", \
> +    "Vector IEEE neg: hf", VdV.hf[i] =3D (VuV.hf[i] ^ 0x8000))
>

Use softfloat routines
    VdV.hf[i] =3D float16_set_sign(VuV.hf[i], float16_is_neg(VuV.hf[i]) ? 1=
 :
0)


> +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfneg_sf, "Vd32.sf=3Dvfneg(Vu32.sf)=
", \
> +    "Vector IEEE neg: sf", VdV.sf[i] =3D (VuV.sf[i] ^ 0x80000000))
>

Ditto, but float32_


> +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=3Dvabs(Vu32.hf)"=
, \
> +    "Vector IEEE abs: hf", \
> +    VdV.hf[i] =3D ((signF16UI(VuV.hf[i])) ? (VuV.hf[i] ^ 0x8000) :
> VuV.hf[i]))
>

Use softfloat routines
    VdV.hf[i] =3D float16_abs(VuV.hf[i])


> +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=3Dvabs(Vu32.sf)"=
, \
> +    "Vector IEEE abs: sf", \
> +    VdV.sf[i] =3D ((signF32UI(VuV.sf[i])) ? (VuV.sf[i] ^ 0x80000000) :
> VuV.sf[i]))
>

Ditto, but float32_

Thanks,
Taylor

--0000000000000c9e46064db77035
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point miscellaneous instructions:<br>
- vassign_fp (vfmv): vector move<br>
- vfneg_hf, vfneg_sf: vector floating-point negate<br>
- vabs_hf, vabs_sf: vector absolute value<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +++<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def |=C2=A0 7 +++++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 14=
 ++++++++++++++<br>
=C2=A03 files changed, 24 insertions(+)<br>
<br>
diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_iee=
e.h<br>
index 78f546eb8e..263feb7e94 100644<br>
--- a/target/hexagon/mmvec/kvx_ieee.h<br>
+++ b/target/hexagon/mmvec/kvx_ieee.h<br>
@@ -13,6 +13,9 @@<br>
=C2=A0#define FP32_DEF_NAN=C2=A0 =C2=A0 =C2=A0 0x7FFFFFFF<br>
=C2=A0#define FP16_DEF_NAN=C2=A0 =C2=A0 =C2=A0 0x7FFF<br>
<br>
+#define signF32UI(a) ((bool)((uint32_t)(a) &gt;&gt; 31))<br>
+#define signF16UI(a) ((bool)((uint16_t)(a) &gt;&gt; 15))<br></blockquote><=
div><br></div><div>Use softfloat routines here</div><div>=C2=A0 =C2=A0 !flo=
at32_is_neg</div><div>=C2=A0 =C2=A0 !float16_is_neg</div><div><br></div><di=
v>Actually, these aren&#39;t needed.=C2=A0 See below.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">diff --git a/target/hexa=
gon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef<br>
index 43153366b1..5ef5baa404 100644<br>
--- a/target/hexagon/imported/mmvec/ext.idef<br>
+++ b/target/hexagon/imported/mmvec/ext.idef<br>
@@ -3018,6 +3018,20 @@ ITERATOR_INSN_ANY_SLOT_2SRC(16,vmax_hf,&quot;Vd32.hf=
=3Dvmax(Vu32.hf,Vv32.hf)&quot;, \<br>
=C2=A0ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,&quot;Vd32.hf=3Dvmin(Vu32.hf,V=
v32.hf)&quot;, \<br>
=C2=A0 =C2=A0 =C2=A0&quot;Vector min of hf input&quot;, VdV.hf[i] =3D qf_mi=
n_hf(VuV.hf[i], VvV.hf[i], &amp;env-&gt;fp_status))<br>
<br>
+/* IEEE FP move, negate, abs instructions */<br>
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vassign_fp, &quot;Vd32.w=3Dvfmv(Vu32.=
w)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE move&quot;, VdV.w[i]=C2=A0 =3D VuV.w[i])<b=
r>
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfneg_hf, &quot;Vd32.hf=3Dvfneg(Vu32.=
hf)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE neg: hf&quot;, VdV.hf[i] =3D (VuV.hf[i] ^ =
0x8000))<br></blockquote><div><br></div><div>Use softfloat routines</div><d=
iv>=C2=A0 =C2=A0 VdV.hf[i] =3D float16_set_sign(VuV.hf[i], float16_is_neg(V=
uV.hf[i]) ? 1 : 0)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfneg_sf, &quot;Vd32.sf=3Dvfneg(Vu32.=
sf)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE neg: sf&quot;, VdV.sf[i] =3D (VuV.sf[i] ^ =
0x80000000))<br></blockquote><div><br></div><div>Ditto, but float32_</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,=C2=A0 &quot;Vd32.hf=3Dvabs(V=
u32.hf)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE abs: hf&quot;, \<br>
+=C2=A0 =C2=A0 VdV.hf[i] =3D ((signF16UI(VuV.hf[i])) ? (VuV.hf[i] ^ 0x8000)=
 : VuV.hf[i]))<br></blockquote><div><br></div><div>Use softfloat routines</=
div><div>=C2=A0 =C2=A0 VdV.hf[i] =3D float16_abs(VuV.hf[i])</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,=C2=A0 &quot;Vd32.sf=3Dvabs(V=
u32.sf)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE abs: sf&quot;, \<br>
+=C2=A0 =C2=A0 VdV.sf[i] =3D ((signF32UI(VuV.sf[i])) ? (VuV.sf[i] ^ 0x80000=
000) : VuV.sf[i]))<br></blockquote><div><br></div><div>Ditto, but float32_<=
/div><div><br></div><div>Thanks,</div><div>Taylor</div><div>=C2=A0</div><di=
v><br></div><div>=C2=A0</div></div></div>

--0000000000000c9e46064db77035--

