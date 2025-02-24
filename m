Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA669C021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmhYa-0006bV-53; Mon, 24 Feb 2025 18:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhYW-0006YJ-UY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:08:09 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhYU-0007hD-B0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:08:08 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d284b9734fso44177455ab.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 15:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438484; x=1741043284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPqq8WYaPj6J2IwBDMowPX92na6feXUAfjpPv3BrLRw=;
 b=CtYuJ3i4w9CX/qx3irDD0XWFVAbIYbi0YflD64DRrdVckj+QJiMRbbl3BpppVL5zdO
 ZMJTb4McJbn1GMuc7ZTxPBDYL7kqOYqiG3xAW/KZAlmQscP+CAfIXsWtRNG/lAgzuGf3
 0wwGY3YXkjgIrSL+ZiEV6w9Jw4EtBaEGHt7lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438484; x=1741043284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPqq8WYaPj6J2IwBDMowPX92na6feXUAfjpPv3BrLRw=;
 b=q74lBRlj+8c2unJnfElEKlZVayUJTWTxCXuUgmyvXuXnUv2LUj2j+1qW+OCNUAQHT+
 RwqYNUpQXMTxp7xxr3vkpUHgfi1xrI1ZwNE8MgC9ayxuYrNhEx6VLNlpXoyqazVBGB0p
 v2sDooh/LEPsQLgTgQj3hH9Lu+fMyDoLgT4jWyhufoarwKWJvG8yOKHoGeibdqu3X7Hw
 BIhnh/r/+ZEVU8im+FQDJOpYun4SQf86ednegPuAIUsdImpew0aE9BXzqvvI3qnyywei
 Zm2iWVnq6t+zbgaWGxXn5O1sW0kj4GsKb0ad9avvwIzehPgCwwuOczEgsXpT3LpZSMDB
 Sf8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV66+yqL5k2WDOe8Colk/cVF0jiQeiIm95jwFGz7lYVvGvJmUQsHou2TwUVWL9Q0fYOIle9IWwick54@nongnu.org
X-Gm-Message-State: AOJu0Yx6rr8P9FURg8TrrUBB9mQKIbH9j8tgu53FWAKQcVpTL+qL2t04
 hIsUaYvBBXPbs+mLs4WBDEK31b25jTi6ycP1rW8OOgR1KgXORhzGJCNcF0I9bw==
X-Gm-Gg: ASbGncthEvymVQjNXsbrN84PE0x53PRpmN+aY/bk5NDA4N7CjbthovKplacDC+Vge6j
 WJxpPLOfpCqGPHZ+617AwVCJA+S8lEccDTPeCxUiZ+Rhs9klQSCu9tYd2Fx345m454h+Yt2eVu/
 bBM5j89hOrQ8n5jpbq//Ywgxs66dGV4EA/szSFZfI86Lo2UwwrW5e52bh9vzlCNma8DzVpfKFqr
 BjVeI77AEySLExzgRxrRMtBWpun0X8R4PJpa66pz9K3Prt/eM4c4GJ+sBppzN/D6ezr7Eyf9b5S
 AsfdUU0kHjpoYvqN+HOayfiLlSG+svGazB9BRQFps/Lr9oIrWOn1al4j8dVlYtg=
X-Google-Smtp-Source: AGHT+IGHuENz4NSG2YP3MtyNHiMYnYsoBcaBZ+4DIs/SSPItUKJyfRJV3Nh4u0OHC1KyNa9T9uFUxQ==
X-Received: by 2002:a05:6e02:12e8:b0:3d2:aa73:7b65 with SMTP id
 e9e14a558f8ab-3d2cae699b6mr137167905ab.6.1740438484667; 
 Mon, 24 Feb 2025 15:08:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 32/44] x86: qemu: Use the new e820 API
Date: Mon, 24 Feb 2025 16:06:21 -0700
Message-ID: <20250224230640.2665206-33-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=sjg@chromium.org; helo=mail-il1-x12d.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Move over to use this API before making the code even more complicated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to use the new e820 API

 arch/x86/cpu/qemu/e820.c | 48 ++++++++++------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/arch/x86/cpu/qemu/e820.c b/arch/x86/cpu/qemu/e820.c
index 17a04f86479..2b0ad179489 100644
--- a/arch/x86/cpu/qemu/e820.c
+++ b/arch/x86/cpu/qemu/e820.c
@@ -19,51 +19,27 @@ unsigned int install_e820_map(unsigned int max_entries,
 			      struct e820_entry *entries)
 {
 	u64 high_mem_size;
-	int n = 0;
+	struct e820_ctx ctx;
 
-	entries[n].addr = 0;
-	entries[n].size = ISA_START_ADDRESS;
-	entries[n].type = E820_RAM;
-	n++;
+	e820_init(&ctx, entries, max_entries);
 
-	entries[n].addr = ISA_START_ADDRESS;
-	entries[n].size = ISA_END_ADDRESS - ISA_START_ADDRESS;
-	entries[n].type = E820_RESERVED;
-	n++;
+	e820_next(&ctx, E820_RAM, ISA_START_ADDRESS);
+	e820_next(&ctx, E820_RESERVED, ISA_END_ADDRESS);
 
 	/*
 	 * since we use memalign(malloc) to allocate high memory for
 	 * storing ACPI tables, we need to reserve them in e820 tables,
 	 * otherwise kernel will reclaim them and data will be corrupted
 	 */
-	entries[n].addr = ISA_END_ADDRESS;
-	entries[n].size = gd->relocaddr - TOTAL_MALLOC_LEN - ISA_END_ADDRESS;
-	entries[n].type = E820_RAM;
-	n++;
-
-	/* for simplicity, reserve entire malloc space */
-	entries[n].addr = gd->relocaddr - TOTAL_MALLOC_LEN;
-	entries[n].size = TOTAL_MALLOC_LEN;
-	entries[n].type = E820_RESERVED;
-	n++;
-
-	entries[n].addr = gd->relocaddr;
-	entries[n].size = qemu_get_low_memory_size() - gd->relocaddr;
-	entries[n].type = E820_RESERVED;
-	n++;
-
-	entries[n].addr = CONFIG_PCIE_ECAM_BASE;
-	entries[n].size = CONFIG_PCIE_ECAM_SIZE;
-	entries[n].type = E820_RESERVED;
-	n++;
+	e820_to_addr(&ctx, E820_RAM, gd->relocaddr - TOTAL_MALLOC_LEN);
+	e820_next(&ctx, E820_RESERVED, TOTAL_MALLOC_LEN);
+	e820_to_addr(&ctx, E820_RAM, qemu_get_low_memory_size());
+	e820_add(&ctx, E820_RESERVED, CONFIG_PCIE_ECAM_BASE,
+		 CONFIG_PCIE_ECAM_SIZE);
 
 	high_mem_size = qemu_get_high_memory_size();
-	if (high_mem_size) {
-		entries[n].addr = SZ_4G;
-		entries[n].size = high_mem_size;
-		entries[n].type = E820_RAM;
-		n++;
-	}
+	if (high_mem_size)
+		e820_add(&ctx, E820_RAM, SZ_4G, high_mem_size);
 
-	return n;
+	return e820_finish(&ctx);
 }
-- 
2.43.0


