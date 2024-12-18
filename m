Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B35EE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuWH-0002fE-BS; Wed, 18 Dec 2024 08:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuW3-0002VS-7y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:55:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuVw-0002bS-QT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:55:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so19669225e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734530099; x=1735134899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6VDGr1qZz+LuYaf3NQ/MlQlAShqd1B5WIWGUSgV8tSQ=;
 b=yijUNvH/MoyMGCQc3TAnwZLHgeIr7Pc4LlvH4mCIbw4xCv/ju8aQcrroeaLdYKSMQh
 w15+FK9roYbDpd904c8QNApnmxEwmLfoaHO19zNevKZX+3FCH4dxhs9fJMDCEPLH19MX
 YHn/op8jKsiLkThBcEE8OizYV8XSUUgaIpGATvSeAEQlSXh0shCvY6RINNS15CUVXDUZ
 A8CODqpA/JeLWbuIo/wy2sKCV4LP2L9HvKLiDvDHwNhbUtGYzLAowO0e+OWFssHnldDt
 01h4Jo773mB/zNA9ST82s5XV57QOTWPRVK9lGifLgZ+3cWUevgaRZegOllsLk5p6Dazj
 FZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734530099; x=1735134899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6VDGr1qZz+LuYaf3NQ/MlQlAShqd1B5WIWGUSgV8tSQ=;
 b=TIkNVwidW4xXiIYrsV7CZ7VmlKOzygpECOvZ8qKlP+rp35nNI7QNbWagUDs9i/xbyl
 4/1WBwzUQua1vRA/o7P//qOA9hN1BaJ0HQJhFvTjCvZNWNoo8qUqJXYyTXb7pN4pVar1
 OQtEMyYnuepbVacDxEWlNxzirIy0vkNd+J07/QNDHCsOnBU16bY5Ou4EA99D0BHfq+Ou
 OJcpi7wCbjJzTDwBrAHr0zCc3BwWIKoYHpYCu2WgoYiOA5wHLAHgDLIvzHseVJ+16TmJ
 iDdwmEld2ki0+IDcUKRmHT/YpP08kj6yd4kCVfc4jlQFqTqeVGr2Y40nhxMX7iQRIe5t
 jeaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVXezY7aCVz3obyoFiAPjT43zvgmOoeDBf/9pIed9o/hztFGkyUhkWOQoC0uXMg2Nhnhe1PjCZSfiZ@nongnu.org
X-Gm-Message-State: AOJu0YxCTvIQFUDXC9CuehoEs6Z26iD9C8Eeg7jdlAeXz8/NBBt6yBMN
 cVFLvikGDNpgnMwR39WFlPKb3ofHC/U+0xvOpOjcSf40YknHscFFS7/apBeKHKPEZwrZhNGgnsG
 a
X-Gm-Gg: ASbGncskBrSXgFm2oYUkwx46rI3YKVyTPxvYBkw77OWQqd/+FJJp9VBxbCKLVDXtRG3
 OeJ1U0/UdaOhmoicPz+DQ9xPC8tw5GHXspBW0uD0zl5wFEKzPbB0o0cvXtWRBSIAZf0QImIzV7G
 nTM+QE8l39zLGJog+MRkxMbLd1YdNwnsH9bANH50iuMZxJvmPKxGwhVWY43kobfaPSpD0EOJtid
 2FBTnwBqtNelqP4qUgnL7h3pl/DOTG6Xk6EuY0t7pbZlOM/NTW9+WR0OyaZKP/QBNXF6i1V
X-Google-Smtp-Source: AGHT+IGdDS9KVxXUaHdww8JxgOjAhnDZ8Ulvan0ULMuC6p6c1zwEhxJ1axEBwsYS8ZmMEiv4fP6/3w==
X-Received: by 2002:a05:600c:35cb:b0:434:ff30:a159 with SMTP id
 5b1f17b1804b1-436550af78dmr30114105e9.0.1734530099185; 
 Wed, 18 Dec 2024 05:54:59 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801ace1sm14174399f8f.60.2024.12.18.05.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:54:58 -0800 (PST)
Message-ID: <baad190a-fc5a-4625-ae0b-37b39ab481e3@linaro.org>
Date: Wed, 18 Dec 2024 14:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/24] Constify all opaque Property pointers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-25-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> Via sed "s/  Property [*]/  const Property */".
> 
> The opaque pointers passed to ObjectProperty callbacks are
> the last instances of non-const Property pointers in the tree.
> For the most part, these callbacks only use object_field_prop_ptr,
> which now takes a const pointer itself.
> 
> This logically should have accompanied d36f165d952 which
> allowed const Property to be registered.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   backends/tpm/tpm_util.c          |  4 +-
>   hw/block/xen-block.c             |  4 +-
>   hw/core/qdev-properties-system.c | 48 ++++++++++----------
>   hw/core/qdev-properties.c        | 78 ++++++++++++++++----------------
>   hw/misc/xlnx-versal-trng.c       |  2 +-
>   hw/nvme/nguid.c                  |  4 +-
>   hw/s390x/css.c                   |  4 +-
>   hw/s390x/s390-pci-bus.c          |  4 +-
>   hw/vfio/pci-quirks.c             |  4 +-
>   9 files changed, 76 insertions(+), 76 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


