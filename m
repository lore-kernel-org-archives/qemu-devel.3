Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B87CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuS80-0006IO-9p; Fri, 05 Sep 2025 04:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuS7y-0006Hp-JD
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:49:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuS7v-0000JN-Sz
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:49:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b79ec2fbeso13249085e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757062137; x=1757666937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vImP57uZdAHyI8QEZvlJW9RPbCKH2D2IL9McWfoLgT8=;
 b=LyJruntsy7Whhc1Of2no1VBsfSy9i1C2o3+xfU91bjSZRCI4eiKCpRUFHRedg/8/M2
 wVRvur6hUJoZk5zph4ksMrdvBEN/RMpbS0k7aGuvCXB19FkI4eViX5H2QUhCAFMYwtXZ
 ljMFYTvvtf85BOdMzidz7JXYMo31j3Oj+fXcBee2HvosPNH7uWUEB/bxq2q5LIrl7mWE
 bfTtPp0/+IUW97FVWuZtuIMYuyRxMM4zNFDemj4FKWGConZrPIUtNTJp+Pzrj7z8hu41
 RT/xrK/pw4vyx5lSRlBqgz874uWzc4fjHaepNDfLj3gD75agx33N76O0bH90wQmtcwUZ
 Z7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757062137; x=1757666937;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vImP57uZdAHyI8QEZvlJW9RPbCKH2D2IL9McWfoLgT8=;
 b=qUP6tfHnLcAnjfA2Qr4WcfozLfgxUDEDv93y7GbqYB/Mpm6vQ08jHapfiv1a8mvFtP
 OFv4cK9vwghihXbfWVuRJJoG+WZV7prztQL6zu4o5PBsvGuPXyRQzhqT+Gy1VMjxwMVf
 PlRQ17IHBqRLvo3FYSzse+8gO7EnEIaNxl+wn2ICKaM9zSGE4iUHNFBdDiFWJ42O1lrC
 hgi4RiROovXA0ZkbyszY1u8qY08RJWHDpAT6Jm6ZaaDkKkXeGkun2y8DKR9xdkdmDzUh
 vWy4R6noMbKzWQUfHlyoC9OzujtwMPiEgkAwEJXch0DdHPx7bx/Fi/fdbIqU4f5KyFGz
 5T+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1S5VZhStlDApueI2sI+yYbgWoOpJaYTGtmrUE+xmPsgG9Yaqgu/Bs3eFjbZxTRRHUaZgfyVoHsBQT@nongnu.org
X-Gm-Message-State: AOJu0YxW4+W7fsm/HEa2Addd9A2JlI2izx8BGXwaDdDYCO9SG4LgH0DM
 dBl9akOglH1VN5zA55/GduKa6rgYDrIhjNt5pk8wKz/432OSJN4nquqGuQ+nAns91iA=
X-Gm-Gg: ASbGnctKBzM7BZ/ExwIIeoQCPTQvUkzZgTWbfq/YggtjjQsd3tPxARQ4/QhQWAFcm1k
 JgKR3cDkOQyQ3bLNHks07d9uzz1bxjaq7f6v96ZVXm2m/IlruCsSeJl9+GUHl7y4X0gaWhl39CL
 folKiNwWQk4nt8bFUDwlFqIhg2+MZHIm7DXt9N7q7X+p8YyYp+NslvxwiGiY2PlYNn+FkJX4YlX
 AXs/RktZ3W3Zh5mtp93Zaw4U4ioggFUfrdbhVrnyW1aO/KRlC5vgSmUu4ipFOnNarf+rey6hBkw
 cP4MB7h7zhoW95BGbkTcW06gS093DlnxETImLuYydSW/eazp9GEi9yUvc6m/icYsImPklsN6D6Q
 P2ezCFRJQpih6DdymCa7fIPUkILTh8UZoUKyr
X-Google-Smtp-Source: AGHT+IH/yNpBBD8xGqrUvdTw9BU5RwTMu6JSYdBGtBukpXp97mML7oEPyuvDH0LdVrxiQOql18Yn9Q==
X-Received: by 2002:a05:600c:a46:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45b8558a78cmr211269555e9.17.1757062137460; 
 Fri, 05 Sep 2025 01:48:57 -0700 (PDT)
Received: from [10.175.133.6] ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45ddb779eb6sm4300895e9.8.2025.09.05.01.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 01:48:57 -0700 (PDT)
Message-ID: <80ba3dae-0bb9-4a45-b1f9-5b80f4fdc47b@linaro.org>
Date: Fri, 5 Sep 2025 10:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing includes
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Foley <pefoley@google.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, nabihestefan@google.com
References: <20250904-includes-v1-1-a04a0ea14fd1@google.com>
 <687f76dc-769d-4e8d-9281-5e5f10361bfe@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <687f76dc-769d-4e8d-9281-5e5f10361bfe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 9/5/25 09:31, Paolo Bonzini wrote:
> On 9/4/25 17:21, Peter Foley wrote:
>> We're getting errors about this:
>> linux-user/elfload.c:2770:36: error: use of undeclared identifier 'MAP_FIXED_NOREPLACE'
> 
> Queued, thanks.
> 
> Paolo
> 
>>
>> Signed-off-by: Peter Foley <pefoley@google.com>
>> ---
>>   linux-user/elfload.c | 1 +
>>   linux-user/mmap.c    | 1 +
>>   linux-user/syscall.c | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 26c090c95d3e90ad4a23a927267e4106f68975b0..edbacf041f25d88472c95efb4eb9bdccd81e9902 
>> 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -5,6 +5,7 @@
>>   #include <sys/prctl.h>
>>   #include <sys/resource.h>
>>   #include <sys/shm.h>
>> +#include <linux/mman.h>

There's no reason to include <linux/mman.h>.

This value is provided by <sys/mman.h> directly for musl and by <sys/mman.h> via 
<bits/mman-map-flags*> for glibc.

Are you using some other libc?  You're solidly in non-standard territory there.
Perhaps that other libc needs updating.


r~

