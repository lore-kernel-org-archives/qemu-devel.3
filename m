Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FAFC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtD8-0004gB-Pk; Fri, 01 Aug 2025 13:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrnO-0003U5-7N
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:35:47 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrnM-0006bK-Mi
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:35:45 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-719f5a141a3so19930117b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754062543; x=1754667343; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1WhGv3DTnXBmHJZzfGufzo2qTX8sCFGT13PjkP4VeRM=;
 b=fgNHMPBpKYz5sFNJgnQSeBVOulYC31SAWR3EUjotOiJ2K1u1wpzICvLzOlcPBZjI0G
 5VgyWMR8xnh/9/xhcEj35sZM/eT4ahRXwQi9XddtkpS6tKu5Ff+1CoE9L91N/JcB2Kdm
 IRD31cSxiep+KO4ogKX4Qda5D/F0CznRGYvV3ll7tA7kbSbEo/RmsvUjhjTrKkxKYA/f
 JAPvqlP0FYjrn1I2JofwjNbU/QVMXRwcbsKawa6DxSKSbGoLIhWP7MEo5mov6OVGJMEj
 uP46OBIwmwB5cPYJxv6AfOpXIQiQKSPkNtXTgNN7I4bE58khXnrGz7ornMkiwU9/hyOF
 Z2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062543; x=1754667343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1WhGv3DTnXBmHJZzfGufzo2qTX8sCFGT13PjkP4VeRM=;
 b=rufo4NSl1Ywjyol7lVSCrNW6X+FlDi8Ds+6Xk8wZ+llIBA/gNOXC5++P5HeWHPa9hZ
 nA4ebqPdRWOQJM55lnWPK7ipVEb9dQKdq0heDKnY1VxqR2T7pV8OGitMTfaw4AX2PuSR
 ZYSz7ViW2f2F91vNcFwOl/90hoCTf2K4GbUNDcVSbR/wrI/jhNX3mufi32swqATO9h2p
 SHtGEdl5txeIGVGp1ZlLssnGseHQVcUF+AzB2gE4J0jjcAwwSR+JDiHqzGvBh7lfkoiC
 hKtwjJRB6Wsqv2EZ50u7qFdzZnenqV+Za65C+uwVCLdtUauP1j9hncUVKN8GeOlpZ8AC
 MFEg==
X-Gm-Message-State: AOJu0YztxhSG987d4Yf3VlqG6dUMfXv0tUFi+2ag551p6YNhGybh5W/O
 1XR9gqGHYh4pU5cTRO4DcBdAiGMujKKuoI6w6eDW6aWdrzdp+MUJCRYIfPAggFpIY7NiQCci9N/
 mcxb75W93+1ntrZzUZ2GR0b/Bf4IpIGBspogbtL8PuNW1EpSthsJb
X-Gm-Gg: ASbGnctBVNlJSzC1rEvrY3QlPbYH8suR9GrdEBo6Cf3F5KSv1ZzS6uBEqBWKpx6Clye
 YOSC/6Y+wfDEwCr7g4MMag+AJo1mX3pZg48VtwwDCc0I5Zy17rzA5MZ64hGpC5w/XQVVpUU9CEV
 9nvhBG3ZtMVNUEo9r00lk2dax8ic4zfKvpqYn3yocgqX2nrFYjpy0Bt/eK7TKYhgPrD+9x1iI0G
 sRb1Hb5
X-Google-Smtp-Source: AGHT+IEPVbJnoAXu0BH3ckjNz3S1feVHicknF4XCvSOOwA6RzSLK7vt/Zxi8EUyoQHQKLQLwTJE6OooUDWdnE3A6dAU=
X-Received: by 2002:a05:690c:1b:b0:71a:2299:f0e2 with SMTP id
 00721157ae682-71b7ed70f84mr1578697b3.5.1754062543382; Fri, 01 Aug 2025
 08:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-20-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:35:30 +0100
X-Gm-Features: Ac12FXxL11SUbxA5bAJbui4VeDL-JSkPTHLu2Cb12ldbheZiwSnsPXTJAuDmSLs
Message-ID: <CAFEAcA8=FZ07F92AWtuydAusn7nkWfL81+YQYpSvhpPR4Dd81Q@mail.gmail.com>
Subject: Re: [PATCH 19/89] linux-user: Move get_elf_base_platform to
 mips/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
> Pass in CPUState.  Since this was the only instance of ELF_BASE_PLATFORM,
> go ahead provide a weak fallback for all other targets.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

