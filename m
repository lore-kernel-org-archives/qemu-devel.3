Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9C4C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIrX-0003kR-G8; Sat, 02 Aug 2025 16:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIoa-00009a-Jk
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:26:48 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIoZ-0003wE-5M
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:26:48 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71b4677044bso35252317b3.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166406; x=1754771206; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8+Ds7dy9Yp7vauIk46k2wPmRdCkp9aqVrxERp8xHWeY=;
 b=OjjvBAjuI7DyyMIWjScSkWmUw5RutbwVdOWBBJuwHmjJCSPaVpa4TetJHuKUKJmBfn
 AUL1hbpUCqyhDAHvpi3ZMhFbx2NNKHc+51z3Zoj51v8lpvuXv3zHtz9GbcXeCVh/x6fs
 N39DHI4jzP+BPYqUhHJtZfgur3A+kujXbyRk+1A8szv90PGP+2vQMhUWN4cGXHjP/XL7
 ZN06rHRnCD6n7U4uvU+kvc/Wvy7BJI4Bp/jCAxpeTHdu4wGTigNYJe1/2tWap1oceUlz
 64fTRbQwPTFCGJX+3lAcdT8t+mKn5mpqj3++cEOKO4D6FpHFt9tY8dqfsRvZ88nQdnGO
 R4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166406; x=1754771206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+Ds7dy9Yp7vauIk46k2wPmRdCkp9aqVrxERp8xHWeY=;
 b=cNQEw4bO6S20yFLyvsS0/TfZUc+8URXrqj5HxPQgRUXIIhL3r7t4QNlsrikvIBAoys
 5nIs65/RQci4IJPLXWOjkW7JIjMcoVPo16sXx8x29S+f9llhbjPHHouAw3q3XdpK9cJA
 /M8UHlI+HrzaueawWoz3xdIxUMJhbab/Hnpkbjug2VTrkTpdhNjsS13l2F+5HieBEw9Y
 i3l5xgmIpSgxiZ2bWPdSSRfKPLYxKhpVO9IkhESpXUyAu2qccyXtBiEmGqFfbbmfAy0O
 oW+F93xIchj0v5KucJiY8tVvq5SRKmWYV0MaU/nsdImMbMs6xb9T4/If7+5jiTp7343G
 p2Zw==
X-Gm-Message-State: AOJu0Yz9TfDCFYnILHqhN89qd5W7wpJWNFWoYcLIvbgBx3839X7nEmii
 a7bF2WlT+3Qa/4G2zBPxxqqxbfXlBSWjUvUZJBDB4EOyz7VOCnzaij8YwZFNZD5hraLYmzQnWyW
 zIu1Ro6MVFNf8Tf4SG4O9Qzu9WOZijrca9GOyNLTuJA==
X-Gm-Gg: ASbGnctLFk/jV84neLSAV5THVza5AMUaAL3JZ8X7W9j8KimzOAA3xnGEscvHkqpzb79
 iM1MX6Z5ExYU5e8p9oWBYj/qFEJM9DmUAzTOsHLTPdGAuKkMEPbbVl7FpNlIt65ZcuJe24+sD3e
 YvDC856LpEtp+2cmhGzd0EIxfona80YRi98psprnNdVckQBs663T/wALngvhqIWStn5TsnYyG8O
 gKXPv5w
X-Google-Smtp-Source: AGHT+IF0qFDwBQoiUF/EIuU6HfpCJr7U8E1NKC7b/fCnYIWqZDX9U8M3cuDGkqwSE7dh0RXR4q5mu6rxbM8irZnMRaQ=
X-Received: by 2002:a05:690c:6286:b0:6ef:5097:5daa with SMTP id
 00721157ae682-71b7f07fce2mr56532847b3.34.1754166406198; Sat, 02 Aug 2025
 13:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-68-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-68-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:26:35 +0100
X-Gm-Features: Ac12FXzCYwrKVe1zFk8bL5HgBBf1V25MPBuYmYQ_xHFKkn9A4SYMPFU-fUZDRiA
Message-ID: <CAFEAcA_wEODKEG3gprpBCVGpwgnTAxW0tKZ_FFbD3vPGdG_GBg@mail.gmail.com>
Subject: Re: [PATCH 67/89] linux-user: Move elf parameters to
 loongarch64/target_elf.h
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

On Wed, 30 Jul 2025 at 01:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loongarch64/target_elf.h |  7 +++++++
>  linux-user/elfload.c                | 14 --------------
>  2 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

