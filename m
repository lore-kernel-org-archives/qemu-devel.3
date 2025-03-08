Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7115C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3KK-0000YS-DS; Sat, 08 Mar 2025 18:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3K6-00007B-DS
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:14 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3K4-0001bg-9I
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bccfa7b89so25637325e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475470; x=1742080270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SchAlroLdDNdcNXpi1x0hC/CnniZL26bHHU3ofZkp5E=;
 b=HGwmO33t/cREfu+qWyaiqUM3tWoYr1bDzjtkVXmc2XfIJD4sertyYdR+0uUul0udvk
 5ca9wmnIQ1Zy5Sq1+zuvk/qka3Nj1lElpJ/yzcT79aqZfgxiXCYObrYA6Iq/Iyu6UhAS
 64x9ecL2wqnaQiCx9ocSr/gsrZmw0/JU26HWDTa4YxiU/sG1IxOdqoDuVjsWVC9sZORm
 ruHOzyeQ64QTOFuV21HOvR2SU56F7+SdMIeRNnAcOw+ftoBbqSefzT1b9zllc4f6ZFLL
 UWVyCd58Z44wkvvB681c/H9WzPcOGsEpdAlIi45dGughIhxTn9JYdM2RLKYxCoxNoYDz
 QvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475470; x=1742080270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SchAlroLdDNdcNXpi1x0hC/CnniZL26bHHU3ofZkp5E=;
 b=NhHlVZyqZicbr5brhuswy5hSFHIWP9BdV6pk16cEHKZNW3fwps2QL9J/Hc9aL5pWXN
 ra0WaONWMW8WmRYXUryMB9yFsUwwIIivUoeqsC7xU0u+Yr+b/6STVvgiahHVgAd1weoU
 v8uaxNzcQ5SVxbgjrhxOhUrCgWAhATgeB1XMNgvgZ9Mk461K/JjaAAEvlPEtEQkfK9tX
 zu5T6FHy8SkPDo+zvyzhhZ9O+j26fiX/6I8LtV6zvwaEhEoIbMxxweQQq4Op8QZHpb8k
 9V45ztFw51wIVVKS6mfius+Po02ptl80lZrcH0CTGJDQZeZzliakiXgOEs2XkUu99G93
 yqTQ==
X-Gm-Message-State: AOJu0YxsQva5Y+m6mXYya/lMD7gmfpE/Ef5fh1xgO2wKvRlQZXAKw9v5
 SXLmnfuhP5n8omfBalschtxEZtS8SAT3V07wwmVNInYD9GGgu8jhB5epg5TWHGCJTRH/eK2Ww31
 Tx6o=
X-Gm-Gg: ASbGncuS+rpkXhT7uthntdgFTT1GBYr5S/lZzHCgmrkCI7cT3g9ZRRa1aN/arvnl0P3
 gnfSyjWHPJf95ACzxf4/UQAVxbVQVMLt3TFOHGTiJD7OcY747Y4vP8D2OJTHsCxvglrd3Pu+ERw
 OBUOgQDUMXenxIIlihtYteKkuyFMqcOM/7Vhq9rMfZ0SEY1MHAurXn5356ujHqTkFkWYdLFgflZ
 77AvO6Rrc0T9MPre0+/1cwbBB56syWW3Rc2o4Iul1cJtRRwwh2noyTGMquR4Mb4W1KUhMwyCo47
 Y/CXM7syy6h5nfM2dYyDduVFdLcG4YKGNPGKIzRzWle1wj4zHtBV2+Nkfz2a1noglKAx/RbeC5R
 +qK3mjiGxrRGtZ4Fl7Rs=
X-Google-Smtp-Source: AGHT+IEb/b4LOE2Bgus21ZYrnM3VVzkRV4FDIHRDZ5Yi+DfrCk1Fa3EmoxdciYSS3mQYlPYdKzgUqA==
X-Received: by 2002:a05:600c:4e89:b0:43b:c448:bc34 with SMTP id
 5b1f17b1804b1-43c601d0758mr55299595e9.18.1741475470398; 
 Sat, 08 Mar 2025 15:11:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e4065sm10261640f8f.62.2025.03.08.15.11.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:11:09 -0800 (PST)
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
Subject: [PATCH v2 19/21] hw/vfio/s390x: Compile AP and CCW once
Date: Sun,  9 Mar 2025 00:09:15 +0100
Message-ID: <20250308230917.18907-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since the files don't use any target-specific knowledge anymore,
move them to system_ss[] to build them once, even if they are
only used for one unique binary (qemu-system-s390x).

Because files in system_ss[] don't get the target/foo/ path in
their CPPFLAGS, use header paths relative to the root directory.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/kvm/kvm_s390x.h | 2 +-
 hw/vfio/ap.c                 | 2 +-
 hw/vfio/meson.build          | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 649dae5948a..7b1cce3e60d 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -10,7 +10,7 @@
 #ifndef KVM_S390X_H
 #define KVM_S390X_H
 
-#include "cpu-qom.h"
+#include "target/s390x/cpu-qom.h"
 
 struct kvm_s390_irq;
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index a4ec2b5f9ac..832b98532ea 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "kvm/kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index ff9bd4f2e35..3119c841ed9 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,9 +4,7 @@ vfio_ss.add(files(
   'container.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
@@ -27,6 +25,8 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
 ))
+system_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
+system_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci.c',
-- 
2.47.1


