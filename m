Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034FDE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQPv-0002Q5-9R; Sat, 27 Dec 2025 04:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPt-0002Ou-G7
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPr-0002L8-Sh
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6DgzKFCdB6q//TDsUK3aGBtKyBMMRnX/Ll7zdlPuRw=;
 b=hBBnOlaC0l3FP4A+7PRl/xDGSpAqJXcwhvDUegydvMVcWHlcrK8y0u2cot3ltwN1CNq8zC
 mYyEpDBXjQAchO8QhlXANE+ALF+eu0qYAvlNtGEsRtzZwkuD+bGswFrJvHsOr/5BfpJoHg
 k8NCycJRII9IJOMjMfnFv0J5VVVwtVw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-PjYfIaLTM_6mFW-9_jHwxA-1; Sat, 27 Dec 2025 04:16:49 -0500
X-MC-Unique: PjYfIaLTM_6mFW-9_jHwxA-1
X-Mimecast-MFC-AGG-ID: PjYfIaLTM_6mFW-9_jHwxA_1766827008
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d17fff653so26705965e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827008; x=1767431808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X6DgzKFCdB6q//TDsUK3aGBtKyBMMRnX/Ll7zdlPuRw=;
 b=ijphTIMq9geVnHlFcnq66F1mRW531HUJgz3WFRuWTGgi+4QlKe0+4QrZkmu2nBT/99
 8F2iVxAQTFPdOpN6EWCh7nTw8W5hE7JZ2ffMHco9u9rj5poYA0wz+wNFxHez+NRK+pzP
 QkWpCzr770rQbJpAiR/X4QStx1nhSmeyH3XvsvOys8OM/QP1z7gfF0ki3VK0a5HPK3xS
 opUPw0z6Yx57iQDFmySxHbH+6la7S08Zq0+ec1jwkDBzNpzX5sNmL+nxwEG+c8j8bdSY
 irEYc/Zc16C8CkuclzZU9l7y2d2ad6+PyPARPnX0QmxnqX5VLmBdrgrRoectv0fBo2UL
 C5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827008; x=1767431808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X6DgzKFCdB6q//TDsUK3aGBtKyBMMRnX/Ll7zdlPuRw=;
 b=C/YnxXDpz/Ac+F4lMLCIJ7GGqw334A871/0mQqU6Cczy6st/Tzwr2REWPQtXH9+xlO
 PQW2Od0MZ/0jC5B5HjBUqSK8lc39CKHtCFBi/l1vtg53UnawHPkOhGMwiWG0NcGcE5Vq
 QjHylwysod28VvO9aeKC3gt3B34szcWLTvmmhWcR/xh7ybgz1bZlXzhWP0luWpbD4J+x
 xStoRBwkG4wxdi3zHOdPBM0UYu5jUbbncnuNPGFN769CxLfo/+3cw1lK8LFQ2H6/02Ac
 zy1HnSbKgap6ad60+E2RXD18TZYsy1Uwp0/q9kLkFQfxiZ+33JuLbgTe0DTUUdH2lLt+
 tKHQ==
X-Gm-Message-State: AOJu0Yw6+etNoX+SRv5FwD5q0mzLcKSIPxaqIZ3nsCnLzYhUTs6stEd8
 ZQql7dx1NJgar+QZqPZIg68a2ZxjhGKBZbJXceLkJlwNgJ3vPTCPEQ8pqDAvYpFlr3jTWcWhuOW
 patsDjIBA5tVfVkT/BMD/IGo2eo4lnGwAQQsJouXz8kfDFFFq2K3MZ11W1Z0rx6vCo2XCMQ4RXi
 8g37jUX4kC2+8LnnFDKC5FdkKTtwD+Gg4/89V3IvtS
X-Gm-Gg: AY/fxX55cGboV9ZEIb9VU2fGEvYRtKlBG/wk0YcmC5gbuieIXbE4P+0BGvj1r2icA8q
 /zHKelc2gxSS1pM/od4IPxlrd59VIsYNWQEPNiEp2SbzgYgzyQ/Hdh7SkHHrXC+AcoKlxu+kqEr
 9MtBDX5+XwyuopFwrmbXbd/W5MHGVD7PtcSWKhw8U/rmJVW2YVrwjYfo/rt2hHlpkPCFyRdqG6e
 jbXnlnuYohunnOPk4/FlXs53GiTTzgG9apbq70XhYIxY5qEd/UPM0rF/dHVjMX+JBwFI+Pk4Cvk
 5t1BbyiTgMEAKJAzYETqTmayGkgRfcdPCcbae8Nl0SXyrmogztaSJE7M7ETeWK2H0dhTKMoggdT
 Ft64+NZtHweWui7IdB3gd/n+NYIujgT5pgGFUq00SN/n6GC7Ltn6+7yWTRdzaYRZqctW7/P5HYV
 +LSER4MXGt+r2GQJ0=
X-Received: by 2002:a05:600c:3e0b:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-47d19555af8mr277089645e9.10.1766827007896; 
 Sat, 27 Dec 2025 01:16:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElvbRjBJG8Wp+YFCtzTv7bUZRGOcEp4H//h0C8ZY6e0LbMrh9fgI8bmFC9jVvL8Y0qnFmoxA==
X-Received: by 2002:a05:600c:3e0b:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-47d19555af8mr277089395e9.10.1766827007402; 
 Sat, 27 Dec 2025 01:16:47 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432613f7e6esm38722375f8f.21.2025.12.27.01.16.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 013/153] include: move hw/nmi.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:00 +0100
Message-ID: <20251227091622.20725-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/{ => core}/nmi.h | 0
 hw/core/nmi.c               | 2 +-
 hw/hppa/machine.c           | 2 +-
 hw/i386/x86.c               | 2 +-
 hw/intc/m68k_irqc.c         | 2 +-
 hw/ipmi/ipmi.c              | 2 +-
 hw/m68k/q800-glue.c         | 2 +-
 hw/misc/macio/gpio.c        | 2 +-
 hw/ppc/pnv.c                | 2 +-
 hw/ppc/spapr.c              | 2 +-
 hw/s390x/s390-virtio-ccw.c  | 2 +-
 hw/watchdog/watchdog.c      | 2 +-
 system/cpus.c               | 2 +-
 13 files changed, 12 insertions(+), 12 deletions(-)
 rename include/hw/{ => core}/nmi.h (100%)

diff --git a/include/hw/nmi.h b/include/hw/core/nmi.h
similarity index 100%
rename from include/hw/nmi.h
rename to include/hw/core/nmi.h
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index a7bce8a04a1..4b447e126ba 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "monitor/monitor.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e877e6c4018..960aefc9e26 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -23,7 +23,7 @@
 #include "hw/intc/i8259.h"
 #include "hw/input/lasips2.h"
 #include "hw/net/lasi_82596.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "hw/usb/usb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f80533df1c5..c29856c810a 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -35,7 +35,7 @@
 #include "hw/i386/x86.h"
 #include "hw/i386/topology.h"
 
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "kvm/kvm_i386.h"
 
 
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 2532322618a..67cb9acb418 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -11,7 +11,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "hw/intc/intc.h"
 #include "hw/intc/m68k_irqc.h"
 
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index b91e487e1b8..2a7bc667ec3 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -29,7 +29,7 @@
 #include "system/runstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 
 static uint32_t ipmi_current_uuid = 1;
 
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 94f47175ae5..84dd01459cd 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -25,7 +25,7 @@
 #include "hw/m68k/q800-glue.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 9fed4265676..77658cb6d02 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -29,7 +29,7 @@
 #include "hw/misc/macio/macio.h"
 #include "hw/misc/macio/gpio.h"
 #include "hw/core/irq.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index eb3197da9b1..8a50e9f0d85 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -39,7 +39,7 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/core/loader.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "qapi/visitor.h"
 #include "hw/intc/intc.h"
 #include "hw/ipmi/ipmi.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bad6918e6eb..7363e533e15 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -82,7 +82,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "hw/intc/intc.h"
 
 #include "hw/ppc/spapr_cpu_core.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 29d95be2c64..c5e0691a26d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -35,7 +35,7 @@
 #include "hw/s390x/ap-bridge.h"
 #include "migration/register.h"
 #include "target/s390x/cpu_models.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "system/system.h"
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 07213739488..0842fe373ae 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -28,7 +28,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "system/runstate.h"
 #include "system/watchdog.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "qemu/help_option.h"
 #include "trace.h"
 
diff --git a/system/cpus.c b/system/cpus.c
index 0b1eabd3c4b..a0e1debfea8 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -39,7 +39,7 @@
 #include "qemu/plugin.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
-#include "hw/nmi.h"
+#include "hw/core/nmi.h"
 #include "system/replay.h"
 #include "system/runstate.h"
 #include "system/cpu-timers.h"
-- 
2.52.0


