Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F17FAD3FB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 03:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG7Ni-00072D-0W; Thu, 23 Apr 2026 23:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG7Ng-00071j-08
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 23:39:04 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG7Ne-0000qC-C2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 23:39:03 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso3207210a34.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777001940; x=1777606740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fkokHWhee1UXuA7SLIDtK0T4Jl5SahXI5j4binDDxME=;
 b=xu7dVZvXeI3nVLFdqJjjz38Ub9PxXYkCfe3SurmcVemq7Bo5zM9TQeJTv4i85TDR+A
 vKqkfnsHc324xYkri8EzblIPXDxtyd3B13SYj3n++5cYOj2qrhpjox/bULc32cmwf0v4
 Rg0XUc14QTZR1nLgn1Y/jSpWTexyHpK3e9WHNaTSwT51JBqsZMNtv3EWALN9flaF2+QT
 y/13msisS7dv84pSctsU0YifpVrRrPmQtRTP3ejV9T0jihKQ25i9FK6aw4nKXEDj2rPu
 Jrn5VJI3gZ49CP69igcxCQT//GpqgD3FRKQI4IifLogZcv8l1DJUTbV9D0AqwJoZuf/W
 FRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777001940; x=1777606740;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fkokHWhee1UXuA7SLIDtK0T4Jl5SahXI5j4binDDxME=;
 b=E+j+8WxhSjV8vQoGzdEniOYHCQflooXUi9KVBZ2/BVwUkz4rGx/dCizmxedmA5PpyP
 gKO5MOLxnJP0EzQIgZrysujfcpbsZ1ncT4eTvjomMA/JouEOKsypCUwe43HX5/iD+Y00
 /Jxxg7nAhtsWLvFFqjDc3wkMdFbGtInXahJXAaQ+og4t+5LJ7oNixwewtiA21eUk2lh+
 KbONDhuEBLumnm4EJfS0m0KvkmJDe45Exi8ndh52WtRqgaGf7CtA+CHqd4xqk2leD1Wo
 UgaHH9YOnfaxU1LhtaZrB2doAUnxNhRXVGg9cK6GQAJJ6l2xTIvMzdsU2jyfbolX/v21
 YEkA==
X-Gm-Message-State: AOJu0YzMnLyqdc521DOaNNnTR4ohSeza0hEffM9GqFw9gUihQtpazkG0
 wFHgayyrij+F6EVfhTdjMyUQjqqovvHbewQyn1VII93U40Ef4NsYocaZbVfTrIE/HBaj67QXmnv
 DpPkXADM=
X-Gm-Gg: AeBDieuvpFbXsfAMVGkPkMC9OekdKP2gRkxKuX4ty1Y1BYUKcQXo3mfAajbYjdWqy+P
 rmdSaIDq8O1uiofrsZEQVaevlj12yyW59J4C4r/Lxl7lfQErWROB8C5Gv2YtTqTapC3NHUVIBO3
 Jw2+spqYfceSc5qAU1mOyxTKcPjWutNQZjU08hPesYl706biH9VSDvsfRxAIDzoL44rSwhmXy6d
 ErpPZKlu6hH/qXvkDo0FDj3SXxSVZ7A0ROUNI21k7atahOJUeIZSrZGwdA4m1IiilnVL9x1A4jH
 kVa0l9+hm7Jmz93/MyAXhJD7rRH8jiuCB3Y4XnGoplt8HJsDi7ERz1RaU90wdEFL93jmyjWY+xT
 YS0imWR2r0H1/GaNsJ8qfYTVg6D0avlnLwyz9DDLgw6mXCbuTpIzXrMCR7zX0sL73ROg1UEE6H5
 3Ktov6lp7zL2c7N3IotPFvn98la5ci6fQQIRaVrHaoIVagbn8MY0cDCo+asexZpsv20xBIBYY=
X-Received: by 2002:a05:6830:4113:b0:7dc:db3c:1d63 with SMTP id
 46e09a7af769-7dcdb3c2797mr9310749a34.24.1777001940099; 
 Thu, 23 Apr 2026 20:39:00 -0700 (PDT)
Received: from [10.72.56.227] ([172.58.183.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcce5feb25sm10487019a34.26.2026.04.23.20.38.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 20:38:59 -0700 (PDT)
Message-ID: <7af57d24-f865-4fdf-a6b0-4df0f01e02d2@linaro.org>
Date: Fri, 24 Apr 2026 13:38:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/riscv: rvp: add arithmetic
 instructions,including saturating and non-saturating operations
To: qemu-devel@nongnu.org
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
 <20260417104652.17857-3-xiaoou@iscas.ac.cn>
 <aejRC51hrTYRLDEY@ZEVORN-PC.localdomain>
 <4842f44f-517e-44f3-883a-029b8c0ca900@iscas.ac.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <4842f44f-517e-44f3-883a-029b8c0ca900@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 4/24/26 13:20, Molly Chen wrote:
> +/* Saturation constants */
> +static const int8_t   SAT_MAX_B = 127;
> +static const int8_t   SAT_MIN_B = -128;
> +static const int16_t  SAT_MAX_H = 32767;
> +static const int16_t  SAT_MIN_H = -32768;
> +static const int32_t  SAT_MAX_W = 2147483647;
> +static const int32_t  SAT_MIN_W = -2147483648LL;
> +static const uint8_t  USAT_MAX_B = 255;
> +static const uint16_t USAT_MAX_H = 65535;
> +static const uint32_t USAT_MAX_W = 4294967295U;

This is not C++: static const variables still consume space in the data segment.
You're better off with #define.


r~

