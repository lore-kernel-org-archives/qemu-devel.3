Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A630C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmdF-0006eF-NG; Tue, 13 May 2025 06:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmd2-0006Yg-E3
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:12:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmcz-0008ND-Aj
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:12:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so58757925e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747131167; x=1747735967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ep73+iR9WQw4cYUZI66lyvkdNLNSzJz4ByceQve2wXk=;
 b=fueVT8m2tLzuJFdr+y721JpvdHA0dHIOQU4M/ph1JVYjRXD4FNQZh/Mrto948exveZ
 esS8FX+RWJtnVexrk+riUCDWv8xA5CvdeY/tA5HlsA+gK1GP3clRC9JlIGn5G1Bcxanj
 4JkV2uIMtqCelZas9e//+aeBMre4Y2usaCzHUbZpKU2K7rHLKwd2H35R19FjZqaWD3dk
 oWpjyG0PaWStSinCbdfdg9gpzmm9VoRFtIXAdZdsPzxCCjzBi5eTD3EylO7LxbkXKVwV
 hCSEeDWCq2dDCdmuhVJEFHMO4ReikNuWlAxfuSMRtd765sxPSlOKfPPCjPU8Y649CDew
 Pscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747131167; x=1747735967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ep73+iR9WQw4cYUZI66lyvkdNLNSzJz4ByceQve2wXk=;
 b=nNsK8vCpdd++tnWTC1Du+LHbZi833iiu4amOeYh7PwSOYMxxhoCYo4GJDpESFRJt6S
 4Th98Fg3e6UFbpENX2C7GdY72zoaHs2wpMN5PdyaU/Hkzx5ereuFXncrdpJevCjdmVUY
 CK9UYADWoSBtTQn9Jill9LBjafbTSFDzjH042Iota+5b7fxQex0Sog94SQnl9sjbhvOm
 6ZF7CRbRNYBK/N/TKiFFzNTPCsK3bKWTycbbmVCnl8MgOkABuRYb1QN7ket/QpuEUZ8D
 HhyDy4wkjQ2UDbum1svjYVdz446Q9kF5acpaxIOw095MrS/sWKADsC4V2R3PH8WETnAR
 VONQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0FVSiig3M5hCFN4r2axN/dC0c5buiAbErhCxZ5JHm9OuUsbis4UrRRSmIUumLY+/3R+3uXlCveM8B@nongnu.org
X-Gm-Message-State: AOJu0YwA5Y0OdrZexvKftPipvVVNAJpZkxIm0k9ecX+kV54xX+fBhyf0
 NqfdvxMXQS/HE3d12r2089xu8clTqa3+UPty6w6V7sScW5MGIMe2qZpWNab3tqU=
X-Gm-Gg: ASbGncuFvnVULADuTkW2WHxYxdjulNP6mpvujAF0lqVTwvoOTlIbFnvFwLWtXOOfZZI
 Mt/PaQJ907A1asq7wHn8AoUwxkB9rQj6fC1AQxHv2kN4BYYecvAdoiIttOgX33zyxeYJiXB5gUC
 D5QIf7qjyeY5Bf3iywco+SNHIcLYSaN14P7rhZMRocUnrkZpKeV6BZ1U1LHYZQVsyhMgRWbJ9By
 wuhsiNT88tMz0UlNwbeEloOm+PA7Agd/VG6frwgWTR1mf/nO7dqsLyBW+viwqi+rk1ArNNZtA6F
 FdgkkCFAo4jcM1S+Y6WXUy8PX/uoCOHiylXL/nrqF++DdbMdtSikZNGvO6s/5FmKCC/sjLyDTsJ
 2WxbCUAxaAu6TW/mp5A==
X-Google-Smtp-Source: AGHT+IGlvyyiBeyR8RnzU+5gL0728y0wVMx7KNEseOzxv+itBz68UxqnZpUnNfrcA8ai1zln4TfSIw==
X-Received: by 2002:a05:600c:82c3:b0:43d:160:cd9e with SMTP id
 5b1f17b1804b1-442e9f4a297mr43907375e9.17.1747131167445; 
 Tue, 13 May 2025 03:12:47 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd328535sm210133285e9.4.2025.05.13.03.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:12:46 -0700 (PDT)
Message-ID: <354c9708-39e4-4106-8333-34ae6cef2bc1@linaro.org>
Date: Tue, 13 May 2025 11:12:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 46/48] target/arm/tcg/tlb-insns: compile file once
 (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-47-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-47-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 12/5/25 20:05, Pierrick Bouvier wrote:
> aarch64 specific code is guarded by cpu_isar_feature(aa64*), so it's
> safe to expose it.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/tlb-insns.c | 7 -------
>   target/arm/tcg/meson.build | 2 +-
>   2 files changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


