Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F004C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSnd-0002dm-9J; Fri, 07 Feb 2025 13:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tgSna-0002c1-S9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:09:54 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tgSnZ-0002dk-1M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:09:54 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-21ddab8800bso34944485ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738951791; x=1739556591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nNuHt3rg2ARFf37Gdiorrl7LW3Mcz7UcHzzmf15QxsU=;
 b=fvmvtQFHpQnlXBovMLjrsa04dImn8L2iEo9+aKy8R28a3K94Q+ULM0OKrJYTLCCHpp
 SJt73COvSXHt1KWBqtgfbu1gPK/S8ZHVmo83yr/r8vfSRGvD4+IBuWBaDvruU535I/zn
 FJPSJaczZpSTmZDow+mFGx6tXrs1hr11grlQH/+5X8UEGsdg31JU6IhE5m/njog02Uu3
 JrIdN36MFCPEYxZiLAO0rrJz0MtUNDY0STOOpJIYb2Bvg3jLB6OT2UXkfhTa+wwAZk4U
 41CIafYMspkY2CWeZ80mcBYpxLoyDol/vxGq/JwZMOz5C9v+mp1JOOHoa6oI/cLZnw67
 drUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738951791; x=1739556591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nNuHt3rg2ARFf37Gdiorrl7LW3Mcz7UcHzzmf15QxsU=;
 b=q6U9xGU+mYonqKpurt49heKZs9q4O3ajLSQews2WMzP4HUL71e6vNoC2EGEK9ynvom
 xrdYuxKtHanWsM7Q1+gT+i4avWaKAHXYWRlebHbEwRcSy+ZiGyqgnaSnOE26RcX3Lyga
 HFS1s1rGHprblydufa/c1lVD6zIkx9d95id8YpGtM9KxL7D4Hm52/emhxIHJYzkMaB9m
 qVq7JUfv3Sm+1+9iuPZnV4ZsV2jVWa8lop8zrEYC6jT0T7GRtUffP0T9Q/4Hw46o8cAx
 ryGhX5XtVwB7tQwuZalZP3XncmaeME7JycnD/vcXf+E7WHBG1S23iMM2KyaZtGtrJKDf
 7RnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgx3LsWAkgHPC12aNO0yetqjHnRn34D95l9FhNi9d8MCdFyCrRgoyAefPiSjo1+9VEYQ3OvPliuaSt@nongnu.org
X-Gm-Message-State: AOJu0YxqW8vV52ApoLEAPYNnAjtDIk40NoXVtVLUS9hYFNTbkl11Sx0J
 0qoz2FEOxZQTa4FmantbnYXIm77eGEZFmkawO1QU0asKnpwXHU4=
X-Gm-Gg: ASbGncu//3IHlgiDhrSaIhm60x+SoVYqdWuD1PU9OUk5zFNI/7YRiLfvRfrTlJArb9e
 X847+Q3EPgDIAE2P5HbvSWYk4vj33+VVgmqmAICEKVYEb1mXqSo1rU2gde9j2pyT6yQ19L18Avo
 3+/bmyxVPATBMlv03QE3/MjGev6Qi1f6+5frt3xfjG2DFOK6rQrYdnJCK/WoC19TIW2IBEAh+sC
 r3pZDBrgHOsBc25MDu18bo3XCCWxKna4/5VKGh38UE7Ro4kQCbiP1xgZ4LoNyPnR3wmLII7qWTA
 AjV/nmcoD6HtRNUFDed1Kw==
X-Google-Smtp-Source: AGHT+IGfKUgUmxHci0LIjnwE2GmqVyvqhzjZWiA44ZkBHB0iQ1qER5AFPPmD1rpucfqr+iWKbS4wJA==
X-Received: by 2002:a05:6a20:c78c:b0:1ed:a4e2:89cf with SMTP id
 adf61e73a8af0-1ee03b129damr8209048637.27.1738951791093; 
 Fri, 07 Feb 2025 10:09:51 -0800 (PST)
Received: from [192.168.0.163] ([116.232.67.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048e1f13bsm3282220b3a.163.2025.02.07.10.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 10:09:50 -0800 (PST)
Message-ID: <669b8096-a22e-4ca3-9b8f-579b0522050a@gmail.com>
Date: Sat, 8 Feb 2025 02:09:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] vfio/igd: sync GPU generation with i915 kernel driver
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>
References: <20250206121341.118337-1-corvin.koehne@gmail.com>
 <20250206121341.118337-5-corvin.koehne@gmail.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250206121341.118337-5-corvin.koehne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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


On 2/6/25 20:13, Corvin Köhne wrote:
> From: Corvin Köhne <c.koehne@beckhoff.com>
> 
> We're currently missing some GPU IDs already supported by the i915
> kernel driver. Additionally, we've treated IvyBridge as gen 6 in the
> past. According to i915 it's gen 7 [1]. It shouldn't cause any issues
> yet because we treat gen 6 and gen 7 the same way. Nevertheless, we
> should use the correct generation to avoid any confusion.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/i915_pci.c?h=v6.13#n330
> 
> Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
> ---
>  hw/vfio/igd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e5d7006ce2..7bbf018efc 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -64,7 +64,7 @@ struct igd_device {
>  
>  static const struct igd_device igd_devices[] = {
>      INTEL_SNB_IDS(IGD_DEVICE, 6),
> -    INTEL_IVB_IDS(IGD_DEVICE, 6),
> +    INTEL_IVB_IDS(IGD_DEVICE, 7),
>      INTEL_HSW_IDS(IGD_DEVICE, 7),
>      INTEL_VLV_IDS(IGD_DEVICE, 7),
>      INTEL_BDW_IDS(IGD_DEVICE, 8),
> @@ -73,8 +73,10 @@ static const struct igd_device igd_devices[] = {
>      INTEL_BXT_IDS(IGD_DEVICE, 9),
>      INTEL_KBL_IDS(IGD_DEVICE, 9),
>      INTEL_CFL_IDS(IGD_DEVICE, 9),
> +    INTEL_WHL_IDS(IGD_DEVICE, 9),
>      INTEL_CML_IDS(IGD_DEVICE, 9),
>      INTEL_GLK_IDS(IGD_DEVICE, 9),
> +    INTEL_CNL_IDS(IGD_DEVICE, 9),
>      INTEL_ICL_IDS(IGD_DEVICE, 11),
>      INTEL_EHL_IDS(IGD_DEVICE, 11),
>      INTEL_JSL_IDS(IGD_DEVICE, 11),
> @@ -86,6 +88,8 @@ static const struct igd_device igd_devices[] = {
>      INTEL_RPLS_IDS(IGD_DEVICE, 12),
>      INTEL_RPLU_IDS(IGD_DEVICE, 12),
>      INTEL_RPLP_IDS(IGD_DEVICE, 12),
> +    INTEL_ARL_IDS(IGD_DEVICE, 12),
> +    INTEL_MTL_IDS(IGD_DEVICE, 12),

According to i915 driver [1], DSM becomes a part of BAR 2 in MTL/ARL.
All accesses to DSM from CPU should be via BAR I think. BARs are
mapped in guest address space to host address space by QEMU when
passthrough, as a common behavior, just like normal discrete GPUs.

Though IGD takes a memory region as DSM, it should be reserved by
firmware and not directly accessible by host also, like GTT memory,
since arch/x86/kernel/early-quirks.c no longer reserves DSM for MTL/
ARL.

Appling the BDSM quirk would bring issues to MTL/ARL. Probably there
is no special workarounds needed for MTL and later IGD devices. But
intel hasn't made the MTL/ARL/LNL datasheet publicly available yet,
I can not confirm it :( If Intel really decided to not using BDSM on
MTL+, we can just have a fixed id list for igd devices.

[1] https://github.com/torvalds/linux/blob/69b8923f5003664e3ffef102e73333edfa2abdcf/drivers/gpu/drm/i915/gem/i915_gem_stolen.c#L918

>  };
>  
>  /*


