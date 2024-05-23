Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638A7C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZz-0004S7-IP; Thu, 23 May 2024 19:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZw-00049O-E1; Thu, 23 May 2024 19:10:32 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZu-0006Du-N6; Thu, 23 May 2024 19:10:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f69422c090so3470543b3a.2; 
 Thu, 23 May 2024 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505828; x=1717110628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFPaaQ719ZGm4ALc/N+temkOdUx18gmGqxDG5JRZ0UE=;
 b=aj3L/1KzbJRQNL82NCK0CzxG2orRYLF5lJQZi5fQlKqRj8LPKblkymP4Du9ipSFz84
 V8lugIk7h4KE3wmYQowbqw60Xu7TEd0Fyv/Ni3+x9L5Tu/+itLZdtFs4JqqNnWMJxU0B
 SYIH1dC+iD/l8e00hyfUENXUGUII3sKw2JFm+k7bhGcQ+Qk82WIt8k2GAA8l28axVgSG
 8odGu/930OI1hcNqFnnCbhkZrmosZfvMHnLR2UrV0YW+ejBdXV2KnPcmfkF4It6xn/QS
 MK82SPf/41xDCkHho+4zzo0IgHIbIIsUALnErGk6mhYD/J/HScASkAp09cvH3iy/Hiuc
 usmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505828; x=1717110628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFPaaQ719ZGm4ALc/N+temkOdUx18gmGqxDG5JRZ0UE=;
 b=kcmcjRvdRhdgZoOl62jbGkEFmhqkfjfKxrZ1jsL2Da+EAyPrCtkbu+uwdyYo7W1qSR
 9AWUd9Ork9zZals1saY7d1jkZUrd7KAg/+q2WHVhMjLRDcEwrHxR+A0KBkq1XsgRYbAB
 xswLSL2GZghLTOIl0X7S2Fx9cH6/GOooePhK4q6W0Ly2DxEMeZDZr8POLfXMpTBC7Og5
 IV4VOSzmEGIPJZbHTDOWmGSy88RCUO0ErWNY/DBY9kVD3NCTB5aoAF16CB7OUCfrQZvi
 3KAaqRDE4jaImTjaeG3y2xBFKdS+F/HQYrDMXnguYBZpjKyE1wW8X2kL6ejKYNR9WoSI
 Z+ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVooeSpJQlo2OjM7mzDrAdpvNEXIAVV3+cOX4YqpQumk/vM4Y/CnzsAJ2pxnUSiFnY9fwUXfavHX4yIuwXUeDK9CCjP
X-Gm-Message-State: AOJu0YwFMQfyh+YycMFl4R9ZEw5r5K40DNUy9pFnlA29p+zZMQRMX3NX
 kzhjz+UY3DrCfAH+RlfOQRSl0/tN00VQIXeIoquH0SCd6CIOBNaSUbi4rA==
X-Google-Smtp-Source: AGHT+IFbkUa4EIpqV8anYcpmgUI2GmsPqq6A0kYRL6F6GGXZUWGF0dC/GVqwlB46qQdJgaeVBb3k7Q==
X-Received: by 2002:a05:6a00:2a0f:b0:6ea:c43c:a650 with SMTP id
 d2e1a72fcca58-6f8f41a95a0mr528602b3a.32.1716505827889; 
 Thu, 23 May 2024 16:10:27 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 49/72] target/ppc/mmu_common.c: Split out BookE cases before
 checking real mode
Date: Fri, 24 May 2024 09:07:22 +1000
Message-ID: <20240523230747.45703-50-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

BookE does not have real mode so split off and handle it first in
get_physical_address_wtlb() before checking for real mode for other
MMU models.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 03d9e6bfda..9f177b6976 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1175,6 +1175,13 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     int ret = -1;
     bool real_mode;
 
+    if (env->mmu_model == POWERPC_MMU_BOOKE) {
+        return mmubooke_get_physical_address(env, ctx, eaddr, access_type);
+    } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+        return mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
+                                                mmu_idx);
+    }
+
     real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
                                       : !FIELD_EX64(env->msr, MSR, DR);
 
@@ -1195,13 +1202,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
             ret = mmu40x_get_physical_address(env, ctx, eaddr, access_type);
         }
         break;
-    case POWERPC_MMU_BOOKE:
-        ret = mmubooke_get_physical_address(env, ctx, eaddr, access_type);
-        break;
-    case POWERPC_MMU_BOOKE206:
-        ret = mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
-                                               mmu_idx);
-        break;
     case POWERPC_MMU_REAL:
         if (real_mode) {
             ret = check_physical(env, ctx, eaddr, access_type);
-- 
2.43.0


