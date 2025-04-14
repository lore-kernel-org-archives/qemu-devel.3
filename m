Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC49C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4GzO-0001Rk-Do; Mon, 14 Apr 2025 06:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4Gym-0001Lg-OA
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:24:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4Gyh-0003Pq-Kk
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:23:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso31827455e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744626220; x=1745231020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fETHJj5MntI2mY5whGoDrvH+zCO+mFiEEqfukIA95QU=;
 b=FtKSkStqh699drajb9IdVhukIc5kAbZ0BkFB2/6oSiTd1hkVJM3UmxjEkyVTiSMnM3
 7Q/RZXsJquplT896VYoSWwnIjhvh/YRK9RsI6hkjHaDl+F+BijLEZ+q8zyEMOEzGsJqI
 j9yrNOZ/EKLPqp3QGhZ0JNrCZs3hi/eUlW4kDPJY4eY6/P4+fJ2DdBUgX7CYeaEnLwsa
 GOJMhJXyMNgdKsOfCWAKUUI84wux3Ox/XxpzmeRbBTMgXv5w62jGSXFCEuxacgMhEAWY
 /0eaNJx+cKUxbW1KixBfvYeriAPsvK2i6dg0JpAwmvP+Vj/75sOierUVGi1cjedjiBSw
 T9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744626220; x=1745231020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fETHJj5MntI2mY5whGoDrvH+zCO+mFiEEqfukIA95QU=;
 b=XENNn134HO9qiGTgrwJT7YTFTQmdcG37l6mafLUw6qI0N2a0o18L/NFGTQEAmw3jo7
 ULQuD2vg2mnaHi9lTTuO/rQOEy5N8ULiDlxNVJ2bqe/VXs8VPOdHUOaiahj9IXfxKgjD
 B7c92wZGQB9GMQSv5Px/RKHrgbaR4avCO3Z0vUbzytf+r3UR9Vqkewzh1ZwxuJt8KBqY
 Lw5DVRXyvJ5tizC8fkYvnC+8n57iIC2MAUM6vJE1pJLFw+0Xy879bO3pqeooMaCvuBfk
 YFezlZd9UFkQY99v5Epu3bUUSftCWI6fGIxmR8JgviBeJTUrfJrgsJO1mZeBl2Nv1JLB
 IyjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg76bOyBbzCWnnSK9KHJ0i6YaZ92MlhvirzBVYIm8aiF03m05c+04eS5HkYPkAHpeY3iPAUbbKF96L@nongnu.org
X-Gm-Message-State: AOJu0Yw84bhpiy6ed0zxVMRHLcA1ZrvUm/Zhn2uPGogWKnBynIZMMQaD
 Kgll7HRPBmusQmQo3NbZPnCoM0UcxRxkdcPViyVmOaU8UyU+U7zyhspKoJgObtpLMt6WbQWEV5v
 1
X-Gm-Gg: ASbGncuh+jf6NcXA/xbVQM2ZCNb8SxHF4Rhb7TJWO64NCTQ3OVE9MQHDgeKwxpOK/to
 Kq2AltGJqK9BCcFoWpqMmFxHg2Zy3FsbDdPLRCZuAi5Z4Goek1kok2C19YSfKgtt8T78Z8iqVdW
 isFU1mngXHObqthBwu6jcHjLEbMF/l2fX/X9mAEUPkz24Xg5IA+83BKwVulvaA9JYbDHFPzRmVR
 cFfJ1EqBlZlByw0jFcQkRhNGZI9+MOva0FARcmgQduM1Okcl+W7wX6YaHthN4fAt2mFlohkaY5c
 xSiGQjkPZcPY1sOt8XCurSJM5tnnIF99lOaxk1Jl2Vkn00MU6RqUyTSMnoegSUuqqolxux/r+Mz
 1qy0xHvsX
X-Google-Smtp-Source: AGHT+IFFD+Vv4nqLO4xwpYr/aovQK10YKPsvxfYOue+pO1h9jOW+qkppN3Usro6iNTCi5/MGLwjoSw==
X-Received: by 2002:a05:600c:4f45:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-43f3a95a248mr88554915e9.18.1744626219649; 
 Mon, 14 Apr 2025 03:23:39 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2075fc78sm176639855e9.27.2025.04.14.03.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:23:39 -0700 (PDT)
Message-ID: <ab712311-53f3-43c8-9725-7d751222ecaf@linaro.org>
Date: Mon, 14 Apr 2025 12:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: target/mips: Fix MIPS16e translation
To: Hauke Mehrtens <hauke@hauke-m.de>, qemu-devel@nongnu.org
Cc: arikalo@gmail.com, jiaxun.yang@flygoat.com, aurelien@aurel32.net,
 qemu-stable@nongnu.org
References: <20250412194003.181411-1-hauke@hauke-m.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250412194003.181411-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/4/25 21:40, Hauke Mehrtens wrote:
> Fix a wrong conversion to gen_op_addr_addi(). The framesize should be
> added like it was done before.
> 
> This bug broke booting OpenWrt MIPS32 BE malta Linux system images
> generated by OpenWrt.
> 
> Fixes: d0b24b7f50e1 ("target/mips: Use gen_op_addr_addi() when possible")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   target/mips/tcg/mips16e_translate.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Oops...

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


