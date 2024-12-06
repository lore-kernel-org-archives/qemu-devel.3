Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A45EE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTr1-0004PL-MV; Fri, 06 Dec 2024 03:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTqt-0004O2-Pl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:38:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTqp-0000hw-2f
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:38:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434aa472617so12494275e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474293; x=1734079093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uFDFhaaPmq8YkHpHPFmYcpG9w/lMjvJgPxWHm2v9YMU=;
 b=K6e/Vi4tWXmP0Cn7IoY5MfPUrAgTPfn+8BYYmLvz/pZwQqR6fAYiC0CSZpOyo83RD3
 M39OWKGnyg7VfnleeBoGE0ib/dodIDEaioZvEm5jIZdn2AZzqEiTIAquO5oiDsytS7Or
 boungvYExCtdGHIgPBr/zbUi0vYNmdM+0mJREOI3yvHveiM8mQRYL4LnbqK/1u+Qoxqi
 bbZkF4984OWhwLS/NyCEnkb/XBxMc0V35Kliv53GEw2b1Ax7TUcBmq4Eicd17sN3/5Hm
 i58pq3/21f/DuETwO3tfOeDrXDkA/8uEl+yhPorUAy23JdhQ5kA+jx8cR4bI3UEiDI7u
 D99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474293; x=1734079093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uFDFhaaPmq8YkHpHPFmYcpG9w/lMjvJgPxWHm2v9YMU=;
 b=rcMuu2rsX0JgtDzt00jNcjDCPI+uguh41eGn+hZo2OYAMXe7ZhMYcsgxxWlyqZaXy+
 e00wmpR5GXW+MXX0XXDKKKcivzlZRr88K7l2KG+agoL84SacVxDDiw0+UZP6JQCVR20O
 xDBaThvNEhhnRu8a3Zayn7kmd07EBqDh5JNOjI39MkFodxVaLUt0vKswkcy7l4J8a1lY
 NPCBHfmn89SomthAMonkFKGCSoqEjhMTRGwvglSceix+SKfgEgqESdvXkEUtN2+bTNts
 Jkiow92kRtJm9NAF8IFtSZw/rZLGRmJ3sZ31tU8g0/sPgJUV3PF4rcqBkgJ8u8euijpw
 S8fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7016uDHtXcX1oQOhyP4Trnwt6VpbNePhhLd5vFuVMv06agcvTxwLU/DtNVlNNMrKo9I7H8KnD5zs+@nongnu.org
X-Gm-Message-State: AOJu0YxzDI6MfrrPq2PDaUkKUBO1YStCDOrhdDd8ZI9IVBeHRuYhXE+j
 6ZpnIsUvDvT7EUpDpnYzH4yX80JpbFquy/RTY4bz1Hvl6O+uB4ECpmTNJgOokfk8eMmz+rNzTlu
 q
X-Gm-Gg: ASbGncsVl8YvVfbdOAE2G4Q3IEFIP1DGAT5B7pTyDmsipxzNy8uRTDJ3fKHV/VV5HYB
 kZclGhGeUZzR6eL6AC2PTpIcv1HCaRhwD/35rsxyVXOaX3PaE2Exg7eN3oOfGGTy6HHG8Pis0z+
 /t5eccjADdbZjrRqwnaO0sEXqt6gjIz2W0w2QKCJaju8mlK/zlx8jTUBFRrjfb14omD8HwgBiCb
 28sMCxenDc7W+VD+MTfPjcxfbQryA2+lIbBYnuSHVv+mKqfBRXIH+rDLYdcr8WSrCY5rRGEtuxb
 8rmIufUCjm0e0OL+Eg==
X-Google-Smtp-Source: AGHT+IG1iIwx6ao/QFHlAZHfPAZt4KZInGYJkWShlm653AurikIo0K6vjoWJUIjmcIc1hPkOAZwuvA==
X-Received: by 2002:a05:600c:4f51:b0:434:a83c:6a39 with SMTP id
 5b1f17b1804b1-434ddead992mr18632075e9.3.1733474293477; 
 Fri, 06 Dec 2024 00:38:13 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da113580sm51457745e9.29.2024.12.06.00.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:38:13 -0800 (PST)
Message-ID: <428c9810-be20-4312-8455-50aa54bab3ac@linaro.org>
Date: Fri, 6 Dec 2024 09:38:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/arm: Convert sve_helper.c to fpst alias
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031224.78525-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 6/12/24 04:12, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h | 414 ++++++++++++++++++------------------
>   target/arm/tcg/sve_helper.c |  96 +++++----
>   2 files changed, 258 insertions(+), 252 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


