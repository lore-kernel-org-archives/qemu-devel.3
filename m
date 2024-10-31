Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C130D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZN9-0003Mn-R3; Thu, 31 Oct 2024 13:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMl-0002aL-Is
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMi-0007Rp-Hx
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E81uYVPsxcSZq8fucW64esB6s3dx+C87lpV3yUxgEJU=;
 b=YeBlH2INAL19hbPeZ6ErE6QcqvAePdnObtZbOM17SfIrVTYMAlejWG9W/5BUATUWZ/2uQo
 CZKOUGShgi02RvsAeBi9Idgh/ZP2E7SPyUCVUeeWxWCtOLJkoEFccnanAZ8qfV21llTwE1
 x5iRylhZRgF3cpkGm5mxyAQN9jAf9XU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-x0QwvXWnPt-eCjuUbBZFRQ-1; Thu, 31 Oct 2024 13:53:45 -0400
X-MC-Unique: x0QwvXWnPt-eCjuUbBZFRQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a1be34c68so85448066b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397224; x=1731002024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E81uYVPsxcSZq8fucW64esB6s3dx+C87lpV3yUxgEJU=;
 b=AqDP1Zu79D5l+wHncdX8b5e1EQVOXkhMUtMmpQWnBN9P06uMFuczqmM28BjyOqB8dQ
 ZS+M9c5MMAAp6xPnXUXDTVFVfdMbb3H2AjFuCvf5e6Quk9Mqnd10MjALPoJ9pliwtTxC
 10+XdsxemKM1voNi6Obsx79W4L6piOOln2GV5VHr7WTUnkQlMyA8Zl1RNHqzSIZA4VjW
 ZaTjBWFW0vliyXAJqx3nCKJFSsiNs5My9GWJK4E37BrnlXteDtb34HzOoPTRphHrMwOg
 FZu3JF130Bj0E+V8whbuQl92vJ9yuTFcp9WhOPUGV3wHVlTGy6RWUzBQI9SaQnMJwhlq
 329A==
X-Gm-Message-State: AOJu0YxQ2JxjVybzjhg2rIaJRnOJesOCN/2crgUXKISDRZImmDXFKQJg
 9odcyM6mwuTzD6PU3PpGGGjAUiylYeK5gG4UYzVhJMX2wWm6vhqrkvMly6YCfYncDeRIIhOjx+2
 f1Vkc84D7+j3NDVtLFuG+0k1kB7SAzpKR7GKPs9wBJSz//MuotJNLUWGCFux0rRXHG2W1wBaKv5
 FMp2/ojuIwMfJyEYQS8DT3Yldizyc3FIzF2bhYhwA=
X-Received: by 2002:a17:907:7e8b:b0:a9a:3cec:b322 with SMTP id
 a640c23a62f3a-a9e3a6c99e0mr698565166b.45.1730397223514; 
 Thu, 31 Oct 2024 10:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCh6rQKMwx0c0axZ9p//vKpAaRpaDeuQzjk2XpsJSCJNeDiVfIdjumFj5+Xa4j0aqXncWPtQ==
X-Received: by 2002:a17:907:7e8b:b0:a9a:3cec:b322 with SMTP id
 a640c23a62f3a-a9e3a6c99e0mr698562766b.45.1730397223038; 
 Thu, 31 Oct 2024 10:53:43 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5663fee9sm90525866b.154.2024.10.31.10.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 39/49] target/i386: use compiler builtin to compute PF
Date: Thu, 31 Oct 2024 18:52:03 +0100
Message-ID: <20241031175214.214455-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This removes the 256 byte parity table from the executable.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/host-utils.h                |  9 ++++++
 target/i386/tcg/helper-tcg.h             |  6 +++-
 target/i386/tcg/cc_helper_template.h.inc | 20 +++++++-------
 target/i386/tcg/cc_helper.c              | 35 ------------------------
 target/i386/tcg/int_helper.c             |  4 +--
 5 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index ead97d354d6..4d28fa22cfa 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -313,6 +313,15 @@ static inline int ctpop8(uint8_t val)
     return __builtin_popcount(val);
 }
 
+/*
+ * parity8 - return the parity (1 = odd) of an 8-bit value.
+ * @val: The value to search
+ */
+static inline int parity8(uint8_t val)
+{
+    return __builtin_parity(val);
+}
+
 /**
  * ctpop16 - count the population of one bits in a 16-bit value.
  * @val: The value to search
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 15d6c6f8b4f..696d6ef016f 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -21,6 +21,7 @@
 #define I386_HELPER_TCG_H
 
 #include "exec/exec-all.h"
+#include "qemu/host-utils.h"
 
 /* Maximum instruction code size */
 #define TARGET_MAX_INSN_SIZE 16
@@ -87,7 +88,10 @@ G_NORETURN void x86_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
 #endif
 
 /* cc_helper.c */
-extern const uint8_t parity_table[256];
+static inline unsigned int compute_pf(uint8_t x)
+{
+    return !parity8(x) * CC_P;
+}
 
 /* misc_helper.c */
 void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index 4cbbc73c3cd..8af8b8539f9 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -45,7 +45,7 @@ static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     DATA_TYPE src2 = dst - src1;
 
     cf = dst < src1;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -65,7 +65,7 @@ static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
     DATA_TYPE src2 = dst - src1 - src3;
 
     cf = (src3 ? dst <= src1 : dst < src1);
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & 0x10;
     zf = (dst == 0) << 6;
     sf = lshift(dst, 8 - DATA_BITS) & 0x80;
@@ -85,7 +85,7 @@ static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
     DATA_TYPE src1 = dst + src2;
 
     cf = src1 < src2;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -107,7 +107,7 @@ static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
     DATA_TYPE src1 = dst + src2 + src3;
 
     cf = (src3 ? src1 <= src2 : src1 < src2);
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & 0x10;
     zf = (dst == 0) << 6;
     sf = lshift(dst, 8 - DATA_BITS) & 0x80;
@@ -128,7 +128,7 @@ static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     uint32_t cf, pf, af, zf, sf, of;
 
     cf = 0;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = 0;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -144,7 +144,7 @@ static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     cf = src1;
     src1 = dst - 1;
     src2 = 1;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -160,7 +160,7 @@ static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     cf = src1;
     src1 = dst + 1;
     src2 = 1;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -173,7 +173,7 @@ static uint32_t glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 >> (DATA_BITS - 1)) & CC_C;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = 0; /* undefined */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -192,7 +192,7 @@ static uint32_t glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     uint32_t cf, pf, af, zf, sf, of;
 
     cf = src1 & 1;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = 0; /* undefined */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -209,7 +209,7 @@ static uint32_t glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
     uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 != 0);
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = 0; /* undefined */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 1b83775a914..f1940b40927 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -22,41 +22,6 @@
 #include "exec/helper-proto.h"
 #include "helper-tcg.h"
 
-const uint8_t parity_table[256] = {
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-};
-
 #define SHIFT 0
 #include "cc_helper_template.h.inc"
 #undef SHIFT
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index e1f92405282..1a02e9d8434 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -237,7 +237,7 @@ void helper_daa(CPUX86State *env)
     env->regs[R_EAX] = (env->regs[R_EAX] & ~0xff) | al;
     /* well, speed is not an issue here, so we compute the flags by hand */
     eflags |= (al == 0) << 6; /* zf */
-    eflags |= parity_table[al]; /* pf */
+    eflags |= compute_pf(al);
     eflags |= (al & 0x80); /* sf */
     CC_SRC = eflags;
     CC_OP = CC_OP_EFLAGS;
@@ -269,7 +269,7 @@ void helper_das(CPUX86State *env)
     env->regs[R_EAX] = (env->regs[R_EAX] & ~0xff) | al;
     /* well, speed is not an issue here, so we compute the flags by hand */
     eflags |= (al == 0) << 6; /* zf */
-    eflags |= parity_table[al]; /* pf */
+    eflags |= compute_pf(al);
     eflags |= (al & 0x80); /* sf */
     CC_SRC = eflags;
     CC_OP = CC_OP_EFLAGS;
-- 
2.47.0


