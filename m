Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9CDC369A9
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39IZ-0002ML-Hw; Fri, 11 Apr 2025 03:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39IM-0002KL-Mo
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:28 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39IJ-0003sh-Nt
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:25 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af523f4511fso1606339a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358362; x=1744963162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnBiyYWlQ4RTJ5mrnDzClGCuo+30B86OBsiu2wXEAcA=;
 b=hAho6zqxIOhQpuO+SVf1Dzv4p7X0cUWjttHz/gYG4bxuCMpIR1P46tLp/1sf6Oo+K3
 vThVuS+RZKtj3wVJzw4YjrVoJHBKc6CBzjR5n/xDyOhDEdwcMpQ4z2x1N24fBIMo3PGb
 xveHLZvGcPkn74CFnzs2SX+aGpuSdXXqkPpIriFPApXrlOk9GO5HhBaS8FlpyM9FkRvB
 gGi+Z6SIwjXL3WPVmJ63vqwxQSVz719jwPE75tkvubuiglBA7zk9UcEgBHxTfIgk1WX9
 w/MsZ7ndEqs1rJ42yInc6+Pap1wGEKAdnJQI9TKqVhEubGxwBa4LjCV9SQL9LU2ZFU0T
 h8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358362; x=1744963162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnBiyYWlQ4RTJ5mrnDzClGCuo+30B86OBsiu2wXEAcA=;
 b=EtdQXPJl/iaDsol6G+13XGR1aJzmyv6TfBBzny1fDb1h9YyAjB0LDsfe89AUeGQbNA
 KVojGJFp9ooAuky11h2qQdJUwd73oDruEZi1J5aWVsnGDL/ZJHIzk2jZa48U5U+gWSgb
 OHimK2YHwjI8N/WGdKju9DAGi+7qhfShGI0PHOBE1R7Pyu0hk/gLXXw4OqGBmJSQPRqq
 L4sqCc/ktxLwofez6PcOVOWIS+AzL4juci8x8VcfF53jP6hwfgZfYH1MyG9CKtjOE8cc
 C4emTu8vsNXqmbZ2TAvhOqoDUZ/8J5YabM6+5fW/5GPW95wTXVABCiom2Q8ZInOkeyDH
 Npnw==
X-Gm-Message-State: AOJu0Yw7gLBtn+yHG34b4aWJQaDe4r4WRZeH4rBR0gnu59pgMRHCkjiq
 H0XZtJexBToSQKuzjv07xpqodsp/aoJaBP222teY5LgXUBHjSPqVgL11QA==
X-Gm-Gg: ASbGncsNgCZ1YDmVAxGxH/30ddw2S4zKZJPCzueYnjAH79SseWfJv2fCEHeShuPhkK/
 08HVv3gJj8MzMvdDy9VFoDpx4RcYn8ILvTyR5BGdoNXcJEHqd7rJFwVX/Hy+DHNd1pwdt+sBUv6
 EZY/ccRjRRepzUbVA4xUnwB75NDF84m/jkqWxsKpGwsfzvwcLZh85lTXlzStufKinLJOaMrqBYu
 JnjhPpGauxdBWH5US3OXM537UohbFND0T5u9Vl0SMOHF0AmVd8nTd6zNQi3IN19DiS1AKJtpxzg
 lgi+zbIBuUJc9FnKfNlMsv+9vkEBN9xa2SwQdwKQnDTl
X-Google-Smtp-Source: AGHT+IHE3I0Yt9r292a81lWctoLpZGMmQOHkhvffwWxz7j0t/FpqANIxkm7D343VD2DZ/NYmtALh6w==
X-Received: by 2002:a05:6a20:2d29:b0:1f5:8a1d:3905 with SMTP id
 adf61e73a8af0-2017978a7acmr3406669637.7.1744358362045; 
 Fri, 11 Apr 2025 00:59:22 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233554asm851687b3a.180.2025.04.11.00.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 00:59:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 5/8] tests/qtest/xhci: add a test for TR NOOP commands
Date: Fri, 11 Apr 2025 17:58:47 +1000
Message-ID: <20250411075851.206995-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411075851.206995-1-npiggin@gmail.com>
References: <20250411075851.206995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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
2.47.1


