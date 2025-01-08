Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF89E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVaCD-0008FT-84; Wed, 08 Jan 2025 12:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVaCB-0008FH-QD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:50:19 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVaCA-0004hI-23
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:50:19 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso22721f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736358616; x=1736963416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A7kIsd7gYlbsy1zdl/SDK0x3xcq1dOTTLR29LJ/El0o=;
 b=NrdL3LzMHsoe0vs74DQG4OItzFZReKCyy7sA+qUFkVYdgmE9UuI5lGXpgB5FCB/6Jg
 qpFUDIrC51ObMXuMU9pJA0k89kZYFybo3QKUrNJfDT2z1neVPeOpjTtB8HKFa2YbhKn+
 kPMcaeb1M5nZf/n8rC3QjmGAfyIHiGGjfgJDn1CGcjUl3qNyTFBM/jFcA7tN2YfbbM8j
 1HKbV7e/h4UflzVSiXw+2SRMEUMJVK/12NB1HWxhrnD7weyp63D2zOQBp7m2I4AZoaSr
 BdHeazyHXclTusEeexxlbGypEFg1goEeFUAfl5v5mOgAloQUbUhsLJwZanQ0vpS/Ktyj
 BNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736358616; x=1736963416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A7kIsd7gYlbsy1zdl/SDK0x3xcq1dOTTLR29LJ/El0o=;
 b=U7LOgr9EmJbq6xlyTEhUF3vPboIjEr88WxgKHY1mYYlaMl/zG+ZH//ZUG0mO01z1jS
 bULvmj1TYUC2Z7tDtheJrDUiHa/wud4f3QgsGSq/ATeDXfNxCpkeKr3np/qrn2tI1WG2
 9W15BbbfibE5I8GAsyD0ENEiiffK2oarNC2lwE/TPHm74qP0oxl0Rz0Bm+gBG6ZZ49qn
 K7YoyK8t/z+gQTxF5QKRWn4HH87zYOW7Z9wlahdlN/hcjAuBJjpPpKT4GuMv/ciRCdeu
 YmNMo1GUAWiUFiailaVZZiO3pe+FCdkyBNplpKfhYqasD6OYHT/wpn5LCna4Zdeltzhs
 /faQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXANExPyPI2Z3TZdCh7mXmTsLTMp13rgWgDkXGzvNQlXSzUByRx9Obe1JHmQfBOgVY17K1CY8gbz0gb@nongnu.org
X-Gm-Message-State: AOJu0Yz3UQpsUOkVOUD9tdiDTNNO0wkJyJ+a6IlrAzYEWXZu5nUQcxGO
 cNMMEMdiJaoHbGKFWGZFbqcZTQ35FumcPxeBPV0lSV9e6r/MweHmTzngB00pW0Y+unZZNESeUHL
 jfL4=
X-Gm-Gg: ASbGncuJxQHxLLQt7JvRBHnX8+ZuAPpopCamqgFPK4hYtw3akAnGBBdN8hycBP1637k
 EOQwjbeZ7kKnsQZmrLwFUT0p3i/jaNaPaHS72U+wum9MVhP1BQI4QX2bc2llBCDiIP7Pln1KWw3
 sauXzQ0MEPH93HjvUn02OX4WaLAgM380wTXnVPeMLXrEyrls4DChYV+8dUSkyB7i99t0rKP7vMK
 U+KZAODwwKUy4KCmLsiW/s9jWKvFeAFLpGnEMZ6w4sOuLFV84K/OgaW8hjHbfB7a9uC2kxtHZ8i
 N8IO2dyarFnr7NSmaW2K/SRK
X-Google-Smtp-Source: AGHT+IHLegbm6eWXLUfFFv0VVKGKzaLsEZgN18kqzFX2WO5IzqtFfh8uVmZGVhX0IQZLp+IQfNJoSA==
X-Received: by 2002:a5d:5848:0:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38a872da433mr3251587f8f.13.1736358616040; 
 Wed, 08 Jan 2025 09:50:16 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd11ddfdsm36261895e9.1.2025.01.08.09.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 09:50:15 -0800 (PST)
Message-ID: <8fbe5262-d327-4d3b-8050-d911db149003@linaro.org>
Date: Wed, 8 Jan 2025 18:50:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 53/81] tcg: Merge INDEX_op_add_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-54-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Rely on TCGOP_TYPE instead of opcodes specific to each type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  4 ++--
>   target/sh4/translate.c   |  6 +++---
>   tcg/optimize.c           | 13 +++++--------
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                | 15 +++++----------
>   tcg/tci.c                |  5 ++---
>   tcg/tci/tcg-target.c.inc |  6 ++----
>   7 files changed, 21 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


