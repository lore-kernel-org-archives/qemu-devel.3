Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09498C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 07:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tunkD-0000uP-IR; Wed, 19 Mar 2025 03:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunjg-0000pK-82
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:21:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunje-0005Un-7T
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:21:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so5594488f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 00:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742368864; x=1742973664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T3g9CfRZl8M5TsvLiCnsqp98a1vgPG/VuO5edVAbuYI=;
 b=xcjEZHAK3mDO0Deo4Fg7Ie6KKVOO2Rn/sGptgIc1cLOVYnlIG/p6KlwOE0zG5AfpQH
 qRNI6Tm/8R7fNsJ5F9Y2LnVahY7nTs6S3ZzIhi9dXdnjBNes0P+3QmK9MBh7vrkroG92
 doX1l6JX2aU7V9ly7bmAGYDuIiav8J58vrXjdB1gySbwuh+xRF2yPkcJ8ef0CTIb3lFM
 EFUtiNWB3VEgy9ED+LLp4u4SEVdU0jihcp4PBYjJ8dI4JyScQeJHQw/jsYsqYJe7n1L/
 n1tNrq7MuxsjwLrheVGRxl4s/Jlwqkvd246M/lwOVpwIQBMZkWwN5ECNLqnYWf8FvOMB
 sw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742368864; x=1742973664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T3g9CfRZl8M5TsvLiCnsqp98a1vgPG/VuO5edVAbuYI=;
 b=LV3FxH7jaDsBBu280i2LGSX89gOH328Qo4TaIT3ArTeITEN1omrStjmFkGjwxovOGA
 KQdgu21FtsPbw96BDqjCt/Ozqx/ydP3IX/fC5BSZheWti/7wZ3CfgjWCYtcC+4+/VVKR
 qHfcLmnzsHmWX9onOH1wV3ip4ZpOYbVT/3v27imh4XSRf8lvxFmurPg5h6veZPrLD4Gq
 E/0SxmCVJs5ZPxEv+yK4nLaF6+54HAZO8eUNOYH+ylnVvnoH+ej4ZyLfk9as2J9DByUC
 /b34dknifL8bKQ29ZGbkBzGAYO006TxDJo0zXiWQne7xWM8bqt/ZF0wQvP9zJtsPUabY
 KYIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRV6OQGVgBKdZZVBi+u9GHrCYUOblOoRAQZzrvtURhVY+a9L78hif2xkWrp7/Z9wTDlat+PTO0hcTx@nongnu.org
X-Gm-Message-State: AOJu0Yxi3tojNVza6b0EL3Jh3WzkjqjQfgLCRwXSxWa+QkQohHo+kULu
 eYnQyft4olbT2aKYT3aMyoJEbcFYRy6vtthPSVtL4ntjQJdrVFux+5y5zxHWonRrHvNz0Hevszi
 /
X-Gm-Gg: ASbGnctcwKajKK0wLqSdUlkchU57JpFH9lyVHf1Co3YxW/8kQwxVx0KWHseB/OY7jW0
 E5bfEvZI0nevpnEjj5AEgk+JRCxxjH0NoyO774YfFvDzFrwbPYIdB9m3Cdd6AXaA+unyg4y9ZV9
 ETz/1qMkxMHKlhk86qSZYMdPmvnAxcja+l+AZOsbHBpqZrSbBzc65rX43KOoYxJZN8oE0LwF2hB
 mvL6a8LD7wsASy5BqcJ3yP021L4/NunT2/dXvKT+SJjadBUXIWoGOo/1LAEn8yHdUxQa7xorUN1
 uwvRQAh4ciImEM4GQtOPrEQzcYLPb/Y4/1U7oBokhFVJl4ElUs223WuFKcJUBk5yZ6NpEXDgi75
 JekUqIIImSsHCv99Lf3jZtrQ=
X-Google-Smtp-Source: AGHT+IG9Ff3YCKVGF+aX3J0wGCuGeFGMt1hakfhToaRY0bkLRqOkP7UUlrQ2EfJjVNkr2SYXEtjTRw==
X-Received: by 2002:a5d:6d8e:0:b0:391:12a5:3cb3 with SMTP id
 ffacd0b85a97d-399739b63f3mr1077149f8f.3.1742368863869; 
 Wed, 19 Mar 2025 00:21:03 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea197sm19847818f8f.84.2025.03.19.00.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 00:21:03 -0700 (PDT)
Message-ID: <527eb1c5-59cf-4c8e-9671-f06343e9605a@linaro.org>
Date: Wed, 19 Mar 2025 08:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/42] include/exec: Split out icount.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-38-richard.henderson@linaro.org>
 <d57beca1-4be8-4332-b2d5-9f0368d7c007@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d57beca1-4be8-4332-b2d5-9f0368d7c007@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 19/3/25 01:33, Pierrick Bouvier wrote:
> On 3/18/25 14:32, Richard Henderson wrote:
>> Split icount stuff from system/cpu-timers.h.
>> There are 17 files which only require icount.h, 7 that only
>> require cpu-timers.h, and 7 that require both.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/icount.h            | 68 ++++++++++++++++++++++++++++++++

  ->  include/accel/tcg/icount.h

>>   include/system/cpu-timers.h      | 58 ---------------------------
>>   accel/tcg/cpu-exec.c             |  2 +-
>>   accel/tcg/icount-common.c        |  2 +-
>>   accel/tcg/monitor.c              |  1 +
>>   accel/tcg/tcg-accel-ops-icount.c |  2 +-
>>   accel/tcg/tcg-accel-ops-mttcg.c  |  2 +-
>>   accel/tcg/tcg-accel-ops-rr.c     |  2 +-
>>   accel/tcg/tcg-accel-ops.c        |  2 +-
>>   accel/tcg/tcg-all.c              |  2 +-
>>   accel/tcg/translate-all.c        |  2 +-


