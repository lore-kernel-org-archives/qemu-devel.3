Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACE9FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9uv-0001PQ-Tv; Wed, 29 Apr 2026 14:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9uv-0001Lx-0D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:45:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9ut-0002ad-FC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:45:48 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so87769f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488345; x=1778093145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=otR7nzyBm9qB/OtUMZdNOUoLplrO3rWA+tK2u4B8a14=;
 b=farx2DF+4/7BzSaRsI0hk2RV0bGfAHJoPkyyVzxVLvxHPFVAUYdrmXZT7f0xghzgFw
 F3OUNI9wXEw3Hb443z9SDNBjVCpQFxR5tyLX2hYywrUDGXcgKvqAy/X3TQ31jzY9Vw1c
 vaYzoOiwl0WQwP84cWr/J+3CKrsQk2I/K7iEgRQt9VqgqAZB2yvSZEBVCRe7WCDFr8ru
 +D6Yx95Y6X3swiawx1FUYzt9bh6LXbLlEimkd4Fz0UJ0l4JvyoKjz30v1uWYsXdPmg41
 5AQ/BHOv+fdukSf6Hs3FEe0nIUHzNgccO+qiUIiB9RtYStlJVBLY/kLwDYqxWH7eNmnO
 kOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488345; x=1778093145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otR7nzyBm9qB/OtUMZdNOUoLplrO3rWA+tK2u4B8a14=;
 b=dUWelbzaAX0HMRrTNlJugL1MC3JH5/bmACZzFLEr9R9QnOpiov7Q8j6i4rcwb+x+fU
 sSUuQrGqIJ7xDqyH+K3aXUwr+IsMW83F/hbsBcMcI+brNzKVinY+DOPH5Su/XBdkAt6J
 7g7ZfIItzA38P1Kr3NI0OHGeeKxoq/DCO7aSJGBTaHspnja2JaTZO4yuPHsQVcPEDkvm
 wEfiDaUv1Z3r1ij4SIIMeIT/v6DXsgUk4SD46J4rcKZlwlNe+C7dz/1q+OxUvQ02nXCi
 zZmWy3v9mVA9yUB9Kl30m7L8HId8/OTTnEG6kImqlQuDY9Rfo+YH/V9Pa2jrYpeZ34Lb
 rIpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hTeXjsFm6Bn4Fwpvwi3dPFvCSji7PNNZw/ZrQewFts/CmvCgV1VzcDrsOCiMHCbeuIGtRI+T5ZA70@nongnu.org
X-Gm-Message-State: AOJu0Yy23o4krkIxHzcKeSTYVySjEA0u9bRVoSQyQ1ncqxZ6NFtqlBKE
 tA6B2OPr4nUuB93sftg8A7tI7Q5Hu40EJyBAKkAwgWwhPOmnuvdQLnPdu1xZ0nCIw1c=
X-Gm-Gg: AeBDieu8hdpStNE1c21YRH5zJ+kpR8Egjxxciq4ykQ3xS7403yd2hR1AFgyFOx6Q8On
 3rWT0StztFI2GVlulDHNs8Au8OSqRuPRRZaGMrV3DRoAlw8xd8n7MhuePFfeLx76GqjZ+kzyIey
 sXfESbXEHjvQ0kH22KPMm4wVYtM6u8vEKshys6mqiJbj9g70xfxL27LhgwLlCiY9+rpNeqsgczQ
 Z4V3XxamcQyVWf0/YuM760IQ0G3PSHYDYwawGTFfTqGm5UyrOsvrYEtkPK6jR2Bi6RAcRtwKkvb
 UtpCihXbTGqmOvUJouptx/3uNgpQcz3CV148NSSpVT/bOMZuCjQwALXcDjQAW/v81VLVQ90mSAI
 QyJMLauQ9g1/e8fkBaKowiNzFFHkZVoY+FN2J+NFA/2950GBHFwUxv8gnvKyP71Z8Ri0YeqTksT
 pXQ78YjLLI7JbnLsuxe60QS6t4xY9REsMmB78My1iZMvzms4NOXOQw8ZlVR6S3Brio39lKhTZYL
 bSE75urZsd0Pq8=
X-Received: by 2002:a05:6000:44dc:b0:448:75b0:5ae5 with SMTP id
 ffacd0b85a97d-44875b05b2bmr2550065f8f.0.1777488345117; 
 Wed, 29 Apr 2026 11:45:45 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c0csm7407810f8f.29.2026.04.29.11.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:45:44 -0700 (PDT)
Message-ID: <53bbfe05-7022-4144-961e-5966f53d1c99@linaro.org>
Date: Wed, 29 Apr 2026 20:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/84] fpu: Return struct from float128_unpack_raw
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-46-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

