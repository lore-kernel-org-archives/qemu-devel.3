Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE06AF531E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgM-0001fY-LV; Mon, 13 Apr 2026 20:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgC-0001S2-6M
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgA-00039b-47
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so32220435e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126656; x=1776731456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bo5Y+UZCJy4gHCz2x1tdhwNQXL4/DMiX/PocQwagYM=;
 b=LYj+B3S97dxjy7f6ZCf/qmbLRl/SOhttxHpYUpIVCfORDz7nBQ5nFwEY+szRPJLMHx
 qAyITHyQHjR+xdqk7qMFK5LoLLndIkNfbA9JvE4QWg3CKtZDKkUvDnzfUWjRZGzabKAz
 TpQxkU8u1HxJ52Npms+5PRfXG1syrAWkrVye6LsK+5V8PyReLi8f5LwrUjOcsoJNuF58
 9UpusRNdxD1iReHNAHjZyM/K4xifSb0xgxK6FaR0aH1PXXIYv9Mg3W5Z42TXSyjzbHJB
 dFygrFNFOKc+Cp2hGJzz0tvIksF7k3re4tM4tOObLJwQvGhnS6XXryYOO/sIJIcsESoG
 yM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126656; x=1776731456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1bo5Y+UZCJy4gHCz2x1tdhwNQXL4/DMiX/PocQwagYM=;
 b=PsiQ151SYQXz4YLLkmkGag4Zg6oBW98Xqob+9RxP7CDOy5GLNGofilJ3ZLfoBE1dqI
 14/fdTwwIu3rEcIZ70jfS9vGOymkhdkQFqxqsSUMo8Ap230qtdOJ8P8JCaSe91btsklu
 cZjQSkfvRoWmf/ZiFu6sEe43b93MpeuavBxKrWVcRx9JURFPA0z9VkJqilZpVy3fFsnp
 CavhX0hVekicqSjqKO0Yc7vhslnji93BsBdgZ2f87EV6i5Z9AeXV/P9i9jffEGkrz1qF
 72XA9eteW4IlopWKTVY5uqaupMUP8S6vh3WGkchZxHlLHCBmEMRhY4lETX5xy7MKLk3p
 AVWg==
X-Gm-Message-State: AOJu0Yzr+FXY8BiEKzyIHs4k8DzBIoYGPxHQDkzTSAw9Fc+HFIAuLWIZ
 OEIj9NFD615B5CC2YYpTLonooSu9AZytx3aDSS2q3MYUDMkKtsPdaTdenNjQEW+rpC8ajSwihM2
 tklVMFhg=
X-Gm-Gg: AeBDieuvEb4fvA7LCshieTqzmOOnYJXDuEP0rzJo+UiB/I4OTQ3Ak9xqbs1tOdlO/VW
 BIkPFL3inIts1tK6ZvjrSSoq+fcukfwHzxtgV+dqTguu86SsM3nK7Ev29m+rOpZCBILIqQ5m2fb
 YAsRrczokgBYVqLwahrC9o+iS9nlG0cD2sZHtFM/7vhDQvaGfiFsU0OmdUdxDmqxLrao3yuHbe1
 3u9PTFFfuooK+15Gt17LKW/aU8x+lXFYpEnCfTTww5OWZG/K4/kXgAjxws+ul5QImJPABSu5Ohh
 HdJsj0GuBDgibmehOASkFJRbFETwD5LsY0nK8SQ/6mDLbjVj3G9pltSgfpRGb2+p8l+2pLkRsKJ
 jby2vktscGEkhSqcPNP/huoC8v/OfQrArKHnHSvRlO17AXVSyS8k3bYPh0dgf1mV6AzzWl7XieD
 7GIw0sLR82NHDIth9E5VUc+cmEBRHBodeXQOk+nsD12J4Bq+XCl5+btVOJYbNtBxCAU1enw+yY
X-Received: by 2002:a05:600c:8717:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-488d6816f5amr210993855e9.3.1776126656164; 
 Mon, 13 Apr 2026 17:30:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede156a1sm5574775e9.2.2026.04.13.17.30.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:30:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/27] monitor: Introduce HMPCommand::arch_bitmask field
Date: Tue, 14 Apr 2026 02:29:39 +0200
Message-ID: <20260414003001.97571-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Add the @arch_bitmask field to the HMPCommand structure,
allowing to restrict a command to a set of target
architectures (represented by the QEMU_ARCH_* enum constants).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 monitor/monitor-internal.h | 11 ++++++++++-
 monitor/hmp-target.c       |  1 +
 monitor/hmp.c              |  4 ++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 80b4a8150bf..eaf9a607783 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -82,7 +82,6 @@ typedef struct HMPCommand {
      * the formatted text.
      */
     HumanReadableText *(*cmd_info_hrt)(Error **errp);
-    bool coroutine;
     /*
      * @sub_table is a list of 2nd level of commands. If it does not exist,
      * cmd should be used. If it exists, sub_table[?].cmd should be
@@ -90,6 +89,16 @@ typedef struct HMPCommand {
      */
     struct HMPCommand *sub_table;
     void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
+
+    /* Keep non-pointer data at the end to minimize holes. */
+
+    /**
+     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
+     *     Allow to restrict the command for a particular set of
+     *     target architectures.
+     */
+    uint32_t arch_bitmask;
+    bool coroutine;
 } HMPCommand;
 
 struct Monitor {
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index da7dd7f31f2..f6dce326cf5 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/base-arch-defs.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0e5913fabb1..e881c26c305 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -36,6 +36,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "exec/gdbstub.h"
@@ -219,6 +220,9 @@ static bool cmd_can_preconfig(const HMPCommand *cmd)
 
 static bool cmd_available(const HMPCommand *cmd)
 {
+    if (cmd->arch_bitmask && !qemu_arch_available(cmd->arch_bitmask)) {
+        return false;
+    }
     return phase_check(PHASE_MACHINE_READY) || cmd_can_preconfig(cmd);
 }
 
-- 
2.53.0


