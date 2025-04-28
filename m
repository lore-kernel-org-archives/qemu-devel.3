Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB04EC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Ure-0003zD-MM; Mon, 28 Apr 2025 16:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9Urd-0003uJ-Go
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:14:05 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9Urb-00019W-Gy
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:14:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so4879980b3a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871242; x=1746476042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oAueiFEEQE1PvEMVBEFmCF88YbRq90ZRfOcIcELa84I=;
 b=En17fq2mEZZs1CONkOu5hyTkd/PYpw0fQBocPiuctQqHRcbKnx6mBQDQ0bCpS5HgIt
 87RpNPWaw95awAdQaJmz23lSq1zs5Na+5XOjvh7d51p9vAr1JYkgCMqVAC3BNrBeSsSG
 hL2+jFGYRxrQV1j9pDioDyKWHQVly9tAzt0PtRRj6Hegp+mDO9xpPJkjvVNMC1Tl1we6
 x3tFzjZRj2fYEseeGwIFNggssGI4hs5AavUkLBPzwEfzQNj0meklDC0YkHYx45qx3f+5
 oBtaIUAPeMd1U9KSNexOCHi3vj03s3Jusv1d3Xm6rNtecuOc0P75hHVD3I/snm+pkKuU
 JGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871242; x=1746476042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oAueiFEEQE1PvEMVBEFmCF88YbRq90ZRfOcIcELa84I=;
 b=aqETnSwAKr+n6VxwbTKs0gAHg1/bC5NDmjDxSc+xmb8kkkRvTt78Plav9dDNz3GKIM
 VJGd6Bje/94WDiedeMmrvHBAQd1WrkU8CPCcPPUPPr5FzhMBfHVe1Q8H9WEYRCZVzDA6
 szKwL3buPYSgbPhFuviCVlVLrnyRpjXt8yPH6EZQSzDWLXgPM/oqO7ia6L6JelD0kp7K
 YtUMMCEH+6uSJSSXkcxNQWUmc+2kvcSeT6BTeZ04es2d+Om2XIDTayScQYQYkE7pUrw+
 brecqtccf5Li+P+EWlGFtdGEbJSAJYSr0Yyc4yPfCSTEvoVguuAFAexTomhIJjesx+gL
 GU7Q==
X-Gm-Message-State: AOJu0YyvURJ48zQUWEJsxjPdlQF1njFXciSE0WSFqFRIyYe4ujjWfDEJ
 AB2fu8C2r6yLYNywyl5kyQ5JeUbTKkkl5/i4/1m5fInjR6zikbMf5Fl6OLsZpq8=
X-Gm-Gg: ASbGnctffFY3NrPFdg/vJFNHDMYKbikhg5otA0QebtAtrY0RclFfDsfLagiTSayMiIH
 PKf7SN/pErK1fGhE7cXXw87YIYXziC8OZSsjgkXPF2T2CMNPcfdftX780mf0IYe6jgQMTrCoutM
 4jUBdwbULag9EwJPUujtikYbU2BQaxI7nmZrFopuDPeVkoKtKFytwaokg6HmzYheOtz/h+cOpew
 G/wKg7E3EaFcl28yoVJfudVdaIr5nQC2MCNQHoDq3ix/PA9Q8TkDATpikdeSn3m0v6T+YMteuBE
 GkcpjdmeZL1a8aKwm0cKs8O2b4Z5Cwd58PHQUjxAGxrdHqzQYlM5a8uXQB1VoTqj2uV7zlHzk2U
 Bm22+lJs=
X-Google-Smtp-Source: AGHT+IFZwnkxj/SqRuyDGV+hzkio4tvrAr+08Y1yVV+dyVQbiy6YDOLiXO/1qXIVhiQCp8U+S9F51w==
X-Received: by 2002:a05:6a00:240f:b0:730:7600:aeab with SMTP id
 d2e1a72fcca58-74029470471mr450643b3a.13.1745871241706; 
 Mon, 28 Apr 2025 13:14:01 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9fd26sm8432260b3a.151.2025.04.28.13.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 13:14:01 -0700 (PDT)
Message-ID: <1f6c0738-6bbe-4608-956e-d94ca89b53d0@linaro.org>
Date: Mon, 28 Apr 2025 13:13:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] physmem: Restrict TCG IOTLB code to TCG accel
To: Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
 <20250424202412.91612-12-philmd@linaro.org>
 <cao656ggvonu2gwwcrpu5n23nfa2epmdr6v2str4pwofhzoypo@mmbjpmvzkdxe>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cao656ggvonu2gwwcrpu5n23nfa2epmdr6v2str4pwofhzoypo@mmbjpmvzkdxe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/28/25 11:51, Anton Johansson wrote:
> On 24/04/25, Philippe Mathieu-Daudé wrote:
>> Restrict iotlb_to_section(), address_space_translate_for_iotlb()
>> and memory_region_section_get_iotlb() to TCG. Declare them in
>> the new "accel/tcg/iommu.h" header. Declare iotlb_to_section()
>> using the MemoryRegionSection typedef.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   MAINTAINERS               |  2 +-
>>   include/accel/tcg/iommu.h | 41 +++++++++++++++++++++++++++++++++++++++
>>   include/exec/exec-all.h   | 26 -------------------------
>>   accel/tcg/cputlb.c        |  1 +
>>   system/physmem.c          |  5 +++++
>>   5 files changed, 48 insertions(+), 27 deletions(-)
>>   create mode 100644 include/accel/tcg/iommu.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 661a47db5ac..3a37cc73af7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -168,7 +168,7 @@ F: include/exec/helper*.h.inc
>>   F: include/exec/helper-info.c.inc
>>   F: include/exec/page-protection.h
>>   F: include/system/tcg.h
>> -F: include/accel/tcg/cpu-ops.h
>> +F: include/accel/tcg/
>>   F: host/include/*/host/cpuinfo.h
>>   F: util/cpuinfo-*.c
>>   F: include/tcg/
>> diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
>> new file mode 100644
>> index 00000000000..90cfd6c0ed1
>> --- /dev/null
>> +++ b/include/accel/tcg/iommu.h
>> @@ -0,0 +1,41 @@
>> +/*
>> + * TCG IOMMU translations.
>> + *
>> + * Copyright (c) 2003 Fabrice Bellard
>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>> + */
>> +#ifndef ACCEL_TCG_IOMMU_H
>> +#define ACCEL_TCG_IOMMU_H
>> +
>> +#ifdef CONFIG_USER_ONLY
>> +#error Cannot include accel/tcg/iommu.h from user emulation
>> +#endif
>> +
>> +#include "exec/hwaddr.h"
>> +#include "exec/memattrs.h"
> 
> Missing qemu/typedefs.h include

No, that's always done by qemu/osdep.h in the c file.


r~

