Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AF4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcl-0007iB-2u; Sun, 11 May 2025 23:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJcG-0006H8-Pd; Sun, 11 May 2025 23:14:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJcE-000764-Vg; Sun, 11 May 2025 23:14:08 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7424c24f88bso2014977b3a.1; 
 Sun, 11 May 2025 20:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019645; x=1747624445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUw/jR/I8I0+AFMo0tGeDW6W8FMqM4T9heGR9rWhRLg=;
 b=Wdaw+0uP1Z73KHvsP0dgLe5mcsSrQoZHDbwiDusfmETJLVGSOKH61mps1/pl1WfJBi
 5Vzd3NV9YwUlj5b9p7GHs0+js2wzZAoma2o1VF6MTrQkPl/RJylM8I2kqa6JmBEBP3/r
 QZovSIrINPnpR6bZ+cOBl3SMnNQi2456hh76AkYx8MoHLhmbf4yRWOku1dNFAWJlUY9R
 mxr/JvsZzBD770GuPM4jozxyc5kjlX3vOtCzADUVkusGeY1rmbBwj5lY40PfZNp9iu8M
 SSqGyeLrAMFP9NrQONR5m+LhnjnS2tx/I0r3mV/7+OMYcnUw5POIY2WPbHokAPLZ5mIV
 VsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019645; x=1747624445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUw/jR/I8I0+AFMo0tGeDW6W8FMqM4T9heGR9rWhRLg=;
 b=JwVe/z+nMIhi3i0WeOsuk8SCTBLZnpsCZN4dvdEqjLQma/cZ/khkdoF/dFiReCJUpg
 IO785Vg2OoVTxBwtdOXYYBd1q5oFtqbwUFoF9iB55QH68yTiVBH6JOBk1cgocxCru1UQ
 Z4km9ATd+fe2NWs22ylt9liYM0iBA8EEXacHylRk3PMU/gz+BAORjT2aIJQIBdceBAVT
 eaQGYJv3RKkd8XWQAj1ivIfz7hTuegZZm97BN0hpfBLkLKCcPWUBfMLhnNYGGPa6A5FL
 x1VOzr2BUjT5L1YQ8GFWeIq7SDUJS1jpPbCukHgYap9wvphTuNlYKIsV8M1ZPZRaduaj
 F7Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWskYcEh0XfR26J6jlb3jxo9ioic3rrJ0CO5Ks6ZsGuVwvQIMHLlpq+KALAVqZ23xkVWDB9IBL93Pyl@nongnu.org
X-Gm-Message-State: AOJu0Yz9itfde6KF7Xo25TJnV2IPAEJ1PIa8maa6ipXSzxGfTgmN2CH6
 UctkKtPe1IdPvN/oH5Gc2vwhMkuivS8YK/SratebdA3ams1D3t8xKiFa+A==
X-Gm-Gg: ASbGncv/HuWnFXNytHMITs5YegiPBJE/fQKpeqCRF80NFe9tGFiU9o4VLkDba4fSOWb
 k1Va7/MGcJTVfvlnc8a6Oxc/gvtv2/91C6uSTOLZygeXytPMfy7nuXJs3jFZURKkwye06EcTdWs
 vgAkhb0JdcVAsQ1BdlCr56EzoxBk+ngNGbKrFqwceJ2WMXrVqy7w3CmHxMa/fsb1269+Z6hq2KM
 cWvfzElm5cUmiMwbEhGtroZcEXOxfhQPFP0IF36tPeuLdsZL2MzKOgn9EXfKQoNeoOYHJzkbpxV
 lDhqBXNPpavfcKMM4KeFPIA24MUllxeg7W73xbwlUzqI9a1qG8eYgFRXZw==
X-Google-Smtp-Source: AGHT+IHqBoAxuIIpmM5WRKvzLPE1EgGpVr0IqawJULwTaJ+edhe/j9sBbaUN/UcVwDkxinO4MLScCA==
X-Received: by 2002:a05:6a21:6d82:b0:1f5:72eb:8b62 with SMTP id
 adf61e73a8af0-215abb3ba6dmr15368692637.20.1747019645016; 
 Sun, 11 May 2025 20:14:05 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:14:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 48/50] ppc/xive2: Implement PHYS ring VP push TIMA op
Date: Mon, 12 May 2025 13:10:57 +1000
Message-ID: <20250512031100.439842-49-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

Implement the phys (aka hard) VP push. PowerVM uses this operation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c         |  2 ++
 hw/intc/xive2.c        | 11 +++++++++++
 include/hw/ppc/xive2.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 807a1c1c34..69118999e6 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -747,6 +747,8 @@ static const XiveTmOp xive2_tm_operations[] = {
       xive_tm_set_pool_lgs, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
       xive2_tm_set_hv_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, false, true,
+      xive2_tm_push_phys_ctx, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
       NULL, xive_tm_vt_poll },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, true, true,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index de1ccad685..a9b188b909 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1005,6 +1005,11 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     /* First update the thead context */
     switch (size) {
+    case 1:
+        tctx->regs[ring + TM_WORD2] = value & 0xff;
+        cam = xive2_tctx_hw_cam_line(xptr, tctx);
+        cam |= ((value & 0xc0) << 24); /* V and H bits */
+        break;
     case 4:
         cam = value;
         w2 = cpu_to_be32(cam);
@@ -1040,6 +1045,12 @@ void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW2_HV_POOL);
 }
 
+void xive2_tm_push_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
+}
+
 /* returns -1 if ring is invalid, but still populates block and index */
 static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
                                       uint8_t *nvp_blk, uint32_t *nvp_idx)
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 45266c2a8b..f4437e2c79 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -146,6 +146,8 @@ void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                 hwaddr offset, unsigned size);
+void xive2_tm_push_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                 hwaddr offset, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.47.1


