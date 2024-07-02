Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96531C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfmQ-0004eZ-CE; Tue, 02 Jul 2024 11:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfmO-0004dw-3L
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:50:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfmM-0000Fv-DG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:50:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so2941711f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719935449; x=1720540249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jo0LDaNIzWBmbSA/05/26+f0eHFPCI3HFIYSnWb02RI=;
 b=yIl5WMh9C9ldHO4JudVUv7AuZfINi/OFNzmpfvsyq+SsB1nqIc+cibU/UzlPlz6BB0
 3wH428qqUn9z8l80YEtLu/VvanF48+asfHNs+eCjgpmSjA0rZrPmCQRT3IzLZwfwgrnZ
 Q9CWB+jJB3TJscJ6EwqUpu6UPvhtx183PQDL0/KzCr8oRcVakskbhHi9K1QVyJiQSW0q
 dRV7bYU+eeGVDhE3TAoUdo12OkmEG/b8ImnWhySY0iC1MDhma+5+wYHTAisiuGVcaCZr
 5SbX1AwZDwWJHRmbmwKnSsMnyHjJelKXyi2akBv5JLWfN+FLFG+uQuZokYttgMAvjjPE
 LGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935449; x=1720540249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jo0LDaNIzWBmbSA/05/26+f0eHFPCI3HFIYSnWb02RI=;
 b=wrTZ9SQqye6yXSlXKZZCNZ8jplEASjjCsERibE7imojw0UmjBzhchis4u4Im5GkPp+
 E/3ifPcxZyadQppoqO2EqFa+btiHjlP6ESWpjEqJndZMbyX+7Zf8rmy7y7untbPhxaJ8
 W2mKmZT3oLsi69xGZQGwmfDo4xC0+G/TQxgjEnrZk+RLCsDdM6zo6QouvBqi5LGqQsrk
 pT3+KxjemV/T8LTJAvNNrVdqJpvXljHDnhrKa+I4IAtO2pIr/mPIBNS3qE/cu1PY+Fke
 UV89DLygtHZpagshMryGo1djE0qRRxD0Gp0zcDo4XkoH6Clx05SMxdtrMRrhkhLeFh2g
 Czbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/38hrWtw6zsDQmyhcU2gYu+Dwd/ZeOnWmBPOotfQLB583IRnEj/9A1Ew8JkjDniKZVNNsnYDYckKsZ3D4jco8qKZKDHs=
X-Gm-Message-State: AOJu0YydKWutvjv/yQExsevDOYgnV03/3R8ToyRyADeWqWAeEqv4o+DS
 pfpUbR0wZgSe/jh0f+p2WF++EUhYS0xXbwF2QRmHfZQZRPlXmk17GDw2HBNxx0E=
X-Google-Smtp-Source: AGHT+IHW4rolXIqRE4jii6TI/7kPL+b36qDQ8YPy5WrLvLR5N2bYw+BnItjP/tfAr8+/4TXpiAJ/nQ==
X-Received: by 2002:a5d:404f:0:b0:366:e1a6:3386 with SMTP id
 ffacd0b85a97d-3677571c5a7mr5258083f8f.44.1719935448732; 
 Tue, 02 Jul 2024 08:50:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36789a02631sm1931921f8f.1.2024.07.02.08.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 08:50:48 -0700 (PDT)
Message-ID: <3bdd7747-316d-4b58-a9c3-2320864e6cf8@linaro.org>
Date: Tue, 2 Jul 2024 17:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/bcm2835_thermal: Fix access size handling in
 bcm2835_thermal_ops
To: Zheyu Ma <zheyuma97@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>
References: <20240702154042.3018932-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240702154042.3018932-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 2/7/24 17:40, Zheyu Ma wrote:
> The current implementation of bcm2835_thermal_ops sets
> impl.max_access_size and valid.min_access_size to 4, but leaves
> impl.min_access_size and valid.max_access_size unset, defaulting to 1.
> This causes issues when the memory system is presented with an access
> of size 2 at an offset of 3, leading to an attempt to synthesize it as
> a pair of byte accesses at offsets 3 and 4, which trips an assert.
> 
> Additionally, the lack of valid.max_access_size setting causes another
> issue: the memory system tries to synthesize a read using a 4-byte
> access at offset 3 even though the device doesn't allow unaligned
> accesses.
> 
> This patch addresses these issues by explicitly setting both
> impl.min_access_size and valid.max_access_size to 4, ensuring proper
> handling of access sizes.
> 
> Error log:
> ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
> Bail out! ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
> Aborted
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display \
> none -machine accel=qtest, -m 512M -machine raspi3b -m 1G -qtest stdio
> readw 0x3f212003
> EOF
> 

Suggested-by: Peter Maydell <peter.maydell@linaro.org>

> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v2:
> - Added .valid.min_access_size and .valid.max_access_size settings
>    to ensure proper handling of valid access sizes.
> ---
>   hw/misc/bcm2835_thermal.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
> index ee7816b8a5..0c49c088a7 100644
> --- a/hw/misc/bcm2835_thermal.c
> +++ b/hw/misc/bcm2835_thermal.c
> @@ -80,8 +80,10 @@ static void bcm2835_thermal_write(void *opaque, hwaddr addr,
>   static const MemoryRegionOps bcm2835_thermal_ops = {
>       .read = bcm2835_thermal_read,
>       .write = bcm2835_thermal_write,
> +    .impl.min_access_size = 4,

Personally I consider accepting access of

   .valid.min_access_size > .impl.min_access_size

as a bug in the memory core layer, whether being
unaligned or not.

>       .impl.max_access_size = 4,
>       .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
>       .endianness = DEVICE_NATIVE_ENDIAN,
>   };
>   


