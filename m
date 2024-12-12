Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135E9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLegS-0007Tm-4b; Thu, 12 Dec 2024 03:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLegC-0006tK-O5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:36:20 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLeg8-0005et-GJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:36:13 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7fd45005a09so241177a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733992567; x=1734597367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaApFk3HAaCXgWS7Qs9/zC6MeE/OKY1N8pZvwvf4rQY=;
 b=Gact2AcGYk3uek+BpLhkK7s1Zbn5F9wbxDeR+GHs9d7ymi+7nDex6HAnNHLjjwLSY/
 87/oUkJjWMc6+ut2XTfCq/PDnFBUqEM68JYXmi7DbZrN36HHiFn4xXonrqkxs0czvCbm
 8J9pyibIMBfo1Coqh/8ikx0FAyQdvACOcuvLLeoIyt+O1hVaHqtLK3n2E7w1alx6sp1f
 FVvogxCgjxOvbrJaXxWbeCnmh/vMohVAVWNsLOQ4T4uGGvkBNdIeiEzA+kK8x7GHyngZ
 yicsizdVqvslfVVMgFKLY9AjCgkKcZoZh3HTgaMkF6ANPkyoRPIqsBuy9AcS2uJfQCUc
 W3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733992567; x=1734597367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaApFk3HAaCXgWS7Qs9/zC6MeE/OKY1N8pZvwvf4rQY=;
 b=ZHGsymYUfCQhm8m6UcRawrefQA6d9M6SxWZPhr7qtrPiGpGB0qtFlptpVU8wBf1lzd
 gdBRXqWA2pJWZ1wqqb2Bg7Q/jVhSlAj0blmuG7ZWQgni/MNY19TN9EF23/ebDz4W15sE
 5uasK+imZ/ecX5Z0SrVWpxgIbbmGHYZUV3V91MTPuIUTSG78/3N+va5MRk1todjLoebo
 U9gfjJqXXZAaoBmx9fz2Azl26ksb/DS82+wUef4MmsOxfLXX5kHT5Z3tS+1uTRD1mydV
 dpeMScDXWHjCi1TINvHWTeDIIUPNivD1S//KNlh7ieP/ZExZUz6t3YwBDRKxBfyN1pQw
 CErg==
X-Gm-Message-State: AOJu0YxLjpH70zBhpMmJGuLqsDoJe0AEKcYnSMtSRBxsBCWqnyfV0MN4
 Hns+ApXjQK9OTcDviWXcoPtvVnK+hg2h6kAidZrCQd/XT5UQCDomIQaHrQ==
X-Gm-Gg: ASbGncuvEoyu4668Gb/VqK4GstE137YjxW4zzruqJPlzR8MFrVCu6dAxNUAzAGzSMtT
 2hg3+394Ds5Um4hxzqvKkqiHKVG0sPhP8PZLwV7s55j8mZ0xeaJsvucdE8IwFSxDYqdHkZrh/Ry
 LDw3QGyAQL7ol6gGX/n7wNIUgKPR/Z4V+IAqcDe/X3fCRhfliobZnngfC/IPSABsazJP0ZQ3aJF
 dpSvlOSMS+Qt94/ilKcHRyfY7MjYq0XD80sH0cMPr8fGjil5EW7QRBFEY0=
X-Google-Smtp-Source: AGHT+IF4TqI4fcyqbkyEuRC4eLKvxegCoUwYBV3Mwew6PTXk5uDXEIgP6gtmSfuTyKCdCvX4iCN9Tg==
X-Received: by 2002:a17:90b:4f86:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f139293c58mr4954099a91.14.1733992567474; 
 Thu, 12 Dec 2024 00:36:07 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142dae788sm714624a91.12.2024.12.12.00.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:36:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 8/8] qtest/xhci: add a test for TR NOOP commands
Date: Thu, 12 Dec 2024 18:35:01 +1000
Message-ID: <20241212083502.1439033-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212083502.1439033-1-npiggin@gmail.com>
References: <20241212083502.1439033-1-npiggin@gmail.com>
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

Run some TR NOOP commands through the transfer ring.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 41 +++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 8733299e52f..93614e55461 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -326,7 +326,8 @@ static void set_link_trb(XHCIQState *s, uint64_t ring, uint32_t c,
 static void submit_cr_trb(XHCIQState *s, XHCITRB *trb)
 {
     XHCITRB t;
-    uint64_t cr_addr = s->command_ring + s->cr_trb_idx * sizeof(*trb);
+    uint64_t cr_addr = s->command_ring +
+                       s->cr_trb_idx * sizeof(*trb);
 
     trb->control |= s->cr_trb_c; /* C */
 
@@ -345,9 +346,35 @@ static void submit_cr_trb(XHCIQState *s, XHCITRB *trb)
     xhci_db_writel(s, 0, 0); /* doorbell 0 */
 }
 
+static void submit_tr_trb(XHCIQState *s, int slot, XHCITRB *trb)
+{
+    XHCITRB t;
+    uint64_t tr_addr = s->slots[slot].transfer_ring +
+                       s->slots[slot].tr_trb_idx * sizeof(*trb);
+
+    trb->control |= s->slots[slot].tr_trb_c; /* C */
+
+    t.parameter = cpu_to_le64(trb->parameter);
+    t.status = cpu_to_le32(trb->status);
+    t.control = cpu_to_le32(trb->control);
+
+    qtest_memwrite(s->parent->qts, tr_addr, &t, sizeof(t));
+    s->slots[slot].tr_trb_idx++;
+    /* Last entry contains the link, so wrap back */
+    if (s->slots[slot].tr_trb_idx == s->slots[slot].tr_trb_entries - 1) {
+        set_link_trb(s, s->slots[slot].transfer_ring,
+                        s->slots[slot].tr_trb_c,
+                        s->slots[slot].tr_trb_entries);
+        s->slots[slot].tr_trb_idx = 0;
+        s->slots[slot].tr_trb_c ^= 1;
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
@@ -501,6 +528,16 @@ static void pci_xhci_stress_rings(void)
 
     /* XXX: Could check EP state is running */
 
+    /* Wrap the transfer ring a few times */
+    for (i = 0; i < 100; i++) {
+        /* Issue a transfer ring slot 0 noop */
+        memset(&trb, 0, sizeof(trb));
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


