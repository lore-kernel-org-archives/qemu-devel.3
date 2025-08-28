Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DE9C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgDF-00042e-P0; Thu, 28 Aug 2025 13:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdh2-0006U9-KS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:33:36 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdgu-00082E-If
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:33:35 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71d60501806so7895497b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391605; x=1756996405; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=pm7tUZAE2rP9N37LXIv6MBwgAOm9qYhhQNjr9m+65sCRffYdsXKJRZPrQ+Ry2/oIMZ
 nRlZt5k940TX1jV1hWsmuaHzDWutYA0TAXDrrW0AetZwKy+b9ZL4dkFVbRpzQ31oulCw
 VAt9qnwawrjA55uV9acioccLJNic1czL+S9mKuO2AygD2z9TxaLf5Y37FkV5bfyg2Tpv
 JUx7BBj3emVfSVoiT9faJQR6CniFyaAW6ShlpDtYWOtxrUw25g7Cnx7y7PGgmyM0swLe
 zFEklqM92PCiKGCrYbgwano4muxwO2EoJG2K6ByoSP49Lf0k5GjrvQd5Yo27SQ1bMmPB
 ehvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391605; x=1756996405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=O1vXKJfxjNYUcWmMV0F4ty8Q3z+/dhfLjvIhRJsn9Pct8nB27XArACm9H5hfH2pYTP
 c4OOn3AiDblYDd9BJxFNgG/aiL1u85oVul5hLkEWJmga3HXEKLhAbNL0qUYZw5ypbvPF
 obEXzS5JczVJVUyUL+PRi2naSrSdUU/gGmZa2slJXxa0RwyQH9kVV+0BpfkRGm2eOlMc
 wQku6aLAWHdjDpOcFIazGIEkefqUAoGAXEB/+OCdPuYy4Itz85FTH9YbqVulsIhNINT/
 Ifdl7e7sw83Mz+dH4Z/OpfLXvI46Y29vhMCRQwy0uoyO76hpO5iCk/LMCVLshCRM0nMk
 yL4g==
X-Gm-Message-State: AOJu0YxcPMYgLWh2raE9TL639zMHujdTtrYdlefGLWz0WFPC7WvG++dq
 K+2MKMieIpcD8+HfBml9wj11npXf4SDu7mHx7Lvk3BwQeT0rSs+NgiDMTdO6oxwg3WZcoMHuOqF
 h7o3rWj34SFQ9mJguRHpDbLu7DvDpmH2sflgYcweteUaCFawAu7aa
X-Gm-Gg: ASbGncvecsX8Mb7HQqMbpoRvA/HLP6RfKvz7LPHkm1FM89vHgqfPzPuXkzbgCRIxYf8
 K7T4HpBNwDbgP56Wj6g/mnMSp7ewSBsTJLl4hlSySJS6ALRrVJ6AJwjkMRPj57TccsgCHcAkqHj
 1NDWZiLrvvolgzbYpATJ3IkH3Vmow62q49Ns3TLIdsjUUhiypE4bnQrnjPNdcyN/zuWkMBMoOQz
 XkfoGt67pR1gcgAOeQ=
X-Google-Smtp-Source: AGHT+IGVyFCyuQC8GPZM3HJha8pYjqDWcycb1Q9zPBqYUzW5RhZluy5FXtem3P8naiBZLu0hmaVhUmDEAKXySHB/bFM=
X-Received: by 2002:a05:690c:3345:b0:71f:b944:104f with SMTP id
 00721157ae682-71fdc568115mr285913277b3.50.1756391604572; Thu, 28 Aug 2025
 07:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-28-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:33:13 +0100
X-Gm-Features: Ac12FXzLj6-Kv42yYqysLuVZAUIwKc1XQ-W9aOfkClHIat12b_IoTT--d1t6XEU
Message-ID: <CAFEAcA8uRgZeBLh32wbnWLKFo7Dc+8fvv9p6S9Nd3iTwYV7P7Q@mail.gmail.com>
Subject: Re: [PATCH v3 27/87] linux-user: Move elf_core_copy_regs to
 s390x/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

