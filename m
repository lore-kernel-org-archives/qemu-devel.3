Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DEEFAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 03:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFkOF-0003pD-CY; Wed, 22 Apr 2026 23:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFkOC-0003oR-Ve
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 23:06:04 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFkOA-0005hL-KV
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 23:06:04 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8e8c0c2d2bcso49825485a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776913561; x=1777518361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KkzDB76SM335oBGZ8vED/OKx/xQFvkM/vpw9G5grgPc=;
 b=AgKYqbU2UBSRr5hcAtvGGkCx7MvgxteLRvWMp+jt5Oj1x5KmECF4r5htu35zr9tDcl
 fO8B9GMSpesIofyvp/tr3XoNne+KPUvvDqJYqWEBRpIRQU4GsgatK7IlvyLcW70ClNSO
 kZ5FXqhbdQ9663aE/kcvTNagPt1X32qpi7+HVUYRCvgvH2wMes0J4Aa7pSJGooZ7cc00
 2tlcgbExBKyvKQ5LDK8Dj+v5fbby/16ZKUrOLnJ54NIzJvgUhTZuq/VdT72mV5UB6oR6
 y88Gmr0tXKLaNi0/IkigL53k21G6G6LAhTOQzvETcXWGZWx/JQR9AhferrCVOQ4igIQF
 qBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776913561; x=1777518361;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KkzDB76SM335oBGZ8vED/OKx/xQFvkM/vpw9G5grgPc=;
 b=JP81OBmrg5RksTwZs0FAl5J0600ARH8MJ6tvLmN9RQp6vpvof82pfBcs1jgyUlGq/p
 Z+/lS1YOULyR42zGAM5D9K/v0MSKchVYw2G6S2htWm4KP/lYhwmc49SvraJvPeLPQTCw
 pwgeT5rCbWwPFTO5dXr1ejk6sx77VjkeqQ5Leakv2/HU5IRk+LN/tIUy+k31w353JKe2
 gt8G7XNNdSd5BCjr+EM7mQ6VkrgEIN6JEiJLYj/aTL1GeTCcHR5ZeP+d4H+cyNwBCu7f
 Fa1psGXlb83l7emzR/dAiSCi3F4UUyhGlJGyoVzP7KvvKXOJmYaaQxeSnqsyh+AUnN4b
 jgHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UGq/gztdlSV9dCTyd++ZtPqhI6hzM5/MgVDt5616OfIsik7tqwGo1DwQb61logAK2aWjCq2ko9P9E@nongnu.org
X-Gm-Message-State: AOJu0Yyv72t3LpWh4lzFyC2D2ev6HACCSiaSR7+srLgtd2AEowzaUJW8
 26vZiQ6lAM3GWh/KhmsWya4+z8Pfv733gvkCXWz5bL64m6ReBeqeVQ07RhF0Dj4xlgY=
X-Gm-Gg: AeBDieuybX62g2DCRvvD4gZTF41sjs5Zr6cqFSGnq76eRnv3IISFJwqcuq0uCP2YETL
 QcjQ2r4iuVTvnxXSWz193e3lxeTRUjpS9oVBJezmVCifBFcRRrInRS2ekxyKniCDj7IanMvZHhH
 KK7P84oqsbFWhqbr7r1MeTzksnR0SqNDHmT3+KmyrSB50TX/f/q+XyNba9SYVkGBFoXCLtXHtWD
 m84EpdcibTu3LKKue33Owg0cUn5yglwRF6Fl2esEhNg5A3aW+ua5F+ok7yNWkdsZfrCXPMoCz1j
 oCFBQi9wcW/TvfV3YyaPFKtOGgsO2SWuMapAJzkYAa/S/yBHwiwPsppYKgBG38FUk5uyAgv6ffC
 guAmNWjLuCRtJivJf3xTrNkNR1tyZYkdDch+vWhZu5ND0eh8ihNQt/pvzaVpL/Khl/+ohc7m59/
 ZbGTBF3SWLePWryL3z1T3UXKdFRASr22F41tOqHoSLgfxUoSo7BCUxS1eHWQvMEl5B0rQXfUkf7
 pFRBr+sjUZ2Q0dnLQ0aKsHazQ7a5SGzBNSqoM8=
X-Received: by 2002:a05:620a:4612:b0:8e0:f680:4b34 with SMTP id
 af79cd13be357-8e78f253bb2mr3385584285a.1.1776913560741; 
 Wed, 22 Apr 2026 20:06:00 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d92ce037sm1448408685a.32.2026.04.22.20.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 20:06:00 -0700 (PDT)
Message-ID: <09da5690-5b9a-4930-8fd5-cecf1e3b8eb2@linaro.org>
Date: Thu, 23 Apr 2026 13:05:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] hw/core: Implement new cpu_translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x735.google.com
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

On 4/18/26 03:31, Peter Maydell wrote:
> In cpu_memory_rw_debug() we need to do a virtual-to-physical address
> translation for debug access.  Currently we assume that the
> translation is valid for an entire guest page, but this may not be
> true if the target implements some protection regions that have
> sub-page granularity. (Currently the only such target is the Arm
> CPUs when using an MPU, as in R-profile and M-profile.)

RISC-V has sub-page granularity via Physical Memory Protection (target/riscv/pmp.c).

> +bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
> +                             TranslateForDebugResult *result)

Whee!  Thanks for the new API to address my comment vs patch 10.

> +{
> +    if (cpu->cc->sysemu_ops->translate_for_debug) {
> +        return cpu->cc->sysemu_ops->translate_for_debug(cpu, addr, result);
> +    } else {
> +        /* Fallbacks for CPUs which don't implement translate_for_debug */
> +        if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
> +            result->physaddr =
> +                cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
> +                                                               &result->attrs);
> +        } else {
> +            result->physaddr
> +                = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
> +            result->attrs = MEMTXATTRS_UNSPECIFIED;
> +        }

We should really make a point of getting rid of the fallbacks.

Would it be less churn to drop the get_phys_page_debug to get_phys_addr_debug rename, and 
OR in the page offset here?  That plugs the -1 ambiguity in the short term.

I realize that microblaze must be converted to the new hook, because of its tlb oddity.

With arm and microblaze converted, only x86 still has get_phys_page_attrs_debug, so that's 
an easy hook to eliminate.  We can be slower about converting the others if you prefer.


> +        if (result->physaddr == -1) {
> +            return false;
> +        }
> +        /* Indicate that this is a debug access. */
> +        result->attrs.debug = 1;

Does MEMTXATTRS_UNSPECIFIED.debug make sense?

> +        /*
> +         * Assume memory access permissions are valid for the whole page.
> +         * Targets where this isn't true should implement the
> +         * translate_for_debug method.
> +         */
> +        result->lg_page_size = TARGET_PAGE_SIZE;

TARGET_PAGE_BITS.


r~

