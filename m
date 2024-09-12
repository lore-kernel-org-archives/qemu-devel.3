Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BFCEE644D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPw-0002GE-HK; Thu, 12 Sep 2024 01:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPr-0001vM-JO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPp-00032K-IT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:51 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20696938f86so4703295ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726119048; x=1726723848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGVnotTiwj5mkzBWCHImX70kcvKNSfH8JZUj7NW2zwM=;
 b=mVvRp8zKyhs7udJQkk4Ia23XkCc7QVrv8+h7SUIfaT+EcyoRwYDJ7lZJrONoKzgQ6y
 nzUv8dNwDHmbkBRkEBsfYAZES1pWtOcbb4XqGpWcfGq0XfQL1lAkQ9DZNjEu9vt9qgZm
 XmFb92qskb/PRVyIu1Xr2N6ofT+EElidXELhD8ttmRjQ9sthuWUVQOhelb44D3UPtt9c
 DiRncxvPe08+Mya8kk2ZG+2sBwB6wzttmtyB6O0/3iBKqk550o+vzYSTyTJULB5FPjIV
 ZeKjMxXAjbgR9RLfUNqNloeM+xd/sJfk1YdyQuL/++IiVgnHGEPIXZMkN0G3fWp/LbwO
 1lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119048; x=1726723848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGVnotTiwj5mkzBWCHImX70kcvKNSfH8JZUj7NW2zwM=;
 b=bvOAEcEVgPPh4hNM5BjoSix+FFagM6zG9J92ZfYAJghb8VI6z2rexq8V51J2HivhyY
 w2DFwyeeQYKnykqj3y33M/whZ5jd6GNayZXE+xGUVhQucHSDaRqN/oEOeQ7eLs8ZZJuP
 LsOAwCz4E/Wb97B+rubd3GlUKzIMBHEtB5Vb0y1qrQmjhSgZIOOernP1UcUGlv6sYccS
 468AFrLbMopaVtFnP5MLP4TJAm3kMZFWg099f9KXgqkYf6EMf2IJ8XVJIEq3ufSD4vhM
 v5hXZOcAxiOPrYciMEjTuTuabdeFfUV5VsJjDkcoKEFL8NRuxf2emczM2q6tg7qVuBOS
 d5WQ==
X-Gm-Message-State: AOJu0Yxq/x2kTU8BL8pl3PDzdJZignIzA/mXLK4rJmLq35Wp+UxBoy3w
 dNJ6vBj0glyoCiEv2WcGKirw+ezkOLe9JZMp381tQ5/UU09wbN5ZxZFXAGdwhsi1pOZ3hWgxvT1
 Q
X-Google-Smtp-Source: AGHT+IG9KZAXOXJLdrgdlqxsnyblhDDaPLFah2aLmVwDe8/QTF0OkWY8xxK/LUzFuqcBx4xyhmiGMQ==
X-Received: by 2002:a17:903:2302:b0:207:6e8:1d84 with SMTP id
 d9443c01a7336-2076e415244mr20663115ad.42.1726119047822; 
 Wed, 11 Sep 2024 22:30:47 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9e1dsm7513155ad.236.2024.09.11.22.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Carl Hauser <chauser@pullman.com>
Subject: [PULL 3/5] target/sparc: Add FSR_QNE to tb_flags
Date: Wed, 11 Sep 2024 22:30:41 -0700
Message-ID: <20240912053043.1131626-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912053043.1131626-1-richard.henderson@linaro.org>
References: <20240912053043.1131626-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Carl Hauser <chauser@pullman.com>
---
 target/sparc/cpu.h       |  8 +++++++-
 target/sparc/translate.c | 10 +++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9f2bc44722..f517e5a383 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -744,6 +744,7 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_AM_ENABLED   (1 << 5)
 #define TB_FLAG_SUPER        (1 << 6)
 #define TB_FLAG_HYPER        (1 << 7)
+#define TB_FLAG_FSR_QNE      (1 << 8)
 #define TB_FLAG_ASI_SHIFT    24
 
 static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
@@ -775,7 +776,12 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
     if (env->psref) {
         flags |= TB_FLAG_FPU_ENABLED;
     }
-#endif
+#ifndef CONFIG_USER_ONLY
+    if (env->fsr_qne) {
+        flags |= TB_FLAG_FSR_QNE;
+    }
+#endif /* !CONFIG_USER_ONLY */
+#endif /* TARGET_SPARC64 */
     *pflags = flags;
 }
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c803e8d1ba..eb0158a11d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -185,6 +185,8 @@ typedef struct DisasContext {
     bool supervisor;
 #ifdef TARGET_SPARC64
     bool hypervisor;
+#else
+    bool fsr_qne;
 #endif
 #endif
 
@@ -5596,13 +5598,15 @@ static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->address_mask_32bit = tb_am_enabled(dc->base.tb->flags);
 #ifndef CONFIG_USER_ONLY
     dc->supervisor = (dc->base.tb->flags & TB_FLAG_SUPER) != 0;
+# ifdef TARGET_SPARC64
+    dc->hypervisor = (dc->base.tb->flags & TB_FLAG_HYPER) != 0;
+# else
+    dc->fsr_qne = (dc->base.tb->flags & TB_FLAG_FSR_QNE) != 0;
+# endif
 #endif
 #ifdef TARGET_SPARC64
     dc->fprs_dirty = 0;
     dc->asi = (dc->base.tb->flags >> TB_FLAG_ASI_SHIFT) & 0xff;
-#ifndef CONFIG_USER_ONLY
-    dc->hypervisor = (dc->base.tb->flags & TB_FLAG_HYPER) != 0;
-#endif
 #endif
     /*
      * if we reach a page boundary, we stop generation so that the
-- 
2.43.0


