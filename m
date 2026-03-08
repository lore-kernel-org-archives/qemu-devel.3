Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E344EA853A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHwx-0003f6-Ex; Sun, 08 Mar 2026 13:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHwq-0003eY-DD
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:29:48 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHwo-0003nK-Uz
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:29:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8076B42AC1;
 Sun,  8 Mar 2026 17:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D848CC2BC86;
 Sun,  8 Mar 2026 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772990983;
 bh=5T1LhH5J6f2Ao8dbBECeACv01ggKw++t/KA2Q4VUqbw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JcR/K77APKtIltX2KVF4twyulwUuA5yvLtk6YYihM+osTyX7d5NATDRMvNmytwcTM
 78VLVTpSthqneBqKnQ1E3s9Je9qv/HWPaF1GeVL2q7INNEgcIcLGgEOKhG/NvkxmEp
 kdymZ5N3zlFG3lY3FVA4xyB9ityNbaViIIScLEGFjk4bkk7V/FveG/EhjXj+mj2jxk
 n3XsA8v7Nsy6zhIWrm5ux9IfWGuUtOMvoDcI6uBkTWrxcGIko8/a7oWp7oNuhdkhk3
 DYxGeStDokoZlhjzrJqpdiAWwXCLp6XVMKIhIRsjfRNhGycKgthW8qgBkeHxkbBccG
 e1+E2BAZ12yxg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/12] hw/hppa: Avoid leaking a diva-gsp device
Date: Sun,  8 Mar 2026 18:29:25 +0100
Message-ID: <20260308172936.2835-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
References: <20260308172936.2835-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Create a Diva-gsp unconditionally on all 64-bit PCI machines.
The A400 usually comes with a Diva card. The C3700 has a built-in
SUPERIO chip, which we haven't implemented yet, so running with an
emulated Diva is the best we can do for now.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/hppa/machine.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index f55e84529f..50ace81528 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -380,18 +380,15 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
         /* BMC board: HP Diva GSP PCI card */
-        dev = qdev_new("diva-gsp");
-        if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
-            pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
-            if (!lasi_dev) {
-                /* bind default keyboard/serial to Diva card */
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
-            }
-            pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+        pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
+        if (!lasi_dev) {
+            /* bind default keyboard/serial to Diva card */
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
         }
+        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
     }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
-- 
2.53.0


