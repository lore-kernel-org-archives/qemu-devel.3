Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F5BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6J2-0002Mg-41; Mon, 22 Jul 2024 23:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iy-0002Et-Rs
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iv-0001w2-Ph
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d18112b60so1452291b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705705; x=1722310505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQAUd555e3r5NFz67ssul86cWhr7fC1FabETxGwgt/Y=;
 b=U72q1J2cA+8gzf2lgJ4l59n7y7HgqHNs6th48mHGIyVlElmq/pdwRF4bWI5/Cld1ty
 8YSQw8AJXeeFeLqeCj6LcBCWar/0C1gGRFgmglhegCysCW3QaNwxvA6e8mUWBmcpNthL
 wqAFRGIkUym4MkzsedufPrhECHK+XAjv45KogKyOBAnlEdB9+NByCr+juanT7vjP6XO6
 /FfNddGwazbvsqjly/vfl4nuPcno77eHqV4J1KXDaTqzfghXHK/Xy48dQ1eJ0qy9e48D
 mkf3+soBuDNI73g9Md3DOl72xm/C9OKCjl7UjRL2+WvBOx6zArHKHRK8EvlcUFmLc7DC
 jPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705705; x=1722310505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQAUd555e3r5NFz67ssul86cWhr7fC1FabETxGwgt/Y=;
 b=oFFmtG2ohjEbLsT2drnQJJ1IP7/KaUdBDYv+Nsp9h8EUEhAlLBQyx/Sh7asxHBavJ2
 QYltV7AuuIsG/YaQ6YtMJ1b1oeUiaJHJ5OJwQioeVeYCPFPO+9WFe4mAMZI/NrWZEkiq
 LGdNR9uH7jxaplrIU6SIvjasCnQ8Cc9j788scunCcuva3BeaHh115QCmXITplkHF1qMA
 9AUFJ+UibCguMy4t6f8jvQmXTp/IVR9h14MhM7C8diBICjj0eL2UQi/gt51IaeOL+sSw
 S66mGGjhD8Lu8hPOhA0vXBi96Z+0HEnVbLHm3DspL1TWtJVtIH0mkII9isyStyifV/Dp
 gjng==
X-Gm-Message-State: AOJu0YxGDPS3CMy/t/YNtcwvw091rOaP4cY/Fj6PC/YgpolFoVDkbW6C
 znmOQJwPLNT3TaLZKliNXFCm84nw1ktOrmM0WN7yKBAZAVXsCpFxw3WuuCgA7631B70V1aKasQF
 23zDrsg==
X-Google-Smtp-Source: AGHT+IFoNDkAkCk2ChAzPkyVK1x6FJ9JCUV+Pi8RUeLIii2lHg4JuggKTOz+5BK5OVIYgsuoUgRp4A==
X-Received: by 2002:a05:6a00:179d:b0:70a:ee81:2fa2 with SMTP id
 d2e1a72fcca58-70e80753650mr1827789b3a.2.1721705704816; 
 Mon, 22 Jul 2024 20:35:04 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 03/12] target/arm: Use set/clear_helper_retaddr in SVE and SME
 helpers
Date: Tue, 23 Jul 2024 13:34:42 +1000
Message-ID: <20240723033451.546151-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Avoid a race condition with munmap in another thread.
Use around blocks that exclusively use "host_fn".
Keep the blocks as small as possible, but without setting
and clearing for every operation on one page.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 16 ++++++++++++++
 target/arm/tcg/sve_helper.c | 42 +++++++++++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 5a6dd76489..50bb088d04 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -517,6 +517,8 @@ void sme_ld1(CPUARMState *env, void *za, uint64_t *vg,
         clr_fn(za, 0, reg_off);
     }
 
+    set_helper_retaddr(ra);
+
     while (reg_off <= reg_last) {
         uint64_t pg = vg[reg_off >> 6];
         do {
@@ -529,6 +531,8 @@ void sme_ld1(CPUARMState *env, void *za, uint64_t *vg,
         } while (reg_off <= reg_last && (reg_off & 63));
     }
 
+    clear_helper_retaddr();
+
     /*
      * Use the slow path to manage the cross-page misalignment.
      * But we know this is RAM and cannot trap.
@@ -543,6 +547,8 @@ void sme_ld1(CPUARMState *env, void *za, uint64_t *vg,
         reg_last = info.reg_off_last[1];
         host = info.page[1].host;
 
+        set_helper_retaddr(ra);
+
         do {
             uint64_t pg = vg[reg_off >> 6];
             do {
@@ -554,6 +560,8 @@ void sme_ld1(CPUARMState *env, void *za, uint64_t *vg,
                 reg_off += esize;
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
+
+        clear_helper_retaddr();
     }
 }
 
@@ -701,6 +709,8 @@ void sme_st1(CPUARMState *env, void *za, uint64_t *vg,
     reg_last = info.reg_off_last[0];
     host = info.page[0].host;
 
+    set_helper_retaddr(ra);
+
     while (reg_off <= reg_last) {
         uint64_t pg = vg[reg_off >> 6];
         do {
@@ -711,6 +721,8 @@ void sme_st1(CPUARMState *env, void *za, uint64_t *vg,
         } while (reg_off <= reg_last && (reg_off & 63));
     }
 
+    clear_helper_retaddr();
+
     /*
      * Use the slow path to manage the cross-page misalignment.
      * But we know this is RAM and cannot trap.
@@ -725,6 +737,8 @@ void sme_st1(CPUARMState *env, void *za, uint64_t *vg,
         reg_last = info.reg_off_last[1];
         host = info.page[1].host;
 
+        set_helper_retaddr(ra);
+
         do {
             uint64_t pg = vg[reg_off >> 6];
             do {
@@ -734,6 +748,8 @@ void sme_st1(CPUARMState *env, void *za, uint64_t *vg,
                 reg_off += 1 << esz;
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
+
+        clear_helper_retaddr();
     }
 }
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index dd49e67d7a..f1ee0e060f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5738,6 +5738,8 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
     reg_last = info.reg_off_last[0];
     host = info.page[0].host;
 
+    set_helper_retaddr(retaddr);
+
     while (reg_off <= reg_last) {
         uint64_t pg = vg[reg_off >> 6];
         do {
@@ -5752,6 +5754,8 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
         } while (reg_off <= reg_last && (reg_off & 63));
     }
 
+    clear_helper_retaddr();
+
     /*
      * Use the slow path to manage the cross-page misalignment.
      * But we know this is RAM and cannot trap.
@@ -5771,6 +5775,8 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
         reg_last = info.reg_off_last[1];
         host = info.page[1].host;
 
+        set_helper_retaddr(retaddr);
+
         do {
             uint64_t pg = vg[reg_off >> 6];
             do {
@@ -5784,6 +5790,8 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
                 mem_off += N << msz;
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
+
+        clear_helper_retaddr();
     }
 }
 
@@ -5934,15 +5942,11 @@ DO_LDN_2(4, dd, MO_64)
 /*
  * Load contiguous data, first-fault and no-fault.
  *
- * For user-only, one could argue that we should hold the mmap_lock during
- * the operation so that there is no race between page_check_range and the
- * load operation.  However, unmapping pages out from under a running thread
- * is extraordinarily unlikely.  This theoretical race condition also affects
- * linux-user/ in its get_user/put_user macros.
- *
- * TODO: Construct some helpers, written in assembly, that interact with
- * host_signal_handler to produce memory ops which can properly report errors
- * without racing.
+ * For user-only, we control the race between page_check_range and
+ * another thread's munmap by using set/clear_helper_retaddr.  Any
+ * SEGV that occurs between those markers is assumed to be because
+ * the guest page vanished.  Keep that block as small as possible
+ * so that unrelated QEMU bugs are not blamed on the guest.
  */
 
 /* Fault on byte I.  All bits in FFR from I are cleared.  The vector
@@ -6093,6 +6097,8 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     reg_last = info.reg_off_last[0];
     host = info.page[0].host;
 
+    set_helper_retaddr(retaddr);
+
     do {
         uint64_t pg = *(uint64_t *)(vg + (reg_off >> 3));
         do {
@@ -6101,9 +6107,11 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                     (cpu_watchpoint_address_matches
                      (env_cpu(env), addr + mem_off, 1 << msz)
                      & BP_MEM_READ)) {
+                    clear_helper_retaddr();
                     goto do_fault;
                 }
                 if (mtedesc && !mte_probe(env, mtedesc, addr + mem_off)) {
+                    clear_helper_retaddr();
                     goto do_fault;
                 }
                 host_fn(vd, reg_off, host + mem_off);
@@ -6113,6 +6121,8 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
         } while (reg_off <= reg_last && (reg_off & 63));
     } while (reg_off <= reg_last);
 
+    clear_helper_retaddr();
+
     /*
      * MemSingleNF is allowed to fail for any reason.  We have special
      * code above to handle the first element crossing a page boundary.
@@ -6348,6 +6358,8 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
     reg_last = info.reg_off_last[0];
     host = info.page[0].host;
 
+    set_helper_retaddr(retaddr);
+
     while (reg_off <= reg_last) {
         uint64_t pg = vg[reg_off >> 6];
         do {
@@ -6362,6 +6374,8 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
         } while (reg_off <= reg_last && (reg_off & 63));
     }
 
+    clear_helper_retaddr();
+
     /*
      * Use the slow path to manage the cross-page misalignment.
      * But we know this is RAM and cannot trap.
@@ -6381,6 +6395,8 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
         reg_last = info.reg_off_last[1];
         host = info.page[1].host;
 
+        set_helper_retaddr(retaddr);
+
         do {
             uint64_t pg = vg[reg_off >> 6];
             do {
@@ -6394,6 +6410,8 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
                 mem_off += N << msz;
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
+
+        clear_helper_retaddr();
     }
 }
 
@@ -6560,7 +6578,9 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                     if (unlikely(info.flags & TLB_MMIO)) {
                         tlb_fn(env, &scratch, reg_off, addr, retaddr);
                     } else {
+                        set_helper_retaddr(retaddr);
                         host_fn(&scratch, reg_off, info.host);
+                        clear_helper_retaddr();
                     }
                 } else {
                     /* Element crosses the page boundary. */
@@ -6782,7 +6802,9 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                     goto fault;
                 }
 
+                set_helper_retaddr(retaddr);
                 host_fn(vd, reg_off, info.host);
+                clear_helper_retaddr();
             }
             reg_off += esize;
         } while (reg_off & 63);
@@ -6986,7 +7008,9 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     do {
         void *h = host[i];
         if (likely(h != NULL)) {
+            set_helper_retaddr(retaddr);
             host_fn(vd, reg_off, h);
+            clear_helper_retaddr();
         } else if ((vg[reg_off >> 6] >> (reg_off & 63)) & 1) {
             target_ulong addr = base + (off_fn(vm, reg_off) << scale);
             tlb_fn(env, vd, reg_off, addr, retaddr);
-- 
2.43.0


