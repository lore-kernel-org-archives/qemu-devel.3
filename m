Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130CFC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3JU-0006Bk-PM; Sat, 08 Mar 2025 18:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JO-000602-7g
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:30 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JL-0001Sj-Na
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bcc04d4fcso17916415e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475425; x=1742080225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAApOfCWWikXdcBm+45ltUmeOBmLQGFruMZPHaiGOZ8=;
 b=go9XA4N9cnIJfMS5J8CaRdLtM5aG+5Dqo++XFnOk6Lb8HOIuZPMb6NYJazOBVmkH1T
 S0SgpZQ7296suKxguCUmuJruB/2+27SKzdjK83ITlL+pq89aya6KkuZWYmU8b8UjQSRI
 DgwsD9G0BPap6a+Hve2LgBLgac4qg5efkX+Fpsx7uZrhhu8NE4mnMr0kA/zbWNq5Ugmw
 exn+2aa3FlG2pok64Ip1k9MPw07qH8vHh43IWeKTUgLxa0gNCxcRur9AXm5AEFNxiNc1
 QXTVvuOUZzxJQ8h4o4UyzC1dYHlHrTEezjsA/ZIxSo22OrDOssB0qhscTTW+pTPtR8Sl
 CARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475425; x=1742080225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAApOfCWWikXdcBm+45ltUmeOBmLQGFruMZPHaiGOZ8=;
 b=c7PlWIqjmjayq8ut3vhCJTJ2UJH3YLDbaq3WO5ENhVKfvlpFP4DIHPXu4pPsold5ZU
 0tszS6dzBPBKaFnCWcphyP5Ym5DeNR1O0EZmNtRqA9+eOU4GpustDSzZUS5yCvaFSTp+
 ntB/IB3e7TE9INGGE+4rLqat03WYfv/Uy85jVn8Nj1M6WYnIZ5HKXQDC5Y8+OXjf7P4g
 iJ0J+GGlaHpsPMXwsokSu0HxWPRPMYYz231/dNKqGtg9yjpk47wG5yNZ20TJv85oM8a2
 0s/+lRJcXJyqvj94N92D2TBXxbpv382CXfpuCsFvuOvKBFX9MNSgcg5/EJAYfWCYUTsg
 rcqg==
X-Gm-Message-State: AOJu0YwXe3+pX1cZVdu8DHVtLuCnI2g4LaoimvazPE0+xdWTFtkVDcZ3
 76F90GeNMFayUvHcuhbqqibazls0NJy5ITVIQoF7102LXpqg4cbjLjlDyi/eQc0u0yCt17YsxCl
 tFbw=
X-Gm-Gg: ASbGncsFjBCcGCU3QipYMEtCHuff770Cit2SyRWPIM8q7D+9b+aRZFNg7UiMh2PouPG
 UH4Qp8/zJXbhbHITIYwwHRCsI3tGDmKGLWouqXVWLExdFJ61YBRd8EZgiuACQYhPB5H5pVOQ4aV
 0ezpK5pPJiJs71IHB/l8BSL2VWVFuu2HqJUT759TMezhYrOx643lhAuPAMl2Aj6c+7vphjxsyUH
 4CYpbeaxlVo/HONn03p6W9IgOb7W6HCdPfNivKltCezm9GPgOVWJuK/8EqOqfTxvCKAUvk9kyTj
 xqPv5Pc0R9KRvMT6W8WctR+C6mDoFUoyOjapYkPXMkn1bgaqgJUQGCsnQufMn53aTomTxfekRVN
 gZ8qviSYIV7Ip67Cwwd8=
X-Google-Smtp-Source: AGHT+IEsdUpzC3vvzIbC6qsVM93qE5A0/3sv2x9KGYFFRAItc0/EzKZy6rlmtqCICch1ekTW0tHDTg==
X-Received: by 2002:a05:600c:3b1a:b0:43b:c541:51d3 with SMTP id
 5b1f17b1804b1-43c601cfe2cmr50795605e9.6.1741475425507; 
 Sat, 08 Mar 2025 15:10:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceaac390bsm30320235e9.35.2025.03.08.15.10.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/21] hw/vfio/igd: Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE
Date: Sun,  9 Mar 2025 00:09:07 +0100
Message-ID: <20250308230917.18907-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE once to help
following where the QOM type is used in the code.
We'll use it once more in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/pci-quirks.h | 2 ++
 hw/vfio/igd.c        | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
index d1532e379b1..fdaa81f00aa 100644
--- a/hw/vfio/pci-quirks.h
+++ b/hw/vfio/pci-quirks.h
@@ -69,4 +69,6 @@ typedef struct VFIOConfigMirrorQuirk {
 
 extern const MemoryRegionOps vfio_generic_mirror_quirk;
 
+#define TYPE_VFIO_PCI_IGD_LPC_BRIDGE "vfio-pci-igd-lpc-bridge"
+
 #endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b1a237edd66..1fd3c4ef1d0 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -262,7 +262,7 @@ static void vfio_pci_igd_lpc_bridge_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
-    .name = "vfio-pci-igd-lpc-bridge",
+    .name = TYPE_VFIO_PCI_IGD_LPC_BRIDGE,
     .parent = TYPE_PCI_DEVICE,
     .class_init = vfio_pci_igd_lpc_bridge_class_init,
     .interfaces = (InterfaceInfo[]) {
@@ -524,7 +524,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
                                  0, PCI_DEVFN(0x1f, 0));
     if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
-                                           "vfio-pci-igd-lpc-bridge")) {
+                                           TYPE_VFIO_PCI_IGD_LPC_BRIDGE)) {
         error_report("IGD device %s cannot support legacy mode due to existing "
                      "devices at address 1f.0", vdev->vbasedev.name);
         return;
-- 
2.47.1


