Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8676C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 09:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZRrX-00046j-Ee; Thu, 01 Aug 2024 05:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZRrV-000452-QZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 05:12:41 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZRrU-0007bN-8Z
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 05:12:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3db22c02a42so3833548b6e.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 02:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722503559; x=1723108359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AikQYzZLvJC1qAr5mnVkHuc3qnQ4VJKU1Kq1tgMFSIM=;
 b=nbT9k+WjWefQzteKB/+UH8jz7b1pVIaPtY0w5xBX/IikmIQugzOcMHYBEnxzvwRtIl
 X3qDticvqHrwDs76W6hV89CkH6RetAGWhD9W1f5uUAWxIX3tP3inUZsB34wrLZvDENZa
 H67aGb4kKwLw6zZtWLcgocITSfzo8raaoYyvgXkKB5Z5PrrIe5oS5csDXnE4F96Dzi90
 xHuLjR2LIfv8HwJ9V57vzc8277KbLkiNwLfJDR6RQi4lbUN1lDwFamdjvFJ+MhYCeRb+
 78VQqYvOl4/P98ETSEZbM8+S5B6WQuzuHnPDdVynrnDU48BfvSYjPJHWwEWGaodLjJya
 gIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722503559; x=1723108359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AikQYzZLvJC1qAr5mnVkHuc3qnQ4VJKU1Kq1tgMFSIM=;
 b=GVRjT4CubogRFmW5kCytgxjMecNjoQUzjbBsEeXf1tfhBYD3Lbmc4vAUwRmpEaRPTs
 JIV6EJP3ozmBGfUBn/yxmvC1He0oZlIumbPxFbrFFSLf3/kbgefwHyQMUesQLSWxlFOV
 3hvBUe6duLgztRoJMisIb7i70Ilf8QfhjaboUrO9oXhe+HewL+C0Q0/TKH57RqMSXf7X
 4fmMAPEjVjlsPt9dLyk+p8ctIynZhPGVnrAV6R3m2+UhzXXmtfwcU7YqFQ2Ft5PAJEvK
 yPa7QGliiiVNEOagRR+iEYHfchvTDDXXR/dLpZUTveZvokAzmm7X5s88Jn5R2bI0HF8j
 j+cA==
X-Gm-Message-State: AOJu0Yz60IRrTJtgAjAOTFBp48W9+YCCRLC0FkSFut+26m0X7B4IitO4
 xWb83IM1GX9bfaIYaCVN+kKdxgaLrLlVlc8gYho2LTquhXxtW3Iq8nNw24feYoI=
X-Google-Smtp-Source: AGHT+IGyDLpEbphrYhlw6NBYr9HAlQcsgGSDRg/8IHNyskHA+N817T9Fzjcw/hLOv8ICixlPaOzGAQ==
X-Received: by 2002:a05:6808:3099:b0:3db:15ed:2a24 with SMTP id
 5614622812f47-3db511e5cabmr2090494b6e.24.1722503558642; 
 Thu, 01 Aug 2024 02:12:38 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead890eeasm11113934b3a.154.2024.08.01.02.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 02:12:38 -0700 (PDT)
Message-ID: <0cbb34e8-fa32-469a-a516-4f9ac91a6eff@linaro.org>
Date: Thu, 1 Aug 2024 19:12:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-devel@nongnu.org
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-6-debug@rivosinc.com>
 <ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org>
 <CAKC1njQJiNHT1b2jD009zsNeXrUZ9OG2S4VTeFmnAS4c_f-kAA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAKC1njQJiNHT1b2jD009zsNeXrUZ9OG2S4VTeFmnAS4c_f-kAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 8/1/24 16:59, Deepak Gupta wrote:
> hmm... you've suggested below to use `aarch64_tr_translate_insn` and
> check if it's the first instruction.
> and put the check there.
> In that case I won't need FCFI_LP_EXPECTED TB flag.
> Then I would rather use it as FCFI_ENABLED TB flag.

You will need both bits.


r~

