Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16726C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVpu-00010C-22; Fri, 21 Mar 2025 02:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoH-00080v-VL; Fri, 21 Mar 2025 02:24:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoG-00030o-0l; Fri, 21 Mar 2025 02:24:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225df540edcso56742445ad.0; 
 Thu, 20 Mar 2025 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538285; x=1743143085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPlqrdvSPBhbQRkDKEesOvGQR55g+BN08vpUbW76CxI=;
 b=lSGZl4pnwwrMssvlGWpwmrkIMTJNMs3lWW6ea3c3Cte70PuVDfEB2c1QG5FU4O1qHK
 44c0nCtC+vuhlkR4sgxjtbM6FGH1U5b36z4nM7TP1vpQSy3Q7L2lMcZWI2VfQhH6tqiT
 H6hhY2KGvHh5j9YnQFiYrUvXqC6hGpBzW3r5Emh37iGDmjelgXHQdCOGcqIvj8cxs/JN
 565qibsGwyi3WJBfJR3jE7myCyMetfZAYxcTly+6z4sN+hiEfV9jZpfRCOuAggG+JxwU
 qAQfpQk7hTGvwgdLaES7CeRpr6gXXjuzhZFBiuiy4WqTQBvDCIg6j/xJwt8J/A2HdBrh
 Ycsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538285; x=1743143085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPlqrdvSPBhbQRkDKEesOvGQR55g+BN08vpUbW76CxI=;
 b=V+DWMWB/Yxp7U5gwtiAG8R7HI80MwhQi+t3g11q1veKAVimBjh0AWY8VQk+HqcNfe+
 vnZaReePzN1MgqUkYtju9kYWCttpr2QmI+z001xzrMJDtTLOjQ34PwG8Gho1k3wRsv1e
 oPnSs31+07IfBAoVLtiNE2qsi8NXQM4FXrL3t1Ed6At5OlHF6Q3fKM2clNrjpLkKLCdx
 74UmQk1xgR14NyVsetflVyDO7HpS+obIScDrtgLMjqocEyhbATDsDcZOLW7e/F9074F8
 tBmvah1FHwQgu7tJJVfcGJjHiwpOIKzVNulRyqLPjXrtcAgbwZ6HkVISBIPO61u4I9/B
 vnzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIPRP5UHc/qfI0hk3QZLDPGvIlUT09gQd4k4JCUQeMDWPBlDcWfOOcMRBaiwKO4Twi2OMC0/Ddiw==@nongnu.org
X-Gm-Message-State: AOJu0YwTDxm9Pc9bn0U/SjLgLA8D91lJnuxxIi9OZlFc1FIzZJZ5raue
 75yYrinr+X9T9ojNFa+lGzmS01YY9+OZ76eV8PL9nkrHrTKE+0RpH44bwg==
X-Gm-Gg: ASbGncuHFCKe0vEis0anqLT5wfg0c7fCpzBhelxEq793ab79189ixmtQBdErLDqiNSL
 qySUPv36UBPoYYO0VRV6Lah2muU2l/nymnG5RzDGLYKxFJQpN5Jg7R1my7jZxpStLUcbUbnHexc
 tc6XrG2MZ05YuQLYBWVXzik+fs/gWpE7humMYH//CKuDTt9vjYUPrISrb6XhJP95nVgLa2CaSEk
 LJXb3GZfaOa7V8jm6M9dWpKlEj4RFajS8WcNJ0ES96nNdR1mDPfh9HnpZ4ceSPuCo001JItIxqL
 jQNlPtagIupHZ48yEFw6SVLtnYQnKNTe39/hRzaFyBQICUk62A==
X-Google-Smtp-Source: AGHT+IH/gZlhJTpKT1n2fkcvl7j9Vw5q6C95zNaaIuxkhMSPTSmvWNnzXHJlMtzZ7y/WzFr4rcTQ/A==
X-Received: by 2002:a05:6a00:8718:b0:732:5875:eb95 with SMTP id
 d2e1a72fcca58-7377a0c768bmr8279841b3a.4.1742538285446; 
 Thu, 20 Mar 2025 23:24:45 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/12] ppc/pnv: Move the PNOR LPC address into struct PnvPnor
Date: Fri, 21 Mar 2025 16:24:10 +1000
Message-ID: <20250321062421.116129-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rather than use the hardcoded define throughout the tree for the
PNOR LPC address, keep it within the PnvPnor object.

This should solve a dead code issue in the BMC HIOMAP checks where
Coverity (correctly) reported that the sanity checks are dead code.
We would like to keep the sanity checks without turning them into a
compile time assert in case we would like to make them configurable
in future.

Fixes: 4c84a0a4a6e5 ("ppc/pnv: Add a PNOR address and size sanity checks")
Resolves: Coverity CID 1593723
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c              | 2 +-
 hw/ppc/pnv_bmc.c          | 4 ++--
 hw/ppc/pnv_pnor.c         | 2 ++
 include/hw/ppc/pnv_pnor.h | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 59365370c3..63f2232f32 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1191,7 +1191,7 @@ static void pnv_init(MachineState *machine)
      * Since we can not reach the remote BMC machine with LPC memops,
      * map it always for now.
      */
-    memory_region_add_subregion(pnv->chips[0]->fw_mr, PNOR_SPI_OFFSET,
+    memory_region_add_subregion(pnv->chips[0]->fw_mr, pnv->pnor->lpc_address,
                                 &pnv->pnor->mmio);
 
     /*
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 811ba3d7a4..fb70a8c1f2 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -174,8 +174,8 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
 {
     PnvPnor *pnor = PNV_PNOR(object_property_get_link(OBJECT(ibs), "pnor",
                                                       &error_abort));
+    uint32_t pnor_addr = pnor->lpc_address;
     uint32_t pnor_size = pnor->size;
-    uint32_t pnor_addr = PNOR_SPI_OFFSET;
     bool readonly = false;
 
     rsp_buffer_push(rsp, cmd[2]);
@@ -251,8 +251,8 @@ static const IPMINetfn hiomap_netfn = {
 
 void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
 {
+    uint32_t pnor_addr = pnor->lpc_address;
     uint32_t pnor_size = pnor->size;
-    uint32_t pnor_addr = PNOR_SPI_OFFSET;
 
     if (!pnv_bmc_is_simulator(bmc)) {
         return;
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index 863e2e70ac..9db44ca21d 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -108,6 +108,8 @@ static void pnv_pnor_realize(DeviceState *dev, Error **errp)
         memset(s->storage, 0xFF, s->size);
     }
 
+    s->lpc_address = PNOR_SPI_OFFSET;
+
     memory_region_init_io(&s->mmio, OBJECT(s), &pnv_pnor_ops, s,
                           TYPE_PNV_PNOR, s->size);
 }
diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
index 19c2d642e8..b44cafe918 100644
--- a/include/hw/ppc/pnv_pnor.h
+++ b/include/hw/ppc/pnv_pnor.h
@@ -28,6 +28,7 @@ struct PnvPnor {
     BlockBackend   *blk;
 
     uint8_t        *storage;
+    uint32_t       lpc_address; /* Offset within LPC FW space */
     int64_t        size;
     MemoryRegion   mmio;
 };
-- 
2.47.1


