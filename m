Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EACEE2080
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJ3N-0001RC-UZ; Fri, 06 Feb 2026 05:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3K-0001Qw-Mi
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:06 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3J-0007S7-56
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:06 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8217f2ad01eso1716662b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770373624; x=1770978424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5B1mc9lktFkVX/c3UPr0j4SoEehm7jwPppWo5HwW/0=;
 b=GWHt9I51S41EAx4Zr4FJoDX2R2Ruxx+QQI87VJxbaF3186wDJNcLJI6OlBZrTwK7ui
 jAODJgJwRsgajisKM54DR41jdY1L4rSBiWaXzgsDyU3yuiw7Spk6J90Vn2Qw9CrcSqr5
 0JFilg7EsNkns6+BgIcW8nEuxuq7KGOS7dgqkfYDnuTsYBOzGQd6ZlzQlQTJ/9oKEiuN
 KsYBN3PQbLGwSqqN0LnIUXwlMxQ6wDdH4Mb2xn/IepHoLsXOrZGXz18qXU3+i0N4n9Qk
 9uQWyUb1+NPaKGxO/kczJ21OhRJQRK2uyABaxwnI4biOX+zfb0JlkZM9wY64aeukm1S/
 WErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770373624; x=1770978424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w5B1mc9lktFkVX/c3UPr0j4SoEehm7jwPppWo5HwW/0=;
 b=vkEBtOA1gFUrcmhY+ipXaY325a+eyede8vE/dVK4FJULalj0/A7jvss5lI43Dpi7bl
 oOfXVzdagiriKX3KbJcp1WgIKwngmMXKN6183+nmqDKEdQJCoZvAKlTDJLQFTfutqc9f
 t/LxCQrezWgZ9dDwy45MPVd8giIgKPfreJz8uFclCGh80C2pWUc+4WqGBrpGuLRk1pGp
 XL2XrRQnSn9OkSaqJEp94xOCrcQJ1v5xN7/2aKej2VtLhVpHJ8qEIQ27qukPWM+B1oJ6
 y8YwD6O1fXuBwSinb7p3pDDvTvoXPjcS8yBTr0DikT3ypiQpkcpwp1xR1loz2oJMYJ60
 ld7w==
X-Gm-Message-State: AOJu0YyblNtKKQl03mBEJIIv31TfXTNwSguzRNWnPaImDyrZKUAEpGc1
 ZJyOLxi4dGPAfNewYxmZuE3uInD8vE8bBUWt0xgcy+QUGtSo1vQxyHa3URLD/IUoSx2nRu9YwCw
 zLLNT4Wl0lg==
X-Gm-Gg: AZuq6aKE0XpXQ/9zo+FZ6b1XZqE19TMnLQog+/6P8vmxxwGOBHtPTVZwEv+CsG+cfAT
 +HRGmtNk1wrn2Xo1QOzm+MPpMv8vSK/hI3xHeuSqidV8wCcs6PCX/haB0PCzyWKDaN74tCNecnc
 nMpbCIm6n/5YCCsy70Hv0TNnqZQQNpVmo5eCcOM59WhGG9nRMKPF8guAnczZWF6d6XGTqfjg5rG
 B/cSaCJEu5Equ/RPwygahznIWItiNKPNyDbxzdSd0UaGq36xxIkP2eAktUx3Q2dq6DQ/7wM4y+o
 cldTLF9lmbH2EhF1U9ZHkMr0xcDtZGAZIBPV1dnbms+Gcwy2fFRCpsQSOn3OpnjsygsHbI1DIEJ
 yOmfqWhjwnnTsZMLQiuXBPstHkS0XuA286RW3cH2kuKkNALUstD/d37Foq2N2YvfRSuuIxTDXTQ
 Qt51zLz7pRAe/g02rNfpZFiQayN8xUXC5jLq/oNvwHjYvxwUSJpayyLPDZRjmH5rI=
X-Received: by 2002:a05:6a20:d80d:b0:363:cb5a:61 with SMTP id
 adf61e73a8af0-393ad01c843mr2550569637.27.1770373623613; 
 Fri, 06 Feb 2026 02:27:03 -0800 (PST)
Received: from stoup.. (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b1f49191sm2113723a91.7.2026.02.06.02.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 02:27:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Panda Jiang <3160104094@zju.edu.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] accel/tcg: Fix uninitialized hostp in
 get_page_addr_code_hostp
Date: Fri,  6 Feb 2026 20:26:49 +1000
Message-ID: <20260206102652.164018-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206102652.164018-1-richard.henderson@linaro.org>
References: <20260206102652.164018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

This uninitialized value violates the contract in the
documentation comment, and may lead to a SEGV during
translaton with -d in_asm.

Change the documentation to disallow hostp NULL.
Pass hostp to probe_access_internal directly.

Reported-by: Panda Jiang <3160104094@zju.edu.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 2 +-
 accel/tcg/cputlb.c          | 8 ++++----
 accel/tcg/user-exec.c       | 4 +---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 0ca13750f9..9e7be2d78d 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -82,7 +82,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
  * See get_page_addr_code() (full-system version) for documentation on the
  * return value.
  *
- * Sets *@hostp (when @hostp is non-NULL) as follows.
+ * Sets *@hostp as follows.
  * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
  * to the host address where @addr's content is kept.
  *
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 76546c6651..3d75abbe68 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1545,18 +1545,18 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 
     (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
                                 cpu_mmu_index(env_cpu(env), true), false,
-                                &p, &full, 0, false);
+                                hostp, &full, 0, false);
+
+    p = *hostp;
     if (p == NULL) {
         return -1;
     }
 
     if (full->lg_page_size < TARGET_PAGE_BITS) {
+        *hostp = NULL;
         return -1;
     }
 
-    if (hostp) {
-        *hostp = p;
-    }
     return qemu_ram_addr_from_host_nofail(p);
 }
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ddbdc0432d..f8b4a26711 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -822,9 +822,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     flags = probe_access_internal(env, addr, 1, MMU_INST_FETCH, false, 0);
     g_assert(flags == 0);
 
-    if (hostp) {
-        *hostp = g2h_untagged(addr);
-    }
+    *hostp = g2h_untagged(addr);
     return addr;
 }
 
-- 
2.43.0


