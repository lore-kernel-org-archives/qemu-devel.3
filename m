Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49376C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIwB-0003hZ-56; Sat, 02 Aug 2025 16:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiItK-0007Aa-Cz
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:31:50 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiItD-0004Y5-JX
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:31:36 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71a39f93879so42881127b3.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166692; x=1754771492; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sPYFhPVMHcQIaKsoD9cgC1xNXERUuLt50GXLVhitOFM=;
 b=H/HpT5LT3JJcbhGy3hrNK8955oFkS/AySkJQPewnFrA4Jt2kJ2PGT4MIf+AtA1fFpH
 hIlWXas9OpI1ZUFA9IanOqdHt73rwP3YssCcUs2sQj7JridUFOmPWayqY/Tpz4wdxwKs
 SlG6kW1vK48KRYJRt/Ks2sdDVnXUV79L7eXbN3mKOKDNDQutvICb99MY9mNXBqeLQZBE
 3Bl6hmKOTRRBBh9xbSW/qo03UdRUnDy/NsVo2ABebW9QH2jA4AJLfJH2PWURWDWPTymw
 JoyhijpGZIwg5KFrtMQXP4N2O+2N/ZHArEgiGAE0Guphb09CNKrrgGLgzZRBmPxNjXlC
 rkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166692; x=1754771492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sPYFhPVMHcQIaKsoD9cgC1xNXERUuLt50GXLVhitOFM=;
 b=cE5KbyrUwJUx5VRDVl9PDro/kFPGOJ7XWgSCTvx77eWY8EpFHcvieKIiw1zOpSmMAd
 8SuX2hxPp7k9XdFGaB+k3ZrC+BryO0LDEHF5ZnK4NW7eUeMXUlTWs1aZjEY04Ake+Ymm
 AssBwH6f+R/fxcBP/boRFtTHysGMeGM93wnJW2CAlIhwf5kgjZiZfNoBoN+sw9wosRl1
 r4Ge1jiYKgItlAQg5hL8ZQiepg5COb12P9NkSbaNz1k4tPcu6P3OdS+QmphaGsba5PG/
 vKwM5j2LptCw0sLBKrhcGm6kJdkfcZ/MSJobJm+EWsK55DlYNXQSsMPzw+NEzZmYz9rJ
 XdKg==
X-Gm-Message-State: AOJu0YyLaW84D6E2oHbdw75l9bzDkEeVmgH66yXiMbAkUf3aGmwWguvF
 zeJJp9sk6D/XQ+b13sO+fwDZPpU16hUWjt3b6Nu6xhQX9AO8MmlBne9ScHuBfetCOGqt54Vgtol
 wEq9OwL78yY4rbmoXxxGAaMnOre2ZRZrXrdGlR12w+w==
X-Gm-Gg: ASbGncs77P6hGYPQEg8xDaViLG6v6p19I3CVCR5wFAKDzRfpSXc4MtNhZ3cea+LyS3u
 tIWMsLDqZYbj0sgH9Wl7r1LnVXcfHzUZ2Hqyjy9YLrmLvEF1WxIAPsCsbz00GIDd8/jMgAtpMsh
 P3yLaYgzFGn/etYv+ffaoboI5DFGybXePBHhgB74Ums9PYfIaeIn4/Vq1puCzvKOa6tkaCzLxOO
 YRHmTjy5n+IEn8UeoE=
X-Google-Smtp-Source: AGHT+IHcXOVBiTqsNqN2/ieNHjhn/4eysUEwfn521BtYCC2c1T8I+45NIJcZo0+6Vac0gEO2xQGR0xQB8wPk9yPtfdM=
X-Received: by 2002:a05:690c:f92:b0:71b:727a:f89 with SMTP id
 00721157ae682-71b7ed70d47mr60268037b3.7.1754166692285; Sat, 02 Aug 2025
 13:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-77-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-77-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:31:21 +0100
X-Gm-Features: Ac12FXwMVyKw4cdEPNN4PpJV82R9ihtJnAuIhMzKVgja1-93uCS79U1xoS1EvrI
Message-ID: <CAFEAcA_bF1+0nLDg6WspijZDLBny5MiB2onmgxUOta-kS-1AEw@mail.gmail.com>
Subject: Re: [PATCH 76/89] linux-user: Move elf parameters to hppa/target_elf.h
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

On Wed, 30 Jul 2025 at 01:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/hppa/target_elf.h |  6 ++++++
>  linux-user/elfload.c         | 11 -----------
>  2 files changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

