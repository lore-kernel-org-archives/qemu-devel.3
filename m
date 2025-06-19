Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9E6C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMiX-0007m3-9i; Thu, 19 Jun 2025 17:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMiW-0007ls-Ho
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:22:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMiU-0001f9-8g
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:22:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso852041b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750368156; x=1750972956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eFJdvL31TFJmVw6TQ7nQiG8sii8gnhTz653Nywr6Rq8=;
 b=WxG712Enoruy6cD/ZpKydjOzuu/AECiNM1g49f+ajD7qyZ9UWNo+OK5pDObqKWhYAK
 PSAtd1FUkIC4feQp2F7P2Q3ObIHR7fs7ZZxKI8dQaTMoGEXJwBzeOMCSBTbtuVsHqUbk
 FFZyOxEXMLIiA04lDuFsffUd4Xv7x3nh9K/shOBABQzJEqUXHXnSh5WW4TJJNvLyUEPw
 d2QKLo/FOyrZKwZw+1/GBR8rJVnZxIcun9y2yqOIkUUI/kJGtcisd8LR97mXhH8+XKuF
 0/WyJtNUS7kiQRI2ls3YMd5Rh77csdFRs+x3OLRlDFRZ6LVTnmw5Szi8hM2td0PVvNmQ
 9XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750368156; x=1750972956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eFJdvL31TFJmVw6TQ7nQiG8sii8gnhTz653Nywr6Rq8=;
 b=OBGk1dde9Tg7BEnX42jUyYe+fIbp+1ntINa6wPa3FGaJ7rLSSbQG/jZUhdr3ncz4bL
 vMMAo9A2+8rNMiZaxZ4UH4lPq5PsJGHoUb4/5b+pG+Jj9KRXYsaC5IFq4LAjps/Lk6y0
 B+AD8VuWtcd9reawAMqhRz5U77HPD61q/Uhv27BpIdpEN+3yr/Uomf2Wl0Ib1bX5Hv47
 WjRMsHdgupmOO68OP7Oza9mF2lXqcnJ/iAimudMyi/njtzrkHiJbkgXs2LyEJ4+Sy+NK
 8s9RNYfO6+XSXoqk2TUWck7FkIZpkf4JgS3GbVn18A5WHpLGX5W8jTV0sk2inKNbuWqP
 Vozw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8tTv+OBCk6v5y2c/MS4DWa269h/rXiBMHxIdVdqHl1oRzGTrFL/YPJKRvpw+5HssPp096UnwFXhzz@nongnu.org
X-Gm-Message-State: AOJu0YwRMsBepNYPoZ07ccW0ncLpRMBx9MQfcQtJdl0L/6C8mWmFT09U
 V7gJtMox/yOx2yvs2yOexWGlXLZSFLXNCrC3qDtKcvo01Y9CNLffneIEOqQaja57loU5JFC2vQT
 Worb8KUU=
X-Gm-Gg: ASbGncvA7BTnGVHVLFv0QmVYA3iTLkb866WhRffJPZ8QB7tS4MmrJe0wrzsFbiCrklC
 Q+Xc6/sPjVDEo0GQCf83Y/U5eGKmxMCRtQdH1i58Nd/pOBBQpCFlXXStGbyH+4LEK81VfNV9hpv
 lIGDzg6pBl9X1adyKXRPQU39gH2vY2o5aEboWrRW1t6mtdv8R4BSEuTS8Kt92gQde1VU/fkEFat
 H+Tifhe03wSHlYMyjrubol+MDRTAi14SqCK9VCvrJufdXQalUOp8I+mQTWQKFjUyy22zdxBC1Ku
 sss8f+KN35MjRnqJIt9pQ0RkbaNtig+Tis/H33vkBisZHSZ9nK6BicrmOVPRlK1lJkKf1460867
 rBzZ1jzfymmAg2FaJXWGsIylcT3u5
X-Google-Smtp-Source: AGHT+IFFMdh2cDuMw/1GGtFk5LZA4rUkVf/+59VAUO5nWulxWwUA2ZgOKfPswcQyy1p9xwiGwxz2nw==
X-Received: by 2002:a05:6a00:3e17:b0:748:ff39:a0ed with SMTP id
 d2e1a72fcca58-7490d6a2b0bmr428054b3a.20.1750368156529; 
 Thu, 19 Jun 2025 14:22:36 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a64cdabsm531212b3a.129.2025.06.19.14.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:22:36 -0700 (PDT)
Message-ID: <ae4131af-643b-465a-aaf9-397f19c06224@linaro.org>
Date: Thu, 19 Jun 2025 14:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] hw/arm/virt: Only require TCG || QTest to use
 TrustZone
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> We only need TCG (or QTest) to use TrustZone, whether
> KVM or HVF are used is not relevant.
> 
> Reported-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

