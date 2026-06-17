Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF89CD98F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnAq-0003qU-OC; Wed, 17 Jun 2026 06:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAn-0003pS-7y
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:06 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAk-0008P3-Tz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:04 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-30b9e755555so4850355eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690821; x=1782295621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRYVLPHIUM7GrlbFP0n5EcLNdOMgTStoFfFbNYu20mg=;
 b=lo+u+CWUh6GXr0njCnWjTCj424C0UdgOOFrI6RIxwcfM7Tp+nOzAtP0z4buENrUkCG
 8LAfo+9MNNVTi7SjrBZpEjSWqU+/O44t/VwkSRDR6lERkdJ0zQ8ewsObc/f31ZYcHJhz
 8bmCBatyl9xmss+k8EQrx6QhdO+02mtZWwvFZzZ76CPSjiq+OYEvx3TSXmV6a/Cbbjtu
 HV1cjAYRxhPsZbYhJIKmTWuazqWQi7FXhOCAQ0Mlu6oxDpS0uGgfjUk68OtfFQqp8SyT
 7VKwtX7Ytxg6A7nBE7gvw9FKT+E+5jNRVB/thpi8XOQShgAcLZFUIuf573AxaIh078U/
 eBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690821; x=1782295621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hRYVLPHIUM7GrlbFP0n5EcLNdOMgTStoFfFbNYu20mg=;
 b=nXhC5c5k83hT/9rIvAcw/f4/66ssUjyn0QPhmvp89kTcqw6tTn81o+JpzKVyXmTcpA
 U1I/NyqpkVLXNu8pPYIl9cSeznSdfn/ZGpQjkEvbIzP1ARE2Qf2eQKufi0YBO3JSB/Xa
 5ZCydAZVaV5shVJ7Glr8tLcJPSc2HH9FZl7afpzCku3wFibRyp44rBupDUHsygeMoZpE
 0R0fA0/vAz4sk7W28Ay/IRuzOMX/S8x3n7AqTtxIQGUGcXgNADD6KUF0RDTkDNgIxGgr
 PFKgytP92XnGKKsUahORdgI57bgEq0YF8WlPeDFtuo3v6oNoN0FE5CutH2hZpW1mmHcY
 B/9g==
X-Gm-Message-State: AOJu0YwsKHrH3x08c/F+6jRrGRFmPzBIBGuHgIow+29SN/22pC1FGmUL
 1BWxIVpK0WBS3maq4KoXDn/vKRjrHvaNojhRehHpLVCjAP5UAHxN/CF9kvf2PZwbHw==
X-Gm-Gg: AfdE7cmBs7owIDJPyDUVISX84nCqOSUv12oUrdasIKbf4uVQ/K+G6aCDl3kZ1QzQRxM
 140+ysL2K91QL+K3zE31i/j4NV94zVGOFo8BtBD0WEN2IAf7XrbWCH0TCRon95EKTMQuaUMpB9y
 tkVvobtPzmnfrTddsxqqIlja0wGviN8xw5YvUdAfNnXhQaFRHnJRrPCTSPuaVHQEgXFZpWfP4G6
 LFTVTwA7mrLzJvBavubiM0DufeGI/8YNhQKKyZAbsipxDhtlmvpU1GCnbPRuZ8daf78lDQODDEu
 km/2x8nujesv1/V81L/Ciyy9Kqqe5ul0GTmSwvsnHI/9g9jIYVkfIzwJNM2dqm8DrYi/6KXehB5
 CH45uTpZHs5TcDlduEulQIknQzooLS5mRpZ4lYSehqTJaYV93jReP7NXAOGckr4XJ6HeuYIqaIO
 zfjmi+K70zMiSTtuLoBeWX
X-Received: by 2002:a05:7300:5793:b0:304:ab8:f899 with SMTP id
 5a478bee46e88-30bc9abc50emr1761053eec.8.1781690821409; 
 Wed, 17 Jun 2026 03:07:01 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm21858490eec.9.2026.06.17.03.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:07:01 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v3 2/7] hw/pci: Skip EFI option ROM in pci_patch_ids()
Date: Wed, 17 Jun 2026 18:06:39 +0800
Message-ID: <20260617100646.28326-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1343.google.com
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

pci_patch_ids() patches the checksum at the reserved 0x06 byte, but
for EFI option ROMs the 32 bits at 0x04 are the EFI signature and
must be 0x00000EF1. Since OVMF does not check vendor/device IDs in
the PCIR header or the checksum, skip patching for EFI ROMs.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 601d65aef3..8e7872523a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2513,11 +2513,16 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
         return;
     }
     pcir_offset = pci_get_word(ptr + 0x18);
-    if (pcir_offset + 8 >= size || memcmp(ptr + pcir_offset, "PCIR", 4)) {
+    if (pcir_offset + 0x14 >= size || memcmp(ptr + pcir_offset, "PCIR", 4)) {
         trace_pci_bad_pcir_offset(pcir_offset);
         return;
     }
 
+    /* OVMF won't check IDs in PCIR header, skip EFI roms */
+    if (pci_get_byte(ptr + pcir_offset + 0x14) == 0x03) {
+        return;
+    }
+
     vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
     device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
     rom_vendor_id = pci_get_word(ptr + pcir_offset + 4);
-- 
2.53.0


