Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5E0C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWQx-0005kb-1P; Mon, 24 Feb 2025 06:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQv-0005k5-52
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:33 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQr-000164-IK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:32 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f70170005so2418951f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395727; x=1741000527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8vlxg8z6B0J7aqXx3PXSrTy4ARsg2froS6iroR0l2RU=;
 b=n4s+rPdWiE8Pe+HeaLd2B02vcV26qZwCifMYLdEV6zUQtlQHrihL63LBN4gI5bEKC6
 KMEsHcUlVfN9NmEm7Vxzvqj0qNLrKsUm5VSRfdMC+1HIakKDzJTqxuZ6xJdyFqUAo1xj
 K9VKNT5gbriQcfSbn9e9Xp+I3MbEF6Ot599ULJsolTEz35/QVmWt6g3mmC1ulwkdyM6M
 hP6EDjosv0vsmIGvyngziySplKpSIiYPITCOQ2tzDyIQPD05rD6tavpmUshz9sExGcYR
 Ggdda7bp2gAqCrOXJX8ZKDrUtq/EWTNmbR/gGVxUB6EZnpHuprhAKi/SXGJV3ZzTkzYD
 8goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395727; x=1741000527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vlxg8z6B0J7aqXx3PXSrTy4ARsg2froS6iroR0l2RU=;
 b=LXg9kIF/wfY1XEmdCgSlSWxbKaSrFQPxg4IeGOPd6/Anq14ssLchxjXOnflBhtU1BC
 0KLTqubuZh1OAhkEhYib8tF3HO12T1yzL4Au0tbxpW7xZ0g+q6yGsYCfyrkXO382qH/3
 xhFlcjAGQ+y52dfD72wVStOyrp8V/1zaj6LM4csGFe1bP78KNcbfnVfDYAhMxvd/Njkh
 M+ksneeeG7MpVSi1LgxoHUKuSNzn7yFc7Tc9Zts9cCH4P9mHteEbo0ummYxqrtUISXdq
 FcjmdUIUS6kx8RuGl8tMEob7+ViU2tnVd6B87LsF5ewysG42Dgsawra7RLdfF28dUlzE
 Ddww==
X-Gm-Message-State: AOJu0Yzq/jweKMOYnOEqZ13dBddWSPi2Y2JdPutl3l4eJ5WQfbNgKQrZ
 uiV3vBQ1fjLvdO5PC7f5mqmRNQXRANoQjLX/pPxA4nFIIGzpujsbZxe99+Zgro9rKO1L91JQCja
 3
X-Gm-Gg: ASbGncsFscbp03Mbf0S+pQwDhFNdOTsR+wZAvdoN6oSkbiqPGvmeR7Db/y6zbX6JYfn
 AIA2iLOz8W+hw3LQPy9b/LE+iuIthS0GAeZfltYzLuCl6ybn5S7roZnDuaBjOaxGs7e/4DrjTr+
 sa7zAjvHijnLPNbrzApsG93CoddaYkk38+oFodomDbAMZJoKCTJWEw3dfxlRkj/ZiqwzISvex4z
 t0q1rIpiv3jFGcGLREVxTBAsRXxLIUOC8tz/LwSsX2jV6ASSbdjxXAlLsKMKrsJKc3dlzlkregb
 6tCa+sra2GN2wIhdxGHSp25Qse32WhY3
X-Google-Smtp-Source: AGHT+IG2JgV2aE4aZTHwZtsOHCC796PciGRQG3RXpgX8yjYebq8A8cr7teWlapxmR6eWBWqoFxbZqA==
X-Received: by 2002:a5d:47ca:0:b0:385:d852:29ed with SMTP id
 ffacd0b85a97d-38f6f0affc2mr9374873f8f.36.1740395727353; 
 Mon, 24 Feb 2025 03:15:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/12] fpu: Remove remaining target ifdefs and build only
 once
Date: Mon, 24 Feb 2025 11:15:12 +0000
Message-ID: <20250224111524.1101196-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

This is version 2 of the series that removes all the target
ifdefs from fpu/ and switches it to being built only once
rather than once per target. The ifdefs are all either
(1) floatx80 behaviours or (2) simple optimizations to take
a decision at compiletime which we already have the mechanism
to do at runtime.

Tested with 'make check-tcg' and 'make check-functional'; the
series is supposed to not have any behaviour changes.

Changes v1->v2:
 * Split the old patches 4 and 5 so each has a patch which
   only adds the float_status argument to floatx80_is_infinity()
   or floatx80_invalid_encoding(), followed by a smaller patch
   which makes the real behaviour change
 * Updated the comments in the m68k_denormal patch as per
   review discussion

Since the old patches 4 and 5 were both reviewed in their unsplit
form and I have confirmed that the splitting didn't accidentally
produce any change in the code, I have retained both RTH's
and Philippe's reviewed-by tags on all the post-split patches.

So I think we can consider this series as fully reviewed.
Does anybody have any preference for which tree it goes in by?
I can probably throw it in to target-arm.next if nobody has
a better suggestion.

thanks
-- PMM

Peter Maydell (12):
  fpu: Make targets specify floatx80 default Inf at runtime
  target/m68k: Avoid using floatx80_infinity global const
  target/i386: Avoid using floatx80_infinity global const
  fpu: Pass float_status to floatx80_is_infinity()
  fpu: Make targets specify whether floatx80 Inf can have Int bit clear
  fpu: Pass float_status to floatx80_invalid_encoding()
  fpu: Make floatx80 invalid encoding settable at runtime
  fpu: Move m68k_denormal fmt flag into floatx80_behaviour
  fpu: Always decide no_signaling_nans() at runtime
  fpu: Always decide snan_bit_is_one() at runtime
  fpu: Don't compile-time disable hardfloat for PPC targets
  fpu: Build only once

 include/fpu/softfloat-helpers.h | 12 +++++
 include/fpu/softfloat-types.h   | 51 ++++++++++++++++++
 include/fpu/softfloat.h         | 91 ++++++++++++++++++---------------
 fpu/softfloat.c                 | 23 +++------
 target/hppa/fpu_helper.c        |  1 +
 target/i386/tcg/fpu_helper.c    | 51 +++++++++---------
 target/m68k/cpu.c               | 35 +++++++++++++
 target/m68k/fpu_helper.c        |  2 +-
 target/m68k/softfloat.c         | 47 ++++++-----------
 target/sh4/cpu.c                |  1 +
 fpu/softfloat-parts.c.inc       | 27 ++++++++--
 fpu/softfloat-specialize.c.inc  | 29 ++++-------
 fpu/meson.build                 |  2 +-
 13 files changed, 236 insertions(+), 136 deletions(-)

-- 
2.43.0


