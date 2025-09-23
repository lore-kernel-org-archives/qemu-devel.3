Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FE0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10Q7-0000cO-R8; Tue, 23 Sep 2025 06:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Pv-0000Vm-65
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:38:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Pn-0005BJ-Ju
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:38:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45cb5e5e71eso34051175e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758623907; x=1759228707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mngKleCI9Gnidsd0PWPOZTV68Cz4FjFjTPVRRuaLC5M=;
 b=ao4xT2KamDx8GexShnO7JML0uTuhL2Lh2Ql8yyRsegYCJvZ2AT/zS16uXTQU3VwZEI
 YMI81Xies6wSEYgmJtrjqOy7guNy2SEu6JE8X+A1MM0Ow6X4d9/dVVM1TrIgz3SMDP/O
 yVxkYQ2/+CsqLiGgN5SslKtry1JkNkzqtmTivUqVzHwi/YILB7S7EtDq4EVMQSbH8IFD
 YZNtSuJghqWjtzZemDemHCEzrXbuCCrgDSKsQlCRjnt++kKwCpji/G+VZAn+Hsddct0R
 Pmnjw0cuy+dD+GTvAtJePnmu7peNV9R6xQB9N8gvOVXhfvLcLOFWGd+M2KFiO8Xtt4Be
 x/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758623907; x=1759228707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mngKleCI9Gnidsd0PWPOZTV68Cz4FjFjTPVRRuaLC5M=;
 b=rX/+TXQ1N/lkkjZ5hRTaqB8zp731hOx05d9ayZ9pLBk1eyD1WEkczZvivQTxlX4+0g
 0R9dju7eTRCsiDZBRtzSLEzXjk4CI1CAGtMwOvkbFim0rW8cmvsxCABy9Gz5PbtFzWYC
 ecNz+XJFziwXHvJ+HCciBUcCvkkTdZc7lzaHFn5kui+80HKJH5yqLT19JzffuhyWnrvg
 xgBHOuctdb313+W7RGRFihBwd8HK7qaP4YOkdh9ZwCp5j6tdiTFtGvnf+qsiR+LhX8UH
 4HWgzN0/780oTx40JG5HvkvApRAdvCbjBaD6MnOvcn7wB+b8Dnqx1K/D8Is+YWc/q6bT
 kqbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxK7L++yRoQfuLqWR61XBxmEHdxkYi+l7yGbFpRCMVCExhO3ieyx8nuB3qdxM4SOeVD+iuReVGvnlU@nongnu.org
X-Gm-Message-State: AOJu0YxoLNTTGZxkbU1FQgX8s1TAdp2kU0lPZGxR3WvAEF0rCVoTK326
 3dPhoRbFlItmhTRjqO1vgjzq8GRuPsFx4zQZE9pUgbwUX627cvPTbpWbcysPwrUmR9c=
X-Gm-Gg: ASbGncs+XgOVwkZpF333Dwgw9FjHbE8NgPiEiwkSsFAzazTkXD4RioQI0AfqYKncvsz
 P72kRMW7f2V4t7YQWcWqa0S88I44DuztRkU52XCZ6WaxWRF9Ls5HwNmKFxsEx9kfKzhIYE1SOF3
 buxpbTxrlsNTL/q3586eW83z55gDqy3QuavR9ChCZHLxKbetRsbivNV1A0J6f5pRX3Be1s2MHfV
 9FayL+MVrTkQFPlYhIuIcb6cLTzI8Mu8jXgIWeKpIfA2Qkw1xyGZHeGkLy9aKFcJOFKWNy8YaQ7
 6cNpk1wlq0m5fYBu7Ksstr2msCz7QaA5Zgky5QNsQeGJAQV74lNHdtfOit03Ix4Z2sBy9nQi6H6
 v6vxb1Vdql4aBYAktk5qCoZnbGCCwSdevH2C+UZAMPFJMWrIcOTsdZcyWEEspIL8spg==
X-Google-Smtp-Source: AGHT+IFY5JyIURDAUUkZjnk5JscR9jCDC7S1G1W1r92oaqZ+ZTr/fPQc4VKBXhdY3Yrh32cwZYBxZA==
X-Received: by 2002:a05:600c:1d0d:b0:45f:27a3:6e0e with SMTP id
 5b1f17b1804b1-46e1d98a381mr17443965e9.14.1758623906863; 
 Tue, 23 Sep 2025 03:38:26 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f3d73sm23151401f8f.8.2025.09.23.03.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:38:26 -0700 (PDT)
Message-ID: <29be1e35-e28f-4f5e-b95b-90f02e07521c@linaro.org>
Date: Tue, 23 Sep 2025 12:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/36] target/arm/hvf: Split out sysreg.c.inc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Move the list of supported sysregs to a reuseable file.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c        | 147 ++----------------------------------
>   target/arm/hvf/sysreg.c.inc | 146 +++++++++++++++++++++++++++++++++++
>   2 files changed, 152 insertions(+), 141 deletions(-)
>   create mode 100644 target/arm/hvf/sysreg.c.inc

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


