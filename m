Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F66C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s8s-0007g0-Us; Fri, 03 May 2024 08:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8X-0007Uv-B1
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8T-00037f-Jb
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5592so50089725e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739732; x=1715344532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Tb/CgMjRwAYjJGSlcjkSqdpYLQYMSWtat67VigpwVw=;
 b=U/FbBZDerOkJ2rUe1UU3n5vYfq7NJSfEADoYTFXWpqaRWMHG3FFsrpnimltFrCnOtX
 3lpzMEnUjDJ3nKoljxz2sY3N0a+e4Mun3nlwJ2Ydu5GZR+MhrD14x+pbrWwdxfVmLDN+
 nwubSI3r3k6H08YZXDJKRNr9o0wPb4G1I3DrIL3Izt6jcI/OE6HRIPXXBJPTdpeib5Cu
 XBo5PvYBe2BlFqKCOu3vOFZbANfkPjUda82q1GxlHS/q8E2M/u2g+BgQU6lWI7SmSKkT
 HTEYE6QDwLcYq90Q4qO/6OgppB6iHPqz99zfAiOlcVPqdviWIJ+lBxiwviMpyMKvMooO
 DE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739732; x=1715344532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Tb/CgMjRwAYjJGSlcjkSqdpYLQYMSWtat67VigpwVw=;
 b=hmHygPzTtv2HXKumVJqLlFkmT5ngRfdApG6rj/dXdZM1HCuCcyU87KyQO+JfPLHotr
 AzPgYuxYlMNagabf7qKuzj66X8hy7/32jrugBUCfGJx65/frhhvqBgmbBIV7DAQK8X6J
 29A7Q1KEHzJntj4S1J09/n+L6fiFKcQkPX4GSH8PtuxriQfCmUZJsiMZhyinUWj7El2b
 ZOw6yN6KJ7BrD4WBHHiKz5ZF7AbS0qxpnZXHgQoki0ceOSilDRReAdoiSws/zU/r6k0e
 aVMOZRX1fk4II70ygQvHdmyFMnYoAWS6cb9wm9f1l+LQgAUDPOC9f/69100Fjf4qmW9o
 7KdA==
X-Gm-Message-State: AOJu0YxNcCKM/xiwO1H7SS4JxiZyxuP4PXJghzS/yyz8yed75Gj7ssKY
 2bMsdeelmvRGaGHT3xC1S1fMV/+U3cllphPjZpSjEpYBfm2ale5BdV81Ou6gs4k9Y47LUogmQpE
 A
X-Google-Smtp-Source: AGHT+IEMSKOulsn6UG0LjCmddKsbVDOiHr8tcMRMGdFoXoQSWXRSM5wqAeL8R441+a2gqqvIHa9wtQ==
X-Received: by 2002:a05:600c:1d0a:b0:41c:2699:dd9d with SMTP id
 l10-20020a05600c1d0a00b0041c2699dd9dmr2273086wms.28.1714739731682; 
 Fri, 03 May 2024 05:35:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 je8-20020a05600c1f8800b0041bf28aa11dsm5504533wmb.42.2024.05.03.05.35.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:35:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 5/5] accel/tcg: Always call tcg_flush_jmp_cache() on reset
Date: Fri,  3 May 2024 14:34:56 +0200
Message-ID: <20240503123456.28866-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503123456.28866-1-philmd@linaro.org>
References: <20240503123456.28866-1-philmd@linaro.org>
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

In commit bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
we unfortunately restricted the tcg_flush_jmp_cache() to system
emulation. Move it to the common tcg_exec_cpu_reset_hold() handler
so user emulation gets the jmp_cache initialized when threads
are created.

Remove the NULL check in tcg_flush_jmp_cache() from commit 4e4fa6c12d
("accel/tcg: Complete cpu initialization before registration") which
was a band-aid fix for incorrect commit bb6cf6f016.

Cc: qemu-stable@nongnu.org
Fixes: bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c             | 2 ++
 accel/tcg/sysemu/tcg-accel-ops.c | 2 --
 accel/tcg/translate-all.c        | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1bf85c324d..7e04df2902 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -36,6 +36,7 @@
 #include "exec/replay-core.h"
 #include "sysemu/tcg.h"
 #include "exec/helper-proto-common.h"
+#include "exec/tb-flush.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
@@ -1099,4 +1100,5 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 
 void tcg_exec_cpu_reset_hold(CPUState *cpu)
 {
+    tcg_flush_jmp_cache(cpu);
 }
diff --git a/accel/tcg/sysemu/tcg-accel-ops.c b/accel/tcg/sysemu/tcg-accel-ops.c
index 82c8368f87..13e450c088 100644
--- a/accel/tcg/sysemu/tcg-accel-ops.c
+++ b/accel/tcg/sysemu/tcg-accel-ops.c
@@ -34,7 +34,6 @@
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 #include "../internal-common.h"
 #include "hw/core/cpu.h"
@@ -83,7 +82,6 @@ int tcg_cpu_exec(CPUState *cpu)
 static void tcg_cpu_reset_hold(CPUState *cpu)
 {
     tcg_exec_cpu_reset_hold(cpu);
-    tcg_flush_jmp_cache(cpu);
 
     tlb_flush(cpu);
 }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83cc14fbde..93202fa3c1 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -663,11 +663,6 @@ void tcg_flush_jmp_cache(CPUState *cpu)
 {
     CPUJumpCache *jc = cpu->tb_jmp_cache;
 
-    /* During early initialization, the cache may not yet be allocated. */
-    if (unlikely(jc == NULL)) {
-        return;
-    }
-
     for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
         qatomic_set(&jc->array[i].tb, NULL);
     }
-- 
2.41.0


