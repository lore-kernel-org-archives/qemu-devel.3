Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2811AC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc29x-0002K0-0E; Sun, 26 Jan 2025 07:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc29s-0002I4-CK
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:54:36 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc29q-00009e-B1
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:54:35 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-215770613dbso43692815ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896073; x=1738500873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEorS0Q6RAX3NYefLxo17N/iYg8E8tarkgnSIwf2m28=;
 b=Zgf4/i52T5rzxxMlAbxF3NrGup/OtAiRQpmaIhDKv78UK5Wn2jZG7tGj4GXff48k5o
 J04wUfNOJDj7XEdEE0vLBLdTi97TM9qpJiDPsP3wqzIElZkb684GrQQuKdwfjFTp3H+2
 9bjYkLQBF/3isS3YLm/7PXtNey+A5d2bwmibj3CNlZnPH8wZLiw/7wk3ogRjg7F1KED4
 2Y1JsjAZnN167PKlyFLqlZGbXJZAQGScvmmOlMLKEO+rZ878xKM4BicwaTGkqJoeu83C
 +6tdSyunZAxaOIqI62KC7lV9brXrS2y+okbTzjFGq7LOeCKFRaex73/OgQrQJGfSAnGG
 kTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896073; x=1738500873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEorS0Q6RAX3NYefLxo17N/iYg8E8tarkgnSIwf2m28=;
 b=WRZTaKxM3kBZCCTYuFgB8OQzE2QTnyebhvs9cAbtXOcoMD5He++01jH89sed/Yj+LO
 8U/ERLDn5vIiV5iTYJwznvZ/2srtmeqPmmucCI9buquG+Pun0Wal0bTMfC3AcsDs1i7I
 R4SAy0kl6boYtjAaKogKPR6neI4X1Mf8lN10gqatE7Uq1pEuyLiOsyjFyXFGV3cT7Kp2
 tFiAsrjINrq4VumWkeMw4nC/Ztd513hhh38z7MUJfWlnj/l3SUd8VEuDGDIlo8DjPqDh
 wfQzdxLhnFYmU+5lbSDgyFwrk4l3cj0GD3pKNC25+cc3/9jseyPEnqZftXpBwdRrMFrh
 SGrw==
X-Gm-Message-State: AOJu0Yz7Kj6inI7Fd3lzF8r0tm3qCuE1Gu+pDvLhlHAE5AR7it+mh/j7
 lKyBP2voJmriv7oJY2nTkfxPCMDSK2ngY76sPRw0AuiVXGpu86UQ5JcTHBzUESohE+ypSlFUUDv
 S
X-Gm-Gg: ASbGncuTourF+VdK3kfGX9ySgr4kQc3eCCUivyEDRF1l3n4KhOswFE+f73AfxKjSzw1
 Tp97c1CtUTBBajDJLx87e/BEDXMJQkzZZl57h+rR95WwJZu5qKK0KazMS6qbyMXoP6zPz8ArYbT
 PTnBrY29sHTJGci5+/0i5c77DYDX5B3KkKkr8mTAGGZ0m87f9BIdQRwNC95NqB2nsnmMAhbyiNR
 hqvjZCXxkzpSLB3mwFQUtybdAxLLIzvsp35NSelqLNkrzUPbQ4pCQDPePzM3rSjqdZlcCPe1MsE
 rD5Ck1Bv9OBNE71oHIX0jHk=
X-Google-Smtp-Source: AGHT+IHdLvWSYJSL5dgbVtxJoPQjJ/LEcfVHtxNQEkmaWRUOdFiJxvaF02mCK4dXNLMc40MkdfVssw==
X-Received: by 2002:a17:902:db07:b0:215:b9a7:5282 with SMTP id
 d9443c01a7336-21c3554b516mr538187955ad.26.1737896072691; 
 Sun, 26 Jan 2025 04:54:32 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414e151sm45596095ad.186.2025.01.26.04.54.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:54:32 -0800 (PST)
Message-ID: <5394c924-ca4f-4cca-9e4f-3a16f5438fdc@linaro.org>
Date: Sun, 26 Jan 2025 04:54:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/76] target/arm: Implement FPCR.AH semantics for SVE
 FMIN/FMAX immediate
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-51-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-51-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> Implement the FPCR.AH semantics for the SVE FMAX and FMIN operations
> that take an immediate as the second operand.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
>   target/arm/tcg/sve_helper.c    |  8 ++++++++
>   target/arm/tcg/translate-sve.c | 25 +++++++++++++++++++++++--
>   3 files changed, 45 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

