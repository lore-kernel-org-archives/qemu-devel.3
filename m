Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC4BC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaoL-00032D-O7; Tue, 04 Mar 2025 17:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpamC-0008FM-Hg
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:17 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpam4-0007nK-MA
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:08 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so1142626766b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127394; x=1741732194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vs8Rq5vK4O3QcQ93DYTQizcZdV8tDfXluF6Fck8WA/w=;
 b=ANe3VcYBrJflqJsd5isrrmoijLUGlbFhZWU7Uputxcg4MeSpiRgJF31mDog0Lv0y1r
 hjC6tpw89hTKI3JFjbpc3Rkn7aOv+sTh7cQY15ZylKPTwjyYZ3X9AQ+ogCTIkUpDCOlC
 s7BzNwOH3V8ZN2jPQIP2mGcG9DmZeJE5gOzKGg6MVQU7MIQoUzpECydAfvcNMan99hke
 rP8EU6s6GpYVMw0CFu2Hx93c/S+mlY+cI4o0ePzfnreFpNQrLkqRcwi1fkHWCleg8zj2
 SO3JlENrgtDnJxgjtQdzuYijJOtzvulqMKCHY3sXsDiu8ezoSF2DdpdCmtvALv6emn2s
 1MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127394; x=1741732194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vs8Rq5vK4O3QcQ93DYTQizcZdV8tDfXluF6Fck8WA/w=;
 b=nxAOpCEUwv7gd25joxn/FOYHbTr71+YcU72PkafWCkKuyE9w6gCwUjnbFAgttqPz8o
 tYMNCTPiOFt2ZH7M+Q2yAW37DDLr7ewv4K03OzVhPzlwLFkCgZxyJuS1OC/Xg23bUMHr
 IrNAmsXQDdxoZQAPx+GV0Yf8EpQnD4/5/1OexRZQUTMb7rRqFvXT2L48WHZtJv0hJP/B
 YbnxFFs7T9jPpOBaTZe4bNghhUWduow26b9WBkUtu8Xzbzv6hvnr+wLZj/llXE0ddCsn
 dXNL+G0QymuNCATbskwWqcNQJvxQalfeBWqR5y55bBIl/K6FGnISnYGLYuzY3jICqAP1
 XdTw==
X-Gm-Message-State: AOJu0YwKv+ycqn4fyVQ+oVDkq3fpyg9KTNDWkfhyOnDkrrIf95cx2SmQ
 1UJfgqowBIduPmWfcmMX5C4d1Z0sHrZF0Fqj1uPjNOG/SV12FwINyna2JVA2KqY=
X-Gm-Gg: ASbGncsnPahFrMim/7wzGtwkxN4QtZLvNQD2SmpYSsxotjh00REosNDAvj/Rm+/nfTz
 mP6tad6hEcXM1JeiJzmtY0SdRNzVBygBmn2ZH0jthEQ56YupKuC8hi8IAK+Ncbrc9NqZzB/vlW+
 Wrwb2GLsYN1nZnladSYnXsWse0nYeFYmKdkRazRr6mF+Vgt5hSodwWW7Gx1gQdwEeMYl/kNTcUu
 5Uwo7Z29v4UNCLWM/0lqLt8NjOw7oSRH604AwFUO8Xb5AMg+gMxt2PX2Ca3AWW4IVHhGasaJxPn
 UEKcugFAnaKEYd9UYyeb26vPF5QeAVTMTJ+UbmN6ZEmwm/A=
X-Google-Smtp-Source: AGHT+IGtdbmmxeiqyHFfTDIi2flxRaGrEeujkcX0BvY7zfLHGa/tnJaz2dLlSmkXnRI33PO0KCS8hQ==
X-Received: by 2002:a17:907:94cc:b0:ac1:ed46:7bf5 with SMTP id
 a640c23a62f3a-ac20d8bcbcbmr76665866b.19.1741127394284; 
 Tue, 04 Mar 2025 14:29:54 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1e87587basm253720166b.66.2025.03.04.14.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:29:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 657FD5FC87;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 20/32] plugins/api: use qemu_target_page_mask() to get value
Date: Tue,  4 Mar 2025 22:24:27 +0000
Message-Id: <20250304222439.2035603-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250226140343.3907080-16-alex.bennee@linaro.org>

---
v2
  - use the proper qemu_target_page_mask() api
---
 plugins/api.c                       | 3 ++-
 tests/tcg/hexagon/Makefile.target   | 2 +-
 tests/tcg/multiarch/Makefile.target | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

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


