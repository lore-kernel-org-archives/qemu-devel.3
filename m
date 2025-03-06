Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D66C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDlj-0000Jt-Mq; Thu, 06 Mar 2025 11:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDjW-00072c-QZ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:06:07 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDjU-0008PZ-LC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:06:02 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d1a428471fso6554475ab.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277159; x=1741881959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEe7q4w3SeigGu9Yyevoz5YHH/txq64uIVifPcLXvEQ=;
 b=Ub4DjTw1KQBH6Oqx+Z8gGQr7gJy4Aj8GBJRLG2ANxc3fq7gHfIHy8nDNmznJC5gElp
 20SgzkuZLDM7Won3sdOt9U/OK0lG+NM1IH8oeGWXfMLzWD5REf0UKtfV+0X0SMu2z8Wl
 fV2PlUYWyCTiuppM6uJExIARXcLsOBSjzgk4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277159; x=1741881959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEe7q4w3SeigGu9Yyevoz5YHH/txq64uIVifPcLXvEQ=;
 b=If/dpH9dbyEzjgmbkkOynWLZ+YLOQhyDDuM0tMfrxxbQ4JYv6jc5+9ua5o6GSdHBLx
 KNgKl++DUX2hZRd1W1/FlqrQ06CmwJXlMQRE9yCjfXyAuMlBZ7xhkQH48+xWmYR+dUE+
 182OiwtZtt7/GhQqdrakB8cyEGpnrg6ebvKZq3+F2NpMF/ApQf+4ugEBXgATuL819u32
 3rlApo25rSYV9oS18q8laGAktijQn9Gtzvmpb2vqCROruNgA3vow61YnIiyHUwY7wlwp
 kAiF6AGWJpLhTe9/Jx4u0Ygbz7ep27PzWaJzEnRGiNaZN4KKlL9f9LLT1D2GtJWxii/P
 r0GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/I1Qz8k7dzWHBXMHvXT2riixTXeBqxRValQNByzCDLr608p1yVIb6ctXFQb6Fg3GXKNzX+xO1gwms@nongnu.org
X-Gm-Message-State: AOJu0Yxb5muNTuP4CBrYVPC14HDKgd+G7HsVI8/irAWHcWfksWwXQfFk
 0xCYQlnEanR9UZiAhSPCTEo5XhkjEUOymkOUYO2REoiyeQ+fYfT2pL7UY/F6jA==
X-Gm-Gg: ASbGncsFGhsgFgp0wo/asU06B/X1FuqsiBOMAU//dgR+v2Moek7NXFglG7M4o6f9Qzt
 uye3ijPseOfOgQ8NbsfFX2CK24wstCTVVEoHr5GJuOQitTthM/Y4qeU71U79CHnfriBHqEE3x4L
 C9JMCKK2a4G+OHszdrgGOdX9NvfvJBFhF0j2Xg70FVsmtZN9qXoLek/QUEYoECrH1oQ8QEVjYjq
 dZWSkhN/riQUlDtzJb6Hae80BN0GMgJjNXT2qM8t3pnFdk83kcT6PcrfxbeXL6mk+c6KyzORkBG
 rzYGYgIqzgL1Ao+aF9ojNkVb721W/OAXFv+65i5amNhqkFP3gB2dFjUEtFUTUBZ0iQxEztA9lkC
 nOqGEvg==
X-Google-Smtp-Source: AGHT+IFVrNhma8uIsT77632739na8ad17f1vpP9I5ULeUIufeQtRgBbCD/r5f5pfbzXHknwO/BWWFg==
X-Received: by 2002:a05:6e02:1c0e:b0:3d3:f4fc:a291 with SMTP id
 e9e14a558f8ab-3d44193e19fmr390085ab.19.1741277159017; 
 Thu, 06 Mar 2025 08:05:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 34/47] x86: qemu: Use the new e820 API
Date: Thu,  6 Mar 2025 09:04:01 -0700
Message-ID: <20250306160428.3041057-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=sjg@chromium.org; helo=mail-il1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

(no changes since v3)

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


