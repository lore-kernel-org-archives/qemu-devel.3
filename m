Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC23E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 12:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR9Ed-000310-Cs; Fri, 27 Dec 2024 07:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9E9-0002v6-Am
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:14:04 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9E0-0005G8-NP
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:13:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaef00ab172so454429566b.3
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 04:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735301630; x=1735906430;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcOE8SJ4qU0KcKLjO08qeQlS1Zz6VSXpgWSSMCpxy6c=;
 b=KDaiK2HYuSeQsv5tuXLWt1LfX+RVar9/WSMV+NiKT5DDIWmRt2Ea2YBEOBtBEAzTNs
 6Svwb+nr1XRr2WIzSTiA1Iz+vnHBCOU45450w0WUIEOLDTU52e/c6Pyslo9qTEavnNR8
 NeFWIMQ4BTTj805vJQjTVJoogwjDEvAL+LAkpL3Oo8cJw9YwElQce4J5Xiw3X2tSgUbL
 fH5ugDbVr5cRKSFzGqRl7nFUb+hXUzIIs8kjXNSONLs69e1foqiFuRboWo7dH3O90S94
 ZSmzqSjDe5BUNW6bHC0mq7Pk2UkHLL0PWJ9eflR1qPDdPyqwQQB/OWmwD4SDoGHpC3oP
 KcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735301630; x=1735906430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcOE8SJ4qU0KcKLjO08qeQlS1Zz6VSXpgWSSMCpxy6c=;
 b=GAfFGX37oHYc+VC45ssftooX9WroyHTDlSB2uJnXv+X0MukVJGmVI7HkNZValEbbW3
 qrhCEi0GYP6jBKhhS4E26aRgDG7wEBOab/C734EWSbOXjM3vlCtwQgFXlqDYHi8HOFfT
 2MOfxWjKKrtBgDuX9RJJzWBkEZkePPpb1aJuwpocPwOjts8++S5AOwRfiqMXUHn7/0tc
 wxIDqh/0Y3kMTvJ9/B+R71xGa4aXxEqwS+jSZPvtt0W1nIkM1DZUiFLfPsdW4EGzY8pu
 0rVrwepjxAoBR8l1PxKoEvP38hS8O3mmwVUuPJGLc7ta2hFQ/uQMZN9k7SXy9NzwZbP+
 tiqQ==
X-Gm-Message-State: AOJu0YzGDPE55IDgcuDgriVoXNjOm6TYxFY/ALyHcIu8xP96Ec1A1Jlz
 00patukoFQv19W8PIG+o3uTMRVV3BozpCPjcUcuuX3xaSm5p+BC1gtSf8TYycG/sgzPCqr9nyvQ
 =
X-Gm-Gg: ASbGncujnIFNtzFDm8dUN4LAreLbOgWefrX16wILq/3UtVR+icWr+rxlea7JUkdokhQ
 22KEem61h0RWwMwW/Su+BRPR4INc6c4q/E/aO7gHQ19PTwIkQCj5vLJT6927kCqnfhnhV+xR/Mm
 pUGslIDelbwMoXUNBAZ0KlLYX8wmTbiqCVYO/xCmjGoSJPeLKXgUMFOebg2+pWqMHqIRnzZXjwJ
 wxaic7apHgQx/MmxL8suYYQndGyEaWIgrZaqpHsqTRZV4TYH+6PIR6Xn00uwH+sd3PBzsXiaR9j
 ecrb8fiFiwmdCIC7xOJh0PectvfsH6yK
X-Google-Smtp-Source: AGHT+IFO2cDv8kiwWI/ExJTIJ/4plwMPy8toObJ9rmldlQKIeM2Kqc0Zy/az6oyWpLUzRF9CQI739Q==
X-Received: by 2002:a05:6402:2749:b0:5d0:ed92:cdf6 with SMTP id
 4fb4d7f45d1cf-5d81ddc1b64mr58046183a12.19.1735301629910; 
 Fri, 27 Dec 2024 04:13:49 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82ede9sm1098662766b.2.2024.12.27.04.13.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 04:13:49 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 npiggin@gmail.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 6/6] hw/vmapple: XHCI controller's interrupt mapping
 workaround for macOS
Date: Fri, 27 Dec 2024 13:13:36 +0100
Message-Id: <20241227121336.25838-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241227121336.25838-1-phil@philjordan.eu>
References: <20241227121336.25838-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62f;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This change enables the new conditional interrupt mapping support
property on the vmapple machine type's integrated XHCI controller
using compat_props.

The macOS guest driver attempts to use event rings 1 and 2 on the XHCI
controller, despite there being only one (PCI pin) interrupt channel
available. With conditional interrupt mapping enabled, the XHCI
controller will only schedule events on interrupter 0 in PCI pin mode.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---

v2:

 * Set the "conditional-intr-mapping" property via compat_props, not
   directly on the created XHCI controller object.

v3:

 * Moved the compat global property table into vmapple patch set -v16,
   now just add the conditional-intr-mapping property to it.
 * Set the property on any device implementing the abstract TYPE_XHCI_PCI
   rather than only the TYPE_QEMU_XHCI device specifically. (So the
   NEC controller works with the vmapple machine type too.)

 hw/vmapple/vmapple.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 41e3d7d189..ec0896dd32 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -38,7 +38,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/pvpanic.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/usb/xhci.h"
+#include "hw/usb/hcd-xhci-pci.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/vmapple/vmapple.h"
 #include "net/net.h"
@@ -562,6 +562,12 @@ static const CPUArchIdList *vmapple_possible_cpu_arch_ids(MachineState *ms)
 
 static GlobalProperty vmapple_compat_defaults[] = {
     { TYPE_VIRTIO_PCI, "disable-legacy", "on" },
+    /*
+     * macOS XHCI driver attempts to schedule events onto even rings 1 & 2
+     * even when (as here) there is no MSI(-X) support. Disabling interrupter
+     * mapping in the XHCI controller works around the problem.
+     */
+    { TYPE_XHCI_PCI, "conditional-intr-mapping", "on" },
 };
 
 static void vmapple_machine_class_init(ObjectClass *oc, void *data)
-- 
2.39.5 (Apple Git-154)


