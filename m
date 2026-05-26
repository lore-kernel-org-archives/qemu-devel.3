Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A27CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpbF-0007iw-U7; Tue, 26 May 2026 07:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpbD-0007Yi-EG
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:27 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpbB-0008Hw-P8
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:27 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1363e78746eso5598679c88.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779793524; x=1780398324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Bfw9rNWTfktg1xUtcj8Wv7smY3u6Z0KSK4iQp5lu5w=;
 b=eI0MFYKX8Y4NeUwKG2fG97Yc6JkjrJMi2EDMgL0+rXs4WxOmMcNVSqIRzaaBWPZE87
 HaTNHV7pmscQ3uqqCb50pH1hkfeDNEnVs2uOOMRsMpR9MOUsFDNgV4pk6Udgq+wQvoad
 GL32Oy9Y6fJ1Ga0nQhL/oopoXOg4vwZLKsDW301xsHmGWDy/lnxOhJppT4HZalX/UYv/
 XmgXkyBgv96pUI41FspyefKj564h4uFTc8n/7XbUrYqLbL1yJXidkSNOyhJ4QfEINPjv
 heySvfHKEMZAKYhh41vxa4F8CS59Z9Yw+16I3v2KKw401wz10kaehLMCLALcYmtz6mwT
 skkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793524; x=1780398324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Bfw9rNWTfktg1xUtcj8Wv7smY3u6Z0KSK4iQp5lu5w=;
 b=rsEnNgdq8qJuszjH0TLHT8mDDbV3XnDqHyaTDaCBoTKoC25iu+p+VMvy7LaBTHKMiV
 179wR5bp7WSZZrT1UQrdOoFKbKEnqI9pLhepaQLoRsm5yLxfER/HLQ2fB0r7Ett5j6Gr
 hHnDvl2NQkY7RB+Xlt876JsfSW9Ts24wD2F1y4GgGh0lJ7pg2d8HiKcvWS3kE3s0HnuN
 GsyrR74xoVQkLrDICweW+md5n+egegog1FLLRQuZbVSdFMjGTuSddXbz7bmvkmQYwzjM
 4sf7Tp7F3xWcmDY7Sl0Alsj2dZ0M/H3zFpf2qs1kg9lLqGhnSZNgxCuikJsZm0FH0Hco
 dJTw==
X-Gm-Message-State: AOJu0YzhxYxOCYIw7yCxdYP2D/Hsb+fXOLvA7XFlmE9NRCjV9G4Gk/os
 SdKwd9Ab8F6pfHC863t7TMsweFKey/0DDuKwAfjmA77Xa2qD4MztgQkrqIySwqw3O3YAyw==
X-Gm-Gg: Acq92OHRlykrU4rJbHgbwzw1zZY5TBsBjIGKpPNz1G3AfvUFNUHPxZ/WPhttqHB7Gw+
 1Y5CAfMBrD5Ejv559HcrZPG0cKgzDnBeZiasSJeWd0W/wa3QwnSM1zMOwpm/yfKXt0Ccsf1kJ5d
 4eM8LE4LHLB36H3qE5TsPyoJnlsuSTVBqce5tdxI69VVB1lPgadpmzyd/8jOgjooYG0/tomVZQe
 dx+5GJsILAviYA9Zk7uIXo4+2+xe3Mc4xHImmgKtA+h5YaFslFK1RafIR06cNcH5OPlJSW6GjEQ
 jkedc30iyeS3fGloxB0ZfoNSVCqw3EbdEysbOIdmkQCkfGASfrUC7ZOPfAjST2pmecpAmtVnnt2
 ivOscqohcIt/m4hqGxgP8VWgkuwej4oIHxWucXd0xeW5yNGfHQWBRvfy86KBlZPrtqmwbgP5gq6
 A3eeC7TlP00Wc46VBggZxTPZ/sQ9GhLnvuiktXXyhGtj3v73txwdLS+j28fOpVM6SGlm+QO7PGL
 oGXEE2WseE=
X-Received: by 2002:a05:7022:31a:b0:130:ca3d:f963 with SMTP id
 a92af1059eb24-1365fc637cemr5726665c88.41.1779793524047; 
 Tue, 26 May 2026 04:05:24 -0700 (PDT)
Received: from openkylin.. (ec2-3-101-81-203.us-west-1.compute.amazonaws.com.
 [3.101.81.203]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e634csm9250276c88.2.2026.05.26.04.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:05:23 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH v2 4/5] target/riscv: Reject x-misa-w without TCG
Date: Tue, 26 May 2026 19:04:49 +0800
Message-ID: <c33bea8085f103db209eaf06f978297bba727d88.1779792111.git.fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779792111.git.fritchleybohrer@gmail.com>
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/cpu.c         |  7 +++++++
 target/riscv/tcg/tcg-cpu.h | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1dea66972d..8f54610097 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -955,6 +955,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+#ifndef CONFIG_TCG
+    if (cpu->cfg.misa_w) {
+        error_setg(errp, "x-misa-w requires TCG");
+        return;
+    }
+#endif
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index a23716a5ac..20ad294f88 100644
--- a/target/riscv/tcg/tcg-cpu.h
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -22,7 +22,17 @@
 
 #include "cpu.h"
 
+#ifdef CONFIG_TCG
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
+#else
+static inline void riscv_cpu_validate_set_extensions(RISCVCPU *cpu,
+                                                     Error **errp)
+{
+    (void)cpu;
+    (void)errp;
+    qemu_build_not_reached();
+}
+#endif
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
 
-- 
2.43.0


