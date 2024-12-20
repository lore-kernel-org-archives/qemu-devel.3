Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35792E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfiZ-0002Ji-QJ; Fri, 20 Dec 2024 11:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfi1-0000op-AF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:37 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhz-0008An-AB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:36 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1632090f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711513; x=1735316313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lX+3v+ThkvUGMqddtO85tyC3n6hhb/QJb2DoFh9EAE=;
 b=eeT+I61fgz6vs5xNJFVu+eEoYrzQsiYX8vBonqBJApgmmOFude1UuHP9d3N9OCTj21
 zuj61hAxFO9aa0OaP+AYAdl7a2twmD/QGxvdNb9fbaTc+3HIs8baJgMOFssCyZemH0if
 5Ltx7Oc/kuwf5cG3tkfH7meWgpngFySWiQHhzAU/NcKKX5zZWzG0BkURPliGwYQ3DmvW
 9NHTwBewkd3cQQBwFq+MkRBRzaOGwCAN1c28z4Sx4T+5zsEuM+j0wVXijNzu+Gqc21S9
 LMTZuOunyGmSnebAPv9ZngmFyLAdLLM7M851BHT/G+7iA7OCQJ/e/5MPpONaHqcXQJFl
 +oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711513; x=1735316313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lX+3v+ThkvUGMqddtO85tyC3n6hhb/QJb2DoFh9EAE=;
 b=W39z1uzu2VSYAxiEhO2uzIWfXOnMUHWux4Pln/FftT2Sp0Yav0IC2A9jXcVTPXGuTu
 kTNXg2nmCiCHORVR/gugk47t6Mm30WBVO7YjKtRR0/dUO55q3A3S6XqLPddjytDQ9LRe
 geGk9/jniBJ7w3NlABKHPgXtbF0NDN+dCQqpn19I3aRWCTK+6vYGRXBzLd501/Q3xu7J
 6T373ZUvedcfYtswFUzGRUzpJVW0f+kyDTVSgUN8VkMrOPcaEzahhHcCxnc6PevCMykI
 jb14Hfs6m/3wkNS3HisOHmQR98l4Z4Yi3q00kcatNHxgkeqLmXiv7GH1u2c0ok+oXX5r
 fPUw==
X-Gm-Message-State: AOJu0YzSeCUIZkfD136fJ7rHkMaHWpHNZjtm9C+9+kVCc+AxqmgkABHT
 BzqDCmmtvQl47d43HpUGm4iAqQzoCyZsZAMWX1IdIjhqeBwMSOioNRZATQxjpB0IOom5h36WmEd
 F
X-Gm-Gg: ASbGncvrUPjc1q3g0G4qPfJT8OUY4mFyyFVsse6oPO81c13SKUD4yZfqojtfXmiddTj
 qRyYjkwQxwsD2Pj+TrHkM0CVbx7A0Jo2KIP1WtHsPBjkcSXweBYK+VCEsOsCu2UBXH7Fahyi/so
 NBGmQAkCKxwISZnaBpM0OArJCn93ykXMr6HibfzzzhIqJxLHXDoorBfH6jkcLiThvAomyZcAaiO
 4D7feg93eqvJDQiGqQ2UYObEuDZQuKFaPzgYGjclm3xDDcw4Q6+ndvxHwuxhIuema20TMhcnH0=
X-Google-Smtp-Source: AGHT+IFu186ulEaVkVZTf7nYRPHNuw0Z4aDJwDm893Fj2vPPZDYOVInfSXQT/7JPwuTtF8P6Q0Q8GA==
X-Received: by 2002:a5d:5e09:0:b0:386:3e3c:efd with SMTP id
 ffacd0b85a97d-38a223ffb0dmr4129608f8f.44.1734711513522; 
 Fri, 20 Dec 2024 08:18:33 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832edasm4390237f8f.36.2024.12.20.08.18.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 35/59] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (3/4)
Date: Fri, 20 Dec 2024 17:15:26 +0100
Message-ID: <20241220161551.89317-36-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Move declarations related to page protection under user
emulation from "exec/cpu-all.h" to "user/page-protection.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-14-philmd@linaro.org>
---
 bsd-user/qemu.h                |  1 +
 include/exec/cpu-all.h         | 12 ------------
 include/user/page-protection.h | 12 ++++++++++++
 linux-user/qemu.h              |  1 +
 target/arm/tcg/sve_helper.c    |  3 +++
 target/hppa/op_helper.c        |  3 +++
 target/sparc/ldst_helper.c     |  3 +++
 7 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 3736c417860..04faee459df 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 
 #include "user/abitypes.h"
+#include "user/page-protection.h"
 
 extern char **environ;
 
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 86cd40020c9..73b11f58abb 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -130,18 +130,6 @@ extern const TargetPageBits target_page;
 
 int page_get_flags(target_ulong address);
 
-/**
- * page_check_range
- * @start: first byte of range
- * @len: length of range
- * @flags: flags required for each page
- *
- * Return true if every page in [@start, @start+@len) has @flags set.
- * Return false if any page is unmapped.  Thus testing flags == 0 is
- * equivalent to testing for flags == PAGE_VALID.
- */
-bool page_check_range(target_ulong start, target_ulong last, int flags);
-
 #endif
 
 CPUArchState *cpu_copy(CPUArchState *env);
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index d21fab1aaf9..bdd98a37de1 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -34,6 +34,18 @@ void page_set_flags(target_ulong start, target_ulong last, int flags);
 
 void page_reset_target_data(target_ulong start, target_ulong last);
 
+/**
+ * page_check_range
+ * @start: first byte of range
+ * @len: length of range
+ * @flags: flags required for each page
+ *
+ * Return true if every page in [@start, @start+@len) has @flags set.
+ * Return false if any page is unmapped.  Thus testing flags == 0 is
+ * equivalent to testing for flags == PAGE_VALID.
+ */
+bool page_check_range(target_ulong start, target_ulong last, int flags);
+
 /**
  * page_check_range_empty:
  * @start: first byte of range
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 67bc81b1499..5f007501518 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -5,6 +5,7 @@
 #include "exec/cpu_ldst.h"
 
 #include "user/abitypes.h"
+#include "user/page-protection.h"
 
 #include "syscall_defs.h"
 #include "target_syscall.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 85fe3cae3ed..d0865dece35 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -29,6 +29,9 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 #include "hw/core/tcg-cpu-ops.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 
 
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 744325969f5..beb8f88799e 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -25,6 +25,9 @@
 #include "exec/cpu_ldst.h"
 #include "qemu/timer.h"
 #include "trace.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 
 G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
 {
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index d92c9f15934..4c54e456553 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -26,6 +26,9 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 #include "asi.h"
 
 //#define DEBUG_MMU
-- 
2.47.1


