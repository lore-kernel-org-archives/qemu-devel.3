Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C38C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc5d-00005p-B7; Mon, 10 Feb 2025 17:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc5R-0008Ei-5G
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:17:05 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc5O-0002RF-UO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:17:04 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso2954057a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225819; x=1739830619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxYnmVo73BQmCsNLmzhebDUlsTiyDBQaXiChNep1Lw4=;
 b=WVF213APi3qzcUcdM75GRs9pzSjIbyd2x82h3aOG7VMoJuDdVXOknYbhItfd5poZMM
 kOBpDHL9ncu6nR9xFtdGRmiyGZVEGVGxPQyZZJE3fuiMBqkAHPN1Ka4jBoZZBj9Yi11Q
 i4L5sJgnBd2qMCStbjwVhUaOfIYIa8qkiHNNSZV9qhJ09tqSZ5xfPcPh/3aDwEFki0LP
 9c5pegkidNkYenjURu/4tCvSDt+9Z6QJyi3Xx9Au9NqW4ra/ZslfdiPWBBJdDdMOPQFN
 9zDzdrie96OHnoN1H3/NLXGBWYzl2d0zcY9UMjH+g/hhcJUtbExom8EoScvndfJT1dKR
 eQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225819; x=1739830619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxYnmVo73BQmCsNLmzhebDUlsTiyDBQaXiChNep1Lw4=;
 b=wqX4ujIkvTa4tQNVp3pQ2Cz52p+Bhy9azvi1yPuB8jTA5m1goVaRKQ/U4wSvupFY0H
 gQ0ClCh2/el5f5Dlfo9UVmuLi54MG3KTg3BlnfHxtqxTPhdWZWuudwmyoo1D5ZbRWHd9
 TJ12wJlFTm3Guumg8gM2ik1bOAoPWlPRIkt3RABW99+hmJpzlJt6kLRu9WiFNt5r6EGV
 kwQk5ACWkYFsu2xVI0ZcEMvpeiM/nR63SiJUKVuDbB0bo2NCTH6GLNtJJFVTM5Mq2Z1Q
 sQQN6491MaKkVADmI1LemMOti5gU45+fjBlNyIv4syfIyKns31M7fm6M2pBsBIMCDnCy
 9AaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2gbV/QByGVxZDhK7RSvxQ7IVbYJEWRg+c5EC+uumE08f4H5VTnhxqrXxe9TFTha+Rz4fkeveZFmPO@nongnu.org
X-Gm-Message-State: AOJu0Yy4AsRShNITMFdjZL7dA1iMkBL+YWwCwWwLpOt9S6mGJBD7X5NN
 8x3pxVUrNycrMUfNZVDFB8/u47dz9rqDKcCLO7sJ9LRExeftlBlKgb86x7HprGE=
X-Gm-Gg: ASbGncvahS1DVlPrjjxWuYA4P4CKDZGBeDl0YsomIBhlxF3Tsi8e25uXpdn/RCWoJLk
 rzO7st1LffrT3yxTnBuKeqJZnJ1kdwuGX1hYV0t53texAGmYgDGbcwcj1BEjyHk5stUmm0H2d0F
 HqcbLtoP68VLYC/iQczBONbaROjwRHmUdwtx78HJqreRAoc0YofSFrLSKru4vDKBIOyvasQo+nK
 zC2RK82tiu5ZBrJqNWILu76BImTWOnhrroaccZMG6hOOgevtPLrGb0Xpf4R30yAeJ4Ub6J28Vez
 mQn86GG4BM1wKovc+ES2VWaXgQ9MdCq+sjVxDuRukN0hVMCDNJaIMB0=
X-Google-Smtp-Source: AGHT+IGbUupnISY5b9nHDINezpapgdfI/gxfHd61TFnDoafxjGnp2lY6nVBglRsxOXxRXNhn3VXAMg==
X-Received: by 2002:a17:90b:23cb:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2fa24063c18mr24573415a91.9.1739225818739; 
 Mon, 10 Feb 2025 14:16:58 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa0942d30esm9207255a91.0.2025.02.10.14.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:16:58 -0800 (PST)
Message-ID: <b2f60c1a-16b3-4b9e-b7ff-b8452408809f@linaro.org>
Date: Mon, 10 Feb 2025 14:16:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] disas: Remove target_words_bigendian() call in
 initialize_debug_target()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210212931.62401-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
> All CPUClass implementations must implement disas_set_info()
> which sets the disassemble_info::endian value.
> 
> Ensure that by:
> 
> 1/ assert disas_set_info() handler is not NULL

Can we do that earlier than here?

> @@ -61,15 +60,11 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
>   
>       s->cpu = cpu;
>       s->info.print_address_func = print_address;
> -    if (target_words_bigendian()) {
> -        s->info.endian = BFD_ENDIAN_BIG;
> -    } else {
> -        s->info.endian =  BFD_ENDIAN_LITTLE;
> -    }
> +    s->info.endian =  BFD_ENDIAN_UNKNOWN;

Extra space.

> +    g_assert(s->info.endian !=  BFD_ENDIAN_UNKNOWN);

And another one.

With the spacing fixed,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

