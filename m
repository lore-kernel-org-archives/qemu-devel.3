Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBCAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEyaW-00076K-Qh; Tue, 13 May 2025 18:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyaO-0006xk-Un
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:58:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyaM-0003vC-Ee
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:58:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22fb33898bbso77249135ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747177132; x=1747781932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f+I0vjqOWs/SbzRNgV8IUlGqptpf8N7fkihxNxFiO4c=;
 b=oCWqJ5nRZYUp2k1w0ojQzlU84vfH5vTuOmZS5ZuGhaupjaWjDuPju0omp9gao4+HcT
 lb1fe+nGtDCXR33Q4HOMi3k9fwLnDRuSBTQdf7XG8uRHY0cG2/Hngtyj+BJNbcB2t62W
 5omWFbVetq/YHccdjQ3o4opHOPoVKoRJ1dLswckCQ0ppYvtEIm+YG8vErcWRjArtBJsg
 uRUPspuyZXmgpjG872bKUDfwNCd3YBMF/lc5OdwU3WzCxRJJJQlNb6TVit4Hs/UeE52t
 bTAE2Xwgqq+mqgKrjMG5ccJN3A4v4VKuEFo/36FfX9YQCkBi6HacIOwWz+VVuzBgu/FE
 v7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747177132; x=1747781932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f+I0vjqOWs/SbzRNgV8IUlGqptpf8N7fkihxNxFiO4c=;
 b=TVIllGUNkh7+QNfm6bqrIS//grfUN7PtUIGMHeo0QjjUn+/RNDRMRHDhxA4rnXKhHs
 A8LLijEaDe5qoicn+Wb2MJZraFQREquOEFJAj7sOi4vi9mvwtFDYOLNfJK4o002iiJ7B
 k/tr0BlZoFH+JF2ggGjRQ5ripjZ5aAjof0UkEkhzhKrfmj1Phb3LA0IxG/bg/SjUtBnp
 JFk4YzzGPD1xRJM8xRR5fLB6xQGDMrhxPt7NLwWc5MkKaZUS5tqFsdzKhbmuPj+H0TCr
 R0aCKFu5EXyg8b2D7PryJUazvT6osegM53l9XJTLRSYFDAQvMpbPYpvdDLTqpurMZ5EI
 57Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGnclCKwhEGQ7EmOs9TRxmuGGesZzTeP7MbCxNxBxm4eK68oUZksZTjzcC8ITCdQd5j1l2EgUNuUBr@nongnu.org
X-Gm-Message-State: AOJu0Yz0L5WKaEriJ5iJNCB7gdjRY8E1SJGLi/0Ci/JYW8hAI7Dfauo4
 UX0Nardpjw03PQV1t+Cabip36JMQVTRaZNxx3w/YFuME6+nOVbH8uL+TrxNyNTs=
X-Gm-Gg: ASbGnctFns6E4vqCBpechGqNWRHcovWxG+m9v/lsNfqiYAjoTrigT+1UkOJWhnTU+4Q
 haSX3ue5RjhJul5bifxLKtoSVtMSrWT0O6JxgvUZCsIXeAZd7hl+JwRMd9+j1KTvrb4ZbH8v0zF
 IRf4EjbfH3kveZ6swfs+VFJY4yCUMK5GalI17eNNsEp8bNCRGzmWPmGHxCYlWi3ydkSrAY09DWI
 Fla5yOGo3dn+c8zL9peXkMmbsi6jQ7AR4AWKOzyUUyW522h69tVlcMTxpBKg1FYaE/xrQye9KwL
 xs64NN3nyUbJHBkjL06SjPwjTb/xDFEiknkn7mWa28YsK0Eikf2OA2YOm9dcV4oZ
X-Google-Smtp-Source: AGHT+IHiTJva/K28Sh4NX8TwnKpYP9Ogu4o715wYoVlyBZBOS8GlwnUz8bSpF1SStew0Golf2N2YXg==
X-Received: by 2002:a17:902:d2ce:b0:22e:56f4:e187 with SMTP id
 d9443c01a7336-231981401a7mr14226185ad.22.1747177132152; 
 Tue, 13 May 2025 15:58:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82720a3sm86969595ad.149.2025.05.13.15.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 15:58:51 -0700 (PDT)
Message-ID: <d57661e5-112f-4805-8a4f-75780d679fb7@linaro.org>
Date: Tue, 13 May 2025 15:58:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF
 definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250513173928.77376-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 5/13/25 10:39 AM, Philippe Mathieu-Daudé wrote:
> In order to allow non-target specific code to include
> "hvf_arm.h", define the stubs in hvf-stub.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS            |  1 +
>   target/arm/hvf_arm.h   | 16 ----------------
>   target/arm/hvf-stub.c  | 20 ++++++++++++++++++++
>   target/arm/meson.build |  1 +
>   4 files changed, 22 insertions(+), 16 deletions(-)
>   create mode 100644 target/arm/hvf-stub.c

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


