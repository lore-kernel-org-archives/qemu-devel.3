Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC4CEDEBEA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVh7-0008BJ-BS; Tue, 03 Mar 2026 14:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVgv-00087K-Q6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:46:03 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVgp-0000Ua-NF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:46:01 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c70bfef17a4so3607292a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:45:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772567153; cv=none;
 d=google.com; s=arc-20240605;
 b=WN0vwdrmdCILz8AsBjA7xHwpZg2y+NZv+WukTwz+ltlHZ1Mtrbo3LAJYAiznDDZIFY
 vX7OK/0QfBeQ8W+7ezixS5f2nklqWq0Ucv8CyU0pRM6y/hme1TillOZnytTG0BA7BGKe
 XgZ44Hzygt8kNXcrLMZw8pVOdSLSofOkxEzjBH/OBGd/I3R2GgHhSvt+cXUDieZ82GaF
 4XfnCb1KQsWu03KYjEFqIRqM16iZkQxJlPNg+GEeDUZuRoL7vt2ReXp6bhzVQDU5H2if
 qUedSrADBy3l9W60rb83lfHmOmmqJ3B4Jaln5KRDymC5y0IWh2lPeqx4ZtabyQTkWpv7
 0gUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q1IksLXqAANpBj1i/C1RR6riMbVFHouL7qXRzHh70Qc=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=k+ecHwKEeNrWcqkmG7bn9an7VWG7Rq/Tt2GIj9KcWQMBr2nihf+TM1bQ7OtZcdJnxQ
 OcUodi6qPJ7URiKXcs8UTxzPuSGwMvKUzcz/m7PUPxQrgDtAmouefVU0ClmfUNRg1OlT
 aCYlka8FRq9xUqI11+SO2D5wVTou9dCMbb7DrITnpiJab+dQ143Bsv9UsxS/W+8sLzl0
 qSyBeOnFnOXL67YaoJR99ytU/BZHQpTNiEMVq+zh2HHIglShFFMOupG9UyPs/hMAhzeC
 poHyUi2uoAVL8Qfc5JHV2d8QsFIqLAisfBxSUmvfRPiaMuHMpVUb78srQof68Qvls80S
 IT3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772567153; x=1773171953; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q1IksLXqAANpBj1i/C1RR6riMbVFHouL7qXRzHh70Qc=;
 b=byUaNR8+5Jt07cl6SRsNXK86mFmUr2KtUaqVqb028lLUELsBkstnWH7rCI+WzNd0Qm
 fgVZnPIWRVMI1zZTyxNCso4Vtj8tBFgHmdEBWqIhzQIwbQSz6595lpv9VjWU/wS5XiBh
 RDH8eTglDRPJ8Yfn2dXt28c28+QHcapRO3jONVkcQuP+Z/9s1m5hKTsF4Tv5Vqbg9SiG
 5ByZ3wJhXsBN34AdGMhXd2bnXpGPKPZG+ccfWg87peKSeOUkdo/YEyCbBoHjU0q9Irkg
 nz+MCt089u3MzxRLwavUN8bUNlc120nhl53cl3dbDqkFrHwmuO/YY4rYFzptuQDT8GLl
 30hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567153; x=1773171953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1IksLXqAANpBj1i/C1RR6riMbVFHouL7qXRzHh70Qc=;
 b=ldmM7fbpkySy81Q2UvibPyHIrpl1zGS4TfR7kfZBDV1h6PUsI0wHh7jMO5ed4k2pDT
 Otdyh1uAzQN5mkOX4qxe2oB+lRNvid/MKue23PYbISWJTBEdCx4MQEVnjMwyxtX5VYjg
 f/Bp7TWR/yUWvQ000bHaf9FxmMgSbTkEyvsQ2Tx8kkSLzOOOBpxf+vJGdKW7+vfq5CQs
 M25u7McX0U2nc3rP+xh+2Xfdvx+bO26S4qCGO06RahHZqCI7qK46/E3rezZ6RTLPmxOK
 jQR18Idrmu7jfeC1M/C5lOz6nk6fOo7MWiaoyWL/a5fLfGRd2Fz8P/Gt8IguZf6HvR9r
 VdxQ==
X-Gm-Message-State: AOJu0YyNvlUbHRBPWFCrC0FSwebOq+lYrjphSh3HQSGLWvS/bL3Zc0pB
 JtTewfJMeThXebcjmV0ErWM3KkeDaT69v/k6lGCQzHXGXIS6MJyNLaP3pgpgw/tLpSRctcwinzE
 e4Uqp8IvmcAG7/B0oGmNBMtC3dtmzs84=
X-Gm-Gg: ATEYQzxVH7QSPifEJCNakhyR7uByGW7E7heDVijIi2VT0ILYM+9TKj2PsJMTqJnW9m6
 GdAABC3MHC7YZmW9XW/Uka9FqbO5TmxEUcCnt+hqOsqdm2iJu42n5c6KM3dCjKnM3i78XSTdljW
 L/rSt7uKfHHIOcTLvF1VhtfrHdLfw/Tr40ny2AThtaASgtp7ij7F8nQWswUMUA4uYEgsa0kf9WK
 xYtecbpmun0UYP4eS+wt8FtVO7ChsU0GrgveEB+sRr7cumNUNZMl+gQTpD4RBd7C8D7jCS86HSQ
 x8njP1lT7wZoyRvFyHHL5DzOoS9aP6Lg9sL7qJA=
X-Received: by 2002:a17:903:8c6:b0:2ae:5464:7a4b with SMTP id
 d9443c01a7336-2ae546489e4mr71904585ad.14.1772567152980; Tue, 03 Mar 2026
 11:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-13-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-13-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 12:45:41 -0700
X-Gm-Features: AaiRm51S40_UYhxa3t29lREpGZLeYnyuDiHRFYnz_8f30Gce85aAYnuM_nSJ-ys
Message-ID: <CAATN3NpprWXbhYA6g-Dn2ZA-sAreHw2OMTBnSLMhd0886X7dMg@mail.gmail.com>
Subject: Re: [PATCH v3 12/37] target/hexagon: Add guest, system reg number defs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="0000000000007e7457064c23f358"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

--0000000000007e7457064c23f358
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:36=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h      |   5 ++
>  target/hexagon/hex_regs.h | 115 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 9fd69c7453f..3619eaa1a52 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -20,6 +20,11 @@
>
>  #include "fpu/softfloat-types.h"
>
> +#define NUM_GREGS 32
> +#define GREG_WRITES_MAX 2
> +#define NUM_SREGS 64
> +#define SREG_WRITES_MAX 2
> +
>

Guard with #ifndef CONFIG_USER_ONLY


>  #include "cpu-qom.h"
>  #include "exec/cpu-common.h"
>  #include "exec/cpu-defs.h"
> diff --git a/target/hexagon/hex_regs.h b/target/hexagon/hex_regs.h
> index bddfc28021c..ea8c62eba9c 100644
> --- a/target/hexagon/hex_regs.h
> +++ b/target/hexagon/hex_regs.h
> @@ -81,4 +81,119 @@ enum {
>      HEX_REG_UTIMERHI          =3D 63,
>  };
>
> +#ifndef CONFIG_USER_ONLY
> +
> +#define HEX_GREG_VALUES \
> +  DECL_HEX_GREG(G0,         0) \
> +  DECL_HEX_GREG(GELR,       0) \
> +  DECL_HEX_GREG(G1,         1) \
> +  DECL_HEX_GREG(GSR,        1) \
> +  DECL_HEX_GREG(G2,         2) \
> +  DECL_HEX_GREG(GOSP,       2) \
> +  DECL_HEX_GREG(G3,         3) \
> +  DECL_HEX_GREG(GBADVA,     3) \
> +  DECL_HEX_GREG(GCYCLE_1T,  10) \
> +  DECL_HEX_GREG(GCYCLE_2T,  11) \
> +  DECL_HEX_GREG(GCYCLE_3T,  12) \
> +  DECL_HEX_GREG(GCYCLE_4T,  13) \
> +  DECL_HEX_GREG(GCYCLE_5T,  14) \
> +  DECL_HEX_GREG(GCYCLE_6T,  15) \
> +  DECL_HEX_GREG(GPMUCNT4,   16) \
> +  DECL_HEX_GREG(GPMUCNT5,   17) \
> +  DECL_HEX_GREG(GPMUCNT6,   18) \
> +  DECL_HEX_GREG(GPMUCNT7,   19) \
> +  DECL_HEX_GREG(GPCYCLELO,  24) \
> +  DECL_HEX_GREG(GPCYCLEHI,  25) \
> +  DECL_HEX_GREG(GPMUCNT0,   26) \
> +  DECL_HEX_GREG(GPMUCNT1,   27) \
> +  DECL_HEX_GREG(GPMUCNT2,   28) \
> +  DECL_HEX_GREG(GPMUCNT3,   29) \
> +  DECL_HEX_GREG_DONE
> +
> +#define DECL_HEX_GREG_DONE
> +#define DECL_HEX_GREG(name, val) HEX_GREG_ ##name =3D val,
> +enum hex_greg {
> +    HEX_GREG_VALUES
> +};
> +#undef DECL_HEX_GREG
> +#undef DECL_HEX_GREG_DONE
> +
> +#define DECL_HEX_GREG_DONE 0
> +#define DECL_HEX_GREG(_, val) (1 << val) |
> +static inline bool greg_implemented(enum hex_greg greg)
> +{
> +#if NUM_GREGS > 32
> +#error "NUM_GREGS too large for greg_implemented(): update `impl_bitmap`=
"
> +#endif
> +    static int32_t impl_bitmap =3D HEX_GREG_VALUES;
> +    return impl_bitmap & (1 << greg);
> +}
> +#undef DECL_HEX_GREG
> +#undef DECL_HEX_GREG_DONE
> +
> +#endif /* CONFIG_USER_ONLY */
> +
> +enum {
> +    HEX_SREG_SGP0 =3D 0,
> +    HEX_SREG_SGP1 =3D 1,
> +    HEX_SREG_STID =3D 2,
> +    HEX_SREG_ELR =3D 3,
> +    HEX_SREG_BADVA0 =3D 4,
> +    HEX_SREG_BADVA1 =3D 5,
> +    HEX_SREG_SSR =3D 6,
> +    HEX_SREG_CCR =3D 7,
> +    HEX_SREG_HTID =3D 8,
> +    HEX_SREG_BADVA =3D 9,
> +    HEX_SREG_IMASK =3D 10,
> +    HEX_SREG_GEVB  =3D 11,
> +    HEX_SREG_GLB_START =3D 16,
> +    HEX_SREG_EVB =3D 16,
> +    HEX_SREG_MODECTL =3D 17,
> +    HEX_SREG_SYSCFG =3D 18,
> +    HEX_SREG_IPENDAD =3D 20,
> +    HEX_SREG_VID =3D 21,
> +    HEX_SREG_VID1 =3D 22,
> +    HEX_SREG_BESTWAIT =3D 23,
> +    HEX_SREG_IEL =3D 24,
> +    HEX_SREG_SCHEDCFG =3D 25,
> +    HEX_SREG_IAHL =3D 26,
> +    HEX_SREG_CFGBASE =3D 27,
> +    HEX_SREG_DIAG =3D 28,
> +    HEX_SREG_REV =3D 29,
> +    HEX_SREG_PCYCLELO =3D 30,
> +    HEX_SREG_PCYCLEHI =3D 31,
> +    HEX_SREG_ISDBST =3D 32,
> +    HEX_SREG_ISDBCFG0 =3D 33,
> +    HEX_SREG_ISDBCFG1 =3D 34,
> +    HEX_SREG_LIVELOCK =3D 35,
> +    HEX_SREG_BRKPTPC0 =3D 36,
> +    HEX_SREG_BRKPTCFG0 =3D 37,
> +    HEX_SREG_BRKPTPC1 =3D 38,
> +    HEX_SREG_BRKPTCFG1 =3D 39,
> +    HEX_SREG_ISDBMBXIN =3D 40,
> +    HEX_SREG_ISDBMBXOUT =3D 41,
> +    HEX_SREG_ISDBEN =3D 42,
> +    HEX_SREG_ISDBGPR =3D 43,
> +    HEX_SREG_PMUCNT4 =3D 44,
> +    HEX_SREG_PMUCNT5 =3D 45,
> +    HEX_SREG_PMUCNT6 =3D 46,
> +    HEX_SREG_PMUCNT7 =3D 47,
> +    HEX_SREG_PMUCNT0 =3D 48,
> +    HEX_SREG_PMUCNT1 =3D 49,
> +    HEX_SREG_PMUCNT2 =3D 50,
> +    HEX_SREG_PMUCNT3 =3D 51,
> +    HEX_SREG_PMUEVTCFG =3D 52,
> +    HEX_SREG_PMUSTID0 =3D 53,
> +    HEX_SREG_PMUEVTCFG1 =3D 54,
> +    HEX_SREG_PMUSTID1 =3D 55,
> +    HEX_SREG_TIMERLO =3D 56,
> +    HEX_SREG_TIMERHI =3D 57,
> +    HEX_SREG_PMUCFG =3D 58,
> +    HEX_SREG_S59 =3D 59,
> +    HEX_SREG_S60 =3D 60,
> +    HEX_SREG_S61 =3D 61,
> +    HEX_SREG_S62 =3D 62,
> +    HEX_SREG_S63 =3D 63,
> +};
>

Put these inside the #ifndef CONFIG_USER_ONLY (see #endif just above the
enum).


> +
>  #endif
> --
> 2.34.1
>
>

--0000000000007e7457064c23f358
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:36=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 ++<br>
=C2=A0target/hexagon/hex_regs.h | 115 +++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 120 insertions(+)<br>
<br>
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h<br>
index 9fd69c7453f..3619eaa1a52 100644<br>
--- a/target/hexagon/cpu.h<br>
+++ b/target/hexagon/cpu.h<br>
@@ -20,6 +20,11 @@<br>
<br>
=C2=A0#include &quot;fpu/softfloat-types.h&quot;<br>
<br>
+#define NUM_GREGS 32<br>
+#define GREG_WRITES_MAX 2<br>
+#define NUM_SREGS 64<br>
+#define SREG_WRITES_MAX 2<br>
+<br></blockquote><div><br></div><div>Guard with #ifndef CONFIG_USER_ONLY</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0#include &quot;cpu-qom.h&quot;<br>
=C2=A0#include &quot;exec/cpu-common.h&quot;<br>
=C2=A0#include &quot;exec/cpu-defs.h&quot;<br>
diff --git a/target/hexagon/hex_regs.h b/target/hexagon/hex_regs.h<br>
index bddfc28021c..ea8c62eba9c 100644<br>
--- a/target/hexagon/hex_regs.h<br>
+++ b/target/hexagon/hex_regs.h<br>
@@ -81,4 +81,119 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0HEX_REG_UTIMERHI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
63,<br>
=C2=A0};<br>
<br>
+#ifndef CONFIG_USER_ONLY<br>
+<br>
+#define HEX_GREG_VALUES \<br>
+=C2=A0 DECL_HEX_GREG(G0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00) \<br>
+=C2=A0 DECL_HEX_GREG(GELR,=C2=A0 =C2=A0 =C2=A0 =C2=A00) \<br>
+=C2=A0 DECL_HEX_GREG(G1,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01) \<br>
+=C2=A0 DECL_HEX_GREG(GSR,=C2=A0 =C2=A0 =C2=A0 =C2=A0 1) \<br>
+=C2=A0 DECL_HEX_GREG(G2,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02) \<br>
+=C2=A0 DECL_HEX_GREG(GOSP,=C2=A0 =C2=A0 =C2=A0 =C2=A02) \<br>
+=C2=A0 DECL_HEX_GREG(G3,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03) \<br>
+=C2=A0 DECL_HEX_GREG(GBADVA,=C2=A0 =C2=A0 =C2=A03) \<br>
+=C2=A0 DECL_HEX_GREG(GCYCLE_1T,=C2=A0 10) \<br>
+=C2=A0 DECL_HEX_GREG(GCYCLE_2T,=C2=A0 11) \<br>
+=C2=A0 DECL_HEX_GREG(GCYCLE_3T,=C2=A0 12) \<br>
+=C2=A0 DECL_HEX_GREG(GCYCLE_4T,=C2=A0 13) \<br>
+=C2=A0 DECL_HEX_GREG(GCYCLE_5T,=C2=A0 14) \<br>
+=C2=A0 DECL_HEX_GREG(GCYCLE_6T,=C2=A0 15) \<br>
+=C2=A0 DECL_HEX_GREG(GPMUCNT4,=C2=A0 =C2=A016) \<br>
+=C2=A0 DECL_HEX_GREG(GPMUCNT5,=C2=A0 =C2=A017) \<br>
+=C2=A0 DECL_HEX_GREG(GPMUCNT6,=C2=A0 =C2=A018) \<br>
+=C2=A0 DECL_HEX_GREG(GPMUCNT7,=C2=A0 =C2=A019) \<br>
+=C2=A0 DECL_HEX_GREG(GPCYCLELO,=C2=A0 24) \<br>
+=C2=A0 DECL_HEX_GREG(GPCYCLEHI,=C2=A0 25) \<br>
+=C2=A0 DECL_HEX_GREG(GPMUCNT0,=C2=A0 =C2=A026) \<br>
+=C2=A0 DECL_HEX_GREG(GPMUCNT1,=C2=A0 =C2=A027) \<br>
+=C2=A0 DECL_HEX_GREG(GPMUCNT2,=C2=A0 =C2=A028) \<br>
+=C2=A0 DECL_HEX_GREG(GPMUCNT3,=C2=A0 =C2=A029) \<br>
+=C2=A0 DECL_HEX_GREG_DONE<br>
+<br>
+#define DECL_HEX_GREG_DONE<br>
+#define DECL_HEX_GREG(name, val) HEX_GREG_ ##name =3D val,<br>
+enum hex_greg {<br>
+=C2=A0 =C2=A0 HEX_GREG_VALUES<br>
+};<br>
+#undef DECL_HEX_GREG<br>
+#undef DECL_HEX_GREG_DONE<br>
+<br>
+#define DECL_HEX_GREG_DONE 0<br>
+#define DECL_HEX_GREG(_, val) (1 &lt;&lt; val) |<br>
+static inline bool greg_implemented(enum hex_greg greg)<br>
+{<br>
+#if NUM_GREGS &gt; 32<br>
+#error &quot;NUM_GREGS too large for greg_implemented(): update `impl_bitm=
ap`&quot;<br>
+#endif<br>
+=C2=A0 =C2=A0 static int32_t impl_bitmap =3D HEX_GREG_VALUES;<br>
+=C2=A0 =C2=A0 return impl_bitmap &amp; (1 &lt;&lt; greg);<br>
+}<br>
+#undef DECL_HEX_GREG<br>
+#undef DECL_HEX_GREG_DONE<br>
+<br>
+#endif /* CONFIG_USER_ONLY */<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 HEX_SREG_SGP0 =3D 0,<br>
+=C2=A0 =C2=A0 HEX_SREG_SGP1 =3D 1,<br>
+=C2=A0 =C2=A0 HEX_SREG_STID =3D 2,<br>
+=C2=A0 =C2=A0 HEX_SREG_ELR =3D 3,<br>
+=C2=A0 =C2=A0 HEX_SREG_BADVA0 =3D 4,<br>
+=C2=A0 =C2=A0 HEX_SREG_BADVA1 =3D 5,<br>
+=C2=A0 =C2=A0 HEX_SREG_SSR =3D 6,<br>
+=C2=A0 =C2=A0 HEX_SREG_CCR =3D 7,<br>
+=C2=A0 =C2=A0 HEX_SREG_HTID =3D 8,<br>
+=C2=A0 =C2=A0 HEX_SREG_BADVA =3D 9,<br>
+=C2=A0 =C2=A0 HEX_SREG_IMASK =3D 10,<br>
+=C2=A0 =C2=A0 HEX_SREG_GEVB=C2=A0 =3D 11,<br>
+=C2=A0 =C2=A0 HEX_SREG_GLB_START =3D 16,<br>
+=C2=A0 =C2=A0 HEX_SREG_EVB =3D 16,<br>
+=C2=A0 =C2=A0 HEX_SREG_MODECTL =3D 17,<br>
+=C2=A0 =C2=A0 HEX_SREG_SYSCFG =3D 18,<br>
+=C2=A0 =C2=A0 HEX_SREG_IPENDAD =3D 20,<br>
+=C2=A0 =C2=A0 HEX_SREG_VID =3D 21,<br>
+=C2=A0 =C2=A0 HEX_SREG_VID1 =3D 22,<br>
+=C2=A0 =C2=A0 HEX_SREG_BESTWAIT =3D 23,<br>
+=C2=A0 =C2=A0 HEX_SREG_IEL =3D 24,<br>
+=C2=A0 =C2=A0 HEX_SREG_SCHEDCFG =3D 25,<br>
+=C2=A0 =C2=A0 HEX_SREG_IAHL =3D 26,<br>
+=C2=A0 =C2=A0 HEX_SREG_CFGBASE =3D 27,<br>
+=C2=A0 =C2=A0 HEX_SREG_DIAG =3D 28,<br>
+=C2=A0 =C2=A0 HEX_SREG_REV =3D 29,<br>
+=C2=A0 =C2=A0 HEX_SREG_PCYCLELO =3D 30,<br>
+=C2=A0 =C2=A0 HEX_SREG_PCYCLEHI =3D 31,<br>
+=C2=A0 =C2=A0 HEX_SREG_ISDBST =3D 32,<br>
+=C2=A0 =C2=A0 HEX_SREG_ISDBCFG0 =3D 33,<br>
+=C2=A0 =C2=A0 HEX_SREG_ISDBCFG1 =3D 34,<br>
+=C2=A0 =C2=A0 HEX_SREG_LIVELOCK =3D 35,<br>
+=C2=A0 =C2=A0 HEX_SREG_BRKPTPC0 =3D 36,<br>
+=C2=A0 =C2=A0 HEX_SREG_BRKPTCFG0 =3D 37,<br>
+=C2=A0 =C2=A0 HEX_SREG_BRKPTPC1 =3D 38,<br>
+=C2=A0 =C2=A0 HEX_SREG_BRKPTCFG1 =3D 39,<br>
+=C2=A0 =C2=A0 HEX_SREG_ISDBMBXIN =3D 40,<br>
+=C2=A0 =C2=A0 HEX_SREG_ISDBMBXOUT =3D 41,<br>
+=C2=A0 =C2=A0 HEX_SREG_ISDBEN =3D 42,<br>
+=C2=A0 =C2=A0 HEX_SREG_ISDBGPR =3D 43,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCNT4 =3D 44,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCNT5 =3D 45,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCNT6 =3D 46,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCNT7 =3D 47,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCNT0 =3D 48,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCNT1 =3D 49,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCNT2 =3D 50,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCNT3 =3D 51,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUEVTCFG =3D 52,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUSTID0 =3D 53,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUEVTCFG1 =3D 54,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUSTID1 =3D 55,<br>
+=C2=A0 =C2=A0 HEX_SREG_TIMERLO =3D 56,<br>
+=C2=A0 =C2=A0 HEX_SREG_TIMERHI =3D 57,<br>
+=C2=A0 =C2=A0 HEX_SREG_PMUCFG =3D 58,<br>
+=C2=A0 =C2=A0 HEX_SREG_S59 =3D 59,<br>
+=C2=A0 =C2=A0 HEX_SREG_S60 =3D 60,<br>
+=C2=A0 =C2=A0 HEX_SREG_S61 =3D 61,<br>
+=C2=A0 =C2=A0 HEX_SREG_S62 =3D 62,<br>
+=C2=A0 =C2=A0 HEX_SREG_S63 =3D 63,<br>
+};<br></blockquote><div><br></div><div>Put these inside the #ifndef CONFIG=
_USER_ONLY (see #endif just above the enum).</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0#endif<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--0000000000007e7457064c23f358--

