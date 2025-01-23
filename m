Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DF7C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6sq-0006Zd-Ei; Thu, 23 Jan 2025 18:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sn-0006WC-3f
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6si-00043f-5s
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361c705434so10880025e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675902; x=1738280702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+Ptx+X+/4qytTYw1NRizSw3Es7j283R5duCMBs45So=;
 b=Ef2fc/Pj/OZOiYX1+9odviTVzxzRJ/vZNN8Me63W8E6TIyrDHT6zv6ahYuXGlIwDiw
 8eRxo795JASt5yUnNJHTBetdA0hVcgkOITLWvnnwpNzRj9/hCN7Lkt6kmiJyGZRYlgH4
 iGzzSwcmx2qJS0aJaAPQF4Ba5dxq8Tml9gmi2a27+LXVOPRoknJpWdtAWujstux7QwNh
 x7BLc2SDre7ya0+X2/otZGOWSiAheZo2NqL7sccd3Q4WsBEEc3tfbwYa38JubF7NyNVa
 NpngQeEnG6HvRLYcjZfDvJumPqnFEOWXMh5egUOXn08R6En5VciLj+v4uK5mseTzPoZk
 Ki/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675902; x=1738280702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+Ptx+X+/4qytTYw1NRizSw3Es7j283R5duCMBs45So=;
 b=V6r7eDewvRIzQW+NlbchgJF3I1MeZrp4vadit8jaBifnn/tXvmeHHlJqUn/RM4oTES
 G5VUwFEN62JovITgZ2qbP8xFz59fqBMHJvjM8s8fCRT7pdmrthZFYiAtp6TbaODLqhYv
 4EuobpjnkEMlUzufh07Sbhg/3jlSAKwIAwAp9DZU3pKSKJQs7rZnjsI0Kovg4+JKm/Oc
 Fw6N7ACjIEUbENyPP2lEkDIj/wT37+Lt5mRksFcvj4v8sIvRYFb+7O/GZ7m4JSEs1zrh
 ZsWCyb0Lv6kzhWJ6UVIaFz6VPXaJIHbERR/Q+/RIblppcnRex3/DMroFnC7mpvSNrToS
 1Rqw==
X-Gm-Message-State: AOJu0Yytloc5pRO3cOuDOdsXig5vxfCv5/zRk/XHg2KYn3XuwPh2hmRn
 mJpidplXx0BahJcScvghv5Z1kS3vif2cBvW+dKLoI7/4A1V+Qyxf4IZkZ3Mg/XS2tVNnXDu2RzF
 NlLw=
X-Gm-Gg: ASbGncv5adFQBg+VfNa3tL9KWGSgkdIKy7sVYmuXpgeXzMtRgF2htzpEltCKU4jiYCB
 nvtShwPeeF3FC71s7ktnkS/9VMenugsLduuFBQygkZ/+bNAM9w+aJDtDbYEdfyuiYT+gESeKBmP
 ydf23vYbyMAG3G9l0ve4J70kSO9ggE4GUObq4Es+vPKhLem8O8hG662azqfXuBuY2bxu802vSNO
 w6RSred1c4Lagy3gJMTs5auDcAA8Sj+Z/c+2CKP0bdYocRGoGcAv9k97saUHyNc+RzJwChZxzS1
 qIjKK6jI3ppJ6awRNj52Bqo35Kljzu90teNG0Xc/Sjnd+HsYsec7X+I=
X-Google-Smtp-Source: AGHT+IGYKHSOUWuv3Z35/L1kDcj+xko6P82ABEfwOu6IFt4mwFRNrLSNCMYz6YlSXtAKxKsobnoAmQ==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-438913dfd7fmr310320675e9.14.1737675901922; 
 Thu, 23 Jan 2025 15:45:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c0ecsm6510925e9.30.2025.01.23.15.44.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:45:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/20] accel/tcg: Restrict tlb_init() / destroy() to TCG
Date: Fri, 24 Jan 2025 00:44:02 +0100
Message-ID: <20250123234415.59850-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move CPU TLB related methods to accel/tcg/ scope,
in "internal-common.h".

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 11 +++++++++++
 include/exec/exec-all.h     | 16 ----------------
 accel/tcg/user-exec-stub.c  | 11 +++++++++++
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index c8d714256cb..d3186721839 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -53,6 +53,17 @@ TranslationBlock *tb_link_page(TranslationBlock *tb);
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
 
+/**
+ * tlb_init - initialize a CPU's TLB
+ * @cpu: CPU whose TLB should be initialized
+ */
+void tlb_init(CPUState *cpu);
+/**
+ * tlb_destroy - destroy a CPU's TLB
+ * @cpu: CPU whose TLB should be destroyed
+ */
+void tlb_destroy(CPUState *cpu);
+
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d9045c9ac4c..8eb0df48f94 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -29,16 +29,6 @@
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* cputlb.c */
-/**
- * tlb_init - initialize a CPU's TLB
- * @cpu: CPU whose TLB should be initialized
- */
-void tlb_init(CPUState *cpu);
-/**
- * tlb_destroy - destroy a CPU's TLB
- * @cpu: CPU whose TLB should be destroyed
- */
-void tlb_destroy(CPUState *cpu);
 /**
  * tlb_flush_page:
  * @cpu: CPU whose TLB should be flushed
@@ -223,12 +213,6 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
                   int mmu_idx, vaddr size);
 #else
-static inline void tlb_init(CPUState *cpu)
-{
-}
-static inline void tlb_destroy(CPUState *cpu)
-{
-}
 static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
 {
 }
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc88..1d52f48226a 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/cpu.h"
 #include "exec/replay-core.h"
+#include "internal-common.h"
 
 void cpu_resume(CPUState *cpu)
 {
@@ -18,6 +19,16 @@ void cpu_exec_reset_hold(CPUState *cpu)
 {
 }
 
+/* User mode emulation does not support softmmu yet.  */
+
+void tlb_init(CPUState *cpu)
+{
+}
+
+void tlb_destroy(CPUState *cpu)
+{
+}
+
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
-- 
2.47.1


