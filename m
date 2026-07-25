Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63E1C531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnWYl-0000k9-5M; Sat, 25 Jul 2026 03:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWYi-0000jq-6F
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:12:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWYf-0002Gz-K7
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:12:31 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66P7C23l072763
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 25 Jul 2026 16:12:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=if5f7jn2I7w1WOmuUv3QOszyqkb7Uy0wStq+5e7Oy9M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784963534; v=1;
 b=LywWu0WnO7Fa1nKLG/jKbNUb5Wie8e7gFKqN/YERDQFnqmbiCz3EEEImz632Eds2
 RBDj2a8D5dMnsrINExeWqST+oy7r2NrkP5IdjwfAU+Yl7eG8xDfLJy1+6/AMeYvl
 EfAfGEeESNis6QFL/tcg/ii5kvlyQ526pSBruVFK3C3ttliaTutnOv3KwIjdykuj
 kHzXT/lRsJrMiEje+nktw8P854kY2dTYT9Ws942XRx4XKA4rbWpFnFzmN+63Y4GH
 J/pukXmFO3t09eA6nYy4jb2/9D4yHoQoZJqiph5+ihcFnxxvtvzuodPZD3DEOvsi
 lPRAQjo5SyO6CLB5DS4+Eg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 25 Jul 2026 16:11:46 +0900
Subject: [PATCH] hw/display/virtio-gpu: Initialize blob mapping for
 ATTACH_BACKING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-backing-v1-1-5b584bf7df5a@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubaa5RCvIhfbHBxqtCEl7264/
 NX/+y4I5JkC1MkFng4OvLiILE3AjtoNJLiLBiVVIUuFwmg7sxtEZyQVFWaYI0KsV089n99T0/4
 Ou5nIbu8c7vsBwQeeH2sAAAA=
X-Change-ID: 20260725-backing-db0e69515455
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=ttMnjC0G0IvKCP2wzyNssFK2QHqXl0euTuhrzM+XINY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZK4tkDdWKf2n+cdk6buCrBPN+ncsedan3WIGvG8IU8P
 6LWfX/aUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJHLRxgZvs/TUyr69fej+NuM
 BbY3M06ZzZtz7HxMjP6XzzJ9SgWJ6gz/nYvPRujuW8887+21Xva1j78ca3d/JBGrcHlKYvfcM/c
 ucwIA
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

It is necessary for blob cursor and scanout.

Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 718ba3039290..e886298ec42f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -984,6 +984,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
+
+    if (!res->image) {
+        virtio_gpu_init_udmabuf(res);
+    }
 }
 
 static void

---
base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
change-id: 20260725-backing-db0e69515455

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


