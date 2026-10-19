Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65074CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjdM-0003Ha-1Z; Mon, 19 Oct 2026 05:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjdH-00038V-BX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:26:15 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjdF-0003Ah-Lw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:26:15 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso10315967b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401972; cv=none;
 d=google.com; s=arc-20260327;
 b=SeudOgg+aF6oqkaSF+FDMQXXbIG8eDO8ZN8kk1SMPUsuANz8gIe0aAmRiihJtQE64K
 itsfazKZzxihupHCxp3K0Eap0bOXHdraVWaYAjFor2fBRdd1nR9sj4HnKX4hFrVD2WaP
 YsRZkZSB8Gd/J7bMKjnHfeq9xM91tfJn37e3lubPCgCCehsayi9flCZ/MipyvTzoW4Ky
 cGV0avjGvQWQVgC/QkUJrHnfQyVQHIsLIPtYETCwzp898gYRIPQ/74GSNH4uG/Afi1lz
 VRsO6ZF4GJqC65qs7C9ezqknxDquHAGU0iEgSagNHAqcs+RKpAmQNn5GE3pn2Tn0Za43
 ZzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K+sUOHqMJuWYC1Gv3HZka1+w61ATk4ITWajchGwQUUM=;
 fh=6B8wxvcWtPThAzGDfNPEzgTJhUSkOAHXvdJq+x337uk=;
 b=BazTGh7RsH+PBQWhv9uKVTldXIqVTAm5vCO8Sibm+EjYcuyqrnPdPlNqD+PXN9/hqh
 DcTnIAEyYfISwAPCQRYzhuWQ04SZoms7FF1k7FNyqAY0i+T478phfeG8d0Vd+YfoF8op
 SBAuHt5iNezxftVYA1PHZ5Per6m1LxIc8UmQf7o5X8Fqn9f+iNpt3n0EWZfpWr87t1xP
 jAFqeJ+1z6o+/RygfwD+CfrGwA8lahFUjTWkGB1MAOSVl42IM/l08WcZi4fpkun1yuWB
 x40KSUUXJkkAJ/Jn9bWOEBFUznyLd5UDwBTcJQrbfGySDcwDclFLgQ2INozBi0ct0T1J
 ixfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792401972; x=1793006772; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K+sUOHqMJuWYC1Gv3HZka1+w61ATk4ITWajchGwQUUM=;
 b=WmCy4zz2sCTftSbAX0Mg7ezF6i4IpEEbaDXvg7+2Ugzrwd8y24oAY2U634UrTo4nUM
 APy5hBK3d8wWqnuRfLxYe8h3jygFs/jF2sFs925yXPTvsm2Qo5glrOxdAxsk0e7Pi74w
 ttUes1JM/NsFCGQbZ/oiUU2Zp1YobShnwRjkhlbPNZ8J2Ysn1Z2Ph/4TIYBOzOC3D6z5
 kxHJAX2qnNNukgPMYQUs1PEh3GznYYMrT563uWcdR5PlJ8P2qXBjXxOOh+SsS0JgvciW
 zbYgWYmUmB2rFf1/5BRBsMqDuQW7jVkYXqlBmVPTokfSA9SeV+fKU0LqhKr8XHAn8Mkf
 02DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401972; x=1793006772;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K+sUOHqMJuWYC1Gv3HZka1+w61ATk4ITWajchGwQUUM=;
 b=eSEXB7gJesxFn2r14ff7vkcBgrAy3YdPcvoGVwhUkr1HPDWnIuXHVv0jb4sFbhPCri
 WCSSk09F15eVt9eFb/gwU5DwTBCoFT8GarE9hcj5pS5qbCKG8HqaTuOytNG5eva9SShr
 Mh4JrGQOJjbPvRFpM4p9/u9rgQipwqJAn/E68QCBmPBkQhGrgVVI2KJz273ukdBpki01
 rhcm8Eq8FSBfYzUXuoI6ag5j67X5jvbzu3gr8lKUhAF/Lv2uaOwrFENm9skCHMCUdv6G
 O6TnGbGMo0p6Lg/X6s1peG0jmKCqNS/n7YYWdk4+Z1BB5eAe91V9czzTiLF3bLdHJIFI
 V1zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0pXvWCwOcNRyo/RaMPmPRvkJtUyEBYiVsBUwgpsxHuvF5PYVS1lBlbzsA9IZZS4ptWGfG+U0v2buP@nongnu.org
X-Gm-Message-State: AFq9FYJJcIfqMONnaceIE4HLADhk+EGt6RV7q0WdBdcu/9I7feDFPPNm
 uq2dOy8KuXHl6Hdm2ZMgd/f9v8szws33K2amRrunifPqn3AJHb/EJugOznLBVi3P4s3QOI4JDTZ
 2zE3BD8XW4miO0eDWS/1GOTjKyOQmnTgVekV8g9WNsw==
X-Gm-Gg: AYBFou0diQ+c4KgLWSZLftyU4Il0TOs0wMDfkp64dTjvBpJsznVKyY61uMw8e6n492H
 OhLYgLh2W/bx2tvpm1R2cHzDvUzUBAvDWRRCCmaJ3b/tjV5Agk1QthEyD2l+jB19+Ks6Z7dhz7z
 rg3m8SRlxvDXjP8OlGLdNg3FMerEzs1Jano1SRVGRYhVokFMtZy2Y7iAxgTq1FXl43bqsIAwYqI
 FU8gnrrlDEx1f+3yoijUm5X4FpsPP81V8JCChnY1qKEqBDeYjFM3KrdGYRTXmGEbfV3n/k+DHN6
 M0BdBO9EIHshhFvvqsTTxuACcNhagJrsRZRv8uigy7QgLiDmW4DU0fXHzMHa4oHFyjncweyDr7L
 5A+JyfdQFPtA+X8z/w0k0a9L1MuOyuPphpBE8NvoCzlJyWCWJTA==
X-Received: by 2002:a05:690c:c507:b0:8b0:ad62:19ca with SMTP id
 00721157ae682-8b0f2142987mr23530427b3.15.1792401972098; Mon, 19 Oct 2026
 02:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20261019024441.3554329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261019024441.3554329-1-jamin_lin@aspeedtech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 10:25:58 +0100
X-Gm-Features: AclHuK_cQ1YYp4Z2U_eo2-jzA9kk8--xLfqa3f7PuAFhRmf9jupm1MaOgm2SnJ0
Message-ID: <CAFEAcA8fpUjzHCW=36_P_t=P7RLa7XN1xKJwJgaTdPywcK3rtw@mail.gmail.com>
Subject: Re: [PATCH v1] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "marcelomanzo@gmail.com" <marcelomanzo@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 19 Oct 2026 at 03:44, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
>
> Setting msi_nonbroken in class_init() affects all machine types,
> even when the ASPEED PCIe controller is not used.
>
> Move msi_nonbroken to realize() to ensure it is only set when
> the ASPEED PCIe controller is realized.
>
> Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>
> Fixes: f002aa35f3205d55bbe4a68670ba19a6dcf1d6a8 ("hw/pci-host/aspeed: Add AST2600 PCIe config space and host bridge")
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

This should also be

Cc: qemu-stable@nongnu.org

> ---
>  hw/pci-host/aspeed_pcie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index b46eb74234..ceb010f213 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -181,6 +181,8 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
>      g_autofree char *dram_alias_name = NULL;
>      g_autofree char *root_bus_name = NULL;
>
> +    msi_nonbroken = true;
> +
>      /* PCI configuration space */
>      pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
>      sysbus_init_mmio(sbd, &pex->mmio);
> @@ -294,8 +296,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
>
>      hc->root_bus_path = aspeed_pcie_rc_root_bus_path;
>      device_class_set_props(dc, aspeed_pcie_rc_props);
> -
> -    msi_nonbroken = true;
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

