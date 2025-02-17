Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081ADC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjw2b-0000oj-B9; Mon, 17 Feb 2025 02:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw2Y-0000n5-O9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:59:43 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw2X-0007b7-6n
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:59:42 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso2876002f8f.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779179; x=1740383979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+xIVwoZZaX1sJ4BLjYGjJArJ9gBSPStcije6rAiTut0=;
 b=GOF/3ZcIQTpZHSdQ2dOV6WEsBpREaVz/9UuDKqaIncAv9Hw8+fYrB8eFPbpz8UumFg
 VzOMIc0JbrclO8376if6ZnT8S86Wzl6A9ngsJrpkJNP9F8KZywxTdBh5ZKqXD0jAnvsR
 tok+L8nqcA/gZeLcO1f/P+Rjx8P0H/UYlj7nVWtrX3bjGFg/tiQFNhtlN/zhtdkYdHdm
 iL/dciASkHG0QbquoHWvqNQB4KP7mkuXFspUltBoFhuOkLg0gTjLaHo/dlcBK5m32dU8
 x/gbtOSkFkW7LCTuCLVYWdFqvcEvkdLLRKTTC7aiMywQo2SqSDr3OWGasMEGQ8RUYTft
 y9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779179; x=1740383979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xIVwoZZaX1sJ4BLjYGjJArJ9gBSPStcije6rAiTut0=;
 b=EwJ19/44jHsH9jw6nQo8ETkcGaMtBoYcn5WZugbqn5cy8Nhd5fw1NnlMghE3ma1+Tw
 Whw37rPc3PMKlkWQNxRaKHQZmN0QogMy8o+GL1Wa6WD7ndEPVqrxVSYDuK8N4yN5rxa8
 uo0rOG1KyrYc/TfdJrC+/pJiya858nTNDuR9Bl9Dlkf7nlhONdD2kfWF+rDXlp25ti2i
 X62TZSCGalf5tqn8GTF7ka8W0iKqp60zCPRHmMf7qouXLF+e6gIwJzcnBJ9ztvzwsJ/0
 AKCcu/PoLMWnMEimSoMHskwfjL/EVtaFWUq+KJsmRa7Loohx0cMsbNAWeZ9KFPcsE/AL
 eKLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrmaFtW2cj2vAdxO7sGySahFPX4T65DHwp7EKnZHsxgi5JIA/2SpcoeJILsA8lMeMHwZMGxAxPfvSX@nongnu.org
X-Gm-Message-State: AOJu0YxmOelCXrZWZ9OqK2iUKAKaMpybEunV0H4YPJPJsOgqUjDlmwy9
 BXZBowVuJtHBF6r+6glpJ+BA0p3qsjSUl2eyyNoqyyNXIko+o4NNSGf36UjxRKs=
X-Gm-Gg: ASbGncuUIAsrNnL6yi4OE1sGu3p+2CxCwiPz7GbXsd90M1GcHdaAflp04P2mQ0htWNC
 I3Af0AZoSlxLdWVudmxtYXqVMtAqsf8aeRFELsvCH4//dG0nEZ16jvLBnDOm+hEuGndU8NOeLUu
 0zF4O3K1QA+keYetf2AhYDrT19PyIWAtsLQXaUQZ3sh380cbn/DFwAURGlL5/jvx7QaTI1xh4Ny
 c+BZt81Tl4XFsgNcf/3c6dSXY5zpUoAOV++EtCPAgmzB1e9hp6Au4cAyfdHdPdemJOn63Oe9M1W
 VJKy4wBtsI/bdPlZVW0egPjxQglraw==
X-Google-Smtp-Source: AGHT+IGsE8Nb7EcbVdc1dshRFallr7vMaFQ5drH2jXMl2g0TyBDQWbELroe0p4232lsmGHqBTpIFxA==
X-Received: by 2002:a5d:684c:0:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38f340677ecmr7263124f8f.38.1739779178051; 
 Sun, 16 Feb 2025 23:59:38 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5eeesm11641228f8f.63.2025.02.16.23.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:59:37 -0800 (PST)
Message-ID: <fbc454bc-a262-4ebb-8087-9c9cc8f6a0f1@linaro.org>
Date: Mon, 17 Feb 2025 08:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 064/162] tcg: Merge INDEX_op_ctz_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-65-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-65-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 10 +++++-----
>   tcg/tcg-op.c             | 16 ++++++++--------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  4 ++--
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 20 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


