Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E6C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 07:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4fB-0006Ij-SS; Mon, 17 Mar 2025 03:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tu4f9-0006F0-Ma
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tu4f7-0003HV-6C
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742195602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j3R7Srod0CmFLuYr0W1ywGXYa8jqiaB96i9FX52WwS4=;
 b=bsUFbDcDm5veA+srNUe/JywK/wvDrBxLj51gfnq4hkBAwC5xowzuXto5ZeO5lTmqzjSi0h
 ucvFPjPXLtjDaUT06OZplZSos5Sv2Z/+6lRFbqHhy9oOxfJ3M/CXTK647Pwj1XraHvifhM
 u7DDiDC0Rf8cYRhS7uM3mS1HN2uYEa4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-xelmX_lcOOeHSRLOzhKZuA-1; Mon, 17 Mar 2025 03:13:20 -0400
X-MC-Unique: xelmX_lcOOeHSRLOzhKZuA-1
X-Mimecast-MFC-AGG-ID: xelmX_lcOOeHSRLOzhKZuA_1742195600
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bd0586b86so9504595e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 00:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742195599; x=1742800399;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3R7Srod0CmFLuYr0W1ywGXYa8jqiaB96i9FX52WwS4=;
 b=e0b8bLVofuOCTeUZLWTNT8cPtzk/XE7k+Hn31g42/Uf8qC+wXpP321p92H1lbPm7Ay
 U0CpkQkjJcw+hGe1jtNcvw57gWKyGeMcj4d9ItKnNNJ01AV0KE02QEnDNKMBEsEbA1H3
 5leJzL3YpAd0AvRUebC25c3h5Cl0HIJ5vrkwQPaTp4743pl9PzacSubpce2LbQ0yoxKQ
 1RD5z5t+XOhzVU4FpUHQ5EV0T+ZYkYhi7XhnX4xIGmmGjZYu6vsCBeLhH5nUQ/74JSfY
 FWrZl2DlqK19CvYsyh7FldZnWgVzmHlsxGBkbCKARKzLb/SfZTIECaXkQxdarLmmFQr3
 uWrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDyu37PLlvXdgzzdguHLsZe8RR/LLfB8fWcbPSoKLoQDP48QFrj8RvMfoEp4iW4DQ2PrjzlFR+MMOP@nongnu.org
X-Gm-Message-State: AOJu0YzNoUa3IDH9cfHr5cCQ3YyNdMjTMr+/smwdMnKWe9Eh8u23pqmb
 cX1qLLM3TfFgCa37ys6AwJCVCCYnBXLhXW01EMSiFSdLgd+3zIvfGGFUb/dnVcZwJ58A+k+mqJM
 KL/VQYpDJpUWVp3GUNaNL0VYSemtkALNsWM4aiMxl1wbnsd8uO395
X-Gm-Gg: ASbGncv1W2SL5tkMIHbxTyk202rO6zB/Thvrgpcbxhrpftqfr93rGeO4Rrvv9rrt9Mv
 ASvTORR3OfbM8BY0Kk7m0TpeChl0oY6fqiDne140IGTH/bN5PJfd2dYlcTidbECYD2fOU+VJE6P
 o2GxA1YuyZ6cyUjQkLfB+aHWH8DQ+MJKOswAn18Oo2INOOwbw0L5ZDbPOuVzPtT3ige7jqCbb6q
 AHpGIfl0LKSZq0AbP1W42Gjj8cpVttvurMO5SRgqWZWP9TsYcCDRl92eeurb4cl64lVzZh9sUj+
 N/C0cHow/HOtyyZCP9tVlXCkdm5fWsiroSBPlAiAcrmY2uYjO9HowA==
X-Received: by 2002:a05:600c:358c:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-43d1ecc31admr109168645e9.20.1742195599395; 
 Mon, 17 Mar 2025 00:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcDGQ8HGQXXchdiQiPtPXNqNF/WbBd/SOOtDLYS7m4oXxJ9vRuSdSa+bISGLn9j/DqmU2uwA==
X-Received: by 2002:a05:600c:358c:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-43d1ecc31admr109168535e9.20.1742195599023; 
 Mon, 17 Mar 2025 00:13:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d28565b17sm61545305e9.37.2025.03.17.00.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 00:13:18 -0700 (PDT)
Message-ID: <4e000bfd-cdf1-474f-9359-0ab1ce29a7ff@redhat.com>
Date: Mon, 17 Mar 2025 08:13:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ppc/pnv: Move the PNOR LPC address into struct PnvPnor
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
 <20250317052339.1108322-6-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250317052339.1108322-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/17/25 06:23, Nicholas Piggin wrote:
> Rather than use the hardcoded define throughout the tree for the
> PNOR LPC address, keep it within the PnvPnor object.
> 
> This should solve a dead code issue in the BMC HIOMAP checks where
> Coverity (correctly) reported that the sanity checks are dead code.
> We would like to keep the sanity checks without turning them into a
> compile time assert in case we would like to make them configurable
> in future.
> 
> Fixes: 4c84a0a4a6e5 ("ppc/pnv: Add a PNOR address and size sanity checks")
> Resolves: Coverity CID 1593723
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/pnv_pnor.h | 1 +
>   hw/ppc/pnv.c              | 2 +-
>   hw/ppc/pnv_bmc.c          | 4 ++--
>   hw/ppc/pnv_pnor.c         | 2 ++
>   4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
> index 19c2d642e82..b44cafe918d 100644
> --- a/include/hw/ppc/pnv_pnor.h
> +++ b/include/hw/ppc/pnv_pnor.h
> @@ -28,6 +28,7 @@ struct PnvPnor {
>       BlockBackend   *blk;
>   
>       uint8_t        *storage;
> +    uint32_t       lpc_address; /* Offset within LPC FW space */
>       int64_t        size;
>       MemoryRegion   mmio;
>   };
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 59365370c37..63f2232f32f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1191,7 +1191,7 @@ static void pnv_init(MachineState *machine)
>        * Since we can not reach the remote BMC machine with LPC memops,
>        * map it always for now.
>        */
> -    memory_region_add_subregion(pnv->chips[0]->fw_mr, PNOR_SPI_OFFSET,
> +    memory_region_add_subregion(pnv->chips[0]->fw_mr, pnv->pnor->lpc_address,
>                                   &pnv->pnor->mmio);
>   
>       /*
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 811ba3d7a49..fb70a8c1f22 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -174,8 +174,8 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
>   {
>       PnvPnor *pnor = PNV_PNOR(object_property_get_link(OBJECT(ibs), "pnor",
>                                                         &error_abort));
> +    uint32_t pnor_addr = pnor->lpc_address;
>       uint32_t pnor_size = pnor->size;
> -    uint32_t pnor_addr = PNOR_SPI_OFFSET;
>       bool readonly = false;
>   
>       rsp_buffer_push(rsp, cmd[2]);
> @@ -251,8 +251,8 @@ static const IPMINetfn hiomap_netfn = {
>   
>   void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
>   {
> +    uint32_t pnor_addr = pnor->lpc_address;
>       uint32_t pnor_size = pnor->size;
> -    uint32_t pnor_addr = PNOR_SPI_OFFSET;
>   
>       if (!pnv_bmc_is_simulator(bmc)) {
>           return;
> diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> index 863e2e70aca..9db44ca21d8 100644
> --- a/hw/ppc/pnv_pnor.c
> +++ b/hw/ppc/pnv_pnor.c
> @@ -108,6 +108,8 @@ static void pnv_pnor_realize(DeviceState *dev, Error **errp)
>           memset(s->storage, 0xFF, s->size);
>       }
>   
> +    s->lpc_address = PNOR_SPI_OFFSET;
> +
>       memory_region_init_io(&s->mmio, OBJECT(s), &pnv_pnor_ops, s,
>                             TYPE_PNV_PNOR, s->size);
>   }


