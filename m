Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782D0C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 18:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEv0U-00086H-72; Wed, 05 Jun 2024 14:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEv0R-00082e-8Q
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:05:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEv0O-0005tL-5G
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:05:02 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvZxZ31tTz6K7CW;
 Thu,  6 Jun 2024 02:00:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 98ABA1400D9;
 Thu,  6 Jun 2024 02:04:55 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 19:04:55 +0100
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic Port
 Affinity Structures
Date: Wed, 5 Jun 2024 19:04:55 +0100
Message-ID: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Treating the HID as an integer caused it to get bit reversed
on big endian hosts running little endian guests.  Treat it
as a character array instead.

Fixes hw/acpi: Generic Port Affinity Structure Support
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Richard ran the version posted in the thread on an s390 instance.
Thanks for the help!

Difference from version in thread:
- Instantiate i in the for loop.

Sending out now so Michael can decide whether to fold this in, or
drop the GP series for now from his pull request (in which case
I'll do an updated version with this and Markus' docs feedback
folded in.)

---
 include/hw/acpi/acpi_generic_initiator.h | 2 +-
 hw/acpi/acpi_generic_initiator.c         | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index 1a899af30f..5baefda33a 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
             uint16_t bdf;
         };
         struct {
-            uint64_t hid;
+            char hid[8];
             uint32_t uid;
         };
     };
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 78b80dcf08..f064753b67 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
         build_append_int_noprefix(table_data, 0, 12);
     } else {
         /* Device Handle - ACPI */
-        build_append_int_noprefix(table_data, handle->hid, 8);
+        for (int i = 0; i < sizeof(handle->hid); i++) {
+            build_append_int_noprefix(table_data, handle->hid[i], 1);
+        }
         build_append_int_noprefix(table_data, handle->uid, 4);
         build_append_int_noprefix(table_data, 0, 4);
     }
-- 
2.39.2


