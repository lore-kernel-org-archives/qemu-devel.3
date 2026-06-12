Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D61CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY3xZ-0005JK-Uh; Fri, 12 Jun 2026 11:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bea1e@proton.me>) id 1wY3xU-0005GT-Tu
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:38:13 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bea1e@proton.me>) id 1wY3xR-00024h-F1
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1781278680; x=1781537880;
 bh=L7PcrWyepfXUOm7T87FgfiufUdTrrkrZsVvBXSpMJ0I=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Vuq9yaMoBrS9YEfmVrqvUD1+AqN2IgF4YKTTTJ9RbL77Pa5RR9r6u23vHQLtICk+V
 5uD6RpNg9Doa20EXypd3/7H3wQI3RMa4JR2XHTnrJfe9JcElwwaEpybnrLEcpmnaBT
 L/0RSzwfa0bgraQy7L/zmV/6pXEfR4eKQ+wsPYXdNEDba5YuKzV4/owxD85SltVWbB
 3/vmRIFLYUb5mDGgbr9u3q5ppTsDA3M2FdtnzfTBQS0kQUkMJlyDqWcAFwDnkLCyZt
 e4tw9L/p/Y0fmWQhw6NpXwV8AHwnxgpV250tbzLywaOjBzE9cwdt66TCDpPLtwm225
 MmM5PsCGBgtDQ==
Date: Fri, 12 Jun 2026 15:37:53 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Feifan Qian <bea1e@proton.me>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH] hw/cxl: Validate Set Feature payload bounds
Message-ID: <lRjjre9PPucf_bjrOAOLVko0OB0QYPcKJOBHmSHGG4xmSTNr2Y_dHzRiCT5BDRWfoPma6hC4iMdI4n6X5COoum79U7Kj1JgB1B7E703GOWA=@proton.me>
Feedback-ID: 93226294:user:proton
X-Pm-Message-ID: 5500746943177fbbe1ad09ae65f1bf8c4b558851
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249; envelope-from=bea1e@proton.me;
 helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Fixes: 5e5a86bab830 ("hw/cxl: Add support for Maintenance command and Post =
Package Repair (PPR)")
Fixes: da5cafdc4ddd ("hw/cxl: Add emulation for memory sparing control feat=
ure")
Signed-off-by: Feifan Qian <bea1e@proton.me>
---
This is submitted as a regular bug fix for the CXL non-virtualization
use case.

=C2=A0hw/cxl/cxl-mailbox-utils.c | 24 ++++++++++++++++++++++++
=C2=A01 file changed, 24 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..1724b09a6d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1813,6 +1813,10 @@ static CXLRetCode cmd_features_set_feature(const str=
uct cxl_cmd *cmd,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_UNSUPPORTED=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((uint32_t)hdr->offset + bytes_to_copy >
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(ct3d->soft_ppr_wr_attrs))=
 {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_INVALID_PAYLOAD_=
LENGTH;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((uint8_t *)&ct3d->soft_ppr_wr_attr=
s + hdr->offset,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sppr_write_attrs, b=
ytes_to_copy);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_feat_info->data_size +=3D bytes_to_co=
py;
@@ -1832,6 +1836,10 @@ static CXLRetCode cmd_features_set_feature(const str=
uct cxl_cmd *cmd,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_UNSUPPORTED=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((uint32_t)hdr->offset + bytes_to_copy >
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(ct3d->hard_ppr_wr_attrs))=
 {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_INVALID_PAYLOAD_=
LENGTH;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((uint8_t *)&ct3d->hard_ppr_wr_attr=
s + hdr->offset,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hppr_write_attrs, b=
ytes_to_copy);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_feat_info->data_size +=3D bytes_to_co=
py;
@@ -1851,6 +1859,10 @@ static CXLRetCode cmd_features_set_feature(const str=
uct cxl_cmd *cmd,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_UNSUPPORTED=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((uint32_t)hdr->offset + bytes_to_copy >
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(ct3d->cacheline_sparing_w=
r_attrs)) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_INVALID_PAYLOAD_=
LENGTH;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((uint8_t *)&ct3d->cacheline_sparin=
g_wr_attrs + hdr->offset,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_sparing_write_a=
ttrs, bytes_to_copy);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_feat_info->data_size +=3D bytes_to_co=
py;
@@ -1869,6 +1881,10 @@ static CXLRetCode cmd_features_set_feature(const str=
uct cxl_cmd *cmd,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_UNSUPPORTED=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((uint32_t)hdr->offset + bytes_to_copy >
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(ct3d->row_sparing_wr_attr=
s)) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_INVALID_PAYLOAD_=
LENGTH;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((uint8_t *)&ct3d->row_sparing_wr_a=
ttrs + hdr->offset,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_sparing_write_a=
ttrs, bytes_to_copy);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_feat_info->data_size +=3D bytes_to_co=
py;
@@ -1887,6 +1903,10 @@ static CXLRetCode cmd_features_set_feature(const str=
uct cxl_cmd *cmd,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_UNSUPPORTED=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((uint32_t)hdr->offset + bytes_to_copy >
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(ct3d->bank_sparing_wr_att=
rs)) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_INVALID_PAYLOAD_=
LENGTH;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((uint8_t *)&ct3d->bank_sparing_wr_=
attrs + hdr->offset,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_sparing_write_a=
ttrs, bytes_to_copy);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_feat_info->data_size +=3D bytes_to_co=
py;
@@ -1905,6 +1925,10 @@ static CXLRetCode cmd_features_set_feature(const str=
uct cxl_cmd *cmd,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_UNSUPPORTED=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((uint32_t)hdr->offset + bytes_to_copy >
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(ct3d->rank_sparing_wr_att=
rs)) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CXL_MBOX_INVALID_PAYLOAD_=
LENGTH;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((uint8_t *)&ct3d->rank_sparing_wr_=
attrs + hdr->offset,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_sparing_write_a=
ttrs, bytes_to_copy);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_feat_info->data_size +=3D bytes_to_co=
py;
--
2.43.0

