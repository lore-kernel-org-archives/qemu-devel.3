Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D387CCFA18
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMEy-0006ag-6C; Fri, 07 Nov 2025 08:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHMEw-0006aN-BQ
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:10:54 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHMEt-000595-7Y
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:10:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47114a40161so7614515e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 05:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762521046; x=1763125846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OpBjpBr9GlA+WaF8EkSo323Od3Xe6GUnYzRvftCdBSI=;
 b=viH+RetWdxTaWKjhPADThPdqInPwXPnmrDtH3znIXtg4JZ7PxcicNfhk7u//N4q3tN
 Xywp2my936NweZR26ANIcsua2E7O1lwgebOWj0et13WWuG48jYOaJ0/hZoXpWuW7nF3G
 7gR0U+9UfhWV9lgVzIlXxFsti6lVsR1ag0OObsEcVnm9N2daHTEB00Ps5VuEp80SVXk4
 1adbU/cgbowtAAJyLH/qmQZHj60an+NqQKWodQYB9pDwg0aJQ2G7WLI8+jKdQTywCbBJ
 6nLVp4BU04wPuwrbf5pZCcc2OsgFlEweY6OxqMwbli9l9UlobHLh7NAvibIrx3HGKzAA
 rYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762521046; x=1763125846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpBjpBr9GlA+WaF8EkSo323Od3Xe6GUnYzRvftCdBSI=;
 b=pbhZeNSSxMxRMHqzTjthwqOuatcgFd8nubX+KKH1arFi5SZ3vnq5t9Ns9/GkGEAzWJ
 gt2oMfTInc21NhOIgix2YwDPVoZ/YAHreUbBhGy0YAVa1Q8zF5ZYMgSNzhEarWPZVsbj
 pS4jDgzzqSUaWlTB54gnzc38y+xXfTSIf3HJ1bMQaYPqbH8MhIuNi3pz3KOfHQqNEyu7
 tv9Ey21wyLOnoBnyxgVchKF7IQtQWgs9citlZPdONOjYT0ThrdG71CJ5cQa2ugirHQ5C
 nGde1m9JMkkaApEuIPOuQtyTSNyzr5Z0d5aGdqRqF3xHx2k/s87eTkicmGP/8hs9OP8h
 XgjQ==
X-Gm-Message-State: AOJu0YyCoQdMeNSGzhj0FabdSK687ahcHMd7EJ/YdyHyEUk+H8FnRx8v
 kSiHofU3bGE94/VlGaaqPRlyYTR8rsUG3atG4hUmHynR5crYb7IW6pK6t8t1PM6zIeXaayNmr0/
 y5QQk
X-Gm-Gg: ASbGncuKE8H2rH7z7AmmHN8C1r0KyFVJwoUj5UW1/0B1sgxBP+rTDPJRnqdZKxrPL59
 dPDQ2BoqG9upXCFQA/1UDVaawmnbD1ju5SDIPUq7Ks2z4GS10hNqFWtJW/XCgmtS1zNDvSSTOMe
 XdDbLlMHC3VDjaxKurA8n5UEuB5f83JkntbViZZmBSOR1mcGTV0NzMwafuuZlJVJsUzIWfL3K7W
 783UDME9Qo6Ekjnjc4HQZJerFzGJ3oU0MeaXe++47n7eOwRoHf9Ki5MaiDfP9N7APGGeOkaZ/fz
 N2Yts1sUY8iu+nBHO9ADTDQ1QDme3kU8Brpl4xBi5b3PiAsVjenurZoK6s4Bh1KxvekSvGCEgfP
 LQO5Jc/Hck4Kr6nLD5n2QSg+fQZ0NMPBLnLZE94oldp4B8xppegUZs6h/ffphmsFL/FHkn2NjV6
 EeIMBwGw==
X-Google-Smtp-Source: AGHT+IFc6pKjkUWTDkL/Uoq1jq4yQu8+KBl8p9WnQ98qXOFGovc9eGivdooqRIzxfZjF2GhOQpGinA==
X-Received: by 2002:a05:600c:c4ac:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-4776bc87df4mr24361225e9.1.1762521046383; 
 Fri, 07 Nov 2025 05:10:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdce8d2sm165841605e9.8.2025.11.07.05.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 05:10:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] hw/pci: Make msix_init take a uint32_t for nentries
Date: Fri,  7 Nov 2025 13:10:44 +0000
Message-ID: <20251107131044.1321637-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

msix_init() and msix_init_exclusive_bar() take an "unsigned short"
argument for the number of MSI-X vectors to try to use.  This is big
enough for the maximum permitted number of vectors, which is 2048.
Unfortunately, we have several devices (most notably virtio) which
allow the user to specify the desired number of vectors, and which
use uint32_t properties for this.  If the user sets the property to a
value that is too big for a uint16_t, the value will be truncated
when it is passed to msix_init(), and msix_init() may then return
success if the truncated value is a valid one.

The resulting mismatch between the number of vectors the msix code
thinks the device has and the number of vectors the device itself
thinks it has can cause assertions, such as the one in issue 2631,
where "-device virtio-mouse-pci,vectors=19923041" is interpreted by
msix as "97 vectors" and by the virtio-pci layer as "19923041
vectors"; a guest attempt to access vector 97 thus passes the
virtio-pci bounds checking and hits an essertion in
msix_vector_use().

Avoid this by making msix_init() and its wrapper function
msix_init_exclusive_bar() take the number of vectors as a uint32_t.
The erroneous command line will now produce the warning

 qemu-system-i386: -device virtio-mouse-pci,vectors=19923041:
   warning: unable to init msix vectors to 19923041

and proceed without crashing.  (The virtio device warns and falls
back to not using MSIX, rather than complaining that the option is
not a valid value this is the same as the existing behaviour for
values that are beyond the MSI-X maximum possible value but fit into
a 16-bit integer, like 2049.)

To ensure this doesn't result in potential overflows in calculation
of the BAR size in msix_init_exclusive_bar(), we duplicate the
nentries error-check from msix_init() at the top of
msix_init_exclusive_bar(), so we know nentries is sane before we
start using it.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2631
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Technically this fixes an assertion, but only if the command
line is daft, so I didn't think it worth backporting to stable.
---
 include/hw/pci/msix.h |  4 ++--
 hw/pci/msix.c         | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 11ef9454c13..551a2bcfe73 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -7,12 +7,12 @@
 
 void msix_set_message(PCIDevice *dev, int vector, MSIMessage msg);
 MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector);
-int msix_init(PCIDevice *dev, unsigned short nentries,
+int msix_init(PCIDevice *dev, uint32_t nentries,
               MemoryRegion *table_bar, uint8_t table_bar_nr,
               unsigned table_offset, MemoryRegion *pba_bar,
               uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
               Error **errp);
-int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
+int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
                             uint8_t bar_nr, Error **errp);
 
 void msix_write_config(PCIDevice *dev, uint32_t address, uint32_t val, int len);
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 8c7f6709e2a..b35476d0577 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -318,7 +318,7 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
  * also means a programming error, except device assignment, which can check
  * if a real HW is broken.
  */
-int msix_init(struct PCIDevice *dev, unsigned short nentries,
+int msix_init(struct PCIDevice *dev, uint32_t nentries,
               MemoryRegion *table_bar, uint8_t table_bar_nr,
               unsigned table_offset, MemoryRegion *pba_bar,
               uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
@@ -392,7 +392,7 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
     return 0;
 }
 
-int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
+int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
                             uint8_t bar_nr, Error **errp)
 {
     int ret;
@@ -401,6 +401,12 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
     uint32_t bar_pba_offset = bar_size / 2;
     uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;
 
+    /* Sanity-check nentries before we use it in BAR size calculations */
+    if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1) {
+        error_setg(errp, "The number of MSI-X vectors is invalid");
+        return -EINVAL;
+    }
+
     /*
      * Migration compatibility dictates that this remains a 4k
      * BAR with the vector table in the lower half and PBA in
-- 
2.43.0


