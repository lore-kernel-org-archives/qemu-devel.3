Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EC5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTl-0006E3-P3; Mon, 12 May 2025 15:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTV-0005bE-Pn
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTN-0007WP-QH
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UoSMTlpF2qfLgAfQXWinrMdZKQ0moRtra7wfS2I+NKg=;
 b=ZuEau/LWl8CNcXBn96/ln2RS+bCT69IkTjhpeW2TwRpdiEJPKjVyoi18N2e1XWR6X1he37
 x5kMxzrGbAYyxL9AuphB1jA636ZM1jC+SdQ02FpRL9SvgMxgxty2fljFXf7IMtQNpPXqRG
 kIvJLDgom4nsPxHjQJGIp9oJ697bkSU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-yaOLCIj8Or6a0c7hL5RICg-1; Mon, 12 May 2025 15:05:50 -0400
X-MC-Unique: yaOLCIj8Or6a0c7hL5RICg-1
X-Mimecast-MFC-AGG-ID: yaOLCIj8Or6a0c7hL5RICg_1747076750
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b7ceaa20so1569866f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076749; x=1747681549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoSMTlpF2qfLgAfQXWinrMdZKQ0moRtra7wfS2I+NKg=;
 b=pRbL8xYP7TiRq80YAkg8Z5BODkGFECJADEteoP1AV5YKiHFtFk55Q40+sQHJj8rNV0
 c75PIMRLjdINxqt07wIJn9ILD78ehZkP6eCOzBSXAjHL3gbfF+rbcHd9/3SMc4ZX+jJz
 YIqwkeZHCq0FdwnaMVmCVa2aUWaGDv1wmPXTWGyn5f5iOmmUcgnVLQR200qT2NphfjhS
 pxr3aqfu4J/eLcOuGMMdAFMFoOMlh3Ezj47+KkyE0wjLH6QrKJRRBUzUdCpnroN88RSU
 YhMXgx5J3Icp/fAqqZ15B3X2XUI8BiGH8tYtUZY3TcZujMnEriGY1zRK7KStlcrNfHsd
 TUcA==
X-Gm-Message-State: AOJu0YxjRdSss/v0TefXpMoc1z+Hv9Q5RRXke33zVgv3fxcVwOHATPxM
 nWU7W2eHqSP7bx0LGoSbgPee+nzxU1SuZr1N/VyqACMwVVaFjcMN/sdY4nt208C9aTmlo+xoD3f
 iNz76IQtPLBQNkH5WSj7YJmglTp2z7OwpTdSG/EJlQkuq1sEXb3d+BMeqX45HTqpKTcdyM1z5D4
 s1bczXek4tGmLHnDux3yVq5MDNzafzzssL2LDO
X-Gm-Gg: ASbGncv00Ku01ikRppMfNT0OHGHLZiLm7Gi/6UKfP3fLlGWEz6WMrVKl+D4c+06HGRJ
 DYpKTYUaqFjMTOW5yeKWUS8vM3fVaQ8Mp07033sGmDGFAiOqs1FBU5AnM4k7DD65qBOzkcB4j3r
 bAbLas5LIAc8gBsomY2tJvdUtaiOoq3dDzj+DqQguXEzUJGLLhlkaukDpDWoVOd7sHOcWoCwTYv
 roZJXaUQWIELHMZDOR+jJelEhAvIIYVcyvVBWeoRgtpRCYANekY1al0tLh1QgJu/eUDWa0jbu56
 iVKSiJILUuI+SsE=
X-Received: by 2002:a05:6000:3102:b0:3a0:7a8f:fc73 with SMTP id
 ffacd0b85a97d-3a1f643145dmr12046632f8f.14.1747076749055; 
 Mon, 12 May 2025 12:05:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8lxuZQ2lMV0XxEnFUU/BXRo5vVafDStiusxl7lsODXXwT8MsZQyWQ6ueaPh+9oAyUWHk/YA==
X-Received: by 2002:a05:6000:3102:b0:3a0:7a8f:fc73 with SMTP id
 ffacd0b85a97d-3a1f643145dmr12046616f8f.14.1747076748663; 
 Mon, 12 May 2025 12:05:48 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ec8f1sm13178492f8f.26.2025.05.12.12.05.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] target/i386: move push of error code to switch_tss_ra
Date: Mon, 12 May 2025 21:05:17 +0200
Message-ID: <20250512190524.179419-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move it there so that it can be done before the TSS trap bit is
processed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 72 ++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 0ca081b286d..cb90ccd2adc 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -326,10 +326,10 @@ static void tss_set_busy(CPUX86State *env, int tss_selector, bool value,
 #define SWITCH_TSS_IRET 1
 #define SWITCH_TSS_CALL 2
 
-/* return 0 if switching to a 16-bit selector */
-static int switch_tss_ra(CPUX86State *env, int tss_selector,
-                         uint32_t e1, uint32_t e2, int source,
-                         uint32_t next_eip, uintptr_t retaddr)
+static void switch_tss_ra(CPUX86State *env, int tss_selector,
+                          uint32_t e1, uint32_t e2, int source,
+                          uint32_t next_eip, bool has_error_code,
+                          uint32_t error_code, uintptr_t retaddr)
 {
     int tss_limit, tss_limit_max, type, old_tss_limit_max, old_type, i;
     target_ulong tss_base;
@@ -599,14 +599,38 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
         cpu_x86_update_dr7(env, env->dr[7] & ~DR7_LOCAL_BP_MASK);
     }
 #endif
-    return type >> 3;
+
+    if (has_error_code) {
+        int cpl = env->hflags & HF_CPL_MASK;
+        StackAccess sa;
+
+        /* push the error code */
+        sa.env = env;
+        sa.ra = retaddr;
+        sa.mmu_index = x86_mmu_index_pl(env, cpl);
+        sa.sp = env->regs[R_ESP];
+        if (env->segs[R_SS].flags & DESC_B_MASK) {
+            sa.sp_mask = 0xffffffff;
+        } else {
+            sa.sp_mask = 0xffff;
+        }
+        sa.ss_base = env->segs[R_SS].base;
+        if (type & 8) {
+            pushl(&sa, error_code);
+        } else {
+            pushw(&sa, error_code);
+        }
+        SET_ESP(sa.sp, sa.sp_mask);
+    }
 }
 
-static int switch_tss(CPUX86State *env, int tss_selector,
-                      uint32_t e1, uint32_t e2, int source,
-                      uint32_t next_eip)
+static void switch_tss(CPUX86State *env, int tss_selector,
+                       uint32_t e1, uint32_t e2, int source,
+                       uint32_t next_eip, bool has_error_code,
+                       int error_code)
 {
-    return switch_tss_ra(env, tss_selector, e1, e2, source, next_eip, 0);
+    switch_tss_ra(env, tss_selector, e1, e2, source, next_eip,
+                  has_error_code, error_code, 0);
 }
 
 static inline unsigned int get_sp_mask(unsigned int e2)
@@ -719,25 +743,8 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         if (!(e2 & DESC_P_MASK)) {
             raise_exception_err(env, EXCP0B_NOSEG, intno * 8 + 2);
         }
-        shift = switch_tss(env, intno * 8, e1, e2, SWITCH_TSS_CALL, old_eip);
-        if (has_error_code) {
-            /* push the error code on the destination stack */
-            cpl = env->hflags & HF_CPL_MASK;
-            sa.mmu_index = x86_mmu_index_pl(env, cpl);
-            if (env->segs[R_SS].flags & DESC_B_MASK) {
-                sa.sp_mask = 0xffffffff;
-            } else {
-                sa.sp_mask = 0xffff;
-            }
-            sa.sp = env->regs[R_ESP];
-            sa.ss_base = env->segs[R_SS].base;
-            if (shift) {
-                pushl(&sa, error_code);
-            } else {
-                pushw(&sa, error_code);
-            }
-            SET_ESP(sa.sp, sa.sp_mask);
-        }
+        switch_tss(env, intno * 8, e1, e2, SWITCH_TSS_CALL, old_eip,
+                   has_error_code, error_code);
         return;
     }
 
@@ -1533,7 +1540,8 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             if (dpl < cpl || dpl < rpl) {
                 raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
             }
-            switch_tss_ra(env, new_cs, e1, e2, SWITCH_TSS_JMP, next_eip, GETPC());
+            switch_tss_ra(env, new_cs, e1, e2, SWITCH_TSS_JMP, next_eip,
+                          false, 0, GETPC());
             break;
         case 4: /* 286 call gate */
         case 12: /* 386 call gate */
@@ -1745,7 +1753,8 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             if (dpl < cpl || dpl < rpl) {
                 raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
             }
-            switch_tss_ra(env, new_cs, e1, e2, SWITCH_TSS_CALL, next_eip, GETPC());
+            switch_tss_ra(env, new_cs, e1, e2, SWITCH_TSS_CALL, next_eip,
+                          false, 0, GETPC());
             return;
         case 4: /* 286 call gate */
         case 12: /* 386 call gate */
@@ -2256,7 +2265,8 @@ void helper_iret_protected(CPUX86State *env, int shift, int next_eip)
         if (type != 3) {
             raise_exception_err_ra(env, EXCP0A_TSS, tss_selector & 0xfffc, GETPC());
         }
-        switch_tss_ra(env, tss_selector, e1, e2, SWITCH_TSS_IRET, next_eip, GETPC());
+        switch_tss_ra(env, tss_selector, e1, e2, SWITCH_TSS_IRET, next_eip,
+                      false, 0, GETPC());
     } else {
         helper_ret_protected(env, shift, 1, 0, GETPC());
     }
-- 
2.49.0


