Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6129BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbK-0001h3-LA; Thu, 23 May 2024 19:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaw-0007mv-7V; Thu, 23 May 2024 19:11:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHat-0006N6-D5; Thu, 23 May 2024 19:11:32 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f8e98760fcso294869b3a.1; 
 Thu, 23 May 2024 16:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505889; x=1717110689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4GTBmpK/uwjCeV22q5y1Kk/p3bIImzV+8sEKRJvedI=;
 b=anYwriUecm+vpKb0N0t/53WbkHb+E1cvb2CnZRX9R9Axm6NhdoTd00Y/Qojba2KQqm
 I+wTLQ3QI3ZCVW2ANfuoeyRQlE9LD0Q/hPdmIb4LtbqYP/ymODTSJqb4ql4Cif7lGBGs
 quG0nRumYPumSq4chIA8T/AY1XXu/q+6IHWojXwyXZF1rVofOCZvUwk4kIwHHE+KRTyA
 +XqRHggbSPbYx7WRKd+xaE4/dkSqjJEzgadh07lSR2DXRB+VAHzO1bbV5pzrqVZ5NL2O
 JiFEmPldeqsSkmxsvDNlIJ/i5MxTVdhVoAbp3SdJ1pq4ezVGpquDMQiXDqNdEeZotgrL
 NdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505889; x=1717110689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4GTBmpK/uwjCeV22q5y1Kk/p3bIImzV+8sEKRJvedI=;
 b=cQoPAsexIERkexEBWFl1fWvKYHoPZ+5ef6ygBsu5gtLp45L6XBpRcbdpz6SzBcX6qa
 uiW/b8B/wm+oKBl0xgkCk38Y6tqod2mjkbDXNy4jGzNEoCFfnKfbLPjURtPDUnpb5Jr7
 8KuZEqyLx1PMmTZPL49o2i7lpz3dwVR/CldVxh6I5zK1ies684ZSrpAXarU3vtN8jeHB
 NCq6VzxF2qgS4eCkOEkKyzgfKHI7XTEzOGjGDUQY+HoUgtFC1qg8lABzozvV5meA6lWX
 CoWycQebFEQc/0lTRV3xM19hfn3LQYudwRaBDlTxMW7izPCL+3bxYIh4OVLkNrtHy2w3
 IyXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt5OEX65x2O8AmpdFoScvWBHyAKj+KQUiDYM7QcGJbwp5PYtiBLAWeRmRgHlAdrt8I2wAgZPP5t44zy+/RYoX1alRd
X-Gm-Message-State: AOJu0YxtlX7BiHTUlj/fmUYFnXg6cI2vI3/9xaPo6asgps2bOdDfIzgy
 tiw+SXriMgLeHolnfFTcSGMOGG2FWjBkdPUwfv5Gp7h5kdBjMqDl8GWFKg==
X-Google-Smtp-Source: AGHT+IH6Gpe30mpplUBDBW1yl7T+Ai9PlltkLdEgkYBjboutnQ0PErvsL75KBALwJZoLpF86UQ+0gg==
X-Received: by 2002:a05:6a00:3388:b0:6f3:c10a:7bdd with SMTP id
 d2e1a72fcca58-6f8f34b281cmr951744b3a.18.1716505889122; 
 Thu, 23 May 2024 16:11:29 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 69/72] target/ppc/mmu-radix64.c: Drop a local variable
Date: Fri, 24 May 2024 09:07:42 +1000
Message-ID: <20240523230747.45703-70-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The value is only used once so no need to introduce a local variable
for it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-radix64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index fefa55a5f1..c1e4f00335 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -185,7 +185,6 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access_type,
                                    int mmu_idx, bool partition_scoped)
 {
     CPUPPCState *env = &cpu->env;
-    int need_prot;
 
     /* Check Page Attributes (pte58:59) */
     if ((pte & R_PTE_ATT) == R_PTE_ATT_NI_IO && access_type == MMU_INST_FETCH) {
@@ -210,8 +209,8 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access_type,
     }
 
     /* Check if requested access type is allowed */
-    need_prot = prot_for_access_type(access_type);
-    if (need_prot & ~*prot) { /* Page Protected for that Access */
+    if (prot_for_access_type(access_type) & ~*prot) {
+        /* Page Protected for that Access */
         *fault_cause |= access_type == MMU_INST_FETCH ? SRR1_NOEXEC_GUARD :
                                                         DSISR_PROTFAULT;
         return true;
-- 
2.43.0


