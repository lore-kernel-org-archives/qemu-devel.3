Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955D2C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNSd-0000Qq-OF; Tue, 21 Jan 2025 18:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNSb-0000Jg-67
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:15:05 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNSW-0005du-DX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:15:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2165448243fso136084765ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737501297; x=1738106097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=liWwEXX9lDKU9ZoErYY++lz9UK9hH/+L730wJDQab/k=;
 b=F9rGJ71FAR4Qxwb2Vh8nZt11+ndKdVtW1mgdbPxRFNw82VayiSnu1YWwdLNAW2gZuQ
 GNNEwJLDzUR04f3faC+PRx2L65JfJ9amKksVQX/4OivGtjTNbNurp6FwTmowNcRUZNtO
 HN/aG0pbRY/EbMEvY6DZcCZ44M+lS764z6dAa9klbCl/1m5aT1ik9fVcCvfxIr7RY/qY
 f00TgnrvHSQHQ3+h7FQtYL2fj5kq7TIZVF8Rl4RmL+B4904qbDHpQfvXBxRaisZkSHDt
 f+tXflJHavlDr90MeYYecDJvTzKS4qCzmce/7e4Vh7RXqWR/PPgmdZLUHjpLiadeA58P
 UGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737501297; x=1738106097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=liWwEXX9lDKU9ZoErYY++lz9UK9hH/+L730wJDQab/k=;
 b=B7MWDZ1foczbH7NXxXnzvfS46ni8KU3teI84xDYIQxDBaJ2iP9g7Tflu2TPKsjwAVh
 SVrQGQt/AkHZMgf6KAk6NE+a1FshFLVF4s7gyUL/RlAm5zm67smb5UMmTmFXzh6FRLgd
 f88sXkmaTWgw8HntWZElurro3zfjWZLScF1guz6pdEFyYDWEZSt4at8otzW+ytCMVlVP
 u/fBVwUYj5JP0hbuUeRgMPYarKcZOA0r0YoX8bgCgT1lWq3++JxxjmjrPfs0S+wAwphO
 PC4N2KEgW6xneETXsbaQ2z5JcTtgTmjoCzjv2ZZr4aPkDnO8wQitvKFdYuQ53ZhcqiN5
 uk/Q==
X-Gm-Message-State: AOJu0YyQF9c/NAFIdT9qdgqrfpvlo953qPr+cZF8GYUmUeXz/Zb9zqRz
 80aOmSmLJiWU/0A2097mIc1n35kRPOLZFbGTSixJOg0BQMTMYcuBelvWgacdR6bMMEU+MZXIZvW
 g
X-Gm-Gg: ASbGncuM9m48igmedUrnMN0E0IZTsnJGQ2KpBkl/i3k8/Cntg2OHs4ZrNcPDsTPyKZV
 BlTJNgQfwqRyjcYTEfVaOmNYkuwf5wckYew0Te5Xx3QpzrrGr+zuNUoQdfAkDkBspwKYhFL8sFI
 aG5T0avreHPPnCWABFZE6eXH7264KRi2ADE6PrgSwEMloPddQ6SiexHV7DGFALz5X5sJC+wNehQ
 GAINCu8yZRx9inK93C1BS8ScXXWMX86mrL0lTwKV+RxvbKN6TYqTRlkFeIPo32M9YF2sNdcwqOW
 liWcypHBgjLeXg6sDyjfMXki7a28eEpWoOxFCM4a4XTPov0=
X-Google-Smtp-Source: AGHT+IEsjI14cos6TZE3CkEcyKAFZZonkoJ904nSXmEfuMlZggoPsPVjEpHpLVmEps2qOIJGAtGNCA==
X-Received: by 2002:a17:902:ccc8:b0:216:45b9:439b with SMTP id
 d9443c01a7336-21c3563c530mr277216495ad.50.1737501297647; 
 Tue, 21 Jan 2025 15:14:57 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceba906sm83504005ad.91.2025.01.21.15.14.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:14:57 -0800 (PST)
Message-ID: <ca9d93b9-cdb9-4ac2-90a2-a8e4bba16152@linaro.org>
Date: Tue, 21 Jan 2025 15:14:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/pci-multi: Convert legacy qemu_allocate_irqs to
 qemu_init_irq
To: qemu-devel@nongnu.org
References: <20250121182828.45088-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121182828.45088-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/21/25 10:28, Philippe Mathieu-Daudé wrote:
> There are a fixed number of PCI IRQs, known beforehand.
> Allocate them within PCIMultiSerialState, and initialize
> using qemu_init_irq(), allowing to remove the legacy
> qemu_allocate_irqs() and qemu_free_irqs() calls.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20250121155526.29982-2-philmd@linaro.org>
>            "hw/irq: Introduce qemu_init_irqs() helper"
> ---
>   hw/char/serial-pci-multi.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

