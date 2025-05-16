Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C821C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFniW-0007LT-4X; Fri, 16 May 2025 01:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFniU-0007J2-1S
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:34:42 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFniR-0001vs-E1
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:34:41 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30a8cbddca4so1939106a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747373678; x=1747978478;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pqD0aayVf2BbjrhM0TCdSbQhUBCU2DchppJ7uJQEezc=;
 b=mpHLG37ULk4BmvWcCzeCttKZFAbIaohgKRsv5wDABEFWHJWfi4Fd8WiQMbAeOP8eVU
 bMjY1PWCWiWqNN8YsfLrae8s7TroRUKeY8NV649yeX1/XIxcx009V3romsTgVItpmU6R
 OtjQQCd58CIitP5d8TxcGevVRN9xDXVVr30GGV3cCdYsa90SpsYjoPtzHrcVvcKMlIBo
 dJxLXEYdwiMo3g7+lc/36PymjwWEtptu1FcSu9G4TmQFfDIxUV1CG+pHiWu3V1GC8/dz
 O4jxnE0tODLdpP0+thfZekRbh07nOhTV5jk5Vk2nYign1uo4oMLbo1rx1nvz9BSdCgdT
 0yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373678; x=1747978478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pqD0aayVf2BbjrhM0TCdSbQhUBCU2DchppJ7uJQEezc=;
 b=mbvARDBk0OCGmMdhGidvcBlwFBZPIgMZaNi06UzFOVvd9p1g3RD30bbrTI83Xtf99M
 bXg1SwX+xEF/81/JKt6Ed6+78Wc5Zdt9plJRxhG05hQssOsFtr413gLr6EAaZSXCU/Y0
 3TOU8sYjdA9jG3vZIc46NXPStXu3c+ar1l5JLj8NS8P/NMeMlT5T7mHHf+imFMPl8pUH
 E9VMLSFCvA8GS5F1f5W/KY1ByBbFA5f9XhGuWtXy0C11Zx4vbwNVrFlW+lE4c8z3Up+F
 tdpJnaFwN1xyWvFSXMRYsgYCumrpyV3KN5DnURgZ3OGF7QFEvLK6O5juZHqLMrQY92OF
 Eb3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWnvjk/NxbM2bLm13vbq6WaGr8cC7gI0uyA5l6sa8tJFbCgpUMsBs+2Vzws8OG2UsKs9qbN3g+Oudj@nongnu.org
X-Gm-Message-State: AOJu0YzoGlw2PDgRw5NJg6b4ojxpkcZeLpa4OrIsKQu8UbRMOVa/LBpv
 H9NKuQsKOTD3rluPP0EMJwnEctsHaVL31AVrPpEmBe6mKAfuo2BV1Re4JcWRKSNjZpg=
X-Gm-Gg: ASbGncsdbywcW4kduHNDry/8Wkcg7hPwbUi35NoGWef4jxalylpiiwvHgocTRILbwwD
 uTesAQuCG6XqlddG3oniUesGh7mh08dZ0bAJTWQjABRoZob+/IEdCP95EEHexGYlW3RIz1E4NAV
 xoFVRZ5xMVRXuIdbLwEzVPaDHy+ZGMzsGAiNGHhqK9usnRY3viLs+7o9tsXCdmG6Vh6pJ8xgOHb
 xTPkglDx19zyCbASVOZ3sOXgrLfD4MJ+jHudORzCQW9/9QZVihJmc18NJg9aHvsuwgBNrxfK8Be
 MSSzjbgbOG+1yht69HqxbxMK8/VOwmIH8wKxtd9ZDPHzl8UaHuHtNJxlgAGet5vm
X-Google-Smtp-Source: AGHT+IEUG30DPvgwL0B4yPdYC1OqKk3I0Wv74nds2ejIgucANlyi5UIcD7d6XDKUJ5xTBCfTjmd/4A==
X-Received: by 2002:a17:90b:1f8c:b0:30e:7b15:3580 with SMTP id
 98e67ed59e1d1-30e7d5b7b91mr2544833a91.30.1747373677558; 
 Thu, 15 May 2025 22:34:37 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e7d591857sm737269a91.48.2025.05.15.22.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 22:34:37 -0700 (PDT)
Message-ID: <271a1379-0347-4858-9602-c561bbc8aeaf@daynix.com>
Date: Fri, 16 May 2025 14:34:33 +0900
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
 <b1b6574c-1ddb-4129-8a68-fe88f93caecd@daynix.com> <aCTNkxN9HMJ5FvR-@x1.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <aCTNkxN9HMJ5FvR-@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
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

On 2025/05/15 2:06, Peter Xu wrote:
> On Wed, May 14, 2025 at 04:34:33PM +0900, Akihiko Odaki wrote:
>> On 2025/05/13 23:39, 'Peter Xu' via devel wrote:
>>> On Sun, May 11, 2025 at 03:08:18PM +0900, Akihiko Odaki wrote:
>>>> futex(2) - Linux manual page
>>>> https://man7.org/linux/man-pages/man2/futex.2.html
>>>>> Note that a wake-up can also be caused by common futex usage patterns
>>>>> in unrelated code that happened to have previously used the futex
>>>>> word's memory location (e.g., typical futex-based implementations of
>>>>> Pthreads mutexes can cause this under some conditions).  Therefore,
>>>>> callers should always conservatively assume that a return value of 0
>>>>> can mean a spurious wake-up, and use the futex word's value (i.e.,
>>>>> the user-space synchronization scheme) to decide whether to continue
>>>>> to block or not.
>>>
>>> I'm just curious - do you know when this will happen?
>>>
>>> AFAIU, QEMU uses futex always on private mappings, internally futex does
>>> use (mm, HVA) tuple to index a futex, afaict.  Hence, I don't see how it
>>> can get spurious wakeups..  And _if_ it happens, since mm pointer can't
>>> change it must mean the HVA of the futex word is reused, it sounds like an
>>> UAF user bug to me instead.
> 
> [1]
> 
>>>
>>> I checked the man-pages git repo, this line was introduced in:
>>>
>>> https://github.com/mkerrisk/man-pages/commit/4b35dc5dabcf356ce6dcb1f949f7b00e76c7587d
>>>
>>> I also didn't see details yet in commit message on why that paragraph was
>>> added.
>>>
>>> And..
>>>
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    include/qemu/futex.h              |  9 +++++++++
>>>>    tests/unit/test-aio-multithread.c |  4 +++-
>>>>    util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
>>>>    3 files changed, 28 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/include/qemu/futex.h b/include/qemu/futex.h
>>>> index 91ae88966e12..f57774005330 100644
>>>> --- a/include/qemu/futex.h
>>>> +++ b/include/qemu/futex.h
>>>> @@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
>>>>        qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
>>>>    }
>>>> +/*
>>>> + * Note that a wake-up can also be caused by common futex usage patterns in
>>>> + * unrelated code that happened to have previously used the futex word's
>>>> + * memory location (e.g., typical futex-based implementations of Pthreads
>>>> + * mutexes can cause this under some conditions).  Therefore, callers should
>>>
>>> .. another thing that was unclear to me is, here it's mentioning "typical
>>> futex-based implementations of pthreads mutexes..", but here
>>> qemu_futex_wait() is using raw futex without any pthread impl.  Does it
>>> also mean that this may not be applicable to whatever might cause a
>>> spurious wakeup?
>>
>> No. The man-page mentions "unrelated code that happened to have previously
>> used the futex word's memory location", so it doesn't matter whether we use
>> pthread here.
>>
>> libpthread and even this QemuEvent follows the "common futex usage" so we
>> should do what is written in the man page.
>>
>> Unfortunately the man page does not describe the "common futex usage
>> pattern". It looks like as follows:
>>
>> Assume there are two threads, one atomic variable, and one futex.
>>
>> Thread A does the following:
>> A1. Read the atomic variable.
>> A2. Go A5 if the atomic variable is zero.
>> A3. Wait using the futex.
>> A4. Go A1.
>> A5. Free the atomic variable and the futex.
>>
>> Thread B does the following:
>> B1. Set the atomic variable to zero.
>> B2. Wake up using the futex.
>>
>> In this example, the execution may happen in the following order:
>> B1 -> A1 -> A2 -> A5 -> B2
>>
>> Here, B2 will cause a spurious wake up of QemuEvent if the freed memory gets
>> reused for QemuEvent.
> 
> This is true.
> 
> Said that, if to follow my previous statement at [1] above, here I think A5
> is the UAF bug I mentioned, trying to free the lock object with existing
> user (Thread B) accessing the object.
> 
> IMHO, the userapp should make sure the object will never be freed if
> there's any possible user of it, and that includes a waker like Thread B.
> 
> For futex, the futex word (which is the important bit here relevant to
> possible spurious wakeups) is part of the lock object, hence if the lock
> object isn't freed too early it won't ever get reused, and then there
> should have no chance of spurious wakeups in the futex context.

It is a UAF, but it is by design and not a bug.

The principle of the futex design is to use atomic memory operations to 
manage the state instead of using a system call, which is more expensive.

This principle motivates tolerating spurious wakeups. If wakeup system 
calls after free are forbidden, a thread will need to use a (expensive) 
system call to ensure the wake up actually happened before freeing. 
Instead, we can tolerate spurious wakeups without causing a buggy 
behavior by making the waiting thread perform (cheaper) atomic memory 
reads to verify the expected state.

Regards,
Akihiko Odaki

