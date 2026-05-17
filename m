Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE72CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOexE-0002rR-Sf; Sun, 17 May 2026 13:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOexD-0002r9-Bp
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:07:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOexB-0004xH-I2
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:07:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so14936265ad.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779037620; x=1779642420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8CLwcI1iwHQGyxf85Sd/FKaRZEOVOM6fbiaDe8Czs8Q=;
 b=dYSfuIfwyuDMtJsNp5XR7RypRxmt+zIs2wysM4kFmDQ4WMCeUFHLrIIMfwvB6up8sw
 Knff3qsLJwGKss6wnVat0y7SB5VnF6WT7+2m76FMpYmCKMTLLIfBFtui6UkDOaSRbkRO
 aMdi6msNnWiOguqzAFm0/YkcmLvDTMdgF9/gKJXoNkvheFTvSYBjtCESiH9R1FQ59QnQ
 nPtijUyslgZAX4J+2WvzoHdVDk7GjHuayzj39zHsncJtRCRTWpDvVah6nU1AZbMByWNy
 L+EjOhK3uJVWZartF0DvwxF+WTT2rGki8+JVhp3zi2rS/aYAO0MJFmioF5KDnVmoY0Ya
 Zfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037620; x=1779642420;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8CLwcI1iwHQGyxf85Sd/FKaRZEOVOM6fbiaDe8Czs8Q=;
 b=lM4wo91zGllLp1DJqJI+3raOkf3ewz3Aq/tEe9gNn4LJGSvFQrWHPw/h1Qk48O4sB6
 Ep5Gl/OcuqV5C6FydtamliZrpPC2axHG/B068ByaQxDxFu9waEwm7WjFA9lAvdGdeXeG
 u4xLSctKofAKMr2J5ourZNADiBAllXWFp0JIYfNtwIu6JBMXcsicDPxk1cIRew5uEDMz
 XxrhbBnSq5iA6IszoveJWmk/n1EJ9/Eu/Fgw5fST82k7qL9UobIr+IecPTKpmZ5PowrL
 Nkm681vKga+T2jaTENq2wT9kQxosNeKgtUpbdp6WZQicYMI25fm9A3S8XTvqQGedyS0q
 tQcg==
X-Gm-Message-State: AOJu0Yz+shAnMrOvaN5A2PDOCJhAApTxDC2l/5EtqwIfCUUhsIi42q2V
 VhZXYoIG9dXbdW1l5KjeqvGgmRBdkkohhrSBOY7aA3RPNTB4X9SooyeKitqDftcK2WCoT2pedwM
 XD26+
X-Gm-Gg: Acq92OECHerMqT29f155oqAzlrXXKWRMuPY7gZkW7nfnBCWcqBe73glTAB0kPp79Bx2
 hJn1niw+B3A6mrZTu/oDunQgwQHUyPzvh477VxZlbhiy1km356HVgZKPogU3oNGac+U09v1oNXk
 i4vI9/+uVDQ1Sg0rcu1IarluJsuw16u93Yr+tVDbSl2yGZw+nwusEOBUMT+189T5UiLIacxSfaW
 +l9EofLYLhylnRdRtuFdSKepydOMSwFFErDeKvT6X1gWnfpSyPlCPnzEYiF9P16L3++sItcUrsO
 tkRv++J2ztGmHI5LMDK0eriVN/0URSKyQkVYNKb239babEAJb8KCmTc7EB3ewANOoCBo3NCnqPi
 eECK882yR12wATCTYUgB0QiejUxhPOlP0HYwZjye/kjTJlAOX5yIsnLingPV42MpJ1cmtPqbzC1
 kUJIth/EOZg9Y5TXSj8ivcZqL9tjuD6VLaQ5eLGVqps2TSsIw=
X-Received: by 2002:a17:903:2bcc:b0:2bc:8101:3393 with SMTP id
 d9443c01a7336-2bd7e7fa24emr121051785ad.1.1779037619529; 
 Sun, 17 May 2026 10:06:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11cbdesm123297565ad.71.2026.05.17.10.06.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:06:59 -0700 (PDT)
Message-ID: <a5af419c-387e-4b53-aae3-e056401fddd2@linaro.org>
Date: Sun, 17 May 2026 10:06:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] hw/arm/omap: Remove stray unused prototype
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/12/26 13:34, Peter Maydell wrote:
> When we removed the support for most of the OMAP SoCs, we missed
> deleting a function prototype that was for a function defined in
> removed code.  Delete it now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index dc63323210..96a52d280c 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -338,10 +338,6 @@ struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
>                   MemoryRegion *sysmem,
>                   qemu_irq lcd_irq, struct omap_mpu_state_s *mpu, omap_clk clk,
>                   enum omap_dma_model model);
> -struct soc_dma_s *omap_dma4_init(hwaddr base, qemu_irq *irqs,
> -                MemoryRegion *sysmem,
> -                struct omap_mpu_state_s *mpu, int fifo,
> -                int chans, omap_clk iclk, omap_clk fclk);
>   void omap_dma_reset(struct soc_dma_s *s);
>   
>   struct dma_irq_map {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

