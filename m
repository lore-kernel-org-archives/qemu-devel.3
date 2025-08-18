Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3489CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7N2-0006Rp-7e; Mon, 18 Aug 2025 17:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uo7N1-0006RZ-0Y
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:26:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uo7Mz-00023O-Az
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:26:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459fbca0c95so23535e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1755552380; x=1756157180; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QPtaYCrro8X7cxSLunuaf0DNwBe7HkZQ6c0X8ZL1wNU=;
 b=K9q10TVr6Z5G8eT4L4ZdcokhkiXn3qvErY81BbUc/5tstRC1Pn0KrQzbCuGo2HT3th
 lGygEM6t4tWLb8aE8/8n9FCkl+PIYzIFCvMZRB9aIakhwcT5Pcb0bFuui/ZjrJMk2MtV
 lTtWn4aWm6wDZ6Vv/DVV3gXheUT9M/YB9kVZucK03IdBiwsMvhQQbZJE0iR4Lh3B/z9o
 LCmc+A+4pi2+vDK0ag//6L00IkTeNSB1i7SfEebJBly1NILORSVhLQSai7ywfuoASOGQ
 r/V6YMOiaE1UOnVlMSnr9b8MR2LKEwgjSM73Y6UhwEX9atfYB//QP9pXtE/WUQTwE4dE
 PPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755552380; x=1756157180;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QPtaYCrro8X7cxSLunuaf0DNwBe7HkZQ6c0X8ZL1wNU=;
 b=xOezVnil3KpOL7jtRmIf/3oOkL2dbJcjTdR5uZTdBNMHgJE04G6q1cJcWuk+FH5ydp
 HwJzZDLmhm6pYnO1EkRP6c+aEnG+yH1/nMK2rCpytELdnzP7okjhS+gtrL4y/DepNhfb
 bzeeJDX7lH/Pj30ub/YjoWdGPUjUPs0Rjm/dC0GhUBAFMaboci0/SjIQ9FUYjDKeS62T
 l5dYVMGxy3U22DLpuDzLxQrjtz0+YDqquRqMVwQBXfxjJEJNfInZLM/vqZFRQYxkho7u
 96Dgqsdi9TKbe9mQTTT1U7J9NNwL23/VSnZg+gcf1F+jVbI5IDv6sikl4CIrTFO6lA33
 93jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYPRZRoqc07rxoRuH599tMPhRnjo0n0iHL/QqZm8BE5Gu3e64jVYTTDTbUm30FarwlfXBAYFrS9MMQ@nongnu.org
X-Gm-Message-State: AOJu0YzEaaKfGqUvtuKjSUz/TvnGeRgO1dgHOa53/FLsxG09jwHHUBik
 bAiYiITDHFCzrCvGg+kJB0yZ8C6YegFljRyGTKLuH2VkwDQIoa1ViaFoCncyhJ1kBw==
X-Gm-Gg: ASbGncvcHg62k2WwexQBuL6X8PhnZpol76w4S6xgFuheg3EbZAdyF/alYxnqbtOsoAb
 hO7eSRNWt6a5UIqSbnIHC0+SrJxLZreqgbF3wHgenrkXyMZinPolf2zMJlepmdzeqnUesQGVzA/
 sbfpOBjrT0TYz59AJEKjIvknWj3/XuQyjHu4jM28Stno6416vPSLhm9L0veMcXizWrcpVrMJuQg
 5L/OPcLpppMKSZ/xzySgKdZp7ho8PuVX6GtjWimzGy+tgX7n+eJIwqY+8Ws8knVnhJAgQj5CacI
 Xg84f/LP5pxO9DNbO0vzeQ9nMLpi9nJGXBEYkDWBvGNBF7AzPj949JpWOpaNcNyCO72oNQzkskG
 QbginXCUtibvj8X5Lbd9CGq+57MjJR/fc9NwNL7TRbR2dJStSI8qkeRA4GX9PaO/cw2vpKnNc
X-Google-Smtp-Source: AGHT+IGawUjiHtlKDmxz0HjBrDavlzvxLL1UNN1uGwbb/jEyaaiSso1OJRwKmMp3LpxnJLlZhkI3HQ==
X-Received: by 2002:a05:600c:4314:b0:459:d7da:3179 with SMTP id
 5b1f17b1804b1-45b43d67f31mr33455e9.5.1755552379622; 
 Mon, 18 Aug 2025 14:26:19 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com.
 [146.148.121.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074d43626sm925362f8f.15.2025.08.18.14.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 14:26:19 -0700 (PDT)
Date: Mon, 18 Aug 2025 21:26:15 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
Subject: Re: [RFC 03/11] hw/arm/smmuv3: Implement S_INIT for secure
 initialization
Message-ID: <aKOad6FxdPB4r4Z1@google.com>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-4-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806151134.365755-4-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 06, 2025 at 11:11:26PM +0800, Tao Tang wrote:
> This patch implements the S_INIT register, a secure-only register
> with no non-secure counterpart. It provides a simple mechanism for
> secure software to perform a global invalidation of all SMMU
> configuration and translation caches.
> 
> This is typically the final step in a SMMU's probe sequence, marking
> the end of initialization for the SMMU's secure interface.
> 
> With this and the previous change, a guest that is aware of the SMMUv3
> secure extensions can probe the device's capabilities and perform basic
> configuration of the secure interface, as is done by secure partition
> managers like Hafnium in its smmuv3_driver_init function.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c     | 29 +++++++++++++++++++++++++++++
>  hw/arm/trace-events |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 619180d204..0ea9d897af 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -920,6 +920,21 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
>      g_hash_table_remove(bc->configs, sdev);
>  }
>  
> +static void smmuv3_invalidate_all_caches(SMMUv3State *s)
> +{
> +    trace_smmuv3_invalidate_all_caches();
> +    SMMUState *bs = &s->smmu_state;
> +
> +    /* Clear all cached configs including STE and CD*/
> +    if (bs->configs) {
> +        g_hash_table_remove_all(bs->configs);
> +    }
> +
> +    /* Invalidate all SMMU IOTLB entries */
> +    smmu_inv_notifiers_all(&s->smmu_state);
> +    smmu_iotlb_inv_all(bs);
> +}
> +
>  /* Do translation with TLB lookup. */
>  static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUTransCfg *cfg,
> @@ -1921,6 +1936,16 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG2");
>          s->secure_eventq_irq_cfg2 = data;
>          return MEMTX_OK;
> +    case A_S_INIT:
> +        SMMU_CHECK_SECURE_WRITE("S_INIT");
> +        if (data & R_S_INIT_INV_ALL_MASK) {
> +            /* write S_INIT and poll*/
> +            s->secure_init = data & R_S_INIT_INV_ALL_MASK;
> +            smmuv3_invalidate_all_caches(s);

Do we need to check that the SMMU is enabled as the spec says?

> +        }
> +        /* initialization is completed and set to 0 to terminate the polling */
> +        s->secure_init = 0;

All access to SMMU registers are serialised, so it’s safe to drop this and
just return zero on reads.

Thanks,
Mostafa

> +        return MEMTX_OK;
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
> @@ -2249,6 +2274,10 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>          }
>          *data = s->secure_eventq.cons;
>          return MEMTX_OK;
> +    case A_S_INIT:
> +        SMMU_CHECK_SECURE_READ("S_INIT");
> +        *data = s->secure_init;
> +        return MEMTX_OK;
>      default:
>          *data = 0;
>          qemu_log_mask(LOG_UNIMP,
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index f3386bd7ae..019129ea43 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -64,6 +64,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
>  smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
> +smmuv3_invalidate_all_caches(void) "Invalidate all SMMU caches and TLBs"
>  smmu_reset_exit(void) ""
>  
>  # strongarm.c
> -- 
> 2.34.1
> 
> 

