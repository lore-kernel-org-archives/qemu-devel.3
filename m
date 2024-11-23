Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D873D1BDC2
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 13:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEqMp-00026v-6I; Sat, 23 Nov 2024 08:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqMn-00026W-Mz
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:40:05 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqMm-0000iq-69
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:40:05 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-27d0e994ae3so1551084fac.3
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732369201; x=1732974001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4iOsiPStMfROVDLuxtCwKLVN9n2WprpVU4m6PSaSX9k=;
 b=QPnklXZvhscSx1gUz3XlGBQu5teRXt6EQ8vNmWoh5frypmmyXue3IMZN7vipT1XBFh
 y6FFkKC/yDoTi0dMwc9C4UjPGfL1BT9PkF2xdOtxYwZJ7rw7JXhMZASTVFV6+PjI5SsR
 gwMhKGB5fH95vYLdecDsYoy5RGl/uD8pPqATvsQ/e4iq+QvFN8BIlZkTA/l4g/xGEM2B
 SqpvmwLGXtSVtxjOoLyo0AawxMDl+a7Nf49AhpIeGrZghrs3NM47Wxk0U+81nBX9bnv2
 pvo/ZUFvVo73qwZGdUx2a1LO8raiQ2yZHQQkt36M4ud6Hja95tacLm7Rd3IDjfX25bZs
 pZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732369201; x=1732974001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4iOsiPStMfROVDLuxtCwKLVN9n2WprpVU4m6PSaSX9k=;
 b=oWu4Rw5lVkDhntvcuadj46bazWLlMLnPCYT7D7fL6A3d2pt2hx16xhdTQcGRu06T46
 sHRkjbQITQukkMg6gtwvGh0Xmic/xv845dhAFYRnXtGMSGJrLi8PfUNSMtIuEm4Xi8H3
 cBSzgSpgswiVcU4LfsK6q6d9iHv5y6BMWOsFd6QbAB/NrVyxW5C6zHpClmoA/ezRBQyb
 Pr9hFrYEXWGl9K3d3+MHmV12Du4RjRPI8SDaHCn6c9MSqvzYuaAPZmlc/a5srBQeoueT
 UQ6qI7Qxk+WaVAQFzKIZRew/YPygPSFN7lj9JRZBPeUBtA42y0XqPLAVQWlIJm5eX79G
 LR4w==
X-Gm-Message-State: AOJu0YzuDQ8eM5o44h3wwkDVGNHdaN+OGRBJJ4/XcLDYh2BxzKrh/Hws
 hMyj/3JpwQewX8QfmdsXYezmib7q7GNVMNgBvi63gS9huVW4DiirDSYBqX/L738Pgn2rE9hQ70R
 nXSY=
X-Gm-Gg: ASbGncsCCMzd0JsA6SwYmj8dgnVJkO4i/wXWrpNigFzL1e1A57dh68NcFljatyYhle0
 uJolcGhmpXBoPtaCvJFvpKkHhiPZoG82m4jSavS3pZoCaPHiemPRL6OnPZrdGBwdBoshNS22Vnm
 LLw7VgyQ7tcOhcPGNEJysdlesBCE0RgoaDoZ45apwThFfjwjac9h7tzgZ9KlKFqaZwMloMniVtX
 ZwmNs1qqHj3GBK4/0qPIvSDNiyWQ3f0vLtX2nvj76o7Me6jVhbihNhcS8iAW+GVJA==
X-Google-Smtp-Source: AGHT+IE7bNggqsLCq+XJyLjNZEciX+E8HdtwrrCH1LnWuEhlDugo+L3YijcOWRmIg375S+u9H+ZtGg==
X-Received: by 2002:a05:6870:8189:b0:260:ebf7:d0e7 with SMTP id
 586e51a60fabf-29720bf0409mr5964520fac.15.1732369201323; 
 Sat, 23 Nov 2024 05:40:01 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d898b54sm1344645fac.53.2024.11.23.05.39.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 05:40:00 -0800 (PST)
Message-ID: <0105f2c1-9390-4557-bfad-668a328ce951@linaro.org>
Date: Sat, 23 Nov 2024 07:39:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/openrisc: Fixed undercounting of TTCR in
 continuous mode
To: qemu-devel@nongnu.org
References: <20241123103828.3157128-1-shorne@gmail.com>
 <20241123103828.3157128-3-shorne@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241123103828.3157128-3-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

On 11/23/24 04:38, Stafford Horne wrote:
> +    or1k_timer->ttcr = or1k_timer->ttcr_offset +
> +        (now - or1k_timer->clk_offset + TIMER_PERIOD - 1) / TIMER_PERIOD;

Better using DIV_ROUND_UP.

> +        /* Zero the count by applying a negative offset to the counter */
> +        or1k_timer->ttcr_offset += UINT32_MAX - (cpu->env.ttmr & TTMR_TP);

Since UINT32_MAX is -1 in this context, this appears to be off-by-one.
I think -(ttmr & mask) alone is correct.


r~

