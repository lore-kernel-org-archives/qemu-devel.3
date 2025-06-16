Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C4AC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2eP-000187-V1; Mon, 16 Jun 2025 01:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR2eO-00017l-Rr
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:44:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR2eM-0007dm-MM
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:44:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso2818029f8f.3
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750052692; x=1750657492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xc2cLD2ntBOLWn9J2QDVOrWC0n7u+YczZeWOQbn7lZg=;
 b=IR0Dk24xpQp9nyMw8WVWaiCH3ilFul40ZcS7NoLK/vqfCsr/Qg1RV1K5mrnTFE6scg
 hhNBtp7xTYrMaFNIcXud4cGgPC4g3s43lLdvhlO3LJDAzJTIxMIWDVB9+nJqX/20Hn3s
 pc0OqKFRS9Ehc7zLQ0NEr1u+3kWWdKY2xXfAzOMsTbPlFxBflJodJkH+oxNwiXxIHMhj
 drMLlt2ZUHYWHy6Y6qK4zyzcmuVh3+2PBxX5WwG14+ihM4Pb5wtl6RyvIK48QoBx5NFu
 58iM7CErbOld6n8t6bH/jGXrvMd9F7kQcQBOu8wspWUskujjCaxSgwoyuwArH3M0lWcU
 jbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750052692; x=1750657492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xc2cLD2ntBOLWn9J2QDVOrWC0n7u+YczZeWOQbn7lZg=;
 b=fOZIDHohzzXnC8uLdWZXwdN7m7FK7W4ilOhWtf9QfSWAKzIC6xvB65af3IBlDerMMN
 M27lTA07mRHMgwSVYnaeVfjoMZgg0mtUPk09dG8O7oyTkxdinbibHdQFMZLm00Ki/vWb
 G826EKdIF2OTR3Xy0hbCp8ufI2lBrOPDE8Ou055ryrRmSJK8Yux82SvSDbCX4FOxXYN9
 SL+T7QMx+r7Hcu9oKdVf+N+m+magTwTKgK07jVdH6aqItONNB0taQ5cXLPPtI4q7VI67
 WdRnSRNE9N+aWRIOaiUWJ3z3GFinGv9ZtN59e0DLIak9/MwHIwlNUOrf4oIPzm9o5WSY
 6Tdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoB/VdF2NXcbeCgmUKKehnq08CMfzuQiBbhrAMVbYwvOsFWKgok1eYHu45KlAhULQ3ZLhFJy7/7Jrz@nongnu.org
X-Gm-Message-State: AOJu0YyhCr5P69qidCtrv1AJHpgdz/E1Gmj2S34P0DxdBPnNLBAkSdIe
 Cp+oekN8D6sNcijZXUaAOdQZ7T7FrvXrFOjnrD9AciqGTeZZn8Z+gYG1da6cwWBhyVk=
X-Gm-Gg: ASbGncuXWDT9jRj3clt6iy9Km6Xjmp8rAakw8Ra/tU+oVJFLedvkSAvI/EAgGzTAe8H
 zumm67+J4LjgtRY3PRu3K/wIEUg+rh2/5AspbYkTurESa8CTyHrmRu2AXPJvc++xNGHtzk7za6L
 qBH4qf/lQLx4ueoQt26nLZaWI/PlI+PBxk/sGfv6+Otl6XGKiilJ8pQyDGRJ9Pgf5cC5m+ri5bM
 UPu3nCtX8oeFbGfDcyEbcdRHec7VDXdA/mFXD9RGUR2zdWiFjpr2I5ZVYwCE9qHdazO373ti5Ct
 ISF6Ei0cRAN9FRqMWSqXK2kz5W9X7CV0nJ1yRZHzCjrYNKkgTXPNaCxAcNlWnWk672PYh5GwyQT
 Ocu2gWxKKTUoArcS2S+gw2sUy0FYI8Q==
X-Google-Smtp-Source: AGHT+IFYTpQH3yHz13TnpWn5YVUswxWXBHCLhK0owLYk0MQtj4zBSSIM5+oTeIjNo8PH2QPxzYFCQA==
X-Received: by 2002:a05:6000:708:b0:3a5:5278:e635 with SMTP id
 ffacd0b85a97d-3a572367577mr5888410f8f.3.1750052692022; 
 Sun, 15 Jun 2025 22:44:52 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e256630sm136115695e9.29.2025.06.15.22.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 22:44:51 -0700 (PDT)
Message-ID: <23605427-8930-41a8-bd92-6a3a76a950cf@linaro.org>
Date: Mon, 16 Jun 2025 07:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/arm: make cpu targeted by arm_load_kernel the
 primary CPU.
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me
References: <20250613134208.1509436-1-chigot@adacore.com>
 <20250613134208.1509436-2-chigot@adacore.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250613134208.1509436-2-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 13/6/25 15:42, Clément Chigot wrote:
> Currently, arm booting processus assumes that the first_cpu is the CPU
> that will boot: `arm_load_kernel` is powering off all but the `first_cpu`;
> `do_cpu_reset` is setting the loader address only for this `first_cpu`.
> 
> For most of the boards, this isn't an issue as the kernel is loaded and
> booted on the first CPU anyway. However, for zynqmp, the option
> "boot-cpu" allows to choose any CPUs.
> 
> Create a new arm_boot_info entry `primary_cpu` recording which CPU will
> be boot first. This one is set when `arm_boot_kernel` is called.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/boot.c         | 15 +++++++--------
>   include/hw/arm/boot.h |  3 +++
>   2 files changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


