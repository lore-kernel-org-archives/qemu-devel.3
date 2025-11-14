Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73276CEACCC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK0Na-00034I-KQ; Fri, 14 Nov 2025 15:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK0NU-0002zy-JT
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:26:41 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK0NQ-0004KH-Dw
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:26:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4710022571cso22705545e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763151979; x=1763756779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xG4g/NAZGGMi9Kvsw77di4WNNkm1HsgWnLkKcNjwZ7g=;
 b=tH6lwCedPxwIKzbf5mmYQSP2Gr4aG3NBsoWygHZe4f9T4np/PN43Oj5C6KfupBdqls
 R8hxBDoPKhrZLnIhNuG+CCEaJDg7ojpolNNxMIOXI8Fimx/3qsdlzJd6aPmt1V7F3Xsm
 arjpdfiYvtxbKb5uDwlY3fh/89g0x6B2Btc7+zBhgfTMlfAnoXhJLYJ9TMTjMjXaKM+I
 iEWJK7K+s0HCo38U+fxUDswKHP5112M855EmR/GZjLbmS01/E3h+aD3S7k7ippEY7+ab
 cmxouc9em2TsOpplvzEv0Z4SFP5LUVVlF+IrQHNFIc38Tx4JCApuB7zSqrlKDhSGXa1X
 sbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763151979; x=1763756779;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xG4g/NAZGGMi9Kvsw77di4WNNkm1HsgWnLkKcNjwZ7g=;
 b=NJIKX97q0rNTeS8R7pNBLI6pLO4euKluAz2vwZG+5AORlxP5WFCv25vVis+h4BjqJL
 f012NKdlMw8wSaEy3B3/7WomvAcFItdAYCqJYSKk5gj0T811efAFqFdxW1rzRdnrvM8K
 5+1s2YAh3uqPaqRXHlWwPQ0vaUYVnhyEzD0xpfrqql7iQvAwsDv3MgRNN/An12PW/BVw
 n1H0NYpG3fpZcufgMvIb0ti7+ClJAJpzdCibVKCfoEnWBIL7tZP2ClEPbL0JZeRIh+8r
 HsaXhqzgFhv0VQ7Gnekq8zZDA2mySrM466pWmhvCLA6qNiYO2QWnJKL5SFb0N19X19K1
 t1Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYaKpmU26jd1kb/EItS+YdH6RUnCYC9LFgRCMOZq5REoxRAYe6LIyXtO/h4weG0j8i3ZJBZQRvJw1B@nongnu.org
X-Gm-Message-State: AOJu0Yx6Eelhoo47jPvsE9cgLPWMU98N89liHylpFiI/KacLadGkD/M2
 xCwNNl4lLsp/NTvJQdqGOyU/kgNaCjdrcRN9/G2CCfkia3cnTTcDT6dLH4Uza8Wsek4=
X-Gm-Gg: ASbGncttTj+aEnnMeRum8Y72h7AUksEjyq3UIXxOQ672D/HCCgcppr/h1q5HytoO9Vt
 o7IYVbyjMaOGS4f6N7QRDE6dWmpY58QQnBqwq+B5X4yFvy7R0hcFBdekkCSc/2k22HX/2VsPKf9
 tr1TBnejFu97fB86nIfbGwLskk0Cw9OBt0aG3ReRG0aX7JTwVIu9Jf7qe4uBJTaUp7yK9RsnwjE
 R8IgE+afWEbQANu7u6YgAGxuEz7lJNqAZnarWblsBAb0l16WmOnAEqPvA+j6az7RRL9yTP0WaZJ
 549UOLm4J0Ff23jSJnV8EKzwn5uUQBkEl2Q6EtUUkZfYJSE6/qx8NXepFqD6xcSiMnNfZIYjEGE
 uGHpbOOxQUu/etQNFCxrbwX5TARGj1ZSABBzb6gYTs93VdkdgEhppBdo9Q3sxdi9CBFr4oGVrTc
 Mbi31U1GdUPST1RhQay+z0ysYpsoYEVlmNUECa9VLZHMNSeUE/5M+uBw==
X-Google-Smtp-Source: AGHT+IE7LEp3wvTbxGoQSpM4iC0ToqH8G/sAwa2NEEgcxeU/Iz5b5IxmKb+qGPak0nUk6lNHlIQlUg==
X-Received: by 2002:a05:600c:a06:b0:475:e007:bae0 with SMTP id
 5b1f17b1804b1-4778fe5ef06mr50030655e9.16.1763151979099; 
 Fri, 14 Nov 2025 12:26:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bb54bbesm52081065e9.5.2025.11.14.12.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 12:26:18 -0800 (PST)
Message-ID: <b4d9cac0-8f72-47c2-8357-021c6d6efbc4@linaro.org>
Date: Fri, 14 Nov 2025 21:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: fix potential out-of-bounds read in
 rpmb_calc_hmac
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, zhaoguohan_salmon@163.com
Cc: bmeng.cn@gmail.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
 <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Zhao, Peter,

On 14/11/25 14:39, Peter Maydell wrote:
> On Thu, 6 Nov 2025 at 07:29, <zhaoguohan_salmon@163.com> wrote:
>>
>> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>
>> Coverity reported a potential out-of-bounds read in rpmb_calc_hmac():
>>
>> CID 1642869: Out-of-bounds read (OVERRUN)
>> Overrunning array of 256 bytes at byte offset 256 by dereferencing
>> pointer &frame->data[256].
>>
>> The issue arises from using &frame->data[RPMB_DATA_LEN] as the source
>> pointer for memcpy(). Although computing a one-past-the-end pointer is
>> legal, dereferencing it (as memcpy() does) is undefined behavior in C.
>>
>> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>> ---
>>   hw/sd/sd.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 9c86c016cc9d..bc2e9863a534 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
>>
>>           assert(RPMB_HASH_LEN <= sizeof(sd->data));
>>
>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
>> +               (const uint8_t *)frame + RPMB_DATA_LEN,
>>                  RPMB_HASH_LEN - RPMB_DATA_LEN);
>>           offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
>>           do {
> 
> What is this code even trying to do ? We define a RPMBDataFrame
> which is a packed struct, but now we're randomly memcpying
> a lump of data out of the middle of it ??
> 
> The start of the struct is
>      uint8_t stuff_bytes[RPMB_STUFF_LEN];  // offset 0
>      uint8_t key_mac[RPMB_KEY_MAC_LEN];    // offset 196
>      uint8_t data[RPMB_DATA_LEN];          // offset 228
>      uint8_t nonce[RPMB_NONCE_LEN];        // offset 484
> 
> so frame + RPMB_DATA_LEN (256) starts 28 bytes into the data
> array; and then we're copying 28 bytes of data?
> 
> The existing code (frame->data[RPMB_DATA_LEN]) doesn't make
> sense either, as that's a weird way to write frame->nonce,
> and the RPMB_NONCE_LEN doesn't have the same length as what
> we're copying either.

Indeed.

> Can somebody who understands this explain what this code
> is intended to be doing ?

We hash the frame data[] + nonce[], and work on the card block buffer
('buf'), filling it before hashing.

This change should clarify:

-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9c86c016cc9..e60311e49a6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -125 +125,2 @@ typedef struct SDProto {
-#define RPMB_HASH_LEN       284
+
+#define RPMB_HASH_LEN       (RPMB_DATA_LEN + RPMB_NONCE_LEN)
@@ -1164,2 +1165 @@ static bool rpmb_calc_hmac(SDState *sd, const 
RPMBDataFrame *frame,
-        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
-               RPMB_HASH_LEN - RPMB_DATA_LEN);
+        memcpy((uint8_t *)buf + RPMB_DATA_LEN, frame->nonce, 
RPMB_NONCE_LEN);
---

Regards,

Phil.

