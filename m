Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF75CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNv0-0008R2-SR; Thu, 04 Apr 2024 10:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNuz-0008Qi-NG
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:18:17 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNuy-00008D-8D
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:18:17 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so1494056a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240295; x=1712845095; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xikcDFJLxhtpWznEYltiS0RR5yx3flfHluguPP/wWa4=;
 b=s/KZFMu7ErZWvzlFp8cx0ElYSSANcKQe9FnlIHg+wn4QMU8KKeQDseAIW8VjEhzXxj
 fKRMtFqzgJij+loKqgJjAqzoa2mONKdHf6fjB36CuA5NYLyIIFnMTEhA2YvOxHNMkswY
 F58KzNkuzCfWBZOi6hgbHHJRQ91nZTHj6lUYqX4LzTnuo47QzPOd0MuJ64EgB5pME59y
 mlaJnz3rRZ8hcuLHJMEWZsKc4h3ffSmWHEB3AZlp+hU98n6KF2C78vbbOKAeLeU3ZEAe
 CFDCDanmMd2mQt7NRlgT01OzV8gggHbvhU7GHHMNIXm3JrSbuCY34F7o0oHzUPSXyIsd
 1fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240295; x=1712845095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xikcDFJLxhtpWznEYltiS0RR5yx3flfHluguPP/wWa4=;
 b=OyKsZn0PCONC6ZF5C29CaNTaaNtNUuIOAvu9/n0luZ3QvxMjEG6iR/ZJUmKVaQJ9rX
 aXlGm2z/7Mwv2LgacovhMP4DwuETvynndgL9VIcs9zC1nqfhiqgYQqUp7R3EDMqTJbHM
 Dj1T2GpUiH23LgEcwacNKt02Eap1ZssgUbucXtSSYzmjBhZp5W1npSg8dZgnMQTbkIDE
 a1WQSk8kKr4t4ZbEkjROCKoYEWt18gLJnhTz2ShrfEPKDNa19aXDqkW7BgXMlz6tuh+I
 /FOUBGafduD0Dd7dMYcT22LQN+ZI5fl83G/IKu0rAKwhNAF00js14w1Jc1OTDk22lXQR
 GoJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWjImwA3rJs40Dk/H2NbFVYwEMe4lpBGIxPXyySG4A8LGZh/ynjo1Jmq/RcjNC4X/u8+2gp1LriyiCp0rfLmemFrozhjs=
X-Gm-Message-State: AOJu0YyFuDCHqJgwCHAxVFez/+ETYqpMUVpJfY0YM4cuGw/R6nbzlYpD
 q4mas3yNbt1ScxB4VsatgcVZMs35EplzZnfjVYdeGnJHtHVjHxoNjGvU37dpyLwy+JdgG6axTsA
 cZ9Rxdzq7IWWk0u5poxsNLKpk6TfNN23uRFfHAw==
X-Google-Smtp-Source: AGHT+IGtlNNhSfgP/UzrZyItQK49KlTYXpvPbV8UuqaQHH2p6hJtJVh8CHDHeS1mO2KO628AQfbHnLGE4M7HFZCu4Nc=
X-Received: by 2002:a50:d541:0:b0:56e:f64:aaf6 with SMTP id
 f1-20020a50d541000000b0056e0f64aaf6mr2111228edj.5.1712240294663; Thu, 04 Apr
 2024 07:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-9-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-9-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:18:03 +0100
Message-ID: <CAFEAcA8sb4w2VHrqFa_t0VjjWem1MJkN=9AwCNV17u==WOev5Q@mail.gmail.com>
Subject: Re: [PATCH v12 08/23] target/arm: Handle IS/FS in ISR_EL1 for NMI,
 VINMI and VFNMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add IS and FS bit in ISR_EL1 and handle the read. With CPU_INTERRUPT_NMI or
> CPU_INTERRUPT_VINMI, both CPSR_I and ISR_IS must be set. With
> CPU_INTERRUPT_VFNMI, both CPSR_F and ISR_FS must be set.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

