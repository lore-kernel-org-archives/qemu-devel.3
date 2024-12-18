Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D2E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwSM-0006DO-Cf; Wed, 18 Dec 2024 10:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwSL-0006DD-Mg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:59:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwSJ-0007rk-ME
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:59:25 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436249df846so46468655e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537560; x=1735142360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1PtiwkJt/+DijNbqUoe227vdUj70+KPR5ybVcrTmE4=;
 b=EaHL89Sjk0Ntujul6Q5s+BlRnBaZ25PomvHGy4XuFzYkYNtLK1rYcj67qu2WdgutYu
 EnzKY3j0YB4MLqNldIhlseasgpEBPjZ+JFcPHg5rnEsFPsBl3ZVCbP3ldTyNEaPe/Ezc
 UQ47sIT3wkIdZLbK9pmyjW244LTL2A7kQFIDvDK2BSEp7IBN9+ZlER0aqFtB8f952oru
 64lv6FkLIUPZGC4fHCxc0A1WGKjdB74NoAIJJjcjNxFphVnkPu2x3tc3SOHpW5juEVXX
 F2g8BhiqxCGmBMCKozWADeMIa6pRBztsIUa3iWVssIhfEPanVTe3mOAvYl1vxNU0Uxhr
 6pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537560; x=1735142360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1PtiwkJt/+DijNbqUoe227vdUj70+KPR5ybVcrTmE4=;
 b=A35WpXllJxazDmNLOc+wqqAxHNDm1+y3fnUKDC7pihqlQx000a7jn36yLM773Mhts1
 aiNfcEgVIAbIoe19u8c5pvSYx2Pa6EXIBjR4LfnekQbAsRNxxwr0w7anIyOxqqWNnXvG
 JnMyXgzRiPivpeeg2TOyn1Ov8C9C7UwGBybrKIPRST5M1pzqydWEhhUjdVSy52lwa8ue
 3EYGzvggD31E3BeFMYE4Y5mWIvTI5S0MbfuqlDbzmgojDWHhrIUlsKdUBlFAqWEVYsvs
 xWjovM7obKSBYGDk2MrhIngT8oEyDaDgQfbtedv4ODTjGaiXbQ2YyiRyhLQGEkV4ZycA
 vTsg==
X-Gm-Message-State: AOJu0YzvdKdekkrVUddpA9wGtK9s8S0OtuxahK2fto1sEUpg1x5NTPo+
 ClsNzxof2hS35OkZWytVemdH7+LwzjbxbrEvc5f2FAZzkc8d/WgWjlC2n782goQjsa/Vzk+oKPV
 i
X-Gm-Gg: ASbGncs+T6XjNhmVtor9H4VCVAV5mQChYsen8UofcjdbXtce2f/nJrfI8JwsP30X5C+
 OK+Y6COQABFFoAStrI5MJOsGKdeZpgMLpITLTMbSVrSIU88Y/ppAKy4jXh14ZOgNBH7G2W1UPc3
 jpIWmsOSNLpNLNKzCpBhXeBzz5K8q6ykNqIf1SBVoDBqq+xzKOT0sGGZpi983CipqMnERtjMdKA
 DDvyqwopGhEG4a+w9Pq9eesrB6qBKcAHt9l8EYQMJ6j/wUSCTbzfL5S+WfGSPQm6bCQv7p4CNOe
 nr3L
X-Google-Smtp-Source: AGHT+IHmkwoIYW6Cp/iqDz90yD50zgbZisO+B/FzbG+TIKWUEJjeysPGArnAL3+O3AtChZFuiI545w==
X-Received: by 2002:a05:600c:5103:b0:434:ff9d:a3a1 with SMTP id
 5b1f17b1804b1-436553445f5mr32035875e9.2.1734537559916; 
 Wed, 18 Dec 2024 07:59:19 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b01d17sm23876155e9.16.2024.12.18.07.59.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:59:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/2] system: Move 'exec/confidential-guest-support.h' to
 system/
Date: Wed, 18 Dec 2024 16:59:12 +0100
Message-ID: <20241218155913.72288-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218155913.72288-1-philmd@linaro.org>
References: <20241218155913.72288-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

"exec/confidential-guest-support.h" is specific to system
emulation, so move it under the system/ namespace.
Mechanical change doing:

  $ sed -i \
    -e 's,exec/confidential-guest-support.h,sysemu/confidential-guest-support.h,' \
        $(git grep -l exec/confidential-guest-support.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/{exec => system}/confidential-guest-support.h | 6 +++---
 target/i386/confidential-guest.h                      | 2 +-
 target/i386/sev.h                                     | 2 +-
 backends/confidential-guest-support.c                 | 2 +-
 hw/core/machine.c                                     | 2 +-
 hw/ppc/pef.c                                          | 2 +-
 hw/ppc/spapr.c                                        | 2 +-
 hw/s390x/s390-virtio-ccw.c                            | 2 +-
 system/vl.c                                           | 2 +-
 target/s390x/kvm/pv.c                                 | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)
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
 
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 858005a119c..2664c0b1b6c 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -18,7 +18,7 @@
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
 
-#include "exec/confidential-guest-support.h"
+#include "system/confidential-guest-support.h"
 
 #define TYPE_SEV_COMMON "sev-common"
 #define TYPE_SEV_GUEST "sev-guest"
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
index ba819fec0af..0e8af37194f 100644
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
index a271ecc1acf..4785b3ff09a 100644
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
2.45.2


