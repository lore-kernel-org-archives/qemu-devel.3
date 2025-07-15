Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACBFC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgu6-0006HM-Sx; Tue, 15 Jul 2025 10:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDn-0008WV-4w
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDj-0004Pz-U3
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so27624785e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588081; x=1753192881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03a8oqVougUj1P1XLqtmU+cmDY2pUCd+NDIqmAcfEn0=;
 b=k9nwin5OD1qPTuTH7qolZ5l9IdVAT0bAbqcityk1tE/3O9KBFfJk61VTRnMlOseTQc
 bHVD5ZrmafJP+tqiah9qbxMKslUi/RbdAxQDRG4NqXxIR5tPzLawq66zTLbkk6R0Dcog
 5QmyS5dl0fPSeIPD8UdlHc63ZXSiS1rZOQXyKnPN8dk/CqwwY5wtOgbMXrtSKbJo3PZn
 RKNsIRHZPzMbOI/DgMeFP/aM99L+KU2GuHxk0qo3iNXRtRf/NEYjXoiqGrNOa/iBJQ32
 Rh4oRDnbYPrmt18BOrddKu3P8/LihW7vqoajbAvpO3H4OmInc3E8IfUIc/nfc2BXBU6S
 zhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588081; x=1753192881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03a8oqVougUj1P1XLqtmU+cmDY2pUCd+NDIqmAcfEn0=;
 b=Y4ISmlT6Mtvm0zWQkh8vQIXf71hbQwAHG+QWrI9hHQMmMct396MULpAYVw3LuzHfq/
 tcxItTFJDnupzVsbaQPyvQPozxqYbbn2LkAxdpaQLW/bIYn8ItMr12Y4ij75M0W2UXpe
 FDNd4d7kL44Bj/dulfvpXYoG80sbS2D4hgnvYU5cPfK2/QqJ1TnneUrBSb3hcbnlKJWX
 uMdnNzaS7PYpoQbUajdwMfYUI0ye/bNaMZm+/VYSqPwHRQay8huewa/uLrjkeg0RezcF
 1Ni1QmDYUiCnWns04T+aw/BxyYF2zCqN3uFOj1VhhaBUBOAUK7I5oSiRjSvfp7sgO5GS
 4z1A==
X-Gm-Message-State: AOJu0YzE4kMSsC2qYkc/JSLXEzWiU6itmEbxgqXJbj1/slkxHiV1hfQA
 u5StjCQ/zGyutpysDRw0T+7ey+8AGVTzVbl04rauiwDEDxcsGNiBvYdVza2Y2G0pp2yimRK97xO
 yWpwE
X-Gm-Gg: ASbGncukw9nwa6hrDjwPkQOZBmD34+qHmjQOfyJkPuZ/1twIorab3tHOX6i09B7OMjD
 ELUeKCAzI2VXTlQVEqkBsvnUPWfr9ELsGprJZwAAuJ85AaGYcjOuo0me6wwG/Px1hvaRil7y3zB
 KaKLplw98vSAeEUM30TJpMGEzKXQTS3kf/mpaSPLAmazwFnzx2pca/MRWyW3/lISCWyxBum07HJ
 EHxYnkqV6713WcbovCW72y3FM0UbhDO/g93nXQQZGpHo7P5b0f9kFtoFGZh/jW/6XhLxNBZQ6do
 +zE/NIT2HMD1VDy84zwEEq63rNriENcAab34dyyLVhiMBG8b8hc1o8BHtSr71csOHs34SwU/4jn
 3l2RK9MMsQ4HcHC1Ufapw4OUDoF4WOoh/2EdGoLuzYZMydTxwBGXVvmjB0itb1Uz8RHhhtc7Lml
 0Qxg==
X-Google-Smtp-Source: AGHT+IE7urS6kxw6umdWe3op099cCN6bAyv1d3hvKdA3YEjSU1MSyo60lGjfmasN/Lw51yO8qGA/EA==
X-Received: by 2002:a05:600c:4f94:b0:456:43c:dcdc with SMTP id
 5b1f17b1804b1-456043ce1f3mr106786515e9.33.1752588080969; 
 Tue, 15 Jul 2025 07:01:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560d019f1esm99178635e9.10.2025.07.15.07.01.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 07:01:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH-for-10.1 v6 5/8] accel/tcg: Propagate AccelState to
 dump_accel_info()
Date: Tue, 15 Jul 2025 16:00:45 +0200
Message-ID: <20250715140048.84942-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715140048.84942-1-philmd@linaro.org>
References: <20250715140048.84942-1-philmd@linaro.org>
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

Declare tcg_dump_stats() in "tcg/tcg.h" so it can be used out of
accel/tcg/, like by {bsd,linux}-user.

Next commit will register the TCG AccelClass::get_stats handler,
which expects a AccelState, so propagate it to dump_accel_info().

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 2 --
 include/tcg/tcg.h           | 2 ++
 accel/tcg/monitor.c         | 1 +
 accel/tcg/tcg-stats.c       | 5 ++---
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 77a3a0684a5..1dbc45dd955 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,6 +139,4 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
-void tcg_dump_stats(GString *buf);
-
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0c2a319c11d..a6d9aa50d47 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1005,5 +1005,7 @@ static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
 
 bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
 void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs);
+/* tcg_dump_stats: Append TCG statistics to @buf */
+void tcg_dump_stats(GString *buf);
 
 #endif /* TCG_H */
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index adb9de5a1c6..be5c1950177 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -12,6 +12,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
 #include "system/tcg.h"
+#include "tcg/tcg.h"
 #include "internal-common.h"
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
diff --git a/accel/tcg/tcg-stats.c b/accel/tcg/tcg-stats.c
index eb6e20ae985..e1a1c4cf4ac 100644
--- a/accel/tcg/tcg-stats.c
+++ b/accel/tcg/tcg-stats.c
@@ -37,9 +37,8 @@ static void dump_drift_info(GString *buf)
     }
 }
 
-static void dump_accel_info(GString *buf)
+static void dump_accel_info(AccelState *accel, GString *buf)
 {
-    AccelState *accel = current_accel();
     bool one_insn_per_tb = object_property_get_bool(OBJECT(accel),
                                                     "one-insn-per-tb",
                                                     &error_fatal);
@@ -209,7 +208,7 @@ static void dump_exec_info(GString *buf)
 
 void tcg_dump_stats(GString *buf)
 {
-    dump_accel_info(buf);
+    dump_accel_info(current_accel(), buf);
     dump_exec_info(buf);
     dump_drift_info(buf);
 }
-- 
2.49.0


