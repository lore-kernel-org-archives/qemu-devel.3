Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED08CD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6q9-0001ru-26; Wed, 29 Apr 2026 11:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wI6q6-0001rd-RE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:28:38 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wI6q4-0006iq-3l
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:28:38 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2adbfab4501so59553665ad.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476514; x=1778081314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oaj7TdntV4BbKlicNCDnibmbfLlIXWSzMFxlbQXRV0=;
 b=eJVAcCSdisCHVDPJPhhah5H1m5se+yue09/FFItiNrBDIR/0eBld4aGy3TzTBrIfA5
 a4G5UMEkRsstdkmqOfPPdQZkVdRZhc/NJHgfEFdIdpPvNNPyMtn5o8N1J9DokY0/vql9
 791jJ30hedlRkU5wQIyB/EjiafllLy49TGJSrlvf8oFPmWv/Z/RNFUewYs5WTtYcGVZF
 5AYZ4tYtncxjj+hpRXtsX27RTPhItx+LQZHpn9qYysUxikvIfsoRiWd/+PosRoijgUX/
 jk78X6ZcU850bJaz5Owz1/GqaUzLAf7ULJ/6LeRAxrUc1XonVDoNJnCZKERNhs/pI6tq
 hoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476514; x=1778081314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/oaj7TdntV4BbKlicNCDnibmbfLlIXWSzMFxlbQXRV0=;
 b=Ezx3IU1RxMfyro8v2ekYQzBnSOt2YBKcMKF8sANnPopRi2Hp6P3ZTqh4y32k/kP3Zu
 VN3cLty3WBIhoHdBa/g9pFXlrTsQnjcv5QBixm4adcNsBiJS3LyZggI6R5xagmDoEIPF
 HUoLZsJvUAeOzTGN/zGXRnS7ebCEs75m6MXOZ5fjjsXhYskF/SL+uhOMq07XBTL+NB/e
 QcWcsrr/mHNyyD8pwj0qcNpfXh13AoJEIXcPlYr0PczttSO5jVuUBiSIB/IfTtHjyWE4
 6Ogodznz8K8RHpKPvaVt+AXBed5vFz/y6VDGHsAvZgwdqABuvtkNZhLS0dnXA2UMQYkr
 kLZw==
X-Gm-Message-State: AOJu0YxZOifk8LIugWyUJKfhrRAL1/W47Nww58iwlRw3tQ+0rW5uqKwh
 9qpluu6bqESD0zzUnfC2KVugXu7yQIXWUySXA18snBXewQzBZLX587zn+gJslgN9u7xypg==
X-Gm-Gg: AeBDiesJyvqeAPvMvcrnoQTeXqM8WG3tautgT1g3roMG4CNCkv75XqB/Sk0x26I1dqs
 bWnHTE/xcu7+jmUf71bt92QGVE4YBEQPwxM0mb5rxluULJjwYNg8721JvFKIPhGIWh8IXS8Sq7+
 2NzcMq/2az3cUP0EH4wnB7+8mfnMs8oPi3iFjten21yDQC1yGPNpGHJ1O2kjj/A7lCdJsZ1nrsD
 De0uY/UFluPvAJh0DXw9S0/xSLBtUA6V8tIxkwK2pEG32l5aLAu2R9Vc8uZQ/lekomW8bvhvLrK
 7EiWPfGztmStCtoYTgsEVjPI6o8Iu4j/7Tue/yPeYbO1AqAa7k6At2OFXVdsxnLppFl6vK43gcx
 DXLtqzjOqCn/lnS5Q7teNQZ47iSW9Qz2BiOg2XqJQ5Ilo8BWvlEphTDhG7zEEYJB7Pq5+Bn7JHd
 CedxrM7divLbhALchlFAfCZpyDE8MQH0srPESK/849nJ/apj+fMy9lZV9gK6eYSA==
X-Received: by 2002:a17:903:90b:b0:2b2:dca5:101b with SMTP id
 d9443c01a7336-2b97c4061b1mr86423935ad.12.1777476513488; 
 Wed, 29 Apr 2026 08:28:33 -0700 (PDT)
Received: from localhost.localdomain ([114.249.134.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988990e4csm26106465ad.83.2026.04.29.08.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:28:33 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jic23@kernel.org, linux-cxl@vger.kernel.org,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2] hw/cxl: bound Set Feature writes
Date: Wed, 29 Apr 2026 23:27:50 +0800
Message-Id: <20260429152750.2409174-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFEAcA_DnrvSCVY3f2q=3OnXt0+708BcwSJ=KhMn1t3sbbXQbg@mail.gmail.com>
References: <CAFEAcA_DnrvSCVY3f2q=3OnXt0+708BcwSJ=KhMn1t3sbbXQbg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=physicalmtea@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit c1c4d6b38b13 added offset + length checks for the
patrol_scrub and ecs Set Feature branches, but the remaining
branches still copy mailbox payload data into fixed-size
write-attribute objects without the same validation.

A full mailbox payload can still reach rank_sparing and overrun
CXLMemSparingWriteAttrs on current master. With an ASan build
this aborts the host process with:

  ERROR: AddressSanitizer: heap-buffer-overflow
  WRITE of size 2016
      #0 __interceptor_memcpy
      #1 cmd_features_set_feature ../hw/cxl/cxl-mailbox-utils.c:1908
      #2 cxl_process_cci_message ../hw/cxl/cxl-mailbox-utils.c:4622
      #3 mailbox_reg_write ../hw/cxl/cxl-device-utils.c:209

Fold the bounds checking into a small helper and use it for
all Set Feature write-attribute branches, so oversized
requests fail with CXL_MBOX_INVALID_PAYLOAD_LENGTH instead
of overflowing the target buffers.

Add a qtest covering the rank_sparing path.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3458
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Hi Peter,

Thanks, that makes sense.

I've folded the repeated bounds checking into a small helper and respun
the patch as v2.

Thanks

v2:
- fold the repeated Set Feature bounds checks into a helper
- use the helper for all Set Feature write-attribute branches

 hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++------
 tests/qtest/cxl-test.c     | 99 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+), 24 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..4c7a083e4c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1702,6 +1702,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cxl_set_feature_copy(void *write_attrs,
+                                       size_t write_attrs_size,
+                                       uint16_t offset,
+                                       const void *payload,
+                                       uint16_t bytes_to_copy)
+{
+    if ((uint32_t)offset + bytes_to_copy > write_attrs_size) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    memcpy((uint8_t *)write_attrs + offset, payload, bytes_to_copy);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
 static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            uint8_t *payload_in,
@@ -1713,6 +1728,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
+    CXLRetCode ret;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
     uint16_t count;
@@ -1760,13 +1776,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        if ((uint32_t)hdr->offset + bytes_to_copy >
-            sizeof(ct3d->patrol_scrub_wr_attrs)) {
-            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-        }
-        memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
-               ps_write_attrs,
-               bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->patrol_scrub_wr_attrs,
+                                   sizeof(ct3d->patrol_scrub_wr_attrs),
+                                   hdr->offset, ps_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1787,13 +1803,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        if ((uint32_t)hdr->offset + bytes_to_copy >
-            sizeof(ct3d->ecs_wr_attrs)) {
-            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-        }
-        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
-               ecs_write_attrs,
-               bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->ecs_wr_attrs,
+                                   sizeof(ct3d->ecs_wr_attrs),
+                                   hdr->offset, ecs_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1813,8 +1829,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
-               sppr_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->soft_ppr_wr_attrs,
+                                   sizeof(ct3d->soft_ppr_wr_attrs),
+                                   hdr->offset, sppr_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1832,8 +1853,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
-               hppr_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->hard_ppr_wr_attrs,
+                                   sizeof(ct3d->hard_ppr_wr_attrs),
+                                   hdr->offset, hppr_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1851,8 +1877,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->cacheline_sparing_wr_attrs,
+                                   sizeof(ct3d->cacheline_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1869,8 +1900,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->row_sparing_wr_attrs,
+                                   sizeof(ct3d->row_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1887,8 +1923,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->bank_sparing_wr_attrs,
+                                   sizeof(ct3d->bank_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1905,8 +1946,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->rank_sparing_wr_attrs,
+                                   sizeof(ct3d->rank_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 8fb7e58d4f..a9fcd98736 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "hw/cxl/cxl_device.h"
 
 #define QEMU_PXB_CMD \
     "-machine q35,cxl=on " \
@@ -59,6 +60,12 @@
     "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
     "-device cxl-type3,bus=rp0,volatile-memdev=cxl-mem0,lsa=lsa0,id=mem0 "
 
+#define QEMU_T3D_DIRECT_PMEM \
+    "-machine q35,cxl=on -nodefaults " \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=1M " \
+    "-device cxl-type3,bus=pcie.0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 "
+
 #define QEMU_2T3D \
     "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
@@ -81,6 +88,17 @@
     "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
     "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
 
+#define CXL_T3D_DEVFN 0x08
+#define CXL_T3D_BAR2_ADDR 0x10000000ULL
+
+typedef struct QEMU_PACKED CXLSetFeatureInHeaderTest {
+    uint8_t uuid[16];
+    uint32_t flags;
+    uint16_t offset;
+    uint8_t version;
+    uint8_t rsvd[9];
+} CXLSetFeatureInHeaderTest;
+
 static void cxl_basic_hb(void)
 {
     qtest_start("-machine q35,cxl=on");
@@ -118,6 +136,85 @@ static void cxl_2root_port(void)
 }
 
 #ifdef CONFIG_POSIX
+static uint32_t cxl_test_pci_config_addr(uint8_t devfn, uint8_t offset)
+{
+    return 0x80000000U | (devfn << 8) | offset;
+}
+
+static void cxl_test_t3d_enable_bar2(void)
+{
+    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x18));
+    outl(0xcfc, CXL_T3D_BAR2_ADDR);
+    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x1c));
+    outl(0xcfc, 0);
+    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x04));
+    outl(0xcfc, 0x2);
+}
+
+static uint64_t cxl_test_t3d_mailbox_base(void)
+{
+    return CXL_T3D_BAR2_ADDR + CXL_MAILBOX_REGISTERS_OFFSET;
+}
+
+static uint64_t cxl_test_t3d_payload_base(void)
+{
+    return cxl_test_t3d_mailbox_base() + A_CXL_DEV_CMD_PAYLOAD;
+}
+
+static void cxl_test_t3d_submit_set_feature(const void *payload, size_t len)
+{
+    memwrite(cxl_test_t3d_payload_base(), payload, len);
+    writeq(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_CMD,
+           ((uint64_t)len << 16) | (0x05 << 8) | 0x02);
+    writel(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_CTRL, 1);
+}
+
+static uint16_t cxl_test_t3d_mailbox_errno(void)
+{
+    return (readq(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_STS) >>
+            32) & 0xffff;
+}
+
+static void cxl_test_fill_set_feature_header(CXLSetFeatureInHeaderTest *hdr,
+                                             const uint8_t uuid[16],
+                                             uint16_t offset,
+                                             uint8_t version)
+{
+    memset(hdr, 0, sizeof(*hdr));
+    memcpy(hdr->uuid, uuid, 16);
+    hdr->offset = cpu_to_le16(offset);
+    hdr->version = version;
+}
+
+static void cxl_t3d_set_feature_rejects_oversized_rank_sparing(void)
+{
+    static const uint8_t rank_sparing_uuid[16] = {
+        0x34, 0xdb, 0xaf, 0xf5, 0x05, 0x52, 0x42, 0x81,
+        0x8f, 0x76, 0xda, 0x0b, 0x5e, 0x7a, 0x76, 0xa7,
+    };
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+    uint8_t payload[CXL_MAILBOX_MAX_PAYLOAD_SIZE] = { 0 };
+    CXLSetFeatureInHeaderTest *hdr = (void *)payload;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+    g_string_printf(cmdline, QEMU_T3D_DIRECT_PMEM, tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    cxl_test_t3d_enable_bar2();
+
+    cxl_test_fill_set_feature_header(hdr, rank_sparing_uuid, 0,
+                                     CXL_MEMDEV_SPARING_SET_FEATURE_VERSION);
+    memset(payload + sizeof(*hdr), 0x41,
+           sizeof(payload) - sizeof(*hdr));
+    cxl_test_t3d_submit_set_feature(payload, sizeof(payload));
+    g_assert_cmphex(cxl_test_t3d_mailbox_errno(), ==,
+                    CXL_MBOX_INVALID_PAYLOAD_LENGTH);
+
+    qtest_end();
+    rmdir(tmpfs);
+}
+
 static void cxl_t3d_deprecated(void)
 {
     g_autoptr(GString) cmdline = g_string_new(NULL);
@@ -238,6 +335,8 @@ int main(int argc, char **argv)
         qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
         qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
         qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
+        qtest_add_func("/pci/cxl/type3_device_set_feature_rank_sparing_bounds",
+                       cxl_t3d_set_feature_rejects_oversized_rank_sparing);
         qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
         qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
                        cxl_2pxb_4rp_4t3d);
-- 
2.34.1

