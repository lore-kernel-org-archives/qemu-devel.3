Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78149C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNUN-0004Pb-94; Thu, 03 Jul 2025 13:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXNUL-0004P6-WF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:12:46 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXNUK-0001iB-FS
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:12:45 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73b5350980cso722433a34.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751562763; x=1752167563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o2YgT6Ve08VSJ9Xm7zuhLRjJnhUbfcigwOq/fj4ARCw=;
 b=L3vqJIkpjRoMAO+3UNAlSk+WJ9ABYGAhCyIdE2QFLnQerrzRlOXCYHJC5bv3XwPMj7
 f/ZX8up3h+AuE+gas+waeZGbo3oE9VEwvmeKYjTYrPe+rl5d7J08ddqROjDUpP9wrZJ0
 0upmxo+4B5HPKFVImX+X0aTRBlGZ7mNv0mJQpHhe1EmPoVXS41+IzYOWWgQvF7XI477d
 e2Oitn5MvTa8ftBCVxyte0XFJh3dvMEAY3g6ogBypJZ/6/zRPRjkPuVj4axgsRvvS6vX
 xyuTdD4OpQx0AXv9UE9YxS8dsnh2qnDT3i1lRdzL6x+FUhduKPXagZxW5Ou4IznbuSna
 L38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751562763; x=1752167563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2YgT6Ve08VSJ9Xm7zuhLRjJnhUbfcigwOq/fj4ARCw=;
 b=nmi/HgLbeEHP3tKNtF1MR/0pW88j17iIpBWrjiLC/tnMxc5AQSFTkOunVxYYu0ftwO
 V3A+5/fvxdXsMi320sr6yjU4DtjzzrMrhZpBrblr9TlvXJWkTVLiNfr2OiybFP9JFr3Y
 6qVBg/jtGrY1ve+sibzEZJYgK9xTJADjR0387jTjnk9wrXME+r+8CdhZPmIhyzoHgDU9
 UERWOh9p3pn5cI0AX6xLBCgP28kjAJ0FzZorNxzDtEIQTvDoTDYAVJrZ2mb7sJFsESLX
 88qdaR6OaMpPOwChkYdoArlufcfqLwJO/XVg047b5alGXZyh1/StELWpdETYws3cCF3B
 S9Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNMKKTLF9FgFYxku0SvY2TpbxX4yQlUrP85P/yqgvINf7f8rTjfAI6MP+aaJDTz8Wnb+oh7rRS6/je@nongnu.org
X-Gm-Message-State: AOJu0YwH5XocRSU5jmT/GmjlYlO5/5n9Cw4FCt9Z36iV+FG1Asp4PKgI
 xdU9Ckj4DFPzAxN570VIv6DzF7vl02Rxq2R7u1Ihz3PKDKExga6KIGYvP/PG/ros5Q8=
X-Gm-Gg: ASbGncu+BxKsLKa7wknJOE1SoYDcVOMPLds+sbQvuI82s2rQezxrktO6OBR2VlI/FVH
 1fZqjKmghehURo9sFG0SK2cJo7pDeZLLVrEFW40dDq3wVHQPcMpTtlGAO719mQQzOGou/AlyHQR
 mnvpmnnp0wndsHKuYNcic6tnvYy9mAJ5SqMCzTa6gCiK/ppJj6+EogVzbuLGczCvjh5VTmgFlrz
 7oao82Z+X+w8Jkiddx4bDDcA0AXaHAy/8XO17ZlfA/tukU7FF+5IeWvZuzb9fJFXAt8751Ra3V+
 XVl0EUf9rdDaEi/HC76PTrbHlITs7QGZRvC8DXZN6hiu6eNovmpwqNwf3tGu8vDIWHTAAaaT216
 X
X-Google-Smtp-Source: AGHT+IF5l9apRRehOl6m5fQfC7kxHzdRpKufN4Z2O8WUBM7+FA5gQoKNugd8V4FGWEYtQvwAJLiaOw==
X-Received: by 2002:a9d:694e:0:b0:72b:7dbb:e39d with SMTP id
 46e09a7af769-73ca0458421mr3637a34.1.1751562762941; 
 Thu, 03 Jul 2025 10:12:42 -0700 (PDT)
Received: from [10.25.6.71] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f751e3csm33618a34.17.2025.07.03.10.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 10:12:42 -0700 (PDT)
Message-ID: <0243f1ab-9b75-43eb-8bd4-57a3bd9ca579@linaro.org>
Date: Thu, 3 Jul 2025 11:12:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/69] accel/tcg: Remove profiler leftover
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250703105540.67664-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 7/3/25 04:54, Philippe Mathieu-Daudé wrote:
> TCG profiler was removed in commit 1b65b4f54c7.
> 
> Fixes: 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/monitor.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

