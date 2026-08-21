Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36222C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxWSV-0007xv-Gf; Fri, 21 Aug 2026 17:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxWST-0007xE-D8
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 17:07:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxWSR-0001es-Qy
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 17:07:25 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ccf2360620so13188065ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787346442; x=1787951242; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZUiSq8PsvavJBFzHfD6KJmOqkADBjSEXe9SnRzZnEAk=;
 b=GjURinTsNm9XjZTxYOGy9+HIk+rKAZsqLmMk1xJ9cLJx2rrFoH9dK4khmMTnj5bXSU
 X1heyxJseRBSD/ehfzZKOHpA7dCmoFYnx3tlLUALnIcyNxPWAvym31NwOvcSQmvQiegR
 FgCm2fYX9dLnRnOWo3Mb2JWCasfouGxKxSd/Zp5XcYMW3uTvihCfYmlK7GEGTY9Q5pNz
 jTBwoQUM2fbGN7JiOJMbNUjjExt1FJpdQ8Z9Qj0kjmzAWqGApr7ZvT7HFu7T+N+XYUg3
 yfIBWHifDIvNvgGELI+KWg+pkVXFyv6ydYcyjC4vkgJ0fAuhgHzFM9SUPKJUO9G5ZN+9
 oemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787346442; x=1787951242;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZUiSq8PsvavJBFzHfD6KJmOqkADBjSEXe9SnRzZnEAk=;
 b=XK53xbFm5ZJ/QTSPrDis/5x6NbDrFNf7D25iHaFEju7cbbUkamaGiXmtXw85yu9mIt
 9FpmRpm9UQHDuY+8M90sKjOv1UFXVQVmr49cg0PsHGpmKmokJSeedDIT5MPUW4MJftnr
 +7fVny4V2cHazlEaypXIf3pEf9iPaiQNvUZo6fr4GcLoytxHKBFSwtNTxDzffJr/+ulG
 wB1UQHyJbiPJskq7W3y7qnIbWMGWzUGmOuw1pfJQy870hxbPL5xav5upyVyP/+thnzQE
 gYA+c3ARPT6rhsuFYX19ylk2uXxJ6Vtv4j084UeuUnAVmTem9UxLoBTbUu1ZDPLEeqMb
 ckcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqaz+s+0Ac9LuPKpmassnBHVDg5hmBkyLzOjP3y1UlxiDXDQ5Kj76kzz+kGDLU1AUwE37uq8mp+uX56@nongnu.org
X-Gm-Message-State: AFuF++nXzwRvtMuobJBJ56ZK9TRJx1qBL1NS6R9hNhoK5lOsQw2D32zu
 1sAEIUxMIg/GPQl+Vz+YFygSBw7v9ZY7vOBmIc90ZAORhZopo30d8MPuRIVnTtvY95I=
X-Gm-Gg: AR+sD12Nyxix+zBhUk0mfKq9+K05UTSrR9CLuxxhUwFSYqALGzR44gGHTfJUzIs1Lii
 SmWKXGP5iQy2y3K6TKcp00SEvbwFN1BpjZ44YdaA9OwaqC2UtgJ0xKXcsBPiiIoVzhFBcsi4Clm
 8BjWCDCUwmGR/Q7vkV31Kh7RZSBHK5JbAkrj44koM7HCqh5XnhWDX5XbdYBfwhbkIlZxvQ6WZoA
 JGLiJbe0UAYhQQQ+nPnpWaM+5iJnn/IaSMnK9Zv3oynr0pBldXW35p8nn4FoCNPKvIPVCSgOgV+
 zK9uttCQbYDIUMh0mNpc/WndZy9tux5cBM5ftMO0zkJFc8HiKP80+jKDw+/XMJI2PaUgAeRIRJ+
 +YswGh7KsV9Y+v0AKzoZyQ8zCN9qk2hGz3oSRq8ci6xBzqHheFKuGjsJt3xN7aB0ZV6hZh4SFDd
 KXGYRYUA0uCmIfPpA4qLWuzonMD46G9XIpuHEdGBIhGfjFUJGkpifK3LF5Aybg5waCePQiUWgAV
 AFgVniFCiFBtnRKD8KZTTtXacXKCYqjfrl4DLurcSzUl2fN4A==
X-Received: by 2002:a17:90b:54d0:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-395c353ee4amr18153913a91.6.1787346442074; 
 Fri, 21 Aug 2026 14:07:22 -0700 (PDT)
Received: from ?IPV6:2607:fb90:339b:bfd7:dac5:d94a:debc:5ef7?
 ([2607:fb90:339b:bfd7:dac5:d94a:debc:5ef7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e494fa73sm199595a91.4.2026.08.21.14.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 14:07:21 -0700 (PDT)
Message-ID: <180ce662-a0e8-4b03-9a7b-1b6d4feab0b2@linaro.org>
Date: Fri, 21 Aug 2026 14:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/18] accel/tcg: Replace size with first/last in
 TCGCPUOps.tlb_fill*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-13-richard.henderson@linaro.org>
 <26a073f0-9e8e-40c1-97dc-6b420740e20a@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <26a073f0-9e8e-40c1-97dc-6b420740e20a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/16/26 08:17, Philippe Mathieu-Daudé wrote:
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 0ddd898e6e..bfcd9b6159 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -666,11 +666,13 @@ static const char *access_type_names[] = { "MMU_DATA_LOAD ", 
>> "MMU_DATA_STORE",
>>   static const char *mmu_idx_names[] = { "MMU_USER_IDX", "MMU_GUEST_IDX",
>>                                          "MMU_KERNEL_IDX" };
>> -static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
>> -                             MMUAccessType access_type, int mmu_idx, bool probe,
>> -                             uintptr_t retaddr)
>> +static bool hexagon_tlb_fill(CPUState *cs, vaddr address,
>> +                             vaddr first, vaddr last,
>> +                             MMUAccessType access_type, int mmu_idx,
>> +                             bool probe, uintptr_t retaddr)
>>   {
>>       CPUHexagonState *env = cpu_env(cs);
>> +    int size = last - address + 1;
> 
> Nitpicking, since we know last >= first, could we use size_t instead?
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Certainly I won't change the type in this patch.

It's only used by logging/tracing, so I don't really care, but you may, after the fact.


r~

