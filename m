Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67088CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usy6A-0002IG-EX; Mon, 01 Sep 2025 02:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usy69-0002I4-BI
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:33:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usy63-00073y-Ll
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:33:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3d3ff4a4d6fso856984f8f.0
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756708370; x=1757313170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=++q8exrnDuI2ZCBaHfT4p401p5bBpm/U2L+BlyrLFEw=;
 b=YuUIh2dWAzLfHDWRam0T7sz0fvntgbJVa005hiqeViLV0ihR7opQPBpshZblluVU35
 5EzWlgcb2Jg2Po6YUnm+sAvqjWkU/tsWQS/U7ebxPhEFpzSk62g/4nadA4n/Jks5mmrV
 MoX+Z5gezsDsg3Y8kyw6AQCdXPXx7juQWMaihXkC9kvp/zjg/6j1NN9CcjVDWVpCG/gX
 ve2Jk9W3WVhGqLZ8+NWETv2J87Dw6YrqLkuzMFUb3/+gDYJgc74GwYqqZ8bTvp3alvBE
 BcmLSpoKejMb2YMfWRZ6jaM+LFk+YZ0qRjkQlqhl6Qsh93nI8e1Tdp98GKSRoOl0HMjY
 Zp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756708370; x=1757313170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=++q8exrnDuI2ZCBaHfT4p401p5bBpm/U2L+BlyrLFEw=;
 b=w2NZF5rb3L1Yl8WvkIZBiL2g+AkD2BueL7pzwWL28M2SanuP41tj7EB4vpziQ/tyY9
 PvYQhDJw/f6GYj9dA8Jm5dVD3sDtjuQC3tx10s/osNntbv3lLJOJZz12E2DOGCIWXnlI
 VMBbY6h52A4LC1JrcCEqrJh8pzR5eF1d6LLrgbEwVbFEHlfLqoZ01/qs0h2IBKpiNOhL
 GUGsc8jQxLWKWxHS1yc7ymOOLF15KGCJ844LzaU5ORjG2o0vL/gcWs1wFooXdz/CR32J
 8has53fFUzIoU8Xa3pGgVrsz/xO0S2GErkWlisJrD4E3l3lXL3/LHmYwS4E3vBqFli0c
 cSkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCXy6GqWcQA7k5WqidfYdQxm6hjDL2ZETiV8BUam0sMVdrRyE7OGBcsnF4RKiKzRnryChQvhYjSYTk@nongnu.org
X-Gm-Message-State: AOJu0Yzz7lHq+PjTo2+ZGCcTQGKU3SA19zCJb3enVX/hRZ6gZG3l+Y1Q
 Bct+FhhdhuF5VDVyIOirXpuuT0vV02FLtw2ayKbpn8vhUmWDcuaGAqaLrcRy+RAHbUs=
X-Gm-Gg: ASbGnctHKxY3NE/T9hcD836rpCEY+XSkHJbKDSjeMWsvbY+yK6vrS4WSP6VHUM7462I
 BEyWWXAxcgHbVOZcvpiwIa7GfvNsMivyJCjPtBOAbFdxmoV8f3xhAP1iKDdRj+7l5NmxbCkGVhD
 vx26BhGopJB0MrdAhpqV39AwP2E5bcIsV66r5qjGKlZBUWrEL8GmmdBwR83M0mbV+8W9YPvxQRM
 0vRTTyaN6tAEXL1opgJEmCCMCyt74T8Or0UVUOen8uKGuXx79cTfB3m3it9JYH5Swo1QAGLeWpD
 3b2EIo7f77uk8a8fEQRGWrPiZt4QGrDZeJr8uzPhYo5GdNDSbbo/QcHQVJ3pPp5n/t+8TVyKTsb
 whfo8JwihZYW0WqonUUcGQHZZcxfCyIYr3UkeOiqc5UvlQMkjBkqQVVLJ+GZ7t4kfBKMpJ1XR64
 MR
X-Google-Smtp-Source: AGHT+IGwjsN+CMstXWrxgCYazWqGSSFKzAmEBM8Sg8a22Au1KekzKgFc9OUM6JYsP834E2gyFdZaeQ==
X-Received: by 2002:a05:6000:2384:b0:3ce:d43c:673f with SMTP id
 ffacd0b85a97d-3d1dc5a2399mr4553650f8f.4.1756708370426; 
 Sun, 31 Aug 2025 23:32:50 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0a7691340sm12893620f8f.39.2025.08.31.23.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:32:49 -0700 (PDT)
Message-ID: <d1dac0c3-4f04-4886-a1b9-aaf65d4bb553@linaro.org>
Date: Mon, 1 Sep 2025 08:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/arm: Fix tgen_deposit
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20250829135203.284630-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829135203.284630-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 29/8/25 15:52, Richard Henderson wrote:
> When converting from tcg_out_deposit, the arguments were not
> shuffled properly.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: cf4905c03135f1181e8 ("tcg: Convert deposit to TCGOutOpDeposit")
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target.c.inc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


