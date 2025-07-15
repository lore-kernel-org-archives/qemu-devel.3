Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDFCC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubd5s-0004xl-Pe; Tue, 15 Jul 2025 06:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5e-0004k1-DB
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5b-0005o4-Qo
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45610582d07so17679325e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752576045; x=1753180845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHOAoC4vQEuBjIRxFlKZabNqqoxfUsSgKzK47tojwcc=;
 b=oh89euifpMufQ5UX1/eucitqyPGL7RRrqlS95vXNHhblLhHC+jYsNTVdsABBSC+FLf
 izLvn31Jcqa8CpSKfFVSvlVQI3hGvRtljf41Mj/Gm9j7Gc6PdVH8+wthKHDJij6rIVIX
 SqErYj5b0uBbTqoVabD36QUq4enbGbxzznmeG174mCKPavFOPewTlT3GEHubKjYtZVYN
 k5HV810zZFRX+7sKO+yO6fLtr5jRMYZ4sigkehT51vJEm7cBJhdzxdDrc6FaXU9npzty
 92vYvyAIrFne5tLG4tjJXcFZmEEahLmaoF/QYT0g70HvQzXy0wxBGpB37IOtlMO1J4We
 xAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576045; x=1753180845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHOAoC4vQEuBjIRxFlKZabNqqoxfUsSgKzK47tojwcc=;
 b=Eb7BUz3VS+JAcdXXBP7D9/3pvGL9OeLDyO+t7wEiL2kLg8TqVXZh+vZSizCtY6QYZu
 r/CyRq8lXy2clnTAp2SlXgNRJo5wbu6a6QDVF6vZ2iLZhWxdvdz93xNf2t8rVBWMiSab
 RuqKohi1tz217TgYvpm41LlxdGAKrw0WirmLkHanBrihlKkdodT9HXSo+K+EPgGLpbzQ
 jaYGLLvn5uzqoHuuHeXC4BcSJgEAvskt6bumklxJeCNV1e70Tn28qeQEwISFouG/JehQ
 YD++1KPZUWcaRXj8uXYrxp8iGPKWt0AofonFaVTnv/Eo6etX6EPOnVRx0uCQQy2tauhC
 Rwaw==
X-Gm-Message-State: AOJu0YzNFaWtWQgGHW+e73x5MdsqNvEK3CDsa3nl8C11LixrSfA09c+i
 +vEsKe8C8POg1zlBpxrIIn2VgGMO6pZ4I0fiDF9AVN3xWARJiOo/Y/7otvuI/AWIiotLsvOTKZb
 K7d3r
X-Gm-Gg: ASbGncsCVH72hfAHFz8ZFcKo2Qj5gLjmnx01AlUo0kkMrbla4BmTuZNgsahI5CHQbcZ
 LQZVdn78fufvJnzw+auY4sbJDpCeeTR5ywMFHs/J23nShn+tRbuLChqraFLOnZ8wKRGGIP7BrqX
 +/Ij0SoL206+v2bQYfnMbU0G3RUzqTay9QZEzbllFGVNhOi00nRY7u/A8pGnTwehdHBuzZcaL94
 7JXRCASLEsaHUr/Dnvi1Gpe3lRnu/qLXmcM2OcNJcl1dQws1CEo+IAja8isQTSsogWDVQ9BCw9P
 RtlnP47R5nsFF1Jy8FjqGkl/nafIGjxzWw13Uou+CUsZkcfIwoxA1HL38acA9MJy810raqS96Xt
 80z5OxA6rCAvfPVTeBnd764eJgtqtD6C7i8WI1pOb+xHIIpVhkymikbVPPtilT4qTpKhCwfNoyC
 p/jQ==
X-Google-Smtp-Source: AGHT+IF9dRkKJlkTsKAxnF9quZwSF+B01ym/ys9PnW7Ym6xsHElUqVsgfxa9Do+l9RkZHTrrUB46rQ==
X-Received: by 2002:a05:600c:a48:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-454f4272c71mr156379575e9.7.1752576044851; 
 Tue, 15 Jul 2025 03:40:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560eb98a40sm88485115e9.27.2025.07.15.03.40.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 03:40:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH-for-10.1 v5 5/7] accel/tcg: Propagate AccelState to
 tcg_dump_stats()
Date: Tue, 15 Jul 2025 12:40:13 +0200
Message-ID: <20250715104015.72663-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715104015.72663-1-philmd@linaro.org>
References: <20250715104015.72663-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Next commit will register tcg_dump_stats() as AccelClass::get_stats
handler. Since we want this handler to be called with the correct
accelerator state, propagate it along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 2 +-
 accel/tcg/monitor.c         | 3 ++-
 accel/tcg/tcg-stats.c       | 7 +++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 77a3a0684a5..847ae3914f5 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,6 +139,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
-void tcg_dump_stats(GString *buf);
+void tcg_dump_stats(AccelState *accel, GString *buf);
 
 #endif
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index adb9de5a1c6..97626da2f1f 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/accel.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
@@ -23,7 +24,7 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
         return NULL;
     }
 
-    tcg_dump_stats(buf);
+    tcg_dump_stats(current_accel(), buf);
 
     return human_readable_text_from_str(buf);
 }
diff --git a/accel/tcg/tcg-stats.c b/accel/tcg/tcg-stats.c
index eb6e20ae985..02795570b5c 100644
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
@@ -207,9 +206,9 @@ static void dump_exec_info(GString *buf)
     tcg_dump_flush_info(buf);
 }
 
-void tcg_dump_stats(GString *buf)
+void tcg_dump_stats(AccelState *accel, GString *buf)
 {
-    dump_accel_info(buf);
+    dump_accel_info(accel, buf);
     dump_exec_info(buf);
     dump_drift_info(buf);
 }
-- 
2.49.0


