Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7604C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 18:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnLhF-0007qP-JJ; Wed, 26 Feb 2025 12:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLh6-0007pn-1j
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:59:40 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLh1-0004mh-81
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:59:39 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220e6028214so958825ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740592773; x=1741197573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2mt48uuHSH7hAPDdzHxyvmKvkI9HXZXzVq7bhxT367o=;
 b=JbJrAXHbomlS5/Wuj+knH+JnFLByfqbbYRz11a+sOjJf1td6VId9FeJQXXop7UQb0r
 ECk4qCl3IYQ6JgXo8xhUcCdH3lsVusBM+UuTzOnfHhNf4BAYjAEqmoBR0fCt1fBW5SM6
 Sz5gcVa8vQS9hvcJ8lE+eAdrDvvBb5Y6KO6oW7UIKhwYgpwuMiERjF4L/QihqehdZatm
 Yinj50uo8gSBthJsEUhdX9wmAmXBLPPXK34/ri9DBvl+yxVhlx7UqmsUabLoHHSxV+Sm
 6m0oZB/RTatx+IE9XkHFtkPZyY4Hu0X4fMw5wjMWFSTlDaudGjFQIh4oNd4zBVD5LjOO
 0qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740592773; x=1741197573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2mt48uuHSH7hAPDdzHxyvmKvkI9HXZXzVq7bhxT367o=;
 b=Z9FdGTumB0bvc4z4lacBxON7Uzb/x9Ufve5FpGywtfImqbvUqYNLI2v/o7ZEG1g2nI
 fB1NW6pXPoZl5HjdeTTFsokOdv2/zB0jrQAgpmcPaOVdcyBXIsI9JJcwx62l7EQrfqFW
 2I5IV5IvKcLi6BbMw43dIRPk/4vboc4KkjwKLTTaZmSYPvp4ZvsBgGmWRNzLKHNypEOn
 3pfZlkfR3+fedO1000jKUbMiNnY1HUJvdfoR9u7B20xjfcKmKq6Aljmsun6OYi+8vE0T
 p9sdQr//8oBwhjVzD62mJYHI4a5O+a/SJ2rdjGVxBcPYxUYACuZBNwzjrTMgXiwjno8Z
 cJHw==
X-Gm-Message-State: AOJu0Yxbq1B+Fq3YhC/A4dDDLaRgM/nxD0jga+OPapcEm1FRQm5Fh+Pp
 ZYRdOn5M6myLbhX1cvUcWGcs8+Ck2JXcO4BYcYiJnSX+V3KktitL3Q+9260MWmo=
X-Gm-Gg: ASbGnctiHd0FHB8/lxy9bjDfr1baroudXJVndzrGZqpg2R90/rBe45f3UYDXwUtVkvC
 AHK1e//QA2/mqiiJ+Sgee3cZiWEoLs7sdJzkVK91BMzBl6kUX9lfiOpht7g08iUUf5migOO1uYS
 qOPprFy/FGtkQuMUZAUSuWOgW6SIoRr1iarMO+T+/oKtjyoNUmNmXSDFEh9WEefE4ZfGeaho3rr
 cmkS84p0MVqx59Kr1jWicYlHnpuMnq9jPJ4abgHZT6ia+j5ToueKL9O4zBttbLew7iWgzXAf8Iz
 mwQ6rIdKPOZaYkw9WDk5yjP8uvWpv/pstj91/Z63xi5GwkHv
X-Google-Smtp-Source: AGHT+IG7RAVkIJjVw7xUbobf37G034XwckIGwgQWv5t5xDoFt9IYQgRdkdt45+vOH2SoT3oJjRGB+w==
X-Received: by 2002:a17:903:186:b0:216:1cfa:2bbf with SMTP id
 d9443c01a7336-221a0015683mr407308615ad.35.1740592773096; 
 Wed, 26 Feb 2025 09:59:33 -0800 (PST)
Received: from [10.254.143.227] ([172.56.201.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a000558sm35776315ad.25.2025.02.26.09.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:59:32 -0800 (PST)
Message-ID: <7b2c2bf9-7bcc-4a88-8db2-84b91e0ccd52@linaro.org>
Date: Wed, 26 Feb 2025 09:59:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cputlb: introduce tlb_flush_other_cpu for reset use
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-4-alex.bennee@linaro.org>
 <d033b2d7-a2b6-4ed8-ac46-85b52d46f8ea@linaro.org>
 <877c5c4w4g.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <877c5c4w4g.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/26/25 06:29, Alex Bennée wrote:
> I guess we want something like:
> 
> 
> /* tlb_reset() - reset the TLB when the CPU is not running
>   * cs: the cpu
>   *
>   * Only to be used when the CPU is definitely not running
>   */
> 
> void tlb_reset(CPUState *cs) {
>       g_assert(cs->cpu_stopped);
> 
>      for (i = 0; i < NB_MMU_MODES; i++) {
>          tlb_mmu_flush_locked(&cpu->neg.tlb.d[i], &cpu->neg.tlb.f[i]);
>      }
> }
> 
> ?

I like the name, and the separate assert.
I'm not convinced skipping the tlb resize and (especially) accounting is a good idea.

I suspect that the tlb_flush_by_mmuidx_async_work should be split vs its 
assert_cpu_is_self, and you just should use that.  I'll note that tcg_cpu_reset_hold and 
tlb_flush_by_mmuidx_async_work both call tcg_flush_jmp_cache, so we've got a double-flush 
in there.

If you don't want to use tlb_flush_by_mmuidx_async_work, I think you need at minimum

- take the lock
- tlb_window_reset()
- honor and update cpu->neg.tlb.c.dirty


r~

