Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A544C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz51-0004it-Q5; Wed, 02 Jul 2025 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz4h-0004W0-DL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:08:47 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz4c-0001qS-Hb
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:08:39 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73adf1a0c48so2384355a34.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468911; x=1752073711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SromJdYWRi0IX5meBNfxmdgHqbOvzVs8/IQzgCqHJ1s=;
 b=BkyZTTk959H/gaMImXl5lVfmDV6znjYkmm5zS2C8DdbtUB86FNbRv0/8KIpyT9Mm+R
 GWHYEiWYFBMkGfHkOk1o1LQ3bv/q2EWChbLPx8a6A7HqEcF2YmhQvQZtvOdNcWVw+bIL
 ptHPW5KeWz6cGqDMUrLGmImLKfZB4KIgQ9WnkYUJjDAIPQA6bL7+BMsID5fqFf61yuLD
 rWaKqVvUvGsrk7+VAqv/HKoi8NN8xLlogVzHwSIr3QcgR+MRRTGpERKKga117l1pAntA
 0pvw2CXAOXeIpAvzelg1brNJzgM1OBSyjfqryemDxJMtAQELbkEJ/GrHKipR7ECtNXEk
 G2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468911; x=1752073711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SromJdYWRi0IX5meBNfxmdgHqbOvzVs8/IQzgCqHJ1s=;
 b=aHRzyCNHoum+pW6GlG4CAOfzeQJ5+Xd/z3tOiNVoIKvq5DIoZtHxIiEdoM508GHR4R
 hgvIADIPsO0XIAJMC59uvmA0iyqqmb9YJFFFzUZrAqV0cBZ0juQwkO/kH8ZsU7x0Fk1q
 CU0QC9i7KYH2I1wUEGuchBOf2aechWFR2IPRmP8cvLK9ghJsy00EFekD6Off2K3XDa4q
 kZVi2LQFA+iBk7Y5TqXvnUgH1pFwqvjoAwvmzUH2zfSVlHHFyO6HfXZeYaWL1pndOUvT
 ke4Z2Na0UaOl2sP8dlKJ03CL3e+blAwz0fEtoGPJiD6y6Ag3pg+d761u0tPJ/3NrlCYT
 GRtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBAXXM2O0TyMvSN8FhS/QHZZp/cY5WtmUNHVxGrHUVPNJeRV2Ot/BNYZkg7d/5sM7K2AF5if0qebUG@nongnu.org
X-Gm-Message-State: AOJu0YygmsHtsZ1XFLqPu1yrjUvoBeRtEidVWNegovg9LxT1/RVxP6BP
 ZFf2PN/SCUI/2bn2ruXMbAQzQ+3nBZPBLCoOikSA0TegeAxpevVlgt+98sDJI5R0oTk=
X-Gm-Gg: ASbGnct8FZnnEZnovpMIrUkKFVnhqwRXDZdoyVgK1iwMXH4Z+mf1ekwcnoNFdXGiVw6
 hPTbquZI51dIN7Hj2QbvmaWq8Jd/ucXrNkQuIxaEFH8aEOUgY7HhgVRsQhksuwoZIdYz9XMI+QQ
 wv+ZGHGhE34AI5ajtEjO+VVjIiWw+HXrPQnv/48PG3vj+yVgfxtbwbbYlxF9k6Ch2cPlL576M4r
 Di2NWr6p/Rfz8RQinPwCIvwS3DOk95K8Gik9j9P/rs4Olz+8E1DkQfcdPG4wL9WsI/7T0NWEAIK
 33HnpJQVrfT7D2YuqkQFpLpgfu6tQp1QnPc11500VxkpRvhOp57uDNNTQwY6crnKdyLyxJ1tH0x
 b
X-Google-Smtp-Source: AGHT+IEA/Hg00qL1JMoo3l3nBie8IeGVDrUGYU5EEH1jNBgXuhwTdPsU+Bv6ZoezozqSWXRtGroXOw==
X-Received: by 2002:a05:6808:1c06:b0:40b:af9:b32d with SMTP id
 5614622812f47-40b887479eemr2301180b6e.2.1751468910934; 
 Wed, 02 Jul 2025 08:08:30 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243dc52sm2561319b6e.46.2025.07.02.08.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:08:30 -0700 (PDT)
Message-ID: <cddc07e4-1fe9-48af-9bb6-a26e380d0490@linaro.org>
Date: Wed, 2 Jul 2025 09:08:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/68] accel/hvf: Move generic method declarations to
 hvf-all.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-32-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-32-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
> while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/hvf/hvf-accel-ops.c | 272 +-------------------------------------
>   accel/hvf/hvf-all.c       | 267 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 272 insertions(+), 267 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

