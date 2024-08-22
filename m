Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE534C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCws-0000mj-5e; Thu, 22 Aug 2024 14:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwq-0000Vt-TJ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:16 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwp-00049E-2w
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724352840; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZUOB1T3gCbhg+duf9CudkjxgkFopsMn8Z7Ew8AaUUGxeSD1gIDDebqMpdFrUjxOSznjXG5r4tlVtLXRFf8OOvmxVSebSh2hv17XblDYKrVk+5MbLxw7b+8umn+TxLU3qoRNJuogVFo9zkcgJ+zKbhdZnv8FF1qMeAr336gqclSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724352840;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ap8P/zbrScy+lnoMzkTzbFmuJHrSIe0PxDMWd9b5lXg=; 
 b=SYjG7vVGyGgeYf0c9EkvEOTHszUdkWSSWwzxxpV+MdDXuHXxahkIVxMLl1w1qcanEzE3hWig5nsXcRXOE2Lh/hvi9PHsyAIyxmqYgfSBjNxZ+9dTMtBm62pmNuGEZ+QXSWAXHxmddvvbOsouBNc01tTywy1izNC2MS0qniKDQYI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724352840; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ap8P/zbrScy+lnoMzkTzbFmuJHrSIe0PxDMWd9b5lXg=;
 b=HBvCUV2WdAKcesBAbLGYlt/FKajxAfUiqirfj0jPhSWeiBOnaTU+VhjP/fVWwR6u
 UGm5NjN+bqxGGHftjOR9FAMVHtG+HsSCUDdKxKk9dEIuwCNEIt5PrmXW+lBG+JtBIl8
 uMujzfnqRy4XONS3RisQIU/MMNculNnzuICqVaTQ=
Received: by mx.zohomail.com with SMTPS id 1724352837858643.7842343988855;
 Thu, 22 Aug 2024 11:53:57 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v17 08/13] virtio-gpu: Don't require udmabuf when blobs and
 virgl are enabled
Date: Thu, 22 Aug 2024 21:51:04 +0300
Message-ID: <20240822185110.1757429-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
References: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The udmabuf usage is mandatory when virgl is disabled and blobs feature
enabled in the Qemu machine configuration. If virgl and blobs are enabled,
then udmabuf requirement is optional. Since udmabuf isn't widely supported
by a popular Linux distros today, let's relax the udmabuf requirement for
blobs=on,virgl=on. Now, a full-featured virtio-gpu acceleration is
available to Qemu users without a need to have udmabuf available in the
system.

Reviewed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 60dfed87765b..24608338d7ea 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1484,6 +1484,7 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
         if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
+            !virtio_gpu_virgl_enabled(g->parent_obj.conf) &&
             !virtio_gpu_have_udmabuf()) {
             error_setg(errp, "need rutabaga or udmabuf for blob resources");
             return;
-- 
2.45.2


