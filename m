Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6D5E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfgZ-0006rl-OW; Fri, 20 Dec 2024 11:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgN-0006Zp-1c
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:02 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgL-0007bn-78
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:54 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso1845793f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711411; x=1735316211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFkJFg/VNagFkpMx0H3sD+AiSeIrfA9Mtz8ORtYzpxg=;
 b=ObCJ/kZINpPd/wzgTeJCb0qBprdf0F7tP9ARKo+c7OOcvyCN7K0iIuO9zq//Ux+m3G
 KSshbACoJuvzEYInbGXNPSHfpx6SKu+5ZktmmXXRs9gqouqmO0DaAyxDCThGtW7qnyU5
 UBk8J1gX0Z+lF5PAeb9t0xVzT5zDp7xnOgY07fy1izztP8QMugGZ+UpiG36jwxN867/z
 NwRrQma8b6becwh5fKVe+9GiCeUMb0U16JArAW3/SYmb+Fktzh+gOHuJzF8bZdNwveJP
 adEVYmsHjB/w3UNEGp9cNCZ9iwWYq8fjrkGlt5eSEa1cf8muPpidCASebP0808sgqHqt
 YoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711411; x=1735316211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFkJFg/VNagFkpMx0H3sD+AiSeIrfA9Mtz8ORtYzpxg=;
 b=k+jViHTb4MFTTqhXvnGlhKbQnNZUrCDj3r2Yy8TnHb5DEJHOS7l0teQGygHJUJ3h1i
 G95AlKFWjVKe+ueG6t50B0fE/t7hYPWyBHAzQcOXkliNYod548sWYEGHuQyn/s7AW4bH
 WcWFf1T4Dv7I7ZPA7Ux085Q83zWQMNSMZwk9KahDlGk+EwUhnYiZmifLa3+M1YQFAPh4
 Z8wWFyn80WcjHJwdlDgmRD/ndGKeqsmkV1KbfDMVJbwIgiH+BLK69p/4n9vXTQVLQ3Mf
 CY3PGen7P3iKBlpeEE0aKmIa350exiGB1zCR2mNpY5wazT0wiHsQIxeZHXVDhBwgfPvl
 NmeQ==
X-Gm-Message-State: AOJu0YxvdqnK7OiT0pX4z59CVnYIK8oTNRbAe72ctf8x0vNJPLX9lPG6
 svPttPSKGvoTYywF1t+cHFnpo3LNhsFdQLdoqgwbLhaphligtwTizxI7HQt7QpojULf5XR9O3Fy
 v
X-Gm-Gg: ASbGnctaSR+KR5pdumY5l9wMcEqIW4WasAVlCF2xIVtJRrqyPb5GfREb+ewS7eIz2C0
 vBCoQzYDrYp7HmXiz98Kif74QibD0JQgQ/UzQUohLyYBsn3K1fL6SwJJK5wnXQtHze71scICq/G
 ZJMOSStA4klMit7x2eEOI3Wt+PzsIKaChVhdWluyBKq3rqcxMiZxLS9WmdqKi32HCVkPUq2j2Tm
 SCx1dp33APNxQNbnVwDSzNIdFWha0qSXks/Ud60+Sfi+gnrZO6Km0vuKikSsWS1n86X3QgerFM=
X-Google-Smtp-Source: AGHT+IFvd7lEQKqxzxuQy4erA9ikiCTUxfnmxBgT/s21K91xz3zslqpv/gr6iavAGd6mBasg1/RhOg==
X-Received: by 2002:a5d:5c10:0:b0:386:3672:73c7 with SMTP id
 ffacd0b85a97d-38a221eac3cmr3724461f8f.17.1734711409758; 
 Fri, 20 Dec 2024 08:16:49 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611fc762sm49687095e9.11.2024.12.20.08.16.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/59] system: Move 'exec/confidential-guest-support.h' to
 system/
Date: Fri, 20 Dec 2024 17:15:03 +0100
Message-ID: <20241220161551.89317-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

"exec/confidential-guest-support.h" is specific to system
emulation, so move it under the system/ namespace.
Mechanical change doing:

  $ sed -i \
    -e 's,exec/confidential-guest-support.h,sysemu/confidential-guest-support.h,' \
        $(git grep -l exec/confidential-guest-support.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20241218155913.72288-2-philmd@linaro.org>
---
 include/{exec => system}/confidential-guest-support.h | 6 +++---
 target/i386/confidential-guest.h                      | 2 +-
 backends/confidential-guest-support.c                 | 2 +-
 hw/core/machine.c                                     | 2 +-
 hw/ppc/pef.c                                          | 2 +-
 hw/ppc/spapr.c                                        | 2 +-
 hw/s390x/s390-virtio-ccw.c                            | 2 +-
 system/vl.c                                           | 2 +-
 target/s390x/kvm/pv.c                                 | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)
 rename include/{exec => system}/confidential-guest-support.h (96%)

diff --git a/include/exec/confidential-guest-support.h b/include/system/confidential-guest-support.h
similarity index 96%
rename from include/exec/confidential-guest-support.h
rename to include/system/confidential-guest-support.h
index 02dc4e518f0..b68c4bebbc1 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -18,7 +18,9 @@
 #ifndef QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 #define QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+#error Cannot include system/confidential-guest-support.h from user emulation
+#endif
 
 #include "qom/object.h"
 
@@ -94,6 +96,4 @@ static inline int confidential_guest_kvm_reset(ConfidentialGuestSupport *cgs,
     return 0;
 }
 
-#endif /* !CONFIG_USER_ONLY */
-
 #endif /* QEMU_CONFIDENTIAL_GUEST_SUPPORT_H */
diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 7342d2843aa..0afb8317b58 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -14,7 +14,7 @@
 
 #include "qom/object.h"
 
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 
 #define TYPE_X86_CONFIDENTIAL_GUEST "x86-confidential-guest"
 
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 052fde8db04..1cd9bed505d 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             confidential_guest_support,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 008d3379e15..c949af97668 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,7 +30,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/global_state.h"
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-iommu.h"
diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index cffda44602e..8b2d726e008 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -14,7 +14,7 @@
 #include "qom/object_interfaces.h"
 #include "system/kvm.h"
 #include "migration/blocker.h"
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 
 #define TYPE_PEF_GUEST "pef-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(PefGuest, PEF_GUEST)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ad21018b5aa..623842f8064 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -75,7 +75,7 @@
 #include "hw/virtio/vhost-scsi-common.h"
 
 #include "exec/ram_addr.h"
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f4d64d64f94..b45d8963b36 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/ram_addr.h"
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 #include "hw/boards.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
diff --git a/system/vl.c b/system/vl.c
index 91d6d4f7f7e..0843b7ab49b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -107,7 +107,7 @@
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "system/arch_init.h"
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 
 #include "ui/qemu-spice.h"
 #include "qapi/string-input-visitor.h"
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index e4b0d17a48a..69c1811e156 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -19,7 +19,7 @@
 #include "system/kvm.h"
 #include "system/cpus.h"
 #include "qom/object_interfaces.h"
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/sclp.h"
 #include "target/s390x/kvm/kvm_s390x.h"
-- 
2.47.1


