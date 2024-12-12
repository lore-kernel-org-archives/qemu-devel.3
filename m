Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2C8E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLq6x-0003hS-Ha; Thu, 12 Dec 2024 15:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6o-0003el-Tk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:32 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6g-0000vG-E6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:29 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eb8bdcac2eso225866b6e.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734036501; x=1734641301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=EMgTqMRMkolJlVvQSGnZ6bxue/YCrQoiUfgIzAU5wLs=;
 b=HxFGlnpfk0jcpsvTjCtrHkUnJ+yi+PfMQNDDzP5H5p5oTRXnWMbe4+2/ckqQGuSUHg
 3GR77vyuBRe2+tkinqEQ/RkV8/7abNbLlaW2mlwKaRp3oXCUk+6cjJFOKVqBPwhRm/3u
 dFSPJvJa1iuRFcABiwHNgFYqhcBuUegOj2vE9qbMq+bsG1RQvtWCZMb7igBb1XwdsF0c
 UyCdMmbq8iOYAiN1QEt37KYYBntrtw1EqXF1sQgdeMpwqRZey/gQ6xdfb/L8SYNmmneS
 5/hrCNi8sUKjRntbo2S6D1OuQ8ALKTTHwWOmXtbH73RcCKt7i4P4iL7E0+ZlJ16lf4g2
 0Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734036501; x=1734641301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EMgTqMRMkolJlVvQSGnZ6bxue/YCrQoiUfgIzAU5wLs=;
 b=K2cV/+3TDXjYJyJZeMa3i8yuffosW90xzWvJLBkbHMdnLzN0FINWhlV0/u+qCXSTf8
 rVBm96JmLfqn0Uj0waE5kyR2VfT+M8tuAL3IENyfbHbWWiu0SIy3k+7hP907ssKKErJq
 nAUVYA8+QeuOLadFaJoze/76YKA+E9vt+V812CGe2AyDc23n2R3fQDY7dTgmiivcV8X8
 EfqnXBzid8Aw8bx3Dw5tT/G9JB26hAmtPgfB2sO0p+jgATmHpi2vgKkjX2MztlTicmxg
 s+WwTLUS+dCmWrkcAI0eVFQd0MGcFIMvvLqxI02Db2Gf/7mLHQoNTtre+Q1g9zWaL1iu
 MXsQ==
X-Gm-Message-State: AOJu0YyoFJYuN7cpKdlOfQalh1efw9U9Ov0Mab6KHrh4RzOmbyt6oRr1
 2GeWMF4mI97je+iS0GUBj83903Mfyss+RmgmN+QcGEkkMVwTUZCXtfBZ+ON7gI0ED8SDX3/O0zk
 NCCJpd2N+
X-Gm-Gg: ASbGnctDyWkPi9LW5PKweuYHU/LfBkgd2dEYWX21CsS5WNdSDvzVhFQ73fGTTR3crBc
 9sHCpDFQbPn5FLeHWrTAt1uLuNgkYMNCISwXA/aBoCCQGUXoPaJZK78rv4nZ/uqc3sax1mcw2AK
 P9rXS/CBySd0KTmToPY/BlKg4qshISxq67m4Hx5w+spkqIcZpsQ/nO5m4jJyEhyu9OQ0KsO+qH5
 wmIZNrb7MyPbwH+HErh6Qsjas4wyTYcNuWygF5JkH8JSXSFY7cehoY+YHiHaCZN
X-Google-Smtp-Source: AGHT+IG34GhZl4pMDAy2MS1b6He8h6H+9o38pDYns7cMQOt8PXWmXFj8er1gfWDIFbx3fb5b/Mxxag==
X-Received: by 2002:a05:6808:1590:b0:3ea:6321:f93e with SMTP id
 5614622812f47-3eb85abc382mr5930327b6e.8.1734036500759; 
 Thu, 12 Dec 2024 12:48:20 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2b8197b58sm2129758eaf.12.2024.12.12.12.48.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:48:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] tcg patch queue
Date: Thu, 12 Dec 2024 14:48:14 -0600
Message-ID: <20241212204818.2468583-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Pretty small still, but there are two patches that ought
to get backported to stable, so no point in delaying.

r~

The following changes since commit a5ba0a7e4e150d1350a041f0d0ef9ca6c8d7c307:

  Merge tag 'pull-aspeed-20241211' of https://github.com/legoater/qemu into staging (2024-12-11 15:16:47 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241212

for you to fetch changes up to 7ac87b14a92234b6a89b701b4043ad6cf8bdcccf:

  target/sparc: Use memcpy() and remove memcpy32() (2024-12-12 14:28:38 -0600)

----------------------------------------------------------------
tcg: Reset free_temps before tcg_optimize
tcg/riscv: Fix StoreStore barrier generation
include/exec: Introduce fpst alias in helper-head.h.inc
target/sparc: Use memcpy() and remove memcpy32()

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      target/sparc: Use memcpy() and remove memcpy32()

Richard Henderson (2):
      tcg: Reset free_temps before tcg_optimize
      include/exec: Introduce fpst alias in helper-head.h.inc

Roman Artemev (1):
      tcg/riscv: Fix StoreStore barrier generation

 include/tcg/tcg-temp-internal.h |  6 ++++++
 accel/tcg/plugin-gen.c          |  2 +-
 target/sparc/win_helper.c       | 26 ++++++++------------------
 tcg/tcg.c                       |  5 ++++-
 include/exec/helper-head.h.inc  |  3 +++
 tcg/riscv/tcg-target.c.inc      |  2 +-
 6 files changed, 23 insertions(+), 21 deletions(-)

