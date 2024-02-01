Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4440C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYWy-0002dq-Ix; Thu, 01 Feb 2024 09:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVYWq-0002cU-3L
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:59:03 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVYWm-0001c5-72
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:58:59 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso1310030a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 06:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706799531; x=1707404331; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PvE5C8HCEnxkanwInSxFVTeh2/qCg7CiB21pHrxsEPI=;
 b=a4yzwCf8fAEotaL625/dQp/7MlU94v0m8wns+gr5RS3Ib3o9SiLu+NQh/0MfrQzTcf
 s8599fPwFZxrWmE2xBCRUUn3oDH9bnF5sZ9n7fWLzHY/PT0RJ8PzgmH7ywIMbBrtyU2/
 v1lcnvxFfhIlivwr65MiQhD1+6ZwNN3wnaDLlermJj3HQAKUFohL0syDegepOreusveA
 bTrD7kycPENtUZWfXIPpWq3MqhcAAb/XSd9W+n5Q57KH0u1uIX8Lh7dikDxWhcJgTntD
 vSygSO3dF/RJvIKJorl1t92m6fbVhqCIFGMuXDyt2K7dIq2Knr84dXggZcoBHNnHirk4
 qP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706799531; x=1707404331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PvE5C8HCEnxkanwInSxFVTeh2/qCg7CiB21pHrxsEPI=;
 b=KqJPvyAEofq/FY3AEgTRn1Rg9+QeYa4gjCvX/zN2JKO5OI3VeM0a6TUOurMaHJo9Qw
 Ja0GiscNAaHdaxGXTEp+KsOQaJ2Gre+J4ZqjcxoDdGv/Ys3nhy8vhSrvu/RtXAUBOKvd
 NVKJo6SdcQh7YNGtK7ehMAJTapW2fZmqA7DrDeL3MogL76im/gnXtifV+s6jIUAwDSWk
 qqjluLaIOPzksMmXp3BM+nPAEphXGyZT5FsMbrSsRbdHYxhvsxDmFcmO19MjRvChBWci
 iZOiH0JmscVinTcod4TrjR8DW7a5UAXFBzoM2LonF0pQpqOSr+M4qWY7xR77RXNNU7oG
 WtEg==
X-Gm-Message-State: AOJu0Yza2mxWjsD5ZKQ1ykBarYMm/ysun+ozxPwZyAbxoDC+/WIt6c3t
 BTeAawRSFL+RDpxucZCPYHfIlTRttOEpGJCdqjSHJlb2BK8iWI1qVAF1gxCtWeBWV9cnMDq4TYQ
 /nRVuf1TKv5HopbvNBuIdgw0GzVQRaFxXhx6sYw==
X-Google-Smtp-Source: AGHT+IHKaLWTdGacQ13wdcXWmm+Lfcdmcl5wI29fl8p4uOIvPnSqXMAC7yX0tTLH/Mi/6DWyEScGM0VKOtFeBPkCUTo=
X-Received: by 2002:a50:ed91:0:b0:55f:4ce3:5988 with SMTP id
 h17-20020a50ed91000000b0055f4ce35988mr3263343edr.8.1706799531593; Thu, 01 Feb
 2024 06:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20240129060055.2616989-1-linux@roeck-us.net>
In-Reply-To: <20240129060055.2616989-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 14:58:40 +0000
Message-ID: <CAFEAcA-pOdoSdRPDc-cpKyoRq0s309zR_0osDaLJqcdy9iy+6w@mail.gmail.com>
Subject: Re: [PATCH] pci-host: designware: Limit value range of iATU viewport
 register
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Nikita Ostrenkov <n.ostrenkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 29 Jan 2024 at 06:00, Guenter Roeck <linux@roeck-us.net> wrote:
>
> The latest version of qemu (v8.2.0-869-g7a1dc45af5) crashes when booting
> the mcimx7d-sabre emulation with Linux v5.11 and later.
>
> qemu-system-arm: ../system/memory.c:2750: memory_region_set_alias_offset: Assertion `mr->alias' failed.
>
> Problem is that the Designware PCIe emulation accepts the full value range
> for the iATU Viewport Register. However, both hardware and emulation only
> support four inbound and four outbound viewports.
>
> The Linux kernel determines the number of supported viewports by writing
> 0xff into the viewport register and reading the value back. The expected
> value when reading the register is the highest supported viewport index.

This behaviour by the kernel seems to me to be out of spec.
Looking at the "i.MX6 6Dual/6Quad Applications Processor Referenc
Manual IMXDQRM" it says about the PCIE_PL_iATUVR register field
Region_Index: "Must not be set to a value greater than 3"
(there being 4 regions in this case).
Plus it says elsewhere that software "should" write all-0s to
reserved fields, and bits [7:4] are reserved in this register.

> Match that code by masking the supported viewport value range when the
> register is written. With this change, the Linux kernel reports
>
> imx6q-pcie 33800000.pcie: iATU: unroll F, 4 ob, 4 ib, align 0K, limit 4G
>
> as expected and supported.

However given this is presumably what the hardware does in this
case where the guest does something out of spec, and we definitely
need to do something to avoid asserting, we should take this patch.

>
> Fixes: d64e5eabc4c7 ("pci: Add support for Designware IP block")
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/pci-host/designware.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index dd9e389c07..c25d50f1c6 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -340,6 +340,8 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>          break;
>
>      case DESIGNWARE_PCIE_ATU_VIEWPORT:
> +        val &= DESIGNWARE_PCIE_ATU_REGION_INBOUND |
> +                (DESIGNWARE_PCIE_NUM_VIEWPORTS - 1);
>          root->atu_viewport = val;
>          break;

Applied to target-arm.next, thanks.

-- PMM

