Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C10C3ABD2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcK-0006UV-Jo; Sun, 11 May 2025 23:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJc9-0005Wf-Mc; Sun, 11 May 2025 23:14:02 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJc7-00074g-RP; Sun, 11 May 2025 23:14:01 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b1ffeda9363so3895672a12.1; 
 Sun, 11 May 2025 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019638; x=1747624438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3Yo8lTw4jtFlIZ2vyBiwLe+Pag0yNjD5ZBBjQxnrzU=;
 b=FAQUqFANnpc8oQ6kV3XpcUKhNXxauFxtWTJdAoKlwsIEesGfNnKADQFRZRupRXoLNu
 rX3AfcVlpR+lAyLLPvUVs/6qQH/Ib6XxCyHFhIhlFO/6PkbBNls7ExHtWnVxtq0Utu1t
 82sq6Uzoo2tcyvXmVXMVscxcMIuh0/YkpiinJSJ5/4Vy+PVAOJ8EgzELpYhEzR82I0rz
 qJhv+3MVza5Ii+3zIPVW0/OufY4PHNu+QAOjfxIXJjVdaCwVVtm0OnW3ChB2I7JhpN5j
 bCqxYLrfHh5CZt9LhBExFPU2N8YlnbVWEUWDOEPqzPhqvTcxeXanPW+TJfsIV8DXSm+Y
 70Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019638; x=1747624438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3Yo8lTw4jtFlIZ2vyBiwLe+Pag0yNjD5ZBBjQxnrzU=;
 b=rlPXMhpfzlKe4hgfjTDO4KfwT0Y8iQlo6n0ORXinMiOSEjagwN+kzuzNsaY92CneVw
 fZUP1kGel6UDaUi8q2coMmwjVgZaEUB91n6wDeo9bVRsC+YoHJcbnkuhSxNU80eHg5l+
 jLSzatWkA010RqBq5vF7Vmiy0Zx62DmnuYQnBg37drrWS4l4Vo7DDTLcz7eMk2fHt9AR
 4ew4Z3y9DgJ24SGx9CmJz+x/TeaskZFOQRNARaC8foG5MtMVG+t35tJ3FwEsMr7WM3si
 VTHyrIJE3gHnkvAIZEvtLMDaXeUMd+UU2/XKjGPgmf8xtRIXeaz+pzDHji4tL4oRrk5z
 Lyvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuonqTgg11pzNzDWn2tjivLWKbpm94wMP2NfRpCVYDH9TscdmcKQIL/1mTHgXiyEQvvQ/4FE9sRuT1@nongnu.org
X-Gm-Message-State: AOJu0YzA1nIrpJi5T8vyO6HDZMUavelcJfdu7RvuozhLX2o0Q5IoTfch
 zJHHgIZ4ttmWKhnCQx0nJ6BrpxZfeCiZMdkhhxDCcMr5jInrwrhx5XWlGQ==
X-Gm-Gg: ASbGnctlocbOu0Pq8FBM87ks1PyDGzCUhnhJQhxkcdqj/6Ngh8Z1ZFSHwFaD7hv3hi6
 /N/+XxWUQTBD34r+nU96rv87uEV4yKPYVRLawKmG3ZogjJJOHyX2ZTYt5FaTdmdrZ/E4N/eAB0i
 BEUyP4MOf9pmsl35OY3J6GK/hPUweXM8U8pZFq3sq91j23bOsUKFXCmhKaiUAr483G4RAn6VTh/
 sikxRVCBhHRxg0OWurz+VBbQrwwhrEsi6ioxEb7TBiPDRjwmcn/CranWzxwc/m+MvZd1Kd28CCF
 Zp5NFuHV/Rmc/TW3aCv4lpgGTxqmy6ublh+jWHEs1k9X1azeKqbOLn6ILw==
X-Google-Smtp-Source: AGHT+IHK3fdftqWgrG/YfaIHK7y0UEx4tW6xzZwJZU+Lhzk220Q+hVNlnJFdQOWi8CBL0jxiCrPQ8A==
X-Received: by 2002:a17:902:c94f:b0:224:f12:3734 with SMTP id
 d9443c01a7336-22fc8c8cbb7mr149809915ad.30.1747019637855; 
 Sun, 11 May 2025 20:13:57 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 46/50] ppc/xive2: Implement set_os_pending TIMA op
Date: Mon, 12 May 2025 13:10:55 +1000
Message-ID: <20250512031100.439842-47-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

xive2 must take into account redistribution of group interrupts if
the VP directed priority exceeds the group interrupt priority after
this operation. The xive1 code is not group aware so implement this
for xive2.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c         |  2 ++
 hw/intc/xive2.c        | 28 ++++++++++++++++++++++++++++
 include/hw/ppc/xive2.h |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 979031a587..dc64edf13d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -747,6 +747,8 @@ static const XiveTmOp xive2_tm_operations[] = {
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
       NULL, xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, true, false,
+      xive2_tm_set_os_pending, NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, true, false,
       NULL, xive2_tm_pull_os_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 392ac6077e..de1ccad685 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1323,6 +1323,34 @@ void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
 }
 
+/*
+ * Adjust the IPB to allow a CPU to process event queues of other
+ * priorities during one physical interrupt cycle.
+ */
+void xive2_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint8_t ring = TM_QW1_OS;
+    uint8_t *regs = &tctx->regs[ring];
+    uint8_t priority = value & 0xff;
+
+    /*
+     * XXX: should this simply set a bit in IPB and wait for it to be picked
+     * up next cycle, or is it supposed to present it now? We implement the
+     * latter here.
+     */
+    regs[TM_IPB] |= xive_priority_to_ipb(priority);
+    if (xive_ipb_to_pipr(regs[TM_IPB]) >= regs[TM_PIPR]) {
+        return;
+    }
+    if (xive_nsr_indicates_group_exception(ring, regs[TM_NSR])) {
+        xive2_redistribute(xrtr, tctx, ring);
+    }
+
+    xive_tctx_pipr_present(tctx, ring, priority, 0);
+}
+
 static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
 {
     uint8_t *regs = &tctx->regs[ring];
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index c1ab06a55a..45266c2a8b 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -130,6 +130,8 @@ void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
                           hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
                           hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                            uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.47.1


