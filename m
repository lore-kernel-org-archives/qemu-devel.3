Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B09EC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp387-0008Hb-9P; Mon, 03 Mar 2025 05:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37p-000896-ML; Mon, 03 Mar 2025 05:34:18 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37n-00076L-NA; Mon, 03 Mar 2025 05:34:17 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso2995843a91.3; 
 Mon, 03 Mar 2025 02:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740998053; x=1741602853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCrkW5/SSBdsD828jdLH1Sz2kRQnvu37ag8EUtNq8pY=;
 b=jSXvhUgKmmoY1PMzFRPlp2HGcWID2IqsTf3OmfGO+vtc527e5fYoH1NTpQFqVtYv1u
 D5UfxJIsGpN2dAMOvK/82Dd7iEfctsh86pPsFh6+rO+XcypUwf+PxDSwNY1ebdyr9WhH
 vrBMBO2tnusgKJNqB4NQIdqabZwzZpZ2kMn60SRborabCK28KL+KC8XHo2ntPIjXtoW8
 MkQbnpuw4eqdIR221ZrWcUo87OWpoC+yqFlLUdh5Pka2h+l6ZWl8l6JlQyrfSmsMpA3K
 zlQFZ4TculjgJXqpY1VraN/q1XWDcZK3YmDvgEPMBMtKX8PbtUk8d5HiwigjH31p+BgE
 vyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998053; x=1741602853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCrkW5/SSBdsD828jdLH1Sz2kRQnvu37ag8EUtNq8pY=;
 b=EQV4KxpxEzJVFpfziAX36Org2kss/IkZIzePk08qi5rKWpjLTNjQeaOfzKDSAvmdNM
 Rlsgc0GgXdE10uRmtOom0IxcHCBPwlkK68XEOCZfFbWU1URHiBNUire1N08FcEMLFKLl
 skjDb093nTPQkch0V/F1K73FxkwKADsEFrxmI3IAiyEuGvTkWEO7kj4TFMkVevR7eIkV
 GcUNpnIDYCdGdKL1gTWy5uhKL6XKRsgUkQHTcVGhuo+ozyk66c5/U+lu2b7l/yWH9P/M
 ABgOO4mdWt0RX92KZyzr9CGq0Xqu7LwJp3XSbN/0/K0BfAnSRJO0THHCXrji4DD3B5LI
 wrAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvnh350xGLsmDzkkHSP29QZ7Rlt2TaUROiHRhHirC1I6lcC+7F0FD1X1eDTNi2rraprIbquC9BvS+O@nongnu.org
X-Gm-Message-State: AOJu0YxXnGfnPO7Tzyh2pGWYhAaMvENL8Z+hTvuKprll0OrjBd9pbram
 lH9904SXgnCQ0zPEAMy/bH9S4kupM4B8AjmCkDpJcOOLZhWNejeZL10ptA==
X-Gm-Gg: ASbGncuu6jeP4aFhFbolAZLWfbjR/68A8MR1cKSiWghzrAjLLpBHX5cfo7DybPbBzvZ
 1BeaqgRu3XZlXwtIciKJpAOeVudD/DOuGZdvIt2kmyxZ0BefgZ4U/ZA7UHKlzSemlgXmSnX7R4U
 7jt1u7f5aHvR23R5nDtpIOf1ygRXUeGTQmPBS4a2TTsv5PgiPXaEUOr05C7WF8VeJ0x3/deAKbF
 33C8mmapRE2/lUizdqmHmmJZYjy0+TtxfSeBMXy9/RU2W1R8FJqUqRYX0Jdpubl1G43EcQAcRJ8
 KBSyheA7VkGzTlf3FrGNHj9Rful5DnuhPVwtY6J/ydtjT3wsz8c=
X-Google-Smtp-Source: AGHT+IEHkFKtI48I+/GXUIy7f4c4vGhNHtTfUQ3bN5Bg7PiHfFmTOt97JgCumVg5LKlGkhBeX0qkWg==
X-Received: by 2002:a17:90a:e7c6:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-2febab2ed89mr18729852a91.5.1740998053467; 
 Mon, 03 Mar 2025 02:34:13 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea698f309sm8594558a91.42.2025.03.03.02.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:34:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 3/6] ppc/pnv: Implement LPC FW address space IDSEL
Date: Mon,  3 Mar 2025 20:33:54 +1000
Message-ID: <20250303103359.578994-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303103359.578994-1-npiggin@gmail.com>
References: <20250303103359.578994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

LPC FW address space is a 256MB (28-bit) region to one of 16-devices
that are selected with the IDSEL register. Implement this by making
the ISA FW address space 4GB, and move the 256MB OPB alias within
that space according to IDSEL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_lpc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 0e02ce6e940..d812dc82681 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -85,7 +85,7 @@ enum {
 
 #define ISA_IO_SIZE             0x00010000
 #define ISA_MEM_SIZE            0x10000000
-#define ISA_FW_SIZE             0x10000000
+#define ISA_FW_SIZE             0x100000000
 #define LPC_IO_OPB_ADDR         0xd0010000
 #define LPC_IO_OPB_SIZE         0x00010000
 #define LPC_MEM_OPB_ADDR        0xe0000000
@@ -561,10 +561,13 @@ static void lpc_hc_write(void *opaque, hwaddr addr, uint64_t val,
 
     switch (addr) {
     case LPC_HC_FW_SEG_IDSEL:
-        /* XXX Actually figure out how that works as this impact
-         * memory regions/aliases
+        /*
+         * ISA FW "devices" are modeled as 16x256MB windows into a
+         * 4GB LPC FW address space.
          */
+        val &= 0xf; /* Selects device 0-15 */
         lpc->lpc_hc_fw_seg_idsel = val;
+        memory_region_set_alias_offset(&lpc->opb_isa_fw, val * LPC_FW_OPB_SIZE);
         break;
     case LPC_HC_FW_RD_ACC_SIZE:
         lpc->lpc_hc_fw_rd_acc_size = val;
@@ -798,9 +801,9 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
     memory_region_init(&lpc->opb_mr, OBJECT(dev), "lpc-opb", 0x100000000ull);
     address_space_init(&lpc->opb_as, &lpc->opb_mr, "lpc-opb");
 
-    /* Create ISA IO and Mem space regions which are the root of
-     * the ISA bus (ie, ISA address spaces). We don't create a
-     * separate one for FW which we alias to memory.
+    /*
+     * Create ISA IO, Mem, and FW space regions which are the root of
+     * the ISA bus (ie, ISA address spaces).
      */
     memory_region_init(&lpc->isa_io, OBJECT(dev), "isa-io", ISA_IO_SIZE);
     memory_region_init(&lpc->isa_mem, OBJECT(dev), "isa-mem", ISA_MEM_SIZE);
-- 
2.47.1


