Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52E8C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 07:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ2xX-0003Fn-1M; Sat, 18 Jan 2025 02:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xS-0003Dv-Oe
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:27 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xQ-0007ps-Rk
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:26 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so4109691a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 23:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184163; x=1737788963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Auj/lFHkLSk6o6v8/a4KxcoWT3RjhdCD5eZzJWt0p3Y=;
 b=GCsphVSMJNz+jR0/gX7CYWAZtOHe1fquDmVI3h6vOhufqqm1bjUTBFcGkgCRLSNRM3
 hWMMw31474jl/uwAT98yFUm9kUqRlxLncLRJ6oLlJMxYqxDuFn48uejh0dcEVrQqmH0k
 nknXc0kpsQklX40sslj4hbV8IkpyCmI0QB/4mXL8/Gwwr4F10EX5/D+ZD22jbvXrFDRE
 6y6h/ih2Bg+bPIhyN/Bd76LBgOkI+641zO7cuIfUDdGdKUfIBYbNf5af3BE9IxdfKFam
 YDao0gYG5xwjXgntZHuPcPeBlFnjUnWnnqpRz3fsIZ8ncF3z93mX5wRvU18lQZwtj8li
 LBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184163; x=1737788963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Auj/lFHkLSk6o6v8/a4KxcoWT3RjhdCD5eZzJWt0p3Y=;
 b=bhTq0aMOIgmWBWP7qJOpNBXNf7y2dVZ/xHeBWl8lbEyKdhpA0YkfcOFvRvAe0h9vUc
 dLAzAf8MmP3NcHFldjeV7mvoMI5gtEhcseASgyvTbBIm4SxoqPBzjVWZafnl2+2X5AAN
 4DAvmjloyB9yJLyRH+eWzO7UoTz3+uNSdmSgsFfU0duAnpCLCe4njyCtdcnNCRBfeWl4
 qx2V0lmM0sNAogPlyXS9bkCJ0gAfIfJDMtDGSp0QtmXKdq+oy5y7QdY0zU1nx1dNwqI+
 pnIR3USrsYQhgQk+B2lymUqcB5MjRwmjQSJqEJgOzYwuNG49+MBKWkTPe/YYAu4TYQFz
 HQuA==
X-Gm-Message-State: AOJu0YymuRXZuPjXo8LONpRm3zlZUhqtON2I2XSdit/pk/MvS3B/TsX7
 iR9ydojwzAxsI7VlNySA7+NuvwC37gQ9czMRXCJQUp88bO0jA63IjtrtKQ==
X-Gm-Gg: ASbGnct7Ymn6TO0H7alu84HoU8DZTAZobJXhpffGfzG1DupM9ccwSqAjauWkOxMtt2N
 l1PxQhTg26T/4IJy/jg8KfGCDy/DaD0V6QJt5luxBLUkMboLKSXCyS0GkBkn7sptUjikbTfBW+D
 smKLj11JtdfeahypZ2AVJzbVApaK9WMFLAomh4cR/B9J1W+6gLdzCc28qaZ4gEw+4f9I19AxU0w
 dpQDq7IYo7V2bsl7RRyRtqg5D8Ly6WjwuKuSjvNg3r6Aoi4+Z6xc7GczxerHORS8REd2xI/RB6S
 a6LS2BTDNC81HL/U6feHNNfe/Vxj
X-Google-Smtp-Source: AGHT+IH4Ln7YyDyAVGQur8xll+OxxFjkqlv83CnGLLq0I4r5KEJMBbg6taLXxuKnSG3WQPNSNmD/NA==
X-Received: by 2002:a05:6a00:1a94:b0:725:ea30:aafc with SMTP id
 d2e1a72fcca58-72daf929f5cmr6365577b3a.5.1737184162848; 
 Fri, 17 Jan 2025 23:09:22 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c95adsm3192880b3a.107.2025.01.17.23.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:09:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 5/8] tests/qtest/xhci: add a test for TR NOOP commands
Date: Sat, 18 Jan 2025 17:08:50 +1000
Message-ID: <20250118070853.653778-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250118070853.653778-1-npiggin@gmail.com>
References: <20250118070853.653778-1-npiggin@gmail.com>
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

Run some TR NOOP commands through the transfer ring.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 36 ++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index b9fb2356d26..63359fb70b9 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -361,9 +361,33 @@ static void submit_cr_trb(XHCIQState *s, XHCITRB *trb)
     xhci_db_writel(s, 0, 0); /* doorbell 0 */
 }
 
+static void submit_tr_trb(XHCIQState *s, int slot, XHCITRB *trb)
+{
+    XHCIQSlotState *sl = &s->slots[slot];
+    uint64_t tr_addr = sl->transfer_ring + sl->tr_trb_idx * TRB_SIZE;
+    XHCITRB t;
+
+    trb->control |= sl->tr_trb_c; /* C */
+
+    t.parameter = cpu_to_le64(trb->parameter);
+    t.status = cpu_to_le32(trb->status);
+    t.control = cpu_to_le32(trb->control);
+
+    qtest_memwrite(s->parent->qts, tr_addr, &t, TRB_SIZE);
+    sl->tr_trb_idx++;
+    /* Last entry contains the link, so wrap back */
+    if (sl->tr_trb_idx == sl->tr_trb_entries - 1) {
+        set_link_trb(s, sl->transfer_ring, sl->tr_trb_c, sl->tr_trb_entries);
+        sl->tr_trb_idx = 0;
+        sl->tr_trb_c ^= 1;
+    }
+    xhci_db_writel(s, slot, 1); /* doorbell slot, EP0 target */
+}
+
 /*
  * This test brings up an endpoint and runs some noops through its command
- * ring and gets responses back on the event ring.
+ * ring and gets responses back on the event ring, then brings up a device
+ * context and runs some noops through its transfer ring.
  *
  * This could be librified in future (like AHCI0 to have a way to bring up
  * an endpoint to test device protocols.
@@ -519,6 +543,16 @@ static void pci_xhci_stress_rings(void)
 
     /* XXX: Could check EP state is running */
 
+    /* Wrap the transfer ring a few times */
+    for (i = 0; i < 100; i++) {
+        /* Issue a transfer ring slot 0 noop */
+        memset(&trb, 0, TRB_SIZE);
+        trb.control |= TR_NOOP << TRB_TYPE_SHIFT;
+        trb.control |= TRB_TR_IOC;
+        submit_tr_trb(s, slotid, &trb);
+        wait_event_trb(s, &trb);
+    }
+
     /* Shut it down */
     qpci_msix_disable(s->dev);
 
-- 
2.45.2


