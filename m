Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4834FE6ADFF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 13:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEqe6-0008PU-BS; Sat, 23 Nov 2024 08:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqe3-0008Oa-NF
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:57:55 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqe2-0003Ms-8W
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:57:55 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3e604425aa0so1608381b6e.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 05:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732370273; x=1732975073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=390iigWXu/5tVrI6CMLnzE72Ez2CVFb1fxhDqtZ7keM=;
 b=m3d7fEN5zdGQC0xBhTPNrjo7G51GuKwjGe9pUg6WnHO01xHdfzr1Lbw1q8ZRzGzHla
 K85nVoGBZHPndmUf+/sslg09hEQWWCcmIV8DINSCHr5LergNLVXzm/Bz++eSrpDI+QcR
 lqE61M7pq1MNgQKV+8GSEggqPNPNWLCuYOQB39QBVGMijlo+iea+IpJ5kVwdzWAcMO0I
 1ACBNjWncRQaBAYVuCm2rd4oqlsqn7ZUPQl0phGGRdllq+nKLdxnDopa3YFzXBfUAu7y
 tUm2Cb8dRHtHmF9nlzGrvMaPOMiTb8bejP2MI/cPwN161KY0kgxLjuqQ/3aL06+KnSyI
 9NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732370273; x=1732975073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=390iigWXu/5tVrI6CMLnzE72Ez2CVFb1fxhDqtZ7keM=;
 b=imit5hkEjrx+XxmJ0j/ZqAnWmwoTEQv698/qY8YozluX5q1BA4WulgLx01BzV8nH6x
 aqXuRYT0zD87L3+CXK+7Da/G0QGd4HP2ksQz9Li5NBnSXn/GXH/jHjjX1Bohv7SVb/XF
 nLycugDvE86nryqokcoCtz7QE5l6HA+n6YwTQQRXICq1aK/VrBBnWcQ2ME606QOkFzRa
 NAixqSPoUgRjAm12voUlbNWSYqAyGVbESP5sUDJchGwgm5nddP0e+bo1dQ1jfJUhAZgi
 NwRdJfOx4SPZTU7aDcyGu7fer8vkj5SP+DC4kdKoObtdX7ewcomkL2omGGsl29/1ArqR
 clLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpVstvC6/PmNp141TpMeeX3ZxccZKk9ynMFEQ9KaAssXzsQfC1AmMsG1dY0YgHBILv6CryQyUy05ek@nongnu.org
X-Gm-Message-State: AOJu0YzfNikEN68qMARM1y2MBgP/838RZ6QOIP25zAVzRTuPbzONzMCn
 wqBMOYTsaNbcIMcKvNWdZMYNdR65J0SYfPIWfDH5J60vNNQIRRM88g+G00eQMcPhd73YoZltJFE
 Q3OE=
X-Gm-Gg: ASbGncso5xdzCaKiMSdqqNqkHvHHkrYfg6FWSX5+S6HpzeY8KMBMd3jO4rknEtipqnN
 qvU1dIzNWQnpCRUwz3LipEsyEb/OnXwfBN1cAcl0J9IDi0ofmruPuGqPPWNKi4GLEUd5tHSFj3C
 HfUQWv5OxmxyzeXNTuaG4ERMjTBGpG4OOG/zsz6KQdpuKl6K5MszGY+s8eaY9nnwtgbWtm0709J
 krGtMrnX4+ZTg7ZipMVER9MH/sKQVXZZ3JZsVK8nJi78tNttAQPWcP/AD9ZpjtrVQ==
X-Google-Smtp-Source: AGHT+IFZZhDYsPVO7f9EuwMeXnkmP3uAhrLwjjshDuWvOsuw+ogo75sACekduh6vqdZlg3eeqi15AA==
X-Received: by 2002:a05:6808:15a5:b0:3e6:19a9:4718 with SMTP id
 5614622812f47-3e915b66f2fmr4596929b6e.40.1732370272965; 
 Sat, 23 Nov 2024 05:57:52 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c03759352sm1003470a34.14.2024.11.23.05.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 05:57:52 -0800 (PST)
Message-ID: <b1eadf2c-bfed-4d58-8ccb-c4e6d028166e@linaro.org>
Date: Sat, 23 Nov 2024 07:57:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] docs/system/arm/: add FEAT_MTE_ASYNC
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241122225049.1617774-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 11/22/24 16:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 50d0250b1eb..47f5123a31d 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -94,6 +94,7 @@ the following architecture extensions:
>   - FEAT_MTE2 (Memory Tagging Extension)
>   - FEAT_MTE3 (MTE Asymmetric Fault Handling)
>   - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
> +- FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
>   - FEAT_NMI (Non-maskable Interrupt)
>   - FEAT_NV (Nested Virtualization)
>   - FEAT_NV2 (Enhanced nested virtualization support)


