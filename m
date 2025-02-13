Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F9AC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiY7s-0000NC-2g; Thu, 13 Feb 2025 07:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiY7j-0000GB-IX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:15:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiY7d-0001bW-7x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:15:15 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4395f66a639so5147885e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739448911; x=1740053711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vzaZlFcD7N8Wjjl/eyiqiLniNbSdtEp+pnDniDyde9g=;
 b=Pg3FHKISHaAtXrGWtFVY08TIL9aysYhOYseQmcTFL8CK2Eno5IVrGE5PCwC/2AhwWo
 5BOHM7y+9q1djsgMw9Up3FQARK7f+666Qvs7AKlyIGbbLbnBY2fvvMcIVPWKeAJKN8HZ
 Val2BwDAiFFmx9a7ntb6nizQYrG+TEFo6VfTnekbXJ3d+viBk6L8z525voyeWozQE7OA
 kIaVZHhSzJgTquFRCMFpV7MKIT6/OF/lpgiOYhe1gaMlMbq1uEj4olGPOdijo78k1x+b
 Xdss8pQb3GuvdA+I3hWniuPOXKufIemugpilf+Rcl2zJispv9gqiD+33+S4zXlo9g4bB
 TSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739448911; x=1740053711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vzaZlFcD7N8Wjjl/eyiqiLniNbSdtEp+pnDniDyde9g=;
 b=CtCXUYDmOnNCY/2vI8S+WKQhBCbuuyKyrK+Ac7f7+IJmBJjROZnHQeHzIdOwFFI38z
 HkfcR475+IjwC9g1UfeFjQXXtiVaiU+Koz4Bb37sUda2W5Jst3L4aS2/A7q0iPoHHrAa
 WgDBmPFafqyKD2kmNhzOB4ohVWsTOF3Ed9Nn8E/4nw+OJSN/To11tiHcEYbg6S6Fusy+
 YhG3xVUTibVSuBVU9XZdymM40sRDykJ7S6baIaGV/72QfgE5/sPEksUGvzI3KBXD6oQ8
 JPlw8QRkdoqIP+Dbf0sHrVlS016S/i30kHdt8mndsy+HP++ILAXG3zzfhHH7YgClPJrC
 cMag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOVGJ4VUknLh8sLgQygdmlM4GNQ6ugn0rq/LwpQmAvpuvzoO09d79bWVWYQm7if9Iv6hWbAG+tg0MC@nongnu.org
X-Gm-Message-State: AOJu0YxUdWXg/FIyX2Z4GqplPzwffTHPRU+lfPeOhJweOMRBh+ZEF0MK
 Ye5um1/VaXaXwCKzXsvaCrbJlBmpVTHhn6LLPabqIjpAX+ccWOwHMxD8dFA4M9U=
X-Gm-Gg: ASbGncsjq3uAVn9M2JdzWVq52WhkVDRLYug9fY/jYevVBrlrZymP8GC50afQ+Ld4b0X
 2fBkA+mn8oLPMaA5qzzQghZW3KZmPchL83BKkaheZRQMBlFSHWYlbkXp/w9wInUNZw+FsDk0H/j
 Qrzbv+g+ABTWqS0shIlP/43Cf/yqK5MfxXlTHJ7ejn7pIF0wdmwUY61HX2JaehKtohRXryrQz3n
 8Q72Mkze3KpANPrdvyvm6eoJpPcqwGWKJoEGf9Bf8AosyrBn++esDIqWIetqfT1gWmywr/+BHNY
 e9sDzIOBNWxyp76tw9s0e1ry0majGs51evaEHSkAGfXoOfw=
X-Google-Smtp-Source: AGHT+IFVSdY4A8hl0J8R1xzffZyqo2EGtj4UJhs4TdlGadkWQGH3lOBL4wCLTSkruaWT1uY1DCXCSw==
X-Received: by 2002:a05:600c:444d:b0:439:5529:33e0 with SMTP id
 5b1f17b1804b1-439581bf09fmr64411835e9.27.1739448910744; 
 Thu, 13 Feb 2025 04:15:10 -0800 (PST)
Received: from [10.223.46.213] (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394f2c2c41sm63499255e9.1.2025.02.13.04.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:15:10 -0800 (PST)
Message-ID: <57ab57e3-65cc-4301-922f-87dbaaf85d8b@linaro.org>
Date: Thu, 13 Feb 2025 13:15:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/10] hw/intc/xilinx_intc: Make device endianness
 configurable
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212123659.52764-1-philmd@linaro.org>
 <20250212123659.52764-3-philmd@linaro.org>
 <8e5050d7-2792-44af-8317-2dd6948f72c7@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8e5050d7-2792-44af-8317-2dd6948f72c7@redhat.com>
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

On 12/2/25 13:56, Thomas Huth wrote:
> On 12/02/2025 13.36, Philippe Mathieu-Daudé wrote:
>> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
>> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
>> Add the "little-endian" property to select the device
>> endianness, defaulting to little endian.
>> Set the proper endianness for each machine using the device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
> ...
>> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/ 
>> petalogix_ml605_mmu.c
>> index 8b44be75a22..55398cc67d1 100644
>> --- a/hw/microblaze/petalogix_ml605_mmu.c
>> +++ b/hw/microblaze/petalogix_ml605_mmu.c
>> @@ -111,6 +111,7 @@ petalogix_ml605_init(MachineState *machine)
>>       dev = qdev_new("xlnx.xps-intc");
>> +    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
> 
> Do we still need a TARGET_BIG_ENDIAN ?: check here, too? ... the 
> petalogix_ml605_machine_init() code still contains it, though big endian 
> is marked as deprecated and untested ...

Oops, I guess my mind already discarded it...

> Anyway, assuming that nobody uses this in big endian anymore:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!

