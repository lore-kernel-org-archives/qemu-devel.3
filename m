Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2763AC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvtU-0005h6-BI; Mon, 17 Feb 2025 02:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvtS-0005gs-Tu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:50:18 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvtQ-0006vj-Ut
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:50:18 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso26918655e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778615; x=1740383415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fD9LqmL7B3RrlQc3eY6oCuPU4PSCsjv8sAeE1z+YKr8=;
 b=xkw1h30ACUiN8kA/7QWLSWXgUCJd711vKAKOBVusxv01prggHOl5Lr/0nIOcoi3lOf
 m7aJfDqZWWa6r3XrGZZ8ZT+8mYu+eFNB9E7dRIwXolAHW0UHwNl0tEt79RMX9ejdUyE2
 uv4fuih8Flaa3lZPYrHwD7K6WPStByqb1sAyob5IUz1eT6iW1tvs8aAczcK9/vCns/ny
 fsgS9sydMb0qOOJIWNfZa/lZrSZWOoeaw3L/BGPh8njfQ9IzDT9jzgrwomalvoN6yIhk
 iBUC04LhSqbgKckzFmQHcc9R6V/LjyIZBEzJYGBcK5i15G5+nvBzuw2kq/wn2oW3cJVm
 IxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778615; x=1740383415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fD9LqmL7B3RrlQc3eY6oCuPU4PSCsjv8sAeE1z+YKr8=;
 b=jhBfzTtWDJljaSk8ZJCx++GvZxOOBH4ZmEYSzILFgzAmmChRW4PSl0QbmTE6eMRTxZ
 ShuyHa7HEKCll2Zcaku8nq4KNfG2BdPUjFcZdBDElS7lj6dpEFk9jd2jNPk6MFV/QO9k
 xv2qWQB2tfZEOHTrqsf6VKBXol3X7VDJS23YMN/eKH6Wjoch005kaBDykrYl2vTcG0Bt
 w38L7iaIyPLx9uQCe55+mKuoBZ+XU72/zRJaMLtxULUVtXWGPZcRmgXlJR1ad691HUif
 o/ZCcOToxMw8mRQEhQXc+ynNPU2D3fPeUb9gbuddB49jDMfI9b6ygc8++rFD2ioQF6ar
 nP7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkBl14UiK2fDnEF6ZjOLycFIiKMID1R6kdPpvc7i5YrY6AD0YfqQP0ubwCmvTUgdmDOyO/O1KqBUW1@nongnu.org
X-Gm-Message-State: AOJu0Yy7gHciegsAMvme95nwhQ93H/0553mGEq/0AJUz90SUm4TQKGDG
 M4F57Il61P3Z7gnuMPbXuxAPzeENgRAcyxkosYKuUhFhHmuVyhy3TWeqUJE7KW3529/cGBYngXU
 m
X-Gm-Gg: ASbGncvwKc1TEF6TWbbZlGPreudI0OUSA6J/DFtbL7oqgwch5XEMdl0EW6+zJW+2kq7
 TyxcWyG/KcaCWJX+f5HDfGoxYy7opMCuXGL1dZqcx3K2GwTP2yEFVmEYCjrhlI7YQPaDnSzYQXT
 FtS/2Owkkj6dZoGFWRdezvHvqTINqXJ5ajzuoTq4ZhclocP3NsRW/ZsIIqUYSiIX91fkOmImdSz
 J6GqvEMYBPZn/8pQ8YJ4TtmE7xATgX3p0ibsk9cR3be69pKnn+PaeQd6nTnoe93BBFUQ6RXRtwL
 4BpxtXtUcyUjArRZpNKXVFYjP2pcL3uF5xg=
X-Google-Smtp-Source: AGHT+IEhSTJnA+xuVop9czBpU6yRlKpxx/Bo1OawopwXtIqm0ZuQJQKKoVkvHArKp73A16SrTWEqvg==
X-Received: by 2002:a05:600c:1ca8:b0:439:8a44:1e65 with SMTP id
 5b1f17b1804b1-4398a441f98mr7038605e9.7.1739778614894; 
 Sun, 16 Feb 2025 23:50:14 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258cccdesm11499928f8f.26.2025.02.16.23.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:50:14 -0800 (PST)
Message-ID: <92935e0c-910c-46f9-a5ca-65ec8b78f51a@linaro.org>
Date: Mon, 17 Feb 2025 08:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 047/162] tcg: Merge INDEX_op_divu2_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-48-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h  |  3 +--
>   tcg/tcg-op.c           | 16 ++++++++--------
>   tcg/tcg.c              |  6 ++----
>   docs/devel/tcg-ops.rst | 10 ++++++++++
>   4 files changed, 21 insertions(+), 14 deletions(-)


> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index 62af390854..8f3b5e91b2 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -307,6 +307,16 @@ Arithmetic
>            pass *nh* as a simple sign-extension of *nl*, so the only
>            overflow should be *INT_MIN* / -1.
>   
> +   * - divu2 *q*, *r*, *nl*, *nh*, *d*
> +
> +     - | *q* = *nh:nl* / *d* (unsigned)
> +       | *r* = *nh:nl* % *d*
> +       | Undefined behaviour if division by zero, or the double-word
> +         numerator divided by the single-word divisor does not fit
> +         within the single-word quotient.  The code generator will
> +         pass 0 to *nh* to make a simple zero-extension of *nl*,
> +         so overflow should never occur.

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


