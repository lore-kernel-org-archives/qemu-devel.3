Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33843CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gmP-0007NW-9H; Tue, 30 Sep 2025 16:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gmM-0007Mt-G0
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:16:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gmD-0004nW-BS
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:16:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-27c369f8986so61880815ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759263398; x=1759868198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ze0eV8frL3NGPztAld7gZ0IDe63MTniQ5870N3vijAQ=;
 b=AC+wKpBpRMwxbE7TZ+u7enPPg0qZ3F0dNlvMZe+NcbDKtvlSKg06q0sq+PAy8oJjQ6
 x/TVd4wUbW8ZRyA7d9uIfc5XO63VbubdgmWLyD7VA4anNSW/kYAKhyB7HfgYYqKtGgI0
 H42rqxXJ74BwWzST8ct1JGmCMVmKf69GvhQSs/pSWokkZpPXq0Giq0Qf3N2hNUAGTdsO
 FVKhXmtYSBRl9fJL7AWkfybZG95ps+c8OqFklqvuXOXHy6b0ig/Tfa2jU0GEIdT725OS
 mRM5JRamNay22wQysjOGXWiIRWXTZC/HYDdFPXpTCuSV0UX7yyknux7/5fSoSIB7QB3/
 udoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263398; x=1759868198;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ze0eV8frL3NGPztAld7gZ0IDe63MTniQ5870N3vijAQ=;
 b=qkSnL9+JEyQpjCUeRRTFg3ha7UshpUwJYGvY3gsFL57ku/qBfoLsWjxqkHs/ECzTMb
 /6TzMF2QNRqn+0tYpJwnXCbgMMzySwCN+t7xcf8qPJPBrcnSA48kfAhZ+T/N74NZC1Fk
 Iqi52ATzbB4TXBPQ+gBBs3P57txu8MP134Dz4LU89ZCaxMaDAN0RV6l3mghBRl2rnZRM
 0K22A7bCS1f+KY105FBKNxUb8jGkrOINOEKoXWxiAik2PCm+6zqkRm2z3Vc0PLkQ6dWu
 pAJd1N0BXSrtMzGwIR2tC6lhpealMWKQzsyYuRw/YawBnBqdvnQRTiy26U6iBM7SBP/r
 FrVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHtqRw2BmBvNDocHBpydJJ4A5QsSfDq8iRr26n6t++1jiNBWMOcKgjYAqftXxBOwSvQp5P1FqQssZ5@nongnu.org
X-Gm-Message-State: AOJu0YwWF9GF7YHCBmyqG13GKnMacTDJJwrILerPHCKTznuh3Xxb0Izn
 4mlbtPhhxjHM0vpoP8I7vbe+wpKJ56un6LR9ULu+b2IGZAIPGiKAniOOfEy/S+C6ulM=
X-Gm-Gg: ASbGncvvIgpGbfhWrM/GOOThE5QW6blN7rQ88XkXELdmJFQtI5fktdOo5WH0RlyUpNn
 7R3usadUHabhNDElMSIRRYSWwn34tS/fXa4IY2HBfb/Jd/qEEtigTwkoWor8fttNLH9SFWGUQkE
 9VdwKGpTc6bry+jvfcA5sV/MtekWYrFSISJ1PO9dma/zPsYTCpDdvUHFBDr+LNL7gmmZ0N5DB5y
 RJ+E+9IM+8SZyCItiZcD6coAmbPGufeOfNLeSicWSXKQ3XlEpgiBSVueUqcvqylBe/AASWKHjHO
 sp6aW90QXwnM0CPwX07gftjdUKOlN+Wtr6NXpfH3/gcCs9cuSqPwqsZW1Oy6IA8AFHCnI470xaI
 7u+MCbBCpNn8ePHrGVJqO2XFOur3q0Yd9LoEgZ0w9FfT7z7nqttMiv47KVL9CwCiceGfcXIY=
X-Google-Smtp-Source: AGHT+IGLu6YpYGZ80rjFKDsBGVT4Ba1WpNqpas0dECMtG6L8uU28Uq+HwiwB6f4KgEMAOF9I2YDxQg==
X-Received: by 2002:a17:903:46c3:b0:27e:ef12:6e94 with SMTP id
 d9443c01a7336-28e7f442cc2mr10505095ad.55.1759263398292; 
 Tue, 30 Sep 2025 13:16:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed68a0203sm166662525ad.100.2025.09.30.13.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:16:37 -0700 (PDT)
Message-ID: <88a9ea7f-aa81-4534-8ff5-b5c2305eb4a7@linaro.org>
Date: Tue, 30 Sep 2025 13:16:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/18] system/memory: Factor address_space_is_io() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> Factor address_space_is_io() out of cpu_physical_memory_is_io().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/system/memory.h |  9 +++++++++
>   system/physmem.c        | 21 ++++++++++++---------
>   2 files changed, 21 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


