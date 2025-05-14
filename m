Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A571C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 07:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF6da-0000Gt-8Q; Wed, 14 May 2025 03:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uF6dW-0000Bh-44
 for qemu-devel@nongnu.org; Wed, 14 May 2025 03:34:42 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uF6dT-0007Da-FW
 for qemu-devel@nongnu.org; Wed, 14 May 2025 03:34:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74019695377so4844046b3a.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747208078; x=1747812878;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=shNje0Eftl8ySbsWxsa6S7rWKiXpCwd+AvcbjjfbNvc=;
 b=reR2p8PyCHoNyW7F+clSjRaxumppFRaosB7fVytZQKYCByb0z72qui248BntcrTujQ
 HQmqLuaqAs7WKolKpDl73rXkeuaP6lbHD5rj8Yd63zviClYn7i/GuR9RfZU3ly5g2lVt
 R3zrTgVeNWf6JdbRY0ddhJTEU7yDpdL5yNYoCIGaaQC0amuVqhJzffg9mZrRt864DLFK
 Qy3y34jSJBH2q3DlgPJySk2xPwVGR2X0rQ2aWa4ZEmhxitmiRTzwrmNWHRKj8zIEQG3l
 BES76i7Th4aujfnyntuyzEB2yYcTj53BT0UNrG0gZvcSDGmAo2jzHRAyrNF6RBIZZqCU
 uEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747208078; x=1747812878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=shNje0Eftl8ySbsWxsa6S7rWKiXpCwd+AvcbjjfbNvc=;
 b=kSp0hkBgclbxEg41rDBMjuAsV1gj4X0EKjtxyZNSgeTw3lr/Wv1giOgPUHuwAEtw7U
 KUm365lYNnSoJMPLvkCqcNL68Z83gWC5axTMffQrh/x9ee/PjjYdjwKgQNeuNRJ6yX9k
 CQPqKvBpWu8amIlNd4TIygOH9Brh29my9M4ZePlhqcdOb47pjl0vbRajYERtA5977vTW
 XkmCqN256ykkI8rlw6+6XatRvOEdXS/kUf+fXoHuhzqaDpHkeQCxbHSt4QBmaLQcN2Oy
 jElchBsCf97stnwOYOKZMuenfpJ/ld8/Qy6dteznq17FbGt5RKCPzzm3MYu5l7ZgbWr/
 5jCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTq7qsNVC72qkalh+jZxdNy+GUz3Nbu68bs8DvnItoX3LV+cUr+Qw8fvFU66JYsV+mWez0wqiUHoKo@nongnu.org
X-Gm-Message-State: AOJu0YyFxLg1rZzjC2uBBegNEdHOF0rOuJus0vVC9nGdIR4NW9Ohh9Sn
 2PD/BYLg50CoCBgmxP4wnOectlNi1KiyvrpY6nagK7pAuWCeFUUkF/xO54lHklc=
X-Gm-Gg: ASbGncvE59fZMDgV8G8c6oagSx8QGJwN84X1ASqmkFKeRFPOdpU/5wBn2B6TihKfsap
 GcZC/31aN5uDRxIxDSyl2J9VyIBUYa9qHV2qnUtqlDiBe8IABIoti87S073Qe5RWh1vqnrVKF8m
 wjoWDaiJkWPRec3F/bSc2o3PyUXTISUT3zeY+PyYbDijFzlZpbIL/BCIkT3pq+TfJ6iaf3eLkbo
 ClcEffqMsaCaQpGY2oTCaLZfVESCfKWLYJ5Md0fXF1cjWPo3niZeB4zC5fwfuZ/SdEChnsBOM9P
 YydYngAkubWT9XQagZF9/brfufXVs9WNgcz2sX9W6rFZsMOFBDuAhm2LXuKpS1Lg
X-Google-Smtp-Source: AGHT+IHUtCeetFlkBE8KGuI++TuPPlpyfKtk6rk+NUhLuGWbrWaW1uE6cHBGQJElCGMkfHGQ096TWA==
X-Received: by 2002:a05:6300:8d:b0:1f5:8126:8a5d with SMTP id
 adf61e73a8af0-215ff0db872mr3368359637.17.1747208077890; 
 Wed, 14 May 2025 00:34:37 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2349ec816esm8375231a12.22.2025.05.14.00.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 00:34:37 -0700 (PDT)
Message-ID: <b1b6574c-1ddb-4129-8a68-fe88f93caecd@daynix.com>
Date: Wed, 14 May 2025 16:34:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] futex: Check value after qemu_futex_wait()
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-1-f7f69247d303@daynix.com> <aCNZk73GuEaU-gcK@x1.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <aCNZk73GuEaU-gcK@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

On 2025/05/13 23:39, 'Peter Xu' via devel wrote:
> On Sun, May 11, 2025 at 03:08:18PM +0900, Akihiko Odaki wrote:
>> futex(2) - Linux manual page
>> https://man7.org/linux/man-pages/man2/futex.2.html
>>> Note that a wake-up can also be caused by common futex usage patterns
>>> in unrelated code that happened to have previously used the futex
>>> word's memory location (e.g., typical futex-based implementations of
>>> Pthreads mutexes can cause this under some conditions).  Therefore,
>>> callers should always conservatively assume that a return value of 0
>>> can mean a spurious wake-up, and use the futex word's value (i.e.,
>>> the user-space synchronization scheme) to decide whether to continue
>>> to block or not.
> 
> I'm just curious - do you know when this will happen?
> 
> AFAIU, QEMU uses futex always on private mappings, internally futex does
> use (mm, HVA) tuple to index a futex, afaict.  Hence, I don't see how it
> can get spurious wakeups..  And _if_ it happens, since mm pointer can't
> change it must mean the HVA of the futex word is reused, it sounds like an
> UAF user bug to me instead.
> 
> I checked the man-pages git repo, this line was introduced in:
> 
> https://github.com/mkerrisk/man-pages/commit/4b35dc5dabcf356ce6dcb1f949f7b00e76c7587d
> 
> I also didn't see details yet in commit message on why that paragraph was
> added.
> 
> And..
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/qemu/futex.h              |  9 +++++++++
>>   tests/unit/test-aio-multithread.c |  4 +++-
>>   util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
>>   3 files changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/qemu/futex.h b/include/qemu/futex.h
>> index 91ae88966e12..f57774005330 100644
>> --- a/include/qemu/futex.h
>> +++ b/include/qemu/futex.h
>> @@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
>>       qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
>>   }
>>   
>> +/*
>> + * Note that a wake-up can also be caused by common futex usage patterns in
>> + * unrelated code that happened to have previously used the futex word's
>> + * memory location (e.g., typical futex-based implementations of Pthreads
>> + * mutexes can cause this under some conditions).  Therefore, callers should
> 
> .. another thing that was unclear to me is, here it's mentioning "typical
> futex-based implementations of pthreads mutexes..", but here
> qemu_futex_wait() is using raw futex without any pthread impl.  Does it
> also mean that this may not be applicable to whatever might cause a
> spurious wakeup?

No. The man-page mentions "unrelated code that happened to have 
previously used the futex word's memory location", so it doesn't matter 
whether we use pthread here.

libpthread and even this QemuEvent follows the "common futex usage" so 
we should do what is written in the man page.

Unfortunately the man page does not describe the "common futex usage 
pattern". It looks like as follows:

Assume there are two threads, one atomic variable, and one futex.

Thread A does the following:
A1. Read the atomic variable.
A2. Go A5 if the atomic variable is zero.
A3. Wait using the futex.
A4. Go A1.
A5. Free the atomic variable and the futex.

Thread B does the following:
B1. Set the atomic variable to zero.
B2. Wake up using the futex.

In this example, the execution may happen in the following order:
B1 -> A1 -> A2 -> A5 -> B2

Here, B2 will cause a spurious wake up of QemuEvent if the freed memory 
gets reused for QemuEvent.

Regards,
Akihiko Odaki

