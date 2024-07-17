Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C24FC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1jR-00079M-R0; Wed, 17 Jul 2024 06:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1jQ-00078k-D4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:17:56 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1jO-0003jx-Im
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:17:56 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52ed741fe46so3924825e87.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721211472; x=1721816272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0OVCQ7hPH/3bhdPYKZdar4hcfoDdohPJn5w5BoGoHfU=;
 b=VRFu6HLhXqs5HcTC9h0Qe2oCazdN09UAvXh4mTbbvuX93q3Am0c8KXjKHq3bkOQJzQ
 yIVvgd6bfFsoHYEj6vygUvwvfwd5gfxlXWWsvQhIIBfbPWYKo1oMX0On/NSxt88owOSy
 6+aGLIcnFt6o+HWSrg12Y2towx8xililUVr4QToGkWSjuf4x9wNGuDynYw2v3zIiClAw
 cVNLL3i8uJQrUC+/2eLRmm1OUztscQ9Xpri751W1CQ0MJIWASK7jntC/kuFBq8IQB7PN
 SPKtVydvxziILnr6swfM2KMolkj7q1qmgzXixPSyN4gRzJj5AkHnvMNdpTnsZfYbZtpT
 NkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721211472; x=1721816272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0OVCQ7hPH/3bhdPYKZdar4hcfoDdohPJn5w5BoGoHfU=;
 b=AVWzn/xM6JbebX/y7JWRKNDr/nJFjxMkPbEY0mqz27vXmWEOYBgJaWtxbanuAU4CZN
 c89rAKVyoS5YSveSR3+EgDbh1xK/qGDrx4Tdf0GtLNcKiCYgLWAngjdrZNwTwL3Y3js4
 H9UO2wqh+R3bSNjY3Zosd9+o1gG4ZhU/HZabcd8dzccFhL+SF2vBTmJQ3Q4HOsIsGbU8
 4O1vBNj3r1Fg72cd7Bz1cUmufRUByVMjIrqJe+T3Og0oMzAYVy5jQXxizgSlnQc8LjB0
 OjsBc0lOvqUH3XKR+ThvPY3ftRTK2Icw1f1AbTYFAdyyPdDLiMTAIAEhiIYGJ9r3i5Pm
 xBNQ==
X-Gm-Message-State: AOJu0Yz10jqLT69uZCvNp5H8kXKYa45KdAVEwESIGLZdeMMt8W1uzDvz
 O3zcw557F0jj+OXqBiTi00XNshIZ535vHGJWRffgKZs837vzawRAWQUgRGMQVNI=
X-Google-Smtp-Source: AGHT+IEjDxtQHQQWfcEDsbCETRQEa+SNXRCSeEuqTuqRrHwcA4RVaz2qUCkudd6oP2YSQhMigv7ZOw==
X-Received: by 2002:a05:6512:b8b:b0:52c:dbc2:ea1 with SMTP id
 2adb3069b0e04-52ee53ac96dmr884592e87.6.1721211472047; 
 Wed, 17 Jul 2024 03:17:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e77b0bsm163730925e9.1.2024.07.17.03.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:17:51 -0700 (PDT)
Message-ID: <d9abd976-2e1f-4d08-a923-8fe983ff5c70@linaro.org>
Date: Wed, 17 Jul 2024 12:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci-bridge: avoid linking a single downstream port
 more than once
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com
References: <20240717085621.55315-1-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717085621.55315-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Hi Yao,

On 17/7/24 10:56, Yao Xingtao via wrote:
> Since the downstream port is not checked, two slots can be linked to
> a single port. However, this can prevent the driver from detecting the
> device properly.
> 
> It is necessary to ensure that a downstream port is not linked more than
> once.
> 
> Links: https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> 
> ---
> V1[1] -> V2:
>   - Move downstream port check forward
> 
> [1] https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujitsu.com
> ---
>   hw/pci-bridge/cxl_downstream.c     | 5 +++++
>   hw/pci-bridge/pcie_root_port.c     | 5 +++++
>   hw/pci-bridge/xio3130_downstream.c | 5 +++++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 742da07a015a..af81ddfeec13 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -142,6 +142,11 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
>       MemoryRegion *component_bar = &cregs->component_registers;
>       int rc;
>   
> +    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
> +        error_setg(errp, "Can't link port, error %d", -EBUSY);
> +        return;

Could pcie_cap_slot_init() be a good place to check for that?

Otherwise IMHO we should add a helper in "hw/pci/pcie.h" and
call it here, not duplicate this code in each model.

> +    }
> +
>       pci_bridge_initfn(d, TYPE_PCIE_BUS);
>       pcie_port_init_reg(d);


