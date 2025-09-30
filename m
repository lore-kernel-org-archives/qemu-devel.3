Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2732DCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3grr-0001PU-4a; Tue, 30 Sep 2025 16:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3grl-0001Mu-Go
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:22:32 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3grX-0005wA-Qy
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:22:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-27edcbcd158so67668345ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759263731; x=1759868531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AW6j4WJn0Sb1B8NuExZQmk+9T/YOlnAgB256+MT3Lzk=;
 b=KvkoInnOcM3spdvLpW4EeSMGJGu+083ji4CEtV6k6cmXvG6WW0YS5ct1MvQv0j7VD9
 +dhtlME+7Yu2ilSohKux3FQjNgD80mLFvOtwkC/zkknVEkLaSPP2y4zZkYNhJEoyqoFR
 Ar7ZM6ftQvTcEv8XBppDx8ICI7PmhvZKAZjsH5gLlVoY4rt25r2hH78NzilcDyzYl5NL
 nSV2yeAJ2f8UUgbtK7nx+65RRVplLcItXSQWWpUkvuR8jK4uXYzL6Vgb8mNQa/xRAF2j
 qM3M1YHNFAZ+ZM78qoI3hxrgdnSO0fuMr7W6uYQuT7AVHJACk8Bxx0DnywoeOCwSn/Mn
 iDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263731; x=1759868531;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AW6j4WJn0Sb1B8NuExZQmk+9T/YOlnAgB256+MT3Lzk=;
 b=XMG8Tb7nznWBvMQLIELuHVaWESpSZFtvC9r41m+LufmhrMQC0sZYxyO9VjF17JtD8v
 rypcNocvicqsiiVEDLJZd4STmjXWiIF1fBif6YAcA1mkE6t1jCaKTFF2EBQS+oSIiLHW
 EKV2zOa28GVGgceSNpfRzc17iFejanAXF31AhqO5KjUDl+eLnea5SFq5taSaoLj+2Cze
 fFvKzzFTU8QJeChVt6uyt4wa2qk31Z8VkK/uA1vmn2Ta2eWDRf5iSFJGNLRO5mAd4rgd
 lnrOLAZdqDJCzm5urG+ZuigprAPJmQb3We3NaMwiR3BAcD943yDSQ4kUX6Yw0RuYE8Id
 NKKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxg3GUOUPnVo42pV9xe2H15CEGnJxTs04xx9yFlwQ7kGK5E5sF+NolpeR42XS+7asa6fcHnqLPZr6O@nongnu.org
X-Gm-Message-State: AOJu0Yyf00o8VfP4a18AFDvOPP6GthGHV+CsQpTFoYf3tNRru1V/AhPN
 Dm22mmDLOYRK+9IKftgwUO6RpePWvA1X1CDxSk4m12HXKaa8LsjPBRhKk2ebpQrqT77bw3/S3vY
 7WrticZMGsA==
X-Gm-Gg: ASbGncuWPjpgpZyaZOqukrxHlPDuooPszuMEfePzSHuqM6XFAmhk+ELQq9WS/94Ioyw
 ivSq+GNaMRGrR+XYL4SVt3yUf2CEGZCSbyONRayIiV0K63e3zP2aPtFv/mEG+nw/TAy4szkr2Uf
 P222s7vMUyXcw8zKetxij1GXCduhQu6wNbFbD7ffmteO4iEirDTp4KXSA1KLEbhvLjb9dVDkpAO
 dhX8XHAaAppFOvIe/Fwab/cin7DG8LDu0jCPtj35YlobNah9EIK8aPHkRWZpjcwkl8S/U4cSekd
 w4nB5zogKyLz19i5KcoyXFO7doJDpcdxtgqUtSn6BIRvljOfsAEhiW9IqPpX7DQ6z+cIWMbP8LA
 7b5TERzQ21q857L6cr0MzVRM52rKg/s985aM1z9jJMnYUeVkO6YGBwLoWTT3s
X-Google-Smtp-Source: AGHT+IHPuYG8mZX+VkXAaDSfwaBJMeNYDcvtpH3rcxxMoWkYXiXU2T/bmo40Zj02HOba/iWyi0aVXw==
X-Received: by 2002:a17:902:d4c2:b0:271:5bde:697e with SMTP id
 d9443c01a7336-28e7f2f5ebfmr12564345ad.3.1759263730846; 
 Tue, 30 Sep 2025 13:22:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6727ea7sm167896275ad.61.2025.09.30.13.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:22:10 -0700 (PDT)
Message-ID: <41a0aa9e-21b1-4dd9-9294-6ca3dd46288a@linaro.org>
Date: Tue, 30 Sep 2025 13:22:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/18] target/s390x/mmu: Replace [cpu_physical_memory
 -> address_space]_rw()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> When cpu_address_space_init() isn't called during vCPU creation,
> its single address space is the global &address_space_memory.
> 
> As s390x boards don't call cpu_address_space_init(),
> cpu_get_address_space(CPU(cpu), 0) returns &address_space_memory.
> 
> We can then replace cpu_physical_memory_rw() by the semantically
> equivalent address_space_rw() call.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/s390x/mmu_helper.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

