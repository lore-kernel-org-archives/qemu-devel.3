Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A40D6406B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Sgq-00006u-6d; Fri, 08 Nov 2024 12:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9Sgk-00006N-SW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:22:27 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9Sgj-0005TX-8d
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:22:26 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9ed49ec0f1so402045566b.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731086543; x=1731691343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4+qhtb9s9ocFtFV1XMcVk3c+uFSHsXMugHfYW9GOxjU=;
 b=GOOVMccDDT3cIcTOMa1EvTYm8WG03sWwO8z3YskAjb5Jt0VU4Sza5vLN2eiHqj5y4S
 6M7FqsEfomkS7vqTXHAUkZAtbpkUBRqCw5Yqa3gjXTCggw4y/g2gNi1AW4/+tnfDAeOD
 g1ryVSxs4Sr0MIq61WA0LhXVS786O9mmhxVnbxgWLGA1y6ag9jQuYHeNGVSQjwtjqtoP
 8sHMJTyibCN+3mo8s5QvB5z8dulM8hhdWI/zkIzr5W5hYSflzRfRYfAEVEdCBwC1WjRY
 MXVRuDMyGFxhLmUuUNbzRkb+vLwg028eVLWtmcclYk1Y6sxqIdazYMGaZ9gs4ZAmNA+l
 akLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731086543; x=1731691343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4+qhtb9s9ocFtFV1XMcVk3c+uFSHsXMugHfYW9GOxjU=;
 b=SZCI4x02BVgHu7Id4Zk/Jwi/qBSSjAumxxwpN+9j5tx+Shyjk+Rciu9ocjg0gLBGAz
 /HgoT/yg1f1acbwQf/z5DWlT2LdZ+cKPkLesdYpmLExdtMVE3xw0F70MmjVZJGGKSVNM
 fSyQprRDlmUWHeuixu8cGd7RQkuADqXeehmV3G5jFSEaXaw3uW0D190O0Zq6OfsjAL9Y
 UCKTSkJ1CToLqeg+g8G8IUy5VjjCxAbazfrfOopf1R04dNagV/7hgqIK+wKkIztHPK6g
 uRPyj6k1vIiMbqI0JffYrp4g27BWMB7bQFiIGhTFbNxxfuRYZcC7GxjIGf3Atrbw5yd7
 eVaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKeAShDv0ASmiTqKdA+Tqq+c0I9ST7jZ+F0whc7ayztrbqBD8VDoeb9nqMRKb40oF6sg51gSPONWCk@nongnu.org
X-Gm-Message-State: AOJu0YwdN6iLU/FWKhNKVk3tLJYMHC3j1RoBF7AKW1I3n4JG213KCtfQ
 0s8XPFI2xQBpfbVTdZQep/kX7FN9eG5YNhYZgLaiC5kB9INLKVQm5ioX9PZkH2Y=
X-Google-Smtp-Source: AGHT+IH7MhPSqCtyG/1kgCdF8gneSpnQJhXLPqPb63ovhcxRY8mwuHqY2UN6HwNPQPtbdKSQHqYMhw==
X-Received: by 2002:a17:907:6ea4:b0:a9e:c266:2e15 with SMTP id
 a640c23a62f3a-a9eeff3ebc6mr355696966b.27.1731086542679; 
 Fri, 08 Nov 2024 09:22:22 -0800 (PST)
Received: from [172.20.143.32] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0abf305sm256134966b.86.2024.11.08.09.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 09:22:22 -0800 (PST)
Message-ID: <a94d3c4b-374b-4266-85b6-cee44b54f03f@linaro.org>
Date: Fri, 8 Nov 2024 17:22:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer: fix possible int overflow
To: Peter Maydell <peter.maydell@linaro.org>, Dmitry Frolov
 <frolov@swemel.ru>, Evgeny Voevodin <evgenyvoevodin@gmail.com>
Cc: i.mitsyanko@gmail.com, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20241106083801.219578-2-frolov@swemel.ru>
 <CAFEAcA9joGGX46UnkVvapvhyFr7ryhMeczWdT7D+wJLfR4wyCA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9joGGX46UnkVvapvhyFr7ryhMeczWdT7D+wJLfR4wyCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

+Evgeny

On 8/11/24 16:47, Peter Maydell wrote:
> On Wed, 6 Nov 2024 at 08:38, Dmitry Frolov <frolov@swemel.ru> wrote:
>>
>> The product "icnto * s->tcntb" may overflow uint32_t.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>> ---
>>   hw/timer/exynos4210_mct.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
>> index e807fe2de9..5c6e139b20 100644
>> --- a/hw/timer/exynos4210_mct.c
>> +++ b/hw/timer/exynos4210_mct.c
>> @@ -815,7 +815,7 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
>>           /* Both are counting */
>>           icnto = remain / s->tcntb;
>>           if (icnto) {
>> -            tcnto = remain % (icnto * s->tcntb);
>> +            tcnto = remain % ((uint64_t)icnto * s->tcntb);
>>           } else {
>>               tcnto = remain % s->tcntb;
>>           }
>> --

Alternatively we can declaring icnto as uint64_t locally:

-- >8 --
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index e807fe2de9..9fae2ceda9 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -787,7 +787,6 @@ static void exynos4210_ltick_tx_commit(struct 
tick_timer *s)
  static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
  {
      uint32_t tcnto;
-    uint32_t icnto;
      uint64_t remain;
      uint64_t counted;
      uint64_t count;
@@ -813,7 +812,7 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct 
tick_timer *s)
          tcnto = remain % s->tcntb;
      } else {
          /* Both are counting */
-        icnto = remain / s->tcntb;
+        uint64_t icnto = remain / s->tcntb;
          if (icnto) {
              tcnto = remain % (icnto * s->tcntb);
          } else {
---

But then isn't it equivalent to this? Dunno, I might be
missing something...

-- >8 --
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index e807fe2de9..d8b2c72b73 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -787,7 +787,6 @@ static void exynos4210_ltick_tx_commit(struct 
tick_timer *s)
  static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
  {
      uint32_t tcnto;
-    uint32_t icnto;
      uint64_t remain;
      uint64_t counted;
      uint64_t count;
@@ -813,9 +812,8 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct 
tick_timer *s)
          tcnto = remain % s->tcntb;
      } else {
          /* Both are counting */
-        icnto = remain / s->tcntb;
-        if (icnto) {
-            tcnto = remain % (icnto * s->tcntb);
+        if (remain / s->tcntb) {
+            tcnto = 0;
          } else {
              tcnto = remain % s->tcntb;
          }
---

> Applied to target-arm.next, thanks.
> 
> -- PMM
> 


