Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B819CD42BBE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvRH-0004T9-0P; Tue, 12 Nov 2024 13:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvRE-0004IU-P4
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:16:29 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvRD-0002X0-A0
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:16:28 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso4628575b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435386; x=1732040186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WxuLnudgs+LMgiDxmn3RS1osC6WEyxk74V0/n0i8aOc=;
 b=hqxiUVYOmHwPpBjeVf/eslyyvoaKkNXkb1/CgF2wdgRxpbXRNs72pwxtNdPykagioB
 tQMU5sYeNstsyOxHCiv/h4M8KNTW8SQ1XPm7hr88DPlWt5vTFkj2Q8rXEvDhaPcd34Sf
 YXW3FQghCWgilUTgIFic/gJBlx2tcvE+hNtk8vLRmGCKLTFf8Vb0iXzCWE4fSo1UpJ2T
 Bd06spfZhMkrn//cNlANloELuBNAYLZhh9ZuvhvJ06d7Gf36CpoPPOiTLIg5Tm9jO2Ih
 teYbnf0Wj3zu58zp6kj3Mz0GnwgM7AA0SYf7iX5cQXc/q2gxBjD5SaAu/7EWN1IgaTsh
 IfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435386; x=1732040186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxuLnudgs+LMgiDxmn3RS1osC6WEyxk74V0/n0i8aOc=;
 b=MUSSSTjMrM73znb3dQu7X7w+7vxxDuq5NXvnUtuogEB5vBC1aX/zXRRhFknFj1eSY3
 2i8cuDYI5T3YZuyBjsPXW8fA03d4rVMUxANzO+9QR52Sy3+p7mNtQvIMePY944cXq45D
 2bsO3aW8ild1kzAsiuAs8IEg1cGtFP0Bb0byq6lRARAqjZ40SlJtS/mGAKOlzhmyh3R6
 4QVDRMXSMGGuWMmyR7T6PCFGGwfjBZnIg3g30lOAEdOzdDxnExT2nPDzpQyO/B5e+dLd
 Wg02c1kGl9ylW+dvdkqxoOxspitZg2cIXGYqYfC4HOXg3D+lTmXLyDbkLoYndWDdJjhv
 ml9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgxp/eFpon294DeKmOU/g4nTK6OZV9UaRqYDlbmgOejJtFDFCpV9o248fbnVwhB/bPFLH9Q8+oQ4Zy@nongnu.org
X-Gm-Message-State: AOJu0YyCy46vGWEixjkTC4gd16b1cCyGNmGBQE5KHYKr/uEq0xTw4l1Y
 nehHpLppznTnD7+hVzQlbU0u/CmYJ1kn53slCmOsY1Dq/lECQK54pyO+Jbkev88=
X-Google-Smtp-Source: AGHT+IGNhLZhUKWVkrN8oP2ziWDwN0QSgw6LwcIt1LLpCQ5KgdsHuLigJf0YSlUi+TVqy9XQv+uVWA==
X-Received: by 2002:a05:6a21:338c:b0:1db:b808:af25 with SMTP id
 adf61e73a8af0-1dc2286581dmr22561928637.9.1731435385766; 
 Tue, 12 Nov 2024 10:16:25 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f5bee9asm10852260a12.28.2024.11.12.10.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 10:16:25 -0800 (PST)
Message-ID: <a26d7e97-f32f-4a7a-8685-fecb8f155f04@linaro.org>
Date: Tue, 12 Nov 2024 10:16:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/mips: Have gen_[d]lsa() callers add 1 to
 shift amount argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241112172022.88348-1-philmd@linaro.org>
 <20241112172022.88348-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241112172022.88348-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 11/12/24 09:20, Philippe Mathieu-Daudé wrote:
> Having the callee add 1 to shift amount is misleading (see the
> NM_LSA case in decode_nanomips_32_48_opc() where we have to
> manually substract 1). Rather have the callers pass a modified
> $sa.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/msa_translate.c           | 4 ++--
>   target/mips/tcg/rel6_translate.c          | 4 ++--
>   target/mips/tcg/translate_addr_const.c    | 4 ++--
>   target/mips/tcg/micromips_translate.c.inc | 2 +-
>   target/mips/tcg/nanomips_translate.c.inc  | 7 +------
>   5 files changed, 8 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

