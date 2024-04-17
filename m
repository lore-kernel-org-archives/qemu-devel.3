Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E58C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA1j-0007vO-Kg; Wed, 17 Apr 2024 14:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1d-0007nh-5v
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1b-0003Lr-DJ
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-418c979dca2so465925e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378530; x=1713983330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO/V4plvXFYo3PYcgn25HOreAsh2/yu478RHuCQmS58=;
 b=XqBJsYV+nnS4JPxban56kGYhKdwRwD5Nfqc1Y9a/dF8PiGJjzWsSo7q2ul7jyljFg+
 +BgxxG7tm2BmHmUXCXA0hac6L1LllsX7MGOnVFHtknFra71kMazysYTcgyk02o67SNhQ
 Um0ZVLBCqLcDbZZ2U0R+zc1MeK3FeXdoAdQlcwDBoo9Kdw4YTV9F23mOeoFm10TNS9Sb
 AtID+omiQVuTAhn2rkLXzgnHhxAMuLiIyh8xWg8R/0WUL4jJsMul23OII6swpFm2WQit
 lLw7J9yCteF7712d2cXxa/fbgzhdgBCL7ang+CsV3VByjLMhAmsk45fPMTOlJf8UirZl
 h77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378530; x=1713983330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BO/V4plvXFYo3PYcgn25HOreAsh2/yu478RHuCQmS58=;
 b=dm8DI4eqdMU+oEjKTFtfbq1qimwopOloPJX67H+tNMYMpUS+vcHmPGwqNfzO2aCTrm
 cLfl6kY9vH1JaKMGVEbdlzvoYGLm4jaA2QU1dkc8nvrdonQWaM/X2+nLAyNlIrCmH8Ik
 E/wCjT2r6F2y4AjpdEd5DDyPG5/igwbaNqB6PIqFYiOBAzmbsJNOi7WC+WLRyKgZNZJs
 u99+x2+jjUtm+GH+1EtylbJCJwDnyCR/QEiRjVYOPkYpfroKjuNj0mq5Q2UbcV9QefPX
 XPZLx/O9B2+B89NZloPXEZTCh+JfZsf5U8tlU+j64KTv99fjr3d6EyFPC4An0bK+AKsg
 irRw==
X-Gm-Message-State: AOJu0YwhAhCa3QyMueiSLH0aLdkrBUx9mPd5bkDcgksgwePBiZzT18Gt
 1uNld+DKTaxOdWqNCc0tlpM8+sYgnLVZYYcjw3ohuW51DMO6wT1rS0WL+juKFnCZBZYpxMIvRmP
 v
X-Google-Smtp-Source: AGHT+IELqrR3gHtN8nqLMQ+Lun5Ky8HL4C3a3bel/8ayw2k+uehL7BxMeT9zID+4P83bcKuT5k9VIQ==
X-Received: by 2002:a05:600c:444f:b0:416:af4d:e3dc with SMTP id
 v15-20020a05600c444f00b00416af4de3dcmr335223wmn.12.1713378529861; 
 Wed, 17 Apr 2024 11:28:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c470c00b00416a43d60e6sm3740010wmo.39.2024.04.17.11.28.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:28:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/21] accel: Include missing 'exec/cpu_ldst.h' header
Date: Wed, 17 Apr 2024 20:27:52 +0200
Message-ID: <20240417182806.69446-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Theses files call cpu_ldl_code() which is declared
in "exec/cpu_ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-5-philmd@linaro.org>
---
 accel/tcg/translator.c        | 1 +
 target/hexagon/translate.c    | 1 +
 target/microblaze/cpu.c       | 1 +
 target/microblaze/translate.c | 1 +
 target/nios2/translate.c      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9de0bc34c8..6832e55135 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
+#include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index f163eefe97..47a870f42d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -23,6 +23,7 @@
 #include "exec/helper-gen.h"
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
+#include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "internal.h"
 #include "attribs.h"
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 96c2b71f7f..d05e2e6ea7 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/gdbstub.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index fc451befae..6d89c1a175 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 7ddc6ac1a2..bcfcc3b112 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "disas/disas.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-- 
2.41.0


