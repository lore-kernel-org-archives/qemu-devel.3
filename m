Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29A6D1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4lC-00025n-Oh; Thu, 04 Dec 2025 03:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4lA-00025G-C9
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:32:20 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4l7-0003kL-4h
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:32:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso4788295e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764837135; x=1765441935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+0K1bpUEL7aM1a9raM9NJyQ+JQTgzHZJJQaZsOf5Y4=;
 b=iAXrFJ1n0m7bcjRWyyKhYv82b96MfYU8qXFN9G0oUWSoUNFcf4ds8NPZSpETJ9Uh+t
 3aEmBm18wM3Wl3jtcc8+Osh+5DTkB7uWc5Hg+EDJXQ/glo20M2B7ApbZOinuyXSGG3dD
 lKu9Sm8qfrKVKfsvJdPaq5CtKTofHDWFOFnuvq4ndBo5Df04MCvo6Py0SikyiTywwFQH
 IS195FpvrvP3V4gdrRRE9Ah6+J0G+GMzSFOwGp6WtzLpDeoOwQZ1JB82fMDhbF6aRl20
 mhNufHlurYZbl26uoXTcyryfe7rTjA7i9uE/BQu/K2qYHsqBOo1/xpt3zvOhsv5VHbbC
 J6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837135; x=1765441935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X+0K1bpUEL7aM1a9raM9NJyQ+JQTgzHZJJQaZsOf5Y4=;
 b=UeBwR5lJZ5n8AArza/SBE9xbcgKEucfQOxL7Zg0zkkxZqMxaXiWM2x61H562DEAdke
 U6oKMHQV7rzHPxn+GqszmQEn89jOxmEABL4ydJP5nDIaVYctkV29wyEleMsASCeCMmG9
 SNa3qgPQa8vagHl46/BBI+9EEzQoiqHm0sJoEVuXGipDOwPrkuynkg8z8xvLbtDTbQ+7
 d/E/bxACexvJ6gpXn+1559FIvOL4EPRlSDEioHB4pVTe8tAVCXLEgqrWHtCdiH/ZGcl/
 nYpzd6MQBxJ5d1ArilU9iFFVfGdDmofX8zpECbwRPNj+tA0P0G4SZrEwDteLIxkqGc2N
 mnLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhczM3iGfoGEH95hOrZTet2mHX+aorbsP0EYlaCArcgBah8D1CJVHVuW9hnHxbPayjt1sEuDuKt3E1@nongnu.org
X-Gm-Message-State: AOJu0Yyb6ltS7qys1/ZunjUzyiz/w82Dhq1k5WE3LJb1ee+rZj2GqOHc
 0Hjmpn7xFg3U7ltPi8fEEHeICecaUhg1vn6H9B2lD9IwWC1F1QWKNT7LvBmb8r0F6IQ=
X-Gm-Gg: ASbGncvEw1iGTGJ8YdsUksgSA+KYnx2vMu7SzQRV0F0rrrkapw9yJbHjJ9ZA3enyZpC
 9wySB/R137Un5ID+Ds+mJf5tGqBH3Y3gkSj47bEATcaad+t+eYxgT21ql4YEaDjaSXVW32ygza0
 IZCiTNbmIaP8+47d6SQ2hiJiiOr5RJbqVZ60HCZ1kvWnzWz1SQ1zxP6q6ggIu2j+zilP7LZdB5r
 cSBDS85m2I3AZ+xAnZbw6ZZ4vC84TLf0xaspvdKQvKg6+HN2IJHbvF8UORDeFs7KBsarhbwikSz
 2KxVShRJ+Mz4f2Tq19X5ZPpRqb/4WOZ0jgDw8XKoGKPF3Y4mXFXBQOGTTNg/KeoyiQC+BPJyFJA
 /G87MdiH32mQT7vvXvo8tx+0HCjfUTqa/IQj2LPoMphVJ3oyirmLb4h3KmoTnIT1jgnp2Gk5bBG
 89Kh5l6Dj8UfOXmO8r1PjpbhndK2bLJ7WG9FnF8urD+YrJUx/gCY5b1ojwOcyMyXyC
X-Google-Smtp-Source: AGHT+IHEYQMBnU2PzEQfeQ9hWO5VO+2E0u0kC8UIR09pCiIhrmHWtRa8Gk/+A71F66efn2msFD8sUQ==
X-Received: by 2002:a05:600c:4e89:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-4792af485a4mr53424825e9.35.1764837135529; 
 Thu, 04 Dec 2025 00:32:15 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310a6dc7sm17447995e9.3.2025.12.04.00.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 00:32:14 -0800 (PST)
Message-ID: <a3b2b1d0-08f8-49b0-953e-eb7fd18658fd@linaro.org>
Date: Thu, 4 Dec 2025 09:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw: add missing includes hidden by block/aio.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.omc
References: <20251203185133.2458207-1-pbonzini@redhat.com>
 <20251203185133.2458207-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203185133.2458207-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 3/12/25 19:51, Paolo Bonzini wrote:
> hw/qdev/core.h being included by core headers means that it was quite
> easy to forget including it, or anything that hw/qdev/core.h included.
> Add the missing inclusions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/char/serial.h        | 1 +
>   hw/virtio/iothread-vq-mapping.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


