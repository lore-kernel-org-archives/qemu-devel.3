Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E028CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 12:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQyp-0005lq-Pj; Mon, 10 Nov 2025 07:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vIQWn-0003gy-6h
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:57:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vIQWl-0003ry-HF
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:57:44 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so25634355e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762775861; x=1763380661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y48iyNcR8AwY1r9+GFcZ4nk0kp4L4j9xSE/5/hC/t0c=;
 b=f4IKMpLgU11Cn6bIxmHP05wTcN2UW2afVcXx+7U+NzZDch0s0msGbFRENlNKzKDZcG
 bHUGNfiW7oCnVN2WnHHAJSU/FtZF5F3Os/EIy11PQ1qO5kB6Woa4nyYo+DNhY5Udn+QF
 3kVvDIsrR+stPwOhu98OuV6cfREUpvev2RwRGqXn9fX+E0SyocqpJtx23i1A6QZsuAkw
 X5+ew0b7GupihALXiCkKBdBJb0xoJOuZ6Wsrtf/eX/w6rtdkWIZhYOVMueMl6MkB3ssh
 MCbq8Sk7iAriTD2Jn9vjugXEGOCbxF96V8Yy1BUFHp3eJqFbzN+phtSv8VaOrddbU//z
 vi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762775861; x=1763380661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y48iyNcR8AwY1r9+GFcZ4nk0kp4L4j9xSE/5/hC/t0c=;
 b=s61cWyi0WrTIqkOiA9eVgMidEf3A7E5ZakZx+vRhuWlXswx0z1rxWTVnMysYAIHMaD
 BhHXssHM0cmmesffrPblatY2aL/A6mV0slHQSa2UPaRFNja1mcKqfszsw4FYcXBgM5om
 FyvWcLjY9BKUOm1G1WbVSuQhl/BMkLqovtzyWjlI0/IvYwfPzQtJFB3A7OwYb2Pek+9i
 Fx3u+9YbD9gzX+4wQ2T9v2KpuZjwpsNAadtlUdDlxYR1nNOMLZWnB51Kc5kkiwSA8dAq
 Foa4I14koSifXkwXA1oloqPrz2NBPuZR7Ku7JZNhQl8qJtJRf3IW7CHYU6DBlGmS8s08
 Pmpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt4llccRxTKN94o2GU5ZkzHz/83HxbO7TCwV7RSrZiV1TFHsnnSmGa85ZAY9oRwZ+LFA/89QVTFDbM@nongnu.org
X-Gm-Message-State: AOJu0YwGiM3lB9ltCI68mL2UgGhpmSdygFQ2bT7jVVfzTIJn28X8yoKn
 pNi1PI+rD1xNzw3wF6H8cOu1RtWCg1yhZqc1iorsi32SmF/jGjaST2fSE4QhKrCe5ZA=
X-Gm-Gg: ASbGncsxmzDYbjjK/HMuDKa+rQU180muB9jxe7AeRF2D+drnjpAGFJb3rt/5HG151q4
 UHp9qkIDaY7S30QTrJD+nWk6tvGCKJpOH+nDbaAKRV+S+k7FA8MjRnRAXHDOAwfAoSkM+JSILUY
 Db/46jCB0CEeQNLuMo2uzmfGrOLjH/44f0lszetUjdgVpCcTWdf8jqKBzEKkTymakoZ14pT54nK
 TonGqpVLZZdTkY08yzJ/tQQUbfZVTqibrq8+TZk/yKMFWNuLQLcxmYk84vxL/1ge285y9okpzP+
 qh5noax6NpIG6pyw0+tNbWx1OnbyqDfYfEo1gsS3ee+BhqlHlo6CY/by/1bzXI0SXSm9FgnY66Y
 5SpDyeGsStErEYjZLviq4AzfZBPvP9tG+PCcIkpBBegtrfiYfGLaLfoEBz2YL7v4/l0H/yOt2Hw
 27kLPKe3NQfIYrftVFcWPFFLzT6nokwBoIxX2PnAbo3r8k8uPHiGeHefDtNaQe4LiFRA==
X-Google-Smtp-Source: AGHT+IHEJsJxX4aSmUtSaQy4jQRVLHcEJ+qpTxMrpVYH0Ttf79ETmEOd1AeqIyN8Yqy3WLEjNk+QhQ==
X-Received: by 2002:a05:600c:1381:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-4777325ab51mr71770685e9.18.1762775861213; 
 Mon, 10 Nov 2025 03:57:41 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775ce211d8sm330916365e9.11.2025.11.10.03.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 03:57:40 -0800 (PST)
Message-ID: <bb8eedd0-b061-416f-be49-33a760c6e1f7@linaro.org>
Date: Mon, 10 Nov 2025 12:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/sd: Fix broken ssi-sd implementation since v9.1.0
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>, QEMU <qemu-devel@nongnu.org>
Cc: Tom Rini <trini@konsulko.com>
References: <20251110110507.1641042-1-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110110507.1641042-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Bin, Tom,

On 10/11/25 12:05, Bin Meng wrote:
> 
> The U-Boot community reported a CI failure [1] where the
> `sifive_unleashed` target failed to boot from an SD card after
> upgrading from QEMU v8.2.0 to v9.2.3.
> 
> At that time, the issue was traced to commit da954d0e
> ("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)")
> which was introduced in v9.1.0.
> 
> Testing with the latest QEMU mainline shows that the problem still
> persists, although the underlying cause has changed due to refactoring
> since then.
> 
> This series fixes the broken `ssi-sd` model. After applying these
> patches, U-Boot successfully boots again on the `sifive_unleashed`
> target using QEMU’s `sifive_u` machine.

Thanks for fixing this issue!

Do you mind adding this test as a functional one, so we get this
code path covered?

> 
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2945
> 
> 
> Bin Meng (2):
>    hw/sd: Fix incorrect idle state reporting in R1 response for SPI mode
>    hw/sd: Fix ACMD41 state machine in SPI mode
> 
>   hw/sd/sd.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 



