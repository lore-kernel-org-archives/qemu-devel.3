Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8985C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 16:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxUKp-0000lJ-Bk; Thu, 18 Apr 2024 12:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxUKn-0000kv-2S
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:10:01 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxUKl-0006YY-26
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:10:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3476dcd9c46so718458f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713456597; x=1714061397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RC3I7eEuU1Vrf2ad1mlMtTC053sX+mHPqI7q34t9+Ao=;
 b=iLe/mHvHZ3DmAiEZCSMcWExrF96RqQZXTGRfz6y5119Jne/1epHOw7X+HcbNuQZcgP
 trjepu6BoKan6rLTeh2OvPS0NMwmbNoqTLdL2lJCnN1Ty0TOh7jSbIgsGRN4CRACncVH
 dzhzt3SUVeIGwezkt9YH4/eei008A7FDKGxmS8XP8of9La7+sExwyBr/y2HVqjhI2Lda
 ew+4Z2S8YQDQzZ1quTyx5fa/uePE9NspQxVngZhc06TZASWg2mNInohNl6Qz+esBOBDb
 uqs187/ouJ/X8hCXQ2fhsoABWN8sUGtCtGAQrRRfkogHTLzTMk1SZWl5n5qX3D0wwuul
 vCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713456597; x=1714061397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RC3I7eEuU1Vrf2ad1mlMtTC053sX+mHPqI7q34t9+Ao=;
 b=vPEQ702/xy2kXoBfANky9F1Ja+Ig/JhJoV2a7izHntdcctgNbxlEj3MSiDG+B1nw5m
 TGuUvOW8D861gub2J7fPESyHpzLfbP6yTKlVP9hX4NCSAOQaYhBtLj2b+L4aebZum7d4
 Cn1G251yTMQS+V5xiyHwTdeq+IpcstVJGVqS95ql+A+Q/1zQotY/v6V71AfQTsX6Trs3
 npxnDD521PGzPIgLwtvatQN14XpA215YPWMS1a251wp4GFSflqif7svBzh3/WkJ3P0QT
 7v5lIjkKTNm4TxQSLv62tY7XJge5CXgVZXeEaOm8SLXzhmB2dsHqTvVP3ogVA4e0TGfM
 wMcg==
X-Gm-Message-State: AOJu0Yxf7yVkfB4nxEAWsVGdSxuNyf5wQbNrRAHgZV0R+cs8y2kOl3yt
 HoTw6PDCYpa9GaVc/HHWmIrl8tsclR05cno8PHPb5h11sO5GuihPjzkJK6ICouSg0ALCfjNVJkr
 +
X-Google-Smtp-Source: AGHT+IFqQr1grcS6Vv0q2R8fNpGw+sUBkGr/sEJtqbVYxP3cv0SlnpNkBVS/32q5ifVtO3wIYSRCxw==
X-Received: by 2002:adf:e6cb:0:b0:349:cbaa:3bfd with SMTP id
 y11-20020adfe6cb000000b00349cbaa3bfdmr2071143wrm.14.1713456596692; 
 Thu, 18 Apr 2024 09:09:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d590a000000b003437ad152f9sm2145991wrd.105.2024.04.18.09.09.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 09:09:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] accel/tcg: Rename load-extract/store-insert headers using
 .h.inc suffix
Date: Thu, 18 Apr 2024 18:09:43 +0200
Message-ID: <20240418160943.95047-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418160943.95047-1-philmd@linaro.org>
References: <20240418160943.95047-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename 'store-insert-al16.h' as 'store-insert-al16.h.inc'
and 'load-extract-al16-al8.h' as 'load-extract-al16-al8.h.inc'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 accel/tcg/ldst_atomicity.c.inc                                | 4 ++--
 8 files changed, 2 insertions(+), 2 deletions(-)
 rename host/include/aarch64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/aarch64/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/generic/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/generic/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/loongarch64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/loongarch64/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/x86_64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)

diff --git a/host/include/aarch64/host/load-extract-al16-al8.h b/host/include/aarch64/host/load-extract-al16-al8.h.inc
similarity index 100%
rename from host/include/aarch64/host/load-extract-al16-al8.h
rename to host/include/aarch64/host/load-extract-al16-al8.h.inc
diff --git a/host/include/aarch64/host/store-insert-al16.h b/host/include/aarch64/host/store-insert-al16.h.inc
similarity index 100%
rename from host/include/aarch64/host/store-insert-al16.h
rename to host/include/aarch64/host/store-insert-al16.h.inc
diff --git a/host/include/generic/host/load-extract-al16-al8.h b/host/include/generic/host/load-extract-al16-al8.h.inc
similarity index 100%
rename from host/include/generic/host/load-extract-al16-al8.h
rename to host/include/generic/host/load-extract-al16-al8.h.inc
diff --git a/host/include/generic/host/store-insert-al16.h b/host/include/generic/host/store-insert-al16.h.inc
similarity index 100%
rename from host/include/generic/host/store-insert-al16.h
rename to host/include/generic/host/store-insert-al16.h.inc
diff --git a/host/include/loongarch64/host/load-extract-al16-al8.h b/host/include/loongarch64/host/load-extract-al16-al8.h.inc
similarity index 100%
rename from host/include/loongarch64/host/load-extract-al16-al8.h
rename to host/include/loongarch64/host/load-extract-al16-al8.h.inc
diff --git a/host/include/loongarch64/host/store-insert-al16.h b/host/include/loongarch64/host/store-insert-al16.h.inc
similarity index 100%
rename from host/include/loongarch64/host/store-insert-al16.h
rename to host/include/loongarch64/host/store-insert-al16.h.inc
diff --git a/host/include/x86_64/host/load-extract-al16-al8.h b/host/include/x86_64/host/load-extract-al16-al8.h.inc
similarity index 100%
rename from host/include/x86_64/host/load-extract-al16-al8.h
rename to host/include/x86_64/host/load-extract-al16-al8.h.inc
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 97dae70d53..134da3c1da 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -9,8 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "host/load-extract-al16-al8.h"
-#include "host/store-insert-al16.h"
+#include "host/load-extract-al16-al8.h.inc"
+#include "host/store-insert-al16.h.inc"
 
 #ifdef CONFIG_ATOMIC64
 # define HAVE_al8          true
-- 
2.41.0


