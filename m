Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B953CE7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53b-0002Oj-7n; Sat, 21 Dec 2024 14:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53Z-0002Nk-Ok
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53X-0000A9-St
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cAzRLGZnZVq40JVmxNUS9Db1k3+vz0e88yX7zLkG8EY=;
 b=MbtLgdv408J62w6LCqgGO8lr7DDk0XA5aAOlnCPcfpnc7IXS9q1o/T6claqtQhQk0WP6xx
 ZZR7GsKgEyebglptaUeC9GtBdQ1316lOrnfPsrG8vGNSMv4aomcRL5ldxBAVu1x0YIcDRI
 H1odkvEPG7fzs1pw3K4JOSbRP+oE918=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-__Ogcn7YP9iowKF0NpFngQ-1; Sat, 21 Dec 2024 14:22:28 -0500
X-MC-Unique: __Ogcn7YP9iowKF0NpFngQ-1
X-Mimecast-MFC-AGG-ID: __Ogcn7YP9iowKF0NpFngQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862a49fbdaso1304403f8f.1
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808947; x=1735413747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAzRLGZnZVq40JVmxNUS9Db1k3+vz0e88yX7zLkG8EY=;
 b=SB0BuFicpBH9cQBW+KfMJQXgSBFo1fnArIof3GpwWc/7Dqn1nwAavY6D961c9JszP8
 I/Cex8HEz6NDKFcrOKqFDYRIPTkBpEuALkLMvvAoEWa7/snzPKmYeYbNgtKPG/sl/XZk
 vjJHs5WX01Da6AOg0Lc2mCP5bDB/9qJlCPvbmF7w7fwvdYBxy/YIomFQTJYIv56iu4dZ
 eWiHbL55wAmm7wF9lRh+jHir+gs6RfUIhogigDmH6fQRdpX9+C2m8p/qMusahLAVzHcH
 y56fYiMKnlco05D2FJEBW6SRmifxAwzRnEsjUp24JErsqJqHWnnVoB0d8r2t4xEXKufB
 lKeA==
X-Gm-Message-State: AOJu0YzaasRaZMWFY8VYWAYrbDL7duhCKU7leYLgZosE3LWT6ISUsMhv
 UAJoY0Wd039X4NcCkOAmGAMU8KPs/EAWoz3fSgc7NfxHf0XKAuI3xPEJlwfDxAoc+PoVaMj1/UL
 2M2iWdj/doRJV3+JYMoNKJUkybvpXSDyJDLWBHNoJIH2y79xJegElR44zVgHknjmo1HwHNso7TD
 ZKlwM1QalD9nanM4t5A4CxvJTDj9W5K0pM
X-Gm-Gg: ASbGncvWmQENcPkxLy1gv+GEWehInMehNYNOTFhzF4PWB3UgL6+qfFaiJySoAHyniEJ
 PkCIpd7tNzSSPxHdIQSsozar2L89rRwhd59MVf1RQJx7mzyblBxNoo5S1ra9uj+Vz+rUicCtfU7
 46M8/bvPjuH4awHhlt1pZOq25MShNXWbVlpDk62JNxwVu3dMKf8rHrSBokEJ8PPCW3FX7u8Hu79
 o7uGICoti3ay6gcCOEWOGrO/6P9/ps98BVT39EoB+S1UuW159s7gJQOfL0SLkZR4B/qDv2dCESm
 rS2n44KjqJ7ykPBq3ZWrcbyh93dxswS2eOg41oI=
X-Received: by 2002:a05:6000:4029:b0:386:41bd:53a3 with SMTP id
 ffacd0b85a97d-38a224083afmr6415164f8f.50.1734808946920; 
 Sat, 21 Dec 2024 11:22:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9pHyeJRXyOXYuvBQ9gKfmtxyRNZA3ycH4dbL2CYUqBYa7of+GkCkTJjGFQZbAo+/QUDDCaw==
X-Received: by 2002:a05:6000:4029:b0:386:41bd:53a3 with SMTP id
 ffacd0b85a97d-38a224083afmr6415148f8f.50.1734808946458; 
 Sat, 21 Dec 2024 11:22:26 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c847513sm7189727f8f.49.2024.12.21.11.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:26 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 05/15] s390x: rename s390-virtio-hcall* to s390-hypercall*
Date: Sat, 21 Dec 2024 20:21:59 +0100
Message-ID: <20241221192209.3979595-6-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's make it clearer that we are talking about general
QEMU/KVM-specific hypercalls.

Message-ID: <20241219144115.2820241-5-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/meson.build                               | 2 +-
 hw/s390x/{s390-virtio-hcall.c => s390-hypercall.c} | 2 +-
 hw/s390x/{s390-virtio-hcall.h => s390-hypercall.h} | 6 +++---
 target/s390x/kvm/kvm.c                             | 2 +-
 target/s390x/tcg/misc_helper.c                     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename hw/s390x/{s390-virtio-hcall.c => s390-hypercall.c} (97%)
 rename hw/s390x/{s390-virtio-hcall.h => s390-hypercall.h} (86%)

diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index d6c8c33915..e344a3bd8c 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -29,7 +29,7 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
 ))
 s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
   's390-virtio-ccw.c',
-  's390-virtio-hcall.c',
+  's390-hypercall.c',
 ))
 s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
 s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-hypercall.c
similarity index 97%
rename from hw/s390x/s390-virtio-hcall.c
rename to hw/s390x/s390-hypercall.c
index 5fb78a719e..f816c2b1ef 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/boards.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
 #include "virtio-ccw.h"
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-hypercall.h
similarity index 86%
rename from hw/s390x/s390-virtio-hcall.h
rename to hw/s390x/s390-hypercall.h
index dca456b926..2fa81dbfdd 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -9,8 +9,8 @@
  * directory.
  */
 
-#ifndef HW_S390_VIRTIO_HCALL_H
-#define HW_S390_VIRTIO_HCALL_H
+#ifndef HW_S390_HYPERCALL_H
+#define HW_S390_HYPERCALL_H
 
 #include "cpu.h"
 
@@ -21,4 +21,4 @@
 
 void handle_diag_500(S390CPU *cpu, uintptr_t ra);
 
-#endif /* HW_S390_VIRTIO_HCALL_H */
+#endif /* HW_S390_HYPERCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 508403609f..7a3e1a8e1e 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -49,7 +49,7 @@
 #include "hw/s390x/ebcdic.h"
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "target/s390x/kvm/pv.h"
 #include CONFIG_DEVICES
 
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 2b4310003b..b726a95352 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -36,7 +36,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/ebcdic.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
-- 
2.47.1


