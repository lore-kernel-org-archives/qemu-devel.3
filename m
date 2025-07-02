Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBDAC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz4L-0004Eu-5j; Wed, 02 Jul 2025 11:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz49-00048L-Ml
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:08:09 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz44-0001bt-Bw
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:08:05 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2d09d495c6cso1554576fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468878; x=1752073678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6trF46c/r4ECEMVRlm6GjjXuLt9n4TR0TkpjXzR3FU=;
 b=p5OL7QBLFVo2RxFhC4QGXKg/pZ8YX+6FHGPOFIxvaYBM7Riued7Qyoxe0Pj34sFPfw
 AiowCgcZG8gejq8bcDq34jlN9HDskNcfiLsp/Up58z1R89ATmUEfJb+gozYgRXRt8Qis
 IPCrm4qNaZ7jKG0JQamaPFoFh/GbZiU5SHU5Xngf9o51/2XlrvnxiIi/2cBKRfoaoHRc
 vQhHd753QNK1J0ygAOCr/y56zC/00MkL/xWegNtJhRlVcsqZ9WUDf2NAI8p7vS4cEe5w
 kcrq47r6rgBH6LSEzL6Q9JmvOrolBycm4Gyar6+7qaaiz9Gmga4XcX62+foUADXxP8Pk
 CMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468878; x=1752073678;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6trF46c/r4ECEMVRlm6GjjXuLt9n4TR0TkpjXzR3FU=;
 b=jWehBRLKVUbX+jYrKJropO3ITR9ZfmZGMy0wRDnjKhXbO3l7D2dYgFaDl06xDg5d6b
 HmUgs2wPr+nlAb8sxs7zJahETny4soXn7TOVDyPVqcgmBzKqCSxTJhsviRn7Fd3kM2gk
 rXN7q5VSPtz8DLWodzGDZxaeLczFTIPaliD5qaGEKnCELZeZdMWN7xiOB9rOBzMTGz2H
 cc5vhkDsgEd6+tQttQrVJ0dB/R50PurxaGGJnE4QnEbzeyncbdnvFC5xY68BboKNs+aD
 fd/XkCfzd3Ww7byn5atnQKLtCKHCSOeg9PO+8CCoZEKeLXn2xEeTU1emcyUrY39Q8kg9
 wKqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKE2I0aD4FZ2Ffav/Pc0Br/h2CTZABYveC6eGTPLj2KWz+FdzssCOHVrrd2J2rJmNozFDFlHOYETnV@nongnu.org
X-Gm-Message-State: AOJu0Yy93O6/3SX5//XZqB49a6OXCFaAo/4ulUm+n0QX1m35bWJpxIoE
 XEFqSG9wW5kVaNWRHkIHz5nFPnic5VzrtgH3TulsADZdieUoH+VqktNLWimjfmtBoXc=
X-Gm-Gg: ASbGncv+8Rjo2Av0KKSKYHjfLymRrmlnT0KqdwrvbwaMR+ZdbYhihUDZAgCP126NqcO
 /0ANbJdeUTk8L3oDxMwRdLmumdT9vp6IWg1QWzFdinOdr8F1Jei0MGW2lsjU2x7WIluguUKEOSV
 0NJOLlQyj4NGnb1Gz4FwS2jMQHJKKzr8ebcqT3c6g6Rqn9f/By2AzsBA1nXleuMegbbbf+mXHhe
 dPEDBw30yBcyGC5vjNSCbfaUlumVSPduhIdB3aP9ioqbBSfKQQlIJEnJFUg67xKyFdUQdJYQgjf
 zRf4xLWPMauU+gxG+dWDCfSkMFiMbAORKegqX26cj5el20DZwQHWDmrUUGyfmLSID4nArSl7OeW
 c
X-Google-Smtp-Source: AGHT+IHWbCzfQJSxKT60t2wbSHp/cj841AJ1u1t3q3buALa1vX/Uc7pSigoiqRphFUdcikzaecHFFA==
X-Received: by 2002:a05:6870:3b12:b0:2c1:5448:3941 with SMTP id
 586e51a60fabf-2f5c7c4a7b7mr2546442fac.18.1751468878024; 
 Wed, 02 Jul 2025 08:07:58 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ef29absm3882789fac.14.2025.07.02.08.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:07:57 -0700 (PDT)
Message-ID: <178dc387-ffeb-457b-8d79-125b98ce7aa6@linaro.org>
Date: Wed, 2 Jul 2025 09:07:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/68] accel/hvf: Move per-cpu method declarations to
 hvf-accel-ops.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-31-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-31-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
> while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/hvf-accel-ops.c | 29 +++++++++++++++++++++++++++++
>   accel/hvf/hvf-all.c       | 29 -----------------------------
>   2 files changed, 29 insertions(+), 29 deletions(-)
> 


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

