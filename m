Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63830EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAc-0000dF-JE; Wed, 04 Feb 2026 14:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAY-0000BX-NI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAW-00081D-Kq
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6HhJDWdiH+sSKLH6a+nIbjrvZv2j3XojMKDoG+stmr4=;
 b=g/sjk6wXZ078RasBJN3CWEt3bTkESMIGgUB7lg0rRAjPn8tsLZDXXLoRtOPzqTVeKHU5Fk
 Q1We7cp2bPAOEeGcNWrOOP6YsOAFcr2eGMxxATRT5NJuRqVpN3FZs6kXBJUjjogkgt/YP2
 2JUh5wm63ghqWtR/ZrPRWx0QYOYIjy8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-IGDYuDatNPOD8ivS8bkq_w-1; Wed, 04 Feb 2026 14:04:02 -0500
X-MC-Unique: IGDYuDatNPOD8ivS8bkq_w-1
X-Mimecast-MFC-AGG-ID: IGDYuDatNPOD8ivS8bkq_w_1770231842
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so1253595e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231841; x=1770836641; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6HhJDWdiH+sSKLH6a+nIbjrvZv2j3XojMKDoG+stmr4=;
 b=ceqFDkUbm7UpvlV/V2Gh0Pf9lozBTyjIiWhz8szeAeHWH/W9jx75XuTVgAhuCDvmy6
 t1Jdynx/PLt+kUFfptHnE1hn8QzdBoKarRpUzMG5sXHCohJJwNv4t3C20beCUgKTjI3x
 TlX+y/NcH52HkDswdar6ZaDfacYJiSGJ190ccmNmM96Fv0Ls77HC9kkNPGc5l0aVw+tl
 N3gR09QtFKbjZwtvohaieE730UJtZYB/6W9SPHP71VkbGKsvGqjlvC6GK/JqvmlvtRAV
 Moy7IathjrdajbdzoYn0DKnYkFeYaugMXZHGJEZ8z2GGws3CUIgXDO12kc1SRoCO36qy
 WSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231841; x=1770836641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HhJDWdiH+sSKLH6a+nIbjrvZv2j3XojMKDoG+stmr4=;
 b=oEzaWHwnB4HhpdnWta97CB2TZFWWKDt4icRSaeQEATWcJgZYGdhcj5pbjRznOW+A74
 dskFv2xnsiGSd2jkghm+ssy5xfk9WiwBgYHnE9twGb+4L2dQ+fhIAyfSoyCLx4lvItK1
 d3AmHExLU8z9KouAgDSZG6tZxLQld16hX12RXOC5VsvukCLVladY2sFDlzxZ5x1cxRiA
 RZkJXVatWqT+JDzvlUJz59dRdg1qk86DYUUGo2eOb/xbM6A6BMlt75/jdT89Pd3hZ4uj
 ega7xaVmPCftnmXzxR5tElhVaZ8IqIYuIlDrA0rEX7NEQlBQ1/uPIF5kSWgOzWr1Yjv5
 kOtA==
X-Gm-Message-State: AOJu0Yw8u7Rwfrqxq4pmH20yph8Y+iw035F3h7sHOWJIVO7WmNkbNEkV
 Li4Fke6KqZ5P3a7MDTpbY/6wl4OBNbeK8fMpn4aGOtQfbdsMfyHfI7O1Qqm0+WoZ83fg69eIDGA
 DlictGLGrUBSDtaQf0EH/KXFERHupSj4cYEVKaPhXwIMX26CjQ9ofWbEjQdjqFV9U83QHhkmm4Y
 oZf7yZ4VvVNBtANgHm4pj8aUrJMvKi8mko4A==
X-Gm-Gg: AZuq6aJ5Mo4o9UE5/o0iBRHtZi6pc+YaM6fc/+xGlx4N00TOGJz5kuUG/DhHrooEMYi
 HRCZ/obnnPdZjyIiVAm1diw8CFvwMFv8ypgRfdgQESf22f55lYVAVcMaWC+otFJAUXK4JXb+ayX
 q9orp4dpT+V37Sl2rh1cu5CvHQr1+0pzOKh+09GFlwl4HUureeO3LPQNo0fkdf++A1ACGBbVUM6
 j/OTNzofEPCO6htRmGlIn2wSB0afL0W2vVC/tihB6umgdQDG7Ck6bKvcpfKRIyXs+f+YuRl4CwR
 ywO2RNAylN3XFA0RkzUIiJWa9waG1T4jdYKBBcNRkAw/MACQ9yMUB4GiseLlCgC0r34Gsq8jk1M
 InVlMRrtp4ua+a/FtzhAMpSabD6dhfMzkvw==
X-Received: by 2002:a05:600c:4e4f:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-4830e9335cfmr55705385e9.11.1770231841164; 
 Wed, 04 Feb 2026 11:04:01 -0800 (PST)
X-Received: by 2002:a05:600c:4e4f:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-4830e9335cfmr55704845e9.11.1770231840650; 
 Wed, 04 Feb 2026 11:04:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d345c2sm5071665e9.6.2026.02.04.11.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:59 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: [PULL 30/51] acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
Message-ID: <2f6dc473b905c5c82370f74debc56d5f673d2db7.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

Use error_fatal in acpi_ghes_memory_errors() so that the caller needn't
explicitly call exit(). The return value of acpi_ghes_memory_errors()
and ghes_record_cper_errors() is changed to 'bool' indicating an error
has been raised, to be compatible with what's documented in error.h.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251201141803.2386129-6-gshan@redhat.com>
---
 hw/acpi/ghes-stub.c    |  4 ++--
 hw/acpi/ghes.c         | 26 ++++++++++----------------
 include/hw/acpi/ghes.h |  6 +++---
 target/arm/kvm.c       |  9 +++------
 4 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index b54f1b093c..5f9313cce9 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,8 +11,8 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t physical_address)
+bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                             uint64_t physical_address, Error **errp)
 {
     g_assert_not_reached();
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index d51d4bd466..c42f1721c4 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -516,14 +516,14 @@ static bool get_ghes_source_offsets(uint16_t source_id,
 NotifierList acpi_generic_error_notifiers =
     NOTIFIER_LIST_INITIALIZER(acpi_generic_error_notifiers);
 
-void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
+bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
 
     if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
         error_setg(errp, "GHES CPER record is too big: %zd", len);
-        return;
+        return false;
     }
 
     if (!ags->use_hest_addr) {
@@ -532,7 +532,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     } else if (!get_ghes_source_offsets(source_id,
                     le64_to_cpu(ags->hest_addr_le),
                     &cper_addr, &read_ack_register_addr, errp)) {
-            return;
+            return false;
     }
 
     cpu_physical_memory_read(read_ack_register_addr,
@@ -543,7 +543,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
         error_setg(errp,
                    "OSPM does not acknowledge previous error,"
                    " so can not record CPER for current error anymore");
-        return;
+        return false;
     }
 
     read_ack_register = cpu_to_le64(0);
@@ -558,16 +558,17 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     cpu_physical_memory_write(cper_addr, cper, len);
 
     notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
+
+    return true;
 }
 
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t physical_address)
+bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                             uint64_t physical_address, Error **errp)
 {
     /* Memory Error Section Type */
     const uint8_t guid[] =
           UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
                   0xED, 0x7C, 0x83, 0xB1);
-    Error *err = NULL;
     int data_length;
     g_autoptr(GArray) block = g_array_new(false, true /* clear */, 1);
 
@@ -584,15 +585,8 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     /* Build the memory section CPER for above new generic error data entry */
     acpi_ghes_build_append_mem_cper(block, physical_address);
 
-    /* Report the error */
-    ghes_record_cper_errors(ags, block->data, block->len, source_id, &err);
-
-    if (err) {
-        error_report_err(err);
-        return -1;
-    }
-
-    return 0;
+    return ghes_record_cper_errors(ags, block->data, block->len,
+                                   source_id, errp);
 }
 
 AcpiGhesState *acpi_ghes_get_state(void)
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index df2ecbf6e4..5b29aae4dd 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -98,9 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t error_physical_addr);
-void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
+bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                            uint64_t error_physical_addr, Error **errp);
+bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
 /**
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b83f1d5e4f..3e35570f15 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2473,12 +2473,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              */
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
-                                             paddr)) {
-                    kvm_inject_arm_sea(c);
-                } else {
-                    exit(1);
-                }
+                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
+                                        paddr, &error_fatal);
+                kvm_inject_arm_sea(c);
             }
             return;
         }
-- 
MST


