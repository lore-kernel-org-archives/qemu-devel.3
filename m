Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF543C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp37p-000894-L6; Mon, 03 Mar 2025 05:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37n-00088L-Gu; Mon, 03 Mar 2025 05:34:15 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37l-00075Z-1f; Mon, 03 Mar 2025 05:34:14 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2febaaf175fso4664952a91.3; 
 Mon, 03 Mar 2025 02:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740998051; x=1741602851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4S8rnC1+5w/GBtgcoACwXWBW/0V0OGHaa1l5WT+ryk=;
 b=i9nBfi1jPQN5L4kRba0Id5QpIuMAhiktf1FgtJbhcGBgLiFhRy+uzW8PyOU2O3EiMu
 Q81GR9OQ/oGh0J3wkn8lB4DIqCRCZKvMhKP44RKoIJo66H1uEjaYB2/MGcQyfAR53sY9
 T+QTPOFYkxqqmp82X5hOcVN8HPc85mQDM20V0BRTTf2k3UjUYeZX3RmvPalDMuPWTKxN
 AoRdwjcLLeO9oMvt3URWbixLdy/oKJ8zYqBejXn24e3i4Un99Ev0hZDkOhwW0T9ePx39
 TgJM6vwFSCffAi3wVn0ho10r9AK11F+A47ZQxaYIAm0em+k6mv20drVA3eqU2DTJmqQ3
 wQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998051; x=1741602851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4S8rnC1+5w/GBtgcoACwXWBW/0V0OGHaa1l5WT+ryk=;
 b=WMb3hU+NYlRJyiA90dz/qxIx8cmJA63QnD+ZrNDI6MnTdSBdfcWRGREBHntbx+XSLi
 5nQgC0NRWUX0rihYQvxKZ5z8nZwZ/nQ33fLtsuFNOKvZD/okjuDCoST6pb9RB8fpZn/Q
 pNn0MCFHGNh4I5G0+8miZe8pKopMYTx3809KEcKs4yo9DVlI2Aoqa9cZShKduZD41rqj
 gpcQ2vbGuXIk2R7j1So4Y8ZftCgKeF7z43cefDfS/1Gb8/oRWeOXg28T0E117WYfXupF
 BmgC/mKWgK6MXmqUqSv/IzPqNOJcuMCUB0EcnoLTEEG0WqQXjTgYdE37AzaM0p+j3Unv
 NlDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBtHx1xeBmmWtRlMSB6eYsrGuYfHf79ciNOqDM1ytS4+mAD/UVzJ03cscU3k+KiOuEc/lQQiNc36p3@nongnu.org
X-Gm-Message-State: AOJu0YzOziNcQE5POXLiKDr46PA6+b8YK1wfIL4PjaILc0Tv5wUUQXgg
 BjCgB98/xQqYpqGhzKRs085Ni/JeE/PxP1hnuWfeyEWgPX+juX2/PDtyvQ==
X-Gm-Gg: ASbGncuH8DB3ZvEnU4jvZGuePmhIgqbKwxTZIoIwTjdU9xpztpm9FzYUx2KtC0IcbPl
 s/XO3jXSFAhMZoRPHucZa3OGW78wEiC0mtPmuVl4IocWd9fX/v/Rqhh3KvHO/EtdZQV/2ofPhTj
 OVTphwsCleP1erxqQATcArPps6iiAaFaQKUbQenfIB/vWXg4a1G5TbZQCP71nGOgPX19Ywvo+PQ
 rKQz5JuEa0H7L1WmWQ1+Xa9FlHOxYyV9A6kJOPkYJb/5hj//Z7DMM0dxxBBbQgeA3f3GxTTNiw/
 rmDI4QTpgY/cZz9dtYuLmqZa2Xk3lefbZH8UtquWHWujn4oNPFE=
X-Google-Smtp-Source: AGHT+IFc2XpWV98sBhBCa6lldyccM07gpkyTrkYT9q4H2R0bAzOno8c313I63gjPmjypxuPROtMiFA==
X-Received: by 2002:a17:90b:4988:b0:2ee:a76a:830 with SMTP id
 98e67ed59e1d1-2febabcb0c7mr21432915a91.24.1740998050784; 
 Mon, 03 Mar 2025 02:34:10 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea698f309sm8594558a91.42.2025.03.03.02.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:34:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/6] ppc/pnv: raise no-response errors if an LPC transaction
 fails
Date: Mon,  3 Mar 2025 20:33:53 +1000
Message-ID: <20250303103359.578994-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303103359.578994-1-npiggin@gmail.com>
References: <20250303103359.578994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

If nothing responds to an LPC access, the LPC host controller should
set an IRQSTAT error. Model this behaviour.

skiboot uses this error to "probe" LPC accesses, among other things to
determine if a SuperIO chip is present. After this change it recognizes
there is no SuperIO present and does not keep trying to access it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_lpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d0fccc165d9..0e02ce6e940 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -353,6 +353,8 @@ static const MemoryRegionOps pnv_lpc_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void pnv_lpc_opb_noresponse(PnvLpcController *lpc);
+
 static uint64_t pnv_lpc_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
     PnvLpcController *lpc = PNV_LPC(opaque);
@@ -376,6 +378,7 @@ static uint64_t pnv_lpc_mmio_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     if (result != MEMTX_OK) {
+        pnv_lpc_opb_noresponse(lpc);
         qemu_log_mask(LOG_GUEST_ERROR, "OPB read failed at @0x%"
                       HWADDR_PRIx "\n", addr);
     }
@@ -406,6 +409,7 @@ static void pnv_lpc_mmio_write(void *opaque, hwaddr addr,
     }
 
     if (result != MEMTX_OK) {
+        pnv_lpc_opb_noresponse(lpc);
         qemu_log_mask(LOG_GUEST_ERROR, "OPB write failed at @0x%"
                       HWADDR_PRIx "\n", addr);
     }
@@ -511,6 +515,12 @@ static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
     qemu_set_irq(lpc->psi_irq_lpchc, lpc->opb_irq_stat != 0);
 }
 
+static void pnv_lpc_opb_noresponse(PnvLpcController *lpc)
+{
+    lpc->lpc_hc_irqstat |= LPC_HC_IRQ_SYNC_NORESP_ERR;
+    pnv_lpc_eval_irqs(lpc);
+}
+
 static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
 {
     PnvLpcController *lpc = opaque;
-- 
2.47.1


