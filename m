Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D434C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1Sb-000765-DU; Wed, 16 Jul 2025 08:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc1Ip-0002Op-3s
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:32:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc1Il-0006ly-6g
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:32:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so28024775e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752669115; x=1753273915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4S0/PR+ZyDkT33l6TgYRG19GoNTo6yUrLe6KEZQesYQ=;
 b=LcrcCSyoqreq6K8xkwnbzfBbq8VCotxkANTOixOfxV7e39D7dJ6CHXCeRIexnz32D9
 LpQvtsBNyvocvqifeepQEVOv3UoUEZ8RSCLreUkCbW1vto2liQphoiRpijUKqsxIOuTW
 ZgFBHEbBSWE24RRESyW9z3QTxwCsKqnqtShGa7vbzzmwmgo1lJPZSvWrxc0WxvcV1WKx
 R02mPFzjX25Fl+FyQ3niE9dUYSpyamAnBoxUE5/yYukbhr0SAqpTKhjt1sLCcGCf5FnW
 GBzdxbTIz9I6/SoW5d28iWErUXShdGTNacOIUTRjTYUI0qqaYl8PH2rjrIZYaNSzQYgl
 vV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752669115; x=1753273915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4S0/PR+ZyDkT33l6TgYRG19GoNTo6yUrLe6KEZQesYQ=;
 b=nI/lyzIxz6ZABBSsyxO0kP4UDeigcGWgdDKT6Fg3c9fHZ3F9/4MIH/zHck9elJn9N1
 IfUK2s2l0cKcmsMA730tz4aNN0Wx3Fukdfce1HLYU5HWQqQjcY6KxgZS5JE1G687uKow
 EG3+9mZjkxub5GMZVvHyUMpZ35GlrSq/jkxYyi3nVN6FNDA4joGZyY5ZQKNqx6eu0rr5
 4HSWbv1DNxfNceLcCrjbGBAiwg+5sfPvXUoAm2P5qF3ixnn3ZtbC9t0bAseiq07oTYCG
 jEiYtgwT4Jeyf0ctaqVf20ybYuLaW5jznb46zNXpEAc4y83A5lFFaAf51BZri2kIpMRC
 9jyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTOKmHbMy+8omTvHXemZxx4I8WU3/+gdvJmKCYKbjYXx/xGiIS1O3D/WgsW1opEOA94eThSDd0/aoK@nongnu.org
X-Gm-Message-State: AOJu0YyAhZZCaNm3HklmBVnKSesUn/hDxPV8yCNh3+ca0dCqoIiRGRJP
 52Czw9rxto4WYFdfhhJ6I6cxdCbgLQdGUOmZQ53cZrh91NIJAGggDa+mq2/lfS2rJwc=
X-Gm-Gg: ASbGncvDVQDnGxZheu6ELPB4cTezNnZdKg9SdM5cYhELBDDB5Z5f26nfyirwEjdU06h
 p9g8D5guPvpgzpwdaWgqvCV7G+HZ2Gc5yoWdnrAe0eNqtatR4Lfq/CztJEzzQt85mJ1U9/awxf+
 aMQ/c7qfI58u9ajRhge1VLXy3Yyob9nOUtRlILiQ3S0mnMl95ySvhSb3TIjrJ0HzsnNSIdTDeos
 mnhmSkkTpDEDroQZyqOcOtAxAfxNj22E/E+3bflBuu9SW8jWejsrmCQduLkkHlBOqNZnkh4OSHY
 iLJ5jyBCcUgks8TPK6AIDUswgGwXYPu9oBv/LpLbTXyHLMM4AI48ciuUtZPuoqIQJRKg7NCphTY
 8n1rGpehWH8xZyrpQsoDHi0iNG8yqkIpxGWW2hN+Itvrwsh+s309d8zPeSjKu1KneaXAmiox2BG
 CUXHYaz+PR
X-Google-Smtp-Source: AGHT+IHtyhSzmbhDpcmeW8FgvVzQOWZZPzAWnO8sMJgQEEGiSHCHBskbsfMCSDqGol22KaZ6ddjGCQ==
X-Received: by 2002:a05:600c:3b11:b0:456:1dd9:943 with SMTP id
 5b1f17b1804b1-4562e364923mr25968725e9.3.1752669114966; 
 Wed, 16 Jul 2025 05:31:54 -0700 (PDT)
Received: from [10.132.103.213] (119.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e7f2bb4sm19507705e9.8.2025.07.16.05.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 05:31:54 -0700 (PDT)
Message-ID: <3f33c08b-96e3-47f1-acff-c69a1bcf39b2@linaro.org>
Date: Wed, 16 Jul 2025 14:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] hw/i386/amd_iommu: Fix MMIO register write tracing
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com, Vasant Hegde <vasant.hegde@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <20250716073145.915-2-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250716073145.915-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 16/7/25 09:31, Sairaj Kodilkar wrote:
> Define separate functions to trace MMIO write accesses instead of using
> `trace_amdvi_mmio_read()` for both read and write.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   hw/i386/amd_iommu.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


