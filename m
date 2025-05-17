Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAC0C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 05:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG9gV-0003HR-QO; Sat, 17 May 2025 01:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uG9gS-0003DB-BC
 for qemu-devel@nongnu.org; Sat, 17 May 2025 01:02:04 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uG9gO-00058y-E3
 for qemu-devel@nongnu.org; Sat, 17 May 2025 01:02:03 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30ac55f595fso2686901a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747458117; x=1748062917;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pfzx3JLNCWnHmmtv6kl+Rhpn6NeMWTWrqSOg1DUcJPc=;
 b=ja8UOkoXq20ElnG78Ph2f9U9pLZ/3LfweojoqtoOChI5tHj+tgNfrgH2dIqZWTBoWk
 wpIE0J75EcqGikd2LsAMKp5wmx1qZRPF5RjEDgYMpVyLwpR+8M6JHEhThZlcf2BH3f83
 drNoZAKe2riD4gzpVmo9qSW+5uySRcM9AnlKpYgbca2D/edmKeAn3qb260HlhzPvJiLp
 JJ+7r2+OKWSihHiFfyi1bbFGJ0ST7L3u5vKABlAjaGH0cC7YFF2bA3Vd69oakruwdXIO
 I/Yaz7AklBbFUFL13FEpng1WyZMib+C+CowwcUjogCqA/b4fhuuhh7a4fYyNk3GVWVUb
 0ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747458117; x=1748062917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pfzx3JLNCWnHmmtv6kl+Rhpn6NeMWTWrqSOg1DUcJPc=;
 b=ICPKY8/EMjtLm8UNgb1Zvmv/QMtbVIofImdV3elDkfWHiJgboOnANvY7Pc1FCxTsR+
 sEfeCoDTZK36iqKiOmuAlYTvZDh5cOZU/QvwE2gxi5jp6RAH7S/PnnCx3uy9aUxxxEto
 o7VKiCWRzwPZGOYlqgtVybDJp+MjNL2aKJV4JPziLcOWqFRpJSR98k0IuAG0xMgGWS7x
 ptgQo1u3kxGp/UJe6C8fsY3aKfGM1ca1yYfAsxjbZ7HZDgJsxLFczEysavBSThhQk/vV
 vdxX9d3YV88FZp6BabAdaJxvJ75het/+ZKp4WwHPrrv3DeoNilKl8oWXQFJUON0oaNiz
 jfPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjsl8Yvi0Hwvs71Z0TF+EtRvnTfV09cjmbhFedibEX5PG2w7E6MigRBQgMnyOICLku24zgeIt1hULd@nongnu.org
X-Gm-Message-State: AOJu0Yw0tSlzLH10Hew0J8ZgKaf026Ub27QSoU7JeN5aiWIwoOlOkx+M
 u9YVe5nG93QPkGTniXazOuCspnFljrnBcvZwqO9O8+eWk4zyN5EQbLCPf4FFSNewCuU=
X-Gm-Gg: ASbGnctb70yp/OYgiw8P42xuafQ3Y4aqiN6qt+ulw3xDPl4LWQ5GlefcE5MEoZmd8yA
 L87K0E+OloDsDpqx+xS+FuVAwWK9GwJDiEh7LuJC0TKzIrdpCRi3SW5A6iT5XGNfAoe4FGQGqc3
 v7BpGdDvo0g6GdZXemgP3SPnFHBDucnp1tY7LfrX1NixYwC1+iN+8VAKQM00CiPZ40Zzzm6x+F8
 S7avnPgoofEWADX6fEdR6Dft1Lck9yt/tYtjERpFV6LH4InhRDgXbZPqQde+8YnBnE1pIwACTfM
 llIK8/pMYMgQ517GNr1z3S1ickzNktKIKSH3RMZSY+rblGDyZiQW6TFYJJT+J0JOGkrwlEv+UYy
 /SrSOo2I=
X-Google-Smtp-Source: AGHT+IGFM23iMDpJKHMMujukhgNboL5+XwkOlX58aPB8QXKLCSxaAgOnEajR8Z01HvxmfeX+35k/CA==
X-Received: by 2002:a17:90b:4f4c:b0:30e:ee6:6747 with SMTP id
 98e67ed59e1d1-30e7d520bf3mr8034544a91.13.1747458117411; 
 Fri, 16 May 2025 22:01:57 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e334147acsm6102019a91.1.2025.05.16.22.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 22:01:56 -0700 (PDT)
Message-ID: <0e242dff-b312-48fd-ac85-b24377e0fad1@daynix.com>
Date: Sat, 17 May 2025 14:01:53 +0900
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
 <271a1379-0347-4858-9602-c561bbc8aeaf@daynix.com> <aCdRho2SCZHOlsn_@x1.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <aCdRho2SCZHOlsn_@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
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

On 2025/05/16 23:53, Peter Xu wrote:
> On Fri, May 16, 2025 at 02:34:33PM +0900, Akihiko Odaki wrote:
>> On 2025/05/15 2:06, Peter Xu wrote:
>>> On Wed, May 14, 2025 at 04:34:33PM +0900, Akihiko Odaki wrote:
>>>> On 2025/05/13 23:39, 'Peter Xu' via devel wrote:
>>>>> On Sun, May 11, 2025 at 03:08:18PM +0900, Akihiko Odaki wrote:
>>>>>> futex(2) - Linux manual page
>>>>>> https://man7.org/linux/man-pages/man2/futex.2.html
>>>>>>> Note that a wake-up can also be caused by common futex usage patterns
>>>>>>> in unrelated code that happened to have previously used the futex
>>>>>>> word's memory location (e.g., typical futex-based implementations of
>>>>>>> Pthreads mutexes can cause this under some conditions).  Therefore,
>>>>>>> callers should always conservatively assume that a return value of 0
>>>>>>> can mean a spurious wake-up, and use the futex word's value (i.e.,
>>>>>>> the user-space synchronization scheme) to decide whether to continue
>>>>>>> to block or not.
>>>>>
>>>>> I'm just curious - do you know when this will happen?
>>>>>
>>>>> AFAIU, QEMU uses futex always on private mappings, internally futex does
>>>>> use (mm, HVA) tuple to index a futex, afaict.  Hence, I don't see how it
>>>>> can get spurious wakeups..  And _if_ it happens, since mm pointer can't
>>>>> change it must mean the HVA of the futex word is reused, it sounds like an
>>>>> UAF user bug to me instead.
>>>
>>> [1]
>>>
>>>>>
>>>>> I checked the man-pages git repo, this line was introduced in:
>>>>>
>>>>> https://github.com/mkerrisk/man-pages/commit/4b35dc5dabcf356ce6dcb1f949f7b00e76c7587d
>>>>>
>>>>> I also didn't see details yet in commit message on why that paragraph was
>>>>> added.
>>>>>
>>>>> And..
>>>>>
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> ---
>>>>>>     include/qemu/futex.h              |  9 +++++++++
>>>>>>     tests/unit/test-aio-multithread.c |  4 +++-
>>>>>>     util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
>>>>>>     3 files changed, 28 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/include/qemu/futex.h b/include/qemu/futex.h
>>>>>> index 91ae88966e12..f57774005330 100644
>>>>>> --- a/include/qemu/futex.h
>>>>>> +++ b/include/qemu/futex.h
>>>>>> @@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
>>>>>>         qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
>>>>>>     }
>>>>>> +/*
>>>>>> + * Note that a wake-up can also be caused by common futex usage patterns in
>>>>>> + * unrelated code that happened to have previously used the futex word's
>>>>>> + * memory location (e.g., typical futex-based implementations of Pthreads
>>>>>> + * mutexes can cause this under some conditions).  Therefore, callers should
>>>>>
>>>>> .. another thing that was unclear to me is, here it's mentioning "typical
>>>>> futex-based implementations of pthreads mutexes..", but here
>>>>> qemu_futex_wait() is using raw futex without any pthread impl.  Does it
>>>>> also mean that this may not be applicable to whatever might cause a
>>>>> spurious wakeup?
>>>>
>>>> No. The man-page mentions "unrelated code that happened to have previously
>>>> used the futex word's memory location", so it doesn't matter whether we use
>>>> pthread here.
>>>>
>>>> libpthread and even this QemuEvent follows the "common futex usage" so we
>>>> should do what is written in the man page.
>>>>
>>>> Unfortunately the man page does not describe the "common futex usage
>>>> pattern". It looks like as follows:
>>>>
>>>> Assume there are two threads, one atomic variable, and one futex.
>>>>
>>>> Thread A does the following:
>>>> A1. Read the atomic variable.
>>>> A2. Go A5 if the atomic variable is zero.
>>>> A3. Wait using the futex.
>>>> A4. Go A1.
>>>> A5. Free the atomic variable and the futex.
>>>>
>>>> Thread B does the following:
>>>> B1. Set the atomic variable to zero.
>>>> B2. Wake up using the futex.
>>>>
>>>> In this example, the execution may happen in the following order:
>>>> B1 -> A1 -> A2 -> A5 -> B2
>>>>
>>>> Here, B2 will cause a spurious wake up of QemuEvent if the freed memory gets
>>>> reused for QemuEvent.
>>>
>>> This is true.
>>>
>>> Said that, if to follow my previous statement at [1] above, here I think A5
>>> is the UAF bug I mentioned, trying to free the lock object with existing
>>> user (Thread B) accessing the object.
>>>
>>> IMHO, the userapp should make sure the object will never be freed if
>>> there's any possible user of it, and that includes a waker like Thread B.
>>>
>>> For futex, the futex word (which is the important bit here relevant to
>>> possible spurious wakeups) is part of the lock object, hence if the lock
>>> object isn't freed too early it won't ever get reused, and then there
>>> should have no chance of spurious wakeups in the futex context.
>>
>> It is a UAF, but it is by design and not a bug.
>>
>> The principle of the futex design is to use atomic memory operations to
>> manage the state instead of using a system call, which is more expensive.
>>
>> This principle motivates tolerating spurious wakeups. If wakeup system calls
>> after free are forbidden, a thread will need to use a (expensive) system
>> call to ensure the wake up actually happened before freeing. Instead, we can
>> tolerate spurious wakeups without causing a buggy behavior by making the
>> waiting thread perform (cheaper) atomic memory reads to verify the expected
>> state.
> 
> Right, that's also my understanding that it's by design for futex from
> kernel POV.

I think it also makes sense from the userspace POV; it is a common truth 
that atomic memory operations are cheaper than system calls.

> 
> Which I am not yet sure is whether it's by design to be used in userapp so
> that a spurious wakeup could happen.  From which regard, I still think
> maybe we shouldn't have that paragraph in the man page at all, at least it
> can be clearer when put into man pages.

Eliminating spurious wakeups requires removing the paragraph from the 
man page and updating all libraries (including libpthread) not to make 
spurious wakeups, which takes a long time. We need to prepare for 
spurious wakeups for now.

I agree the man page can be clearer; the paragraph assumes readers 
naively follow what it says, but you need more insights; I also had to 
spend some time to understand the QemuEvent code and the libpthread 
code, which was unnecessary if the man page describes "the common futex 
usage pattern".

> 
> So now the question is, do we have such use case so that QEMU needs to free
> a qemu_futex_*() API based lock _before_ any wakeups?

We need to care external libraries that may use futex and at least I 
know libpthread can cause spurious wakeups.

Regards,
Akihiko Odaki

