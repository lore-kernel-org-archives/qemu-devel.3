Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E26C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp389-0008OA-BZ; Mon, 03 Mar 2025 05:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37w-00089w-UQ; Mon, 03 Mar 2025 05:34:25 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37s-00077Q-Qm; Mon, 03 Mar 2025 05:34:22 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223959039f4so24118795ad.3; 
 Mon, 03 Mar 2025 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740998059; x=1741602859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3AZuJ9knP2vix0loLxAZpy1PVhtWN6trVm/NXU34mY=;
 b=ZX9B/Nbws+ktMfA0GyxgBEn/NIbzYZBnFCPSRpuBkYpaxTAUQE5UZ+aefCRUtw7/vc
 N5g4cerEt+kEZe+xH6cFRxo5e9wdPT1n6mYHqemDjEZDl4pUc7IqFXz/uAkwaMNKWs25
 6RP0TLsc1SNhYcNeHXNsVLOkAeCex5muSfNOmS1HADjqWJXNBfaoiL4xtkp3s4empSVu
 KDBFVgE0GnC7O4h5Q1ElAcSap1r0JMAz33gBcc6SlXtB3/genmmHjX75b0lh6DuKZhpi
 IiAOoDLZtO3ncC5IK3AEIf4bS80LoFWJgOeKr27rM7oZ/N+/rYaU0ZDi4LeQeJwkv3tX
 lVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998059; x=1741602859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3AZuJ9knP2vix0loLxAZpy1PVhtWN6trVm/NXU34mY=;
 b=XVUxGnCP6PXiL8L4WKwMYzfLDuVIp/CD87E1OSzyBOfBZhFcnw8Pd+PeeGUolLjwW2
 rnYBecz6OFPJmChRLiUuTPVAAmhykyEPdkdGv9aVSinTOBYO4qXnK4FBfYFWa/BhC8JO
 CfoUeCW3K/q8F8UY33E/R7YUUfFkkr4FMK2iT39H++xk3a+0a0kD47DNpyM8gDSiI0rh
 nl6fVwE3d7DuE/TxMefyMpWYNAl9CMAT50jE0+7Pr1RMQgFiUb4HhnSK0CMlTtMUQOo3
 DD7Ner6Ew/aXL30XS3h7vZXEhbKXMTGp4DsZOilCRNH/Ghrv3UCXcklMhdusyR3xVuM4
 2cRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB8grCJK0iYgRuDhKQ6wDIOTeuEABtwRAhQ1ORzlrcQKdrXeB8w40CmJxledhTio4NRgCM6YQN0nyP@nongnu.org
X-Gm-Message-State: AOJu0Yx6Inb9oq0TQEwHtsGmHhkpKkJm9MW9yWlLD8A7g4SBrhxQXU+i
 lL0SV+v/UN/CfyI4b09K0oJKZDvN/PGsTyqV60WtGJepGpWMtngkeNawcg==
X-Gm-Gg: ASbGnctW5mP6XIFp/Yd8qlb6gNJIM8qTNQCiEU6qz+a/XkmTlPzJKfCh+H68hthxMy0
 GQBB18mBrmw3YzwPyQgiNJc1X2kEdlqAb8GQZwSwh1xOUqvW/5h+V+z80oQgfsmAy+rEY10NTQg
 ZbMp1DzzzsqvyL4lh7+E2/iv/DS9irrWBzY/ylgpcq3RAMKxcVhtHlXD5B/fnM/aL/OWV4vK23G
 v4bl27ZbCcs2FAPGCJrko9M5uLbnrDo/2CGx3ggtfcwnhq4wmQJZ33nl/Jr7/XyHrD4yaoaJy0n
 QGQAWgNmLiLkaE2xUx9/BNgRuPKGnQ0e4FzF3XGRN5wzIycTRU0=
X-Google-Smtp-Source: AGHT+IFYfDkXOZ6/TmyN+hewIjyrM1BZuEFUPLC9YGgbYePDgBf5RFILKWDqj7tNoxmQe25qr6Zm6Q==
X-Received: by 2002:a17:90b:4c4d:b0:2fa:e9b:33ab with SMTP id
 98e67ed59e1d1-2febab7878bmr22055491a91.16.1740998058905; 
 Mon, 03 Mar 2025 02:34:18 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea698f309sm8594558a91.42.2025.03.03.02.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:34:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 5/6] ppc/pnv: Add a PNOR address and size sanity checks
Date: Mon,  3 Mar 2025 20:33:56 +1000
Message-ID: <20250303103359.578994-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303103359.578994-1-npiggin@gmail.com>
References: <20250303103359.578994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

The BMC HIOMAP PNOR access protocol has certain limits on PNOR addresses
and sizes. Add some sanity checks for these so we don't get strange
behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_bmc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 0c1274df21a..811ba3d7a49 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -251,10 +251,38 @@ static const IPMINetfn hiomap_netfn = {
 
 void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
 {
+    uint32_t pnor_size = pnor->size;
+    uint32_t pnor_addr = PNOR_SPI_OFFSET;
+
     if (!pnv_bmc_is_simulator(bmc)) {
         return;
     }
 
+    /*
+     * The HIOMAP protocol uses block units and 16-bit addressing.
+     * Prevent overflow or misalign.
+     */
+    if (pnor_addr >= 1U << (BLOCK_SHIFT + 16)) {
+        warn_report("PNOR address is larger than 2^%d, disabling PNOR",
+                    BLOCK_SHIFT + 16);
+        return;
+    }
+    if (pnor_addr & ((1U << BLOCK_SHIFT) - 1)) {
+        warn_report("PNOR address is not aligned to 2^%d, disabling PNOR",
+                    BLOCK_SHIFT);
+        return;
+    }
+    if (pnor_size > 1U << (BLOCK_SHIFT + 16)) {
+        warn_report("PNOR size is larger than 2^%d, disabling PNOR",
+                    BLOCK_SHIFT + 16);
+        return;
+    }
+    if (pnor_size & ((1U << BLOCK_SHIFT) - 1)) {
+        warn_report("PNOR size is not aligned to 2^%d, disabling PNOR",
+                    BLOCK_SHIFT);
+        return;
+    }
+
     object_ref(OBJECT(pnor));
     object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor));
 
-- 
2.47.1


