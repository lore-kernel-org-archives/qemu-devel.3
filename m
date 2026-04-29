Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E38FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI4Ib-0003tU-GI; Wed, 29 Apr 2026 08:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wI42C-0000We-CN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:28:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wI42A-00044O-84
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:28:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b7adb38d65so61685855ad.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 05:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777465732; x=1778070532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5eMx0iBuYl2OSxD/RccAMVzR1/aIPsHq+RnfmrGkecI=;
 b=c0empiY/r8PfCWgEWHciPoGBvgPUHMgMC8/LJXULThKxw/h8ag/jo8TsMe1aKoWB4m
 EWkaVAfh9EMAYs+pG+IqWk8heq91yguvIP0t5UdpkIFYmCr5XBbYCS2X37LT2h6X+24E
 B+EV9aaYV4MT+ErVhwFh3N1YRd0asTsCsovQ1fSQV2oeQSevvX2KcKOgXlonixgK4Mjf
 ux5plYI8l0Hihd7Vk3naC0+V/0hNJxLyWVyV6XAlcUbwigBCFbTeCLXdDJ657H6yIDm4
 JIzAGua7XYJL/fa+TUTkkEgGjA+8F8Vgh4ZAGjfMMYDlmty1l0l6UxV094kpzyfJ2ckx
 LhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777465732; x=1778070532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eMx0iBuYl2OSxD/RccAMVzR1/aIPsHq+RnfmrGkecI=;
 b=DiWr53XWfEzkrLRBoygs17GhG9xY/1A6or7jfgi7p1T5rs8lT+kn23G9yCzUg7l5uz
 qrfdfEDV3Zo0696FaeuZmFddalVZZl4/ad873rLWuUkfvHU1cyLcEhpxbqp9nn2kn6MF
 iE9iO0KV1isK/iA6YJkuPfiVB7LKsMui1HvfCa+wVJ7YeEm7JkxV3iJjLx5vXG404FFu
 kJjJt136Ddf+Z3/DsQ7PXj+mOWDrlPy8Zk1ZznkmiCUIpdHFYQn1c5EM/1lx/vepqFTW
 8q07c1YteRAJ9pXr2hISUH4IO093+2IjNu38jfVK8hLRU78vuekup0VZWYGlEacBC+8v
 0obg==
X-Gm-Message-State: AOJu0Yw6/SqTFBGxucVy1JBjpbVzKeXpp+A/bt52ZB75YiNvg19Bbaig
 YLZn3GQSiP2elDK/LxUU3dk0bThy/T63hQO6gpP2kPzU9R6g0RCjnVi1Jki436IZZy+FuA==
X-Gm-Gg: AeBDievIsF9dZWANCuRFcDQZ6qiuBXHEuuGdDKPlXrh1ERGFnjeCGG1FHAfw+km5GCo
 iiu5umRCo0Eul2DU2JYZvdk6sPoeNK/7O+yprvlqh5QTCwezY9HUbIZGS/l2om86oq6/o1NtRDW
 JpweZhHRhK6YRQCW5DQDtBjuNYdzoBNxGe8T2vnPDAbdsWz2bqTN18gqtquBHDX29eVEtwwzwHN
 cIBkJabtCtmaQGC1UYZZEb8P5Vyuu5LW7VmE3v6NLWIrBQ5Z9lFIRXaBwzw5OJJ5g7I9BgTJI9n
 borqlxUDp8q67R+lCd0qfCFAQNdzxHZCiFQpIk6147XJcYsjKR9E2LZPHZKJrxJ/qVq2135Nkdh
 8Kp8D1ckeUD/+BSiMtiS5GqVe+dOFJtPiAVGqwhjZ+YgkAG0Z7mGh3SWSKZJYlDunwLf/BJeH8P
 XzDVvrfqHUowNhGJrp4lOO6NcMgKGuGQ==
X-Received: by 2002:a17:903:2acc:b0:2b2:4cd2:e162 with SMTP id
 d9443c01a7336-2b97c48d869mr71975645ad.34.1777465731581; 
 Wed, 29 Apr 2026 05:28:51 -0700 (PDT)
Received: from jia.. ([114.249.134.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772e9csm21079935ad.9.2026.04.29.05.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 05:28:51 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, fan.ni@samsung.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH] hw/cxl: bound remaining Set Feature writes
Date: Wed, 29 Apr 2026 20:28:45 +0800
Message-Id: <20260429122845.2119072-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=physicalmtea@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 08:45:51 -0400
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

Apply the same offset + length validation to soft_ppr,
hard_ppr, cacheline_sparing, row_sparing, bank_sparing, and
rank_sparing so oversized requests fail with
CXL_MBOX_INVALID_PAYLOAD_LENGTH instead of overflowing the
write-attribute buffers.

Add a qtest covering the rank_sparing path.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3458
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 20 ++++++++
 tests/qtest/cxl-test.c     | 99 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..ce139e30eb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1713,6 +1713,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
+    uint32_t end_offset;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
     uint16_t count;
@@ -1746,6 +1747,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     set_feat_info->data_transfer_flag = data_transfer_flag;
     set_feat_info->data_offset = hdr->offset;
     bytes_to_copy = len_in - sizeof(CXLSetFeatureInHeader);
+    end_offset = (uint32_t)hdr->offset + bytes_to_copy;
 
     if (bytes_to_copy == 0) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
@@ -1813,6 +1815,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if (end_offset > sizeof(ct3d->soft_ppr_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
                sppr_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1832,6 +1837,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if (end_offset > sizeof(ct3d->hard_ppr_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
                hppr_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1851,6 +1859,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if (end_offset > sizeof(ct3d->cacheline_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1869,6 +1880,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if (end_offset > sizeof(ct3d->row_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1887,6 +1901,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if (end_offset > sizeof(ct3d->bank_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1905,6 +1922,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if (end_offset > sizeof(ct3d->rank_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
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


