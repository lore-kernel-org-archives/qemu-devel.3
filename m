Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEDAE63FF9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 00:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9BOx-0004Mz-Ck; Sat, 04 Apr 2026 20:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9BOv-0004MQ-9S
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 20:31:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9BOt-0002ju-BV
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 20:31:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82c68339cf0so2210838b3a.0
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775349097; x=1775953897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bDBBZXtFGG2jB92VIe+sfMeolZhs7NXFh/nVZELTOxM=;
 b=TvFM+r6WaJDrJyl/+KRHC0+HsAjr9jZrQCIxqsWnZpMHh41HqT1p1gL6BR1caYUC0F
 HujqdtmGEacmugklf0djpxIj7kwuNTlOaFz9gHMdp/2G60453kl7KwtGTPN/MMYvY1KX
 4Pa3T7OCDaZ2GkkzD/0o2wMjq/Del5i9IlvowE5UXrS4l2RR3lPJZueAhzOJO4uD+93e
 yrLbShzD+uQAtBoUQFBirTBrOmQU7ORbI+AkUBV420+Xj8Y6GTM8VFzTLJbnQ4oP6I+Q
 Ja7X27dxV2wDNNVEoBa5Ey8sGa1Ph+jCEy5hQZVBRqYkH0tg8coAFcbYdV07FIr6u6Bc
 ZU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775349097; x=1775953897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bDBBZXtFGG2jB92VIe+sfMeolZhs7NXFh/nVZELTOxM=;
 b=JIePK6NEIyYaEVGbEvL/w/2NLei+/cP12RPvA5e80AMqyZ+wSYnVZvWZweefbl0XF7
 qOlo6UKdqID62I4BZ64IY3bncJRFqfHCkVUngScP7OZdtgIMtwcM0yheXYq+ADBOLsob
 MfaeCxdyoJaAOlldLlqTUfFrB7LOza09smWB5S6m+/S5Pi7pn/5nbmTIjiSqlpLzyVJP
 3hJVp4x2su2oW/OPzQ/5ORlEtzRp7cqdsSQcKQyTGd/2HsYVamurE0k477FEAgf+42Jf
 jfIiCImxYqBMZy1lio/4S6OYnj6HiQMwZtFxM+xkJVPKzJTK204QZBsa+YoVLNaSK1LC
 zQOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoaWZO5iYZmlN/bqdWgNHWKT1gij05jL8NoxF7pVDZHMVcndnyQ1T0A3XtisL4v+U0kVYIjBGU4Vk6@nongnu.org
X-Gm-Message-State: AOJu0YwFzZaOZAgvbBIQ3F5kFvn/n4Yn7p7LAzRAuGF++MKYK+ZX0Bdw
 ATU6Dab7sUNgtThT3PWH2PbSkLXMUn9Unsck1Nm4/0+xI0F0QGvjOV52RJ3K77cYE24=
X-Gm-Gg: AeBDievzV6RtfVZtCWwC6RydWX53rQelSilKK9LzZVPjCKEomLTWSOq+CVX0xPvwB2J
 D5tEbq68dBZ2TFrKodwtQT3wcgYXAd2DjrG/2sHNGxESkcza+sHMj9Bd4uAho3BQ7eg9gbetwxc
 w4AAlQKcr6f3iH+DVxsdgSlXBVmV+Ari/Cy2t+YduIDzlGht7E3h/PmvolkHP+BGkkCz6ksY7+1
 nzzI3cMKXQx1V+FE6xRrcRqkeG9PaJbszfrbqaOS4QsikvskBAAh2JPysKmEzpWanIwn32DINUg
 MuaQQ80hnHdyvhgsvEma7yGqPPZsMlkqu8XSBxLtuEZ/m6GyCpReUYeqjV87Z+8x9KaP6QAhrDk
 MzWtasUgQWWQCJA5tB1aPwxTP+VZmQs+eyUq2VcFmeDKx7aMHMRSDnX9JhplOtvmjUSgbLnEGqT
 wUd36/lNcy8bTVYptHZL8u+pzwpDsJ9KC2B9qHqzXEuc9gEkA/VQJ0rmByXEInAfsdbZM=
X-Received: by 2002:a05:6a00:1301:b0:829:6f7d:3086 with SMTP id
 d2e1a72fcca58-82d0db5fc40mr6479738b3a.11.1775349096950; 
 Sat, 04 Apr 2026 17:31:36 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3e169sm9959397b3a.18.2026.04.04.17.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 17:31:36 -0700 (PDT)
Message-ID: <68e3b199-006d-4cc7-a50f-f04c47741866@linaro.org>
Date: Sun, 5 Apr 2026 10:31:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] target/arm: tag check emitted when MTX and not
 TBI
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
 <20260309-feat-mte4-v4-5-daaf0375620d@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260309-feat-mte4-v4-5-daaf0375620d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 3/10/26 08:59, Gabriel Brookman wrote:
> @@ -1062,12 +1062,13 @@ static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
>       int bit55 = extract64(ptr, 55, 1);
>   
>       /*
> -     * Note that tbi_check() returns true for "access checked" but
> -     * tcma_check() returns true for "access unchecked".
> +     * Note that tbi_check() and mtx_check() return true for "access checked",
> +     * but tcma_check() returns true for "access unchecked".
>        */
> -    if (!tbi_check(desc, bit55)) {
> +    if (!tbi_check(desc, bit55) && !mtx_check(desc, bit55)) {

This pattern happens enough that it's probably worth creating a combined helper:

static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
{
     uint32_t mask = (1u << R_MTEDESC_TBI_SHIFT) | (1u << R_MTEDESC_MTX_SHIFT);
     return desc & (mask << bit55);
}

There seem to be several more uses that were not updated in sme_helper.c and sve_helper.c.

There seem to be no uses of tbi_check that shouldn't also test mtx_check, so I think the 
combined test should replace the existing tbi_check.


r~


