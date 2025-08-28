Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB54CA0FFE
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIb-0007xD-NG; Thu, 28 Aug 2025 13:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureBo-0003ZZ-SZ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:05:25 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureBj-0004QP-7c
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:05:24 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71d60504db9so7113167b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756393517; x=1756998317; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2zdGw5ohVi7ahJP2k23EcXeYCHD8NuEhzf19Msj/UJc=;
 b=FXByKwF70YFqWiOHPy14ovMIaQvpJPqlooLDtW/LM8eYagDDQC2F31ZGeN6VoZCkpz
 AqENqieB5tZpJUhoHjD9GvsIlH9tTzfTk7m6t6iijRCLGCXg8PelR176fplalnfbW2VU
 l3P3y+B9EUeBV3W/ZZJwhbfKvjihirsTbppUYTE5hcX6BhnSatn/IeZMJPLCP6JZOU0f
 q8JjE5UqLSf36lxxnQMiNUeX8NhRCw6Jwwya3LVjBeQtUQePHxaRIm9AsPZOS1+FN+S4
 Ua8mJOxz8kFijsXZOtCIrFNsZmhb7PQ/b/T4bCCAr27JzVXs4JhWCO8z3+VQ1YnYr8Hz
 4cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393517; x=1756998317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2zdGw5ohVi7ahJP2k23EcXeYCHD8NuEhzf19Msj/UJc=;
 b=JZhRfFPwGW96HCPuQRdSgJnPOCRHtZC4Jdz/ZSXsCV+AgVGUlMfJHVW5idUADadx1j
 Vz860ZZPEBwEh3fuQsxEyDdnGcV+ENEML+JOyAurwrRAqT67h4PGMxL3ee88I5FHYLOY
 q9Ez17TjqaFl/0btrHpW/JL0Lazb+7kO+fc22D5qZF3iPbJb56b9ygF7p0n963ppSj0Z
 VblTCemRoZ4ZBw+OAGcBCsQ3hQsC5YOsYFpYyUzVUSueSTedYt2YYlE11hQCRIGUITlr
 C7QJxeZYKpn6wfGXSmy1PSXqJFpKBHaqgLzWJ32oX4pFOq6Gn/Y+EpcNE8a38R1z4Dv4
 KB3Q==
X-Gm-Message-State: AOJu0YwruVLkZLWDROT2WTk06raKlc8RFYvlLKBewfp7VAlRZU7YqqxD
 QpjEsmIqfJEO8tpLOde6soQ4FzHvVSnQa3wR4OScm2XzlRcbGA2gjrW7s2EQ9WzNbqSyPBKQF4W
 dCWT4x38w7ZLejqvM0LX/mMr1buy0nStGcT2tZlZlTQ==
X-Gm-Gg: ASbGnctfJOS1T57qulhgbW8r6kzO4WCr5NGeBAdyLERpQBXDinwvzTTHF+C/8nj4wai
 nsei4tqjp588HNlxSL9ClWergovkH/aiG4yv7N52WzdXiCYdZM0TLve3wlMkNHPDYuy4pEWYjkE
 zhjxGtWszf6F+amhkps0k9sGGla6joSmJD8RFRPqfuiR47IKioDhK9jyFJpy6E7fWVCj2a5+RSz
 Wi3yIhIMsWLFrxE2WqrjjcBDekF8g==
X-Google-Smtp-Source: AGHT+IGMxMnBd0UDqZV8t3lKccNSVrYd8yf/yh2E7M2l1L4woWGCp2pgUghDwWGKPono2eHgVMAOpn4XpyH5mdsipP0=
X-Received: by 2002:a05:690c:6082:b0:721:10a3:6584 with SMTP id
 00721157ae682-72110a36c63mr177207167b3.11.1756393516768; Thu, 28 Aug 2025
 08:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-50-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-50-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:05:05 +0100
X-Gm-Features: Ac12FXyG_oiFCCEI2XJvxWT_k3UnV3QtW0REW7h8eLmt0lW3m4h7JkP1j4BCt2Y
Message-ID: <CAFEAcA8DpE0HquA6QJGBXaiLCPYKUKjVFZoDL5axJJN283Lc4Q@mail.gmail.com>
Subject: Re: [PATCH v3 49/87] linux-user/ppc: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the target_pt_regs structure from target_syscall.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/ppc/target_ptrace.h  | 26 ++++++++++++++++++++++++++
>  linux-user/ppc/target_syscall.h | 28 ----------------------------
>  2 files changed, 26 insertions(+), 28 deletions(-)
>  create mode 100644 linux-user/ppc/target_ptrace.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

