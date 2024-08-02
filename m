Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144E6C52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZmzW-0005b8-4z; Fri, 02 Aug 2024 03:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZmzU-0005P1-Gg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:46:20 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZmzQ-0004Nm-6P
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:46:19 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52f008b40d7so1421674e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722584772; x=1723189572;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qBxnA+if0EtPxQd5lWGWjOvQV6MTONJImsaSt8pZ1Wk=;
 b=aUk1hWk2irkGXk7ovG/zX7WIMHqRoR2Pl2VN6dFhKrSGKHLx4tWnQr2K1c0+aSMVxc
 rjqDPFuw+1OkgaSM+fIXZ9KE/6yzFgoFuW5cj+YM8BSLH8Zdh2YRVZFwKyNLTWXUQNdG
 w1Fdl6eJeVdRW/KRooQbg20GFbEiZ3PqwpcPfQlYX8+adnrjSATDh3SqOiXfhPBraaaZ
 5G88B8R+wt3XcW+gA79Evl/xf2GtOWGLeWsiBEdPwOZeQ50CwERuahS8kwhnmbPjgzb6
 Br8PrflUFO7Bv33aO6ULLDMzseYbLaNo9QtXximWuwwxXphR/ZDpXEv/sPowTMlL+qr/
 N1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722584772; x=1723189572;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qBxnA+if0EtPxQd5lWGWjOvQV6MTONJImsaSt8pZ1Wk=;
 b=RoZH11E8jzuGoW1HaDop7ETOQU+Je4mX2qTgaaWX7Y1TDWJrzRhuaq4YOPovnZUPpq
 BUW0GLZJyu/Cx7+BQcp/KggYfLondcvc7Musi8ARksXe0MaqbsyXS14SGRM3U7/2F/tB
 hesuI1N7rrRQRJQueea4yKmr2PH3GkD/Xjobr/wATea8frkDH5CMCcNTCpsXDq0ovTbP
 8UhamYdXfWuVzLP6xiaKRkYRistVeA6e6L6CFHZGidWd4tC6R79cVl300Rk1DsWzSG+6
 X8X49gkUCKDyLW3eCccRFC4WyAFUpuw66t5avj0YT0kxldaffZr6CaLCkRXR9TKeoRXy
 QTXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFJfmT3+eQxda2byPHVBvynmuAM2bESvBfL2MKzi/rDgHhBgHyXnLwzRMzFjXkNTeJ8vvCHtAjMTIh@nongnu.org
X-Gm-Message-State: AOJu0YxIaomDkO8P93kXEVeogumqvsk4qhekq2LMu8QVMqDiERd5G+o2
 V9mIOqx0+7o1sjVSoG6OIMBVS7ghRE9WDzu2HpcJ/nwFCi5ipUCCR/fkv9j9/Vo=
X-Google-Smtp-Source: AGHT+IHCGNufTvtS6hU6z9Zolb0EE+iZxyIsXG00iuZM0OFY/bBeqhhDyzPdHDBJUw5H7VqltuE92g==
X-Received: by 2002:a05:6512:2206:b0:52f:10b:667f with SMTP id
 2adb3069b0e04-530bb3957bcmr975420e87.5.1722584771701; 
 Fri, 02 Aug 2024 00:46:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd05980csm1276714f8f.76.2024.08.02.00.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 00:46:11 -0700 (PDT)
Message-ID: <83aac1d1-846d-4df6-b600-4cdb05992cfe@rivosinc.com>
Date: Fri, 2 Aug 2024 09:46:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] qemu/osdep: Add excluded fd parameter to
 qemu_close_all_open_fd()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240731084832.1829291-1-cleger@rivosinc.com>
 <20240731084832.1829291-5-cleger@rivosinc.com>
 <5d6d52f3-7ce4-4b6b-a9d9-e0a5118b3a8f@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <5d6d52f3-7ce4-4b6b-a9d9-e0a5118b3a8f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=cleger@rivosinc.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 31/07/2024 23:56, Richard Henderson wrote:
> On 7/31/24 18:48, Clément Léger wrote:
>> @@ -823,8 +824,34 @@ static bool qemu_close_all_open_fd_proc(void)
>>       dfd = dirfd(dir);
>>         for (de = readdir(dir); de; de = readdir(dir)) {
>> +        bool close_fd = true;
>> +
>> +        if (de->d_name[0] == '.') {
>> +            continue;
>> +        }
>>           fd = atoi(de->d_name);
>> -        if (fd != dfd) {
>> +        if (fd == dfd) {
>> +            close_fd = false;
>> +            continue;
>> +        }
> 
> Assignment to close_fd not used here.
> 
>> +
>> +        for (unsigned int i = skip_start; i < skip_end; i++) {
>> +            if (fd < skip[i]) {
>> +                /* We are below the next skipped fd, break */
>> +                break;
>> +            } else if (fd == skip[i]) {
>> +                close_fd = false;
>> +                /* Restrict the range as we found fds matching
>> start/end */
>> +                if (i == skip_start) {
>> +                    skip_start++;
>> +                } else if (i == skip_end) {
>> +                    skip_end--;
>> +                }
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (close_fd) {
>>               close(fd);
>>           }
>>       }
>> @@ -833,24 +860,68 @@ static bool qemu_close_all_open_fd_proc(void)
>>       return true;
>>   }
>>   -static bool qemu_close_all_open_fd_close_range(void)
>> +static bool qemu_close_all_open_fd_close_range(const int *skip,
>> +                                               unsigned int nskip,
>> +                                               int open_max)
>>   {
>>   #ifdef CONFIG_CLOSE_RANGE
>> -    int r = close_range(0, ~0U, 0);
>> -    if (!r) {
>> -        /* Success, no need to try other ways. */
>> -        return true;
>> -    }
>> -#endif
>> +    int first = 0, last = open_max;
> 
> If this were really _SC_OPEN_MAX, this would be off-by-one.
> 
>> -static void qemu_close_all_open_fd_fallback(void)
>> +static void qemu_close_all_open_fd_fallback(const int *skip, unsigned
>> int nskip,
>> +                                            int open_max)
>>   {
>> -    int open_max = sysconf(_SC_OPEN_MAX), i;
>> +    unsigned int cur_skip = 0;
>>         /* Fallback */
>> -    for (i = 0; i < open_max; i++) {
>> +    for (int i = 0; i < open_max; i++) {
> 
> Because this isn't really _SC_OPEN_MAX, this *is* off-by-one.
> 
>> -void qemu_close_all_open_fd(void)
>> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>>   {
>> -    if (!qemu_close_all_open_fd_close_range() &&
>> -        !qemu_close_all_open_fd_proc()) {
>> -        qemu_close_all_open_fd_fallback();
>> +    int open_max = sysconf(_SC_OPEN_MAX) - 1;
> 
> Better to move the -1 into qemu_close_all_open_fd_close_range where it's
> actually needed.

Arg, I had it right in the previous version but messed up with the
SC_OPEN_MAX factorization.

I'll fix that,

Thanks,

CLément

> 
> 
> r~

