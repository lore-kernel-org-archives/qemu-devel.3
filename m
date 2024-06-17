Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2FDC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJFN9-0003Hc-T5; Mon, 17 Jun 2024 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sJFN7-0003H4-OD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:38:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sJFN5-0006CS-2z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:38:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35f1c7d1286so343692f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718642297; x=1719247097;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=00yYcSir0U5kxb0ueCU5b8C7p8d6xAePVzlqpCtGkJ0=;
 b=Fpi6L5WXVksol34YTFEu9klz2MGLGL4LlfPqF7IHoKCGYPrU0DqASe6AUzCOkpUNQt
 HZPan936rGICBKHvZqvellfn6bYgQZsR9FHkVVjIsMGuDE7gA7zGwhnlsKv0cokLml1b
 VuKlH9RKjyxqCg2R8k02ZKcFG1HpALzvh8/iDOjBklUmeQ5D0OVurWRkGUw1VcEFX+Vr
 vokK7XYmHqut2/fSuQA6DuMIx7jCtTUvdzSt2R8IWAxMmYci46DOJFOd6n4njkkIcM10
 dJnmrHpO+OfOi4Yxnoy9ZMhY4lT7gdhA0xh8w19lPjyJ8aRDrh4xd3H7j3NnYfFTolIZ
 8R7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718642297; x=1719247097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00yYcSir0U5kxb0ueCU5b8C7p8d6xAePVzlqpCtGkJ0=;
 b=i7+ZLPb+qv+T/HX9QEZvcuQs7oxfaaAAUBdgv4APxkTpav2wVa0A0CGcz7QnM0ka0X
 VEKdSQh/1Akm7uBSKqtMs9NqDL1FrNfJOVjp6kpBE6tingXW29rXTYfWjGq3E4RTTSo4
 1BnljFjIIJ1IuKLdM+VWP38PvQqcHGofmj4HA4HkrhK5TCALjLC3IxJbrx4aft+TaZoI
 wrLa0t+hdpYF2LWLPmUJZjvfGhBgZQI4gIFqEGqSSqO8gm+UofqTjIi3cpFdUgi3AP8b
 x6dT0TYHsEqjFZ4XveDEoc2anlCzi6L8+JRK3ed6bKxhKm+4CdjfDG3MHxt6C63JwOjh
 v7kQ==
X-Gm-Message-State: AOJu0YzVQDJ5bsttNmBlb3iZkR3C7lOa/z1yfJ1oI4+96wa97iel8ia9
 hp+IiRAlajIrgHJlAOBunTzrkJjAY931Vgs/OSYWyfA+ng77awW0PfTAiAuJxa8=
X-Google-Smtp-Source: AGHT+IEnDBAyMZg8RVyyYK0ZyCYxU25z0+GSmdBQ76V2883MNlnv4j7FVw0HlJdEtjWgdvKpgmGwEg==
X-Received: by 2002:a5d:5f43:0:b0:360:90d9:ed4d with SMTP id
 ffacd0b85a97d-36090da1216mr4019331f8f.6.1718642297057; 
 Mon, 17 Jun 2024 09:38:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:8ce9:8054:2dd1:4211?
 ([2a01:e0a:999:a3a0:8ce9:8054:2dd1:4211])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075093a4asm12227032f8f.21.2024.06.17.09.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 09:38:16 -0700 (PDT)
Message-ID: <df31ffdd-4d14-4808-b6d0-d8c9c72c4ecd@rivosinc.com>
Date: Mon, 17 Jun 2024 18:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap: use close_range() when forking scripts and helper
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240617162520.4045016-1-cleger@rivosinc.com>
 <CAFEAcA9v3UAbO7RpHQ0gP=adrHmKGPToJj3UdW_Nmd4T9bfO7w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAFEAcA9v3UAbO7RpHQ0gP=adrHmKGPToJj3UdW_Nmd4T9bfO7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 17/06/2024 18:36, Peter Maydell wrote:
> On Mon, 17 Jun 2024 at 17:25, Clément Léger <cleger@rivosinc.com> wrote:
>>
>> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
>> POSIX"), the maximum number of file descriptors that can be opened are
>> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
>> of 1073741816 file descriptors. Now, when forking to start
>> qemu-bridge-helper, this actually calls close() on the full possible file
>> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
>> takes a considerable amount of time. Use close_range() which only
>> requires to be called twice and factorize it in a separate function for
>> both call sites.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  net/tap.c | 25 +++++++++++++------------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 51f7aec39d..6f5bf06bb5 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -385,6 +385,17 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>>      return s;
>>  }
>>
>> +static void fork_close_all_fds_except(int fd)
>> +{
>> +    int open_max = sysconf(_SC_OPEN_MAX);
>> +
>> +    if (fd > 3)
>> +        close_range(3, fd - 1, 0);
>> +
>> +    if (fd < open_max)
>> +        close_range(fd + 1, open_max, 0);
>> +}
> 
> We can't rely on close_range() being available, I think --
> this should be ifdeffed with CONFIG_CLOSE_RANGE, with a
> fallback if it's not there.

Ok, makes sense.

> 
> Also, QEMU coding style requires braces on all if() statements,
> even single-line ones.

Sorry for that, noticed it after running checkpatch.

I'll send a V2 with these fixes.

Thanks,

Clément

> 
> thanks
> -- PMM

