Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2199C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyLz-0000oU-Pq; Fri, 31 May 2024 05:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLy-0000nI-5Z
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLw-0006VQ-Ee
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717146911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Kp+O/AAAjxYFhrZsZua+SQq3136l2wt/4x9JcXzMHw=;
 b=b9WweBAfdk8TSoaUobY4hn7a8umovJ/6gxAKjQkql+fDEZE6kW0cI/3TaatmJi9ZGrayrk
 fkdeoZhBIFDVM/ClPGi/lp2ABKvR+c9vVRGHblx0d/V3Xi/YAA/gZ5x++Am+iYXzU9L9Vo
 pAQxDGUt29Ytf33L/xAYz4U3FZ+qB0E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-TY6r2bUoNGmLMSzj-L3qbQ-1; Fri, 31 May 2024 05:15:09 -0400
X-MC-Unique: TY6r2bUoNGmLMSzj-L3qbQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a2ffddca3so384602a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146908; x=1717751708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Kp+O/AAAjxYFhrZsZua+SQq3136l2wt/4x9JcXzMHw=;
 b=ii5TdnXYN57QqS/VO2qjIzvMf8jt1+ZiiaTDPpt2hVRekUTpsdp8CXwHeDOGGOzEpS
 jXb8KFUPslG2776f4WPPW9hJtccLJ0SfrpZ7g7y6jrSQdkXn7I2/QaWdjgooTe5Gb/NE
 BnupfG1GomNEN1eeJmlAy2v+GH2TFto4+Ir9hVQ1M4CkN15bes0a9CLzqDkw2U+5ZQdF
 03oj3/ZxOPTgU89dWuglBXNi6hP0qfLGyww+LtIt08W0ElwpjJy2agNFjSSmmYOTljGD
 rCgooBrI9fLxim296KFK61OcCchxCGOQYn4AHPkpJYXOC7Bm2nqfsCph4QZb6aJ0hGWI
 EYxw==
X-Gm-Message-State: AOJu0Yws8SJlsGCQtlJVQl7tN6SgJEKhd2Y5pHpf3Z0j1R6ZvBn8Wcyb
 T0AWKAzJEWugcICxjW/mbnAvaaF93jIeNJXDZhVvH6xvP4SpvUXG/mbC8jFaj3JwEQeHyduH+X6
 53i62ZXSzz1rgK+FFIgjljBsxEu7nbdYhuMyPTZOflXbFgZ0h3397XFj3IGy99ide1HADri9pAH
 /FkMfrgtlXExIZFv2hOsjNjzRE156gdB5E5d2z
X-Received: by 2002:a50:c04c:0:b0:578:4aeb:9b92 with SMTP id
 4fb4d7f45d1cf-57a363a5c5amr902420a12.24.1717146908055; 
 Fri, 31 May 2024 02:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg/idlIHcD6KnGATkmBMxYzInh1Jd6NOaNsRDrM2c5YdxFeGfzRoCR9jT6E+2zDa/dCY+//Q==
X-Received: by 2002:a50:c04c:0:b0:578:4aeb:9b92 with SMTP id
 4fb4d7f45d1cf-57a363a5c5amr902399a12.24.1717146907489; 
 Fri, 31 May 2024 02:15:07 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c9c10dsm788216a12.87.2024.05.31.02.15.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 02:15:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] host/i386: assume presence of CMOV
Date: Fri, 31 May 2024 11:14:54 +0200
Message-ID: <20240531091457.42200-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531091457.42200-1-pbonzini@redhat.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

QEMU now requires an x86-64-v2 host, which always has CMOV.
Use it freely in TCG generated code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h |  1 -
 util/cpuinfo-i386.c              |  1 -
 tcg/i386/tcg-target.c.inc        | 15 +--------------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 9386c749881..81771733eaa 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -9,7 +9,6 @@
 /* Digested version of <cpuid.h> */
 
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
-#define CPUINFO_CMOV            (1u << 1)
 #define CPUINFO_MOVBE           (1u << 2)
 #define CPUINFO_LZCNT           (1u << 3)
 #define CPUINFO_POPCNT          (1u << 4)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 18ab747a6d2..90f92a42dc8 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,7 +34,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
-        info |= (d & bit_CMOV ? CPUINFO_CMOV : 0);
         info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 59235b4f387..9a54ef7f8db 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -157,12 +157,6 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define SOFTMMU_RESERVE_REGS \
     (tcg_use_softmmu ? (1 << TCG_REG_L0) | (1 << TCG_REG_L1) : 0)
 
-/* For 64-bit, we always know that CMOV is available.  */
-#if TCG_TARGET_REG_BITS == 64
-# define have_cmov      true
-#else
-# define have_cmov      (cpuinfo & CPUINFO_CMOV)
-#endif
 #define have_bmi2       (cpuinfo & CPUINFO_BMI2)
 #define have_lzcnt      (cpuinfo & CPUINFO_LZCNT)
 
@@ -1815,14 +1809,7 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
-    if (have_cmov) {
-        tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
-    } else {
-        TCGLabel *over = gen_new_label();
-        tcg_out_jxx(s, jcc ^ 1, over, 1);
-        tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
-        tcg_out_label(s, over);
-    }
+    tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
 }
 
 static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
-- 
2.45.1


