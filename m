Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD42C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwa-0005by-By; Sun, 05 Jul 2026 10:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwZ-0005bn-Kz
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwX-0001QP-Jd
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M/pDiHFNHl4AEoQzRlTnpmRpNB3vDThrml6JhOkf8EM=;
 b=gmswQZ0BEk3XlnwzoHDrV3nXpiWK17FxtEmP+6x44QdLVzmIaqedhRLbeYkIQqZhjtfedv
 +rQvm/ZBOt9R9AyxQRm914Pdu4zjerMXAE9m9D6byJQRXGiGDMAYYn7MBbSVXZsGGq2EpD
 Q0T6sO3kaT2XOzzbYtdB8c/DFBNiKEI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-o5XOPf4PM8Cbw4ivRKduFg-1; Sun, 05 Jul 2026 10:35:35 -0400
X-MC-Unique: o5XOPf4PM8Cbw4ivRKduFg-1
X-Mimecast-MFC-AGG-ID: o5XOPf4PM8Cbw4ivRKduFg_1783262134
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-475eba52438so1414667f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262134; x=1783866934; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M/pDiHFNHl4AEoQzRlTnpmRpNB3vDThrml6JhOkf8EM=;
 b=KuGIBCB0JICuaYjGkp88GuN/f3DvqlXMKLtCXRIobBysORh+niT/U23SaM6KQ0MzyY
 7H8PJ3crTAUaa99SGmGo2lKNB6zw/omUOA6SG0QPOerqfOjCfMyc8D5hoCVZBB2MXXdJ
 A159P2AhN2mp2opKccuer0FFsIpCCRfSJRDlpvC/Snv3cygedX0JiQq2vih9+VU+1Lwl
 p04hNNnJc+t2BUTiQcAD0c/vECIjh52Sm2ltOPiZFFwJv7l+x/HKQQnJoD1b2bF9RYtY
 I5L5i8hVuWxcXX72V5yqzevFUV1AKcg5hdYVcrobHAKBPXJ/ilbkUJ5tvYqe5LS1Rwcf
 6dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262134; x=1783866934;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M/pDiHFNHl4AEoQzRlTnpmRpNB3vDThrml6JhOkf8EM=;
 b=Z8t7kOxYWAMw4BuQzrx3TDoYakE8Mj/jjPipvV1aYrL8icPtZWA7hpq6JDRrsiTbkb
 ZOEoOwTdzQdJNB9u2Ry0kCsx+70oV4Qer3ehgt56XePiuE1SKEx8ifBewjNyE9xwuL7o
 Rg0aWnH+DgqcbWGybhDN510VdIvGTENtYB1Wr8XlpT2d0MrQYGSEJRQ669p9bdJbIJV+
 4Bev9NOed707vEnNBVoYLyVQz4OWt64ZcsSSiXum0q8lLRDMNImSUilYRjkQ3faZgOyd
 l6ZkJVFyUmi/gQfDD2kVJBF8QI4N8s9Y9HpLoE8MksTAC0yUvextrSV5rt4FV3OTXKsG
 9QXg==
X-Gm-Message-State: AOJu0Yx/jG7F7fOOlOcyaUsSJsZL3jbf4oOwGFF2p1M8qA7rsCl/vVLM
 aPewkCvpWlCh/7zvvXHBJBk8zHSXeHndHxCKGQP/TCz6ePp+RDYbRbxaXTetsYEMgstafvoddf4
 2+ADfAtrkwcaHlLLnRm3MrTaE/8i2FNoqLKwbFixbahasYhf3W5D5222JzmL88/gXhJbcizXV/c
 4GNxolu4FY8FmRvvRZKzKqhOUkdYEJnGX9jg==
X-Gm-Gg: AfdE7ckkUf0XIctCVwHu0qFfQCRB71iUqvvdfuvJ+cUQf5/Gnc3jKeb/OHqXIgcRLhZ
 LRYplzZCrvx4v7YZOK2mkIM9nwsst77MpKGo5qN13vNO3QujZQhVRGt2EWBEIYO47pyXVeB5EE7
 YTSVf6auoTRvhDHK5sUIKXw96YLhcayyTrPh/lx3FJeuSQUvJT2LnBRAl6vsT9LjGkz+XQRGqv/
 /Xye4LwAjFiCA12pFqnEpz5Dxpxv1bzRe4KDmlYJR4B7z88LAQzhuadx3CCcEyVM/pWqcHRxXqR
 4H5VAykm6/AUIKaoP9/Sdt6Adt+rUWanSBzpUW55RRwm5tKzU9UQhaKt37raVPPvNarignjmUKl
 PRwnXQRm9abj6srv5Xq3LulY+s35BWmYp
X-Received: by 2002:a5d:5e08:0:b0:475:f100:35f9 with SMTP id
 ffacd0b85a97d-47aae0d9d11mr7273845f8f.54.1783262134425; 
 Sun, 05 Jul 2026 07:35:34 -0700 (PDT)
X-Received: by 2002:a5d:5e08:0:b0:475:f100:35f9 with SMTP id
 ffacd0b85a97d-47aae0d9d11mr7273811f8f.54.1783262133890; 
 Sun, 05 Jul 2026 07:35:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa09608d4sm17272049f8f.25.2026.07.05.07.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:33 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PULL 21/44] tests/qtest/libqos: share Intel IOMMU test setup helpers
Message-ID: <302fec996c31ac312278a6a756d66d053b80d2fa.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

iommu-intel-test.c keeps the iommu-testdev PCI setup (save_fn(),
setup_qtest_pci_device()) and the VT-d command-line / capability
helpers (qvtd_iommu_args(), qvtd_check_caps()) as file-local statics.
A second Intel IOMMU test would have to copy them, which defeats the
purpose of the shared qos-intel-iommu module.

Move them into qos-intel-iommu so sibling tests can reuse them:
save_fn() becomes qvtd_save_pci_dev() and setup_qtest_pci_device()
becomes qvtd_setup_qtest_pci_device(); qvtd_iommu_args() and
qvtd_check_caps() keep their names.

No functional change: iommu-intel-test now calls the public
qvtd_setup_qtest_pci_device() instead of its file-local copy.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260703072200.463082-2-junjie.cao@intel.com>
---
 tests/qtest/libqos/qos-intel-iommu.h | 23 ++++++++
 tests/qtest/iommu-intel-test.c       | 78 +---------------------------
 tests/qtest/libqos/qos-intel-iommu.c | 77 +++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 77 deletions(-)

diff --git a/tests/qtest/libqos/qos-intel-iommu.h b/tests/qtest/libqos/qos-intel-iommu.h
index c6cacc5c3f..dd6f920464 100644
--- a/tests/qtest/libqos/qos-intel-iommu.h
+++ b/tests/qtest/libqos/qos-intel-iommu.h
@@ -182,4 +182,27 @@ void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
                                QPCIBar bar, uint64_t iommu_base,
                                const QVTDTestConfig *cfg);
 
+/*
+ * qvtd_iommu_args - Build the -device intel-iommu command-line fragment
+ *                   for the requested translation mode.
+ */
+const char *qvtd_iommu_args(QVTDTransMode mode);
+
+/*
+ * qvtd_check_caps - Check whether the running QEMU exposes the ECAP bits
+ *                   required by @mode.  Calls g_test_skip() and returns
+ *                   false when a required capability is missing.
+ */
+bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode);
+
+/*
+ * qvtd_setup_qtest_pci_device - Create a QPCIBus, locate the iommu-testdev
+ *                               PCI function, enable it and map BAR0.
+ *
+ * On success, *pcibus and *bar are populated and the returned QPCIDevice
+ * must be released by the caller via g_free().
+ */
+QPCIDevice *qvtd_setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
+                                        QPCIBar *bar);
+
 #endif /* QTEST_LIBQOS_INTEL_IOMMU_H */
diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
index 703bbfef73..c2744def6f 100644
--- a/tests/qtest/iommu-intel-test.c
+++ b/tests/qtest/iommu-intel-test.c
@@ -24,82 +24,6 @@ static uint64_t intel_iommu_expected_gpa(uint64_t iova)
     return (QVTD_PT_VAL & VTD_PAGE_MASK_4K) + (iova & 0xfff);
 }
 
-static void save_fn(QPCIDevice *dev, int devfn, void *data)
-{
-    QPCIDevice **pdev = (QPCIDevice **) data;
-
-    *pdev = dev;
-}
-
-static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
-                                          QPCIBar *bar)
-{
-    QPCIDevice *dev = NULL;
-
-    *pcibus = qpci_new_pc(qts, NULL);
-    g_assert(*pcibus != NULL);
-
-    qpci_device_foreach(*pcibus, IOMMU_TESTDEV_VENDOR_ID,
-                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
-
-    g_assert(dev);
-    qpci_device_enable(dev);
-    *bar = qpci_iomap(dev, 0, NULL);
-    g_assert_false(bar->is_io);
-
-    return dev;
-}
-
-static const char *qvtd_iommu_args(QVTDTransMode mode)
-{
-    switch (mode) {
-    case QVTD_TM_SCALABLE_FLT:
-        return "-device intel-iommu,scalable-mode=on,fsts=on ";
-    case QVTD_TM_SCALABLE_PT:
-    case QVTD_TM_SCALABLE_SLT:
-        return "-device intel-iommu,scalable-mode=on ";
-    default:
-        return "-device intel-iommu ";
-    }
-}
-
-static bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode)
-{
-    uint64_t ecap = qtest_readq(qts,
-                                Q35_HOST_BRIDGE_IOMMU_ADDR + DMAR_ECAP_REG);
-
-    /* All scalable modes require SMTS */
-    if (qvtd_is_scalable(mode) && !(ecap & VTD_ECAP_SMTS)) {
-        g_test_skip("ECAP.SMTS not supported");
-        return false;
-    }
-
-    switch (mode) {
-    case QVTD_TM_SCALABLE_PT:
-        if (!(ecap & VTD_ECAP_PT)) {
-            g_test_skip("ECAP.PT not supported");
-            return false;
-        }
-        break;
-    case QVTD_TM_SCALABLE_SLT:
-        if (!(ecap & VTD_ECAP_SSTS)) {
-            g_test_skip("ECAP.SSTS not supported");
-            return false;
-        }
-        break;
-    case QVTD_TM_SCALABLE_FLT:
-        if (!(ecap & VTD_ECAP_FSTS)) {
-            g_test_skip("ECAP.FSTS not supported");
-            return false;
-        }
-        break;
-    default:
-        break;
-    }
-
-    return true;
-}
-
 static void run_intel_iommu_translation(const QVTDTestConfig *cfg)
 {
     QTestState *qts;
@@ -124,7 +48,7 @@ static void run_intel_iommu_translation(const QVTDTestConfig *cfg)
     }
 
     /* Setup and configure IOMMU-testdev PCI device */
-    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
+    dev = qvtd_setup_qtest_pci_device(qts, &pcibus, &bar);
     g_assert(dev);
 
     g_test_message("### Intel IOMMU translation mode=%d ###", cfg->trans_mode);
diff --git a/tests/qtest/libqos/qos-intel-iommu.c b/tests/qtest/libqos/qos-intel-iommu.c
index f8ca4c871b..4095ac0917 100644
--- a/tests/qtest/libqos/qos-intel-iommu.c
+++ b/tests/qtest/libqos/qos-intel-iommu.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/i386/intel_iommu_internal.h"
 #include "tests/qtest/libqos/pci.h"
+#include "tests/qtest/libqos/pci-pc.h"
 #include "qos-iommu-testdev.h"
 #include "qos-intel-iommu.h"
 
@@ -452,3 +453,79 @@ void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
         }
     }
 }
+
+const char *qvtd_iommu_args(QVTDTransMode mode)
+{
+    switch (mode) {
+    case QVTD_TM_SCALABLE_FLT:
+        return "-device intel-iommu,scalable-mode=on,fsts=on ";
+    case QVTD_TM_SCALABLE_PT:
+    case QVTD_TM_SCALABLE_SLT:
+        return "-device intel-iommu,scalable-mode=on ";
+    default:
+        return "-device intel-iommu ";
+    }
+}
+
+bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode)
+{
+    uint64_t ecap = qtest_readq(qts,
+                                Q35_HOST_BRIDGE_IOMMU_ADDR + DMAR_ECAP_REG);
+
+    /* All scalable modes require SMTS */
+    if (qvtd_is_scalable(mode) && !(ecap & VTD_ECAP_SMTS)) {
+        g_test_skip("ECAP.SMTS not supported");
+        return false;
+    }
+
+    switch (mode) {
+    case QVTD_TM_SCALABLE_PT:
+        if (!(ecap & VTD_ECAP_PT)) {
+            g_test_skip("ECAP.PT not supported");
+            return false;
+        }
+        break;
+    case QVTD_TM_SCALABLE_SLT:
+        if (!(ecap & VTD_ECAP_SSTS)) {
+            g_test_skip("ECAP.SSTS not supported");
+            return false;
+        }
+        break;
+    case QVTD_TM_SCALABLE_FLT:
+        if (!(ecap & VTD_ECAP_FSTS)) {
+            g_test_skip("ECAP.FSTS not supported");
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
+    return true;
+}
+
+static void qvtd_save_pci_dev(QPCIDevice *dev, int devfn, void *data)
+{
+    QPCIDevice **pdev = (QPCIDevice **)data;
+
+    *pdev = dev;
+}
+
+QPCIDevice *qvtd_setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
+                                        QPCIBar *bar)
+{
+    QPCIDevice *dev = NULL;
+
+    *pcibus = qpci_new_pc(qts, NULL);
+    g_assert(*pcibus != NULL);
+
+    qpci_device_foreach(*pcibus, IOMMU_TESTDEV_VENDOR_ID,
+                        IOMMU_TESTDEV_DEVICE_ID, qvtd_save_pci_dev, &dev);
+
+    g_assert(dev);
+    qpci_device_enable(dev);
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    return dev;
+}
-- 
MST


