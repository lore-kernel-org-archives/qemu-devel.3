Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B14FD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 23:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQDRu-0002Xc-4q; Mon, 01 Dec 2025 18:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vQDRh-0002Uk-2w
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 18:36:43 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vQDRf-0004Xm-K7
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 18:36:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764632180; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VljJdM/dckJFOq1tW1OHLb7h6gbMQUk+3L8qbQnLmC9pMaf9vUHxpDzd1uqPmlvDi8CR9H3VgyP5JVRGD+ZMOjx2Z8Smk9MPXtPCqYf8f2MAXWQ0FcGbtXucbbYgr0lqkWf1pEeonYMFe3/xwKLPlJtKhhmQERvtC1B7vvYLRPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764632180;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AYFRVDCKoVpb6ooIGe9Qz6mLyM80Vp+eLcGhnTdce88=; 
 b=kmqPNpcB8vqF2XSY3e9ocFCIWgWJu+AT5oQg7eczofSdRFeIkGlPs5gw8Zr8jb+wDk7gykejJAoRN1pS5OX9xCf44U5ecN3Cr5NjjBttbPzuu8DATTslRJlyd+aXgmvUyA2BPp58W0W4N2BoB5FWJ5qdycREFtVlQ6ku0qG/1fQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764632180; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=AYFRVDCKoVpb6ooIGe9Qz6mLyM80Vp+eLcGhnTdce88=;
 b=aZ4jI4LhxBHNnhtgiaoOcZ7ywictuwzutuxA1NT8qoCmRzk2Y9t7B+P3LJwvulwv
 /wZyXYZ98h4eerGE283QnPahmVpqhExXpYa6pCiQI/y6Wo2Phsb/gasJONnFqrzu+/u
 tXZ7v0jjRGMExmFWVSmGi1lXbutFfGOfIt8jdAZg=
Received: by mx.zohomail.com with SMTPS id 1764632177390415.2729731986384;
 Mon, 1 Dec 2025 15:36:17 -0800 (PST)
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
Subject: [RFC PATCH v6 2/4] virtio-gpu: Validate hostmem mapping offset
Date: Tue,  2 Dec 2025 02:34:45 +0300
Message-ID: <20251201233447.2218728-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201233447.2218728-1-dmitry.osipenko@collabora.com>
References: <20251201233447.2218728-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Check hostmem mapping boundaries originated from guest.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index a6860f63b563..6a2aac0b6e5c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -767,6 +767,7 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
     struct virtio_gpu_resource_map_blob mblob;
     struct virtio_gpu_virgl_resource *res;
     struct virtio_gpu_resp_map_info resp;
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
     int ret;
 
     VIRTIO_GPU_FILL_CMD(mblob);
@@ -780,6 +781,15 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
         return;
     }
 
+    if (mblob.offset + res->base.blob_size > b->conf.hostmem ||
+        mblob.offset + res->base.blob_size < mblob.offset) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to map virgl resource: invalid offset\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     ret = virtio_gpu_virgl_map_resource_blob(g, res, mblob.offset);
     if (ret) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-- 
2.51.1


