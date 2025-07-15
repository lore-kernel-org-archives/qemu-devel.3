Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B35C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublko-0003Ee-QS; Tue, 15 Jul 2025 15:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbl-0003Go-LF
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbj-0002lG-Gs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-454f428038eso41148535e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608788; x=1753213588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HquHgk/7WbZHZlOnd0Sx4ZEF9PYPrRxaR8gX1Hc6sWo=;
 b=t+a4lSKcCW6sUoQd1xlxNpdOzEkf2uyaAvQ+jQkNXYtH+MtMwLLHwg0txePFjPkvlp
 m0HELFphXQuFJ0hDGsdFrsKNTcfH+WOnnBTh5f6j0fRo+dK5QHjIPbocVjah20aZeKSg
 FqdXD2UUiITD4lbpJBmSUhOKnZM03QKaLDf8T0ctkHFMuVDGn2ukXgsUCImpZtP7ROG5
 jRvTJdIlAQg43exFZ23Fr7ZuAEMcZL0sI2xoSIGvC5dVCeGqIxQajU6ZT7GonNd6/T/7
 udBUV7s+WxDjjzf07c5FmLzmwDWvOb+nDuBJ8OMZgeYvqxaK2N+gTn2i+XVwz+dPuoac
 Xwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608788; x=1753213588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HquHgk/7WbZHZlOnd0Sx4ZEF9PYPrRxaR8gX1Hc6sWo=;
 b=RFTOmgOXPRT95B7JCQQnzSMFl9n3Ye77cO2OfRsn9EP9XRhB7/5b25CxfN2aBtMaNg
 4Ky7Kke7aoyCOrMzzAytyO3o1H76U2Bm3R+q4NnGtKbPFYgFkK5SQc9+xCViaKBLrMzg
 j7SGxprpIR+MR0ysyuMt6JhWbVlt3j1Q0du8lbPmfNYAxaQdgjYqCujkGghppDebudJI
 nQuuw9ibd7ynPlzUixQ+epwDFoKwE+9AMotaLFBLzvhcsDyh2i04adBztVde1KPii3VN
 yDnr3mq7vcvWTat6voxm5cqvn/73/GucOJCvXerCq1M7lMO8lVpveOzvhfWMMZ/kZKNs
 BB/g==
X-Gm-Message-State: AOJu0Yw1a2yKbIsmIM1KhZmU0cC7FnhE1UqW+mIe/noehZu1ZK9DWaFw
 mq7+PQqld7ugGZGFIhTkCTcBDpdiBvQvSkG7WSkM11OSChuWcKqA8VtKc0EiDNN0nDO1nlT9UQr
 vEhmC
X-Gm-Gg: ASbGncv0mootqRBh9IEJyknNO0HUWRw9SbnDCaVv0DKS5h0/Yg32Sd/0E0Yg6w3y4de
 oKtYksYtYFqBg7+BU9VQkEF/Sv+oJAiGrKggmlex0Tz9dAu89n7hWCs3J1aupngpmPrae+9akxA
 MyT+hDEyB3UUu67PQQmOhVJxOxC/OubuajAvXv0AhPigdE9rS+NRUitC7fCjiiaixvCssnvrb2s
 blyKOTLRagoblkNu9jx+vsxnb7vQ/Lvds067NdZMRZriosLkde6GgRFVQ4/RfxU0dWeP1G3exP5
 j3VrtYZJMAh3AjKFQswBAMT4tx7a6lD8opg1mOrWU3Zna09t2YuPTre0nIY06FjNUVkYR9qqkfg
 5ofuqlM4JKSJNK7jx0hMWdfCpLJXhutl59M+SE7AUdaxTbRK23sgGdrunDtilMGXkSaw4hdzKG9
 8nQQ==
X-Google-Smtp-Source: AGHT+IGjBjzcfWBn7iIvF891ru6O3itGP4wwJbxVSsfQpa130OxzHRCeOroeMeR0HORMNA/arePKCA==
X-Received: by 2002:a05:600c:3554:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-4562e3b8f65mr501675e9.29.1752608788310; 
 Tue, 15 Jul 2025 12:46:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d4b5sm16132335f8f.53.2025.07.15.12.46.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/17] accel/tcg: Implement AccelClass::get_stats() handler
Date: Tue, 15 Jul 2025 21:45:13 +0200
Message-ID: <20250715194516.91722-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Factor tcg_get_stats() out of tcg_dump_stats(),
passing the current accelerator argument to match
the AccelClass::get_stats() prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250715140048.84942-7-philmd@linaro.org>
---
 accel/tcg/internal-common.h | 2 ++
 accel/tcg/tcg-all.c         | 1 +
 accel/tcg/tcg-stats.c       | 9 +++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 1dbc45dd955..6adfeefe131 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,4 +139,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
+void tcg_get_stats(AccelState *accel, GString *buf);
+
 #endif
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index eaeb465dfd5..5125e1a4e27 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -243,6 +243,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = tcg_init_machine;
     ac->cpu_common_realize = tcg_exec_realizefn;
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
+    ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
diff --git a/accel/tcg/tcg-stats.c b/accel/tcg/tcg-stats.c
index e1a1c4cf4ac..ced5dec0c4f 100644
--- a/accel/tcg/tcg-stats.c
+++ b/accel/tcg/tcg-stats.c
@@ -206,9 +206,14 @@ static void dump_exec_info(GString *buf)
     tcg_dump_flush_info(buf);
 }
 
-void tcg_dump_stats(GString *buf)
+void tcg_get_stats(AccelState *accel, GString *buf)
 {
-    dump_accel_info(current_accel(), buf);
+    dump_accel_info(accel, buf);
     dump_exec_info(buf);
     dump_drift_info(buf);
 }
+
+void tcg_dump_stats(GString *buf)
+{
+    tcg_get_stats(current_accel(), buf);
+}
-- 
2.49.0


