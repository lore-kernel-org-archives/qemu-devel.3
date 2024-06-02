Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CF5C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 06:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDeg7-0002Vf-2T; Sun, 02 Jun 2024 02:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDeg4-0002VJ-RF
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 02:26:48 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDeg2-0000m3-NM
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 02:26:48 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6c821775f82so615735a12.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717309605; x=1717914405;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCj/VbwYG9yk9PAlILFTltKJ7+5kuA+uXg0bT/+hDGg=;
 b=RalHuApgmm5VJwtTj2ev3FKSCA7lDIksyqc/HInovLvZ/xvRHhy5NtT9an13xk0oWI
 1Pf2vWdRb/I8qEoPkzv6tLz+zjFNzt/SgcokbjvmivuIn0b+IhukdUutJYgjdfhm40NT
 bp7K740H1LbqfFhrx3/UYuV4THaCnd4ZXA2nfxdnkoeq1baE1TrwqieBQuhr7Z/VbbCh
 ToT6TpH+nSFSK/rvQdq5TSMu4RvsQPEz+QtZF9oNfyqLl74vg9MWZ+qi6BYb9DRilt4B
 3iEXR+pvJgUi6u6dMwbJRU7+RoeE7A8J5VUDkHIB7XUSBMmNHqRYXEwgrFHfMxvM/1F8
 qQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717309605; x=1717914405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sCj/VbwYG9yk9PAlILFTltKJ7+5kuA+uXg0bT/+hDGg=;
 b=uogEHMkFWBPZrJ1rEA6jhb7PoPlGVBneL94ttqF8sLYMqzs0wjkacwYruK8x9GM7Y1
 Al9y7Il8wp2udZ+gd2+wv7B91FwEhvgRQ9eX98jbNTSSxwqQkTs+xlVlf7B0mGJ2QJCp
 Z5rzBfj1u4dBCCFNpgfFeLI9WzpcrC+52wKjwe3nOZ6EBItBC+PoAfkYam5YZQKMEgsB
 lQ/oMbtbaVdLWzkrpffx6WM3y3k7GocM1ihCU3ARTzewcAE23jPSRqt/vegLABHkSUAb
 Sodht/Yxtpnl2amOrYg4CxkG9CJhktiyWJO0SoGOIfWUF1DYrZVj9d5J4+VxGQ+MgsGK
 86Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzisVy8fe9LHjpnXoI7UCndBP8/iNSYOvTMwbngrBE3LZUmNNzmM/lt7AFc88B99XPOp8/xHQXB+IfGZyuqayTmZ94bAw=
X-Gm-Message-State: AOJu0YwH72rO8IFhtB49BNr9pTqfYBjSWmFGDe15SYEA4EndSzYNQkk/
 D8vIz+fenW4Vl4QwmtgvuLt0C4A4CNvQ8d/Ezn5Ey1y60CNswtub0Q03G1VwmIs=
X-Google-Smtp-Source: AGHT+IHDh5dsVNwHZ4gy2hEg21Z43CKNRahrwxkIuifpK8nt5L5rXs+SCj0ef5ioVz3f5J0T54Du/g==
X-Received: by 2002:a05:6a21:6d9f:b0:1aa:a6dc:38ca with SMTP id
 adf61e73a8af0-1b26f139089mr7211054637.16.1717309604899; 
 Sat, 01 Jun 2024 23:26:44 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1c283164fsm4207761a91.37.2024.06.01.23.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jun 2024 23:26:44 -0700 (PDT)
Message-ID: <08ff19ed-9d1b-4fa3-8a40-3fe10d1f9bfa@daynix.com>
Date: Sun, 2 Jun 2024 15:26:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>
References: <cover.1717168113.git.mprivozn@redhat.com>
 <393c7b26302cb445f1a086a2c80b1d718c31a071.1717168113.git.mprivozn@redhat.com>
 <4b146ec6-bec2-4191-8c95-fc30d8307ef6@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4b146ec6-bec2-4191-8c95-fc30d8307ef6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/01 0:46, Philippe Mathieu-Daudé wrote:
> On 31/5/24 17:10, Michal Privoznik wrote:
>> The unspoken premise of qemu_madvise() is that errno is set on
>> error. And it is mostly the case except for posix_madvise() which
>> is documented to return either zero (on success) or a positive
>> error number. This means, we must set errno ourselves. And while
>> at it, make the function return a negative value on error, just
>> like other error paths do.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>   util/osdep.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/osdep.c b/util/osdep.c
>> index e996c4744a..1345238a5c 100644
>> --- a/util/osdep.c
>> +++ b/util/osdep.c
>> @@ -57,7 +57,19 @@ int qemu_madvise(void *addr, size_t len, int advice)
>>   #if defined(CONFIG_MADVISE)
>>       return madvise(addr, len, advice);
>>   #elif defined(CONFIG_POSIX_MADVISE)
>> -    return posix_madvise(addr, len, advice);
>> +    /*
>> +     * On Darwin posix_madvise() has the same return semantics as
>> +     * plain madvise, i.e. errno is set and -1 is returned. Otherwise,
>> +     * a positive error number is returned.
>> +     */
> 
> Alternative is to guard with #ifdef CONFIG_DARWIN ... #else ... #endif
> which might be clearer.
> 
> Although this approach seems reasonable, so:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

We should use plain madvise() if posix_madvise() is broken. In fact, 
QEMU detects the availability of plain madvise() and use it instead of 
posix_madvise() on my MacBook.

Perhaps it may be better to stop defining CONFIG_POSIX_MADVISE on Darwin 
to ensure we never use the broken implementation.

