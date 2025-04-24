Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032F2C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qXF-0006N6-F1; Thu, 24 Apr 2025 02:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qXD-0006LE-Po
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:58:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qXC-0001J8-5v
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:58:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso5933525e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745477888; x=1746082688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCQy5R+RF2DL85aOpCkrhZKW+JqhoBKv5AjtTOKooUA=;
 b=UDWbbi4KXv4ut46GMpw+1VKWRvIQry9gt+PVa+f9B1o3nOTkaRipF7ONQ683ubySeW
 cXXRIyFobcIzmO45WieVOj+GPDcLtuyFWElFr9tG2+DF7ojEAXkYRsWz34cE9YAsyp53
 W4YhBe5Wztudp56moP6fsLD9sg6QfHMQJFVFj4MBzbma9cKGI1PQPaOdcTQDxJiim0qn
 mlkpxqyBU5oe0ItCOxT9wkFIplIHGFhO0KFOWPRj1WRXsJZV8ZpYvF7eOyhcsD8DJUP/
 zwANno588iD4/KUskyV7ogCdC16tzbCYdurnVo013+8GFBRw2THYDh2V+a61OA5dFpqm
 JJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477888; x=1746082688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SCQy5R+RF2DL85aOpCkrhZKW+JqhoBKv5AjtTOKooUA=;
 b=LFlBoFkft2V8qSxRxaMhudaQ/qZu1EuMC5eWuD+fBBwgen5t/kJPkZN1DvToll50Ku
 T+o2I/ifZKNsHX6Jgt31eDtiWh54HBwenxj43mCzmKnBcJQab3xySaSmvurpPYOozyW0
 xfEszzzzcMUHbt47RkuZ6ShgVEYmajtU0O1rRf2rKx2K75onLJR8lKeMSX9/OmLn0rF8
 /mhl87TvYvyuXPya3CnGv6djDgngdVr1RU+Fwf1RvNq6Vg5LghTgnIkqYLA/V06vkatB
 yTPyNX+Zz6XyiS7t2tBuw5x+lw9PykZeMPnaRu6+lJQ2qLIv6AKJ74TqtePj7/a7wlJX
 QxKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH9vI/vKSm2rc5ZknQoWjCKyIt0pmCt6T1wsf/dWUgpNl6wKhy5oVAKUOPh46H+SLcpb90r4Rv/tKs@nongnu.org
X-Gm-Message-State: AOJu0YxgYhMEGcXAg+Ctt4QzfHncRMw59o5DD8FYQG+D2zYMH4BuEd/Z
 H46iawGXfAiQi04yxqEfNeOaBMmyEo8MXKuHmB106oFeTUiztLTtGk1s+58LVnrPtpIaoRXaQCw
 8
X-Gm-Gg: ASbGnctnDVMea2gVJ1uOPnWCWjoWEWY4ORPghEvosEkR3LeWFZ5b0No48V9QjJizzYb
 jJ/RB+nbFgkPzew0t7o+QErUj7SNpouMLM8lsnCEDk15XKHeXA/rlodHKvrZZCKLjk9+QEV8DIG
 I8tjO4PFdnYJI2b6ITKH9p/v/B5TAsoEkOVUyumt8524mwsZWgFpG1LHQ2Y+JRL9rczevEDOVlI
 8uPb7XJjDPeYGgaVBWM9SN7JBPscoumBep398kVS/uSZ7KxPzcmB5HbNDIcsnJHsLnho/4sNIun
 WNYULa/o5XzZT1dtls6xuyms6g7HdOo62OmkWOltk6TESpQzl+LkqsC/AgbwBICeVaIdG6cr2Wx
 j+54EGB5J+f0x0g==
X-Google-Smtp-Source: AGHT+IFIEHiPp6PsyJb56LR72qda8OneY0t9eNvdyOpOEWYzfU+hMzPeMcTo/fMNyFwRnAY5yaUG/g==
X-Received: by 2002:a05:600c:3d10:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-4409bd781a7mr10978335e9.22.1745477888429; 
 Wed, 23 Apr 2025 23:58:08 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d04802fsm43822245e9.1.2025.04.23.23.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:58:07 -0700 (PDT)
Message-ID: <82e1e679-3c86-4c60-91d4-aedfab44334c@linaro.org>
Date: Thu, 24 Apr 2025 08:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_range
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h   |  3 ++-
>   accel/tcg/tb-maint.c      | 10 ++++++----
>   accel/tcg/translate-all.c |  2 +-
>   accel/tcg/user-exec.c     |  4 ++--
>   system/physmem.c          |  2 +-
>   target/arm/helper.c       |  2 +-
>   6 files changed, 13 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


