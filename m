Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6695BCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBk-0002YW-Iu; Thu, 28 Aug 2025 13:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdcG-0004QT-R4
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:28:40 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdcB-0007SI-OH
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:28:40 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e96e1c82b01so674716276.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391312; x=1756996112; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b6rLyGWwMmSLoeWHTjBmyMPVlXBBUjLkLrA2HwylDb8=;
 b=oV0byu+dPUWXoJPETV15pX1bUbU/GJuio1a7U7KTrVST8RUEM0M17TlA1QS/G1PACG
 UvcC5rFACHHQ7MbsHFe9u3zE/8+ZTOgaKNK6RTIqWyFPhc1GOjAs2k33zL2U9kzl8fjT
 zMyvkgxd4AZK41HjqWiyhWLqJG7dED4h2SC5q3BZH9Eh3fn9UlpMespnlQ9s4ZyzhdBj
 450/te7kH2MSf1aCmULT+MegoaTiViims9Ckp5LUnp37sUZGEBgj2hCarCIIxmtup4qA
 74qxidEP/uvk3ZfFhhDO9t0QMbB1PGglkmO2lvFuWRlNQC31T7J3fQwsuvI+T5IfWynw
 GIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391312; x=1756996112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b6rLyGWwMmSLoeWHTjBmyMPVlXBBUjLkLrA2HwylDb8=;
 b=L3x7yC8rLSeGlA53G4pk9VeHOOHRl4WnSNNxRlWXU+bIVVzBQ8Iq6YYykA6dKCBefj
 8/XhKPPEX7YbHv8/VWhy8x190bAnw0zc9zYiqsaRUrldlywb4B1dYIdq+TxLjz514ilH
 8go2U1zveAEbRBUy/6FHmTSha3hqFULoGwvYXeLy3InUrgjNbpXqz4eD0bAuQ6K0kojR
 kdV77mrRquHglHlYdqikuKYnrqw9Q5LbBubklXi+Uj21FyqSsYD/U0jnM0f4YIUqKhrk
 oow/PbyP/TSQ17nXfnGXecKcStKeIuVaTSa4o5Zi6ltYqTa9Sp5nLrei16UefBZMiLR+
 4x6w==
X-Gm-Message-State: AOJu0Ywke1JfCXgiwu2FuS6RhaGrU0pRAn22MuXgU+0tD1yjXqLca1fb
 1xLU7NWmim/KO+rV7d2myHlzzeFxtoGC83UZSJht55aZE7LKfXbBa5+AC4DiTE3TWBwjjMxJ+mA
 ed3+d7UQ1t7fOc5kFACeZBrzc2ySy/+418xeL/8X8d44X+l3PkHhy
X-Gm-Gg: ASbGncvdU6TZ8N84pjS8LrVFkTW/WBLb4BwSIqMhCNNmWV/XjaKi29Rp6+wdXJbhaYX
 9fgvCfiBCrlbJU2IrOgKEs5ruGkpDjhm4OMZ1vauW1qZNH5/eSPWfionHz1lD5b/5gREqMc90jE
 Nzi/gWrlrboUTmGZ6O8VXkRP4hdeg6vNhBVOy5LnaWda7Loy5KnEZNTtE2pHrJK2h3Bzm90rust
 ekeUttCoTkXzYArtLQ=
X-Google-Smtp-Source: AGHT+IHRp+JrGarI8Pp7+YDn5PyS8wJ70Tv9uV9ySE5jGIBISfUd4SUaZ0jjijjoYhcHZ2ER8yMxNNkCfIcfw/A4/vc=
X-Received: by 2002:a05:690c:4b03:b0:71f:b944:1016 with SMTP id
 00721157ae682-71fdc55e08emr271259547b3.49.1756391311804; Thu, 28 Aug 2025
 07:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-16-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:28:20 +0100
X-Gm-Features: Ac12FXy9Zt2ga7lstwZ45V5So_m1fLofZtpGdjhJ6rfTB0H4wbkNC5oMVNtk0Xs
Message-ID: <CAFEAcA_MyPS3Jhbn7HcBFr2O5v35M79MsrsE-dMk62R4Dh0k9g@mail.gmail.com>
Subject: Re: [PATCH v3 15/87] linux-user: Declare elf_core_copy_regs in
 loader.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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
> Drop the static from all implementations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loader.h  |  3 +++
>  linux-user/elfload.c | 33 ++++++++++++++-------------------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

