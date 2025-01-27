Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B67C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKU-0001k7-4E; Mon, 27 Jan 2025 05:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKT-0001jH-8Z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKR-0001yL-QR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:53 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e3621518so2153091f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973610; x=1738578410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHD1U6D3WvJOsbcmnGXDiHvtbFUdg0u7emrKOSlHmN4=;
 b=kL4fgL35+EfWAQckiJ9/n4FQiTZaAwFETZk6I0HhMOS5UxB0Osj9WXY8Pvs+Dzk0br
 Q1yDoMuRWV0YPjweJH/IYA4K3VLxdYEedUdYOU70awZzHQ3b3GgSLKx+yj1uerQfBoVi
 DM5qfFp5ay/7pNS8NqOYhWjB3BPyxeBZvQEjt096w9BG4bCxRB3BH92cVp435HK52d1H
 TiXBVt3Dcq9FOPedee12H3DYzQcBymvS3yojJS+qFuoVElYuUqBQ48rNX8RUuFonkXha
 c210fw0UtfLDHP3by5+PmZgGxHTZwaiLrZUJowdjbjA1rFmCBCmVLqRS9m5tfxIMg8V/
 u5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973610; x=1738578410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHD1U6D3WvJOsbcmnGXDiHvtbFUdg0u7emrKOSlHmN4=;
 b=qJWfIcaBWuGCVl32s7xMPP1X8hA2Ejd1RhXWR34rJagCh2KIoCfgR/99hILYwzRf6q
 ukQyuLkGSfTBtuFOVFJDOHyd9UMZVe/ukkucZL+Zd3fu0V9CkcZeWg3zuLkB5qq8fcYV
 KaHbKXokp2lZ+viOkq4UndoLtUAOkdUVPqASLlJyDlCPdMhE2YDdG5MFYBTQUf1LG2PW
 SuQLal05q74S66IA1MOgGkUFfUKeCicUFZrvKfy4KIl7Cvo7gFI+3MbuBpzTTSf8ggmJ
 v7l0iDVGUt4NFGysZq88qBk0rPB5JeOLVvwMrP58P5oPGGVj2U9eoqvHdxI5kOgSPguf
 Me5Q==
X-Gm-Message-State: AOJu0YySexFBY//CNbZ/trZvvfwDrZEIoNbiC3V/CZ5hMGs0qo+Nw+Zu
 TxfsTJxjINhxamd/3ELqmllWa14zwqQH5knO62V6SnWlexRRnIbtgL6TnCRYr1IOlddI4asqcqn
 rn1I=
X-Gm-Gg: ASbGnctqiMNGJzWoHkXdzQA/NmG9aZLGQEeRSXkKThc2ApYK5B1R/6h4yLXBgUNi+4d
 OcUXl1PzoLhX+jjJaNXdGcW0BhLvl/PqMLyw0kxwY0u0sswUHflWNmF613FAJlAx0/GcH4V2Rsu
 1Y4622HEf7ox6voHGOKjXLdD7/lzVpaeigzzrjq6sCzX9IfrjX+UZHw1Ng1icjqeswhHE6CfICr
 M4B4qsGoy8WUQTqHlLo+F4gN5wiQbgbpXFUvB0glZZyqamK2FPHdcX9Xp8aevYdSjrzAMGRTqFF
 Gq3vrISbLJ+LBAiINxhSfwO7T9PVEoVMQWEu/u9CU0jri3KlLeXhg+s=
X-Google-Smtp-Source: AGHT+IHE1qPRy4HH6nLf6AB4L2453ztgnqcZYgaajsK5G2TLu3TvAZAuk/8IZKaTxB71v/wnQjIo4w==
X-Received: by 2002:a5d:64e9:0:b0:386:2ebe:7ae2 with SMTP id
 ffacd0b85a97d-38bf57b8aa7mr36379943f8f.45.1737973610166; 
 Mon, 27 Jan 2025 02:26:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a313383sm10923817f8f.36.2025.01.27.02.26.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/15] target/ppc: Ensure powerpc_checkstop() is only
 called under TCG
Date: Mon, 27 Jan 2025 11:26:10 +0100
Message-ID: <20250127102620.39159-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/ppc/excp_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8956466db1d..b08cd53688c 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "system/tcg.h"
 #include "system/system.h"
 #include "system/runstate.h"
 #include "cpu.h"
@@ -30,7 +31,6 @@
 #include "trace.h"
 
 #ifdef CONFIG_TCG
-#include "system/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #endif
@@ -443,13 +443,11 @@ void helper_attn(CPUPPCState *env)
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     /* KVM guests always have MSR[ME] enabled */
-#ifdef CONFIG_TCG
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
     }
-
+    assert(tcg_enabled());
     powerpc_checkstop(env, "machine check with MSR[ME]=0");
-#endif
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.47.1


