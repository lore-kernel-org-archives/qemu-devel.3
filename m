Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD01CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10Ir-0006Li-NO; Tue, 23 Sep 2025 06:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Io-0006IL-8h
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:31:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Ij-0004Hx-CN
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:31:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45dd513f4ecso39683865e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758623467; x=1759228267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VBxEajzs7Wxc5qI1Nh5llJDIOdnTsd5c/L8oX7nwzr4=;
 b=BKiXuxbbEfXNXPz6+wne21FAGvZ5QDC4h3d7aTbrwUn6fV/kDBFPraisVbck93rTxK
 6XBAzr3tKWMmyXUj+mEe9KLg5FHaG+bYikz/+HEIPSqm0zwr+5XoUGRWMGB8CddzVml7
 RNjPOFHs9mv7Vg0g7mmGm4L4uOuL8mZAcQQmFeUjs8cQAB5FcYGnyH6pYYrUjVGBkOTz
 PY1i9sxWUY7vy9SVJB5eMQ03tYI+Hu2v+LICxtJ68OXnHpuDGONNLn3TTzM1WPU6Ge8T
 B9uqlWe5ddw7xYA8RbGWkXZ2wRzWYVlpIRWGbNpG096Ycr9P6V604y/CRQuLAFCSw/WE
 Hl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758623467; x=1759228267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VBxEajzs7Wxc5qI1Nh5llJDIOdnTsd5c/L8oX7nwzr4=;
 b=XTnJQjRpTUz14+gQ/xd84WkD16CPrFyeI/ehpfQswMe4MsLBxgQmlO4MO517favD/E
 XPx1vaqK/O2TW02ZBpgu1ERAnWs0eKhqqMfPO1I4j3DDCMVofQ1nMjzhpVmPpYloctED
 U8Isis6+AyInO+fQJCpAy7k1EQloIo493XMyIrkAL/NbiVh1db3oWCKxtStJCWc3g/gm
 qRTZ4WCHkNVxYf1hNygRaZSuLamiKiKlrOJbizQrT0ZxBc4cY6/475lFvPH/BUpbCTR6
 FzQcJ4IZRizPL+qwnUBdSwiqM/5+S1eiPeOe6r0tpXGNGCh9gzsuYGRvmh61syc9Bc6a
 6JFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJWh8sZ58Hq3RYX+9vHotJJVw5AlWvCg0XM3Iig0aa8VEeKduzQ62sCdJt+obS8ECHUp/FQLHXk0as@nongnu.org
X-Gm-Message-State: AOJu0Yxsy07N3zxGZXh5M1CGrwheDXTYxUDSproSVUwwve7cPBMqjvJ/
 YMEMzC55e8hP2RKqcbbg9npuK/82xE2hdh4kawwNXdM0EwdbNhVhm5USwMGpAMPnV+8=
X-Gm-Gg: ASbGncutZQrJzWpi5dtn7tEiljN1ITF1Vx+rrXEWARW67OIsU5NuBCg6AI298UhDfyd
 OSGH6UYsf1JkNWvRGeOm7RDehwtVwlsvHgRKQ+bEIOF/Q7zGHazFQg3pIrRwcwKJ64pWuznbo2f
 fs0CzD+97nBIDJua/EQBs/F9vcfKkff2OvzoViVRCOuawhCwLGvR0zybkJSgCple+WH1avUgQPR
 K/GZ3tUcdcSYbCffBM9LR+m9OBwmthmEV316s/s4Gbkq+w299s1sTo0BlFGIOvHwQoPWuJup8ZS
 FvFFDSod6rMaVqQSq/DIpmVb+vsMV/8cQTMhSjHB9Y96jF5P/HpDY0ApQWyTwk3i2n9X8jfSkkF
 ds+aPApxGEq46h1PsTZAOhoYA5+EmxJq62czesTKXbKoq3/t1lSMUwBCokYEsXN0RyA==
X-Google-Smtp-Source: AGHT+IFLcn6lWjI2aBiMfQfdSgBcoFHi1htcAN+ykOPAbMZlNc1sp3QoKI+lQNBvwQLhI4KWdY2x/g==
X-Received: by 2002:a05:600c:4f56:b0:46c:7097:6363 with SMTP id
 5b1f17b1804b1-46e1d98bf65mr20761295e9.13.1758623467277; 
 Tue, 23 Sep 2025 03:31:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613d33633bsm284377745e9.11.2025.09.23.03.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:31:06 -0700 (PDT)
Message-ID: <9cf69af4-fe5f-4998-acae-cffee41d2c91@linaro.org>
Date: Tue, 23 Sep 2025 12:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/36] target/arm: Rename all ARMCPRegInfo from opaque
 to ri
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 16/9/25 16:22, Richard Henderson wrote:
> These pointers are no opaque, they have a specific type.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h | 10 +++++-----
>   target/arm/helper.c |  6 +++---
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


