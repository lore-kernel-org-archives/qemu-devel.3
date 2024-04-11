Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0A1CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 08:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rupbP-0004gh-7m; Thu, 11 Apr 2024 04:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupbN-0004gS-8O
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:16:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupbK-0005Df-Uq
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:16:08 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ecff9df447so6351663b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712823364; x=1713428164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VE9fzmSB/sHdUF7YMeAyAVnL2WSxZl1ES34T0xSXyx8=;
 b=b7AK1+NkGv7P0ftwdVQgyvvm5bbBSw4FdFcSxaOlCQPBDyJ/Jprwc2wUozqIfSZLwx
 O+nKdmjDEiKqxfZ6oo3RtiUZ4IJLkl8Hr019xOhazizzF+u/x95Ym+dUdj4F4Xt7SnRZ
 x7u4wdj7PDGCxEnqEL0y9IvcC0UJsz7aV2yxBmSF52+fWEJYHgBC7kCsRf0khjJZaS7B
 b7acjrE6cUABWZt3oySeTBloDldBmlRa8ljZFx6Fs2v7PJrKtJeVnBhmWTXQHq1qzw2l
 QUvZMwLi1dYPZCQWhZ10AqxVOzS5ZXLRw8EQ5xXGVpBsh9Jh1cxNfuMPTwyTTQxRPxpj
 x9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712823364; x=1713428164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VE9fzmSB/sHdUF7YMeAyAVnL2WSxZl1ES34T0xSXyx8=;
 b=RSN+dUxcvBF62tKwCmEFN+Ly0u/ttRbRiWaYVyGXlZ9K20GZtZ61/6ueyeVwtwFq/u
 7GBA/gdFtesblzLMF9pDNdXPV2Qr9GFzmvVtfLp6w/UsPBM/7ww4B5QpDxJQ5pxuwlRB
 7ItA3X+zTOuHixYJGSFvWyslnEsRRhFoDZqRziQba2Ak/RAg32vULZ0XSm+rThDpfZsH
 MVSvEmIblZUEvfL74yNExEGcwCprwRsxHIH4/Th+JwTUrWO+jXrsDaJuaR4vCBW1haNQ
 dRr6UC7hbVeLEEOYKRPgdJ+S6bEWY2Jwm9Ae0yVQjQLDDYoPeTltf0fE21h5YZ7K97zV
 AuPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFUgT+TaudiBRIGPDwWy7anyggsFvdmKVGRBq4/dZomfqW6A5MFvtQ9gdoCJAbXyzq3is7uFmaWnkYI2MOZCCA7OYzJNY=
X-Gm-Message-State: AOJu0YwO5N1o75bUKsJ0yJz8YpjjOLWxTKvVTG3C65AmdnU1x8TrmA2b
 U94Ii9LI6Xm9mXxKW73eK1M87WHIu/N401jtjzBpvuLq9GZkCtiltKPoptjW32w=
X-Google-Smtp-Source: AGHT+IGejog4GzUwDpSWJ+GS/I5eOdLFfoWiw8VH9Uy5+ogRdkDT5BGpBANks+wpfTCNN4QNR7r2OQ==
X-Received: by 2002:a05:6a00:1389:b0:6ea:c04c:71cb with SMTP id
 t9-20020a056a00138900b006eac04c71cbmr5834119pfg.3.1712823364473; 
 Thu, 11 Apr 2024 01:16:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a056a00228b00b006ed26aa0ae6sm746360pfe.54.2024.04.11.01.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 01:16:03 -0700 (PDT)
Message-ID: <65f973d9-8357-43f0-ba9b-42d885e1fc8e@linaro.org>
Date: Thu, 11 Apr 2024 01:16:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 17/19] target/i386: decode x87 instructions in a
 separate function
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-18-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/9/24 09:43, Paolo Bonzini wrote:
> These are unlikely to be converted to the table-based decoding
> soon (perhaps there could be generic ESC decoding in decode-new.c.inc
> for the Mod/RM byte, but not operand decoding), so keep them separate
> from the remaining legacy-decoded instructions.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 1120 ++++++++++++++++++-----------------
>   1 file changed, 566 insertions(+), 554 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

