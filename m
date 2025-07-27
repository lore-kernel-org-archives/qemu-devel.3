Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4182C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwOM-0005qo-O2; Sun, 27 Jul 2025 04:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLy-0005vJ-NV
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:30 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLx-00049Q-5U
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2352400344aso30514255ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603408; x=1754208208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U5uKtt0dYMHATom5laLyD9UNdX3pU9hAWzf847+404=;
 b=P3ys4EJDvFnUmRWC1BuFJ061dOlzMO8jA3ida+AsAlqNPPiJpwMbGmVVLePnss2Fv8
 UprMS8wzq/IGoZ5ObwUFQPnLsFWken0GhIMqFGtBXfQf52vwFRNhXr4sXDpxi4MJSg5V
 pM+LJGpHQzRjMV0bSKzzpFzVzsGCJ4eqD3zlegsWjCXmec2Mnj0mi7ZrkuPyoTXu++Dy
 6pwx/NCAgseLfRBxO7Gb0JQsUyEhbx5DZh7HaGYdAv21lU/svdjEYNMeAbEbwh7gbAyF
 2/7IVVyfH87Xd3AC8RH3xSWBIQmHhetgX0goSLjR36Qq/zjtd0XO2Ydkkxu3+WWSjHO9
 oDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603408; x=1754208208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U5uKtt0dYMHATom5laLyD9UNdX3pU9hAWzf847+404=;
 b=uU8GU0xPQj9uQBBIlgsKWpZya7iN+8Cn4cktVMNVHeBb4Eo9BbkCL69N14sXaA7Kp+
 821P3lglkTlfBdfNGLFu1BMOCSd1gapLddPztXFkbkvJjV86OTeV5aRDIFER26XnpPHT
 JRwvsytE0zesKDVty0qhm6BccMjZ3MeDKZzZwF994Ab6KOeZ8eKH9Vr+C28OW7lYwJIM
 AfeIczMXMiw6yeUx6tTWjAo+5AAX2OuymFDWhxQ/DApLNAOcJFoQ+xeVUKxP62QNoN+8
 DphTMT1Pay1w8EV45o2Kkcr35roO/j+IqLk6elqcc2j7vjelfwUB5qSMWm8AL5+bPaV2
 qVfw==
X-Gm-Message-State: AOJu0Yz3jjO7xR8wJpbThrBDwaJII67IZ50Ug2RIenU4IUdQLMIKG7gF
 UHx/r58iOU3dhus+x9MgJ0NyogV0H+dxaWRDPGA7U5MW/GNtbWhRK9//xocta9jZwcDfQJ9vhJL
 9MtL3
X-Gm-Gg: ASbGncsCeI9yhDB/zypt0I+UVVES8jbsmCpLVZMWtl6hwm0hPumPjb96kcxKpeTyKL+
 NBjd8TdjphGg8tH7te+925rwP/yc2cLuMHX03vMbNnAo28ZeTnhJHqmnGAEwkUfsW4cxEP+vxDy
 T1MHs60zj/Y5PNTRGMr/JyrGeDMbnYhEEx5jkZa4x2ikvtuUqkgS/VAHfdmkszYIu8dDMzI6tnX
 dSpOHv7pokE+OYlGoFEGycxkFUcmvlxWB5KAu1Z6FK9W435Z47V3er2994ytcKBPdX7tJNdBAGE
 AyIEMVI8L2JJyrJsmwUe9Kk5zXlN1R1p3Blaj8/5m+g4nX824qnGXg39y4dhWKN8E30RGAsYohk
 VGsuQHJ/j9cC6NsRCAIuw/AB4Wav70VBVgjfYzPDwRXwnn/vLxctbLadQhZjRIheS/VDiuiTYkE
 AnAxYt5D+3ag==
X-Google-Smtp-Source: AGHT+IFmwitUmt0qFVTKUsXi7RNSAUSqNuGzvb0P2H6j++ds2E/N1WCiJb9mUPHQDo8IpYV5d/t7Uw==
X-Received: by 2002:a17:903:1c2:b0:234:a139:1210 with SMTP id
 d9443c01a7336-23fb31bdf48mr120549785ad.53.1753603407889; 
 Sun, 27 Jul 2025 01:03:27 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 26/82] target/hppa: Adjust mmu indexes to begin with 0
Date: Sat, 26 Jul 2025 22:01:58 -1000
Message-ID: <20250727080254.83840-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

This is a logical reversion of 2ad04500543, though
there have been additions to the set of mmu indexes
since then.  The impetus to that original patch,
"9-15 will use shorter assembler instructions when
run on a x86-64 host" is now handled generically.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 11d59d11ca..672ab3750c 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -29,21 +29,21 @@
 #include "qemu/interval-tree.h"
 #include "hw/registerfields.h"
 
-#define MMU_ABS_W_IDX     6
-#define MMU_ABS_IDX       7
-#define MMU_KERNEL_IDX    8
-#define MMU_KERNEL_P_IDX  9
-#define MMU_PL1_IDX       10
-#define MMU_PL1_P_IDX     11
-#define MMU_PL2_IDX       12
-#define MMU_PL2_P_IDX     13
-#define MMU_USER_IDX      14
-#define MMU_USER_P_IDX    15
+#define MMU_KERNEL_IDX    0
+#define MMU_KERNEL_P_IDX  1
+#define MMU_PL1_IDX       2
+#define MMU_PL1_P_IDX     3
+#define MMU_PL2_IDX       4
+#define MMU_PL2_P_IDX     5
+#define MMU_USER_IDX      6
+#define MMU_USER_P_IDX    7
+#define MMU_ABS_IDX       8
+#define MMU_ABS_W_IDX     9
 
-#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) < MMU_KERNEL_IDX)
-#define MMU_IDX_TO_PRIV(MIDX)       (((MIDX) - MMU_KERNEL_IDX) / 2)
-#define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
-#define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
+#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) >= MMU_ABS_IDX)
+#define MMU_IDX_TO_PRIV(MIDX)       ((MIDX) / 2)
+#define MMU_IDX_TO_P(MIDX)          ((MIDX) & 1)
+#define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P))
 
 #define PRIV_KERNEL       0
 #define PRIV_USER         3
-- 
2.43.0


