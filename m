Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CA0CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOf6u-0007e6-FT; Sun, 17 May 2026 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf6p-0007dJ-M5
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:17:02 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf6o-0008Oo-4e
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:16:59 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c801b30188dso563958a12.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038216; x=1779643016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pnyqd7uvff2nt3t85dEUcgbUi9XCHPUIHJcx+rJgf7M=;
 b=qPYN0GAkiIv3Q53t4Z9pxYIcfk1tlRKJfICp0wArrXP8hCdMalJjNOCyAP80ZBBvGT
 1NXXP2+flPfZiW7UJVK6V9tzFnr2Ys2RQugIXAHGsn5Z+RFciYKn2qh9zFs5bsqJ8bgQ
 CXwwwEcZM5aEjE8HUroEDgoRvHGjzDp1pimEmyfSyUjhEZ/O7dwJsmT+N3iZLCMh9i4e
 qIr+FQwCmig+Z3AHXulNnR4sGhe1rbtxOm00W9XGZynlFnieMpPC9ruxCbqtkZ+9QoZi
 roEME4RMk1bm3DOBJVg1p7L60IMtfOObEYT/R33NWbZTTZQOc2EAeMvr47Dp4s+zSx1S
 cwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038216; x=1779643016;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnyqd7uvff2nt3t85dEUcgbUi9XCHPUIHJcx+rJgf7M=;
 b=pNR25m4ufnJs/5YY406tErqlcx8AXzcfE5fbIJUaztRpRUdtJfqeijaKHCG5/OfUHF
 cO00IBjaVZs7ufqcs80su0Wjkh1viqiyjwegwXbENop0xb3i30zTFHBCuQliaVcCT5yV
 AQ9kDPvrcPoD+hcHQBm9riAsryRLbVlybI6wAb6UMkCOV2Uc7QQ4vvtsBtMIGCuGldkd
 oJRHFLosuQtvuL+6MOLgNN1eKVXFmU/Al+ZcOjWnI1I7BQJYO1D3+VsQiISpkx/vn3Wn
 gf3jVsQ6MhZw/ysLQPZq8H3PhdW7VXvBahJdfWSA0XkiJwzlrTNtAZ6Mu1SxShgc9/i5
 T3Kg==
X-Gm-Message-State: AOJu0Yyv8SRN3C0PH/wljS2JXSy4iIb6q0CHclULnwJbE0NpPmz7rdZg
 GY3+e6rPU6EkXZkCG50ETLWJmW9aabQnBjdE3VACnAgurkZgDh6IbzgsO5wQVZqFDJz3b9T43zK
 e1X4k
X-Gm-Gg: Acq92OEkbjrqSnI75FxeqKGQy+Bxfbg3tabb/xT1FaoZEGLESS5wwMUwNgMfptIJtHJ
 dS2V63R5jtbS9XFRvN4GJ5uOgRkl1GLsfbprztKmcqBcdi77k0UKgaAqe7SnH33AcS2QJ5NceaE
 evtZPcGCWLZekkxx1boU3kzyEw3MLp/3Ngnzx2bR3Vp/USZE3+Hc1jMfFXlMg2pkUg9oAmpUfp8
 ZNWDLr1wpFbxPJX/nTumDeremQLJ4ODcB79kchvkITe/wwakZUgbiIprf+3qgdBLALFB4MKGwhq
 Z3mWamQWL5eRATlxyUW7851CR8pjyadhiII6NJmDze0C0ppbhtXfu+wB0j/2ynJ/QgNKsQSWM3A
 Xf9C4sTZQwadtJcKLbd+fSSRGAVptNSIWNJ/UpWZ/Xk5zftjYnVdhxCokCAGRb64xXHTDj5tp+a
 sh5yurVsaF9H1AT7xRJkRlnTQm79LmhxAuMAzb
X-Received: by 2002:a05:6a20:748b:b0:3a2:d316:de53 with SMTP id
 adf61e73a8af0-3b22e1ca7a1mr13234101637.0.1779038216086; 
 Sun, 17 May 2026 10:16:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb08d06csm11031215a12.14.2026.05.17.10.16.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:16:55 -0700 (PDT)
Message-ID: <af23cdff-92c6-402c-ab5a-d2e0435a8079@linaro.org>
Date: Sun, 17 May 2026 10:16:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] hw/dma/omap_dma: Remove 3.1 mapping handling
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
> Now we have no 3.2 DMA support, the omap_dma_enable_3_1_mapping()
> function is called at reset, and there is no longer anywhere that
> disables it.  Remove the function and the unused
> omap_3_1_mapping_disabled struct field, and drop the indirection from
> omap_dma_interrupts_update() through the intr_update function pointer
> to omap_dma_interrupts_3_1_update(), instead inlining that last
> function into omap_dma_interrupts_update().
> 
> The only other thing omap_dma_enable_3_1_mapping() was doing was
> setting s->chans; since this is now never changed at runtime we can
> move its setting into the init function rather than reset.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c | 52 ++++++++++++++++++++---------------------------
>   1 file changed, 22 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

