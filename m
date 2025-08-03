Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D373AC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 10:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWF8-0006sq-1j; Sun, 03 Aug 2025 06:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWEw-0006ir-VQ
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:46:55 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWEv-0005PG-Jo
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:46:54 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e8e1f488b37so3286109276.2
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754218011; x=1754822811; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=951l07FBdtwJ0Hqcfzu6ZhLkbKBdpM0WZlwLHYsQEpo=;
 b=izHLhY+BRJYAVr6DBWhCthkr49J8KGh1Gq4ykAiNdfkHU8JYIqEvP62hMigtcL02qN
 nm44mS3o1h6f/Knf28seHwRk03hdr0UrIv/xL7IcRDBo/7MrcPXn07Uc6dYQclr4L16L
 XZgdst7LDlxH3BEHf+44DjGtNCPraXD/u9dcgVWbZ/23nKyUzHr2Un5O1+iqdjCOy5OA
 Wc6Bo+mVxvmQFZ4j2h8I0D1ctx6VZMlgUwppa3ENns4lPej523/vyQYBTndgix96wehA
 EMH9qx7Jx2mWu38TpnDaOO67/MD+UnxNJpjjbcQ8N0JXcW898VWF/4WX1a3GZZAN7GVu
 QaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754218011; x=1754822811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=951l07FBdtwJ0Hqcfzu6ZhLkbKBdpM0WZlwLHYsQEpo=;
 b=Y90qylBWaVps5dWhZO+0kZySAVxKpp0LJxjrFk10N/wSTCIZv72vyto+3AAHd6zaXg
 U057nx1woH7hX6D7lizYI0aQ+bwHr+1ZVPO0hkBFlfGJnZITMnXfzfJjur3fVQWUvra0
 2cMbNK+k3O7Z/Qa/pQB/ZiRWW57u3PZqk0PZBpjQZBVX5ojCSlffQLqUUaHi1ughdfEB
 94pLkxFcWKxSgPn/fk/neDBqy3iWNcJqkdqzUBg+xAyhj0d+ijr5XtnrZ48qOwQZDNwh
 4ImKDb403RaaDiLPghgPaaQUPIcOFDjbAEyjW2ekNyGyz7AmFh0JDVEgysDv5XIC6NS0
 bWNw==
X-Gm-Message-State: AOJu0YwMXYhLkinRbnlALifXv6q9UwenMJOLHHH49n141e+a0shSKg69
 XGGtomYUF0fxYdgIOk03aScFQoF1hoMpmdzOot/UqrPUi+hQgpLCxshrum/Pr0iQ1Q5yidE/+j0
 NdRWKc+2kQrAYGy0u2zPdJ/HCQS2dputk0kuYQc+50w==
X-Gm-Gg: ASbGncucwNrs1+9BFMtLUXSm0w0YKXV5QKJ5Fz38nfPuopZ3XdDRkDFKMqwP/j93t9g
 xskZ+aKbAA6+l8dlb94IcFFW3VVaez/GR9HXcLYGLQx9SF5Ar1JVJ5ldQFP4clzz1/H9EokI3Hs
 eHz/byqgC8bLw05unGvtkmQe8APchbhtp+O7Mk2jOwRWKhK/7P9NhYcUzFb61DRNPGbrm4piTq6
 MqBKvUr
X-Google-Smtp-Source: AGHT+IHB+VrWgxnAEyKSz5sM/AAeF1bRjvXYal6eInJwPhvXPN4q8Lr7yeL7S9zCc5WY7FOl7cIpQ2m26sqvWCWBzrY=
X-Received: by 2002:a05:690c:d8e:b0:711:406f:7735 with SMTP id
 00721157ae682-71b7ed73e4amr81664177b3.13.1754218011484; Sun, 03 Aug 2025
 03:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-27-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 11:46:40 +0100
X-Gm-Features: Ac12FXwHbixGPfQvcITE3pIPf7r0YD4OoB7webbROmBN2U3UwQRw5vzzwYjf7KI
Message-ID: <CAFEAcA-ZmcySiqbWpdKrdseNO2XyxDm9CzTqLc7xh0CiZOGC+A@mail.gmail.com>
Subject: Re: [PATCH v2 26/95] linux-user/i386: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Sun, 3 Aug 2025 at 00:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
> Temporarily introduce HAVE_INIT_MAIN_THREAD during conversion.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

