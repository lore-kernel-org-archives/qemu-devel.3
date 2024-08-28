Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3321C7114C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 22:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjRS3-0004Ny-LO; Wed, 28 Aug 2024 18:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjRS1-0004Mm-MP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 18:47:41 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjRRy-0004qu-PW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 18:47:40 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70e07c1ab31so64064a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724885257; x=1725490057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9f/avNeT6ewmpbIH3/c/pcZubZHUKmOt5F9wE2Uxa7g=;
 b=e3M8cDzzFC/ecA3imJn2BePU+buFcvPjA0nEo9LY5ilnbip/mgDL2ty9/DSYWASy5e
 zX16/YwCZFWOrY7W0En0NRAkL1KlkdOR9HiMANlqeQA6YSyMcMAzvsdLBBWeXWkM2k/O
 EovbwI9Jrm5VVRn+toxi6XWnvQWs3pOl2mdiGVDVkIbcZj2Lh7G7naKn9OSAlbeK0cM9
 POurhhhKKIrtt5nr3LojGJ6WXKY0+r33OPltJceu/PSuVTh9U++uAuGffgwYLeFWVrmv
 H40qLZ/BYyzIUH+IndN3r5yFD/rTRQG1bik7qx2IDtcCgLBAfurapERYfvWmFOQwyOvp
 eGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724885257; x=1725490057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9f/avNeT6ewmpbIH3/c/pcZubZHUKmOt5F9wE2Uxa7g=;
 b=pyUYS2S/+9yvHalMfZB0WKPeT1bFy+TPki5qOOX0/CYC8dNIkWqhHSVtMtpYS0edGr
 vlnNEvClMDZn533q/o3x0sHDL+3wk/w/2Dxmpyhzy+8yV4IqFWJhiKw/YR/tNTHVTuw6
 8vyM1OWQpflQpVxnFo8Y7ujZxNt9x2Ph61C23hIRPNE7EAuFsRwZHZaygxIEzdtycFOW
 L/saCP8vazxVtgVpZE1q2cc8jfUBgCpr89nk3Qqkm15UUYcf3u6ENPRxhcfMXl+uudNB
 muk1cQ1pEeaBVvI56g0MvtGDTx0xrxFbYnBHMFvbNGAMwSfIW5nlFQqXR6aIj4SKaj2I
 XcSA==
X-Gm-Message-State: AOJu0YzDakmauysxyrKdAmhL0C16ys+e9u0VB2kMmWwBgu1/dyuTAb4v
 5hTdqnzCIsA6nQN1RMvSiszo5d2oyO8NItIRvqF3WcyYpRu5wn+LSMEEshIjIsg=
X-Google-Smtp-Source: AGHT+IGeyjiKx86jJ7md7NCwzbs71lHmLlPyfNlQJk3+YV/OUGQ1Z2iiopiQQp/0u2qpgov4QBF45g==
X-Received: by 2002:a05:6830:6d86:b0:709:48f1:bc7c with SMTP id
 46e09a7af769-70f5c343bdemr1534370a34.5.1724885257142; 
 Wed, 28 Aug 2024 15:47:37 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70e03a84460sm3167527a34.21.2024.08.28.15.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 15:47:36 -0700 (PDT)
Message-ID: <bea888ca-9221-4c51-bcd1-c869d73094ae@linaro.org>
Date: Thu, 29 Aug 2024 08:47:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/6] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
 <20240805003130.1421051-5-richard.henderson@linaro.org>
 <Zs8ctyVxQz3iLDmM@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zs8ctyVxQz3iLDmM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/28/24 22:48, Daniel P. Berrangé wrote:
>>       dir = opendir("/proc/self/fd");
> 
> IIUC from previous threads this is valid on Linux and on Solaris.
> 
> On FreeBSD & macOS, you need /dev/fd though.

Fair, but importantly, it doesn't do anything *incorrect* those systems: it merely skips 
this method with ENOENT.

>> +    int open_max = sysconf(_SC_OPEN_MAX), i;
>> +
>> +    /* Fallback */
>> +    for (i = 0; i < open_max; i++) {
>> +        close(i);
>> +    }
> 
> I'm told that sysconf(_SC_OPEN_MAX) returns -1 on some versions of
> macOS. "Luckily" since we assigned to 'int' rather than 'unsigned int'
> this will result in us not closing any FDs in this fallback path,
> rather than trying to close several billion FDs (an effective hang).

Ouch.

> 
> If _SC_OPEN_MAX returns -1, we should fallback to the OPEN_MAX
> constant on macOS (see commit de448e0f26e710e9d2b7fc91393c40ac24b75847
> which tackled a similar issue wrt getrlimit), and fallback to perhaps
> a hardcoded 1024 on non-macOS.

I wish the timing on this had been better -- 25 minutes earlier and I would have delayed rc4.

Since macOS simply doesn't close fds, I'm of a mind to release 9.1.0 without this, and fix 
it for 9.1.1.  Thoughts?


r~

