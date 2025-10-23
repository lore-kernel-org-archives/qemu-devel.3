Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3500FCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw9C-0003LW-GP; Thu, 23 Oct 2025 10:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw9A-0003Jw-DJ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:18:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw98-0007uR-Lq
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:18:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47117e75258so6891675e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229108; x=1761833908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3TodHf8EnmpsPsthqYvv0vWl7r5ute3ZM8HcgFFdy7g=;
 b=sYamByhUz/+9NBPFc+fhsmsCuYSSjXpWCnv4sCd0T3rbGEgEoDMjZA+u5H8rUqj3VN
 54u2YcT2nfxnIOye96TkLWM2FuMPobl8PqkfSeWBt3BvSpkNqlILUiP2KiDZzA/KPmfE
 NsEjseStTJcJanlQQZV7vWpKhDY1lckpJPmAOOAxfWfEXPj7nglywdK5piXkef71eFQB
 9dmUE+vxBwRzzS1P7MjTaHhXz1ghiqijR2/LLFNrHwk1RE0HT+NNfhDmgX41BqnkJFjL
 xydJv5UDnVqDdaGsrVrYHwvWVJ6SI0mqd7jIHyyBtpi6HHQP4/3EgohhS/P4lps1h+Rz
 mgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229108; x=1761833908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3TodHf8EnmpsPsthqYvv0vWl7r5ute3ZM8HcgFFdy7g=;
 b=XhftduF6wsV85jYPk2Z8K0lWSYx/h0dnQGzkfqPLxVQJ10RRVLYyu3MRf20fG4OLID
 Qr9l1XV8eEP1Xb8qF5l3raWa2nxBjPA0ZNFxCDHUkv7rBpWYlysfkXk/H31NFB4R9dJL
 Ab3njXGxznXC1Tu23t+a6VsXjfOTqYDbO1PrMKBG/ikGwAQdvzT1nCxQhsaRseYxFPzk
 KBZ1Nl4itJw8bm9tHSQv+ZjZaRR1ONh9fZkYILlBrwr2s9revBy6xd1sXQhlOix2Lko1
 8pqa9eUGBFpPdYx4zFEIAtomUgC3H2mKZ3qxQgrwAHnwRLUVQa3T9qaqVM6hAFHCEqow
 6hXQ==
X-Gm-Message-State: AOJu0YwPjsMAD+qBl6LESTRHyW/CR/GkecJBoj1MIP5HPRrn4d9LTqaR
 YIAjdcKJavW4Oi21yV6+S6zcS/gJniFBo8be/LHlskDKap1m68eTcw9o1VcixZFe1v7l59O1fZC
 GgCxPH0M=
X-Gm-Gg: ASbGncuyvG3xeBNjR10Iso93tl6AIW0UvgPLzPQzYNm3WZ1KAt+pgZHm8TfhFMNuStr
 TgttB+jbz+ALSqNrYl+L+WVOPhN6tiIaLliwF00GygQEWHMJ8gWvc9zXrsjGm3FJ0OQnzMNSI2o
 Qlccm00PS4a+TCmoMeE8SUcX/RESJvsTAXNSLvk6nQzaWQsBf8Ef0nJrgQKSEiG+BWUR+YglWPm
 s0NHA/C5Sd68pTXBwmcd+NFfxHn3obefQhOMqQja/nETNYflmqngZWNcjnsVsPcFvBGTQj41/Jy
 DnAYoMP6nra5/6OxFvHtygnYvNnG/l6e+vWQgOT07baGIp23m+JW8rhvmqWouhPSAX8Q+GyP2+r
 mYMXZ5Cvp78BlViIKIxnRtxzlCh3Y18D0zHs41/vJh1VMpXqBtY6J/mtBc/rO09z4z3IY7gEgrS
 gVYWR6d7GPBWmFy06GhcW2igYtTZWm9jnjjr8zGYnE8FF6xe7pviOWKg==
X-Google-Smtp-Source: AGHT+IHRY5v4BAu1MI6GCLyFqQ9EugRdVX8TXQOiJi7s8XzAO90LjLEcm7uyuoKsSmZAzrrABMTk7A==
X-Received: by 2002:a05:600c:1d04:b0:46e:1d8d:cfa2 with SMTP id
 5b1f17b1804b1-475cb02fa02mr18063485e9.20.1761229108255; 
 Thu, 23 Oct 2025 07:18:28 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae9f571sm41689055e9.7.2025.10.23.07.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:18:27 -0700 (PDT)
Message-ID: <7f18a254-df48-43ad-8876-0331908d61d9@linaro.org>
Date: Thu, 23 Oct 2025 16:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/58] accel/hvf: Create hvf_protect_clean_range,
 hvf_unprotect_dirty_range
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023115311.6944-5-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023115311.6944-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/10/25 13:52, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h |  3 +++
>   accel/hvf/hvf-all.c      | 25 +++++++++++++++++++++++++
>   accel/hvf/trace-events   |  1 +
>   3 files changed, 29 insertions(+)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


