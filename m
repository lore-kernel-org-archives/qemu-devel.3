Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7938EC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhwb-0005tX-Tu; Thu, 13 Jun 2024 06:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHhwZ-0005rA-A8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:44:35 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHhwX-0003mI-Gf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:44:35 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6ef8e62935so116915966b.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 03:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718275471; x=1718880271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sumL6TrGjbghTO5XOerJp+bSLYxh41etGSCXTjn7OMI=;
 b=JWOSgHO51At2ze4OeOqEGR+70/MhdBleQsIjCxfOD0pMiYIdXN3NLIY2My7YuZNJgr
 hr88ECtXODaLlOv8wzhoyyY5lP3H8L9iAPGcy/nMOXFKRE+yyOeHANjCKgXIlISgEyRz
 xu2WJDgLFuFeEi00cTS1KM9IoQcsgXJaQ9fvCXkILbtqTiDASePftwtruJpAwPI56onB
 XvshJxbuaaHpcXNJrBR5MwHyH4MGjiK66ceB4jNy2MkbtWGsZKNNr86sns7JIBlUh2Gg
 ZjVXUi3VYKgd8oEaCMnNIOI26+zrm+DJYHoDTu08cFZChNSt+wcsRexJVT+DMwXsCxaa
 lCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718275471; x=1718880271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sumL6TrGjbghTO5XOerJp+bSLYxh41etGSCXTjn7OMI=;
 b=O+gxVyhDas6oncdUBMNivIERhsTucGMzRymbyycPMGCjEZs9fww3NUIXvlDPM6kSOc
 aAUdJh3OEuBMumq1l+waztY+If/LYeANGV18F4oDoruVzeBUjdfSEQbbM7Y8qUTL2Q20
 3Vbmg8RQn+Eyd5CKcyoLFSDB9YqOeVuZVclPW+F3bTgmOQZwGkq5EPK8mb4x0CNJWrbs
 BCDS/ssn3q9X38Vw9bv/zlRZxHco/4IGd9pWhZxlX1iOTjBDZgRc67gk+/GhWGZyMmQr
 X2b5bx2bZZIeuDfqsZ06vi35dNYU3CvrL5TOxk6s29E2QW0kcSXCsc+QkRYZdNv7GCj2
 7/Yw==
X-Gm-Message-State: AOJu0YzbZjY3pK5qusxR5bUR3OGkR4zuGfOn/dwmd/FcXKMjrrcMC6uY
 LeSQPhWjc//Ge54JWP6mwTRgdCRqL4aGTsNw8CQVS+2X28vo57OhH0vn81ZqKRrHs3yoz/1Mme1
 Y
X-Google-Smtp-Source: AGHT+IGovXhJJ5/9fVSATsDnhlpfyh0KtvXck4/dakrGqHj7wR00CyeWU8asfTjulfyUEKAD5UqKlA==
X-Received: by 2002:a17:906:480a:b0:a6f:5f:8b7 with SMTP id
 a640c23a62f3a-a6f47f589cdmr354174066b.21.1718275471420; 
 Thu, 13 Jun 2024 03:44:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f41721sm58272566b.154.2024.06.13.03.44.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Jun 2024 03:44:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] target/s390x: Use s390_skeys_get|set() helper
Date: Thu, 13 Jun 2024 12:44:15 +0200
Message-ID: <20240613104415.9643-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240613104415.9643-1-philmd@linaro.org>
References: <20240613104415.9643-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Commit c9274b6bf0 ("target/s390x: start moving TCG-only code
to tcg/") moved mem_helper.c, but the trace-events file is
still in the parent directory, so is the generated trace.h.

Call the s390_skeys_get|set() helper, removing the need
for the trace event shared with the tcg/ sub-directory

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


