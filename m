Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A6AC0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 17:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thBZs-0007yy-8T; Sun, 09 Feb 2025 12:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thBZc-0007vP-Fv
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 12:58:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thBZW-0001vP-IK
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 12:58:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so23805965e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739123897; x=1739728697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22Z6m8XyV/NBDHZ1/r5xAtFPJNDgixnqd002YFBDV6U=;
 b=GEZt5XDHZtxDX1zlrGXvht6bq4ecVApuDb32w7GhUzCCKmtmH45sJ2/fsEGO+uRMo1
 OBAm5k/C+Blq0S/Mal7//z8HxUU+fZKH2ztnfINLmMQk0GujUnRW9eGeESPbWcmruNil
 kQX5Ae7quzvz2VrR4AfyKi5c2JaNA6Lxqu/rkfkYSzardh/uhySWxD59mnzdgvh96jRC
 qPWXHPrr7MHw9svSede/4xe9jCjCrmTzXeC4448HzXAZncB7PwMND7E+RqRILGfuU3oa
 NxaxUEJ6pNthKrmJ8YFIsn9KBxfc+bsBbxCpjmSWdQOxO0vbZs+4mA+L7I9ZrDuJ6tFa
 Ancw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739123897; x=1739728697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=22Z6m8XyV/NBDHZ1/r5xAtFPJNDgixnqd002YFBDV6U=;
 b=c+QpKLo+NuJKxGNknTwly1TrqO5rVifkT2lGecCB/42OCKZquaTTmg5aQHWMsmY1ow
 EJQ5IF6nu5xMjs18wp2ZvjepkqcOTqrSL10IUeUwDCwk4Wn8qgK7mzh+uFMPduwiApWn
 9k6RUFetfStdIbRMzC/IU5ati5WRrmwFqXVtZ+GJWaLFZIw0olIK687ET+/w4oLr3Bbx
 HHwUUkqdJu5Qu7VypTHXYuLVRliAqmHHDr7IaGvXOeNHbkcQLwGbqKBfIXTqf7RM5Hha
 6/RaHZCOa5uE9VO0YFF5wepfbiWnH2/NlHja5BvR1HI44OKG6dUBYBLi4QLoTDkbJj1y
 FIXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvoja6Zxj8bu3lVfzwvOq9FuCihuFsc0AH+wTMIwhIY5TpRBFGM49wSXeMmUiQraS4l6G85O6+YuR0@nongnu.org
X-Gm-Message-State: AOJu0YxNGImg010bpxgsWmhPWfHjKyv2lNv4uNP8Nk/Vqg6whoj97xCD
 i2yeFuX9fmSlV7smFy0Yzvn7ryYwTVwXoEM9hsAJfBTwZvGJIm2+oKd8fUhq0gw=
X-Gm-Gg: ASbGncuEquA2E/uGccOktaB1dYV/LH2KFTH0ahlGrgOi5mhouSIxW7z3gMJGhuQX79h
 tIKqZz+8ytNdWg3wdYC0ij+8C38XmSAfxcHz34hGIX7b6NJlOaHFTiOeqhRRG74UxIo6cesPfZx
 tSyQ0yD+P0CZxLlSrrPUuAQFS7i9mcOlE24M4l1KMtXe3HvAVnSClopz71znLEik1vdcL8d2Caz
 ZQSRRaCIbNuylazRE+8B/R8L8PpvF+N6Y8eiZeAtq+Z9/U0vtWY8xQEFjFxmRq3zf6mXJyPV2TB
 4Wpchsd3hlVSHWhyaA8vvsXT02LCY+11CkX3qw1jzlfe4ww5eOO5os1uEvY=
X-Google-Smtp-Source: AGHT+IGooW+rsJzZoQooonMjNu7IJdhO6s22uid7p37oa4D3gCpGcyNNve4ogX2h+yklZKpNEX2Izw==
X-Received: by 2002:a05:600c:6c52:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-43924a27b10mr94463635e9.5.1739123897228; 
 Sun, 09 Feb 2025 09:58:17 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439447ee508sm6476665e9.6.2025.02.09.09.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 09:58:15 -0800 (PST)
Message-ID: <41393c93-1ed4-4b0a-be0c-9560d462e4ce@linaro.org>
Date: Sun, 9 Feb 2025 18:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/loongarch/virt: Code cleanup
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250208070655.3039366-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250208070655.3039366-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 8/2/25 08:06, Bibo Mao wrote:
> This is code cleanup with loongArch virt machine type. One separate file
> is added for fdt table building, also rename file acpi-build with
> virt-acpi-build.
> 
> It is only cod movement and function rename. There is no any function
> change.
> 
> Bibo Mao (3):
>    hw/loongarch/virt: Rename filename acpi-build with virt-acpi-build
>    hw/loongarch/virt: Rename function prefix name
>    hw/loongarch/virt: Add separate file for fdt building

Series:Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


