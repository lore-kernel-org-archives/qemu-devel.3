Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402DCCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCM-0003D8-0m; Thu, 28 Aug 2025 13:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdtq-0003bM-8X
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:46:50 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdtl-0001W2-Je
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:46:49 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d60593000so7154867b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392403; x=1756997203; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0a2ZJhK/6NnfaABhjq9SOra8kjPb2tXPi+iLZKsc0Wg=;
 b=OxJvZgocRXt2j5g+lMrqIGawC5fa3kEHtU7QIfkTmDcZCdHiStZK9L/0Z5PfY3IncF
 2hRS4Q3D8lTKx+DrGMoPGC2Mzfl47eJeK6uhDTH/4xfsk4Wqzr9mlbWU37I/1CeqIUwI
 PsouN3VE1PYJaO1/r9i/sOQ2AaEgPR0+6nuRbauftUrgiVZr/4kdhl4TwQfXyZyeAicf
 7mGA1iAfMWtdvZf8WJiHjsljngdfIQku8FAUH0CQjEqo4jHr5LPfD3B5ecdM9mTaWxqE
 Qt5D7UsVMLmJE8s33dHjx5NjYGBoaFGdF1OcGAut5fgzvoe0AcVhjKTTumUfLv+ZNmtN
 rSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392403; x=1756997203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0a2ZJhK/6NnfaABhjq9SOra8kjPb2tXPi+iLZKsc0Wg=;
 b=SWT6VfSK2hQCf2pANklG5sTgA0C6ZdCDez0ds3aQ5SKn1NsLN4w2WUKf0shqoxvy7s
 wIQoCW8mb9GSucZxn/rJXtiPfiBh6TgIYAKEq9jW/40CiMgWVV3X2YBT7t1SyEba1XKw
 x3hIoPIHw6XdiFG4V3npi0XLFnODq0iRElrE7nuq2Z2fsZFJN1o0yBf7ljCRTSIiEOC/
 GwCbnCzOq9N8G94P+PYSGaWvSSjjKfsZnB4/P5DTsGpqcVPIeHmo0PdXiCBHWYm7MRnU
 ts0/DDwTKqJt0CPYT6bkmc0z0gvt7/3drjNIVeW6RWdXRNdF7eXIJ41QB3HvgrsRj2gS
 ZxIg==
X-Gm-Message-State: AOJu0YxxTtEmC/n9VlSF5TP/Aof5hDSqTzGq3y4Mz85PpWHMXPRR3kqe
 PXBoS08HwEr5dLIQ8Ahzhb9oZoHL3EI6ns7Vt++0QSdsfEyCxd9mdpzJZGtmw4qszozdmfOvNWB
 7HkxN54aTgPGTRW1+VhGO9eX9KJ21MG3uylokznZYU+vRlT8q7lNz
X-Gm-Gg: ASbGnct40bpdXAR07JluNF0WSPS3tNEApU5UyZvgm+Y1bxAjivUJIdLY0rm1DIkVpOg
 cov7ZwEove7F2k8vfLf9mi4P7BPvBxW5ZETl+NOqMPmedG7u33Gtm3ZEE6H7WjlchqxsiyNSy3p
 t44aftIgk134W2g+kBZVdZzdMuKSPGkPQIFcZyFWCLIH5Vj6ILXUZMQq1cGocN3Bw70vo+JmXPr
 Up7Y0JjCJDiHOzgos4=
X-Google-Smtp-Source: AGHT+IG7/KCXgUxkU3wwuqvVuWEhl9vtceCaaNtkAgoH1C0Xs2UQOZKqgLLOyr9FdTa4Jsi4Hvh7ygjQ8GMzssXHYK8=
X-Received: by 2002:a05:690c:4b11:b0:720:79a:b096 with SMTP id
 00721157ae682-720079ab5cfmr190297517b3.4.1756392403293; Thu, 28 Aug 2025
 07:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-37-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:46:31 +0100
X-Gm-Features: Ac12FXw7YMIIiVT6DEFE5xRNNiK4FcsQGqbclImcF1UKoVNPv7kSII1QGN0yRHQ
Message-ID: <CAFEAcA9iyp6J6orTgo_ibwa+01tu-DZAcMy57Gk-Jn4YGV1b6w@mail.gmail.com>
Subject: Re: [PATCH v3 36/87] linux-user/aarch64: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 28 Aug 2025 at 13:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a
> proper structure by using target_user_pt_regs.
>
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

