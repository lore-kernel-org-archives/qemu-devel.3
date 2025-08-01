Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC67DC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uht25-0004WG-6I; Fri, 01 Aug 2025 12:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrgN-0006ja-54
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:28:38 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrgK-0005Ub-Oo
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:28:30 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71b6ab52e8cso11392057b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754062106; x=1754666906; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Esk4bqyO2WRuvpFX1MeeP1zTbsjz3bEK3KDJOtdhfKs=;
 b=Uok4LldzyumfGyLhq9V+K0+dkqe1/Zoy3tgwEE/RF2+IrzovoazgIB+OBS0SLHq/Ne
 oorH9INVuJ9HlGMVGzWjF1XgzSPm6EyHhr244PJ0I/+vgWNybiuhk+Qnv+RymBIbGIwR
 5MvFf4gbcjVZcIuRtXJWxqBax0oqwv/v948xp0lLdXg/Iqlz2V4nlhiAqKLARtlv/5RV
 g7lVUWa/wB602sLowcEmRlvOyjxPbBrSagA8U+/TdQsfvJFpRlAgr1tO0pcATbOAPX3G
 yL07rKJ7jmJnew7EyQSIrYKxZ/MzgjeEEZDa2fCZPDKORPJ+EdmxXPiNYE9bAr2JMFrf
 ++ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062106; x=1754666906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Esk4bqyO2WRuvpFX1MeeP1zTbsjz3bEK3KDJOtdhfKs=;
 b=gHq4ZRhZGYqXK76roXXEVUXhljT9F0bKLalzH195/61iyWGqIVC84PClEWcxc0Ovsy
 MxzEzZJhsAo5jd1UEAx4f3617oOjFyzAUmmWA8CamgVelyLpkfH1v/BHO+vVGDNQ8fnx
 NUoIS6oifsbRz9HQXVTL07pvgFPRhLd5UOTlG+bxDBrvR1FEubTciHO+iPckgzk67XJy
 nQ/lIizU0D49yeRKeFLbTZ6zWYxUn+aTKPsz+kqOtVWNCNe6i8apAVxeDYWKHGRZASbb
 Z839xStBUX0+4YyFTu0Wuvle/PkHh6dmj6pzc6GtgMbPhzSRNkDnrib9wZarwjLD/e0w
 MNdw==
X-Gm-Message-State: AOJu0YzsrnWOrWEtLp1i4fCPirOu6lZ5JIByyuPklUZznysN06q9/1Yy
 ywpGcfSGttJvUdiVZFo0AfXDmCI0pRpDmJ/ZCRM5wTH+2QZsDWZwRm8hTsit1cTzq/NNSH2nLZM
 pLCh6T2nqhg2ibHGRaCh8XuWQYHCOgJQT4xxne6A0p14k0IQCLUlW
X-Gm-Gg: ASbGncv2gKl0uwfmTgYSLrPJ+HmPxDYqG1oXA4uFHKwru++hs+WaBK0AoPZ1rPWAUjO
 lbIz5yvoBzJ/E/jri9GkcqBLCuhyms63IvQ25RU8wSAQ/mQwuRHkAGwp2jTE7kjN9Y/dffts5AQ
 4KV5LC4DLhNLxAbJBTfl9VBMoUKJwERn3aCTdA3xDkab5OdROQUhzhoPOZqKPTkn6j/PGjBwj6E
 XBp0qFf
X-Google-Smtp-Source: AGHT+IFI8n6xygm89VYO2cqqkbFhZVO27cd4nWfboUO1l4kRy+O0vgX42yPSfl2mvfobuIF3xOiIP6lcEiFspdXmvpA=
X-Received: by 2002:a05:690c:fc1:b0:71b:6ad2:d10d with SMTP id
 00721157ae682-71b7ed73cd6mr979687b3.11.1754062105580; Fri, 01 Aug 2025
 08:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-15-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:28:14 +0100
X-Gm-Features: Ac12FXyqUJ3iCI5IQRa2dyve11RcmTQRoYJQ-dAwY2S9Q6Mm-QfHBJiGEP_0E8U
Message-ID: <CAFEAcA-TXMAAwbu+G92FVkcSJCWzxmJc7zeiaTXCJJd+Vcd+=w@mail.gmail.com>
Subject: Re: [PATCH 14/89] linux-user/i386: Return const data from
 get_elf_platform
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

On Wed, 30 Jul 2025 at 01:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than modify a static buffer, index into an array
> of const data.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/i386/elfload.c | 12 ++++--------

I was thinking as I reviewed the previous patch that the
implementation of that function was pretty ugly :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

