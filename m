Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224B7C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc7u-0003jQ-Cz; Mon, 10 Feb 2025 17:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7j-0003HA-E2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:19:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7h-00033H-IR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:19:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso54640775e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225963; x=1739830763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwYzznxoCnH8hzDS7762Hk4iYRDmRQJu5feM84dGztY=;
 b=snZsNAcF52IPppgHB5LkQ3Jykm045ZaQGESjozq/yfIO2jpRyXvNaEu28YUMlht7WZ
 0dHd72mQnom99Rw5imLgwbwN85FqDMRYFnhUu9VMQsaBlWwgOMwyr0EbO0nGny/+3gU7
 843IMn1MwyhoyrzEJEBRFBVMWL5Yb4H3sNfjMtDx2FrRZyw7ZzdRCHwnm5kuxlBfTzmm
 10z5x9Mil+Qse6NAm8THJN8AKQN22cAPReSpUJQW2eVFL76ujxL53GR1Db4toB3qcFkx
 u6oFBiK9Xp2O91tbyPFqlwUPUtq3bRDau5VEv5KRjAYDOVpAJVWHzNMtSiOLLTgsROJ/
 FbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225963; x=1739830763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwYzznxoCnH8hzDS7762Hk4iYRDmRQJu5feM84dGztY=;
 b=rH321pr/FCi0gSc+TwfBlh7Z/X9ExwamLpGiJ4gosKFCM8IFr72IS7+I/elMVR032j
 NRVCHxoGS8UUVPp2LVIoxGTvngoqXVTJ28HhNwmi9BvB0gTski8H8IKKuY+YmTdib+G4
 Akdj4vt2S26OKEKuWi2hbeBPlHd8pxrp8O7fX0Zg7dQL8ABMIauvQYmMih+rL7iCwF/W
 GkxjnCcmZKsQ6H0hMqY18yoPZNKzLhyzyd4HPn378jm5ULAi3AMuL/pDMEHjuYSCkvx9
 Y6ztIoSyWfyT4liT5jhM2seIoWLgfKSpi/Cga+OLw7p6rv5a/n+qFQWjuaFSCyz/zYUN
 jFFA==
X-Gm-Message-State: AOJu0YzBR9Zt5MzG/ZmuLwkgn0aQnpXeQqcA5gEvH2/R2r97ve4UrzhP
 w19WNHPSLfp4xSi8W/yu9dMNNvlVxkEQYULwfgj3Tznhnm7jlLPRqdgb1VJS5W1UERSxZOLngGe
 CfgQ=
X-Gm-Gg: ASbGncs9BsumtOzTzk8ocKuHMvWGfWlP2E9DPCugZd5dymDE2FG47f2Kg7N68AkbrYF
 /NZnVH70hYSYTBnobMXwChPVbAQSfCkSsRXZsawDnFEtC7IkPyeVA1lrvuc+72ufrq86MJVZMvg
 jkYUis0Qbkg92xf5DRqfv/7on4Rv39LpO3QPq9NsOvC0QFVpQ1UwG8bf3fdECGhC5eGm6/8DsPv
 Zi6FwelLygqzruIFJNx0f/dMIbk3TYLTJVs3FLWt4xmuINBRwHwVC8mc6y2U3XJrYh8wNQor+LM
 CXBAoo9LGj75GoNB5L/t/fGqo+hoGcaa6fcZtd3Hu55ePiPKpjkXxhc8z4iywLmXkg==
X-Google-Smtp-Source: AGHT+IF2woyAeqb32DWs0puFt3odYfKhFG4a6PhMqbV6FCSol5ZIFLkfilc6VEh2VNVsH5467RaXqQ==
X-Received: by 2002:a5d:64ae:0:b0:38d:d371:e04d with SMTP id
 ffacd0b85a97d-38dd371e50emr8193475f8f.34.1739225963003; 
 Mon, 10 Feb 2025 14:19:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd5e3cddasm7271481f8f.22.2025.02.10.14.19.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 14:19:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/10] disas: Remove target_words_bigendian() call in
 initialize_debug_target()
Date: Mon, 10 Feb 2025 23:18:30 +0100
Message-ID: <20250210221830.69129-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210221830.69129-1-philmd@linaro.org>
References: <20250210221830.69129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

All CPUClass implementating disas_set_info() must set the
disassemble_info::endian value.

Ensure that by setting %endian to BFD_ENDIAN_UNKNOWN before
calling the CPUClass::disas_set_info() handler, then asserting
%endian is not BFD_ENDIAN_UNKNOWN after the call.

This allows removing the target_words_bigendian() call in disas/.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 disas/disas-common.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/disas/disas-common.c b/disas/disas-common.c
index 57505823cb7..21c2f03430b 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -7,7 +7,6 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
-#include "exec/tswap.h"
 #include "disas-internal.h"
 
 
@@ -61,14 +60,11 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
 
     s->cpu = cpu;
     s->info.print_address_func = print_address;
-    if (target_words_bigendian()) {
-        s->info.endian = BFD_ENDIAN_BIG;
-    } else {
-        s->info.endian =  BFD_ENDIAN_LITTLE;
-    }
+    s->info.endian = BFD_ENDIAN_UNKNOWN;
 
     if (cpu->cc->disas_set_info) {
         cpu->cc->disas_set_info(cpu, &s->info);
+        g_assert(s->info.endian != BFD_ENDIAN_UNKNOWN);
     }
 }
 
-- 
2.47.1


