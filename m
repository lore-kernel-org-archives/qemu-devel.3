Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B0CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ945-0000Zd-JA; Mon, 15 Jun 2026 11:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZ941-0000Yw-DF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:17:25 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZ93x-0004vz-5N
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:17:23 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8424b6792efso1439563b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781536639; x=1782141439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6oskG5GTcT9Ma7NKGU5j19GJVLzOfGKstQg9zurxwG8=;
 b=bNYBqxY1sC0WNlDWSbYSOYiWro5wPFhmc8d5O++1TO8ms+7MT0Z/PVAvn4PiH/BKxy
 rmUHRLCfYAFFN08jb8pc0PSW8A255Xs7Wr4hsNcgRI8dM1zliD1nk0C8lKx5v6PVeNIb
 KF4+gANzQfTqw5dikyufy+mYtNDskoZ3+N6xVz/wgsoVyByH/nHeSdJFP27+LtCaskPk
 NWPemOus/7xsoHx4mQvZIU+6rDHJ8O0BmF2Ic1u3BDojQS+my+S9cIREHmB0sSbdO2e+
 Qvng7wj5jhHI414PxdsYS12FGnf8NvvaGCCUXYfgEfbYGoNDj6C2iC79NXwHr1tlGPhI
 0aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781536639; x=1782141439;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oskG5GTcT9Ma7NKGU5j19GJVLzOfGKstQg9zurxwG8=;
 b=o0yEacGvQAUg5hCHL7+fRNakv7x7g5n2QOQ2Q0cEO2HOeFNLvPHxRwQdyMeidWMBnS
 tjDlRibz5/36lI2knFfvzemNZx274SMFLtERUpG5QU4Y+BvXyK0FwF7X0X/927wJBXKT
 muwi7IHjllad8L4JaWA9jgi6ltP1Si3FwWxexHSbMMuCmVYElGE5jxCa3B7D+JzHvjpn
 FV4vJcdOuEhhr8snwzNK5stwBRpNLV/wL2TFqI0BpM3Nxo6l0YCuS79V+a0ESxnXeIBN
 ldub33o2MhRdBRPINRts2jqGiFOIVUaWG+QaWrO2MeZ43sdoZOnB6B3V9qfoi1nrswmS
 ZPVA==
X-Gm-Message-State: AOJu0YwAY5PxRLFRZdnFdFV6depAfgZF8RkbyAXZDsCp5nboXQiwZedb
 mlQQ0cVQoH/7ItyWzEMf6pip7Eqb+/XfBjgixZzTwKvxwsHMQdzUnX3gJ+leO7wtOog=
X-Gm-Gg: Acq92OHxLcL72urzn9Yc0zdU8jZR0itE4HdRUlLIbH41EhBHs5C+/jFZcyBOGUHMUkc
 bMO1tH4xTARFYEwM5UliqeiQk9e/dvzrhq+J2rsM147w2lMSSdbluj4/+6ZuuoZhkVHMSviWYLd
 COVF7OIkMt9PVMfHpBhrLg9P3xk2zxtz5iWy7WZokdttYz4/wLItIaeDlbHd0Wb5Czq2cU6rbua
 3mhMQ0p64dcZO/MxazkH4bWHxc+qoX/9R0nTwoJGg8obhQQRMJR3Ed0tgzllNb8AoFdm7YV4cff
 roA8ehwVyQjkStWW7jx3ef8olzuBTohhorcZZuciC/29IlrW7NjRxBkrjgc/tVDbrltCo1dKmdM
 wWGodT1GXMs1YH/fAIoBx3nTsKFywiYQWSIFXLhXp9vaqD1X8oGVNSb0hIkeUJ9hN5lyx1lpCs2
 outfqbFvbjgsoWnsNk8Cf9YBhLaWhycv2J6UHG
X-Received: by 2002:a05:6a00:179a:b0:842:6a3b:60d8 with SMTP id
 d2e1a72fcca58-844e1a69616mr11372809b3a.30.1781536638968; 
 Mon, 15 Jun 2026 08:17:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b05d7d7sm10876173b3a.60.2026.06.15.08.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 08:17:17 -0700 (PDT)
Message-ID: <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
Date: Mon, 15 Jun 2026 08:17:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, peterx@redhat.com,
 alex@shazbot.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260615100200.266968-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/15/26 03:01, Gavin Shan wrote:
> +void qemu_ram_copy(void *dest, const void *src, size_t n)
> +{
> +    if (HOST_UNALIGNED_MMIO_OK) {
> +        switch (n) {
> +        case 1:
> +            __builtin_memcpy(dest, src, 1);
> +            break;
> +        case 2:
> +            __builtin_memcpy(dest, src, 2);
> +            break;
> +        case 4:
> +            __builtin_memcpy(dest, src, 4);
> +            break;
> +        case 8:
> +            __builtin_memcpy(dest, src, 8);
> +            break;
> +        default:
> +            memcpy(dest, src, n);
> +        }
> +    } else {
> +        uintptr_t test, lsb;
> +
> +        do {
> +            test = (uintptr_t)dest | n;
> +            lsb = test & -test;
> +            switch (lsb) {

Either assert n != 0 to start, or use while not do/while.
Because the body of the loop won't handle n == 0 correctly.

> +            case 1:
> +                *(uint8_t *)dest = *(uint8_t *)src;
> +                src += 1;
> +                dest += 1;
> +                n -= 1;
> +                break;
> +            case 2:
> +                *(uint16_t *)dest = *(uint16_t *)src;
> +                src += 2;
> +                dest += 2;
> +                n -= 2;
> +                break;
> +            case 4:
> +                *(uint32_t *)dest = *(uint32_t *)src;
> +                src += 4;
> +                dest += 4;
> +                n -= 4;
> +                break;
> +            default:
> +                *(uint64_t *)dest = *(uint64_t *)src;
> +                src += 8;
> +                dest += 8;
> +                n -= 8;

Use qatomic_set for the stores.

src is not aligned, so except for case 1, you need ld{uw,l,q}_he_p.

> +void qemu_ram_move(void *dest, const void *src, size_t n)
> +{
> +    if (HOST_UNALIGNED_MMIO_OK) {
> +        switch (n) {
> +        case 1:
> +            __builtin_memmove(dest, src, 1);
> +            break;
> +        case 2:
> +            __builtin_memmove(dest, src, 2);
> +            break;
> +        case 4:
> +            __builtin_memmove(dest, src, 4);
> +            break;
> +        case 8:
> +            __builtin_memmove(dest, src, 8);
> +            break;
> +        default:
> +            memmove(dest, src, n);
> +        }
> +    } else {
> +        qemu_ram_copy(dest, src, n);
> +    }
> +}

The qemu_ram_copy implementation above does not work with overlapping blocks.


r~


