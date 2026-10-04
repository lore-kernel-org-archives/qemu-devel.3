Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7D3CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 03:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDD5l-0003G7-8V; Sat, 03 Oct 2026 23:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDD5j-0003FS-28
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 23:40:47 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDD5h-0005N2-6G
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 23:40:46 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ab3fd8adb1so5976647b3.1
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 20:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791085244; cv=none;
 d=google.com; s=arc-20260327;
 b=NVHsKGQ8h2ogu8BkjjLbj+PrA7LV+389SnAb4ErxQjpnm0fj3NIV6KQ14VZMa5FP7X
 hAeuzVrZjdnHAFZXNZ/GjoQYzyf/8ezRSWZ75QqvHaK/A0M11QOsFiELx0UIjLnk4BnQ
 q7FKPRh4uQE7GG1JGym9Y+FgQo4GPJ8PHPBUHSDucx5OamAqywDPDjotg8BOKFnA5ssK
 Hg5hIg3AqgHCVhoPtniWAY38r5iMTX9OOvHEP3910bI5eWyDOzWk9dvjJWFxXGJxfcMp
 z2G9AhBH7D6QrFTmKApr21nKu9/QXcP3GiPZBPZFG9XXEA2fxTyfWOLLrJbzoWMbmBt7
 /XNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9RqZkDpOL7Jhqyac9A34FP7Iwk84dMoFYwUChYXMwVI=;
 fh=2omqo1irkH1WVe6de1a4y+Wi0w/xKd08HbE/1su/X2E=;
 b=m1eSLUnlJYpnHKBRJekebX0e+eshu1ZqCJ5kDxe9QN0T8VPGqI0aD460yg3ykr5lbE
 F6TfZfVRxfG4A4zrtDKatKfGik9w1Jq/QUjyfBlxEY3l92CuE3To49KYr5dR6WYVX1D3
 SWBgW5wTo0Mv/MccJBLUsltGUYx4j6kq64H8p/GUIXyoVgaqjzXV1vFNn9S/At3xjcCs
 SgukSzoPgnyQ9lHTrOSR60rFShHXqQ1zPzeJDapXAxMeUInZOrnvf5ZrAbHElAfi9dXe
 RsjGfb6t9+jXdO1urSHyvi7vOTIgTRcB57YF8aa9xXtq/RfcmpR6IwxcZiOwb7A8jGYf
 OGTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791085244; x=1791690044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9RqZkDpOL7Jhqyac9A34FP7Iwk84dMoFYwUChYXMwVI=;
 b=jNx3JRcZlFCgMI0aZdSyR6B2i2jaUI3Ms+sSFmegAt8Ffj34B+nZCaop7svLq9ervH
 tGvj2MnEAViS3QOyBwVcNXwSBnk/aLvzDiEyc96qUXMhHDSuAA3LzW4KrEIFTndVw53Q
 XILNHN4217mkx3Ov15NR/AFXHywyX6EwNo/3BMCEnGsAzyIzhnw74IrtY49DnNinxiJd
 S26Sf5ms7sbuK2M+dd0FjmyaA5zrOedGEBmxdvhqT2J3aj5tZMq9QZEjXPzQi+0HU5Jv
 S0QMD/986mfjBN3RKFtEF1kXam2+texi12M63zFTGxCYVz7xAEIWASHtwVbqNrZJsetW
 5M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791085244; x=1791690044;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9RqZkDpOL7Jhqyac9A34FP7Iwk84dMoFYwUChYXMwVI=;
 b=hKT1/+z3NMyFAPK0LEUDAk6pUDhRyVjfSaUG8PwkNIZv9a2qr12xhki1vHvbIsQ+CB
 QvCLFiV5up8UrNXe74k2TEr9rsrdzwL5aic6Z3DK8M05nA4NVMoN3FVBACfy56WPGQxb
 +hV5SWmnf3SwRg3//8JTinFrPElEJvyC87/vkiaCWaduX+MZ12Y/tliPFWGsV3onjOuB
 fePPWYLvFFcpi4z5hneuTrpqVnlGNjiuy3PBu625AmzPMb0ibzkvuva/HQM0fyQ/6o4x
 ivZRd37ftVZElcFBSCFCeztKx+PwFj9S3i7ZA4XzW+rdLFIRUhdbHC5fSnZUkGe/PKS3
 +nJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6VHjZsqd+oNSHgQmzjz8FpFNnZgUrS1N5xwWbLLXXCRGT4dfqSATODklfWR5s9y5G808MMEgcYQyX@nongnu.org
X-Gm-Message-State: AFq9FYKpxwntG9D7BhLocLr+MHb1WsBzrnO6jCe9+yEyJRTQD2b3+Od5
 +DOdDfGqc+LUBsMHM3GUT2+tX2S8KYqtXX/68+U9Xp0jSOKPgQjmdXPeS8iCoySnVEPU0aiMse9
 R+GvRGXlZRrlBjnP3n/jDr6yCZkSrUow=
X-Gm-Gg: AYBFou2u3d5pb4P6736H3oMfxSsJwNz6ACLhAskphfpYpgKdmbUzpXFKelovWlFUqZG
 /CupfPSpU489k5T/tuXSNz8EAvAP3dCvmepXTJg3dB9srQ6Fo8g7wq+LBzOJfbRGpkBFNxwyVxX
 s9rEb2bZ5lDN2u7tu9tucCnSNxDtidkIdSQdyWRoODt6cBsaMjoWltaWlNKQXqbXzQ6I8j51UEo
 2nI4JQaPbbrYFuVt/l/yyMtmgRSaO78HFLJTNyZm2e13HgE22J3e9Gmi2kBtJz7ftLf6d2Hn3D3
 KqMpmmDqI4uHXcSYjTbbZkxsmro6XhLc4/Qhbia1MyYwBJCbrkotMv415yWWqB7h9fYPMY+Zmg0
 I7cxjaFc0JFgLDfH9jUDdGI2rpA==
X-Received: by 2002:a05:690c:39a:b0:89a:63da:faa1 with SMTP id
 00721157ae682-8ae95b38df2mr15327757b3.92.1791085243809; Sat, 03 Oct 2026
 20:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-7-bin.meng@processmission.com>
 <5F11A2B8-4459-4621-8CDB-CEEE85D83F96@gmail.com>
In-Reply-To: <5F11A2B8-4459-4621-8CDB-CEEE85D83F96@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 11:40:31 +0800
X-Gm-Features: AclHuK_HfSHD6vubhrr25iISBG82AOBv24CyXaTFAdOpG35_2Ss0IHSIB0QGI0s
Message-ID: <CAEUhbmXn2xQzXmJ+M1JNVTcx70RwkRM_FaL8RQnoV_wcXX5_7g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
To: Bernhard Beschow <shentey@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 22, 2026 at 1:33=E2=80=AFAM Bernhard Beschow <shentey@gmail.com=
> wrote:
>
>
>
> Am 4. September 2026 16:14:29 UTC schrieb Bin Meng <bin.meng@processmissi=
on.com>:
> >U-Boot's i.MX uSDHC driver enables IPGEN, HCKEN, PEREN and CKEN in
> >VEND_SPEC rather than the standard SDHCI clock-control fields. QEMU
> >only checks the standard fields before issuing a command. It therefore
> >silently drops U-Boot's MMC commands even though the controller clocks
> >are enabled. U-Boot eventually times out waiting for command completion
> >and cannot load the kernel and device tree from the SD card.
> >
> >Accept the complete vendor clock-gate set as another valid clock source
> >for i.MX uSDHC. Also report SDSTB when the vendor IP and host clocks
> >are enabled, matching the state U-Boot polls while changing the clock.
> >
> >Keep this behavior behind an i.MX uSDHC quirk because the shared eSDHC
> >paths also serve controllers which use the standard SDHCI fields.
> >
> >Reference: IMX6ULRM (Rev 2), section 56.8.10, 56.8.12 and 56.8.26
> >https://www.nxp.com/webapp/Download?colCode=3DIMX6ULRM
> >
> >Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >
> >---
> >
> >Changes in v2:
> >- rebase on top of the microchip polarfire soc series
> >
> > include/hw/sd/sdhci.h |  7 ++++++-
> > hw/sd/sdhci.c         | 27 ++++++++++++++++++++++++---
> > 2 files changed, 30 insertions(+), 4 deletions(-)
> >
> >diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> >index 2d03e37653..83d465774b 100644
> >--- a/include/hw/sd/sdhci.h
> >+++ b/include/hw/sd/sdhci.h
> >@@ -112,7 +112,12 @@ typedef struct SDHCIState SDHCIState;
> >  * Controller does not provide transfer-complete interrupt when not
> >  * busy.
> >  */
> >-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(0)
> >+#define SDHCI_QUIRK_NO_BUSY_IRQ          BIT(0)
> >+/*
> >+ * Controller uses vendor-specific clock gates in place of the standard
> >+ * SDHCI clock-control fields
> >+ */
> >+#define SDHCI_QUIRK_CLOCKS_IN_VENDOR     BIT(1)
> >
> > #define TYPE_PCI_SDHCI "sdhci-pci"
> > DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
> >diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> >index 14c312a691..b6e447a805 100644
> >--- a/hw/sd/sdhci.c
> >+++ b/hw/sd/sdhci.c
> >@@ -1107,9 +1107,11 @@ static void sdhci_data_transfer(SDHCIState *s)
> >     }
> > }
> >
> >+static bool sdhci_clocks_on(SDHCIState *s);
> >+
> > static bool sdhci_can_issue_command(SDHCIState *s)
> > {
> >-    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
> >+    if (!sdhci_clocks_on(s) ||
> >         (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
> >         ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
> >         ((s->cmdreg & SDHC_CMD_RESPONSE) =3D=3D SDHC_CMD_RSP_WITH_BUSY =
&&
> >@@ -1810,6 +1812,10 @@ static void sdhci_bus_class_init(ObjectClass *kla=
ss, const void *data)
> >
> > #define ESDHC_VENDOR_SPEC               0xc0
> > #define ESDHC_FRC_SDCLK_ON              (1 << 8)
> >+#define ESDHC_VENDOR_IPGEN              (1 << 11)
> >+#define ESDHC_VENDOR_HCKEN              (1 << 12)
> >+#define ESDHC_VENDOR_PEREN              (1 << 13)
> >+#define ESDHC_VENDOR_CKEN               (1 << 14)
> >
> > #define ESDHC_DLL_CTRL                  0x60
> >
> >@@ -1826,6 +1832,16 @@ static void sdhci_bus_class_init(ObjectClass *kla=
ss, const void *data)
> > #define ESDHC_PRNSTS_SDSTB              (1 << 3)
> > #define ESDHC_PRNSTS_CLOCK_GATE_OFF     BIT(7)
> >
> >+static bool sdhci_clocks_on(SDHCIState *s)
> >+{
> >+    uint32_t vendor_clocks =3D ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN =
|
> >+                             ESDHC_VENDOR_PEREN | ESDHC_VENDOR_CKEN;
> >+
> >+    return SDHC_CLOCK_IS_ON(s->clkcon) ||
> >+           ((s->quirks & SDHCI_QUIRK_CLOCKS_IN_VENDOR) &&
> >+            (s->vendor_spec & vendor_clocks) =3D=3D vendor_clocks);
> >+}
> >+
>
> Rather than accumulating vendor-specific quirks in generic code, can we n=
ot remap in device-specific "virtual" methods such as usdhc_{read,write}?
>

Will do in v3.

Regards,
Bin

