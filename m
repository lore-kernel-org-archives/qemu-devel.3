Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C63C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 19:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpuGp-0006p7-R2; Wed, 05 Mar 2025 14:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpuGo-0006oe-3H
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:19:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpuGl-0003xq-VB
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:19:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-390e88caa4dso3663791f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741202342; x=1741807142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6q2S+v+JeAtwsva/ajQ9rhDrN2yK+zVYq0T6QTWeRZ4=;
 b=b1bA+8mBmW/n1XAoqcWR4eY29ZJi7am+Xv4mDTtsphVegVy+iqFsNoPk8JCR1eCtiN
 IKomps5UEPgfKWdhN8oMcq/7IX2Itk/3BE7j4xNEWzel8IFgIxo9uRTk6FmIKuF8NiNX
 RTB1GP3Jej1J7cv0FXDBr8EstOqgHikEFr+dHY2cu/4KXXFjHFNZNApmHZ2TPUFuLPl0
 mljoRRaVC93u8qkePRel4dmw5KvmaMz/kIWBbrkz/CL1A2OQhduEzQ85sayQEBu/Yn6v
 yHQTGkSZJbBNmwOKt/NvDJ+QkFtBP678DyYs5E5v1kllcra8no+oHppsRJqHha6TJWA8
 9xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741202342; x=1741807142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6q2S+v+JeAtwsva/ajQ9rhDrN2yK+zVYq0T6QTWeRZ4=;
 b=b8wxvh+UChhd1o3MUZOMy9/yz2eVQKNZPARyOhZspUWFNI3P60kKuESDyeUv1dy8RK
 1SjtOEjoVYlV2dsoiix6+4QYiVisPEi3asqHO3Rppbv2Tl6YpNzqDYeGY3BpZG+PmqL3
 UYY09I9xjmGjr1Qd/kkOvugbZGTMwmMfLclcj8gpDI7Qkzz6GWHJVaytlczOYeIbmV83
 dwKYcQhxMUkDHJK22qnwOR5J8L2MEu4nZMB3qgWvQQTju6eXxpb56+7LIJis2ayJc046
 pDv7KDh49BBJIc0U9MtBgmvI5XKNTRv5e5H6KNCv0CceOZ2pN2POi/WvtsSB1zdZRas8
 aPOw==
X-Gm-Message-State: AOJu0YyMJpwWUvYdNg/KuJ6x0IjgAsqiUb8LCH/dL0Qx3oGYt68t4OCU
 d/JNoaXkb4uL55KK2QGoYSslnzpvHhaZTn0/WRA3VJJ+rSwgA/Xj0iGxi81KNZYGHfKRTvvhGvQ
 JfYA=
X-Gm-Gg: ASbGncv8UkNkV+2rOJd3rZylDzCCVFZtC7xoPPBpCxv1unwO113pIYHvUqT6obR5u1a
 BR4+ZqjaIryJjOeZ1ZZX+e5svIMXf3l7wFPFVoQ8X9OXa2PJkuFaTtzekTRVqTFTf3E+Kt3O5/r
 Euj5o2ctw/jhwEU8ugweX/Ouw4NmwOnRFXBRS+4nkT1TACiznlSQBUKojNcYVJ600XBNxDKapY5
 rG2xQZUwsxm9o6yEjAJ6mXZP4Asdw7LV40dR5p+GbFUehRSNPCAfLLQ6MA2z2D1bfqUF5XadSMc
 UMtnXTlIF83YAXTpL583SnlyivFM5Ba9uTBaSkWwnJXiYXKpdF4bu30ZDWF4hba7srp5x7oq9FX
 jw9yC4wEtSaoktFPnH7w=
X-Google-Smtp-Source: AGHT+IH7AcTi71zsrzySXPNlAZx7Es2s1Z4KEiZEo9RHC6VNLuvKp3dVOD/+bl/HZwYuNOmVvvTAKw==
X-Received: by 2002:a05:6000:2c6:b0:391:865:5aa8 with SMTP id
 ffacd0b85a97d-3911f7d2fbemr3538059f8f.54.1741202341707; 
 Wed, 05 Mar 2025 11:19:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391269f30f2sm1600369f8f.34.2025.03.05.11.19.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 11:19:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Restrict CPU_TLB_DYN_*_BITS definitions to
 accel/tcg/
Date: Wed,  5 Mar 2025 20:18:59 +0100
Message-ID: <20250305191859.71608-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

CPU_TLB_DYN_*_BITS definitions are only used by accel/tcg/cputlb.c
and accel/tcg/translate-all.c. Move them to accel/tcg/tb-internal.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-internal.h | 27 +++++++++++++++++++++++++++
 include/exec/cpu-defs.h | 26 --------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 90be61f296a..abd423fcf58 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -13,6 +13,33 @@
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 
+#ifdef CONFIG_SOFTMMU
+
+#define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_DEFAULT_BITS 8
+
+# if HOST_LONG_BITS == 32
+/* Make sure we do not require a double-word shift for the TLB load */
+#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
+# else /* HOST_LONG_BITS == 64 */
+/*
+ * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
+ * 2**34 == 16G of address space. This is roughly what one would expect a
+ * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
+ * Skylake's Level-2 STLB has 16 1G entries.
+ * Also, make sure we do not size the TLB past the guest's address space.
+ */
+#  ifdef TARGET_PAGE_BITS_VARY
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  else
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  endif
+# endif
+
+#endif /* CONFIG_SOFTMMU */
+
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 /*
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index ae18398fa99..9f955f53fde 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -46,30 +46,4 @@
 
 #include "exec/target_long.h"
 
-#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
-#define CPU_TLB_DYN_MIN_BITS 6
-#define CPU_TLB_DYN_DEFAULT_BITS 8
-
-# if HOST_LONG_BITS == 32
-/* Make sure we do not require a double-word shift for the TLB load */
-#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
-# else /* HOST_LONG_BITS == 64 */
-/*
- * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
- * 2**34 == 16G of address space. This is roughly what one would expect a
- * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
- * Skylake's Level-2 STLB has 16 1G entries.
- * Also, make sure we do not size the TLB past the guest's address space.
- */
-#  ifdef TARGET_PAGE_BITS_VARY
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  else
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  endif
-# endif
-
-#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
-
 #endif
-- 
2.47.1


