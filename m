Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F94C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 20:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3M13-0007S8-I4; Sat, 04 May 2024 16:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0r-0007MM-DK
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:42 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0p-0005WD-Fe
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714854578;
 bh=7hQjZuTzsym0fJcq9f9wiRPViw9PtWDp0tZMJQ+M5NU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DBf0MgV6xlu03ts0L2ukv8lP4lu8FQJzhETswe9B6lXzCgyOToFn+6jkBf46yV83t
 HaXLvNZLm9GCSARKLGIGeVc00H5RKnsiPJZNUi6xNO2yW3HmEzbz49VVY4LbhrDFtG
 6dhRbNjtb8g62ih0/NsFD/Vs4Xj0HeBl5GJTId+xeac+P9Kkpd8viABK6Y7yTo90l1
 Oa8th2UCAwY4G5PYa3QWNNOkBgp13fTFBIINvTWXC8fcQ9TczmEf7ANWi6xaRduFII
 KgH5pRBVhM/xSWTl4syb1mvAsOMKshBx7mJ3Ixfoz3yuTmOojz95aie/l4/NlDJwvL
 4W7YDCoPwfysA==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 49493378216C;
 Sat,  4 May 2024 20:29:36 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
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
Subject: [PATCH v10 04/10] virtio-gpu: Don't require udmabuf when blobs and
 virgl are enabled
Date: Sat,  4 May 2024 23:28:28 +0300
Message-ID: <20240504202834.399780-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ae831b6b3e3e..dac272ecadb1 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1472,6 +1472,7 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
         if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
+            !virtio_gpu_virgl_enabled(g->parent_obj.conf) &&
             !virtio_gpu_have_udmabuf()) {
             error_setg(errp, "need rutabaga or udmabuf for blob resources");
             return;
-- 
2.44.0


