Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA71C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 11:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWVZ-0006Cw-Do; Sun, 03 Aug 2025 07:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWVA-00063Z-HA
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:03:50 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWV8-0008TP-MH
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:03:40 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71b49bbb95cso20708037b3.1
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 04:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754219017; x=1754823817; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PsS9bterW8eXNKRZMdVXehhUiuQZvFFrGXd0hHuMagw=;
 b=Z77ndl93zd9/UkaWW4rtYoOcoKbBmMH9mbNMBybOYgFjzUAMgnS0BIhF1DAPNdY43G
 O7EFfeiN/FWyNfRIkTGHIPL9SN2NjIkc3fMOt77Jx4Dp1PPv/KIrpprATqm3lOr7oHLq
 iApR9vDvgVKiPjfckQZ/+BUdfs2fgbP7MkkFngEhNBffQggXB8swXDAYRLlG0qie2acL
 2U5vlJFSTOXznDWrou2nKW7ozG73ShlD1zxn0ituen7C4EZMbOMRvdqMK7m120vR91/m
 Sa3RUnYCpBOQ7A79W6BI/JuxYfNk6qY52hNEV29A9q7Nm8IrQMjYc12ygv3tsFPTlmYL
 uA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754219017; x=1754823817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PsS9bterW8eXNKRZMdVXehhUiuQZvFFrGXd0hHuMagw=;
 b=epPar1sa+4juj3YDeZXzps7dwWxtGieT2M0okadZ/EqxpEHNogOdaZriVUJaPz64K7
 /OKLtWxtSGUem6wshxUSRvGE0cqx/dTb4oK/g/2eLT/N1Vhx8/mP6Q/dLC4hU7DUMkTD
 +MxducDrdNXThqRzg9Id/ICHNc+nQR2iHyW/Bc1Ar0jsrf3Gd2FBWyhY1mGhkLxbZ8sZ
 Geb3/UizTQ1cwi5hdnf5BCVZMrX6AaVJF+LdR9/HF2UEJxsqWXhgZp7HvhuIVQvToHQR
 y8yJm/gWorYAxsYkNqK05P56wXbdvWkGyVD9r9YRT+sE/IJ7BggGohWq++fKv1SECjXH
 hhUw==
X-Gm-Message-State: AOJu0YyGpgrl+xfozyr87HmDr7GQwY9vQR4S093poc/FlfKmD+uRTXLl
 juWfP4VQWEZZ5X0mWvVjiGehQM9zWPX0WhtrBlmLUHfuQoBoeey96hfAUFlhq/UI/28Xbzy5a22
 S1gIeNtUipqIjQve9fxteYLxRYo/oUGWwevVED3UxEw==
X-Gm-Gg: ASbGnct0ZrgJj4GSEHxY//ZEcW1rCbxjkGzd8ahWka5/P2eIR5Wv1W9s50F8MWcUUYB
 frPo9n8cTLKqJgzLZzI8qKT6IB6JVdPU9DZyzCF6opzPlMd5B6UQABHiB+FYdf+rj1YI9ipjeC6
 TO4cfddxerJY4zZPm/A/nb4ZBCQaHK22eNYTcVoB0vIxD9f8V9sENNarRCNywDMpOV8q3I0dnnb
 yCjJRVTDgB6ltd3RS0=
X-Google-Smtp-Source: AGHT+IE8ywBJYx77GTau2VUOoxc4Oho8Z3rE9MY8kiGtcKFnQ6cCAgppKWy5p4ZXAYUC62zi7Cs4QdYMpazocYDs7Jk=
X-Received: by 2002:a05:690c:6707:b0:71a:51f:81a7 with SMTP id
 00721157ae682-71b7f3f89cdmr71926117b3.26.1754219016554; Sun, 03 Aug 2025
 04:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-94-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-94-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 12:03:25 +0100
X-Gm-Features: Ac12FXz0WM2iONccSAENgoa5BpA4P5oruDsfzoy_GJUED0J1VBjz7CFLg0mlBmo
Message-ID: <CAFEAcA-dPnUC8M--wuyxGtEM+fBjF_xiTa2_YYp7wc+StnMTvA@mail.gmail.com>
Subject: Re: [PATCH v2 93/95] linux-user/openrisc: Move target_pt_regs to
 signal.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 3 Aug 2025 at 00:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This structure is part of the openrisc signal frame.
>
> Rename to user_regs_struct, per the kernel's ptrace.h, which allows
> removal of the explination of the name change from the kernel source.

"explanation"

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

