Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF16C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnWa1-0001UO-Gt; Sat, 25 Jul 2026 03:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWZz-0001TO-Sx
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:13:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWZy-0002MS-4F
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:13:51 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66P7DdL4073060
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 25 Jul 2026 16:13:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=qvnRG6XZ1a67sXlfpkEnQXxN9+P0U7A3YZitAXNEJCw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784963624; v=1;
 b=JYzagT+osF/65HuPWTKuBWT5ReknQvQRYitNAp+3E9/oGILE1SZE9clT5L4YCHQS
 BFvqTuC/z+Vw8WYfI/p31WWMylJbAAtdypmQVn+UfPN+OWyOhcE1WmTen59u6dwG
 XSg47PR1LaggERgEeTxnVN1LtXBZ3ei36jq+HTLVz47jiXDCfhx/5zynOr0HR6jk
 M/v8O+z2XCJtqO4NnKy4sdi967cdQIL6hBmQZSDH9WA8Q4wuopuME+yFw81Lkp3H
 yVOflhfuppxxdIdYW2DFJknKVtyCby2bgNF0ApN+/UM+Fb1eZMWd99/dGVkQ07US
 Dbyrb/rdzOs6dwZ7RfqVIg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 25 Jul 2026 16:13:35 +0900
Subject: [PATCH] hw/display/virtio-gpu: Reject non-migratable large blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-blob-v1-1-f643fbd76398@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNT3aSc/CRdi0SzRMNEC1MzA8NEJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAEPhBPVoAAAA
X-Change-ID: 20260725-blob-8a6a1a85601a
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=+OIh1VzS35u+Naul3OrQ1LB36UCHyZtD7rdKxbCoFDM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZKkjrzhwvVohER26Sari0S/q03obRgp+ONf9x8NmVnD
 5WXedzsKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEhENsP/HLcKxz+Hkn5t1FGY
 wXB4c2KmsWXfRkv+6ndHV06zCvzqzMiwoT/6oKb2nn6WV1b3fHLvmtS0XmB79Dj/8GOWj7c17r5
 hAAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

The blob size is encoded as a 64-bit integer in the virtio protocol, but
it is encoded as a 32-bit integer in the migration stream, and
a large blob whose size cannot be expressed in a 32-bit integer will
be corrupted after migration. Deny creating such large blobs.

Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with blob=true"")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 718ba3039290..a5aa37aebd0e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -352,6 +352,14 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
+    if (cblob.size > UINT32_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: blob too large (%" PRIu64 "> %" PRIu32 ")\n",
+                      __func__, cblob.size, UINT32_MAX);
+        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
+
     if (virtio_gpu_find_resource(g, cblob.resource_id)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
                       __func__, cblob.resource_id);

---
base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
change-id: 20260725-blob-8a6a1a85601a

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


