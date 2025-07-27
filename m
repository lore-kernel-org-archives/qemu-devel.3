Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEC4C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwLo-0005Eo-9O; Sun, 27 Jul 2025 04:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLb-0004tE-Ke
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLa-00041Y-21
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2349f096605so41184795ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603384; x=1754208184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCFS6cqTwlg3fFOqku117fnhPK1D7OaRJaQ+ElcEeuA=;
 b=ZEhiUVZoKtL1akne3G4OzYuxsapMBxGn6vdVtlBCoZL6wWh2pqk6nMe+Z7KvMHkX9j
 4ysKpND87+D7d/wo4rkDJ0v2gK1X9m1f4JqO0sVL8mvICyQ9dEvOCFrAuLoavh/69whg
 2rH2uOQrnYKQXLxF0DmeM5FhAB596aUxXSsar5gNDE/6eaazTYQLyUdgbKCCkjeeks3L
 g4sbQxfvwMXj9JqcQbvQySoFZB5KsUAxafD97RRbyt6nfOPo2w6g+iHNp+GF2iRTvhhZ
 cZK0bW+A+bkRCXRggXx6y3jiiMxnp5GvBzve6baqY8MRNKtfwT5WujZFgPhtoO3WYi5+
 +uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603384; x=1754208184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCFS6cqTwlg3fFOqku117fnhPK1D7OaRJaQ+ElcEeuA=;
 b=pE8HGooiaqeCCP0aVOrD6Am1OMr4J3cMiS1PF5M2xvGtpReLIJi3L4rWn1vhi99XLI
 iqmli4S3Z4Jz0q0SQo9obaWGLYiDfQdGYjBR9eWLznI2pbb848aGCT9U2xM9qUtA4Wsz
 zt3iSdn3DpsN3dj3cuL6GmWpiNjxm6U5u2q4a+ckLEprMQSGfUdiIyb43zclsHCd2wbH
 ii+YhUgrC77IKTLCvEH5zju8XliD5V52covgcbcWmCbM/Su4KxFSQDpYw7xWuyiMBCpa
 i4Qs9Gq2+u1eCqja6wbdbr0P7IO2wHt6OktQeU9h0mSUCx4/N19Euk3kgc7/CeIBNyLP
 hyWg==
X-Gm-Message-State: AOJu0YzL4kia+pjGE415g9VcdQpAvfHQN/l7piGWJERuHF21DqJKKhrd
 OdBOpNaqjfClDLQQE3+xPoOLq2gXoJ3q7+4grdq0EHAUMjsJ+dTW3VhVptGMIGODwOCr2jJxt2J
 YiWoW
X-Gm-Gg: ASbGncvcWSQ1vrASeptbkcfSFa1ztJV0X/8Fh/a1V1Mc5K/VJp88v8hy4QupcxHdrdv
 +3EcAlqD97VuQiNNmXlMuxEQi241r99yH6PtbdWbezQp80g44rvYzAXxXSn35UME0gjfpaWo3DW
 SManUXLD91fIBNh9We6S1qYq971DyNPuB51UwQvoErNz2XZwSE0fkYlcDui+rnAlNgOc6yLVIpo
 P5sCT03N4XaXPbCQraEeLDwjsCvgXziDxV4wzeDTW/IcHX5OOrmsJBC7W4/oRSnm4hEUbca5YbA
 s/xxZvQAoAVtuUTzrhiDiriA80JAnX92PjYmjth1ST+Vmcox40cCJwp0ThxfD1VkOoi9jhHfdEQ
 5bKjJC6Wr3rljakCNgR+JOD2rHj8UTDuYJBDD+KPbwYvcdOb1pjYy/EnKRb0KEas6HNoDCFtqRL
 lIkBbhUP7h2GUP55shLIIAqUvgdMoXEDQ=
X-Google-Smtp-Source: AGHT+IE15DlIHJfYVYyb0xNhUbYGyOzdfFbS408/FXwVkk2N9tdMCZZroYOusQdeLTgIkLfBzQKYBA==
X-Received: by 2002:a17:902:ef07:b0:235:cb94:1399 with SMTP id
 d9443c01a7336-23fb309bfe3mr107940975ad.6.1753603383803; 
 Sun, 27 Jul 2025 01:03:03 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/82] target/arm: Skip AF and DB updates for AccessType_AT
Date: Sat, 26 Jul 2025 22:01:37 -1000
Message-ID: <20250727080254.83840-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We are required to skip DB update for AT instructions, and
we are allowed to skip AF updates.  Choose to skip both.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1866c494ef..efbad7af1f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -58,6 +58,12 @@ typedef struct S1Translate {
      * and will not change the state of the softmmu TLBs.
      */
     bool in_debug;
+    /*
+     * in_at: is this AccessType_AT?
+     * This is also set for debug, because at heart that is also
+     * an address translation, and simplifies a test.
+     */
+    bool in_at;
     /*
      * If this is stage 2 of a stage 1+2 page table walk, then this must
      * be true if stage 1 is an EL0 access; otherwise this is ignored.
@@ -1929,7 +1935,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr &= ~(hwaddr)(page_size - 1);
     descaddr |= (address & (page_size - 1));
 
-    if (likely(!ptw->in_debug)) {
+    /*
+     * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
+     * and it is IMPLEMENTATION DEFINED whether AF is updated
+     * (AArch64.SetAccessFlag; qemu chooses to not update).
+     */
+    if (likely(!ptw->in_at)) {
         /*
          * Access flag.
          * If HA is enabled, prepare to update the descriptor below.
@@ -3553,6 +3564,7 @@ bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = space,
+        .in_at = true,
         .in_prot_check = prot_check,
     };
     /*
@@ -3653,6 +3665,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
+        .in_at = true,
         .in_prot_check = 0,
     };
     GetPhysAddrResult res = {};
-- 
2.43.0


