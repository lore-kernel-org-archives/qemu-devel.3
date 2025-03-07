Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870E3C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqaOR-00078V-Ua; Fri, 07 Mar 2025 11:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqaOE-00076L-Hh
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:17:45 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqaOC-0003oP-9G
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:17:34 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3911748893aso1483632f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741364249; x=1741969049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CKbmXBhZt96UC0LXSUNrNhOjMobrG9KTIMBs8+XXIck=;
 b=AHawQjzsOEtwicWRPKoDQeRH3y+Y2PvsLQYhPVvobFoDqeJcPbFmeaPlaeFVmtuAEn
 k2ovONz7WPL+su9TIpQv8PP5PORbo+/t137AyT5jIS8Lk4Rk+MbVSYXVnBV+uxyIc7V8
 sTk9PgBTIzJJ/VypP3d2oC7Ir0BWmSG8hqDUa5vqnl2v70hgAX8wpB417fq8gzXv3+n+
 u5aHsEX60caArUai4Cx4TI2XG7crYkiwBjAvK8598zu+QYqguC2sN0Ug1LBoDEc9anhj
 94gNpEErdXNbXe7YcjtVNP4le3QqNnUDtkedZCPrbnfCnVc7ZVW1T3TyfCiKDeMzSAvz
 Gpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741364249; x=1741969049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CKbmXBhZt96UC0LXSUNrNhOjMobrG9KTIMBs8+XXIck=;
 b=mj4Ea9VAUmD7xUShtQK5RKxMh+RFi0ujBVfTeOfyPlYfmPOZnHJ/rxfh+jAvTjhDQD
 A0z0dLuKdcNv1eNbEd0WlEsk6F9/WaluttaaOi8Cb6G1VwTL2OdW12HKwEUEI8cxv7T7
 jCO6pMpd3NtDGJAHuZ3wzUhd0UhSqxGMOuUBvOURGbFEkkjb9Bir2IfVbQsaxA0NvPZ2
 KfEsjg9wXAfZkOBm7VsI71z8gDN//PaQ3uzK5TCAiRS3xRyqjs7B//4jXhErZ5sxZ21F
 45tunkHI24B8O8NNhlzupsXAT0WE8zwjjCB2weurfmwyO9NhKaF8ldU2C3EzI0UcpK2T
 Lx0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkRnODUNVC2zzIdxR+mNp3EHaZScjPxxROzJPzdp0kIoWLFytF4U8xzmDK6MVZMpjW4xx9ftPUVKMc@nongnu.org
X-Gm-Message-State: AOJu0Yx2Y09p6oiZdF9ojKPBj7SOT/N4HtR67FM3W2BArXcwOD+eq4HB
 /NRy+TAhcc/etyml2we37GeFY/pnAKgqvsHwwa2bkgdV2PwtiJDHsghfLv8pmqc=
X-Gm-Gg: ASbGnctqn31OYJpUzNfKOJixAg77ooJw45HV8GCdSJhnE6biptqwuaYfkDBR8Rv/HOJ
 pe0dI7OpuSpqEE80lAnW+vs7NwLSB8MYxGuLo63yB5voEXnKAls2T/ZKjkIk0lMeYV+7JmwLgP7
 6GxtkOPpvyJs/EAmHYT5rQRK/9Q6fXFRmg6Jn4/bobAZG0Q3JkQ7XcKTpuSgoagc73o4JiHY2yo
 VKyJNOtg64/G3zLUJYNOFnxFQpCz2Fs7AgDIRYceTSjIVEt7RRgtS0PDP6m4xOqKqaaHmaBF4XM
 Z+aDNPavH5P+bWaRhmkrPXElN2RyNUDEgzy5j3yxY1JE5VJggY6XkN4gjbmm2vC67uEfLa4+EIu
 5A2LcKDlinWlW
X-Google-Smtp-Source: AGHT+IGLqJQYkZDNnyxtacWJN0+VJ3692jNq65VwAYhIGwhN6gCsJUzgf6yxb4IbXvn8+gP/x481lw==
X-Received: by 2002:a5d:6d8c:0:b0:391:952:c728 with SMTP id
 ffacd0b85a97d-39132d77544mr2481381f8f.4.1741364249541; 
 Fri, 07 Mar 2025 08:17:29 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01ebddsm5939035f8f.60.2025.03.07.08.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 08:17:28 -0800 (PST)
Message-ID: <bfbf843d-f97f-4e7e-bbc2-490a6f8b0674@linaro.org>
Date: Fri, 7 Mar 2025 17:17:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] bsd-user: Propagate alignment argument to
 mmap_find_vma()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307130951.4816-1-philmd@linaro.org>
 <20250307130951.4816-3-philmd@linaro.org>
 <3792e6ce-3dd8-41ad-bbc8-313fe4309e2f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3792e6ce-3dd8-41ad-bbc8-313fe4309e2f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 7/3/25 17:08, Richard Henderson wrote:
> On 3/7/25 05:09, Philippe Mathieu-Daudé wrote:
>> Propagate the alignment to mmap_find_vma(), effectively
>> embedding mmap_find_vma_aligned() within mmap_find_vma().
>>
>> Since we ignore the alignment in do_bsd_shmat(), leave a
>> FIXME comment.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   bsd-user/bsd-mem.h |  2 +-
>>   bsd-user/qemu.h    |  2 +-
>>   bsd-user/mmap.c    | 10 ++--------
>>   3 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
>> index f5ec0de24ca..87219da2919 100644
>> --- a/bsd-user/bsd-mem.h
>> +++ b/bsd-user/bsd-mem.h
>> @@ -372,7 +372,7 @@ static inline abi_long do_bsd_shmat(int shmid, 
>> abi_ulong shmaddr, int shmflg)
>>           } else {
>>               abi_ulong mmap_start;
>> -            mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
>> +            mmap_start = mmap_find_vma(0, shm_info.shm_segsz, 0 /* 
>> FIXME??? */);
> 
> It's not really ignoring the alignment, but not requiring alignment 
> above page size.
> 
> Traditionally, the alignment for shmat should be SHMLBA.
> But in current freebsd sources,
> 
> sys/sys/shm.h:#define SHMLBA      PAGE_SIZE /* Segment low boundary 
> address multiple */
> 
> there are no crazy broken old architectures to worry about.

OK, thank you for checking!


