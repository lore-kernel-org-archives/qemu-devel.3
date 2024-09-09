Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173CEECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snh6s-000109-N5; Mon, 09 Sep 2024 12:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snh6q-0000zA-TB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:19:24 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snh6p-0007Du-8j
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:19:24 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d88c5d76eeso2894212a91.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898761; x=1726503561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mq9dk/yeTvxJDa2OYzYUC7zIRF3fM25tuukQKjyBDdw=;
 b=p1X3pf97yhZYvYL8jZRzA/mFgeDqrQutKQxLRgf+lmysbMQLRrPfNHwWfvGSsuIsfZ
 k496URf8M0o9ct5oJvf0ur21RrpmiQLfStyF1HXDLb5CA/f0adD1KU/BpEECUPGV6PY8
 aJJTDez7C3Y9Ngv0pvlERz8iZKltuZwtZocfWoA71rAs94rZnIQA+7roBvrgLgE0/FGD
 /uH2OLUAqO8sT63fuoS9TzaApVq1oux5ynEv0+BLNxA6mdbnD5di3KpR9oqPTzmqHPKa
 SoqUz/q4tG81NLjJ78N7WyyklEyUVIwcToqNQBLVtJn/Q9K5rM05AUGQ4Ib36OJ9aNMA
 0O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898761; x=1726503561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mq9dk/yeTvxJDa2OYzYUC7zIRF3fM25tuukQKjyBDdw=;
 b=v1mVb6AXP30g6/Lbl14RVXYgSLoTuhW5w+CzUuysxB1tka4MJOu8bvgVI3wm/24i9w
 SwaLZ0rVS8NR8Q3aUVfYYO+tqllSsYanj0UfCcX/vDBy2KF2ALHiCvHkD3r8f01bq52m
 yQmE9OJFruVsI83Ajrzhwo+uAgFiu4TilKkLnd43hLE9CkxEAjLHQWvhpK3SjQ/j8urz
 vs2jJw0r9txjFncD6Xhsc92bkIqcXjiaf65pvg1lLPHwPYpuRJC/CN5SjtKprBYXY5DB
 Zl4kJ5AR+7Xeudm6OoXq63Ch2iIMHoGKj+Fa5EF8XJOxOpoCQKPDluJAxNJWKMHN+Wir
 lLEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRluWZ7fNZl/M9brMTOZ+cHcSgKa3dTTFYLTsOrLyRK4lj7oYMknYRbaUWiYIA5XuzEpOnew+XfucZ@nongnu.org
X-Gm-Message-State: AOJu0Yyz75aRCihehyQ7GKoRw07Y8cVrVX0YpwljsZ74dOFKwEYgwjei
 d5qnnCziK8W1R1qGlsN++KKwU3l/NC0Q80C782jP7Ya6mEVs+ekYoChWg4T7hkzl1s+cenn4mhM
 6
X-Google-Smtp-Source: AGHT+IFEHMPATTs6OVQ14OiUhafesJSL+oso+8Byw3rO5puUuiWBRuebfO4+qYnbumPxnnk92yiFCw==
X-Received: by 2002:a17:90a:12ce:b0:2d3:c6dd:4383 with SMTP id
 98e67ed59e1d1-2dad5019a89mr9988131a91.16.1725898761206; 
 Mon, 09 Sep 2024 09:19:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc00bfc0sm6880840a91.15.2024.09.09.09.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 09:19:20 -0700 (PDT)
Message-ID: <95b74368-8e3b-43a2-8185-e95ae89c9f6c@linaro.org>
Date: Mon, 9 Sep 2024 09:19:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trvivial] linux-user/syscall.c: replace function pointers
 for flock64 fcntl with macros
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240908071600.430410-1-mjt@tls.msk.ru>
 <08b5c803-cfcc-49bd-910b-61934fa2d1e6@linaro.org>
 <096e96cc-d126-4f71-a05f-eaef1f8f4a4f@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <096e96cc-d126-4f71-a05f-eaef1f8f4a4f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 9/8/24 22:26, Michael Tokarev wrote:
>> Why do you think this is an improvement?
> 
> It just feels more natural, so to say.
> 
>> What was wrong with the function pointers?
> 
> Not exactly wrong.  It just hurts my eyes when I see an address
> is taken of a function marked `inline`

I'm certainly happy to fix that!

> (though I understand well
> this keyword is just a hint and the compiler is free to omit
> inlining).  Also the typedefs are a bit ugly.

I think the macro is uglier than the typedef.


r~

