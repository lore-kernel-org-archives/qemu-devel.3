Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E414C5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKpH-0000QE-1C; Mon, 27 Jul 2026 08:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKog-0008OU-95
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKod-0004Yc-3Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785156738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7SISsmVC5DR6jth9n1yAMQHhAe2WBmhf9WFDEyh/gg=;
 b=dI58eBO4STwDrxsYnvZ7M4ES/AWHgdkuGJFEXIczXq5JHA+exSIF04K9L1AgBXs9iAUSK3
 5wSxAjmAGxuWcNXIkcek/+dykQNygTIbgK/0MIJwHLCCKZgXK++bqXHMVVArxck93sahvY
 2ufBkJpse0Gi8k7GfUVf/W2uxzzSOZE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-XaXgClkwOy-mJRJJxr3GXg-1; Mon,
 27 Jul 2026 08:52:15 -0400
X-MC-Unique: XaXgClkwOy-mJRJJxr3GXg-1
X-Mimecast-MFC-AGG-ID: XaXgClkwOy-mJRJJxr3GXg_1785156734
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E007E1801A32; Mon, 27 Jul 2026 12:52:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.178])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58B0E1955F1F; Mon, 27 Jul 2026 12:52:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Feifan Qian <bea1e@proton.me>,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PULL 1/5] hw/cxl: Validate Set Feature payload bounds
Date: Mon, 27 Jul 2026 14:52:03 +0200
Message-ID: <20260727125207.646148-2-thuth@redhat.com>
In-Reply-To: <20260727125207.646148-1-thuth@redhat.com>
References: <20260727125207.646148-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/cxl/cxl-mailbox-utils.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 20e0b7e476e..ec18338b423 100644
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
2.55.0


