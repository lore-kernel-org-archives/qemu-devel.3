Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529ACFF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH20-0001rd-Ln; Mon, 27 Apr 2026 04:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1e-0001GK-Sx
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1c-0001pO-2R
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so84331895e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277340; x=1777882140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1bo5Y+UZCJy4gHCz2x1tdhwNQXL4/DMiX/PocQwagYM=;
 b=uIoHhn+VBCk5qT2LA4uhOEj2ZzjKNT2LxZnXoTuDMsMrnSGagsM8eFwdOxKeS+bgEI
 vMS5yCRJK3e+Uz5whDqXaroWFS8HQpuHojO43z5BgZrrMkyUHqIUqZhi9srwaoSaegN9
 foLBdX8C1An7z1DVTrChygeCQilz3PSsR0GsFYhMZHOQVmfjEdR6NPZo3B1JDobBv72j
 NDEqItw3aMI12mchfJqNxtT7pVev9CLHpgPYXBc5y/Wz27o9KXffEWTIR25EW2MaOe3v
 hOghjIS/KthyZn57uDgU9oBnpjMFXVVYpPy+UgZqVrsg91R7SrH06CJ4T2Hq9Kd5hwxX
 ABqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277340; x=1777882140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1bo5Y+UZCJy4gHCz2x1tdhwNQXL4/DMiX/PocQwagYM=;
 b=WLC4IhtkO/J92YLLK/h0mxeCH9yOy45Az0ncdfCSBPjQej29QBb2CxzNN8bDjglZ0h
 5hlWwCNcx6agNApIw3UAKFpyJtrfbNy+7kMhtkYMN42mI9exxjPYSjgPNpEQr6TD0Sl9
 9egXnHrCwoGjZ5atxtuxO17iA0cW7J4Xm0Z3s8kFdDN/75kK+oTXIJeqMpwnYHgamqV1
 uBafYemDInicea/Aj91IhXYhBtN2C7jSDTm/vG/eJrjxBSdB3yYAKuBVIqpLQEyLP1w8
 9jzfkl+FWxl4J8MiI9QygjJi0qXYt4uK9C3QISR2s/nCGDoXZ60mG/A/L17GtgDzN1pF
 xJJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gV7zejVF4rEViZGWPF+ciL+7FaXuB8l0BPTsYwU1t3pQr3ZEnvAReBBkGO2WaHmT2d83IiBAmrzGN@nongnu.org
X-Gm-Message-State: AOJu0YxbSxHl4romJgGA1KnN0cS32KWcvw9GLElBSFoq3DV61E2YYXeB
 nmFla59MksTlFc0s6n7XcTaEw/cjIiFe7RMbWfWc3VMpwSXuQ/M7Im7E/WsDHBDK9lQ=
X-Gm-Gg: AeBDieu00ex0obK65Igulj55ep55Tc7g7HhGTo7GjwkvakxhAyRjhKziYSKRKb+Dxy6
 nLzhbOvc7twW+OFsKrdW9KgylIYdDIP8nWafnapM3UYwzidwtvno47VOV9b72kkF0Jmxf//T1Hc
 wUlLV268UutULnnvi+0pyX7FftKwU0TOQONPRCVJhCOgfkSkGYZHVnxB+l+9Xolaff/5q7j7KL6
 hseYMJwfi9ioFXoX+wjDV5tavNL4dVv3fbroJ4j9YcewGtBcGynTqxSxkYau8D8ROf0PNDcBBZ4
 iBiaTUfFJDIjrMTMNI36YXKA+JgwzcvOJ/7LQhVMvsgaREqE2E5hcTdjMmK6bftQRKJQFIl/ksO
 ZPuLrv/wiKY9rPecNLkyvX1kzJaWAdE2fhT1NqNFy1h99F3spNr3n2HjKLBAbo59SJbnfbdt8AH
 q+qSBB8F7TQH5WY18bkVDY0TAnGqCVB3zfxefL1JaKG2/q5zspapFGbQ03gadQu2eI+kff+V1YU
 J0aob62XTU=
X-Received: by 2002:a05:600c:46cb:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-488fb7451e4mr611543445e9.5.1777277336726; 
 Mon, 27 Apr 2026 01:08:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c773fsm858727835e9.12.2026.04.27.01.08.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 11/32] monitor: Introduce HMPCommand::arch_bitmask field
Date: Mon, 27 Apr 2026 10:07:17 +0200
Message-ID: <20260427080738.77138-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
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


