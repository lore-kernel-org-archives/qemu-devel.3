Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8422AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7I1S-00035y-B5; Wed, 15 May 2024 13:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7I1O-00034V-Pf
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:02:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7I1N-0007rp-BW
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:02:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-351d4909711so37280f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715792546; x=1716397346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yiRGsrw3DKaavdRwWZkHwGKJpiiOH6ylD1utjko87eg=;
 b=F70/jRin1QueN4QR8o6yLNnB1tc3A/4amLsGSw6Ho8Fm/u2L5ctTL9mvj5m0+p3aVn
 yT43FbEV2ikzJbyUvPJB0+Oke6TjG72pFxmgzL13hPJJ8QaT73Ch6k8hujBWOl40iois
 W5zAWNxI2tYJQ6Y7jBrX/zlJ9Ti1taGANUo+Jh612HCXScUKvnwiIqAi8ecOaeRiIIWR
 F1+xWYRFm9PDptevjEmbMa6WRa925aO5/gbsGTuxEF2pxp6IucOm590XBhAto25prCT5
 MDanzuoy5Nk4Sj46SzkHVhHJZAESml3O75OzNyQAeTxc63w7usz7WJo9GnzkYvzjSumG
 w5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715792546; x=1716397346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yiRGsrw3DKaavdRwWZkHwGKJpiiOH6ylD1utjko87eg=;
 b=X1pViU3jggrylbE/6osQKWtWIRXw4akfkX2bwHrIiPf3by/0fnDSPbIlWfZiiTbBpB
 cKhFsT5QINzB4mh9rSu8bYFXS7yU7sJVpp3tdiVH0aAri/flUQLAK3hRbW5aCmnDde6Z
 KCapVFRrLYOQnW+aXDRyY9ormoNniKULB6iD44kAJJirFzJAHxpvdVXnwRG8LuFWq5tH
 PyproppNaTz0LKmThdHO1jvGF+6P/uXB2ZV7kILdtZHo5qVuqc35A9jBBjb6yYwX49Af
 hNP28OJWt+V4uRvhq8lx7mQ17y2nGHjiTiPnUAf2BUQniQm9XdLG4NW58eC7OwRL2zG7
 Ocrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfsoHaB4fSJG3MbAIi89tyhhseA43G9xiAdaiZm1f5KZhYy/P3+pI4xOlSRUYpiGxkd6MrS8kKshogMe0EqE7Vh9aes4c=
X-Gm-Message-State: AOJu0YxEaO/1KFG59pivNSV6SCVNr+R6kgETMSiLt0QN3LASFOQ2l9Be
 W444JB/jt/35F5m1Ix71NQWCBvn68gI/sTicBxs66uA6LJuyKHxy2Qthe5Z5GPnM/zXWttLmuEt
 A
X-Google-Smtp-Source: AGHT+IGUPtl8TCMOGa4JuLqgw4m+uQd3nfooEkDkx23thnn++cXanM1uNfP+PsSSvC5Kl5+PHB2zeQ==
X-Received: by 2002:adf:e80b:0:b0:34e:5284:4753 with SMTP id
 ffacd0b85a97d-3504979cd90mr14335006f8f.1.1715792546034; 
 Wed, 15 May 2024 10:02:26 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacff4sm17015230f8f.79.2024.05.15.10.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 10:02:25 -0700 (PDT)
Message-ID: <311452d7-15f5-4e8a-b45c-b9184bcfe06a@linaro.org>
Date: Wed, 15 May 2024 19:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tcg: Introduce TCG_TARGET_HAS_tst_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240515145900.252870-1-richard.henderson@linaro.org>
 <20240515145900.252870-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240515145900.252870-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 15/5/24 16:58, Richard Henderson wrote:
> Prelude to supporting TCG_COND_TST* in vector comparisons.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h            | 1 +
>   tcg/aarch64/tcg-target.h     | 1 +
>   tcg/arm/tcg-target.h         | 1 +
>   tcg/i386/tcg-target.h        | 1 +
>   tcg/loongarch64/tcg-target.h | 1 +
>   tcg/ppc/tcg-target.h         | 1 +
>   tcg/s390x/tcg-target.h       | 1 +
>   7 files changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


