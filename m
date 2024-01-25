Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E0EC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2gH-0006uj-F3; Thu, 25 Jan 2024 11:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gF-0006r6-1Y
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gB-0002AK-10
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33937dd1b43so3359945f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706200453; x=1706805253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+eC4LHMBL/iVnWEGbnsMN/lqwJwozZWJpzQmLLpDa0=;
 b=gZTPy9M8DXpWBMJVATgRm04efqFyEE/FsBwtBdKklrr+Tr94m5Zca0TnRrNgIbXiCa
 iOhdZ+l4B7WN4RHmaCUT0bRaO3vaNyCzTckh6dEir4xSTFkNbHEN8GhVW9YJilawWH1i
 UGLNs9q7WPWbiAx+JYl7nuWVOKSJEL0MVdCNwk5m/gmyhdiHV0AKimFgskDm4CW0GhcJ
 SGM40qzwQezDNdETE1CY9TAAWQPBaQALbd2NeVp6UzvLOspnR9PcDu7huK5SjFYw35g9
 cGrDHnsgaKWezFWcAow/FZ04PfCHpe0MU8Ky28r4nJJUfxHhY0bzcXXSnpRfxSG25UJc
 +G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706200453; x=1706805253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+eC4LHMBL/iVnWEGbnsMN/lqwJwozZWJpzQmLLpDa0=;
 b=HlHkSZGhswHl5dTu9ekgE6d5PHvVqRNomqARVGzrK0Tia4FZV9B5SeAHUz6WcBuLW5
 xWzOSKWypV+1HDzX8OzPWimd5Eojydc441hTSix2BJi2PaO2CyTUGHcbha7nm2QCBik2
 9tWI3LIbiIbf2K2aHPUkPSYUe08wrsvQlSs1IPtikQpQSH/F/rkzSjTTaphus6lKcvMF
 6LXZPkgUSOGimmkyfYFtj8nCxlfKyw9x63QMIYbhWVIQx5mLRdbNitYxBXw4TXylVTP3
 kW2mRmcFtHQ+FtytfzTk8ic4TAn786Qhu5F4TID4NMi+iJm6K3zyby1t2WhM1b0gYeLr
 HwGQ==
X-Gm-Message-State: AOJu0YysZ8A036BBksPz64A7aGbZP3gORjYplG3aifRKGT/fouf/RaR/
 i1FOFR/ccq4sJoZqd6VizvOZsf8zyos9U9hV2K1iwZlgaQ0zjpou43lm7FNcdK+gJggI8ZW03CK
 P
X-Google-Smtp-Source: AGHT+IGyP5nRjHk0KpttX4oDcB2/nRV7auXh/RG+igrAkp1gDwPsD5uz4x8PKPiZDBAucmppiO9Tmg==
X-Received: by 2002:a5d:6543:0:b0:339:502f:5e0c with SMTP id
 z3-20020a5d6543000000b00339502f5e0cmr1146669wrv.10.1706200453495; 
 Thu, 25 Jan 2024 08:34:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040ea875a527sm3122208wmq.26.2024.01.25.08.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:34:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 09/10] riscv: Clean up includes
Date: Thu, 25 Jan 2024 16:34:07 +0000
Message-Id: <20240125163408.1595135-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125163408.1595135-1-peter.maydell@linaro.org>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git riscv target/riscv/*.[ch]

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/riscv/vector_internals.h | 1 -
 target/riscv/vector_internals.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 8133111e5f6..842765f6c16 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -19,7 +19,6 @@
 #ifndef TARGET_RISCV_VECTOR_INTERNALS_H
 #define TARGET_RISCV_VECTOR_INTERNALS_H
 
-#include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "cpu.h"
 #include "tcg/tcg-gvec-desc.h"
diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 9cf5c17cdea..12f5964fbbe 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -16,6 +16,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/osdep.h"
 #include "vector_internals.h"
 
 /* set agnostic elements to 1s */
-- 
2.34.1


