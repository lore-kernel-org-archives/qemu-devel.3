Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F7110FC456
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAcLq-0004KO-Ov; Wed, 08 Apr 2026 19:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcLo-0004Gw-Dd
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:30:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcLm-0000RT-NO
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:30:24 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2addb31945aso2129555ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775691021; cv=none;
 d=google.com; s=arc-20240605;
 b=loi3lVSrjvdIcw4CwZU5n1vUIAdM4zhyWBepyHxPdJ/ngzvKw1wpb3cN8vsac4eBo6
 ea4hwlmkWprox53VbexFTWfKIikX1nZYf3fXK/4WM91sgxBKmi9m3q0PyZTiReOXR4Ru
 ctMwaZ9zsBy9iJCJzWc4Cr0RYhVK2hk9IvPLnRHYNKibn4a/9BPWVibDi79TvyPSbo39
 416ijsF02613K0AxneZNfiRdmKM061iUQRJA/euReGMAC5Bzs0i+7Njd4yzFzul+h5TE
 SOk6F2O0ixE6qtqHDt94qA96JmKFZqrGeUHFbIeZOEZjqNb9gFq6R7l5sPvbXRBXILMG
 jgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DTlBoQRl4C/4v0qjBblJOKydeJC045m40dzqZvQmXio=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=Wez9DSi1KONVsxUyp6cVoF7wjxXccZTnfB+WV1c2CbszcxgZWVLPW4vUSemM1A0FT/
 pfCcIxLNTVx40Y4xBvNU5coIyWANeYU9aZxXpJEk20qgMfXCwrv0IDMYuZlJJgcDhdf9
 9DqdQ5wbbsUiAm6PB6wXjAMkP4ajFZZywLQdhPgJxa+RtTXPlZEF5EpjA86Bd8ZkJytG
 23Eu/k0drVK+VYdZs6w+DQmNK7pnqTdzxTd+dRSeaLUYUZGxcB9iKcRidvqn1QkHCorc
 QGRDCA0a+lJm/yioV7jO5VLTc84IaYeiAJla2IZJHjiVLn9Jm5c6tWIvOUkXHFMbWAUv
 l2wA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775691021; x=1776295821; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DTlBoQRl4C/4v0qjBblJOKydeJC045m40dzqZvQmXio=;
 b=hQZf9viKR4kZgzIKwTQLb7ShHyBuulEEMpSuImBedsEC6p37xryxXr0Z0+QzdSfxlN
 VDx3MzhCgC3bWxnPRQe3bCY7fSz5fgLx68pg2nM25y2CAVwo7iY9Ao6l7gwBc0hPc1KX
 l/yN+79oPlWVtF+HFnQ7g2IPZ6CYayFRBocamLkxSpYV4i22s2f6FVXsSUgA1c8gKObZ
 Aj0P1wjbhMLQhcnV2DSgHzVjXXuWNfUBO5nJ79GoizpgiCbIRzIySZKJlbwkWwlORnAS
 bl9V22y/OqjgIDwbA3R1fmV+GWM7BfKfgNXMX1vSCqvlxVT/h2IsOWThxdlz5FV+kYde
 x1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775691021; x=1776295821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTlBoQRl4C/4v0qjBblJOKydeJC045m40dzqZvQmXio=;
 b=r21Q6dAmzBzfDjP8rE0yvJgizGMa7BQN6OOBFThZg+FN2fOnk4cMhd2ziMMPVWuQna
 qXGxjKREmZGcnevMaH/HJdAECmwcpWtTeGiNoIyQNvebA/1j/cnqaibfZHVCB0PUb93y
 99g52jkb7vyFvIpeBqwZt8laSwkVe7cW792Qzumq27fV2Y4S6kCjdSwr50cU4kFwPcF5
 40rVPKsOPmpaUXzHUXcDFwqvjfxZR+E8f18K0WmTrOE0BIKfYBJ6SKNxXUhobCEHtys+
 T91uGHYs/P2p6GnB/1cfHRKuRP9pdNNKP/sbSoN+NUlbNMVuTVUyCxs9Op7hyp0TI5Hq
 +W3w==
X-Gm-Message-State: AOJu0Yz4x7zb8Jr/eAs7ybEzV7jm5c1QA3MT9ljhNlZpsbenrAYDPPRx
 3W/Tc0YgI4Ear1ttQtw2YKlm/sprN1UzrChy3hRP+ZWbv8Squ61dX3JPb4Xky3k2voKNqEfGRl3
 NTH2ZLh9YuBUxfkCx9KoXmm/2MUIbmlk=
X-Gm-Gg: AeBDietBPt4wRKO8wVgea/NipPpJ7gVtbRi89R7KTddf129cLaQria94K9fPpsB41Nx
 ln6uGDDdMfoZeBmI8Z3wwRt9jZYJOF9SuRi3eFlbKgn/kRUeVPrMWDE7huIr3kowrQO9z1ulhhn
 /dNJVbA0uiXXplTOYGG9E/wUDhk8CjyW8M+FkDoVkavbCa96MTLQrFAFkrVsGDVyIceLePkUW1h
 YG72grEZNgSrDdWki1fYrqS/Vl/ijFRxkNESwamgERpzC96gok+TnZasvSV7TsWLtYaCajhBXs9
 GuCn9V8bWXIMIfUP8YYM81Vyoc3aY/utN1e8bAs=
X-Received: by 2002:a17:902:e546:b0:2b0:5b4e:370c with SMTP id
 d9443c01a7336-2b281931aa5mr233465475ad.32.1775691020914; Wed, 08 Apr 2026
 16:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <2aa7f105031465bdbd63c22bca6e2b77b92bab5f.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <2aa7f105031465bdbd63c22bca6e2b77b92bab5f.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 17:30:09 -0600
X-Gm-Features: AQROBzCY5_LzmL57OYVS9x2RuiGsuogEGGMAlJ_VNFYOx5vzOBT5nqYtPMIKios
Message-ID: <CAATN3Npqzo=hoQuKix6=gAf9GVeuqM1=wF9LDFyOFcv1MvC9oA@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] target/hexagon: add v68 HVX IEEE float misc insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000008854f7064efb48b8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x633.google.com
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

--0000000000008854f7064efb48b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point miscellaneous instructions:
> - vassign_fp (vfmv): vector move
> - vfneg_hf, vfneg_sf: vector floating-point negate
> - vabs_hf, vabs_sf: vector absolute value
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/imported/mmvec/encode_ext.def |  7 +++++++
>  target/hexagon/imported/mmvec/ext.idef       | 12 ++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/target/hexagon/imported/mmvec/ext.idef
> b/target/hexagon/imported/mmvec/ext.idef
> index 0e9cace203..5312661684 100644
> --- a/target/hexagon/imported/mmvec/ext.idef
> +++ b/target/hexagon/imported/mmvec/ext.idef
> @@ -3034,6 +3034,18 @@
> ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,"Vd32.hf=3Dvmin(Vu32.hf,Vv32.hf)",=
 \
>      "Vector min of hf input", VdV.hf[i] =3D qf_min_hf(VuV.hf[i], VvV.hf[=
i],
> \
>         &env->hvx_fp_status))
>
> +/* IEEE FP move, negate, abs instructions */
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vassign_fp, "Vd32.w=3Dvfmv(Vu32.w)"=
, \
> +    "Vector IEEE move", VdV.w[i]  =3D VuV.w[i])
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfneg_hf, "Vd32.hf=3Dvfneg(Vu32.hf)=
", \
> +    "Vector IEEE neg: hf", VdV.hf[i] =3D float16_chs(VuV.hf[i]))
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfneg_sf, "Vd32.sf=3Dvfneg(Vu32.sf)=
", \
> +    "Vector IEEE neg: sf", VdV.sf[i] =3D float32_chs(VuV.sf[i]))
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=3Dvabs(Vu32.hf)"=
, \
> +    "Vector IEEE abs: hf", VdV.hf[i] =3D float16_abs(VuV.hf[i]))
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=3Dvabs(Vu32.sf)"=
, \
> +    "Vector IEEE abs: sf", VdV.hf[i] =3D float32_abs(VuV.hf[i]))


Should be VdV.sf[i] =3D float32_abs(vuV.sf[i])
I'm surprised there isn't a test case that catches this.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000008854f7064efb48b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
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
=C2=A0target/hexagon/imported/mmvec/encode_ext.def |=C2=A0 7 +++++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 12=
 ++++++++++++<br>
=C2=A02 files changed, 19 insertions(+)<br>
<br>diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/im=
ported/mmvec/ext.idef<br>
index 0e9cace203..5312661684 100644<br>
--- a/target/hexagon/imported/mmvec/ext.idef<br>
+++ b/target/hexagon/imported/mmvec/ext.idef<br>
@@ -3034,6 +3034,18 @@ ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,&quot;Vd32.hf=
=3Dvmin(Vu32.hf,Vv32.hf)&quot;, \<br>
=C2=A0 =C2=A0 =C2=A0&quot;Vector min of hf input&quot;, VdV.hf[i] =3D qf_mi=
n_hf(VuV.hf[i], VvV.hf[i], \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;env-&gt;hvx_fp_status))<br>
<br>
+/* IEEE FP move, negate, abs instructions */<br>
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vassign_fp, &quot;Vd32.w=3Dvfmv(Vu32.=
w)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE move&quot;, VdV.w[i]=C2=A0 =3D VuV.w[i])<b=
r>
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfneg_hf, &quot;Vd32.hf=3Dvfneg(Vu32.=
hf)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE neg: hf&quot;, VdV.hf[i] =3D float16_chs(V=
uV.hf[i]))<br>
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfneg_sf, &quot;Vd32.sf=3Dvfneg(Vu32.=
sf)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE neg: sf&quot;, VdV.sf[i] =3D float32_chs(V=
uV.sf[i]))<br>
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,=C2=A0 &quot;Vd32.hf=3Dvabs(V=
u32.hf)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE abs: hf&quot;, VdV.hf[i] =3D float16_abs(V=
uV.hf[i]))<br>
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,=C2=A0 &quot;Vd32.sf=3Dvabs(V=
u32.sf)&quot;, \<br>
+=C2=A0 =C2=A0 &quot;Vector IEEE abs: sf&quot;, VdV.hf[i] =3D float32_abs(V=
uV.hf[i]))</blockquote><div><br></div><div>Should be VdV.sf[i] =3D float32_=
abs(vuV.sf[i])=C2=A0</div><div>I&#39;m surprised there isn&#39;t a test cas=
e that catches this.</div><div><br></div><div>Otherwise</div><div>Reviewed-=
by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylors=
impson@gmail.com</a>&gt;</div></div></div>

--0000000000008854f7064efb48b8--

