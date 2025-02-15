Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E92C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 19:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjNXJ-00028q-Co; Sat, 15 Feb 2025 14:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjNXF-00028V-C2
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:09:05 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjNXD-0007Jh-DY
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:09:05 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fc3a14f6fbso1676868a91.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 11:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739646541; x=1740251341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TmIbWHe8iXnwEhGxSOwFiJM8JZGblOKLEWGTPJ9goOw=;
 b=WoCtX9n9avysQPCH4s2+vUB0P41GM/pcAsZydw20Xd4KQZSgBmXmoKuCAdNBeguIyf
 4wVSdsJkXJ9hHbOjx7e7J9kVxiB+CcS6Vt/jIyxpbe5U3IvsuRO7fBBGuyiktrOKQ+gE
 AFBphmvxmSVh8P3t9wlcSfbVcBi8yZiWYlVeBDzolX6FjFnu6alEx9ZXs7B1MqZzad5N
 zZTdGC7mjwIWvjd+2E21uxS7pPXy306foqDsmtE0TcYRVn84jkfgibrEjV95socI3vfw
 /WvgFuXcY2eQUK28QYV4lZHfriSuqm9Ssh07T6V58ggfve5Wv4u/AL393adl3k5dRG5l
 A/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646541; x=1740251341;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TmIbWHe8iXnwEhGxSOwFiJM8JZGblOKLEWGTPJ9goOw=;
 b=UdOGwElcQWW8TrpGWEuQ73NJQQQDhJR+8wwk4akgVOgEBJXUijJjpQ6wYocvhsEAut
 5R+NrloRI4p9vsDvkGep92RErebkSoCEDj51JEUWahJNCvYDNBERTLzDjKecGtRNw3db
 Ci7JIXS5axK29+rOYekVggI+T3joMiODVde5sKYpyK5kCWdy/hicI3my1N+KDxAxtpHy
 8sRsrAjByzmq3M6V5R1veGUTjOjlm9KAXE/V2A517zCtUDP6FhVKthtyY+tP7hRqYZp9
 Q1wz2JFCx8vkvcYJLHApBSLpGJeA0OlqK7uGYo+g6uD5FKXx1rUoRG+tlYLFR93KR1pa
 2yLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlYyJ/hav9OQ3aHlpT/COmiCigCg6jZTqFMO3/mqiagZqCKqf2LYy4igmly10ju6liKIUb7wefJ3xk@nongnu.org
X-Gm-Message-State: AOJu0Ywdzu5+i33aNOajZ0J5lam/SN2A4/nAkRH4Mb7+iHRzBIg1gS15
 f3AoWhtAf1db8+42gVXEmSUDAYNkXyjLPA+RjTO6+vHJnzdZ+xIGYAkGAgwSVa/0GjpuaHzxmNu
 H
X-Gm-Gg: ASbGncvxjbGMsTxiKQTf8WBhhbRqZJ84Uo7WwroEDjO1+YEdeamd5qOkYFJZnYD+SnX
 9VSIq59ncG8qCsxlCtN3Vcuq3lhZKpG47GFhyCLOjuP5UT8eKniufNb5RJxWtstL0eTb/MgQPmf
 vwnzcTa8qvD8jUDyOjCyHYdIhKeq6VLR0JRIi90HotyXpP45BO3V4t53zluYbGAd5y0SYB6eJ/m
 JQORnbTm1gECUvSHw0MlWGT8HweHVlh500zh2vk84o4rtTWxRyitbwAQyh7rE+A0xJwybwSis6o
 +/ud10HoPTG3ItYaPg+jjMnuLKubO7bO0TnfTCl3BweeouYTeTpkwWs=
X-Google-Smtp-Source: AGHT+IEv3Iemykp+Y1YNz5kXY2tGy+iZAJtouZE1htV1/oYW/TIdRy2w7BwbSeh6b1XWhfzrko/U+Q==
X-Received: by 2002:a17:90b:3851:b0:2ee:bbd8:2b9d with SMTP id
 98e67ed59e1d1-2fc4115401dmr5253997a91.34.1739646539464; 
 Sat, 15 Feb 2025 11:08:59 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ac0a06sm5215304a91.15.2025.02.15.11.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 11:08:58 -0800 (PST)
Message-ID: <5c33021b-7bf4-409e-8ea4-fd2473455adc@linaro.org>
Date: Sat, 15 Feb 2025 11:08:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] elfload: Fix alignment when unmapping excess
 reservation
From: Richard Henderson <richard.henderson@linaro.org>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dario Faggioli <dfaggioli@suse.com>
References: <20250213143558.10504-1-farosas@suse.de>
 <92d268c0-ba67-454a-b22b-688122eccd7b@linaro.org>
Content-Language: en-US
In-Reply-To: <92d268c0-ba67-454a-b22b-688122eccd7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 2/15/25 11:06, Richard Henderson wrote:
> On 2/13/25 06:35, Fabiano Rosas wrote:
>> When complying with the alignment requested in the ELF and unmapping
>> the excess reservation, having align_end not aligned to the guest page
>> causes the unmap to be rejected by the alignment check at
>> target_munmap and later brk adjustments hit an EEXIST.
>>
>> Fix by aligning the start of region to be unmapped.
>>
>> Fixes: c81d1fafa6 ("linux-user: Honor elf alignment when placing images")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1913
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> In the bug there was mention of the vdso landing in the wrong spot,
>> but I don't see evidence of this in my testing. Looking at the
>> addresses in the bug report, there seems to have been a mistake
>> because I don't see an overlap there either.
>> ---
>>   linux-user/elfload.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index a2c152e5ad..05ee5e74fd 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3351,7 +3351,7 @@ static void load_elf_image(const char *image_name, const 
>> ImageSource *src,
>>       if (align_size != reserve_size) {
>>           abi_ulong align_addr = ROUND_UP(load_addr, align);
>> -        abi_ulong align_end = align_addr + reserve_size;
>> +        abi_ulong align_end = TARGET_PAGE_ALIGN(align_addr + reserve_size);
>>           abi_ulong load_end = load_addr + align_size;
> 
> Both align_end and load_end must be aligned.

Bah, hit ctrl-enter, not enter.  I'll fix and queue.


r~

