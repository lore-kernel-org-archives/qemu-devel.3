Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C46C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIJ-0006uM-8n; Thu, 28 Aug 2025 13:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urddl-00053T-H1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:30:13 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urddj-0007mJ-Aq
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:30:13 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71d603a269cso7246787b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391408; x=1756996208; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=Zi4kwsd1zchKmzxqlyMa3tdwVDiKkbQeVpEj7pkeWZfzJabPQCZCWV26Jh2IGuUEi1
 ULzHlqVy1XflkbSC6rNP5FcIgSGCXRmWovpTEOBjrsz5VCYXzUMJSnQBtCjJsSIPT11r
 WOoG73QGNrG4N3QXqqyfCLzWIQODSDZV2SezxXn4TppdQFUMAOohvqrAv+YuzOgD3ymc
 K3tbfBoRnWwZxpOqLfb0xo4QFKw9ZRaX7YS9Vcn+Ez6uWO55/tcZjN5VHsUofbq/25Py
 J0la6/BbTa3a9lUbCMEnYx6yiUAEfqjKo8WjbPtuuK69indMyRfJpxwtneuo/zrajB7R
 JQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391408; x=1756996208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=Nvi/ah1lvY2tVRTN3BwSqseYD+mphRSIqdvKZeBd8gsOe56TZCP9cs8mkRgM+YAjT+
 z3S2N0h+u6GOlMOq1Dlp/ppQSmjQ6OvHdnaup8LL/Cxsdv5VTVlhhzKmH4jhzc7tnhMO
 3VpAxSLUaqCM2JULSz+Za0fNmduclf9M6gzq2/BwUjEI46xeD4aYJ9j6PyTpFxDEx5vy
 tTOeIe/ZuAG3StgulNr0NXgnIa6Cm2zZF/DNU1eEHBtbNGpH05YF2hRmJ2ey0ew8XyRi
 h9UQMmlhbzIj2X6/JDwJFFrAZ6naMabzUHjyCe/3GqANvu6+Zzem7ZsK93SHcvkztGyD
 X2Dg==
X-Gm-Message-State: AOJu0YxDgOPb4m5f5f1vVa3TV0JoChHd/xLCw/5yTVrgMJhMVzNTnezP
 YXpPkMZCh2oWnZ7icKEPkrs1+IN4/X9gpq+s0Q2j075VAzbBX9wUKCxOPyd7T+GA0Q5BK6sZCaR
 5v4IIvco/9BvJ029tdTkpShG4xW5CgjAGDpacsGxOjbafjQ+ZlEXR
X-Gm-Gg: ASbGncuUlL/ZTD1ym1Lpn/TxgOfOyJZYjmSb4RGMSQ0VVceKO9K++80JnHTXxrM+4xW
 NS/oMxjaAjt59m+xwZrWkZlFtDWyW+IIj+K2vCo/XUh7+vCt8rBsHeNoXNT8Rr4G0p3b+ktTaTL
 xEM/riFBmaJAKCoiGG7ZRj7naq+5jUwKY03Omm4KtcgcUzz3kD1ybxn8kuf7Ipdlw5b7imCNCwI
 T6Dkc0B8cAqtxtHBuA=
X-Google-Smtp-Source: AGHT+IFYb2ZFQTskEUzGuuopZRE6fKOwBwpfMDmSwuclDcaVcggPemwgV9CwDVDw3zf4rQUSEQlCMj77C6vvp6KwbSo=
X-Received: by 2002:a05:690c:d95:b0:720:378:bee0 with SMTP id
 00721157ae682-7200378d995mr221649357b3.11.1756391408147; Thu, 28 Aug 2025
 07:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-18-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:29:55 +0100
X-Gm-Features: Ac12FXwQe3HeKJbqphW4JrEECgubhRn7tcrctS36ZpigKUm4HEX0rdh39z1WrjU
Message-ID: <CAFEAcA8LY-n0ArDnmy7a=S3oQUWuuQcnbhVcN8NAahWmVznPYQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/87] linux-user: Move elf_core_copy_regs to {i386,
 x86_64}/elfload.c
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

