Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE283C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCwf-0007pR-Px; Thu, 22 Aug 2024 14:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwb-0007S3-9X
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:03 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwZ-00048Q-Lz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724352823; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AHLfMZLvb03sfgj9P19Tmb7JPZRffI8SKmA2UVL2mRLvzuo6dZ03zEAzD3wt1/U9RT/5kZMWmWn0GUQHrjKk+1B08ysESxsm+CvfVeBOHDiGlbTnnukMWMcvA23MKKB1vW3rAmQiDF3CsnBkdQmYqBEv1lZkDbdMBXkkO4EZff0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724352823;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tyc7lt5VwRovwqeWfLOnuITm4aMpWI+z2Qm/hAOBHsM=; 
 b=Nlch0oJmIkAnR40RFh7qhPsSCQ9EBpkhTUf9e09D7NUoyN16EBY9jARPuhnLHUu+XRqQVdgkUksZTqT1MIRpB8ftWXqNwvUC6prD6sluAlio7cXODPTsFlIprT76n4PPUVPTBAEwyrDKAlPoy7EtyGx0OBYHpPDmzfCeGf2x+D4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724352823; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=tyc7lt5VwRovwqeWfLOnuITm4aMpWI+z2Qm/hAOBHsM=;
 b=WpBe4YSlLfQE0h4RJY5gNkh04CppbefgmVXJ4PUlsQfY/ePD2HaXsc0Yz/7ohGwt
 LdkkkM6U1aa0r/TPpA2uuHbHDen4ZYf2ag9sCkn0sOSAO4ZvSq8lp44DnQpZLQnIqWN
 wXeAfP6GRlrFjqasLQZkYBA2ncR9mRtJ0ZGg3JDY=
Received: by mx.zohomail.com with SMTPS id 1724352823124556.414450950701;
 Thu, 22 Aug 2024 11:53:43 -0700 (PDT)
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
Subject: [PATCH v17 06/13] virtio-gpu: Use pkgconfig version to decide which
 virgl features are available
Date: Thu, 22 Aug 2024 21:51:02 +0300
Message-ID: <20240822185110.1757429-7-dmitry.osipenko@collabora.com>
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

New virglrerenderer features were stabilized with release of v1.0.0.
Presence of symbols in virglrenderer.h doesn't guarantee ABI compatibility
with pre-release development versions of libvirglerender. Use virglrenderer
version to decide reliably which virgl features are available.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 meson.build                   | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index a63d1f540f04..ca6f4d6cbb58 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -171,7 +171,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
         struct virgl_renderer_resource_info info;
         void *d3d_tex2d = NULL;
 
-#ifdef HAVE_VIRGL_D3D_INFO_EXT
+#if VIRGL_VERSION_MAJOR >= 1
         struct virgl_renderer_resource_info_ext ext;
         memset(&ext, 0, sizeof(ext));
         ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
diff --git a/meson.build b/meson.build
index fbda17c987e2..8bc7ee47da2c 100644
--- a/meson.build
+++ b/meson.build
@@ -2388,10 +2388,7 @@ config_host_data.set('CONFIG_VNC', vnc.found())
 config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 if virgl.found()
-  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT',
-                       cc.has_member('struct virgl_renderer_resource_info_ext', 'd3d_tex2d',
-                                     prefix: '#include <virglrenderer.h>',
-                                     dependencies: virgl))
+  config_host_data.set('VIRGL_VERSION_MAJOR', virgl.version().split('.')[0])
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
-- 
2.45.2


