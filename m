Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D750BD37496
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 20:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRc4L-0004fW-PI; Fri, 05 Dec 2025 15:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRc4A-0004Y5-V8
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 15:06:14 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRc46-0004Da-PL
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 15:06:10 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45391956bfcso618789b6e.3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 12:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764965165; x=1765569965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aVec1LDbmH8ZjZ44p64js6TYQ9U3axj8RMeQFa2hJ8s=;
 b=GviYRBooGEqfowxYtw3/x1X7IvB62M1To2rVsExVwbLxnnDY7Qe1KgGpPR2sQmcWB7
 spFqwfd2W7yeTUyr3dWtnVMavKdQLPxVrvX3bevPow8oy+cOExhwyzAFZ8TzWhWLC8mB
 +UsAtnJzw2WAlgVOVfLXwHcy5wY5xMo8waOviIk6qxdF0OQNsiSnT9I8zqt0nwlKRRJB
 8yz1YIqEHFPA8Mx6OoSSQfYpcvaFwsyg8P+iNDZBflBZwAoewr4d6zHVTkwvDPQBhUQ0
 g+y5h+CVfvZbducd47+3RJH3A9p1Cv2yG8mD3TFXBQBopzn97qdGjzxvQEipZMxVIENq
 3V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965165; x=1765569965;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aVec1LDbmH8ZjZ44p64js6TYQ9U3axj8RMeQFa2hJ8s=;
 b=AFvclTCcX++kTESIbpogf8bRSlEkKiPQDBR8aiczEsftYz/faPwM3VDijRIxCb2RZh
 WhI1sOwK6Hm1IOCKfuL8JVM+ArRpBI4IDUIhOBADZWJ0N2PIj5qbKgpgwlmSU5XmJnhe
 fy5Z6WsYoW3CrYkkcRJcRdmiSF5DrzBfv6f6RMaCxtdoG4xRAXJ5P7szuGthNuk05CoZ
 ALhK+PtwfUPA2YeJ5FjR/5vmMDI35dzu0YC25myqvr8sThWwHvz4xhGSD/GeZgXSLiev
 W9dt+XxCTNRXzAfDCtu+SADToIbM2epAvVVCMAfXOsFwHX72aDYPqgGL1MUN4tjBMjV5
 Lakw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCA8SRuD8bfqtqUsqfRfyzj6kyh//9eMgVmq7FADLnER4HeSqdszcg5CP+xtO0WFFzc4LaDK/Aefkg@nongnu.org
X-Gm-Message-State: AOJu0YxlQpoo2itHNgBaXwHynZLNhLN9keVpEY51BEeIJnaaeb1Duc5i
 OkxVqQfBo+R5AWJuHduOpy7VE63XvcTB3XhrphZBBgXOQjvYt1YJRAFyh93jl3akNhI=
X-Gm-Gg: ASbGncujE4FhPx9+XkRPNLNocY9usiaeyi1eb0rXPNIS0JCZdpK9FH7TUnmWiu1iYv3
 1U/Q6K/Jkw1AX0YKOQDa5m5fgyRnVCrg8DBZxHEz6eTDU4My/iBOUEsIdi2ejLL2QYhKxuBXgvO
 bdlL3/1cVXKW6ZTBHlRGkN9y2+HJ+KMPxN8MgBjQWKUVwVIp6k/crR8NWhQ2MMFh/lR+REJQRKg
 4zfAACE6FbqFYYPxhvWaLAuAYwUimhbTVm2YmTiLhipfGHi7AlBrf8jXp2z/N0my4vUYAQh1wC8
 gcY6KGg6lPWM/OtohfJtc9dRXr7QY/xWZqBETJhlSIJpNiYJSCGgAdjoIp3nuhlLMULij09IU/2
 P1zX7CohBitTSBPHN66p453gO/f+3j2yMup8sI7viYa8mx6fFMMxuElPaS0/dlzPo9uLbKJQskO
 gTX+7d6hGBIFKxLw1UOk8h9gM86rHSnOaripMcRQUWmD6cOFd/Wa9eWZ234M9l2NilwJgC/4Hlj
 LQ=
X-Google-Smtp-Source: AGHT+IE2cR/n+uD1Em5em2MrDDhZTWGlFFwYhuaAnDxBAO37fntg+nOLIQWuv3Y+BiM1cgEXONQKuQ==
X-Received: by 2002:a05:6808:8906:20b0:450:a9d0:b799 with SMTP id
 5614622812f47-4539dfdd3f1mr101450b6e.17.1764965165420; 
 Fri, 05 Dec 2025 12:06:05 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4537f6bc9d5sm2763951b6e.0.2025.12.05.12.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 12:06:05 -0800 (PST)
Message-ID: <874e6b9d-dace-4aca-8b93-f405da467767@linaro.org>
Date: Fri, 5 Dec 2025 14:06:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 10/22] target/sh4: Replace cpu_stl_data() call
 in OCBI helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_stl_data() call,
> inline it. Set the return address argument.
> 
> See commit 852d481faf7 ("SH: Improve movca.l/ocbi
> emulation") for more context on this code.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sh4/op_helper.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

