Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E39EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8oV-0006NB-Nh; Wed, 12 Aug 2026 09:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ke-0003Vg-Vc; Wed, 12 Aug 2026 09:12:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kb-0006L8-QY; Wed, 12 Aug 2026 09:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=4/UzLkysQzyYLqGqZVBFyzCw1aseDfeIxsziEJjsPvM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QzbOioWSoOoJxKbDVo5CmcDysDgEX5exJyCDaaB2UgwVI0+uGxLljK7mFj79lTJAV
 6yRtNMNEQ7EN59jPU3+w3pcvBJiz0ufwHRO6D2AAnPy5+0/vNtSmzLB6JYIlgBv1Vt
 vug91tBp0QTvfjmSMyctx0IZnsRJRD95gkjb9P4UsjX3MvcYeEBpZBTrY53iTzQLnW
 8WTRgZODMliB/G9hkFrS3tNNDcetkBpnGOxbinUVu5MMd+c/BWscFu8P3kBlWAbeNa
 tAl45Xs6FjlqPxBrBa1ZZqsRoLnqyl502LuZr9ztHPM9LHPJEPfDLsuh2Ch/cgitdT
 8q2zfZs2U1a3g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B5A7C1CA4DB;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EB9EA409BBE;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C1BD32F94C; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ankur Saini <ankur98saini@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 092/102] virtio-gpu: reject requests with
 short/truncated control headers
Date: Wed, 12 Aug 2026 16:02:07 +0300
Message-ID: <20260812130233.621965-92-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ankur Saini <ankur98saini@gmail.com>

A short control request can leave command data partially initialized.
For the common header, guest-controlled flags can then cause stale fence
metadata to be returned to the guest.

The command fill helpers detect a short copy but only log and return.
For the common header this leaves the request without any completion;
for type-specific commands the caller still completes the request but
reports VIRTIO_GPU_RESP_OK_NODATA, masking the error. Make
VIRTIO_GPU_FILL_CMD() clear the partially copied object and complete the
request with ERR_INVALID_PARAMETER. Make VUGPU_FILL_CMD() report the same
error through the existing vhost-user-gpu dispatcher. This also rejects
truncated type-specific commands.

The vhost-user-gpu common header is copied outside VUGPU_FILL_CMD(), so
clear it and complete the request directly when that copy is short.

Fixes: CVE-2026-18054
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
Reported-by: Ankur Saini <ankur98saini@gmail.com>
Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803-virtio-gpu-short-header-v3-1-936c1daa8e61@gmail.com>
(cherry picked from commit 1f24066fc88d33455ee54a20f29994d9e69997ba)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index ee9858c397c..78648815093 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -930,16 +930,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)
         if (len != sizeof(cmd->cmd_hdr)) {
             g_warning("%s: command size incorrect %zu vs %zu\n",
                       __func__, len, sizeof(cmd->cmd_hdr));
-        }
-
-        virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
-        g_debug("%d %s\n", cmd->cmd_hdr.type,
-                vg_cmd_to_string(cmd->cmd_hdr.type));
-
-        if (vg->virgl) {
-            vg_virgl_process_cmd(vg, cmd);
+            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
+            vg_ctrl_response_nodata(
+                vg, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
         } else {
-            vg_process_cmd(vg, cmd);
+            virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
+            g_debug("%d %s\n", cmd->cmd_hdr.type,
+                    vg_cmd_to_string(cmd->cmd_hdr.type));
+
+            if (vg->virgl) {
+                vg_virgl_process_cmd(vg, cmd);
+            } else {
+                vg_process_cmd(vg, cmd);
+            }
         }
 
         if (cmd->state != VG_CMD_STATE_FINISHED) {
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index 2374eb90cb9..aaf2870cb24 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -179,6 +179,7 @@ struct virtio_gpu_ctrl_command {
         if (vugpufillcmd_s_ != sizeof(out)) {                   \
             g_critical("%s: command size incorrect %zu vs %zu", \
                        __func__, vugpufillcmd_s_, sizeof(out)); \
+            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER; \
             return;                                             \
         }                                                       \
     } while (0)
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 9ee0737d9df..7f4dd42ff65 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -296,6 +296,9 @@ struct VirtIOGPURutabaga {
             qemu_log_mask(LOG_GUEST_ERROR,                              \
                           "%s: command size incorrect %zu vs %zu\n",    \
                           __func__, virtiogpufillcmd_s_, sizeof(out));  \
+            memset(&out, 0, sizeof(out));                               \
+            virtio_gpu_ctrl_response_nodata(                            \
+                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);         \
             return;                                                     \
         }                                                               \
     } while (0)
-- 
2.47.3


