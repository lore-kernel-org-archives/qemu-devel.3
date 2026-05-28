Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1152CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdNo-00075B-Ss; Thu, 28 May 2026 12:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdNn-000753-M5
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:14:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdNm-0000nA-6m
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:14:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso70742245e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779984892; x=1780589692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KWbabj0GMz/SKDjE1ewJQLWnMcG0Z/OGt6zv4qyzMRw=;
 b=YYQUOCUA0WCkgOdYte7ebqe/YVnWNtJ2gQ5EGdMntIJoHpcwtJr5AcJBj3FmaAR7WN
 P1mlE7xlj11vQRPyvvRAaJVa2uFKnuwpNxaapQvBEMzupxFCUcp3Wrb5Tdush/dxK5SG
 5JnSlp/ERDmtylwbYUdP2VWhs3QCm4jCsYZScigGoJYYHbY+JKlaM2wnS1haSSa5LQC7
 yChiRRuHcpb1geamDsk44/xi26njU3k1vwmSzvXse9Cw38GVX4Kh9vBvSJyQ8DYqeUkk
 yEZW9kYxJd8lZgTdwMVyyaM7ZnL7ZXfZELEbI9P9cScqcbaC7VC73m0RNSFjzT2Le8As
 ZGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984892; x=1780589692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWbabj0GMz/SKDjE1ewJQLWnMcG0Z/OGt6zv4qyzMRw=;
 b=CeymbWLGxYZTYE2SaHnOCC/xfy0l3h7lmgyrPiLbmylMrLnck4Q6zOgIepsq9PaeVN
 2Oi8xDMOMcUa2OqLAI+1wv562DQt/3trEGVPbPVkB7RJhDf4wEb+i85sGst79nea+6A1
 SQhWd4/ECCK0QrC0t0Qt3kxjkZRZzsP1AtmfYV8kefhLQx6JVrs2e3UKI1UzV5yiD29/
 3Q+ht+a81WtnwvNUS5U9mneuPs6eG0FNqZRfBEavCLEZWEPUIeXPfr13ncrommeoQxea
 2cWlOX6mYwQZeafGwA27RP+BYoQ7mbL7vEPmL1nbWMui8IJTevJXlPkgJ9L2qYhc2d+w
 YCDw==
X-Gm-Message-State: AOJu0Yx3IUBNNVgLgKaAMN2Ak9J4hheBn5vFM96dnxWZT/IvgQ9Hsq+/
 Jll1dgsMkj9Ei9xmnHrcy67jVrO+RMrbDvgxDKmaUulAZyRLvuAl+48iZxuDwsI/LPmDqPaqH20
 dEAJ7
X-Gm-Gg: Acq92OHcJNpj8c0liJhPWCcLPcvcRxkybY+mt9oh7kdxhm2/Ya2Ad6ILVGMLbxf8BkO
 TFV90mMN5p6CceQXkzq6cJKQ33ipwYajRN+pxwgEsL+bQHxJY/ZNw9OlCKQpTOp6KviWxDKSJgP
 7XP2eYKIGBqfk3sioVk+JJpLH2dyezMwkdDIHXufa2SuE7tOu0QY8jjDgGghztQZu1lm1OjEUWH
 JiOaJCmE9qMRM9E38ohtZuXQjRdFbOcYXBKwt8VjT7plD/+YJWzXgLuuYiOw5q79lo22Pu1WyYC
 f2YzbjP4H6ru834F1FCNXGoT3dna0tRBtNljxbPzF01KtQf+k3uqy0VrsnYlz0rh2u2Q3waEXdv
 pZcQpXTfnjBn8NQHMV5W8uNnzaoF0AQIDyBpHBx6Tu1BnLemEPBaf7EWVjA8gzlRhtUgEbycI2O
 un0hsf3Al4hY57HicuKKdKYYj3jFWZef7Y1Q3V4o/C6g7vlIK8brRx08jygpVc0n1dHjAsyBSm8
 05BTTFHDN4HJCh1MHaDB3nzCk/tJTUS9ZM0m3IJIQ==
X-Received: by 2002:a05:600c:524e:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-49097823f05mr8401165e9.25.1779984892055; 
 Thu, 28 May 2026 09:14:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b5a618dsm19378805e9.8.2026.05.28.09.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:14:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 0/3] i386, microblaze: convert to translate_for_debug
Date: Thu, 28 May 2026 17:14:47 +0100
Message-ID: <20260528161450.3564396-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


We currently have three methods that a target can use to implement
"translate virtual to physical address for debug purposes":
get_phys_addr_debug, get_phys_addr_attrs_debug, and the new
translate_for_debug.

Only microblaze and i386 implement get_phys_addr_attrs_debug;
convert them to the newer and more flexible translate_for_debug,
and remove the get_phys_addr_attrs_debug handling entirely.

Changes since v2:
 - patch v1: fixed bug, changed mb_cpu_translate_for_debug()
   to the "return a struct initializer" approach RTH suggested

Patches 2 and 3 have been reviewed, only patch 1 needs review.

thanks
-- PMM

Peter Maydell (3):
  target/microblaze: Convert to translate_for_debug
  target/i386: Convert to translate_for_debug
  hw/core: Remove SysemuCPUOps::get_phys_addr_attrs_debug

 hw/core/cpu-system.c             | 11 ++---------
 include/hw/core/sysemu-cpu-ops.h | 14 --------------
 target/i386/cpu.c                |  2 +-
 target/i386/cpu.h                |  4 ++--
 target/i386/helper.c             | 31 +++++++++++++++++--------------
 target/i386/whpx/whpx-all.c      |  2 +-
 target/microblaze/cpu.c          |  2 +-
 target/microblaze/cpu.h          |  4 ++--
 target/microblaze/helper.c       | 16 +++++++++-------
 9 files changed, 35 insertions(+), 51 deletions(-)

-- 
2.43.0


