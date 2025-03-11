Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C78C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCw-0002sJ-T9; Tue, 11 Mar 2025 08:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCs-0002al-2B; Tue, 11 Mar 2025 08:59:38 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCm-0007yt-HY; Tue, 11 Mar 2025 08:59:37 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff6ae7667dso10225697a91.0; 
 Tue, 11 Mar 2025 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697968; x=1742302768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWFZ3hhh+CauKRhvgamT4Y6yPpw/m5EE+YXGOVXnowQ=;
 b=fukWU700sv3SNmaskwEv76wTHdATqZeKREVlH2wOHCLLSG97Y96uRFJy62Yu4g+VTS
 2YVN8WO/E2rCsyIyE2H0iurdzLzpF7I5YuwfilxIJqm9AemjKXL7vy8mZMnbNee/OxKn
 aycwd8/qz+AdRWZDwzCaeHlGTiTv7GvYqgNkllU1X/Ge1ou92xqyEJ0t3mTocq3h3a58
 eMvrNRArneccI/ZgqES3jntZeLkkurad1aw1VIP4HTFjOfaoCSITOEWenAH2/TWskr3b
 dh8p/dTBrhkheYBzHnZflsZg4ZTbRCx+l3E0VNalr49hItvaUyKK9b0i2RmVBGIeSbIM
 i+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697968; x=1742302768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWFZ3hhh+CauKRhvgamT4Y6yPpw/m5EE+YXGOVXnowQ=;
 b=uBAMDKPTrwwNkw3Efj+1IBkcb7guISZFW9Gz3AQ2QJIasRlffo6pdKVJ4aFxbYfbF3
 tMlKrv4FOLN8kws9LWhmCQuJQeEm2Q59om4sH9cQvzjgpgYnpbZCKVGt2xKerRl9s/O0
 VSRqOg5Pitvoj6W5nM+IzrGW/B55dT2JzDtKS33x4VPR6YtF1vtqJ5LxcIQ3//KBgR7o
 2uYDhev8Zz+e1XkabLMQENgVlWymva8EltNd+JNXBbEacbo7eSnXNkE8D86/EpqovYf1
 iQyRtgsH6fL/lQk1/yAZdQJ/+TJnKSMGu8BGoREPvN9Wz+Jtnzmgq/Pru5ndrS3/q/lj
 3wug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjUt8OkxvbDrQzWrmZ28u6DUlo9sOpM47KKXUSWin8hRr88g2u51eFYqZISHAMVetBsDCjxbqDzA==@nongnu.org
X-Gm-Message-State: AOJu0YwucRyzJJxjZpyffyVjD1xVq2wG3HuhE/DVLkKhtQoB5v2n4Cwx
 eK2ViLErR5P6dmoKhnfoud7A95Gymqltu+gKE37CU5V+HE1Juv+FROxSvQ==
X-Gm-Gg: ASbGnctPNuIyeKmTwUn4HvbOvCl6DcYxKiarciQLkrp8jyt39oGgv7Gk03zP3d8yvMj
 qPrKDJ0dnfz460rN9yYhm5Ru1/SK5W0HFvVPlNPjZFndHOmCGFkqEQnm8D+j3iqkHtBlc9VuKew
 086AlX+KuXkcfRDQCNIFYAEMVpGs7OsUBrdg2SKsVlHVJyszTimAsdcWecg90lAPTLVK9TXwxIz
 vs2ktslWBswAfqoDQdJ3h/fqtou+OUxy5nJv/sZrqFaMbQNfYBwqy1C2Wl+qpmmACqZ0WhutISJ
 bCbMd0RStBe4CyXg8vbRgMo45bH2OewZ7mFLKdE51ulz0oim7Ys=
X-Google-Smtp-Source: AGHT+IGsmLnQ5nuz1baaSGWshuiCQAoKQNb38fSHNEUxPj5+z+qFuI1Qmib2l92ftTxdSaro4tuzNw==
X-Received: by 2002:a17:90b:3c08:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-2ff7cd45c1cmr32797426a91.0.1741697968252; 
 Tue, 11 Mar 2025 05:59:28 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 19/72] ppc/pnv: Implement LPC FW address space IDSEL
Date: Tue, 11 Mar 2025 22:57:13 +1000
Message-ID: <20250311125815.903177-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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
index 0e02ce6e94..d812dc8268 100644
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


