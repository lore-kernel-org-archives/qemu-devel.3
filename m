Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C88ECA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDNn3-0001Bl-PH; Sun, 04 Oct 2026 11:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDNn2-0001BO-Co
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:06:12 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDNn0-0004YN-Rg
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:06:12 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-67568357b63so644814d50.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791126369; cv=none;
 d=google.com; s=arc-20260327;
 b=gsV0yIg41GPFwYC3NeaiDMH0JEpJ9wkOcMB9jxyDyO8jRyC0x8Rn5S9irSpzEttjwW
 UqG0qaXDGdX50giC/X7XVptNBRgpwQyTMZRy3d+PR1VodLX2+OyL6knCAmiM2+9MD32W
 4lVzdIv/ifOhFEuciyIlJbABnb44uKMGgg2ww56IXK7gKAK7Y3Hromyd9t0SZGuTbqNs
 /9kS04KC+aqlezvwlMSG6JMEG0OhrurezG5tu1HneF67TW2pbUpbyerPuRHE+fQTt8SS
 9aNKkWh9Q4r3vpGiAtdiad9beQPPZlQ+4+5VOym3fDawT4H5noTdtc08Pq8ZZ88IrUeA
 sAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DESbJWfMCbJ8bw2F615znrlmfU4/iUDeoDkDoUisMCM=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=O3gmlKqEeNRnL/FUjjLkw+8HxM2CqXEHl0ZkMLMtM+XcbUJkCzMti7IITIiGzjFWVk
 q4LnbYgW4/GOn6I3Uhn1YIhZ4QRLQJRoAgA7AKxwZ9EYEOl7pdzSkZ1AHOnwpZNhtnI4
 Lx7FsnGgS28mDK6lWk4iyv72g5qhxyEhgxBtFF9m1/KSi9oWQhRrkF7b/KAhn7h08YhY
 TLMWoBaNFMcEJkvEo0RyzVD7k/Y6un24Zs5EBnb2WKjPW7k4BcV7lV9msKbhWpZClpdp
 zdbnc8BQDsdJMw9kflztr/Cpz9xw6OOfhu8fv30OvtTk3GZ2PWK9+RCgly0FQgkULBxW
 qAog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791126369; x=1791731169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DESbJWfMCbJ8bw2F615znrlmfU4/iUDeoDkDoUisMCM=;
 b=YRQ28PFtL2ZouZgEafO0YQBfWt6B8xfEusgs/uWWJsnocOwUT0fQ8CEb1fFwEq7K4x
 8pXMd6nPdozSNWCge/3nLum3WpBdOabbmssaPF81AS2LHylkg101li/fUWGZiPFtWm5V
 z8QQ2pmp1FfB72vqFlmVpoB4T8VkxYJ0XQSJUa/VPOgxfXTmlWKTCO/XkGyGxiq8fygT
 B0BuHjPsrKy0usZTmiv92H1cq7Z3Ur/sIathaMfMm9LrGY94UQjqiGesg8HproFhvhHf
 Zt/Z5Xlv2W2jI47OcCeUqyx1szUvmQCDXywR5/fOIeJkyz/0x1Ae+S6hG4AePx20P89S
 qIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791126369; x=1791731169;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DESbJWfMCbJ8bw2F615znrlmfU4/iUDeoDkDoUisMCM=;
 b=IcBJwDaZdHOZiugTvUdmFK0HkYhYRfYMB5URUmWWQT9nbN1DNHBsxilD8+lr6Nff8N
 7eISYaL53hO2T2NqJu6FJPQ/EmVDbi7Rv9AosI2IJFJZUKKP88hjOXYrMalj0WE6WPLt
 fFZkU6WAhK4cfIm/bJuhgeJA48l/qjyJ4kVpcxtkYonvt+/fESC0GcKC7MVNpbtkrsNf
 y1i5gh/bR4WRKO5CgDgGX8f30vt6WNXkdxNnlU8clp6AztW2QL/49y66GqFwg7+3nPDS
 IBotneBHlKGwY3jbdkjAWpHEunPgK0IxP4JPnH+iYja/nKwVCTMOQb2i+O+lHmVBULlQ
 1KDA==
X-Gm-Message-State: AFq9FYIFtVKidozV3ZyYQTZomOAL/oNFeRN3W9xyxBeyneAJtMcP9Au/
 6VR9WqLkoBooCNTm1YMOrjcI5dWeo0VZvuKP7dM+E5MRlSQCSrwHsfDvpt2uIOIsoxY3ThHX4aJ
 a7SSt8FlPp1Z7gJNz9XIO1O88X3Y02pQ=
X-Gm-Gg: AYBFou1LmbIHBFBBKPFM9Cew7ZRu3WgO5mUpBb/AMECLcx2lZB05z+MBAFY7WmW66q+
 XPqXs4hFy6IMXTQzpTP66XNwg98mwW4XIqSYt9w2mznaUuvyNsC6n80nhS7ofUiEk0DBXWHFdza
 PhwutlXJSwnt6p3yN8Ehu8c9UaW5ERVy022L2phnx3JRWQAxkxDrVafoqIhE2Sxre/vOhhO6HZs
 QpNgmFE07tKAMwYIdpuiKxXpnw6YK+Mi4b3MmHErHCJiHJyt1RPREURfaCqkAZRVqONPRqueWyw
 S6n9utdc8PtaIBo/vwXEkPZFoFxdR2x/XgpP3RRBK5iwcUzv92RQtU/Ve5Yx9BF4zSTd54gkFKe
 pWbNKtH4PWuMxcbMA
X-Received: by 2002:a05:690c:c4fa:b0:8ac:cbaa:1704 with SMTP id
 00721157ae682-8ae397b978emr37493777b3.25.1791126369202; Sun, 04 Oct 2026
 08:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-2-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-2-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:05:57 +0800
X-Gm-Features: AclHuK_1ST8KK46y8o7-ffyxMprK-cbAlbGxlXc2kGxi0QssLTlVIkGBJdI2nXs
Message-ID: <CAEUhbmW58ikRLMr0+O2hpmTvnUko7+vWF6CuJBMejXFX3gFBsQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] hw/watchdog/wdt_imx2: Fix handling of write-once
 WCR bits
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0c.google.com
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

Hi Bernhard,

On Sun, Oct 4, 2026 at 8:29=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Guests such as u-boot may experience inadvertant reboots when configuring
> the WCR register. Apparently there is a typo in the WCR locked bits
> handling: The locked values for s->wcr must come from itself rather than
> from s->wicr, so fix that.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/watchdog/wdt_imx2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
> index c83d4107c1..3283990bbf 100644
> --- a/hw/watchdog/wdt_imx2.c
> +++ b/hw/watchdog/wdt_imx2.c
> @@ -156,18 +156,18 @@ static void imx2_wdt_write(void *opaque, hwaddr add=
r,
>      case IMX2_WDT_WCR:
>          if (s->wcr_locked) {
>              value &=3D ~IMX2_WDT_WCR_LOCK_MASK;
> -            value |=3D (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
> +            value |=3D (s->wcr & IMX2_WDT_WCR_LOCK_MASK);

I see this patch has qemu-stable cc'ed, so it shall be a complete fix
instead of a partial one that relies one another patch (in this case,
patch 03 in this series).

So patch 1 corrects the source register from s->wicr to s->wcr, but
the WDE and WDT branches still use inverted masks:

>    s->wcr & ~IMX2_WDT_WCR_WDE
>    s->wcr & ~IMX2_WDT_WCR_WDT

These preserve all the other bits rather than the locked bit, which is
apparently wrong.

Patch 3 fixes this as part of removing the redundant lock flags, but
not marked as qemu-stable intentionally. When applying patch 1 & 3
together on QEMU master, this issue is fixed correctly, but not for
stable.

Could you fix the WDE/WDT masks in patch 1, leaving patch 3 to remove
the redundant flags and migration fields? That would make the stable
fixes work correctly without depending on patch 3.

>          }
>          s->wcr_locked =3D true;
>          if (s->wcr_wde_locked) {
>              value &=3D ~IMX2_WDT_WCR_WDE;
> -            value |=3D (s->wicr & ~IMX2_WDT_WCR_WDE);
> +            value |=3D (s->wcr & ~IMX2_WDT_WCR_WDE);
>          } else if (value & IMX2_WDT_WCR_WDE) {
>              s->wcr_wde_locked =3D true;
>          }
>          if (s->wcr_wdt_locked) {
>              value &=3D ~IMX2_WDT_WCR_WDT;
> -            value |=3D (s->wicr & ~IMX2_WDT_WCR_WDT);
> +            value |=3D (s->wcr & ~IMX2_WDT_WCR_WDT);
>          } else if (value & IMX2_WDT_WCR_WDT) {
>              s->wcr_wdt_locked =3D true;
>          }
> --

Regards,
Bin

