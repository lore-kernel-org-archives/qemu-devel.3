Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49F2D6910B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeYa-0000N3-Kk; Thu, 28 Nov 2024 08:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeYW-0000Cg-F6
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:27:41 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeYV-0003HH-30
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:27:40 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2958ddf99a7so741326fac.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800458; x=1733405258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VVAeRceBg4kDWa8wyC1N1NSLrLPkwpjqK1gwXg59Xms=;
 b=nD/b1m56YqyZlaPzgLZHKVCSegA9dVu6I/g8Nl5sUzvoZHNQL/Q0CGMJT1nVmR/4PT
 3ix94hMxu1zpzYSGF7fBDwlxmYtOfoLcySSJP8Bvc2FjcFbghUmJfyGqqzBaHc3PQgY4
 DMpIH393fF/U6HNEKVhjglir1b0jqVo2/gsasmh9v+8uKQ8YsLS6R8lIp9jeYpzzigIP
 TZZwaa7OokoWto/f41jw2GZhOo0TmoXoIe2Dxw9Shf2iUgmyAn9WikygcKXz09tDegGq
 uSCOwbrbqFIYscfpgNNihdti7fVBbuVhHg7ws6DCLVY9Z8BQv9Mk8vu2+hp3MsxoT7ZE
 60Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800458; x=1733405258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VVAeRceBg4kDWa8wyC1N1NSLrLPkwpjqK1gwXg59Xms=;
 b=SSJaILFewh84H5XwreDlFF1giLoNjcbw/jZZaQaKaU2QMoXIyFjQ77IVLShWV/45d9
 EA5jGELqcaHtWZ0OJdnz5IVOOdAT7UQrDxOgEsSEL0pdUKm6dgOmEWoS6yekKmIMcrjY
 x7S1K9XkRE0RaiFtEe+vMUZxeY1qcCdgJ8m6xWHMpxf3RMfaTF+YpGMSeCHbUarWzdsm
 K1oqhl1XS1olXCMbAeXa55z9DMfYlQ4NDlOGK71zuA2QtKx01NM1LvBJZoMz2rHBdTfv
 5i5MzZ1PK2Mmvjyq2Mgu1Gz62zt7STC4WdTt3HqQXtHH1nw16cOxzYimBThId5ecTi+t
 ESBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcXyL2FjekGCroHGZke+f/jrujYcfjp6Oxo12WDs+F3kTzGfoKiKJ3aTmeMhc6Nbv1TVIxfzDbwli7@nongnu.org
X-Gm-Message-State: AOJu0YwH6mlpb0hEm+WidXVNv6CfnITW2sAXV+Ow4wfxumPRJn0dJAFF
 jBdfS9+j2CWKNSWYW1z6keTE4q7mnx7KMgcRrH2Ja24yX3XlOlr4Nnt7T8lqVYeNahU8ce66IUj
 LJzk=
X-Gm-Gg: ASbGnct9LTLsCWadCJjiFmHNePxu5lT77t5/xIF2j9awvY2pVs99nk9jlgyIfeu+wsH
 XCVdXfekXdInA+uOx+xBok9duW/47gSLzEalpY1MazyYnp1+Q7IwNAqo3zI4ja6Qv/KkWacgt9H
 ofIzTGs9QjgrFDvU1ad3grB0ZbM8iamFvdE6dvDC/C1OKUb7r0c1vYVCys1+ExmfcC7+aVe31o5
 6zxhrEWB8/YCBfTriIxaOsaORDExYkXIqRo7opIV3jRR8uDH1qyO83yJfoxfBksn+b1W7aNQXhA
 JJ6eWMF0acFtam6fKpmcmH1i2IiM
X-Google-Smtp-Source: AGHT+IFPSBYRpj+v6mCACr4cCuhw6fECoX6x7+XTai5x1zXl/0nYEi4hYHjG+6piY0hfbum8yjxhPA==
X-Received: by 2002:a05:6808:13d1:b0:3e8:1f54:6446 with SMTP id
 5614622812f47-3ea6dc21eb9mr6860287b6e.24.1732800456980; 
 Thu, 28 Nov 2024 05:27:36 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86095b6fsm246250b6e.15.2024.11.28.05.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:27:36 -0800 (PST)
Message-ID: <34abf8ba-6194-4028-b6eb-61c036630346@linaro.org>
Date: Thu, 28 Nov 2024 07:27:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 05/25] target/arm: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the Arm target,
> so we can remove the ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c               | 3 +++
>   fpu/softfloat-specialize.c.inc | 8 +-------
>   2 files changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

