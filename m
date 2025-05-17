Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DC8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 16:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGKQb-00041X-0U; Sat, 17 May 2025 12:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uGKQY-0003y9-7f
 for qemu-devel@nongnu.org; Sat, 17 May 2025 12:30:22 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uGKQT-0007ty-6G
 for qemu-devel@nongnu.org; Sat, 17 May 2025 12:30:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-231d4679580so16638855ad.1
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747499414; x=1748104214;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5k10H32Ut4UO7TZ4iloT7BiNYZGko9BMYrTf7997FKc=;
 b=sJklgaouVQkPJu0qIT4uO7XnYvNXXFmnGJvrB4c4klO44saBxloxBtY/OZlxc0PHR3
 Da870w91ejHzYGR+skqaGECXsP7SMzMM49Z7qAHQftIqAZrhdbQvK2z6kBdssZR/rISy
 Q4YdwxiOyHURCEJ/BwZEVcnGG6T6QBz0Ey4jlSPVBQbHdgn9RuqEXg+CWT6JRVUTplzM
 IMX0NpWHxHqAQR2qaRcntvJNIqOAmkngt/3Nxpe3BkAxwWECJOco7p5EmEvXhtvQAGbD
 W4h7OeEKHc7OFn1N1FWzVVQFYZ6JF7rZ10YBEN0xIseTJ7lpVXHlwOrKXHJ9rstQTPPa
 o90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747499414; x=1748104214;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5k10H32Ut4UO7TZ4iloT7BiNYZGko9BMYrTf7997FKc=;
 b=cXco2ioI99wq12swq9vYnj5R0yxW87zQxbeWgg4PHFnt/67R5OTgQ6BGchjekU6MQQ
 JIl/ds3b5FoYoKZhDTPp0IxuJAD/nOF2KgPTXQgZOwbE16DlpTBxie7eYGrlnXenes6q
 PcJygDBZn9/Qv1Uus9BSNPp3wSQ356gnrgSDeLikq5aMnWEjj9+g/laUhnBLDatzB5bP
 0pvFfuYr6YJauAcQqN0oCnNq9jT1wcRO2VruhySl7+LHKMXvmw2Yz5/zktho90dp0Wwj
 p8NMBw8FSnnbnOlOBil1XbjvRx03JDqZ1nE5Ezi6oKD1duy2/n+hLMuZXmNZJhw4r2B7
 nYsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4XEG6zf0KbuAGsT3la8MZrUDPwoFcJeN2bj2ONcT0GtJbk4vL7LhwPYMhQGuZI5OihcSCCw/2aj21@nongnu.org
X-Gm-Message-State: AOJu0YyxptaPFUR6t0k61pvLrytF7Im83zBvLJc2SG/axKPeoWnt9XUB
 yaqGhMaqkpvdb5G2dtLf5b6h3pSpVuju/lVed87v7zG6v8iRvL3ayLYughlYA8A/xLU=
X-Gm-Gg: ASbGncu86cAL6PLVwSUPmIB1aoIReIKYQvToPQ/kNi9Ywko94xC8x2BmKr9mRTtjASb
 6zmH7QEIfY1DSG59boi5qaR1/+JMIXVLTirOESN/F02i0nuDK01L1BagWhl6xfRXrvVTYaS7Z7M
 /3WNbHr9r4QC06qN0tU0NJU4OQ4eKNoZEOCEevW6B6nFYTD3UN62oR8X0RXnFUqL69KTcY68dgA
 4nUJwy5PvCsAKnA2INu9JHlwCSjafTBseNfD/FJOM/18VPhdup/7745KTrPvS+pUtAQSBLTx+CE
 JD5qTvsZbSlHKPkhxWF7K6kR48R+S/5UMgSPBol2wbBqS6jDybl+9YjXtcUYIplxAksbbAcTxMk
 o5kqIjvke5L3u7RFHcc7FMepomn9n8QhIOxCOo97g
X-Google-Smtp-Source: AGHT+IH8Ib+xgfSVtepPnJGJkF2IDZq6PRS91fohXDPkgVljqUEanl5SnKgmiv+fKE39QYQ6Gh41/g==
X-Received: by 2002:a17:903:18f:b0:224:249f:9734 with SMTP id
 d9443c01a7336-231d43d9a1fmr107551215ad.4.1747499414320; 
 Sat, 17 May 2025 09:30:14 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231e26d83basm29016445ad.6.2025.05.17.09.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 09:30:13 -0700 (PDT)
Message-ID: <ab6b66d7-fa8c-4049-9a3b-975f7f9c06ab@daynix.com>
Date: Sun, 18 May 2025 01:30:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] qemu-thread: Avoid futex abstraction for
 non-Linux
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel <qemu-devel@nongnu.org>,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-4-f7f69247d303@daynix.com>
 <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
 <a40b0b1d-b1f8-478d-bde4-cac386323691@daynix.com>
 <CABgObfa+sBbA3OURGm=6WGzs1TQKyaHjRj+QS3n9dUvSjEPkZw@mail.gmail.com>
 <12b1dba8-ecb5-4167-841f-0a32256285d5@daynix.com>
 <CABgObfaT6XJTkkQMfQt4bMhXGu7EvTqAv-qf+qStU9cezBwBgQ@mail.gmail.com>
 <036ed37f-9403-40f3-9c07-4555d666894c@daynix.com>
 <CABgObfZG6pTned+YKtaU3ov5C15GdgmDygZTEGNiwyzwnrVELQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CABgObfZG6pTned+YKtaU3ov5C15GdgmDygZTEGNiwyzwnrVELQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2025/05/17 19:24, Paolo Bonzini wrote:
> 
> 
> Il sab 17 mag 2025, 01:41 Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> ha scritto:
> 
>     I think we only need a store-release, which is ensured even by the C11
>     read-modify-write operation; we only need to ensure that ev->value is
>     set to EV_SET after all stores specified earlier appear.
> 
> 
> You really need a barrier to order the store against the load 
> unfortunately. Likewise in qemu_event_wait(). It's really central to 
> this synchronization pattern, otherwise it's possible that neither side 
> sees the action of the other (set does not see the request to wake, or 
> wait does not see EV_SET).

The code I suggested does not order stores before qemu_event_set() and 
the load in the function unlike qemu_event_wait(), which orders stores 
before the loads in the function. I'll show how the code still satisfies 
its goal below.

Below is the list of all relevant memory accesses in the thread calling 
qemu_event_set() and the one calling qemu_event_wait():

Thread A:
A1. Specify stores
A2. Call qemu_event_set()
A2-1. Call qatomic_xchg()
A2-1-1. Load ev->value
A2-1-2. Store ev->value
A2-2. Call qemu_futex_wake_all()
A2-2-1. Wake up

Thread B:
B1. Call qemu_event_wait()
B1-1. Call qatomic_load_acquire()
B1-1-1. Load ev->value
B1-2. Call qatomic_cmpxchg()
B1-2-1. Load ev->value
B1-2-2. Store ev->value
B1-3. Call qemu_futex_wait()
B1-3-1. Load ev->value
B1-3-2. Wait
B2. Specify loads

The goal is to satisfy the following two cross-thread ordering:

a) B1-3-2 -> A2-2-1 (start waiting -> wake up)
b) A1 -> B2 (stores before setting -> loads after waiting)

First, I'll show that a) is satisfied. There are three facts to consider:

- There are only two stores for ev->value: A2-1-2 and B1-2-2.
- A2-1-2 stores EV_SET.
- B1-2-2 stores EV_BUSY.
- qemu_futex_wait() atomically performs B1-3-1 and B1-3-2.
- B1-3-1 will not appear if EV_SET was loaded earlier.
- B1-3-2 (wait) appears when B1-3-1 loads EV_BUSY.

These facts ensures one of the following orders when B1-3-2 appears:

B1-2-2 (store EV_BUSY)
-> B1-3-1 (loads EV_BUSY)
-> B1-3-2 (start waiting)
-> A2-1-2 (store EV_SET)
-> A2-2-1 (wake up)

Next, I'll show that b) is satisfied.

- A1 (loads before qemu_event_set()) appears before A2-1-2.
- Only A2-1-2 stores EV_SET.
- B2 (stores after waiting) appears after B1-1-1 or B1-2-1 loads EV_SET.

Therefore, the following order are ensured when B2 appears:

A1 (specify loads before qemu_event_set())
-> A2-1-2 (store EV_SET)
-> B1-1-1 or B1-2-1 (load EV_SET)
-> B2 (specify stores after qemu_event_wait())

Regards,
Akihiko Odaki

