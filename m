Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12090C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvALC-0004zG-If; Thu, 20 Mar 2025 03:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweishi@kylinos.cn>)
 id 1tvAKw-0004xc-3z
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:29:08 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweishi@kylinos.cn>)
 id 1tvAKt-00038v-2S
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:29:05 -0400
X-UUID: f7176376055c11f0a216b1d71e6e1362-20250320
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:a34754b4-b64a-4f52-b562-818a80989b75, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:6493067, CLOUDID:8356fa7c2c868dbf5c4a8f77e8ab9c89,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
 :0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
 R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f7176376055c11f0a216b1d71e6e1362-20250320
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
 (envelope-from <liweishi@kylinos.cn>) (Generic MTA)
 with ESMTP id 1235900969; Thu, 20 Mar 2025 15:28:48 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
 by mail.kylinos.cn (NSMail) with SMTP id AC6AFE008903;
 Thu, 20 Mar 2025 15:28:48 +0800 (CST)
X-ns-mid: postfix-67DBC3B0-497983691
Received: from localhost.localdomain (unknown [10.42.12.187])
 by mail.kylinos.cn (NSMail) with ESMTPA id 429F9E008902;
 Thu, 20 Mar 2025 15:28:47 +0800 (CST)
From: liweishi@kylinos.cn
To: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Huang Rui <ray.huang@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Weishi Li <liweishi@kylinos.cn>
Subject: [PATCH] virtio-gpu-virgl: fix a bug in context create
Date: Thu, 20 Mar 2025 15:28:34 +0800
Message-Id: <20250320072834.173759-1-liweishi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=124.126.103.232; envelope-from=liweishi@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Weishi Li <liweishi@kylinos.cn>

When VIRGL_VERSION_MAJOR<1, virtio_gpu_context_init_enabled
will always return false, causing virgl_cmd_context_create
to always return error. Therefore, it is necessary to also
include the virtio_gpu_context_init_enabled segment in the
VIRGL_VERSION_MAJOR judgment to ensure that context create
can also succeed when VIRGL_VERSION-MAJOR<1

Signed-off-by: Weishi Li <liweishi@kylinos.cn>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
index 145a0b3879..48f6121e16 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -338,6 +338,7 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
                                     cc.debug_name);
=20
     if (cc.context_init) {
+#if VIRGL_VERSION_MAJOR >=3D 1
         if (!virtio_gpu_context_init_enabled(g->parent_obj.conf)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: context_init disabled",
                           __func__);
@@ -345,7 +346,6 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
             return;
         }
=20
-#if VIRGL_VERSION_MAJOR >=3D 1
         virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
                                                  cc.context_init,
                                                  cc.nlen,
--=20
2.25.1


