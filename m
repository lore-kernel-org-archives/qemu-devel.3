Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DAAC561E6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKnK-0007jb-5H; Tue, 04 Aug 2026 15:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKnB-0007Zi-FA
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKn9-0005E8-Mx
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNWmILZwFWSVOBT+K3q1P++MAHNFRvmHfS+/HStvrNI=;
 b=btWmnD76AfUcc5xMNiXP7IeuDEF0hxZhFepOY3T8r49xQ6Ao08qjhLqJLNQVsh4lbgoNlV
 vc8AimTzMpxcAI3E8yZC3Sx1XxV83pL8EYlgnqA2kvg4px75BQAX6qSE2KgpsuvUUjAeKV
 3dj1iYhx3Vi4OaSRtVvbuabtA3S81/k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-KsC5UmLBP0CactbRIayPNw-1; Tue,
 04 Aug 2026 15:26:52 -0400
X-MC-Unique: KsC5UmLBP0CactbRIayPNw-1
X-Mimecast-MFC-AGG-ID: KsC5UmLBP0CactbRIayPNw_1785871611
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F028318002E6; Tue,  4 Aug 2026 19:26:50 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0C3830001B9; Tue,  4 Aug 2026 19:26:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 23:21:53 +0400
Subject: [GIT PULL v2 6/9] virtio-gpu: reject requests with short/truncated
 control headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v2-6-70e8fe489c9e@redhat.com>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4438;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Jvo9QYSq6zsmJiKDJ8EM3lJlgrmnG9EU88vt9eYApWc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzUSzRdq2xcbpcFflA5eI9OK84C3Gz0Z/w+v
 dFZ+gDQvHSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI81AAKCRDa6OEJdZac
 5fYoD/9E9Zu553vTJ6AtlekbQ2q1fZz/bMlJ/bap3e/M0u/Fc6JGIltjqcLzSOFQD1UsXhD0E5Z
 v5BWAdsrEm7HozPfKOFrcO/An+25NooUputFjL/onmoJCnRIT3/4CEOtkFtLXksIcjrbUyu+8Cf
 qnozHwPaItuqqhbcXLFhFnawF/MsUJ/AFtENcgstp7LnnRhsokAO1kyNx3sQH/RIhkmyuSP2tqe
 MqARGMtw1BKDGZxYX9ceLyCqAMUxK7pIVdU7GpLZWl6paEPqOQZSubbJMPkfBuXhIo8OMe8Em9Z
 S86ffE0CqA9PWbFw3OehIH9Qmmtcxj8uy2SNkVWcgduNi/gsqCsBC7j7I4CrXlmQ80uP+MPkMU9
 kSw0+6aNRpSXGY1oFKnIs+kjYOU357FMinznBXHZarBWu1U9MDcGYU9S+QyxVildtw/8lj9by6r
 VaBNvYrA1Azan/rdLd0DcRz/GNayUuy+unvRwyvsfJqG6ETqBErF5NdHKWA3eq1qsko5n3ORoWa
 es8iBLtCRhphA8YEuAXPYS8Brhr2NTzwxw+ymlcKIEwyuQYdDbPKSumlobUSn9dcbcE1w1h7iK/
 3gvxTWy52QrWve6M1y1b2zEJTP8w++CreOiJZnZtOXq5vAB4U/5PFreEKB9FrmikRUte5KrZrOz
 kDW09ELB8MyWWVA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
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
---
 contrib/vhost-user-gpu/vugpu.h          |  1 +
 include/hw/virtio/virtio-gpu.h          |  3 +++
 contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++---------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index 2374eb90cb9b..aaf2870cb24d 100644
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
index 2f60c72078b3..f965defa6b25 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -315,6 +315,9 @@ struct VirtIOGPURutabaga {
             qemu_log_mask(LOG_GUEST_ERROR,                              \
                           "%s: command size incorrect %zu vs %zu\n",    \
                           __func__, virtiogpufillcmd_s_, sizeof(out));  \
+            memset(&out, 0, sizeof(out));                               \
+            virtio_gpu_ctrl_response_nodata(                            \
+                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);         \
             return;                                                     \
         }                                                               \
     } while (0)
diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index ee9858c397ce..786488150932 100644
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

-- 
2.55.0


