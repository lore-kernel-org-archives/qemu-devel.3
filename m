Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799CDC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYUI-0007Iv-Ir; Wed, 06 Aug 2025 03:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYU9-0007E3-6R
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:22:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYU6-0003M2-ER
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:22:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-459ddf8acf1so18954285e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754464968; x=1755069768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bae4Rj8LksmUKRExgA49m4XV5dPKfuJ3tBM7IB+NI0M=;
 b=EGQIAuOb4nhmokvTfVg6GWwZ3ADiBfgKU/YuNSrmZzdztZXXnm2/sRG6M9aopQTfN5
 r+cwJCp2tXJ70ffwbZ2icZmcaIfoU/9H6O5fLSFd/4mSNIuXAlDFRFtsQe92uGtlVMo8
 vMyd4XKYdJem4TyraY1gkcSeWruZUANMtSvDj3C55CD3a8JD7AEDQF0Rh+2G1WIaTXYL
 25hZNX3TfrxEXsEC9KYPps0PG87F6tNR9856A2TxjWAVkxOLomPE3p+F5sj02bZMvuDF
 xm0muQh87+wVQ4G2Q1FSv5dwzwsxuxTsp9HKff6jtZqSA2LrdRNTzgCrsKRe9B6azvqg
 nwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754464968; x=1755069768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bae4Rj8LksmUKRExgA49m4XV5dPKfuJ3tBM7IB+NI0M=;
 b=ccz+qFDwZ/L1qERbLpbnIQ3oy2p/pz2xT1NE7K+q/aEDkEh1hrE6DZi1Zn8X7ilxf9
 2N9hODrvwmqsvJFDoasO6ZhiJaiVfePfLiATBQ9JOA+4arDRw872HoDM6L1/EPI+w6az
 OozPgeOIz/RdVwQ4IKVhpl4/D4QVS8OIXBKsutJUmlgxY8fX3BNV2/vP2aWa3mN7sVk4
 oKcLdxDfB9EkzoblrKDAnoC+Z9YsiZ707XIE5IJYJDzHgfukWjq7f23lf1Fvqx4PRw+4
 oOtugXFOVpk+ANoivaq3Ae1bM26HOlPZlcf9UjuWvzAFqsZFYC0gwLFlYvdd6svwItTp
 kAfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ODAgcFlgc77jkAItoT5+4YYYjH/YBPZgQVOnr3AtdGyExi6v/F8oeL7J+q9oy31f9diQIZ+C4EO+@nongnu.org
X-Gm-Message-State: AOJu0YzKC80/8lAXze4VZGIAZAxOEcAOlSktFvUvuSrrXLIklVlrv0x7
 dOtK0DrRdiQBCOCQ0yTlYK1LaqQL4GhEOambKCJVoQ60BvESvJiiWpQjWiqZmBagrxw=
X-Gm-Gg: ASbGncv4+iXzOdyxmhAG/BnefzcZORqBF+CqklLEjMS+dVGjKFW36jlcQPTNW+RJX6g
 hQUKkYaDN+RZUw9kKB/fH90POjz4r/XR+qLTwuN132reAgC+heMZFyKx7xam2teWdRfjBjVTflb
 6hljpKjPfHCxiVVZ3DrA3mpLnGbWe2p2HjLpaU4qnmVaQiYz7mMBwJ6n548fmNqlhhSnRaepw3t
 6FYMFgYKMAveipLYxMiBzJoasyK0Xtqa5fHMAwvg5Aiy+0PACdQhUNV5yTOxvoMf7sLpRnssqKp
 DqyQxDQtCkR0mn+OFNtIzhBL4dnBKqZMTWuEeLXp0rWes/OYZIMR3FRUl+7L91Ph/3970apuE0Z
 XXhD/RZMYJHGkw/U7695KO/JsZpXZwg5OPb7vBl78ie9oH8DO43/WJmqi2iPdBOG/kQ==
X-Google-Smtp-Source: AGHT+IEq7Fi+v8VMGb3iE03uYVSnoegLa4ss7xD7txAF33FygpV+xi18teaRJhVGAgls37e5/InL+A==
X-Received: by 2002:a05:600c:a342:b0:459:e3a1:a0c4 with SMTP id
 5b1f17b1804b1-459e70f63cfmr14736275e9.30.1754464967572; 
 Wed, 06 Aug 2025 00:22:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453333sm22751525f8f.45.2025.08.06.00.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 00:22:47 -0700 (PDT)
Message-ID: <9dc90489-9e74-4e00-8fc6-f97e3f425495@linaro.org>
Date: Wed, 6 Aug 2025 09:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 00/11] hw/sd: Fix SD cards in SPI mode
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>
References: <20250804133406.17456-1-philmd@linaro.org>
 <39982478-b3fb-46b0-bef0-c0839c123300@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <39982478-b3fb-46b0-bef0-c0839c123300@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 6/8/25 08:39, Michael Tokarev wrote:

> Philippe, do you think this series is something which should
> go to stable-10.0 (LTS) branch?  I'm not sure for the impact if
> it is not applied, though, - what do we miss in this case?

Only 2 machines use a SD card wired over SPI lines:

$ git grep '"ssi-sd"'
hw/arm/stellaris.c:1302:            sddev = ssi_create_peripheral(bus, 
"ssi-sd");
hw/riscv/sifive_u.c:671:    sd_dev = 
ssi_create_peripheral(s->soc.spi2.spi, "ssi-sd");
hw/sd/ssi-sd.c:70:#define TYPE_SSI_SD "ssi-sd"

I don't know them enough to tell if they are that important. This
isn't a security problem. The emulation of the transport (SPI) to the
SD card being broken, guests can not access the emulated card.

