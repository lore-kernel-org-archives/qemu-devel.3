Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6980FC54754
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3S-0000fa-HY; Mon, 19 May 2025 00:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroF-0007It-Hf
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroD-0004Is-Mm
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-231d4679580so21983805ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627740; x=1748232540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zo1oQ2uJiz4wOuR0JFtGbTn7SBFfTYZmSnIf0cck79k=;
 b=BDFn6eNdu5vt1WCiXIjak+3cbJeguoRfn5qaMxgXB7WY6e1xtSfHPrVdNrG+tmuSZY
 nEg54B8a66hQn1Ywx48wycoOXZMSs+2LsAuZibKNwSTqidvqPm91P2MGs9pmvqKWdzeb
 DGX2Sg+Y6eywOqAVAlrah3qBIgk0lfYpOr3lkMoRZifqCpm1jeWyxKJX3ui83v6aho0k
 jk/qdtChWGtsr3wkbOYtuqi2Xt4V71+ipT6ErU+4Py6LHdgWYfKikDOFNSZOR/4duqUF
 ltN3pXjbvSmm2BuxDJs/C4KbftS2MYyuqtGu2kYKigBme1/ntmQM5rnoTzd1fBPOSFcK
 LnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627740; x=1748232540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zo1oQ2uJiz4wOuR0JFtGbTn7SBFfTYZmSnIf0cck79k=;
 b=FENKGQ7muhCcY3D1rsqhDmYz/a1081eXaDYCWJeW0oHjdqzpl3i51d6CrmsuOI/mSq
 KHMTP9Vt2gpt5n4AFVcIjFaowKrA70BGT3/DJcp69ncLBQ3y8TCQUa4k9DZgQ7l+U0Qw
 qpRYewXkN82E/AGrCWYb2a06FuR0yIWpTJio02V18+7vbfZwkW/6kznFJkaowgXM+vic
 w0QJENGT1iPMzbTUTezVhREpQhuMMYfhK3NSbN27C9a46mBGbXu2JHnHuAEw/y8fP5kF
 9sODwpz9pv8iwCmMwN8Ysep9Jt+n1hFaHD3w8FYouulP70FzeRxuUHXUnPBWmwfDSfs8
 4CsA==
X-Gm-Message-State: AOJu0YxAfySYmzD5F8se+8ZK5q8F2YkEVO6ZsfP+qjOU1zxmUogsIIFp
 AwUPOoEsYzsVuIb0Dbh2olmmk9TPQVOLK8BeOzuDh7uPQ6tIBdtGc70zsFxrFQ==
X-Gm-Gg: ASbGnctdOy193Z30cx9rxlzRsYEs4ftb+8fs06VUxJsgCwBF4spYfe/GtOfejv9Ye+Y
 DkD/Os0YcHEMDCt2k7gzLBXh0LYIVyg5O3oqunUPUe/9Tk2EBaoTY98imHNcnCUuZ9dB80cLHbF
 RSnnodxGpg/0R3nE0ZC9MSS1BrJm9fK7qiIdqLHhs/aoQK1AEeHCLwmT8jtzPsFb5GcVtE4ipIq
 VuZHf/A/pIwUvFioIP71LCA2YbUCWzRD/spflrDCeDplwJxVUAV52sAkonQLmcrvrseVU1lWZkN
 qD3BUGytyBUkmT6m30ipyuA/q/qp/JtJJbkgDMjRWRsuJ+TBN+3FyEUqr/RNuO5O9TSxOFNUuAL
 AEKLdBJ1Cy7wfqIEXzQcnx65XEK/F/B52ZcdeVWyUVhGDDw3CmULSacrU
X-Google-Smtp-Source: AGHT+IFWxpMTsARYj2VXjWjaRbLt82Y2GXiSDnAKJOgW33F7wFhyoVMbg6EVtwEGeM5EO+b5cGGAMQ==
X-Received: by 2002:a17:903:19ce:b0:224:a74:28cd with SMTP id
 d9443c01a7336-231d454b072mr171571575ad.31.1747627739917; 
 Sun, 18 May 2025 21:08:59 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/56] target/riscv: Pass ra to riscv_csrrw
Date: Mon, 19 May 2025 14:05:32 +1000
Message-ID: <20250519040555.3797167-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250425152311.804338-5-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       | 8 ++++----
 hw/riscv/riscv_hart.c    | 2 +-
 target/riscv/csr.c       | 8 ++++----
 target/riscv/op_helper.c | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4265ce06ee..f674e93a4f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -813,8 +813,8 @@ RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value,
-                           target_ulong new_value, target_ulong write_mask);
+                           target_ulong *ret_value, target_ulong new_value,
+                           target_ulong write_mask, uintptr_t ra);
 RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
                                  target_ulong *ret_value,
                                  target_ulong new_value,
@@ -823,13 +823,13 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
 static inline void riscv_csr_write(CPURISCVState *env, int csrno,
                                    target_ulong val)
 {
-    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
 }
 
 static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
 {
     target_ulong val = 0;
-    riscv_csrrw(env, csrno, &val, 0, 0);
+    riscv_csrrw(env, csrno, &val, 0, 0, 0);
     return val;
 }
 
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 333083a4f1..7f2676008c 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -72,7 +72,7 @@ static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
         ret = riscv_csrr(env, csrno, (target_ulong *)val);
     } else if (strcmp(cmd, "set_csr") == 0) {
         ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
-                MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+                          MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
     }
 
     g_assert(ret == RISCV_EXCP_NONE);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8af0304a36..807a891e7d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5574,15 +5574,15 @@ RISCVException riscv_csrr(CPURISCVState *env, int csrno,
 }
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value,
-                           target_ulong new_value, target_ulong write_mask)
+                           target_ulong *ret_value, target_ulong new_value,
+                           target_ulong write_mask, uintptr_t ra)
 {
     RISCVException ret = riscv_csrrw_check(env, csrno, true);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
 
-    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, 0);
+    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, ra);
 }
 
 static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
@@ -5704,7 +5704,7 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
     if (!write_mask) {
         ret = riscv_csrr(env, csrno, ret_value);
     } else {
-        ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+        ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask, 0);
     }
 #if !defined(CONFIG_USER_ONLY)
     env->debugger = false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 05316f2088..0672101637 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -71,7 +71,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
 void helper_csrw(CPURISCVState *env, int csr, target_ulong src)
 {
     target_ulong mask = env->xl == MXL_RV32 ? UINT32_MAX : (target_ulong)-1;
-    RISCVException ret = riscv_csrrw(env, csr, NULL, src, mask);
+    RISCVException ret = riscv_csrrw(env, csr, NULL, src, mask, GETPC());
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
@@ -82,7 +82,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
                           target_ulong src, target_ulong write_mask)
 {
     target_ulong val = 0;
-    RISCVException ret = riscv_csrrw(env, csr, &val, src, write_mask);
+    RISCVException ret = riscv_csrrw(env, csr, &val, src, write_mask, GETPC());
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
-- 
2.49.0


