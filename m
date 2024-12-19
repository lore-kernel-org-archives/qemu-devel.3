Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE4DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO7PI-00076L-Ug; Wed, 18 Dec 2024 22:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7PF-00075T-UO; Wed, 18 Dec 2024 22:40:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7PE-0004Iv-B0; Wed, 18 Dec 2024 22:40:57 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21683192bf9so3405345ad.3; 
 Wed, 18 Dec 2024 19:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734579654; x=1735184454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vwlpe1MB5sgsXYOFPBQEhsgxZTpLhzeJKWOWZzIcj+E=;
 b=db5PAK6hvpNrSUJ8WNibKh11xgdJvDq2G6dqYkJSC1tNvaGRmEW39HbNzWuNxn1I87
 rtCwMrDdSC/Nl5fk10dpFycKqzvTsBPcE9Ezc7S3MeyzAtTKk+KyBCuMMJBLOQCZjNBA
 Li2w+ttDAyLn/l3SEBByuLw1yTcIIRN69qSLSiOpGYpwNVLLgOY7OmfnqNXuGb0sh6GP
 KQ99hHlwceR4gWJ5JPkES/NCDqM/hiIAzcb86mnaRX0py8YFV+a1Rjrd4/B0mnZ8v+XI
 6uU7XuUszKD4q9tGoRzffRwGfIIGR0r6qz5/e5ByFeYR/wDoXVMp6usTb1XrtDYmDlmd
 jKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734579654; x=1735184454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vwlpe1MB5sgsXYOFPBQEhsgxZTpLhzeJKWOWZzIcj+E=;
 b=QdcO2TWQa05wIvoYhx+Og9+lfD26s++pDom/+JaV3qqGIm/tasG/oEQnYOrpMSSNum
 9zz+g/Nbe5bmrBSJeyPMBREZdePze6dbhOrNkVNcP44JgGQ8H53+t8Jauqww8ZLC4DGH
 4WDvP4GHXpvtIr4dZ6HGDMDD8ufk6t08p3Tlh/7p5TyXWqC6wxSqryVAkezGlX3d4Hnm
 7TFFbnwSijom3dAIu/LG5ciSw/R35e/83j2819VDFN6mahDpP0l5R0hua9HAm6MGQ8bd
 fsbb+yB+X8px+sGyNESI080qeoHXP1llIyt1FkGXymFez6GpbuhFb5Tx1iFWTlqbSh8f
 ryFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4gXP5bER6CJbhJc0dCnuxCDON4z44b4t0fYM1b+eVCcY7YZWrql731Ss2jtA2bVjiJDpBeRMjaryD@nongnu.org
X-Gm-Message-State: AOJu0YwD3KAMxZfdetexD1SlPqUItmMDl33GUzbNYWtmMhwK3i47CLIa
 zLP6+6hSC4RUrlPDQpKxjDfaJNgva9oQlydi5yTIW2bbtoZwB+g/qn1aSQ==
X-Gm-Gg: ASbGncs8TKuOMgrj4BKl8nZLC7yuPx9uvFurDlmhAdokc0NikaJ+11RLDXw3cAN1NgA
 2KdMAPVn86kJUBXtvmCY2rdbP3FPOLhjjxdJOYa7eboGYkxICxGyrRMQbX8wftRIWUr4qi2RGlj
 vssQ0CyfNQiXwpbK1JDn2Rjv2QSpb9Xzyi2uK2mdKw6si1U2xDV8OfdvMpjyzgpeNEXsjMb5C4K
 h9mvpFXQMosvO8sM6Thkp+n+D7vI831ExqL4aF0Lw+lp8vH07vrPBm89IbzW9dpEniFmpSZzkcF
 2nafm18n9Q==
X-Google-Smtp-Source: AGHT+IH2M/jisU1OzVQI0W7JexlH48qVb/oF3O9VlP9AZCZ4bUIl3TvcYLglPfAnMi/z+IrdWz3N1A==
X-Received: by 2002:a17:902:e741:b0:216:2dc4:50ab with SMTP id
 d9443c01a7336-218d6fd5f54mr65907225ad.2.1734579654338; 
 Wed, 18 Dec 2024 19:40:54 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc970520sm2881595ad.75.2024.12.18.19.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:40:54 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/ppc: Avoid warning message for zero process table
 entries
Date: Thu, 19 Dec 2024 13:40:34 +1000
Message-ID: <20241219034035.1826173-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219034035.1826173-1-npiggin@gmail.com>
References: <20241219034035.1826173-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

A translation that encounters a process table entry that is zero is
something that Linux does to cause certain kernel NULL pointer
dereferences to fault. It is not itself a programming error, so avoid
the guest error log.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-radix64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index be7a45f2549..02099300358 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -571,6 +571,20 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
         prtbe0 = ldq_phys(cs->as, h_raddr);
     }
 
+    /*
+     * Some Linux uses a zero process table entry in PID!=0 for kernel context
+     * without userspace in order to fault on NULL dereference, because using
+     * PIDR=0 for the kernel causes the Q0 page table to be used to translate
+     * Q3 as well. Check for that case here to avoid the invalid configuration
+     * message.
+     */
+    if (unlikely(!prtbe0)) {
+        if (guest_visible) {
+            ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_R_BADCONFIG);
+        }
+        return 1;
+    }
+
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     *g_page_size = PRTBE_R_GET_RTS(prtbe0);
     base_addr = prtbe0 & PRTBE_R_RPDB;
-- 
2.45.2


