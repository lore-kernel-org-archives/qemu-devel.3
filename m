Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984D7D711C4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMZ5-0007Pl-N7; Thu, 18 Dec 2025 17:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vWMZ3-0007Pd-9k
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:33:42 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vWMZ1-0007Ad-K2
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:33:41 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b7636c96b9aso198748366b.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766097218; x=1766702018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZczxkJpVmvwQf1tEG3IUh8kARplGldX78CL6nGBVrPA=;
 b=P7l17N4q0grg+bKTNqYM3ohwsKb5EWUv7v5ot6sdB2EOZAHFdJItTwelFFDj/mQqh/
 /djov7jeNJxzKS6/fpZMIhS+b7iw4VM/+Craq+EHoZUtgKNKxGS3U4uwnnnlyBlLhmzq
 HEFQoX3Vj89jU1JYdVtHqa7aSFTLB2kW8S1x03BzUa2wKEpgIbOYdNSfoh5+CXnVvfQO
 QH7pFphRFuVj7Mv4/lG0QuIiVaHGKMclwjWzUsR7tJ+98jpMzUQv5a+ctLxU71evCQYD
 uXCSgQ3m8zwbkqOFDfNLQdrqrtv03CocZ8AwzlKFNlcSqvDGnBh2Eynzmd/YMSx3PoyG
 vslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766097218; x=1766702018;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZczxkJpVmvwQf1tEG3IUh8kARplGldX78CL6nGBVrPA=;
 b=LqYs+0gvQOa+VM1y824ubPP60F1XtCbg+Xa8Xbx9IkOTtqgYCUVbyXsAMO4D5znL1R
 5JwY6VuceSrCXJpkheVV3qoH6D2/RscOxTzqntzdl4LqTEUs/mW0TgsJYiy/sFotmgHi
 q/Qh15XgOlIFsEleQhSrmM8HAL0ElJW4liyTrAY11CdZfYUfxLJYHR0rjgiGBTQeV/QX
 2fKkljS3qGMEaC0rTxbhW/wFPkErSZBD1B8GwiYdN4P1ubQehOhhciZXr1LYrerodFaN
 lwg29WZ+zTGU+Sy3z0EhOImdjqr2ujdDh+k/MaOMaOMPIdy1qoEtlb6XEJECUPA4cUrm
 Easg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEgAZKQGS6yJs1kFN11Ctk3mDb7ig8QzV7gnz22Ii54JGE622EpiK3zxAuv273BFbzpe2q+BpvXIrC@nongnu.org
X-Gm-Message-State: AOJu0YxUoRE2wtAhgz5qARjsbfvr63nS5nJ4ryqx5E+2p+oftzz0p/Mt
 09vazXdgjnEWFmxgq3dnlH+VNaPs5vMN4Z+Dd3fj9vP+j/0I1sCxD2kH
X-Gm-Gg: AY/fxX64gbJufmCoKLpI+MZbSXWUSgNUz411dk+fAnCAkPuzaSeLW7xXwKF0rtYBhGc
 UoKdD7Q8ARkD0yJNTi/mbJGPF+Otqxxiq9WgjSUDNOKuSuqQrQfrPkZxc6oCwac8fefvL8TYEiS
 fr0mP3elJa4xeOITYE6MCVSd9MSGgyKTs8EPIiOuqeNYiRaj1MSldtzxzPdD1m34f916s+DVRds
 GlJ6s26rvMUYd1Och5ZV6m83S7GUzapLlQswoyo2ZScvG1Z3B+lovPX+gEMtqFdXOXWOfT1jequ
 ACE6Oxp8H3B990S4gfRCi55hCSH6BP8DwFFSrYZ3nNxXwkGbSnpNKVvMBgNeox7aG0YdRrl/mHu
 vuAFQkyhMhAU/6FW8ey7UuXPoD/IPrHdFnlZvkvNe3QX0R1ItvMuX5xtMBRLpibe+Bvp8ugKrVk
 lDfz1MWS5WLKB44izGos8yBPgBCnlAIEHHclRBqmXXei/QuuGxgBUZs2e7DuEIPp/m1wDsSw==
X-Google-Smtp-Source: AGHT+IEzV/bLu0JQ/JHZJ5mcfgurrexPOAnT/I/srwUc8Q6ZXHMS0t4CGknSxwCnY3A65d9OgxV2Ow==
X-Received: by 2002:a17:907:9691:b0:b80:2315:b4ca with SMTP id
 a640c23a62f3a-b80371f956fmr92256766b.46.1766097217407; 
 Thu, 18 Dec 2025 14:33:37 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-077-011-003-230.77.11.pool.telefonica.de. [77.11.3.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ad7de5sm58962066b.22.2025.12.18.14.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 14:33:36 -0800 (PST)
Date: Thu, 18 Dec 2025 22:33:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 2/6] hw/misc/imx6_ccm: Add PLL3 and CAN clock
In-Reply-To: <033163952bd2ccb3fcbdde1176d289f4df39c4b1.1765826753.git.matyas.bobek@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
 <033163952bd2ccb3fcbdde1176d289f4df39c4b1.1765826753.git.matyas.bobek@gmail.com>
Message-ID: <F2FD25A3-1277-400E-8EB9-D26E22F1BC57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 15=2E Dezember 2025 20:03:11 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <maty=
as=2Ebobek@gmail=2Ecom>:
>Add fixed frequency (480 MHz) PLL3, of which the FlexCAN
>clock is derived, and compute FlexCAN frequency based on
>divider configuration=2E
>
>Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>---
> hw/misc/imx6_ccm=2Ec         | 24 ++++++++++++++++++++++++
> hw/misc/trace-events       |  2 ++
> include/hw/misc/imx6_ccm=2Eh |  4 ++++
> include/hw/misc/imx_ccm=2Eh  |  1 +
> 4 files changed, 31 insertions(+)
>
>diff --git a/hw/misc/imx6_ccm=2Ec b/hw/misc/imx6_ccm=2Ec
>index a10b67d396=2E=2E45fdd0d5a8 100644
>--- a/hw/misc/imx6_ccm=2Ec
>+++ b/hw/misc/imx6_ccm=2Ec
>@@ -257,6 +257,15 @@ static uint64_t imx6_analog_get_pll2_clk(IMX6CCMStat=
e *dev)
>     return freq;
> }
>=20
>+static uint64_t imx6_analog_get_pll3_clk(IMX6CCMState *dev)
>+{
>+    uint64_t freq =3D 480000000;
>+
>+    trace_imx6_analog_get_pll3_clk(freq);
>+
>+    return freq;
>+}
>+
> static uint64_t imx6_analog_get_pll2_pfd0_clk(IMX6CCMState *dev)
> {
>     uint64_t freq =3D 0;
>@@ -344,6 +353,18 @@ static uint64_t imx6_ccm_get_per_clk(IMX6CCMState *d=
ev)
>     return freq;
> }
>=20
>+static uint64_t imx6_ccm_get_can_clk(IMX6CCMState *dev)
>+{
>+    uint64_t freq =3D 0;
>+
>+    freq =3D imx6_analog_get_pll3_clk(dev) / 8;
>+    freq /=3D (1 + EXTRACT(dev->ccm[CCM_CSCMR2], CAN_CLK_PODF));
>+
>+    trace_imx6_ccm_get_can_clk(freq);
>+
>+    return freq;
>+}
>+
> static uint32_t imx6_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk cl=
ock)
> {
>     uint32_t freq =3D 0;
>@@ -358,6 +379,9 @@ static uint32_t imx6_ccm_get_clock_frequency(IMXCCMSt=
ate *dev, IMXClk clock)
>     case CLK_IPG_HIGH:
>         freq =3D imx6_ccm_get_per_clk(s);
>         break;
>+    case CLK_CAN:
>+        freq =3D imx6_ccm_get_can_clk(s);
>+        break;
>     case CLK_32k:
>         freq =3D CKIL_FREQ;
>         break;
>diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>index eeb9243898=2E=2E7c4f1c45b8 100644
>--- a/hw/misc/trace-events
>+++ b/hw/misc/trace-events
>@@ -242,11 +242,13 @@ imx6_analog_get_periph_clk(uint32_t freq) "freq =3D=
 %u Hz"
> imx6_analog_get_pll2_clk(uint32_t freq) "freq =3D %u Hz"
> imx6_analog_get_pll2_pfd0_clk(uint32_t freq) "freq =3D %u Hz"
> imx6_analog_get_pll2_pfd2_clk(uint32_t freq) "freq =3D %u Hz"
>+imx6_analog_get_pll3_clk(uint32_t freq) "freq =3D %u Hz"
> imx6_analog_read(const char *reg, uint32_t value) "reg[%s] =3D> 0x%" PRI=
x32
> imx6_analog_write(const char *reg, uint32_t value) "reg[%s] <=3D 0x%" PR=
Ix32
> imx6_ccm_get_ahb_clk(uint32_t freq) "freq =3D %u Hz"
> imx6_ccm_get_ipg_clk(uint32_t freq) "freq =3D %u Hz"
> imx6_ccm_get_per_clk(uint32_t freq) "freq =3D %u Hz"
>+imx6_ccm_get_can_clk(uint32_t freq) "freq =3D %u Hz"
> imx6_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(Clock =3D =
%d) =3D %u"
> imx6_ccm_read(const char *reg, uint32_t value) "reg[%s] =3D> 0x%" PRIx32
> imx6_ccm_reset(void) ""
>diff --git a/include/hw/misc/imx6_ccm=2Eh b/include/hw/misc/imx6_ccm=2Eh
>index ccf46d7353=2E=2Ef498732727 100644
>--- a/include/hw/misc/imx6_ccm=2Eh
>+++ b/include/hw/misc/imx6_ccm=2Eh
>@@ -164,6 +164,10 @@
> #define PERCLK_PODF_SHIFT        (0)
> #define PERCLK_PODF_LENGTH       (6)
>=20
>+/* CCM_CSCMR2 */
>+#define CAN_CLK_PODF_SHIFT        (2)
>+#define CAN_CLK_PODF_LENGTH       (6)

Small nitpick: Alignment of the values is off by one compared to the other=
 defines=2E

With that fixed:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>+
> /* CCM_ANALOG_PFD_528 */
> #define PFD0_FRAC_SHIFT          (0)
> #define PFD0_FRAC_LENGTH         (6)
>diff --git a/include/hw/misc/imx_ccm=2Eh b/include/hw/misc/imx_ccm=2Eh
>index 7e5678e972=2E=2E9ce3adf332 100644
>--- a/include/hw/misc/imx_ccm=2Eh
>+++ b/include/hw/misc/imx_ccm=2Eh
>@@ -46,6 +46,7 @@ typedef enum  {
>     CLK_EXT,
>     CLK_HIGH_DIV,
>     CLK_HIGH,
>+    CLK_CAN,
> } IMXClk;
>=20
> struct IMXCCMClass {

