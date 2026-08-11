Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E04EC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnk1-0002LK-L0; Tue, 11 Aug 2026 10:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtnjz-0002Kt-4n
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:46:07 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtnjx-0003ZM-Dh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:46:06 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81e9f7491ffso43502687b3.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786459564; cv=none;
 d=google.com; s=arc-20260327;
 b=Kyf/7yUrZLhapTZ7Fet+wCv/ZuVENpEy1NszdzxhUeK4o+17QXViOh3W8kM0NJi3O0
 DIr3pXIRAFJQ7Pq2kRr3qe3pM0GWctZbWC/PpmhCBV5q6mEO/Id71SuEC61495t6lRf9
 Xk44ZeixxSXZVpQd1NXqjleu9pmWGLCT95E2vEfwXFtky2fVEgvvnpLd1V5Jl9+FWskz
 feIRy6bMNaqvBmk+h8g6UNvq0EySI/i7rKdpmZIPgeVrylqc74Gs4dN8fdn8kT1cJ0Tx
 fquoYHVXbXqoBpchfv1lmnfP6VE+oQE7H8smfQTzU7MaKoPponDRUf0ke6s3xRbM4fX0
 /u1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U363yjl95zUvpvGaT8oqi424jEa6U9SckoONTniyMnc=;
 fh=miNGedvR6G4phaqfPNhZVC1mw8LnDJgpl/iKh8V4IcA=;
 b=Hhu4pNrDNOuwEjvPZpnu0WwGe+FiqMS9lKnSlq3cCpSuzDwVGj1C6undIryaN291xK
 VkvSnEg19UzFwSQ+H0y3uRhDWG7LlFKNaWpkwL2Xf4rROPr0eXDaBvfFZpiHmyQYBLEj
 RJjThqleRV3wLmvsX0lzzztbNDuWeSRz9DWT84szan1k8ZhmFrzukuXdretBSJTe4TdV
 hj75CVnXL7aEwIrOs4DonoSpnKExKdRgSlAvK56KXh7xaYhMoiCRwwxRAXFvQYXLX/5h
 YMlj1izBmSRhqfVA6HZ/xJza27aev+uaJNVPpCOCZYjvgrjpPWq3x1rYaq1db5XLaNLm
 Vquw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786459564; x=1787064364; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U363yjl95zUvpvGaT8oqi424jEa6U9SckoONTniyMnc=;
 b=IalHogeE9RsTE99MmpCGzniC3uhG5K4vkZzPyXQLhn5FQ0RAPoeB1T5eEg7QM6KbXK
 +7pHMTVPs5llDkyaVqTXqnm+Zvbi3zH3xbsCIgfDnxYwoRRUJmTX+L2svNwLOylgLoKW
 slojcfeYFxOH0l8/a2F6wC4EnO5HqYTo0Zi4PfSsJRyn+H+xI3YwywDlSnsvIjkqPqZr
 tuG00+WFwFMaTBAVwCSe+O4+q/FvU6v8skuddjdZzcIK4ptApXMtmuN9355a4Un0BK4F
 qhclbd3a0Nziy1mh0NsjDVGM999utV0DEljy5LJH38DYpPHSo7i/A/Tz9Ss9b78MrsFj
 l9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786459564; x=1787064364;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U363yjl95zUvpvGaT8oqi424jEa6U9SckoONTniyMnc=;
 b=n/jNZINq/Z6CwYJpZ4P0GCexfALJTIVuwQlqhGslqyWE1FTf9kZZtgsUydqdVmpHN7
 ULNJZIJfCugpdEmfq2bKem0oXeSYkukE2EZNVXnBaLfwOk/Yni04/yh0G5E1CYDLtdw+
 3//HsMlmmeiZ5fbm0p5dOlw86UgqshIOUh29+6LlG/p96NDDbrL6qJHS8D74BAVv3TZd
 fNvFVu5dMUCslqNEYUJ8Xq3YOsbR2CfspiXq+xoKuCZ/p/AuJULCOs2124gGWiHrJY5g
 nYY4m7sEwjVn7VR5fWhY0eWHKt0een72Xb16iQbWETodTNy9wE6n3s3qvOIv/cqzP6ab
 KYLw==
X-Gm-Message-State: AOJu0YzZ+pT/JTvX9ZeXD+kHT127M7HVybHOaWtkM41tWgskK+j7J771
 ePl9uS9kUSLvyVGn92Bn95CofhlHHkelDPsou8E6XrHjxlz2WKOogg5rZ4eX4wXvRMXhJiP3qXn
 cOyLpEHwL2OoErg7bXQCiOQR69TruBFLITbFts2HJjHH6REumZUsUM5c=
X-Gm-Gg: AR+sD13VYtxInyEBXUyijNTURwIIvTdymnCSEoUkcGSqN1WkKYBNuHnm2mIt5n6rDX5
 JUdEUlLL0GnGb3vpTKhHSgc6J5B5HMy9W0Fc0hoorE1yM+gWJ8WZCI/u7Ew0s31vL/zFpX+pqZC
 Ae6nBPu42+rPdwNn4jg2TenVbojzCZDd5Ac5Ux0KZwNUNbbp631ar0BRI1wCZ8/Ake3ZjpJEYSg
 9/XFxfj0Xd4dctvi8yAK6fqjaXuPw6rWtLvfR07aC1yAtIlYFH+U0EdDoUkEeZanRyOcb1z8AAW
 DXdgLdQfoE3vFnhQxZMugdIF3oz6eMtEV/KqCWaYAHJTDCFd3YeCEo1Y+7+pCp3RV+EGNm4p5Ls
 fwtJSo3i9Hedjccy+/iolouqbsKzyTaUhnFsstdws
X-Received: by 2002:a05:690c:399:b0:81f:27f8:2de4 with SMTP id
 00721157ae682-8303d4d3d23mr5852507b3.8.1786459563424; Tue, 11 Aug 2026
 07:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260803193635.4153664-1-pmazzini@gmail.com>
In-Reply-To: <20260803193635.4153664-1-pmazzini@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 15:45:52 +0100
X-Gm-Features: AUfX_mzJDWbp3lU0a-Ayto9xlD3vtqLfKr1KfJ51dbm9AekNeJcS2ifw7Lz7GBg
Message-ID: <CAFEAcA8H0f6FjkQJJM=qp0CoXJCX1Ow81ac6v8V7xO-jpQzfEw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/imx6_ccm: add the i.MX6SLL variant
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: qemu-devel@nongnu.org, jcd@tribudubois.net, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 3 Aug 2026 at 20:36, Pablo Mazzini <pmazzini@gmail.com> wrote:
>
> The i.MX6SLL shares the i.MX6Q clock tree, but reports its own chip id
> in the ANATOP DIGPROG register and implements the PMU and XTALOSC24M
> registers that the i.MX6Q does not.
>
> Add TYPE_IMX6SLL_CCM as a subtype of TYPE_IMX6_CCM.  QOM runs the
> parent's instance_init first, so the subtype only has to override
> DIGPROG and widen the decoded ANALOG window to cover the extra
> registers; the i.MX6Q window is unchanged.

There's no user of this new type. We prefer patches adding new
devices to come in a patchset that includes support for whatever
their user is.

>
> DIGPROG is a hardwired chip identifier rather than a reset value, so
> move its default out of imx6_ccm_reset() and into imx6_ccm_init().
>
> The analog register array grows to cover the new registers.
>
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> ---
>  hw/misc/imx6_ccm.c         | 39 ++++++++++++++++++++++++++++++++++++--
>  include/hw/misc/imx6_ccm.h | 12 +++++++++++-
>  2 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
> index 45fdd0d5a8..6f48de5954 100644
> --- a/hw/misc/imx6_ccm.c
> +++ b/hw/misc/imx6_ccm.c
> @@ -223,6 +223,14 @@ static const char *imx6_analog_reg_name(uint32_t reg)
>          return "PMU_MISC1_TOG";
>      case USB_ANALOG_DIGPROG:
>          return "USB_ANALOG_DIGPROG";
> +    case PMU_LOW_PWR_CTRL:
> +        return "PMU_LOW_PWR_CTRL";
> +    case XTALOSC24M_OSC_CONFIG0:
> +        return "XTALOSC24M_OSC_CONFIG0";
> +    case XTALOSC24M_OSC_CONFIG1:
> +        return "XTALOSC24M_OSC_CONFIG1";
> +    case XTALOSC24M_OSC_CONFIG2:
> +        return "XTALOSC24M_OSC_CONFIG2";
>      default:
>          snprintf(unknown, sizeof(unknown), "%u ?", reg);
>          return unknown;
> @@ -237,7 +245,7 @@ static const VMStateDescription vmstate_imx6_ccm = {
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(ccm, IMX6CCMState, CCM_MAX),
> -        VMSTATE_UINT32_ARRAY(analog, IMX6CCMState, CCM_ANALOG_MAX),
> +        VMSTATE_UINT32_ARRAY(analog, IMX6CCMState, CCM_ANALOG_REGS),
>          VMSTATE_END_OF_LIST()
>      },
>  };

Adding new elements to a vmstate is a migration bump, and at
minimum needs the version ID numbers to be incremented.

In this case I would favour having the new register state
in a vmstate subsection so that we only migrate it for the new
device type, and the existing device's migration info doesn't change.

> @@ -474,7 +482,6 @@ static void imx6_ccm_reset(DeviceState *dev)
>      s->analog[USB_ANALOG_USB2_VBUS_DETECT] = 0x00000004;
>      s->analog[USB_ANALOG_USB2_CHRG_DETECT] = 0x00000000;
>      s->analog[USB_ANALOG_USB2_MISC] = 0x00000002;
> -    s->analog[USB_ANALOG_DIGPROG] = 0x00630000;
>
>      /* all PLLs need to be locked */
>      s->analog[CCM_ANALOG_PLL_ARM]   |= CCM_ANALOG_PLL_LOCK;
> @@ -763,6 +770,12 @@ static void imx6_ccm_init(Object *obj)
>      memory_region_add_subregion(&s->container, 0x4000, &s->ioanalog);
>
>      sysbus_init_mmio(sd, &s->container);
> +
> +    /*
> +     * DIGPROG is a hardwired chip identifier: it is not affected by reset.
> +     * Default to i.MX6Q; variants sharing this CCM override it below.
> +     */
> +    s->analog[USB_ANALOG_DIGPROG] = 0x00630000;
>  }
>
>  static void imx6_ccm_class_init(ObjectClass *klass, const void *data)
> @@ -777,6 +790,21 @@ static void imx6_ccm_class_init(ObjectClass *klass, const void *data)
>      ccm->get_clock_frequency = imx6_ccm_get_clock_frequency;
>  }
>
> +static void imx6sll_ccm_init(Object *obj)
> +{
> +    IMX6CCMState *s = IMX6_CCM(obj);
> +
> +    /*
> +     * Runs after imx6_ccm_init(), which installs the i.MX6Q default.  The
> +     * clock tree is the same; only the chip identifier differs:
> +     * MXC_CPU_IMX6SLL (0x67), revision 1.0.
> +     */
> +    s->analog[USB_ANALOG_DIGPROG] = 0x00670000;
> +
> +    /* Unlike the i.MX6Q, this one implements the PMU/XTALOSC24M registers. */
> +    memory_region_set_size(&s->ioanalog, CCM_ANALOG_REGS * sizeof(uint32_t));

memory_region_set_size() is really for MRs that dynamically change size,
not for fixing up a size that we could have got right in the first place.

I recommend that you add a class struct to the TYPE_IMX6_CCM, and give
that struct suitable fields that define how the subclasses differ (DIGPROG
reset value, whether XTALOSC24M registers are present, etc). In the class_init
function for each subclass you set those fields in the class struct. Then in
instance_init you can look at the class struct to see how big you should
make the MemoryRegion, and in reset you can look to see what reset value to
use, and so on.

hw/misc/npcm_gcr.c is an example of this approach.

thanks
-- PMM

