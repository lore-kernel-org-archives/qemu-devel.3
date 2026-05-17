Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB55CD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOezI-0004J6-Ca; Sun, 17 May 2026 13:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOeye-0004Gd-4o
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:08:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOeyc-0005Y2-4r
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:08:31 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-367c2a39fcfso553756a91.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779037708; x=1779642508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VXOxPkZB3qXDe1jnm+EACCm6kAWHzKYSYsRSu/nffGs=;
 b=oXOkg0G+nAk/GrgH3VfKFvZHKef6ymHi/HsKJ4yETgGJNjheVnEcVo6iBViEjLOnjq
 EMlz6Vq/5kCsKGk4P+mWM/UW7aM9VkRRdgbnphpWLtvvSsfCb3eng5X4EhsmdrUOyXAO
 fUsMR/MQmLZryEtMvxGHtlBQj9OX27YjRiyfmgoDfg3Kn39oyW6D4Gs30k3z7hLG8LZE
 9pbQfs8D++Npdxd4ji94Ba8DujTO13QI4206ekkqF6JHobU3JkhLITuzyPx0vl5hbgdE
 WaXMvKNU0bLjTs5FwhHjLVjQZSzKgsxhECBhWxjFuVp8aDnlUJXYwpRCkjdfL9cdic+A
 mxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037708; x=1779642508;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VXOxPkZB3qXDe1jnm+EACCm6kAWHzKYSYsRSu/nffGs=;
 b=H7G/qFafb0ObEpyhxidSHE07GPutINZ20E0kNnSo8lCr5l8fw0PzxUPug9o9oGKQnU
 iFGIw7n5oFX0PzFWRmZYV8vFzVCzp688/tCjwsZ/Kzz73BHziKCA2S1iw5RxM3k1dU9M
 +YU7lmeTPrngQacyu1KA4TUmWjbtgoBI3ZPYFsYxrBs2y1yTJEsBlIH8sGFfhhBw0x3j
 Q3gYvqBKkG8DHyuZoHkaYd3l6tBxb8hOuV2IgDjIsh++QmoG41ff6IvTcSKUJNLBHiYY
 XfZudpLSf3P4CJeaRtBRiRFGRNEP9/15GRdW7PBGhJvsLg0gW6xVxLLL44/PRT7GKcex
 hQDA==
X-Gm-Message-State: AOJu0YyaP37Qxx/Vwlye7i73e6Id153eQrAxxgAxrdBMhp9GUGVCsv7F
 tc9lj9uXPp8PyxjlaWZthuotXQTTmpkmGgbAK+gVm/O217Kbcn8RVw2qwVamyaEpeX9vRNlXg2F
 +J5/D
X-Gm-Gg: Acq92OFvKNG497uDCSTzV5sHdecweBhB0jlZ5UGs/70eoGI783X6VPLLFd1vQaygNnZ
 Q54kaZ7JH6w3EOX/EEWsbR2aRdkMSW0HjCnGFdlC4VJ8LEEKSDBzRg02YthfSpFoO56iA6KxhPw
 oYyPjJZLI0Y/VpV9Yjx43/9iuF+1Iquh0QkQqfcxUyBWsYz0SytbLg1wIpxh9l1WjolmvgdeoRs
 el/U+jJaqoXmR92DSiUcI+hveZfkHzllOILCQZ0kuS0O7bBcod0ghrBxwp5BrQiAiyBcqAXUZEi
 UwTiASVTpF7cdbxBwnOmdRkABMethdOIRq6zHw9eJmoMAvVT8IDH7kw/QxqWjintujUx6yMLo4c
 bjEqQ0ZQTDYP/h+7nU3PCfTAm+qotPwlMRTPtxfkuCJR2Tafxp2MqpjQlCKDV9IE0CZyAcWdkNG
 RReyu77dR5mQe9flsMpscMajkr8Y4NRP09Tjs0
X-Received: by 2002:a17:90b:35c8:b0:356:22ef:57ba with SMTP id
 98e67ed59e1d1-369518b669amr12068137a91.7.1779037708132; 
 Sun, 17 May 2026 10:08:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36959b06290sm4420139a91.2.2026.05.17.10.08.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:08:27 -0700 (PDT)
Message-ID: <2883b2a5-7fc6-453f-ad89-03daa05bd218@linaro.org>
Date: Sun, 17 May 2026 10:08:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] hw/arm/omap: Remove unused omap1_dma_irq_map[]
 entries
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
> For the one remaining OMAP board, we use only the first 6 entries
> in the omap1_dma_irq_map[] array; the rest were for OMAP1610.
> Delete the now-unused elements.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c | 10 ----------
>   1 file changed, 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

