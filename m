Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4E6E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzJ9-0006m9-Bo; Sun, 28 Dec 2025 17:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzJ7-0006ln-5H
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:32:13 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzJ5-0007k7-Kv
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:32:12 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6446d7a8eadso7033265d50.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961130; x=1767565930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fmahlLVw924619D83LuAsPxakBRGBHvrQ8moGIzQc2s=;
 b=Tnyzrrof+F0GA9eJ54im+HkNneCCd+0KZcBnp9Dqll7ahg98rcM+XuLGw4s76YuEBX
 uL6GbkQSX7rU0fcHcbcQ/I9w7sDMWWIfjJ7DtKuijR4Xp4BpKp5kfgBv4YJqUxJLK1eO
 gsJOdHZfBE156uHqhv/yyjAK/XjztBJ0vKh9nocEJWkfbp8xwXtBVfHQuQ+Fheb1aWsS
 XI9AQs7tQoLkXN8T7n5mFhODAyKSFRvishpeIe10Vh09Fg4kUnP7lFcDOCpsgPH1DjRr
 nHgk2x5eTLGtyBN7Gmlqw3P8MsRrNxBxdR4qPSOqHw2j0v1ftrb+7IG6weE3gLowr8Ec
 boJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961130; x=1767565930;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmahlLVw924619D83LuAsPxakBRGBHvrQ8moGIzQc2s=;
 b=vtK/QsBo8xejL4Yat2My6kgKYMjdEBtEMU++z2o2wiQUKL4uTtbNrKUQ5YFh3vOfjU
 +xulgnzWXYudfCLr+YHOqYCZ/AIVEBBKFOOrxuFFQf4z01Swx/B6D/tq67O0C3XlXRCO
 XnOkMgfZVVyom9Nz390gOZ/+2yzHmgTRQ/kT32euQdCqi++RFK5SJvTeB0jIYPOnnUGn
 GCZZWSnYke1jQVFBoSfNrbuqFwmExeXdkqfjqMQGLmh2MwEpKZN8LC1H90GNM5E1xuPE
 le5c124MIn8qVfrMmeuBwXExHRwErGaHOYg+FhGC1U+RcSzTeN+P4tLXFdOa6OBMVi1B
 FCTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYJlSY/DnryddWMXG6eVlWxgPet5HiFvSJoREL4pvlBkjRLx2B+Wajcf19fMgBOGyfezr7FTk+NWd@nongnu.org
X-Gm-Message-State: AOJu0YyIGXUY7rn7h59ZNAO0oU5AfWik2MRkZf/9YyK7Rm+wb+p38q+D
 jX3iWe5stpe5ptqWjcYTx+g9G8BkA9KzOJMeYs+UrzFj4ogD6fuNkkZWvr6nGgKdQx4=
X-Gm-Gg: AY/fxX5jVTQO6lDambdi83ra/Oe32x+xikAjQ9LcRDKIfz8t87q9Oe6eYkbQ2AM6SWr
 iQVpYKhmbtjBwwbqlYV0CKrVOY05/yaMBuSSe2rSy3J08kIRuDJb0nToBWwBXInfVvXViMjwlL0
 c7Qw0gIoiUSL68UrWnrXcbX6EqyRtEVVLzJupdbAxF/QfI7RHsKlvQYrx5nX6lgdvcIhYI2gB1E
 ys+A3OjDUQYclkNBCtPmFy3gy9dlmroLsTDUZFBX9yxq2EtwzoH39kNd4kED53clm0U9H2P8Tkq
 iELfoEXHFcPSMuoDPF91rPB6LYFi4wl6c1HQspqbYmljYRMePMmCMX04rRzcuj0is8b/1SWZEGz
 kG4yAdmYrEQkAg8Hco+YLwNsWAK4iXmGBoVr+GC/BOSl0VSQqEAm+WN+UjaXsLgdxGocDBLdcHp
 aZMIKMe7zbq73Ph9hpSqmq1admfR6+m2RjBhR2SbQ3auCRO6107kpK
X-Google-Smtp-Source: AGHT+IEYZJos3v6VG8dy/85VK6r6sfoXV9Zdrzx3Q3MHBmed5A+H8rMghaZTm0EXwSCRDv03oHL2rA==
X-Received: by 2002:a05:690e:1881:b0:646:7da0:3a96 with SMTP id
 956f58d0204a3-6467da03affmr19184652d50.50.1766961129870; 
 Sun, 28 Dec 2025 14:32:09 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb43c1aa4sm108972987b3.21.2025.12.28.14.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:32:09 -0800 (PST)
Message-ID: <bc46127c-54df-463c-84a7-9e7dbd37234c@linaro.org>
Date: Mon, 29 Dec 2025 09:31:58 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] system/memory: Use explicit endianness in
 ram_device::read/write()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>
References: <20251218212814.61445-1-philmd@linaro.org>
 <20251218212814.61445-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218212814.61445-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/19/25 08:28, Philippe Mathieu-Daudé wrote:
> Replace the ldn_he_p/stn_he_p() calls by their explicit endianness
> variants. Duplicate the MemoryRegionOps, using one entry for BIG
> and another for LITTLE endianness. Select the proper MemoryRegionOps
> in memory_region_init_ram_device_ptr().
...
> -static const MemoryRegionOps ram_device_mem_ops = {
> -    .read = memory_region_ram_device_read,
> -    .write = memory_region_ram_device_write,
> -    .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,

How is the choice here different than ...

> -    mr->ops = &ram_device_mem_ops;
> +    mr->ops = &ram_device_mem_ops[HOST_BIG_ENDIAN];

... here?

One of those two sets of functions is always dead.


r~

