Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF82C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzCD-0003j0-TL; Wed, 02 Jul 2025 11:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzC9-0003iK-PB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:16:21 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzC4-0005oh-RN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:16:21 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-610d87553b6so2773860eaf.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469372; x=1752074172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2cgL/cSEnJMofKGOzbrQfQzqmbHqvCgbvaZQgq+Thjk=;
 b=OnTTwH4X1D7Ic/Yr/THWxeY/hWgUzwv2PSI9622iKvXxhGU6ajf/yYe1eQ9c9Su02h
 lgybvu9/1VfYfLRT2FMeFt/0DIOVT7uUR7csZBa5Rfyw23XZMK9IXWHV3Ow1l7bTe2kJ
 XAq41VxYevw49Y0pXloqC/2BLPsnrHLFQ/VkHwKzHFtiy67oUbxOrSWfgQf1euzm1Pel
 6TMM3DmhevHHLdsyp+zRY3k/7klwKzP5tZgtDdHEPbRQ+NPurCIyigKS/mq6mzmCO/VX
 nD//7KS2GWphbGkk4jiBNEc0oaY0P6Qx0YcmxQhFqRP8y6sezbt/WrqtjzY9xtAXPf/0
 AAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469372; x=1752074172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2cgL/cSEnJMofKGOzbrQfQzqmbHqvCgbvaZQgq+Thjk=;
 b=E2xlIgyckU0dw1E2QRM/xM7BuWuRu0awtfvqMIaLXOUXsyreRU75pqSvTUIHGTaOr/
 AhQz3ONp6lkZim74aG9Ny6UWKWH4zrwwbVZgi61tlCL1Cq/ZsfeVDlYXQaOKDma+k3ZA
 mo0CnvOi1yOGhXxH/W1c8buQK2VW1toZHZtWs81xRcFUJgpOvAj4F9rQosq+OH0FhwxW
 BUTZ24haZisopgradXs6DE2GFDKnkYORGLSmXMjkrXpKBxAc/km3jp+gzHxSLVCRUlpq
 FMatik4bzrsbXJ8cT22ATog2O/888OlwJm4G6oDLbsngUw7mQl77aOoTImL7qIObrHFe
 mh9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvyReAJVoK2x+UH63s6SNQC8bboCeFEIapdJqnJCsyu8Skg7PUB3ISgX0b+sQv2/y7tvJBuH6YeXdq@nongnu.org
X-Gm-Message-State: AOJu0YxgLbOFGCn1JffhW6mzZrDfeoKi/UyBH0UoY3Lky5DV/kdmiSD+
 sGowDlpRk9q4uYh5Lj4zWCxaSfpDHvOALPAwCar9LOyN9OsEK1KrkHYkaqcrmdGZ+LQ=
X-Gm-Gg: ASbGncvfYKE+6ZHnPdrOsHFVtaXVGASjkOk6zF2yaRBB5TsCsUAgjJl7woKo3UmcMDE
 9XNZsjt7wnXOmg7IXKnJ25OSfDpD+CXfBvaAmu31DsS7b/hoiI6SnkMPOt2JUWq/LzMKD5Y+znk
 pVFfzMlMecuYZpQA1lP6PBnK5yZekozPh7m8ooXSaKGvO481oLTih8gv5LKKk7HTrXs68LU4rK0
 YXxebP0UGUc36Cl3tUVM8Ika5IU94EpOzVoo4eMfKLzMmlQ3bNFTAKwE+RUhYUXtdyrl+hXD2Hh
 lSvvC0kUJUwBefd9kOJMe6vjmLpWikhz/sGKcPLrj+IelKDfZdTGEjTCPVSRFsoCA7dIQmlO536
 L
X-Google-Smtp-Source: AGHT+IFvp28NT8hpElaHmTyPHv8UULfLwsY/P0VjYCiUhw9F7jedlacIxrTRibYDecK5piNhcI9kWg==
X-Received: by 2002:a05:6820:1512:b0:611:a81d:bdf1 with SMTP id
 006d021491bc7-61201179895mr2247086eaf.6.1751469371967; 
 Wed, 02 Jul 2025 08:16:11 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b857b915sm1707166eaf.25.2025.07.02.08.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:16:11 -0700 (PDT)
Message-ID: <326bf540-1193-49bd-a2c6-0ae9f6023b0e@linaro.org>
Date: Wed, 2 Jul 2025 09:16:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 55/68] accel/tcg: Factor tcg_vcpu_init() out for re-use
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-56-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-56-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.h       | 2 ++
>   accel/tcg/tcg-accel-ops-mttcg.c | 4 +++-
>   accel/tcg/tcg-accel-ops-rr.c    | 4 +++-
>   accel/tcg/tcg-accel-ops.c       | 7 +++++++
>   4 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

