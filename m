Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382E0CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqj-0002e7-By; Thu, 27 Nov 2025 08:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqd-0002dN-TP
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqc-0001Fs-6z
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jcN7YixdqgD2I0jjuWdi/Wse33GaDQqib2V9SQiQ7HY=;
 b=YiUL8s18B3Un9lSCeaQx+lJe2yy6NmyPxzmdYNQYWJnm9+pQrkdKiwMkfBPYWVIolKFRBo
 lTV4kVUkqsp6WMnmAm9bKwUcqhBPn1l6o0M42KmMP3gCUhjSIqYpRt0bC+riaZRysX6s5U
 JfyCotn9ZQm+cH2gs8z1yj8M0Ec+yF4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-KYidxUA5PQ2ZSYQ4RJTh_A-1; Thu, 27 Nov 2025 08:15:41 -0500
X-MC-Unique: KYidxUA5PQ2ZSYQ4RJTh_A-1
X-Mimecast-MFC-AGG-ID: KYidxUA5PQ2ZSYQ4RJTh_A_1764249340
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6417677bf55so2847253a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249339; x=1764854139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jcN7YixdqgD2I0jjuWdi/Wse33GaDQqib2V9SQiQ7HY=;
 b=hZCLaBy8O15fYyyfEiWSP+ZQ4y+4+cOl0HWP0uKkt1KBpPOyK0Ckw89J/8Cwcu/5Ia
 mrHVjntdVfR1HXjX26e4xsWlL90p0H8U/krpXToAMGAiE8wZLXyx+4Qv1qCYmZ43O2E7
 r+cDEGXqKkcuQhuWMvMW7Yis8qYKauWOuybKyovDdyva7VPG2fcVJQwrfWjwaTwLo59y
 qTqs+J70BneuPGZ3yJPe847Viq13ICXNYvJFH4y9XXEBKFm7ZWMECe2W5MzQhoBAuvrT
 EVtdSdX89E+4LMh8m1WuMkcLl9WbUBAjP3gGtIoIt6oBwhr3HFpUyE0pRAqYFezuhAP0
 CHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249339; x=1764854139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jcN7YixdqgD2I0jjuWdi/Wse33GaDQqib2V9SQiQ7HY=;
 b=EpBWqH3oQylZaj7+r6jsE73EP6gwD4bsnWHlX22STQiDxS3/5Qo5t6EFyeug9Vp2WZ
 l/0TMvLBWDxNtD9hI1R+2JwSJ+eKXnypUFqOb1b8yTQkB8HZYOJjPANskJFQ0JuAqfbS
 omh3dbFW/bg2wSY5pEIyGqof47blMHCXrbeZV67zrr+GC/XIHDLvrXdKBZft09pZ8dZc
 guB1zLZzLQa7AajUmDx9fozink3JRlZ5Goy7LdA79UTCQLzQrn6tG/muF6M4h/ASjy9r
 8K0ZV3C4SmPhvUvBA38N0YrZfivYepINaunU5Fs/fSkUIhK+a5XwsE3nQI6O0/0RBC+/
 Httw==
X-Gm-Message-State: AOJu0YzoWzJB/CeAxPaDyrmVkar55ggcjjW1ZPX7KfEtw8esAI+6V8IS
 MBgh33M5py4n4SGBRwuTUl9uoiCkyuwb06MHgJCSAp7TwkKIFtUY2Kcp646DjCetKBUkdYHTj+o
 +mln2kg9b2WJEE4AH9HPhd1By9AfR5B1wAs2kd1/TtvEr2nUvunWBGIg77Kek6fK6QlrCzrP3VT
 Fx5dYUpvx/eUd59SJ8nzBPlKFv0LSmDOD7olIWc5UL
X-Gm-Gg: ASbGncumK3NT3GQ45ZrCfVcybG/UYuJipRpfb/wejZaEyDjcN4A10OKBV6TFsGMP1s2
 RHQjFrTOvKoAH44lllJUbXDWD4MZKmrRrGRJ3WUxNyypVYOACDp0QIZ9PgwbyydFytR0ftRhoNL
 olCKmDjqRduGVtKVTLcf+rztGX/MCjUqiCxJgVfWN34dc40RWm9ybTmnXrE3GQ/1Y0YwNuS1XHB
 SI0wVEVEVL/NK9jUXFmu4iMc2IKnJmhLeWbPALg9RLOj1wS181PqY31n0gPL/EvPuJVFqEJG0xg
 G8il2kVrsdASLJDbELQSW3TQ2LYve2hK2AYJz/vIeBWbCWXRPeasNdFAFPu+1YwsYz8pjdyWhhV
 FjBpDynAOr+fQ5xPyWDxkNjELQi7RSUM1WMLSw4a5I1GqLAKKQcwVOFR7CVOeiZ0YPt3pYeDOxh
 QMLG9BulLHe3VsBUs=
X-Received: by 2002:a17:907:3f24:b0:b71:60a3:a8b9 with SMTP id
 a640c23a62f3a-b766efb46c4mr2855696466b.29.1764249339424; 
 Thu, 27 Nov 2025 05:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ7ZVbmwg4kPbWtagkyeh4/BrTR+NoJ1LLYKAvAE1+5SeiXwnbmG2gMPNHkr9QVwCxDQxI/A==
X-Received: by 2002:a17:907:3f24:b0:b71:60a3:a8b9 with SMTP id
 a640c23a62f3a-b766efb46c4mr2855691166b.29.1764249338828; 
 Thu, 27 Nov 2025 05:15:38 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5a2176csm159001766b.57.2025.11.27.05.15.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/28] include: move hw/nmi.h to hw/core/
Date: Thu, 27 Nov 2025 14:14:59 +0100
Message-ID: <20251127131516.80807-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
2.51.1


