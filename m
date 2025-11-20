Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6CFCF64B0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 04:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLvy2-00016X-Oq; Wed, 19 Nov 2025 23:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLvy0-00016G-G8
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 23:08:20 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLvxy-0000Zg-70
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 23:08:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763611681; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NItcsnjtu9U6/+0fF75VJTVj8qjzjkMYjk8tAdsjnEGYjg7yIt/rnTX9q3uxgtcHAbKYJr0mEWUQ8OBhKom5vGjQwL5SXgpYSAGgW4Mha6b9EtLtubrL9wH8BUzXVDVhIByxHlQu8EYW+9vd0HxA+LPYrLJOMVeCIy6K1nUbiWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763611681;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7C8gRUa8Zzst2hT4+buIpUk9rJ1iYU0M/DjnShh2d/Y=; 
 b=NedcQK/4/A2YqmXRAlAQ8X9s4Y6K0cGa6Gibd2iS12PgfS484kBWoYcvuwnLzLGum76HIYYOFG3Vgfz9yT0/tgOC0LpAnT8CWrUC/w48hfRMuoSyNM3nhuFUwxk5OXGRe/g/enKIX6RFFDJDsFT+w2U+2m4ooFWiuvgJ8JOA13I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763611681; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=7C8gRUa8Zzst2hT4+buIpUk9rJ1iYU0M/DjnShh2d/Y=;
 b=P1w+mmfSrNSemd3SRd0/NUIOxyfflzXs17ie3DfUqYGOP3OSOKrDIIFYD3wRILnu
 ERIwasxzZPWi7RzaUEQ7E2bcChBqhI1/y+u3wmv1gWnX/mVdJgWowLP5CKXFuFSDypS
 eczbJQfTLKKquUyt0KwCdc8P8+dq6QPSXbqIGrsU=
Received: by mx.zohomail.com with SMTPS id 1763611680130558.3001669036181;
 Wed, 19 Nov 2025 20:08:00 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
Subject: [RFC PATCH v3 3/7] virtio-gpu: Make
 virtio_gpu_virgl_unmap_resource_blob() return -1 on error
Date: Thu, 20 Nov 2025 07:06:28 +0300
Message-ID: <20251120040632.4036204-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
References: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make virtio_gpu_virgl_unmap_resource_blob() return -1 for more consistency
of error propagation style in the code, adhering to QEMU's devel/style
recommendations and preparing code for further code changes utilizing this
function.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index cf1da4b79626..bc22763cc931 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -199,7 +199,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: failed to unmap virgl resource: %s\n",
                           __func__, strerror(-ret));
-            return ret;
+            return -1;
         }
     } else {
         *cmd_suspended = true;
@@ -333,7 +333,7 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
     }
 
 #if VIRGL_VERSION_MAJOR >= 1
-    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)) {
+    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended) < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
@@ -820,7 +820,7 @@ static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
     }
 
     ret = virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended);
-    if (ret) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
-- 
2.51.1


