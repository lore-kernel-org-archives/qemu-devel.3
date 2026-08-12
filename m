Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0117AC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAM4-0001SO-Ln; Wed, 12 Aug 2026 10:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAJq-0006CQ-AQ; Wed, 12 Aug 2026 10:52:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAJo-000726-Ku; Wed, 12 Aug 2026 10:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=GxBvZdmNVw+XexaoMHeYdEt3/A2z0Tke7tfsJiyWlGI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hFQU818m3cJCo5DT3EfuXV1cCBz+nEkEALMe3OPvG4gUatBE/UuYaoings5N/D+yJ
 bJgGrXuaEJdDy4YQqG2a0yJUJWJfi4IWNFb97vi6NKdPnEtpuOuH3yR6YCYoy9rj68
 kjCIZNjFRHNtMj5uuNT2mDXnPB2pCV+LC3UnJw9oVt5My500Zc9SZnMfbj0ocoAsqe
 GVUchqtB/U7uA/Vg4fJja35TKO0fr5dG/2ELPJmBVLO4B8026eRTxUz7D4MLQRd4Qe
 DW5dq22kJ/a/KTzI+om9RQO676b3E+oWkKYQtbdEY2OY4jok1kWItcqDwedlCA6oPR
 7lhA96SVEApTQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 654191CA61E;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BF94D409D5D;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 283352F997; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Feifan Qian <bea1e@proton.me>,
 Thomas Huth <thuth@redhat.com>, Jia Jia <physicalmtea@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 026/120] hw/cxl: Validate Set Feature payload bounds
Date: Wed, 12 Aug 2026 17:48:09 +0300
Message-ID: <20260812144955.649205-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Feifan Qian <bea1e@proton.me>

cmd_features_set_feature() derives bytes_to_copy from the mailbox input
length and uses hdr->offset as the destination offset into per-feature
write attribute buffers.

The patrol scrub and ECS paths already reject writes where hdr->offset
plus bytes_to_copy exceeds the destination structure. Add the same check
to the soft PPR, hard PPR and memory sparing feature paths before
copying into their write attribute buffers.

Without the check, a malformed Set Feature request can write past the
selected write attribute object and corrupt adjacent CXL type 3 device
state.

Fixes: 5e5a86bab830 ("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Fixes: da5cafdc4ddd ("hw/cxl: Add emulation for memory sparing control feature")
Signed-off-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3458
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit b71a179148ff49ed236cffb98af8891aeed94159)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e86252..1724b09a6dc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1813,6 +1813,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->soft_ppr_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
                sppr_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1832,6 +1836,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->hard_ppr_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
                hppr_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1851,6 +1859,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->cacheline_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1869,6 +1881,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->row_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1887,6 +1903,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->bank_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1905,6 +1925,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->rank_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
-- 
2.47.3


