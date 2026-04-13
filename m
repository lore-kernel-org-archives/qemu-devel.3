Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B52BE9380E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8dO-0006gS-UW; Mon, 13 Apr 2026 00:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8dI-0006dU-1Z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:10:45 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8dG-0004eO-F0
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:10:43 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso1538233a12.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776053440; x=1776658240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YHxstGbvv+o2U3Arox7wQdoz5xYWtAgzeZVF1NT7J+E=;
 b=gvNohYWJtZ0dxP2q0Ql0OWURfEIVBaJxWZQBqz2VofhsXZziTfqA3L+QsKP+dgJztU
 xliAv/gZWaLXfYsXr6w9sjma0fueb8xJ1YoTN86KtUna4+639sLoT0fvMhvjoVc1doGV
 fUlcb74Yb77fll73v8tN0FQucA1XnGgioMNFntwKHIDzinIaDwnUr3MoO30fHtP4lwuP
 vuwkIjp7fPgNWl9lialwnpv77iytjC9V6569OQgiZlaBs5hX73AZWG+UEkOY3kIzI1X7
 nTJmWJoayQ9K0vKB+GE/4sPKZN8nDhXz3jibwDQHp2/ShSpNxKP8d2TKv4pbSU626U3b
 NanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776053440; x=1776658240;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YHxstGbvv+o2U3Arox7wQdoz5xYWtAgzeZVF1NT7J+E=;
 b=OG4RtpKibC/9x+RNAuStDpkT3X4mClEkVQ4kxnLuPY3uMEXVu5pDVUahoDIlSW2IP1
 kpjNNxvYPm8wEuZjOwm+B+fyNQwlXvg3ccDUckc1Vi4cJ8y/A/T5uFqBUavQQbc3eu+n
 9QBD1oSwwz4Ox4cZ/Rvj+Wy2cWq54FBGbjLs24gQbuUHYJH2n0cFk6dIlqvN230PYodB
 9VbOV+7vHhEz9mR39t/EdMSWk9rQf/cYf2kanXkZjRKw4gfK2Rly/DDX9F42kLcm8QU1
 uIAeGryKPw42VZbaCjW94sPW7/qZ4G0kyIvwp6usrJbqbStuTrBYLR3vOMYVsabEZMir
 8Daw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NsDwSorBVq5YTQeTB57Je/FKJy5b5cIxJQ3PRCh9gjSy064fFLO2hv2uQZ8lcvpHrkDkJ7bjti3o8@nongnu.org
X-Gm-Message-State: AOJu0Yy6DvfD+YusSYFlZSRgKKTwiVE5TDS4IDWICfijmTsTcUNVDhqT
 FoZkWBSxdSjMq6XDgmhrbXnQ1TPC+UZ0T6hVEaUxNp0GWBhwgHMciOKAz+2z4VTsO0M=
X-Gm-Gg: AeBDiesDTiRjr3RKdLlTmkpdlRKpluztGODM7iMlcf6YvIH+fN2HNNvH6Q2QNjfoeqK
 +pEbbnWVKOQJe+MjMEF+uBoG76ZLJqHIIgrrzC1k8yqAgpI7KSXfpW76Jc/l/07ziDoSPzIYgg6
 S3Vt3t3Y3W4WjoBg1KWm1NrOOcvo7hOfQzH28IWi0u7YEPKyroXallSXchMQX2z6RCCTOJfTSVj
 R28lyKnejfJVR2JXLaNtiMCZ94WDJVrm15gUHi/gr1OvkRJ99K9EdPnNKP3EBdveeAA3or/scdh
 pz2NK5O3udDY9jrqrz+bTe/oUGojB4IENplQcNybCgN4TlTcG0jyiEAgbqTKAnmvtYqRh0xm4Y5
 7cSVcnZlRixyvShmVdb6fjay43UkBn4lOVB+JnmiqbwgQTxa9MeBdtzbQvKecxX/egBxtAqcrA6
 WLfn+AIDgWUl/9ExpyjmJ0Wt1Wh4B06rotypkesRJFQ1K85mr/7HGi/kRj5tmgbAECrVAKqnXcC
 i/LqfRu/Bfbpss1FpGe7kUm0UUk2xXSWErBuHXyjO0VqkntxAHpxVWr5CDCGdGXLg==
X-Received: by 2002:a05:6a20:6a13:b0:398:a060:a97b with SMTP id
 adf61e73a8af0-39fe3c2d507mr12853568637.1.1776053439671; 
 Sun, 12 Apr 2026 21:10:39 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79219c618asm8573976a12.18.2026.04.12.21.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:10:39 -0700 (PDT)
Message-ID: <cc74d383-ec4f-447e-a686-d4b39fe5c625@linaro.org>
Date: Mon, 13 Apr 2026 14:10:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/27] monitor: Remove target_get_monitor_def()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> target_get_monitor_def() is now only a dead stub. Remove as pointless.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/monitor/hmp.h          |  2 --
>   monitor/hmp.c                  |  7 +++----
>   stubs/target-get-monitor-def.c | 29 -----------------------------
>   stubs/meson.build              |  1 -
>   4 files changed, 3 insertions(+), 36 deletions(-)
>   delete mode 100644 stubs/target-get-monitor-def.c



Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

