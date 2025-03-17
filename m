Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E57CC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2xP-0006iG-TP; Mon, 17 Mar 2025 01:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xN-0006hd-Oz; Mon, 17 Mar 2025 01:24:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xM-0007oP-2h; Mon, 17 Mar 2025 01:24:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso65832775ad.1; 
 Sun, 16 Mar 2025 22:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742189046; x=1742793846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxaRFbncyxlnm7heC5LP05GgEcrs1GqHGHGwWOssd1s=;
 b=ZFElg1t6nvAbLXh0fYvRPqfjHA4U/Oey4sGAcdIXqkjSPjEnYhvjEsLm7EUsTYlzkl
 UHihm0S9zcVemkI+IR7NcNLaLEPUyjQ6+b9sDQpOeJl2Dsrxw3KgKOAtO8KEem9A2k7s
 lguEW8Rqzuh9OpiKgSDwTBYYqzYoihwER8m3NHXtTvlRSatrhz2Mig2N1+I2vU5U5iFW
 sRcGcKAQq3dXt3LVKGvKGl1vADz52BHFZLecW51/X1UqhSedxzas4q0tgLC7GheI471Z
 nYF836R+fNTcv06lnD1riDRrBGsNag18FgHP7K5zNHeog7nsDgcOs0/ZUPPwuLubIHZX
 eSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742189046; x=1742793846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxaRFbncyxlnm7heC5LP05GgEcrs1GqHGHGwWOssd1s=;
 b=iSg2W+dWmxexKEZuYzjyUMDWU7fo9doZASQ8QGa+SKfz59GXA2X1f3H8c/GUNa38zE
 mp4t4J6MoxnafjHLfUmnoVqj9QqC7tXdgkjusa3qziOtKHAQYAIoOjb1KVXurjXeVZDA
 fClHqSjbKZD8tmt8O1EJU+HwtJ4kJNS9UJ+X8gAHEZz4VDS9XhaqWLz3KY563EhqdHFo
 TRcGHaNyA8mqCgVTeeUP44J7wb/rkrJCVhsBKfY4pNbkMVK3HjwHra5G3b7pTkOzdOJ3
 zJyCAN6eqZk6v0FbueK/yL034/7a78hhyIjFjNj2EYySgK9R4ZN4SuaQdL3Y9oys94rd
 t37g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEn58Rv9Z0g5UknyvpEDIvXyili1sDbBQ6N3FDLmQ+Q2JYwC5bS5ILlJaGOKxkFTSMob8N+Ge9OQ==@nongnu.org
X-Gm-Message-State: AOJu0YwUvqg9en2i5OYELDvoLwPCj5v2wRUB+femavlzTY4TcXiv/+Kb
 RoGSHctXssnJJq7OJ7KtGCTBewnSzcAIKSwk2MA20PD0gQadDbs48tUYfg==
X-Gm-Gg: ASbGncsbdog4EIZ/W+x2ZVI4U7GuwRn9LdGdnIzx/QIWvlQgTHchl0T9RYU1s3CSF7E
 VRbbCYgNVf4YcqU9D0q8Ix2lQzVsXeSMvTQB+lL6k9R6+2SPtfV5qUDdMBhrAFWAADh/3JPg2in
 q+ZF+DeNS0o9y2C841/86YsKCIG/gKs9i9WCh4uK+qJoFCMXI+1G0kLbw0Fw8vQEzXfD8URdn9J
 jgxijyHndat41VU3ZAQRfeEqMTfz5xqn1VfLNCOgNxApE/SWwCB8NAUBzRYTKiFp1cdhAP+3/B3
 CRGFNQyiokitqBxJJYz8vRDvIRIQ7h7kx5+9Ki4pK1w95ih4UA==
X-Google-Smtp-Source: AGHT+IH7FV73JLG0d04jqf3cEQMjr+Qd8mpByhshKLKE8F2vd4hDYYbHMXejcL5yXBJuR8s/02P87g==
X-Received: by 2002:a17:902:dac1:b0:21f:6d63:6f4f with SMTP id
 d9443c01a7336-225c64f42bdmr181878175ad.2.1742189045903; 
 Sun, 16 Mar 2025 22:24:05 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b6bsm6879495b3a.148.2025.03.16.22.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:24:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 5/6] ppc/pnv: Move the PNOR LPC address into struct PnvPnor
Date: Mon, 17 Mar 2025 15:23:37 +1000
Message-ID: <20250317052339.1108322-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317052339.1108322-1-npiggin@gmail.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_pnor.h | 1 +
 hw/ppc/pnv.c              | 2 +-
 hw/ppc/pnv_bmc.c          | 4 ++--
 hw/ppc/pnv_pnor.c         | 2 ++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
index 19c2d642e82..b44cafe918d 100644
--- a/include/hw/ppc/pnv_pnor.h
+++ b/include/hw/ppc/pnv_pnor.h
@@ -28,6 +28,7 @@ struct PnvPnor {
     BlockBackend   *blk;
 
     uint8_t        *storage;
+    uint32_t       lpc_address; /* Offset within LPC FW space */
     int64_t        size;
     MemoryRegion   mmio;
 };
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 59365370c37..63f2232f32f 100644
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
index 811ba3d7a49..fb70a8c1f22 100644
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
index 863e2e70aca..9db44ca21d8 100644
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
-- 
2.47.1


