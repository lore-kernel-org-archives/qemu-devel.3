Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30871C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Dg-0001yi-PR; Sat, 08 Mar 2025 17:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DX-0001r6-3x
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:23 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DR-0001vq-Fc
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39140bd6317so250954f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471216; x=1742076016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+gu5ogQAWZshVelvD/gHWlmrGalgc39BzbRjaxXUb0=;
 b=P1x2MFOyZHITd0VCFyOsO9hvXA9/PyN/+0E5YwiyEYg0Ha+PwAxDqE4IcaqWrP7yCh
 Xv7Si4VSIByDM4lGu5nbRCBRB8+97OMXBBSAJvE/+icFMsgB4H1FG1Z6rqGwXOrk1+na
 cM8Y9k8Lt3UW3YI9Eo31n23JoUWOpP1jshr6aCmu1+FaDbVWD+8lDeiZUXlshE6QQksD
 o2jGPtMWapuZVOBRtp8YjKAuQLBWlZ//bhc1MB3196HlvGXuQcxAKYr0a4SU/gdk21tL
 GCRicVLBrbG7SxeKBzjqoV5XX+ISGerFX9YbCbxSUnJjeygkseqcJeHnMblMteSZzC15
 sgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471216; x=1742076016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+gu5ogQAWZshVelvD/gHWlmrGalgc39BzbRjaxXUb0=;
 b=sMUwHNJ/rxwiU9mp4AXfHDLeMyCO1wKpmD/zuSwKKFnn30GQwgVyFcTA9VHzgqUAeY
 yKwKVXG7m4FTyeOVnLKqVUVg5sr2Gk0Fi19R9fheGmiERErExIjOpVeJoxXMyXMOzn2y
 SIG+vJFUBsrgOYNcySNL3SAZd3HysiVD3MX1neGbbNegRU+Bzm3+WR4KbOavmUUxiSY8
 sFSpH/LG2Vpp2gTwAqk9OGPvXeGCZ/f1E+6I2WYS8A1FwExlWfa00hOp3ZhfuHiRluyM
 eUl+q8czjhoaANxEXR/1+9veN46OmYGZ8oWu9+4Uw+ZE8UNnrxdlrLC4MpOhkcnE/m+S
 X23A==
X-Gm-Message-State: AOJu0YxKVPXLjqnhfBY67F0pcPyFjcLJL6yYIVNv1FrlO9Xvlm18f4dT
 qLcIQD8ACwCE7wTJGZpgy3SXnEu9Y0Jo4gQ0n4A88+Kj4qNWp4QvL8Ngph7GiqqVPw2y+zu9CL6
 A
X-Gm-Gg: ASbGnct8L+4ph2e02V8kcgb2NWqs2Y75X0+jnwW6NyW65MFSNR1txNke3K+RwDG/0CC
 OBp01KDML6SAC0Oa+Y4fO+k4B4l6GzS4X9k0LiRVtS7mehBzM1ODTDfKkP0GkVaQ42EFm1R7JG8
 4cvplbBsOtSlKT2kdjWcrHyVQYbCwR6Z0vWg6Emg2W6hB5+DG74p5NXL1Pi4PWTAUnGJZcrn3T2
 jgaRs5QbrzS/ivSJck8BTtsBrVAEf8lBVxKlzj0t3/Zx0wjWBcwuTxZokzCWGiqKnCf0Mcva0lP
 7q0xqeQGAB3ZhH1Yfwdl8xm/Q4BJgiUgjmbeeILj71VeUJjxIKkcivHjLA==
X-Google-Smtp-Source: AGHT+IG2jiOEDPTqG92RfaD0GuU7iKgu8zQm+OOJ06p9UHWth5XrxWcyckO/i/rKBwPKPjw4f8WiPA==
X-Received: by 2002:a5d:6d8c:0:b0:390:e48a:3869 with SMTP id
 ffacd0b85a97d-39132d774a1mr5083686f8f.11.1741471215662; 
 Sat, 08 Mar 2025 14:00:15 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01de21sm10091320f8f.59.2025.03.08.14.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7ED3A606D9;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 20/31] plugins/api: use qemu_target_page_mask() to get value
Date: Sat,  8 Mar 2025 21:53:15 +0000
Message-Id: <20250308215326.2907828-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Requiring TARGET_PAGE_MASK to be defined gets in the way of building
this unit once. qemu_target_page_mask() will tell us what it is.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-21-alex.bennee@linaro.org>

diff --git a/plugins/api.c b/plugins/api.c
index cf8cdf076a..fa4d495277 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -43,6 +43,7 @@
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
+#include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "exec/translator.h"
 #include "disas/disas.h"
@@ -287,7 +288,7 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 {
     const DisasContextBase *db = tcg_ctx->plugin_db;
-    vaddr page0_last = db->pc_first | ~TARGET_PAGE_MASK;
+    vaddr page0_last = db->pc_first | ~qemu_target_page_mask();
 
     if (db->fake_insn) {
         return NULL;
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 4dfc39bc98..e5182c01d8 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -18,7 +18,7 @@
 # Hexagon doesn't support gdb, so skip the EXTRA_RUNS
 EXTRA_RUNS =
 
-CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal -Wno-unknown-warning-option
+CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal
 CFLAGS += -fno-unroll-loops -fno-stack-protector
 
 HEX_SRC=$(SRC_PATH)/tests/tcg/hexagon
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index c769a7d69d..45c9cfe18c 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -51,7 +51,7 @@ sigreturn-sigmask: LDFLAGS+=-pthread
 # Since this is just a standard piece of library code we've borrowed for a
 # TCG test case, suppress the warning rather than trying to modify the
 # code to work around the compiler.
-sha1: CFLAGS+=-Wno-stringop-overread
+sha1: CFLAGS+=-Wno-stringop-overread -Wno-unknown-warning-option
 
 # The vma-pthread seems very sensitive on gitlab and we currently
 # don't know if its exposing a real bug or the test is flaky.
-- 
2.39.5


