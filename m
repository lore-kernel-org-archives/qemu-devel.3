Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DD6C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJp11-0005dq-Hr; Tue, 27 May 2025 03:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJozK-0002r5-Qm
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJozI-0000Sf-Ra
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjrLUtJ/wTeOeGDQFHs3hbhXToVFKVogEjfIEHIOlwI=;
 b=VNxZ7HBYnApWwvMpGpdCWCxgMet5S4K36peX3MnWR+Mo8FmZAE+5QvqLXMJNOkjIExQsbc
 m15c8hfze1WezID3zRF7QkWGKq0FMnGIgJQIql23PgiPhoNTWXwqwkhkaych4VomWE77BO
 xZ97Rm0QjvzJEJlmjDaFnEhsmblhv4c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-sZS2cBcbO5mCSNgA5ZM2Ug-1; Tue,
 27 May 2025 03:44:36 -0400
X-MC-Unique: sZS2cBcbO5mCSNgA5ZM2Ug-1
X-Mimecast-MFC-AGG-ID: sZS2cBcbO5mCSNgA5ZM2Ug_1748331874
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9618D1800115; Tue, 27 May 2025 07:44:34 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C91019560AA; Tue, 27 May 2025 07:44:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI hotplug
 off
Date: Tue, 27 May 2025 09:40:26 +0200
Message-ID: <20250527074224.1197793-25-eric.auger@redhat.com>
In-Reply-To: <20250527074224.1197793-1-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Gustavo Romero <gustavo.romero@linaro.org>

ACPI PCI hotplug is now turned on by default so we need to change the
existing tests to keep it off. However, even setting the ACPI PCI
hotplug off in the existing tests, there will be changes in the ACPI
tables because the _OSC method was modified, hence in the next patch of
this series the blobs are updated accordingly.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

[Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
---
 tests/qtest/bios-tables-test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec435..6379dba714 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
     };
 
     data.variant = ".memhp";
-    test_acpi_one(" -machine nvdimm=on"
+    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
                   " -cpu cortex-a57"
                   " -m 256M,slots=3,maxmem=1G"
                   " -object memory-backend-ram,id=ram0,size=128M"
@@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
     };
 
     data.variant = ".numamem";
-    test_acpi_one(" -cpu cortex-a57"
+    test_acpi_one(" -machine acpi-pcihp=off"
+                  " -cpu cortex-a57"
                   " -object memory-backend-ram,id=ram0,size=128M"
                   " -numa node,memdev=ram0",
                   &data);
@@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
      * to solve the conflicts.
      */
     data.variant = ".pxb";
-    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+    test_acpi_one(" -machine acpi-pcihp=off"
+                  " -device pcie-root-port,chassis=1,id=pci.1"
                   " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
                   " -drive file="
                   "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
@@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
 
     data.variant = ".acpihmatvirt";
 
-    test_acpi_one(" -machine hmat=on"
+    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
                   " -cpu cortex-a57"
                   " -smp 4,sockets=2"
                   " -m 384M"
@@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
     data.smbios_cpu_max_speed = 2900;
     data.smbios_cpu_curr_speed = 2700;
     test_acpi_one("-cpu cortex-a57 "
+                  "-machine acpi-pcihp=off "
                   "-smbios type=4,max-speed=2900,current-speed=2700", &data);
     free_test_data(&data);
 }
@@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
     };
 
     test_acpi_one("-cpu cortex-a57 "
+                  "-machine acpi-pcihp=off "
                   "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
     free_test_data(&data);
 }
@@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
     };
 
     test_acpi_one("-cpu cortex-a57 "
+                  "-machine acpi-pcihp=off "
                   "-device virtio-iommu-pci", &data);
     free_test_data(&data);
 }
-- 
2.49.0


