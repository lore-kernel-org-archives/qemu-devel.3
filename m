Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BF6C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJHm-00032A-Na; Tue, 06 May 2025 10:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJHl-00031A-5j
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:28:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJHj-0008Mt-Hw
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:28:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so5102455b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746541717; x=1747146517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bMPyqqctJRKXmx6qPaaZNnXEXcsZ3fgKNTkMa1UTq/0=;
 b=FtnG9c0XYkNZBaBO4HouOEJNvveZLDhu7W/0nCs5JIi0rdM2ebbdlmEmsOnlRWlAk9
 1KZT9B8myNPc2aRtyZV1rYpXeXAB+24Tex60mcKk7XNyzNWyDFW0eoesVAmA5upVq5ih
 YhoXqIgt1UN/z7PEt6Tvv8ESrczTXfUUcLc/7r2M9BO3lhSudbhCkx6eOIHaowaXTCk3
 mt08zEvFEzldscdayDPp+Dp7UxmuLjqnmZf4yRV1go7bUXVYutEbz/fW0PfR8iZ7txAb
 aZx/sBaHxB8itI23vTeCh/UPEMKzHUMB46eUqXPqSvGuVQGznd7D5ZHXv/j2LJXzGZMU
 mzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746541717; x=1747146517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bMPyqqctJRKXmx6qPaaZNnXEXcsZ3fgKNTkMa1UTq/0=;
 b=OmL8eh22c3oPm91X5zyy2mk1YntNxSgeGoxl8WbbzBjVVJ3qD8w8j3aaJCaS8HZUmd
 2C4j/R8D/EdXQ/5vGFNaVKq9WFI11dsN/NcocfkDvxkHLYOEbjoeJeB8sXVDipE7iHYZ
 cPoN/CQcGTeGz0jzsHhHWpWv94r+7a4PoGDD6vbbES5wYW1IhyWOHdugNEMqUzc7SZv6
 YXGnxnO0T9r/UiPC/LYhKpkOY3v4hBYEsw3BqPhHTG6wdBiXnHUtNNZBo/MRlxB8oW57
 Be0t4+wDB5MHIvUk8r6C2IALdvXTw32M62jgn5Oj2xO9Emp8Xt9Hrz6hS39T7sPNMuua
 AKTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnsQS1NchwI99weugI2xwJ4Owqw4ULTCp0RkwK724aGuqDBGJl+HExAY+PzJMAvTXrxudw3wJqlrvH@nongnu.org
X-Gm-Message-State: AOJu0YxH/4xoOtelsRwJPBr1SvaThEVX0uWBZIbj0Ys6JIsCBANOtFtg
 rLBN0hPLsP5ezVTmdki7vz8dwn7uavXIqAA23Z5SeNS25BH85LS62xFyDn6pjkA=
X-Gm-Gg: ASbGncv1fT8pHqKfMPX8pzx4Yl1mhVQZn7LyXqRD7zIJxFhzd1WzVYeVqhRL8/cTMI2
 NxN8vQDFRx/RFFWHR714wSQtBQZswef436B2sI5SKXXw7tL3O/KsCMHl+GMlz/eQzAg4wyowLiV
 ivfsqcpdQWSYQY3TGZBOEs66mw98IDYikK38+5ciSCoYnsyLVWvyeug6rGo1nI/8Daswmzdve1G
 ck7H5kNbyzXCK6zQ3VgUiYHFFrdmSqwvOZWN+MWHHeY02kf26MtA3Rwp6md+GqCWE4+8Imhp7pu
 HqXl7c5rXmj8G0PSCXYToBKhcoKTVJy/XNZAwRWoniUT3f4dDNHEeRhbhcJqE1CIgUOtPw6Ls8i
 pRF9z1DY=
X-Google-Smtp-Source: AGHT+IFkACUswVWWtARWPDjK+IX4zNVwmBH/D5cmtDpJYn2aeM1KH+eEZ8Js0pT9+YQ9kx8GApJ7cQ==
X-Received: by 2002:a05:6a21:9981:b0:1f3:33c2:29c5 with SMTP id
 adf61e73a8af0-20e962fa3b8mr15015753637.7.1746541717650; 
 Tue, 06 May 2025 07:28:37 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058df2a6csm8979563b3a.81.2025.05.06.07.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:28:37 -0700 (PDT)
Message-ID: <c57928b4-e6db-43e3-85e2-02f055ed77b8@linaro.org>
Date: Tue, 6 May 2025 07:28:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 47/50] target/arm/helper: restrict define_tlb_insn_regs
 to system target
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
 <20250505232015.130990-48-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505232015.130990-48-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/5/25 16:20, Pierrick Bouvier wrote:
> Allows to include target/arm/tcg/tlb-insns.c only for system targets.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

