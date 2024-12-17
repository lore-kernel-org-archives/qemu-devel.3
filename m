Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F679E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZo1-0001HY-LZ; Tue, 17 Dec 2024 10:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZo0-0001HP-2Z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:48:16 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZnx-0000FH-KK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:48:15 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so3868061fac.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734450488; x=1735055288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f0mmYM+VbtglGVT88HwKy5Bu24H9an/svIIsHPSJEpQ=;
 b=yGt67Gz7yloIRWnC0ESWw8O6g6on6amACcUJO634E2FPawkPG/F0Idgra839UNnIjr
 Bvs3+YLkPwOfgnCwazPMA/4409fatZCtamvK34N0p2XhgqQX/FIVij+plMDo/2RMrM/P
 5W0B6K8yPf5mO9f6f7dzpZMU7CZJ1lTo8omjVpbwoI71Y69VbKMyzbN5OUIxS7579IJX
 gi2lNERFH5NJEhRSIeHi7SXyiD4CufPyvVyGvmkGqMZF+rzwk5f76bYpqNvTwvmsaV9g
 nz16ZEi8rRXALpab4f+eviarIA5OPgQcCziJEsSKMOaJChMcgqxLc4cnCnS0kpaZUSQe
 fJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734450488; x=1735055288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0mmYM+VbtglGVT88HwKy5Bu24H9an/svIIsHPSJEpQ=;
 b=Eb4vCm2gNndKTKKaNvqb3k2TBG4YKTMmWcUR/UexJ1RNsdxRn0uz2iKdLtLbbrX/LL
 EOcX0LR6kWe2XcRGYYzFgpxz4AJfWk9y5obAIoe19RODO6hGwBcrzkNRIDVT5J2xqf3W
 u7txFBisKflUMSdQ1Us92UpLsD0l/oyTgZ9sZMaXkGP4Hs05m+Tt0dA1SNbAtHuoUwtH
 uQg8/dhdfJKexhw/B8YaY+2TSHT7t6Pq2Y+h7UvyujFjZxz9NmwvXtlDxyYID+peDOTt
 Qx2Xi47dOMsBTd8xqoz0VQ577sQ3nsAqS2abQ8BowIXNAB/a0J1rHjZBtUCUzmQKK5/b
 T0sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlWL7Xr9RVyUdiBJMKHK4wJo1pEtkYpKq6wNYeghBkZZDXCdJftLNwU3rDz9LEjo/IF6XC45gV4Yfu@nongnu.org
X-Gm-Message-State: AOJu0Yyr5hq9zD4TPQ4YvG4Sutsf8Y9jLFIqXxoftF430OJP1kXVrwbo
 8DeK003AKam/47SLrlElc6rAERV+bMRc6in3R+zXAth5gtNTMZYvwdPfGoLurqw=
X-Gm-Gg: ASbGncu03C6M47JHfPfx2viwaokSGdyoJYIue7Y2To7qarNXuyxOtF8/2MEACEdD+PT
 34DRBk5/U7KOHFdhl3r5jziTglX2ybjcb9JrESKy4GVnNRICDCw27cjCLJ62cr2xO/EVcjvhQhx
 pc7HaBXnHjJ/awTXS7VS5dw59OHVvyLlBFmYw9GPdVrkiw/1XrjbBpOkVUjoAXQhOUrd3hSIqVd
 ka7B8v6Aq8t0Rw0FzBLK66k3BjDIVSpm570neI+4oaRHScoqVHob6REQ+YZQSnEFLGf2FU3+Q==
X-Google-Smtp-Source: AGHT+IGRz3A2ptnwB7Owk61+AP8XwGp3U+GE+iecH8uI4ib2xQbTKNBFAXxFrfg7epRGuva8qv6lLQ==
X-Received: by 2002:a05:6870:71c4:b0:27c:52a1:f311 with SMTP id
 586e51a60fabf-2a3ac96d7cemr8441207fac.42.1734450488663; 
 Tue, 17 Dec 2024 07:48:08 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2928e81sm2820976fac.37.2024.12.17.07.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:48:08 -0800 (PST)
Message-ID: <e9045660-8cfa-4cbd-a920-89af4d033aea@linaro.org>
Date: Tue, 17 Dec 2024 09:48:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] include: Cleanups around 'exec/cpu-common.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Paul Durrant <paul@xen.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
References: <20241217151305.29196-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217151305.29196-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 12/17/24 09:13, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>    hw/xen: Remove unnecessary 'exec/cpu-common.h' header
>    system/numa: Remove unnecessary 'exec/cpu-common.h' header
>    system/accel-ops: Remove unnecessary 'exec/cpu-common.h' header

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

