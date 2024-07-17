Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF349C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1T1-0005yl-JV; Wed, 17 Jul 2024 06:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Sn-0005vG-8t
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:00:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Sg-0007au-C2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:00:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4279ca8af51so41976515e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721210435; x=1721815235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lQoBPXVRCm8cVKkizp8OCCwWgm+D9v0mM9zSAvYKnEQ=;
 b=K2OaxSbnr7V7UWgw/w0+W2yipriCs/0hnEfdyXnt5lrjrVprDwDUuxZkHyIAiPiYOm
 vS9p7VQLU7+6c7/tmWuXlje5b4KV9fEvfG6gyiOpYAbb9XSAVBkSrwpqT1vR/IyTT287
 YJNOp6zBIC5cz78dC6w3xc4S9QZu9aw3zCaG58v2B7Iw+edQ5U1vTL2fj5YYgCQaUjXd
 Du4TZ92vZI5q8LmYTGK1U6UZsrAVLDWvphW2qB7KgbFFNH3krRG96ufMAEYHelUVbbCL
 0xF0nugjS/BHXpP+JMDW1aC6Be1tAzdOs5Wzi2zZjg/d8MyNWQpT7/rjbJIo/qgkMPD2
 hSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210435; x=1721815235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lQoBPXVRCm8cVKkizp8OCCwWgm+D9v0mM9zSAvYKnEQ=;
 b=AupLGI7syV94nDZ1PmgI2XmqA3pVAw4WrRF52/8/CmvmIrnt/R3JoXlDKPSj4VFMDP
 2oGob3R1uqPAB8xXYsFXG1bG+yWbS7ME6P+xsJA8P7P9vMnEVNbLs6bvnxk301CQtQCE
 x1E+F5RZwdQR79jZHKqgpCNTGQ2KkVZmksg4JmQWK1/zm2jyyWpriapfijORvb4wLjpS
 V/sTeidAiK4l1MRkyM61lrKGd/egWpVlTJn0v0bgIji5k2b98MV6IuKLNv1f8EeLZTPy
 gIQojqrNRKuKHirUE6is7nPLbISu0SX6cuIkmeHs4wqP3qStgO1uz9V4Dhod6A2Wgin1
 u6eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmAyDVYbn8b1uOh3TIugqF3hX82Lj9L9A1oIV5xbyI2ZGPGEGa52B/5Lq8LSD7W4fmtyUzAzJXfIFUnZJPEO6v07gDltM=
X-Gm-Message-State: AOJu0Yy8rc7QKRu3CTfVVUcRrOU0gwOtr5/mEmiElQbuWSrVGVASjv4W
 vAv3OFutmozd/Ra/8fmzrvizI9PsYSXdX9wKqHLt2qGOInrV3Dv44fMh6dE0myKxOcf+xpEcAWn
 nJqON5w==
X-Google-Smtp-Source: AGHT+IElJU0NZTzZWZs6uTQp1rVUoX1rr6mBXuH/0zizH6n+n/0ZxY4rhryvzfDJvJyIaFaD8DyOGg==
X-Received: by 2002:a5d:540d:0:b0:367:8f29:f7ae with SMTP id
 ffacd0b85a97d-3683174763emr980282f8f.49.1721210434881; 
 Wed, 17 Jul 2024 03:00:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f276b14sm201024485e9.23.2024.07.17.03.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:00:34 -0700 (PDT)
Message-ID: <fe5ec27e-5d00-453f-a066-9be722b6a5f0@linaro.org>
Date: Wed, 17 Jul 2024 12:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] target/arm: Convert FMOVI (scalar, immediate) to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240717060903.205098-1-richard.henderson@linaro.org>
 <20240717060903.205098-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717060903.205098-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/7/24 08:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 74 ++++++++++++----------------------
>   target/arm/tcg/a64.decode      |  4 ++
>   2 files changed, 30 insertions(+), 48 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


