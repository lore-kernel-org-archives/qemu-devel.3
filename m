Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83931C0218F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbifx-0004LL-Fb; Sat, 25 Jan 2025 11:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifr-0004JH-2z
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifp-0000f8-MG
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:18 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so20456975e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821175; x=1738425975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPivNFM2ePYvU+OXN+1pyPQF43zn33Cj2yHAkQlRhv0=;
 b=Xq+BWhOCwMZaw1JyL/tFh306SX1UqZZ6z6FArA2Dc4anZtbx+Dt3XIENL0ovS/oBdq
 tAwdqiQE/kQ3taaktRdNuHUIjpJn0aguvLb4NZ1zhslUi4eXaHt4UbPZqUL6NFcCPg7o
 PqzbJ6pm+bI9xSPPMCONsMheEcuCYOEp2TdhuDcPkLbxADUnzMw8/tPiF/EtqpIwEiPD
 DsWnUCSNDp/19UBujNU86yVwA5eEJgwnFa20xg9nvuiIqCDW3afEJtsjpVFsMNaJPTvQ
 zhcVybG5KvCax54/UVW1KNluEhQ8YPZ++rimX33dZJTvMFkiMfESIWHdzbSWOoaB8YDa
 v77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821175; x=1738425975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPivNFM2ePYvU+OXN+1pyPQF43zn33Cj2yHAkQlRhv0=;
 b=F7x1nm6zIQ8PMFMjVLyBAA+ag/jQY27ypO6u685PlOE+RSEVK+refC/uOlY2dPEhPx
 3bqzdxGv/RXS17ImRbsuBCjV4XbMEouAwE/imYc5/TURDcWPBi43tIHLPT7pyZVclQfC
 ds+lNXAKUv7B/8sqO/ty2S/S/WN20zT6man7XvaiRddANp6CWzKdaLT4QlQR/3jxazzD
 SQW12x6D498N32xA8d+54e44q3xzlMdAcXJ0rqOX1DkJM8WAfhQ768ZdQS3duMyLRtNV
 ETmzB3vAixsFF34EP37is6W2RdloDx5dWGFhahBovSZOZwqJQCabA+Qv3tQeTyPwPt9K
 sIsg==
X-Gm-Message-State: AOJu0YzmpF94Cjb1Y7v1YWsbplwAQ+s6YoJckRJ3SI+7ytAKO3p9dB1O
 XiAyfHSfaAhItzTvO1z5Ie5qXXe9qw2u5zf2mcO0tFlYQ9arG7tdHwudRQEHRbcrGFv3EXRRexZ
 TOC4=
X-Gm-Gg: ASbGncvAHcZzxmNROvgNWGyjD3WB5PjpqpKql9sNDIFLjgImH7dpfaOXfCmFBFM1QRJ
 FkYyYw0EkOznAiw0tv/OUbRLFKwyfW7Yq5Fa3dFbtVZhYf20u+XYU0WUnEKas8QZ03QRCxrRVRX
 bvIWvhpNXg0rsYMeHIDK9XvFJzKMXIbb/j+FRhui8YEz8n9UTrqJs9bO0MF8SoP4PgUi5/qOLJP
 tIEAPnYq+MhQFQIcB2F10dRYpenBjB1v0xUTUYCsJIdbHFfHGmRu9qaUZ+gN8UZP5NUNwMieawC
 ZiQmPEmFZT5YyiaA5C5d1kRcblFwYCPYc/+IqSDCIWLow0ut7U41YK8ggRQ/
X-Google-Smtp-Source: AGHT+IEljwQbeuWc+vLY6KrKP6VzDgxDZPTT4hDjdmtofqxzeSeNFpEN7ghjw8uX807tlYjOQJ9XEw==
X-Received: by 2002:a05:600c:a09:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-438913f86dcmr329807905e9.18.1737821175312; 
 Sat, 25 Jan 2025 08:06:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d2a82sm65125815e9.36.2025.01.25.08.06.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/24] target/alpha: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:32 +0100
Message-ID: <20250125160552.20546-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e1b898e5755..83164a694d8 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -63,6 +63,7 @@ static void alpha_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool alpha_cpu_has_work(CPUState *cs)
 {
     /* Here we are checking to see if the CPU should wake up from HALT.
@@ -77,6 +78,7 @@ static bool alpha_cpu_has_work(CPUState *cs)
                                     | CPU_INTERRUPT_SMP
                                     | CPU_INTERRUPT_MCHK);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -216,6 +218,7 @@ static void alpha_cpu_initfn(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
+    .has_work = alpha_cpu_has_work,
     .get_phys_page_debug = alpha_cpu_get_phys_page_debug,
 };
 #endif
@@ -251,7 +254,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
-    cc->has_work = alpha_cpu_has_work;
     cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
-- 
2.47.1


