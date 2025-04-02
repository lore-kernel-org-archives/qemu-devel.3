Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E81BC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 18:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u02ty-0006sI-04; Wed, 02 Apr 2025 14:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u02tv-0006s1-9z
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:33:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u02tt-00025C-EH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:33:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224100e9a5cso1483575ad.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743618799; x=1744223599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ECUTKnZAfuBkcvEoF+NZCdNB5CHjfGag8e8Z5V7vu2w=;
 b=SdgyZoWL2okzigpIDaPMKsLF257O4xuPLj+2L5i4dBn75C5k0hsKGA1HLi5AByRBV4
 XQuwLCCOvdgl1ifKhREpTchloE6VOGTtBQQydlkBtB3dxYIZ/FSaEieIqvhhss/PawTp
 M63FgPSsehw/H0bFn1eGYBxWG7pyiiUx+X7ouTjhzhmiumBjbIpGHqrkjDBYqjYMw3MA
 eKW9kzSzfcqTF6giFvTaZA65pHBoD2aW84VZPZss3DPNOjIa7sKnUvaNkWkztvUX4q24
 0fFUIqczs84kupjce2QilkT1sw2Iv6jkbHr7N0a/ZJQE51Prl1bW5aCBgoeR5ZRINayq
 Y9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743618799; x=1744223599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ECUTKnZAfuBkcvEoF+NZCdNB5CHjfGag8e8Z5V7vu2w=;
 b=C/s9PGlgnf4YNRQWz/p5Bmu73BN9hXfc8y+c4QRoXel2pYiIk0rm20VMG04PRTk2u/
 7NX3pz+VVvsMkzJ8498vv0W79+QC0l3q/nZbUN/LVwsD+DxfWv9durZ+ReSMgpDz2QCt
 Tp7qs7lKvMhCN6cIFvsPLgEbq/UCUbVcHvVoQ524S8CRYNVWMjDBhwggPkCgh1xT8Slb
 y5J5hsfLNgdLJrYABImKEV1GWt5k0Nfd8aASlLYcuKhXIWbPLi/kkxs2Idwam4JV6Ic2
 dJRvgmv3B0JgdtFipTPRv7JgLheruKgUverwX2wdcgC4JLLaaAfQS0riCVXVKAR4zEj7
 obZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA2tPLW0/ma5F4iCjBCAFEjta3WcY7zqTHnlgs4vSDqte7Dirb6wZf8jcrxaXVvLTDlOELCOLB838p@nongnu.org
X-Gm-Message-State: AOJu0YyKEntCxGtBl0Z4egAay4d5XY8LNS2BX9bhXABm5fnkUG5gFOKe
 txSZGCtthCxmqSsJY7vLzIrZosnsTamjrM71HisjeOHM6i8Iv0khJi5eVrZhT8g91pZi2zU2beH
 Y
X-Gm-Gg: ASbGncvz9bJ4Fgigufb9dbL5NSUaVpynO9hxg+kQsGlwiM2kB0Dge0rM8G5JZOWOBhS
 /qwEKrwccQgldACuTSSCbqK4qxK+slo4gCwfndfWBgE7YVebZBTYQAC3oV/fsR8SfVcWMVvmZQ1
 9KWTOQ1m96ycaGPqXUKoNEofv9HdLpEbrdG0vEI6T0tcY7EXt78LWuon+tdQ0hCJQdd2Pt/HczY
 3LnPo+rqV0mqTwxZyH9x6oIjVvQNAqVSBpEW9mL8qMd4qM+2zRHwnvWCugkBU3sdrKup2G5kxEb
 u4/KY8uzN/vDuv1C+igP9Br3aWpWFa+VUj3GHnVn01xVwKerAYrqZdUyBiYzVaChKgDxEq0/ZfH
 VsoXmjDAm
X-Google-Smtp-Source: AGHT+IH3wmFQnRbc+oeHX4uihYf7F1LMTUJanO5N+CvISdeQkyc3qz6KVSu5Mtgz+un4EEP2sI5c4w==
X-Received: by 2002:a17:902:e74f:b0:224:3c9:19ae with SMTP id
 d9443c01a7336-2292f9de650mr309158315ad.34.1743618799214; 
 Wed, 02 Apr 2025 11:33:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f9240sm111563615ad.236.2025.04.02.11.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 11:33:18 -0700 (PDT)
Message-ID: <d6a62a7c-b857-45bf-b7f4-5a8863ce5b6c@linaro.org>
Date: Wed, 2 Apr 2025 11:33:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-7-richard.henderson@linaro.org>
 <7fbd71b6-8642-4374-a573-c9cc693e381c@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7fbd71b6-8642-4374-a573-c9cc693e381c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/2/25 04:26, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 18/3/25 22:31, Richard Henderson wrote:
>> The implementation of cpu_mmu_index was split between cpu-common.h
>> and cpu-all.h, depending on CONFIG_USER_ONLY.  We already have the
>> plumbing common to user and system mode.  Using MMU_USER_IDX
>> requires the cpu.h for a specific target, and so is restricted to
>> when we're compiling per-target.
>>
>> Include the new header only where needed.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/cpu-all.h        |  6 ------
>>   include/exec/cpu-common.h     | 20 ------------------
>>   include/exec/cpu-mmu-index.h  | 39 +++++++++++++++++++++++++++++++++++
>>   include/exec/cpu_ldst.h       |  1 +
>>   semihosting/uaccess.c         |  1 +
>>   target/arm/gdbstub64.c        |  3 +++
>>   target/hppa/mem_helper.c      |  1 +
>>   target/i386/tcg/translate.c   |  1 +
>>   target/loongarch/cpu_helper.c |  1 +
>>   target/microblaze/helper.c    |  1 +
>>   target/microblaze/mmu.c       |  1 +
>>   target/openrisc/translate.c   |  1 +
>>   target/sparc/cpu.c            |  1 +
>>   target/sparc/mmu_helper.c     |  1 +
>>   target/tricore/helper.c       |  1 +
>>   target/xtensa/mmu_helper.c    |  1 +
>>   16 files changed, 54 insertions(+), 26 deletions(-)
>>   create mode 100644 include/exec/cpu-mmu-index.h
> 
> 
>> diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
>> new file mode 100644
>> index 0000000000..b46e622048
>> --- /dev/null
>> +++ b/include/exec/cpu-mmu-index.h
>> @@ -0,0 +1,39 @@
>> +/*
>> + * cpu_mmu_index()
>> + *
>> + *  Copyright (c) 2003 Fabrice Bellard
>> + *
>> + * SPDX-License-Identifier: LGPL-2.1+
>> + */
>> +
>> +#ifndef EXEC_CPU_MMU_INDEX_H
>> +#define EXEC_CPU_MMU_INDEX_H
>> +
>> +#include "hw/core/cpu.h"
>> +#include "tcg/debug-assert.h"
>> +#ifdef COMPILING_PER_TARGET
>> +#include "cpu.h"
> 
> IIUC we only need "cpu.h" on user emulation. Maybe use:
> 
>    #if defined(COMPILING_PER_TARGET) && defined(CONFIG_USER_ONLY)

Can't.

>> +#ifdef COMPILING_PER_TARGET
>> +# ifdef CONFIG_USER_ONLY

It would have to be this nesting, for the poisoning.


r~

