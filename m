Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601E8FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJVj-0007vS-4G; Thu, 30 Apr 2026 01:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJVZ-0007uv-7D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:00:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJVW-0004LI-FX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:00:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so2091545e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777525213; x=1778130013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rYg8Rb789PIhsepo2/JfoP35d7MRc0SkGtjpFWMEIcA=;
 b=CdAU7GKf1qL+Zl50jcOJJEi29foy95uoAyFAxh7IPEa8A8JgfiA6UqwEej9Q2bT3JM
 BV8BTVzlj9i/+g0kG47cmbtGqagVCwjCMzJITFpUz+Fo5qlmr1qwyfguLdLCgaHzxFI0
 jkHNu4fJLfo+ODskxLu619lvLiY8HnLaSjw5KiZiOnnT7MteKU5nbKUl7WqWWV2UXjw4
 nOtmC50Ik/dlLjnckGb9qa8X9BcFY+8aRDqMUfyYU30G6wzsBltqneTVwwIGdyN0hxLR
 qwhb8gzRIDwj8jS+Xy/lhzAzcXrxEhe04/Sew78Mhj3Fz4IBY7n1o3vZdYjhlb//2Gtz
 zqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525213; x=1778130013;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rYg8Rb789PIhsepo2/JfoP35d7MRc0SkGtjpFWMEIcA=;
 b=S4GMJ3FXvi6HvvR31uqQ98uLZIYQxH3LRuXuBjxoFQ1G9nPC12i4qfMaTtVrFkqcHV
 11jMeMBMBeKkQeM2SXqqYk0QI5zT5LJ6Prkyz1C7azZzy0Q80VaQB3gxAMdpGcbUp2Ra
 YKtpexAG20oIINTEO1DGInzy8IfALK5S2Hc9SA9VaQjNalENh/lR8phS5405YzgJPYdp
 QUeWN9qzGnaQy29i2d24mq0/TyHdJj5/GXsdiPermydiL0McsMZd6FKGKLXRRA2xX//T
 fzTcm4E3SSo/Jqrkd3q8nC7x1dcpSdtCPp+EbrnUUufzvcHsmpyPrcmRYu7YL+Olt4kv
 V9LA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YkOT6ztZhS30/fbvHqN6mGLAw917d55jIQ1dcretH3asSvJZNwcVD1lXs6eVtgDj905MwAWg1eW6m@nongnu.org
X-Gm-Message-State: AOJu0YxfAnwYpuiB1uXLyNFRiriuY/9zHUxVeArBQqlvmKw2HUljW6fX
 F5flzlPdgI4Xrn0AHraS3m888QLCkJpIqfZAiu54/fJGtiktqN2GdOiq9CaL9PqdQwo=
X-Gm-Gg: AeBDieuE+P7Cw8I7zBCPDTAiLGmHU4G0l9JH9BBNAeI0Z5Dx+akNp4V4xZF/r8q2/RO
 3k3NWd0+j0XgMVR8vy2APgUtRsObVKvticMI7cNJRQ8uo8gMn3lMi3uNIqJwg8CK/jCRkWzGZiw
 PJJh9/XOzlLKFlVYprbqZE5lO4Oorlq8J5/5QT54RJlFWoiuWqJk+mSQT8N2ePsyGvoQ31uOS6P
 6N/zvfNJa5omndPfJbNyojZvWYUMRN4CnyiXTj/PjA6Pyl261DuvZRL4rC+TGfI4TN0AllNX5cb
 sF9pI0CMuedPD0DLkAMi8ZX/hIDLWs+lFoeMuS80gnX3rHcp6JTCnN83CH+MQw/zCfKVJPG8Hzr
 0nV0mloSo05aUPa5+65JeEiO9TLD+DskZ7vYvx+J2E7eXHR2VfraLzCSCC42grlpfO7Liz1LGSi
 Duf/noRiIHPo1rZzpa+nNliqDKIMq+61+CbwqK5hVg6BCyLAcNMY11i+vQ7ofZI2PErJphymYZ6
 QQr
X-Received: by 2002:a05:600c:6285:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-48a8448564cmr23452715e9.29.1777525212271; 
 Wed, 29 Apr 2026 22:00:12 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm9158999f8f.5.2026.04.29.22.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:00:11 -0700 (PDT)
Message-ID: <21fd8dc4-d97c-447f-839c-c3c5945ec6ed@linaro.org>
Date: Thu, 30 Apr 2026 07:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/40] fpu: Export default_nan, pick_nan, return_nan
 routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-21-richard.henderson@linaro.org>
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

On 30/4/26 02:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h  | 15 +++++++++++++++
>   fpu/softfloat-parts.c.inc      |  6 +++---
>   fpu/softfloat-specialize.c.inc |  4 ++--
>   3 files changed, 20 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

