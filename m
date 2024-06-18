Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D36AC2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMX-0002D1-UI; Tue, 18 Jun 2024 12:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMW-0001xm-8W
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMT-0007va-Rv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4217990f997so40756535e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726828; x=1719331628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/LkBj7LoTcIamDeZoGEisyJw5TF9TRn7cK0fhUgkPQ=;
 b=MH/AIcwM7bfqlobDnMex9svJF353wJON/rdZWL9rGdx6ogb7q2kL0lKSAHJSQLu2s/
 +AkR1U4EwFzLsMKzpBpWIn9FEYup0R6e2+2c6lPvFpJ2jktMF590h4nwzq/+LgSbKmR0
 aEkMxfwzCx4mdsi/wvCuxURN9B39+xafT+ZUoC3WdL3GbX9iDj4DROJjgjxKWvUQxaPf
 RvnqgGjP31L9W6vzVHyM8gpfROjfH+7ty4/iFtgUgTmxDAZLxcCKveACktD3aopYBLqG
 Uo21HZlhdD7DFXT6BFjEC7vTAyZvVQeBKdwpKHVmYSylq44FO8kab1A32+ldo4nHKmu+
 OFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726828; x=1719331628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/LkBj7LoTcIamDeZoGEisyJw5TF9TRn7cK0fhUgkPQ=;
 b=n8x8iFSqgKJv7tsZENLQOrBaQogmi1Qb3DR0ctlBdeQcdzW0Oryzxuq8PgDfR6xGeY
 YtTAXLCvG7y0mGdtms25w1rPGo93y/Y9caoEgw4M2WAB+VjM7OrEVm2j+kNP6lqHDF9t
 1jUpHBwXLhTX77Uin6rCRZe52BKVh7sr6gfbjouEWem9olFVsGgj2BjvVgPIfTavX92o
 N3Lr0xamxmURmcTSIDTYsiQmmTzKkqUU4yZQgxoYKrg2FQu2+UXY8T9EPIpAKOm0oihS
 w6BJjZQoFtpitHaDyTOZFu91qk5Q/mrovTZSOQqEyKGD+7mdcWWS1Imxk6XYonn3aEzu
 WyZg==
X-Gm-Message-State: AOJu0Yx9vOCgS50ii4YpgpKsyqIQDzCfxTY/sUyFZA+ihfu+8jziHOAa
 T1NiFS88OF8rW2QIlJWztMDO0HHAaPoFyghS7hWph6btgulF/7sUIseizCT8GvCQCjqsnFVCAus
 e
X-Google-Smtp-Source: AGHT+IGcCAn/XCN4cKoNaeL9K6l5q2jmRTz/GgEzuRBKxcw7kUvSjLUVGSttjFoTYWg4dspiEzPjLg==
X-Received: by 2002:a05:600c:524f:b0:421:8e64:5f23 with SMTP id
 5b1f17b1804b1-4230481194amr85240325e9.5.1718726828136; 
 Tue, 18 Jun 2024 09:07:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e73b1sm231071855e9.45.2024.06.18.09.07.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 67/76] target/s390x: Use s390_skeys_get|set() helper
Date: Tue, 18 Jun 2024 18:00:29 +0200
Message-ID: <20240618160039.36108-68-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Commit c9274b6bf0 ("target/s390x: start moving TCG-only code
to tcg/") moved mem_helper.c, but the trace-events file is
still in the parent directory, so is the generated trace.h.

Call the s390_skeys_get|set() helper, removing the need
for the trace event shared with the tcg/ sub-directory,
fixing the following build failure:

 In file included from ../target/s390x/tcg/mem_helper.c:33:
 ../target/s390x/tcg/trace.h:1:10: fatal error: 'trace/trace-target_s390x_tcg.h' file not found
 #include "trace/trace-target_s390x_tcg.h"

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240613104415.9643-3-philmd@linaro.org>
---
 target/s390x/mmu_helper.c     | 11 ++---------
 target/s390x/tcg/mem_helper.c | 16 ++++------------
 target/s390x/trace-events     |  4 ----
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index f3a2f25a5c..6c59d0d216 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -25,7 +25,6 @@
 #include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
-#include "trace.h"
 #include "hw/hw.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/boards.h"
@@ -303,7 +302,6 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
     static S390SKeysClass *skeyclass;
     static S390SKeysState *ss;
     uint8_t key, old_key;
-    int rc;
 
     /*
      * We expect to be called with an absolute address that has already been
@@ -341,9 +339,7 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
      *
      * TODO: we have races between getting and setting the key.
      */
-    rc = skeyclass->get_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
-    if (rc) {
-        trace_get_skeys_nonzero(rc);
+    if (s390_skeys_get(ss, addr / TARGET_PAGE_SIZE, 1, &key)) {
         return;
     }
     old_key = key;
@@ -371,10 +367,7 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
     key |= SK_R;
 
     if (key != old_key) {
-        rc = skeyclass->set_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
-        if (rc) {
-            trace_set_skeys_nonzero(rc);
-        }
+        s390_skeys_set(ss, addr / TARGET_PAGE_SIZE, 1, &key);
     }
 }
 
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 6a308c5553..6cdbc34178 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -30,7 +30,6 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
-#include "trace.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/s390x/storage-keys.h"
@@ -2093,9 +2092,8 @@ uint64_t HELPER(iske)(CPUS390XState *env, uint64_t r2)
         }
     }
 
-    rc = skeyclass->get_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
+    rc = s390_skeys_get(ss, addr / TARGET_PAGE_SIZE, 1, &key);
     if (rc) {
-        trace_get_skeys_nonzero(rc);
         return 0;
     }
     return key;
@@ -2108,7 +2106,6 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1, uint64_t r2)
     static S390SKeysClass *skeyclass;
     uint64_t addr = wrap_address(env, r2);
     uint8_t key;
-    int rc;
 
     addr = mmu_real2abs(env, addr);
     if (!mmu_absolute_addr_valid(addr, false)) {
@@ -2124,10 +2121,7 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1, uint64_t r2)
     }
 
     key = r1 & 0xfe;
-    rc = skeyclass->set_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
-    if (rc) {
-        trace_set_skeys_nonzero(rc);
-    }
+    s390_skeys_set(ss, addr / TARGET_PAGE_SIZE, 1, &key);
    /*
     * As we can only flush by virtual address and not all the entries
     * that point to a physical address we have to flush the whole TLB.
@@ -2157,18 +2151,16 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t r2)
         }
     }
 
-    rc = skeyclass->get_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
+    rc = s390_skeys_get(ss, addr / TARGET_PAGE_SIZE, 1, &key);
     if (rc) {
-        trace_get_skeys_nonzero(rc);
         return 0;
     }
 
     re = key & (SK_R | SK_C);
     key &= ~SK_R;
 
-    rc = skeyclass->set_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
+    rc = s390_skeys_set(ss, addr / TARGET_PAGE_SIZE, 1, &key);
     if (rc) {
-        trace_set_skeys_nonzero(rc);
         return 0;
     }
    /*
diff --git a/target/s390x/trace-events b/target/s390x/trace-events
index 729cb012b4..d371ef71b9 100644
--- a/target/s390x/trace-events
+++ b/target/s390x/trace-events
@@ -1,9 +1,5 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
-# mmu_helper.c
-get_skeys_nonzero(int rc) "SKEY: Call to get_skeys unexpectedly returned %d"
-set_skeys_nonzero(int rc) "SKEY: Call to set_skeys unexpectedly returned %d"
-
 # ioinst.c
 ioinst(const char *insn) "IOINST: %s"
 ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
-- 
2.41.0


