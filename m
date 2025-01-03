Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46B8E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlCG-0000QE-CN; Fri, 03 Jan 2025 12:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlC8-0000PU-3j
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:10:44 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlC6-0006mE-Ds
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:10:43 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so8538204f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924240; x=1736529040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wW81ZsV/iemciYIUPkkQZwi1T5j7zVtZZ41DJIlDy9M=;
 b=NTe+olGL8SXDRfkskFdbMGkPDjstsBL4CZw/pnUVJC6CELqBGqoTIQdTsHz//38B03
 T3pjCb2sfy8sSHTUdpxuvTGIIWGCANK3ucvdr2z8bsZmws45rfHuMwqsU3yAi+NLolx8
 nQbmBoKx/2yJiYsitOTm5jQcXc84XLlzkdHoCzQSXjvTcNmTBVhQldsQFfJCuambVBhQ
 BGysm/CP2jmrvWe8ePInnlJtxdIdL5wrGRdTujWb2aJJqLS04BRlFsh9XJu/HMFCsGiR
 YdY4TDmhXaQGK7w0Wyyigc111GJMdY7ltX4KJSuOBYySohPzZhiXEhzzZVdSjly5dWgc
 zfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924240; x=1736529040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wW81ZsV/iemciYIUPkkQZwi1T5j7zVtZZ41DJIlDy9M=;
 b=gMxAOzXjD7YwbT9vsNpfzpRmD7pVCpaLVAC1K3P9wrNixQA1ONXXfju/Slk9BHUX1K
 ZcJdET8T5kxQCxERb+7P+7emxSpV7sH9BIqXvdTya9zdBHIQ8D4NVYrQ0kSZP7NqF2Os
 z13UQsxNZ2hhRIRsnQ1SMwDOrXQCwx+qP4cvYIz3iX/qhojL247ZMx842SNT9RmbRSyr
 DpO1HElyUNpecCwZZa6COWywz3NA6HgAVivproDhIBxBf7XuN6mseyngKoikX+C3Fj03
 zhKGrP8DG+83LNU9mUL42YlESANg9GGV6Ydw1xYthiwFDR2KI8z5kHY8obvpQGd8vb0L
 IZ7w==
X-Gm-Message-State: AOJu0Yzw67VqMYgnYO9S/KeT2RbrEuEqbtcSewLbcbDEUv7uL00ue+B2
 5uV7B5HOXEwAKQLKfIqnq5SBwqPam3HF30i9Ev31g975iUsF6v4QgPajwxcklSxz23oluVPwTlM
 7M3w=
X-Gm-Gg: ASbGncuTtNqN/YFMLc6rxrJ7VAy4sm8c01I2d2y6q/rUpvOZTXB+WgoULRu2sNdXNbS
 GAhbzOBEFGyJb6/BYcKlY1nr74son5SGiQ7BvyCXjmllWBgdjZKrYLnMnOjCEccuXJoMdinKjIX
 PuhcsFcfnWT52xjKQig9SdL2+qmQA1v0MZPj3o+mPXbSoJt/Jn8maqJO6dxSKTdFy6S1RbJ3QY8
 uyV/1fcc1zXdg2/OgqRcnznuXV/P9gEJGWnWlr7pmYyoZkmKnvoJ4g6mxqqAECt8UVyLc1pn2Tl
 fQYYN99rAW5C2MVEmFCj7nUPAmhmZdI=
X-Google-Smtp-Source: AGHT+IHCYhVQDsYiVnheag74DZuJ3EJ9I+nJ3H7uWGz28yHIx/7nKq+DbH4Izp0rj5xrKnw4qvpsWA==
X-Received: by 2002:a5d:47c5:0:b0:386:3213:5b9b with SMTP id
 ffacd0b85a97d-38a223f5cebmr41308637f8f.43.1735924240342; 
 Fri, 03 Jan 2025 09:10:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea42esm496409315e9.9.2025.01.03.09.10.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:10:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] semihosting: Reduce target specific code
Date: Fri,  3 Jan 2025 18:10:32 +0100
Message-ID: <20250103171037.11265-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

This series makes semihosting config.c and console.c
target agnostic, building them once, removing symbol
collision of the following functions in the single
binary:

 - qemu_semihosting_chardev_init
 - qemu_semihosting_config_options
 - qemu_semihosting_config_opts
 - qemu_semihosting_enable
 - semihosting_arg_fallback
 - semihosting_enabled
 - semihosting_get_argc
 - semihosting_get_target

This function is still problematic, being built for
each target:

 - qemu_semihosting_guestfd_init

Note, it depends on CONFIG_ARM_COMPATIBLE_SEMIHOSTING
which is target specific, so doesn't scale in a
heterogeneous setup like the ZynqMP machine, having
ARM cores with CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y and
MicroBlaze ones with CONFIG_ARM_COMPATIBLE_SEMIHOSTING=n.

I suppose the semihosting API needs rework to consider
the CPUClass? I'll let that investigation for the
maintainer ;)

Regards,

Phil.

Philippe Mathieu-Daudé (5):
  semihosting/syscalls: Include missing 'exec/cpu-defs.h' header
  semihosting/uaccess: Include missing 'exec/cpu-all.h' header
  semihosting/arm-compat: Include missing 'cpu.h' header
  semihosting/console: Avoid including 'cpu.h'
  semihosting/meson: Build config.o and console.o once

 include/semihosting/console.h  | 2 --
 include/semihosting/syscalls.h | 1 +
 semihosting/arm-compat-semi.c  | 1 +
 semihosting/console.c          | 3 ++-
 semihosting/uaccess.c          | 1 +
 semihosting/meson.build        | 9 ++++++---
 6 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.47.1


