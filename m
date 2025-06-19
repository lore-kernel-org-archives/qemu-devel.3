Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40303C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMWl-0000mQ-LP; Thu, 19 Jun 2025 17:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMWj-0000ga-52
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:10:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMWh-00087e-K1
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:10:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-234fcadde3eso15773275ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750367426; x=1750972226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XD4M0/oQzBLq3gYTFHsa/6J4SxJD9T7hmWxuHGR720U=;
 b=PNbzKvnuNTOg4ncl83xTl9iiYxG95k2LSEMgwZw8qrfRC5xZQ3ST//WnOo5RdyRl6F
 j4Rl5tNwOBolo89AcGdAYCUfWh9f4qeuH1/3vQ+RX9y/TIqY568TUsBtMuF5tcaB01ve
 1/aBvFpOyA04K7Yrggs5ssmGo3J9mzIxaB1gNZoBJmP93ejsOGSQns959NdcIbkNpiAZ
 oCTlZ1ljBoevmGYMC/97lG6/g+BDvydkZirvWGUSDYIsGfu3zgADaSabHWEVtzJquqOD
 zz6EAVoNWhcR5kk3j5xRLSNON82XJLcSgg1tz/2gvSjHXGX8GS2eaW0p1QPN5WCa5fKl
 T+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750367426; x=1750972226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XD4M0/oQzBLq3gYTFHsa/6J4SxJD9T7hmWxuHGR720U=;
 b=p6zjqPfY2CHneN66YWWngJ7vwqcUAZotYRtqQo86IwfIx5w7mFncQPsGPm9tSDa3CT
 wgkIDBVnROntNFS0ZLS9CCOxSR5D8VVYMQSxcvuLkV9b2GVFbG++DKbHEkUqoX64XUkz
 irM5MpY6qdU5fvCgdMXqpGWTOBVkgnFSsISRP+AXgdk85rpkTB3NIHUjptNUmHQ+IKm5
 twkUSzVOHW98GrZJKbaRbOFeYaQxjIRvRzFzwrPiWv/8MHmXbeAeir921CnNLpe+cYdB
 NgAYlI2+tZ4Y0luSpq3GrY6vIUn/yiM2esIn5BbaFab8X4hwy5Ti4C9uUfKh8qA3ebZU
 mRVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHghGxYN0U9f5GfxU6VnvtcfxlBXyFzv0oDDnF5nLwWkNdNPgVXH84CqOJlUM6A1ah4dz6FJtw86ck@nongnu.org
X-Gm-Message-State: AOJu0YzaSQwxifZ/6VjNS3Lu6kC0SEzPiuiEC6JZX9DpIqrOfSH96E+C
 6xW0adsyHs4NynXtN98UZjjLkTBpJIJ8E1QpNQqw694kH9TiHJbCDDAhuEOKNnQTyKD/n2S5+Wt
 qa5IaFbc=
X-Gm-Gg: ASbGncvxH5RtxTttEUHGh/w0lbfhbUq7WqTIMqvqCqTmz+btvzSQ+WPzGQd6TD7es5j
 I/nvXTXBZq9gMQXhQuWs9WlPW4E420VqZqb9EKy3qzN0vX3xhbLuaQztvAgFv1INM8n0Pdl4Xzj
 mq9dI+yCSKjOfVcMXGcO+TQAJ3YykKTlFCpEMosx5ImQ7S71fiyOh1hiug06FP+KMnPIXImp3QD
 eoIJXmE7a7wpAczsIT5C+M+Xrugyc9achK88kT6gLxmSn9NMSZctuPiq7Yi4AGSAJxcPhJT7ae3
 1TMcpLo/zzjR4r1zvkkCvBoupz1GcryGRQfjY6XKo1hVgiGJgZxsXWpUL2F/uzzcAKvpz8G+1y4
 aiKX8i0L8VRrZuu4XN6cAJW7B3Slw
X-Google-Smtp-Source: AGHT+IEbBueKRCXJvE4+lgk+AI8Y7rh1LcujYDkjo1ycTWDNI38EEZDDzINNqmMrFh4zlPIpZ8GS3g==
X-Received: by 2002:a17:902:dac9:b0:234:be9b:539a with SMTP id
 d9443c01a7336-237d9a74d29mr4309345ad.40.1750367425985; 
 Thu, 19 Jun 2025 14:10:25 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d839325fsm2504505ad.47.2025.06.19.14.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:10:25 -0700 (PDT)
Message-ID: <14110a74-45da-4369-893d-0352c9b830f9@linaro.org>
Date: Thu, 19 Jun 2025 14:10:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] target/arm: Remove arm_handle_psci_call() stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> Since commit 0c1aaa66c24 ("target/arm: wrap psci call with
> tcg_enabled") the arm_handle_psci_call() call is elided
> when TCG is disabled.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/internals.h | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

