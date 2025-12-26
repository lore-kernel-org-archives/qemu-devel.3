Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6326AE8FDA8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 11:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ68d-0006Pa-Ti; Fri, 26 Dec 2025 06:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ68c-0006Ok-32
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:37:42 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ68a-0002Q6-BN
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:37:41 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso45315895e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 03:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766749058; x=1767353858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yiBGZCG5mTJoae0Mk4duAMkJ9xuDW3gIF4Zs7lMmn64=;
 b=MDzjUOzYqGrC5wyg7z4livcghXJr9+hgMxFad2fMyzQZtOjg4iTyOKcc+XRfq6qNhb
 jW0F+3fiYyu4iSz1HU7vssHGd3m4yc7j/8Kdjkqc750lCtYMn6P3FlvU6sVfF1XfdAWv
 uUrbo2hWbJii0lh1rbmtAGmFcnReit7cZihR6G9YHxEYvlJC7t4u/79wgq7RAb2/Q9oH
 Kd1GXLu4+4UALBfE+N8VgcKkG91KHZWO0nqq/BibzymfvE9IqSyzrxKUkb+d6rgBqPtA
 A8hgvYvwqy83niY1Zdc0kVx/fCqP7sBTjz8NL9ufEwpVe/3r6EYEWJhMIOz+wIRRioZJ
 LC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766749058; x=1767353858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yiBGZCG5mTJoae0Mk4duAMkJ9xuDW3gIF4Zs7lMmn64=;
 b=ubDGFUx5zd8Z9E/ELHEY2U/TiZATeBhzv8T4k38cpuVRKWVzt+piBs44iExEy0VonC
 LNUD09MQj7OMXpF8XiOcio/yqH7EXprES/2f88boXaQMKJVYVcya8eCDd3MPUxQ5FKwC
 LoOjNVmh9lL2xRq5BwZkFF64omAAX6p3PgdeyHhPfiIHnxbvEbyXF/hODfsiAiZd74SN
 QvFQJoU2oKNzXRMK0b8IliCVH/wmir1mnrodHVcGfHTzYKwNZsOTHnaxED5yzTAIXN7W
 HgeltGw5dDpIAURnEyGUQz2oYaNhGrjEwglmpa4nPeOExrgwt1BVmcTzx1kBxIg4gc2o
 baRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbyEhyHcLMtJd13sswv5G6/V2UI9gtkLFLlHFufsoAhdKNzvRpvAn7c2E40I86jRpH/Wlp8A3/3UnU@nongnu.org
X-Gm-Message-State: AOJu0YyRLmoHmF1LXWgiem7PWVo2+Lvx7tE6qqdvtlWbw2Jh6UGAQXN2
 6cKxtBCN45go3ruzkyXzVmoqcVleFmsvriR1Q8+9kSVmWEobUdOcKnvyH+fjKQW7tWnT9kb+vLg
 kbwkr
X-Gm-Gg: AY/fxX4W8LuwVliO4LPJeb128Kf0/G52X7PcfW2i2gwX+LQI9lJ023o8AtKfUB4zai4
 zODsdmd3rfPAInBSgHMrWxj2arTLS27yv9ss2XPpLRcprypGtSnWqWKSXtkGLnn04b8zecLZklP
 MZ28uwLJ3RxiWvQlRsJFMwCBksGmVa71HdSKalDYRbQvljKlZHCor8LXu1iwh5sVtnmqhFtJl0x
 jAIIUY84Io2gBpLDAPDDgQk3PDBMihe5eTTfTjTLDRtpMeUHhywAp6muw98PwgECzFzeACr3zvn
 gARz5X6hqbQEaGOofse6aTIA9kz3gvCE6fav9HZeoQ75rPSdBRxVErlc5rBAp6ix/fkdu/xGdIv
 0GtjfH7cpTwz/J0idRd4hGdtZp9Nf66iUPYEbeFVe+Lgn2VhV8hxQZbPqx0WwWhz63Yfj+Zrynz
 rX3yurLbM11SKS9G/qzj4II798bIScjhKS0DEuaBv5w8oUyprF6OismEhqK6H7mA==
X-Google-Smtp-Source: AGHT+IEb0TENAiCIRO+QT/Oc/4eF5b/luQ8MC8Px4lC1aBR+MnUr5Kl0wpqBUjEQ1dYtzyg7r1zrGQ==
X-Received: by 2002:adf:f18c:0:b0:432:8036:4a0e with SMTP id
 ffacd0b85a97d-43280364b6dmr3235876f8f.35.1766749058527; 
 Fri, 26 Dec 2025 03:37:38 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab257asm45736019f8f.38.2025.12.26.03.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 03:37:37 -0800 (PST)
Message-ID: <e7e0807a-1d80-4067-b2b9-7f01e89f34c1@linaro.org>
Date: Fri, 26 Dec 2025 12:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] target/loongarch: Use explicit little-endian LD/ST API
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
 <cf98f635-b1d9-942e-bdef-be8c260f764d@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cf98f635-b1d9-942e-bdef-be8c260f764d@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/12/25 03:17, Bibo Mao wrote:
> 
> 
> On 2025/12/25 上午12:14, Philippe Mathieu-Daudé wrote:
>> LoongArch is little-endian. Use the explicit 'little'
>> endianness instead of the 'native' one.
>> Remove some target_ulong uses. Forbid further uses of
>> legacy APIs.
>>
>> tag: https://gitlab.com/philmd/qemu/-/tags/endian_loongarch-v1
>> CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066
>>
>> Philippe Mathieu-Daudé (8):
>>    hw/loongarch: Use explicit little-endian LD/ST API
>>    target/loongarch: Replace target_ulong -> uint64_t for DMW and
>>      TLBRBADV
>>    target/loongarch: Use hwaddr type for physical addresses
>>    target/loongarch: Replace MO_TE -> MO_LE
>>    target/loongarch: Inline cpu_ldl_code() call in cpu_do_interrupt()
>>    target/loongarch: Use explicit little-endian LD/ST API
>>    target/loongarch: Inline translator_ldl()
>>    configs/targets: Forbid LoongArch to use legacy native endianness APIs
>>
>>   configs/targets/loongarch64-linux-user.mak    |  1 +
>>   configs/targets/loongarch64-softmmu.mak       |  1 +
>>   hw/loongarch/virt.c                           | 18 ++---
>>   target/loongarch/cpu_helper.c                 | 12 +--
>>   target/loongarch/tcg/iocsr_helper.c           | 24 +++---
>>   target/loongarch/tcg/tcg_cpu.c                |  4 +-
>>   target/loongarch/tcg/tlb_helper.c             | 10 ++-
>>   target/loongarch/tcg/translate.c              |  3 +-
>>   .../tcg/insn_trans/trans_atomic.c.inc         | 80 +++++++++----------
>>   .../tcg/insn_trans/trans_fmemory.c.inc        | 32 ++++----
>>   .../tcg/insn_trans/trans_memory.c.inc         | 64 +++++++--------
>>   .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++--
>>   12 files changed, 136 insertions(+), 129 deletions(-)
>>
> Thanks for doing this on LoongArch, this series looks good to me.

Thanks. Low hanging fruit, so better to clean it now (by blocking
further legacy API uses) than later. These changes makes LoongArch
closer to be used in heterogenous setup :)

> 
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> 


