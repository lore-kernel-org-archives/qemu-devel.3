Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44DFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE86-0008G0-9l; Mon, 15 Jul 2024 01:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE7z-0008DH-MC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:00 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE7w-0007Qd-Lg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:19:59 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e026a2238d8so3673879276.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020783; x=1721625583;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kPbp030IzWtL72MPt2loFrgmtqrQcgrAaOwGHqsGR/E=;
 b=VEJteOypy3zMmF83N2dKEplvaOb5Zx3sfUtkjE5VZbrR4fvhJ20vcv93t2k53isbt7
 h7bwsehTqegWoW7d3nBm1tqWtZLftZYxC+D82Yi8SRYxunvo7Z2hXD8HJmcY5cERizEi
 3jeTGqEYHk3jtEl3trZYgi025hNiZ3cePmR0zG09gfe2T49KoAiCaosH2RxWAv/eA5t2
 GbSagMV3+VdKSN1mj+ew57cQIiuMdL2MbZCdxR3riqVGH6v5IA2+MBv0Wv7pBmaZ1iIj
 pnZnmZl+VoLAKB8TOrV0s15VwTo2if9flwE8mxN7x3Rsr+x29eMEs4h6uPKLMpGFR8lA
 tpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020783; x=1721625583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPbp030IzWtL72MPt2loFrgmtqrQcgrAaOwGHqsGR/E=;
 b=uykd8rmwuN5svvg+u5TVc3noTZGB/zf1oqYFSj9owEEM6M7+prN+ApdegKlRLx8s2H
 kIi/Li1eaLZNTa7k5y4uZ/oJuUGNJ9Wp7jBag/xwarG2bbvSpsIMIiapqFhzOh+fPhCK
 Ntpsc69EWjRyCzzrPNG7Qi10aFqUmw6/+32Q6l2mQW1jQh32C1bjVSANwF8bMgSDO4ZI
 DjnjSSxbEtgZSOb0qoBIKPrFYBMEbOZI70qHSzLsp/P8Tltj7Dfv9fWcFrC5y91Me0jo
 Q8t4mgS4wrv+AYe3X8pDu2DpNXWisl0bNbFZT3qFlgSBnwCSkQJTFLe01k7c2T7r1Wnl
 uqMA==
X-Gm-Message-State: AOJu0YzwAPb8nH9F9tFQjK9j7Ye4UePLEXZLrtkknhgb7YitpSd9Sa9h
 GEUBL/cEo0477TrWHD+b+ww20TmqiAfuPn3v+Pb+gXh7KmS/goVbtx+LU4bf5I8=
X-Google-Smtp-Source: AGHT+IGHXfcBxvdInsneKiUR+e5sjfrNXmNmtZydJVSeJK4EZmxi2MMNUc4i6EeXIUCD9znliGOMyA==
X-Received: by 2002:a5b:601:0:b0:dfa:4d12:7ee0 with SMTP id
 3f1490d57ef6-e041b12b51emr20929361276.49.1721020783219; 
 Sun, 14 Jul 2024 22:19:43 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-78e34d2c4edsm2656912a12.49.2024.07.14.22.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:19:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:19:07 +0900
Subject: [PATCH v5 1/8] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-sriov-v5-1-3f5539093ffc@daynix.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
In-Reply-To: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::b36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ca8fb5383765..497a057b79f9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2412,6 +2412,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar == ON_OFF_AUTO_ON) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {

-- 
2.45.2


