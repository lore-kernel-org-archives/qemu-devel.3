Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF5CCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIa-0007qa-2u; Thu, 28 Aug 2025 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdtZ-0003WM-1C
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:46:33 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdtS-0001Qr-8B
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:46:32 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71d6083cc69so8851347b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392382; x=1756997182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/PvnfJkYlKRQ+gNghYmvwVCQPAaYQQkcyCTNgaBZ/AE=;
 b=Eh39Ri65QZzUb0V7ZCd8zHEOPeW7Ta59mJECQnTlcvUM+7WQy6SwGdp06Mfff308K8
 eJ0/BxpWxG9duBeLeve5pkqvmfPK5zc6AaLfBux5IcPDWG3t7DHcqrYW8ABbPiw1hUiR
 CSfaPahvZoIb6fVyPL0MWHzs5tyLQacVTg7WHD8XAskgQy88r2IbNCd/TJrktxzSUA/1
 UEfqREZSCYhYzyHDMeMlwMTWubs9GCn+6FjSc5NaJ1oZ69FpYC1Fytq8vZ/zIedyDXZ3
 AqIxd8mG+YSKpiO/fUd2zayVSdzr2vicHj0Gb2bZQ8cF8+ItIF1WDokedJ5xYaDttdv8
 1YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392382; x=1756997182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/PvnfJkYlKRQ+gNghYmvwVCQPAaYQQkcyCTNgaBZ/AE=;
 b=ZERo96P9/HQDi9arhUnq+RHE+DCZvC21XJF4+kGUXga7kViy1+DEdExxwzTJCiPzLk
 uAmXeEWaT/8TJvO/2b9bKqV/uNH8tPK0hv+d4Iy4xvqZcWpNnZ/sXDk2GeDPKud4dGug
 GrPDVkPRbLguj16XhhKIsAGZEP7qoAqobvr5Pbje0A2wu04oD4YmBdWTMLMwu4Ux9+8O
 va7XCN2ble1e1taFmXi39TH5+O8+XZU2ApXOtNjpiKtw/48VWJiImbWw+Xf7+ea9cqZn
 PI+jccYXUjiDzYSJAq2VWGc+gxAclS9JwausXOMsbbzpUolEBRBl3Qxl8jD1Jm6wXrle
 mkRQ==
X-Gm-Message-State: AOJu0Yy2k0yeicvAqk4WqfvduKgZ1+UoawDXDPbjdtniPOMMzw+YTy5K
 ecTz5vmuR/MMNsv441kIR+4EYdGPBFDO5iAFd3+LhEFkVFBZWGKlQFzzRa0FywYSLysfQlzARdv
 pAOa7/Z4f7IwzHtKq/PFBFDheZGuxmIAZfFXt+jrlwDGeO+Y2mciB
X-Gm-Gg: ASbGnctHb1fr7smo4xWckQs7cqBDzcViCXq+UatMB1pHKC3wiqxKPrG2WW7Ad+JdQlN
 xiQOwmH7IVCirJyXEdOUWojjuuNCY1uO17Z/1A9+aSfBBxW1U93WfHHOh8+y2ZV7NxNmhdjJIXB
 IZbRldYVZAXZ1U6MdqHE5rN66WH7FeGVeTXxVVccM33FRSrPT5EIXlxdKEfJLYe4HQsGvXJQZAQ
 W7/8Zci
X-Google-Smtp-Source: AGHT+IGIduuEv5VLTRDvkyfJ5RUe2Yyn37zynFxZjnHIEaqKnmlbF9hqBF5pTdOpppR7rHuuhryl6BKIFVQNj9ljUpA=
X-Received: by 2002:a05:690c:6182:b0:721:30a5:3bf1 with SMTP id
 00721157ae682-72130a53f15mr113791317b3.16.1756392381747; Thu, 28 Aug 2025
 07:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-36-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:46:10 +0100
X-Gm-Features: Ac12FXylQO5xV7YftUeauaDoiQJzXseJKnS19U9HkYdh1n1ht4H_yijERTeb_L0
Message-ID: <CAFEAcA-NPu_6b4RFVPwAfneC6spPpbqBjzwf0VQpCnG3xcwT=A@mail.gmail.com>
Subject: Re: [PATCH v3 35/87] linux-user/aarch64: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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
> Move the target_pt_regs structure from target_syscall.h, and
> rename to target_user_pt_regs, to match what's in ptrace.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_ptrace.h  | 14 ++++++++++++++
>  linux-user/aarch64/target_syscall.h |  7 -------
>  2 files changed, 14 insertions(+), 7 deletions(-)
>  create mode 100644 linux-user/aarch64/target_ptrace.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

