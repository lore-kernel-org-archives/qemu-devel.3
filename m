Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62757C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDSk-0008Fw-9v; Thu, 06 Mar 2025 10:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSZ-0007uk-GY
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSQ-0006GL-Di
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bcc85ba13so6602535e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276100; x=1741880900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wVOS1vvZMQwjXlRVCMeomIHaHZpl7bu5hN5ReN6ps3U=;
 b=NXWrxB1/fgrPqvykbxzYEr/NfyMBg9QuDa5CI0Ly36GVd6XaP1lQXdiBxSKqsUhzux
 GodJ7/6G30TllCP/tyQUdQuKw1J4AJUzLQTq4/xtVg+9dtfkjzBUmbvm/YfnDuoLO4l7
 TMfkbanNifNz1aZWSzLGecXO+ZWs50C0qe3lQ+9AlrMYKg81ebKRcYsjRjd1iTq9GuT3
 D3pEnwzi+hupVapds/xpOmOwIlxv0tyyhytPzC3myR4+Y4zA3kN1KtVzF9LsR7t530F/
 J+UNh1GheqdIm+4WWQz4X7rjXniR6OvDWvI4cxT4QCO5c2NMe6rdLDwvFsNijeLKrTaN
 sG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276100; x=1741880900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVOS1vvZMQwjXlRVCMeomIHaHZpl7bu5hN5ReN6ps3U=;
 b=ixjokxbyiNzh6N4fO2FSj5anlrPS+3owPdCc6ZrHFIxMuLhXq75OqiqGus6oecM9N8
 iDKd2DEvt8lt8kz9hfqUedLuXPikL3cTj2iYQzsp8g24fXiROLW77AZhzTLCuj/c5G9q
 voohj3TtiCuA0fj9xvDZMdJSfUkZJv7gu1+Q927Y+o8+PnRpdIriw0JF9DqYO2/0CKLp
 zm4VO3bG9nEC8KxvMxjWw67wha3JUCdV/XdcSezEbNFU4g8ir2NXBWCyPPVfGyGcuEAt
 wiJxUTImQxxyHywAhYedEne3pGmMj6ggjD8Ef1QKjCef8emb+ddiuvLnpKBTN6UZMqjP
 Q6uQ==
X-Gm-Message-State: AOJu0Yx9kkEO1jQtJrk+4AIhaF+eo4rN9xeDr333tdaP7xNh9ozEIZM6
 ZBY7lgVkcXvNz3DXFi9ki/UEcauoDo5hd2QXwmxZCHqSHyjd+CfadRUvOOpDx3s5k1lZHv9MSMn
 EhQo=
X-Gm-Gg: ASbGncs82ZkHTr3RFpyPEkx4XL11rt7kqxXi86HdAlIhPaJZIGBSKu9T54XFRhI4St/
 fJJCgdfEwuEfRElst5vJCvJJU1e64CdAFSaATDnkSrPUyv8pdI8dv6p040xYsJc4bpB6ppS2AeQ
 8aQYykumQSMNQQIV8U0IP7Xr3TCYB8ocWsnBXJer2b0jI6L2vjsmQn2yM1z8sp74Sj9FZydmuc8
 up4OyQyIn24eJLZ2cCEvnbZWLgL5D/WTX4IWROxSMoJxDiQyJkVcXLbaL/7hv+lNS4IzDzvOsuG
 GR96PoHJ1pYNyg/2GDN5lC+/Xfyq1OiUaQA0Uy0lmK/x9xLGSD/DTyBZ55uS+UbmfP1LeMjkseG
 Y25CC7RFJOA5KY28kEHo=
X-Google-Smtp-Source: AGHT+IHnszkjeUhiD+WBxY2VNTH4X5+/VGYzdMH1ZZw96nHA9rPJGeBvz8ZuNsPeJ1U79fUMNGZUaQ==
X-Received: by 2002:a05:6000:4189:b0:391:c61:1de8 with SMTP id
 ffacd0b85a97d-3911f741f40mr5936718f8f.16.1741276098642; 
 Thu, 06 Mar 2025 07:48:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdff57sm2466547f8f.37.2025.03.06.07.48.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/54] accel/tcg: Restrict tlb_init() / destroy() to TCG
Date: Thu,  6 Mar 2025 16:46:51 +0100
Message-ID: <20250306154737.70886-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Move CPU TLB related methods to accel/tcg/ scope,
in "internal-common.h".

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-9-philmd@linaro.org>
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


