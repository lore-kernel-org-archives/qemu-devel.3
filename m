Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7232C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 02:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgvEF-0003ES-6R; Mon, 06 Jul 2026 22:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgvEE-0003E4-41
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 22:08:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgvEC-0001Mz-F7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 22:08:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cace91f112so31007385ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 19:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783390083; x=1783994883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kny2iiR1YW/3xCe6weQ+0ztiIZOJHUB89RINwiVd1gc=;
 b=h07wAXBQC/utMjy/cUwi28+6iEaXEcC8pGHiN2rUmY56XHj83KiVt1FK422Pi+2i+n
 LGPnhs5nnibDcycyUECRm4IPgxa9YYNmr+MFGpljJjsR3oQctcl+jF0pzsP0xevJoAHq
 Mu0lVg8d6Tzg7z6dRMorTK3k8uNDAuTYNMPxs6mjLBzXOa86s+UWUOcL2GECQvE3Qiec
 XSYPww+LOJsVmuB02y8R1gFWRWnnOKAuhYvbY+K3+mnUCTvJCwS8ouBHgIvla0CgTeiy
 mxb6LCTEQxpqJoMMaN2yz/FKlNpi70hQp4TAtYn1KLA0wPnBl4W5u5gKRG0rxerCQuZf
 er/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783390083; x=1783994883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kny2iiR1YW/3xCe6weQ+0ztiIZOJHUB89RINwiVd1gc=;
 b=W4EzwTvKdIvJbjNxyyeZ5Z+onRqkldlTG1YB+rqwtA3qFgLrYP47QNbKWB5lfwpZUs
 vfbCC4wM+kTSwlo36gmc86iBd9zAXNwDDVJNhVfYzOUNHomX/GfLXdtZMFfyA8wjg8Sm
 emOUqfFzuurCLCgJsWr8iRJymeWL9XNMX3KLLOiCiApjCxjcoo/fepXzAAS2iPsjTE+n
 gCL1tLzd7MmvS6UAy8KMzxJfrH1V8bsVatuZS14dzx17gjQp66r3Btbnii3ANVNT2E5o
 PYbrY/c+CUNzALwKquirZ5gL/Jz2Zgts1ZPDn9rHDzBMfi+ourTujwAxrP7QWkXq76dD
 LU4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDju8uYKhvBHGY2xO20bi76jPd7pViLNzFxqzMg+tohKK0hpHbd6zLCgalVKP2RGs7koo4EmTK/3Ns@nongnu.org
X-Gm-Message-State: AOJu0YxX9q90/mx3pOTv5lJPBCInUBwZ1vBIonRfw+RxKu0/GjMgtMAf
 OVgJ0DLUztimDGbQqsOJb/vWEgvSqJC7AK77mGiREM6TYOcZ3YemRGo3
X-Gm-Gg: AfdE7cm58WTLuDs534Ge+lrNpfwX7obUfclbCQ8BjAr6oWI43h8qyP8vIteMtx79MZH
 OT7KCmpOVDlRkBvGqh2fKHO8DMrzIX8CM9CiTnzeSsrQ1w7jpFZV6rC4lwX84EeoY9kdVNvuOmd
 QyDcWkwplwnNLjtZEgrfiB899vR19Ka0rNtMaB/KSqd6PJglDRW6Wh6Aq7PaF80Et/y1vXV6PkA
 2lU4lL1VZb3/FR5gppmlL08luvLkHT8OU/D04cZPYRppSOKSLMakYPhnEmgznQjl4kgWb1JXBdv
 3ot+8Po48TKA8BoAFfZx9BQLsROBXfjDiYTb5VXmtk8ucdwlrFDsJOQ0t/wOq0c+WL6aFznsDd/
 L1WvCwgGEZx9VZP/pajxLjC+ImS6It6FAyXj+5J2eZQcqG6T9ulHUyHeDtvz4h3rsETcRAT+jfw
 1tD//q0/p0DmGwp1ElprNhMMewldt3pqo=
X-Received: by 2002:a05:6a20:a107:b0:3c0:9c19:6597 with SMTP id
 adf61e73a8af0-3c09c19673emr846179637.63.1783390082812; 
 Mon, 06 Jul 2026 19:08:02 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174892711sm2315689eec.13.2026.07.06.19.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 19:08:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair.francis@wdc.com, tangtao1634@phytium.com.cn, mst@redhat.com,
 qemu-devel@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2] hw/pci/pcie_doe: Check mailbox length for overflows
Date: Tue,  7 Jul 2026 12:07:50 +1000
Message-ID: <20260707020750.788960-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alistair Francis <alistair.francis@wdc.com>

It was possible that a guest could overflow the `doe_cap->write_mbox`
buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
`doe_cap->write_mbox_len` would continue to increment and there were no
bounds checks on the length when offsetting into doe_cap->write_mbox.

This patch adds a check and reports a guest error if we would overflow.

On an overflow we also silenty discard the entire object as instructed
to do in the PCIe spec when the length specified in the header
(up to PCI_DOE_DW_SIZE_MAX dwords) doesn't match the length of the
object.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/pci/pcie_doe.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
index 2210f86968..1bc2b45781 100644
--- a/hw/pci/pcie_doe.c
+++ b/hw/pci/pcie_doe.c
@@ -78,14 +78,21 @@ static bool pcie_doe_discovery(DOECap *doe_cap)
     return true;
 }
 
+static void pcie_doe_reset_write_mbox(DOECap *st)
+{
+    st->write_mbox_len = 0;
+
+    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+}
+
 static void pcie_doe_reset_mbox(DOECap *st)
 {
     st->read_mbox_idx = 0;
     st->read_mbox_len = 0;
-    st->write_mbox_len = 0;
 
     memset(st->read_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
-    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+
+    pcie_doe_reset_write_mbox(st);
 }
 
 void pcie_doe_init(PCIDevice *dev, DOECap *doe_cap, uint16_t offset,
@@ -356,8 +363,20 @@ void pcie_doe_write_config(DOECap *doe_cap,
         if (size != DWORD_BYTE) {
             return;
         }
-        doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
-        doe_cap->write_mbox_len++;
+        if (doe_cap->write_mbox_len < PCI_DOE_DW_SIZE_MAX) {
+            doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
+            doe_cap->write_mbox_len++;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Mailbox write length (%d) overflow\n",
+                          doe_cap->write_mbox_len);
+            /*
+             * Too much data has been written, it can't
+             * "match the Length indicated in DOE Data Object Header 2"
+             * so we drop the entire object.
+             */
+            pcie_doe_reset_write_mbox(doe_cap);
+        }
         break;
     case PCI_EXP_DOE_CAP:
         /* fallthrough */
-- 
2.54.0


