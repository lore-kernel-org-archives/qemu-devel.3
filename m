Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49543C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 19:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgTd6-0002U5-OH; Fri, 07 Feb 2025 14:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTd3-0002Rz-Kx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:03:05 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTd0-0005QI-62
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:03:05 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f4500a5c3so41287275ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 11:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738954980; x=1739559780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x5iLhqQVo5p3cfm1ZHXkEjzjBbO03jMKvKOw7vCeE+w=;
 b=C4eTpiczapIPhgWIFBn5btO97h5HQLR/En4pq5mvv8bFJDw0XpnlwnB/QjkeBUil9F
 bc7qgN4QYSOhKIVGUSoCmDUjcH2fkJF/2QjZ0jFRcqCs2gxfvMHNPdIIw9RK2hQRUVv+
 9/iARV7uvkA1yw3J3we3Qv/tXuNiXOI6HdRlcaL94kFvM3ZN+SQbTTfDcxerMVYT0ger
 IeSCutLmAPd3V9p5LFcTYUKlcGhea3Rv8kaXL/VAyzgWeED/s2uxjeaOsWG9KGmOkBrW
 DmGccshjwVtAgd1l1MTVmP7IcnKFnal+QTI/G65QH8hmIaHXCvluNKVRJucppp6Q/fs0
 iX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738954980; x=1739559780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x5iLhqQVo5p3cfm1ZHXkEjzjBbO03jMKvKOw7vCeE+w=;
 b=UBk+HJmySSRbexUmlr6jYCgRGmKITQhrCtOVgZcgoKHRwRGGDoPOv2YOy7VHlWXrel
 5nAUvDRPZJ9ruJ52pUhuRwH9vNwgW32RT4vuS5yyXK3P7SaCVu8IWCtHqley8OESadhr
 GlLllV7imK0DtLklxJFzkz9EFG/SAV5IZnfs1nxcnLKuGlmTL4RHFtHxhO0JRHozGrPz
 Q3uORRoiE0UHMoRxEppusPIo6lvqDPaoNYEfYY6VQvHJ44ljOE3hSkde4wUuzKxUaxS+
 NWvCzEwoId89j119vwDExQmPoVZsvIqPpppf6TdPt/hy0CThktzSo+M/MmeAghLPNJSC
 XMkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtdyK4kZQLZCw88/WoVebedTuPjir+w+ad4TQFuoB8jIoFzYgUIyQinHYkHGZvDS2pOSCWRGAeyXq9@nongnu.org
X-Gm-Message-State: AOJu0Ywsei/b/tTuistIioTJHAES/hLmCPIGYoEI/jQKdM15TX/1lT22
 KovMR5FRw3iqPnfhdx9JHwj81ljj0tf5QVlXuBNZUUYmUX2jnL/nzWcG0jhLu2M=
X-Gm-Gg: ASbGncv44hBk/daHjDnVx5FcPaDm9xxqouErm+YEszLcihuZorfEi4Itw76sBI91n0o
 p8tSUOw8jO8FBO9rJY9nyzJlFf4KnanhYBsk+s1P1BA18ScUwrHnQGfYTLkz0lbO6IirbLiLuYc
 KPfwOr9ZJ8zD7XTBOr6wACJq191uCBfp/Zm2UmSrGPmLgp5kdmZcFd+oA0FS0xDyRhIA+FWyDUN
 IaiwE270MEE0SW1Y7aFSIGmXfkfvlFNygZRJp7qwgMYo7180I5WLY7atre3CsAZQvKx3Cau12mv
 2OfPVbEA2bKZj+a3s2UQf0vkV0EWDUlbXUyF1UPoHvHKVeaN3VpxMgU=
X-Google-Smtp-Source: AGHT+IF2LLaNMwiUuHQAdJOEiXolxAl+x/GhHZKndi/U9zcgMdqVqF1FKAZ6FFPxdWK01sK6FPeYuQ==
X-Received: by 2002:a17:903:1c4:b0:215:72aa:693f with SMTP id
 d9443c01a7336-21f4e6ce75emr60838215ad.9.1738954980335; 
 Fri, 07 Feb 2025 11:03:00 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c68asm34363405ad.172.2025.02.07.11.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 11:02:59 -0800 (PST)
Message-ID: <f5878231-79b8-4e29-bfb0-f9a57ac3f6a4@linaro.org>
Date: Fri, 7 Feb 2025 11:02:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] arm/cpu: Add generated files
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-16-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250207110248.1580465-16-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/7/25 03:02, Cornelia Huck wrote:
> And switch to using the generated definitions.
> 
> Generated against Linux 6.14-rc1.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   target/arm/cpu-sysreg-properties.c | 716 ++++++++++++++++++++++++++++-
>   target/arm/cpu-sysregs.h           | 116 +----
>   target/arm/cpu-sysregs.h.inc       | 164 +++++++
>   3 files changed, 860 insertions(+), 136 deletions(-)
>   create mode 100644 target/arm/cpu-sysregs.h.inc

Why are we committing generated files and not generating them at build-time?


r~

