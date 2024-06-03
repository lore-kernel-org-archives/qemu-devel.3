Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC514C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7C2-000667-0k; Mon, 03 Jun 2024 08:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE7C0-00065x-TK
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:53:40 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE7Bz-0001Sz-8U
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:53:40 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a683868f463so368170266b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717419218; x=1718024018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OM/c4ysPs1GJpA5eW45mBmhnBVQ/fQnI+kTmnkJULAk=;
 b=A7FhI4Ue/IoUAlB+SiFI6kyzibPXA0njL3aPNeHEhMiWatimjI1eyF+4BQ+9+K6XzC
 a77fEPf+SQFJuFjgU1iuHXHQDESN9EsB54FYbhNT5WSLFWwfqHzq+7pu8P4GY/GUu6jv
 1logyeCaF2MFGuB8lL9AY6CaI5vltgfV/y67AelDweAR8VeGQKEGN78+NnZBJ9HPTshd
 ApIab5WZAi2lFWkEvbLodWG3IDirI8DSmn1DaAw5DvjFnTxWdPMYVK/yuiOnamKyxAqh
 FuKGqCXkaMUq10ws3S1Uq30U8DW3v6ULAPY8rTMJAFkKxnrmnPZ7cRAKZ0D9JGQ7SlkC
 9Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419218; x=1718024018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OM/c4ysPs1GJpA5eW45mBmhnBVQ/fQnI+kTmnkJULAk=;
 b=j0O+7WmKw4ON79YpY2hOD7rHJuc9XrwyhwpNJP3iXDxccTF950zVAWvTrXdIbl+9Bb
 RxkK4RDr8KU7GBfGq0jCfY1LbSDsTNOFxZDCJvFqfzdy1CFv+ePTqDsAlt+IhvosyaTZ
 4zcT6cWfideoEAoGVGzRA65OULxYRHH6NKwpJLRXJVSuVWeO2YYTA55xcFeRAl15lrv0
 IGZ9MCsZDrCjD+bezKncX91muzvzdAFw2PjnniOVzAPBZcHDeeoAZcN/D5eqJ3Uxz/3H
 lTpHaK2/6kDv3erCO8uYHWUPlHUEIuMHrTJgWTdBTlr2t7bNQM1QyoISGcGd4guMXdaq
 3FQg==
X-Gm-Message-State: AOJu0YxQJbLqKW5w+kVqTVKTT4oRQ9tkLe1BYYca1X4KvWbYqJ7EzklP
 8l22S+bAz6UCw+/dDs8RzdLtW9wWeFFMVIiLhJFy6dTHbSW8a+INYGH5SCh5tKg=
X-Google-Smtp-Source: AGHT+IGEx10rEhLPPTBdkL5gjMx5JPkqwqxcsybRAhsz2BNn40R6iVL7gUDKDguIxD3mTKuRIXvDaA==
X-Received: by 2002:a17:906:f0f:b0:a5c:dfc2:7239 with SMTP id
 a640c23a62f3a-a6822150e85mr630446666b.66.1717419217628; 
 Mon, 03 Jun 2024 05:53:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68cc45cea7sm299469466b.51.2024.06.03.05.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:53:37 -0700 (PDT)
Message-ID: <48ebd16f-3eda-4292-9257-bcac9c82cc5c@linaro.org>
Date: Mon, 3 Jun 2024 14:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/cxl: Fix read from bogus memory
To: Ira Weiny <ira.weiny@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/5/24 18:22, Ira Weiny wrote:
> Peter and coverity report:
> 
> 	We've passed '&data' to address_space_write(), which means "read
> 	from the address on the stack where the function argument 'data'
> 	lives", so instead of writing 64 bytes of data to the guest ,
> 	we'll write 64 bytes which start with a host pointer value and
> 	then continue with whatever happens to be on the host stack
> 	after that.
> 
> Indeed the intention was to write 64 bytes of data at the address given.
> 
> Fix the parameter to address_space_write().
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
> Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Compile tested only.  Jonathan please double check me.
> ---
>   hw/mem/cxl_type3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, patch queued.

