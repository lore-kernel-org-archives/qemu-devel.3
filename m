Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF75C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 20:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3M0v-0007Ni-PJ; Sat, 04 May 2024 16:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0n-0007LS-4o
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:38 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0k-0005VW-LW
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714854573;
 bh=Q+A8OMZ4/mG9hmoiAc1Asf43Kvissc9Z1oqpN0R0Ssg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QZxVAyXkxVhPGYhWvsW9uzlV4LBds9q1mHnCvyGUcnEX5PY4SzI9zsY7Knaa5G6iA
 EQt5xVLk0aSYOpvAk37pqva2AV4+YFkDJPw5pt3Jt2w+gUZUxSfUpqafdrojYQEh55
 4F+ctlGXNvMMfDJlCHwXztJMuNNjMwAJ3LcJMEihfRcxqVKrpkeMXZtPLqLYzEsV5A
 kzyjZ3o/GfnNXOXSpsUG0Tpx+hvRzYj93AIPDFoFkGPMhItxqu13EqW8D+MFCiTmkh
 lSD6ggcy1n7a4iSzqjMpzF16Jxbn2jXW4egCCibMxaOn25Hjs5w/vgIwEdnmBdJ765
 +/ucMMtO1oN1Q==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id A8FA2378215C;
 Sat,  4 May 2024 20:29:31 +0000 (UTC)
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
Subject: [PATCH v10 02/10] virtio-gpu: Use pkgconfig version to decide which
 virgl features are available
Date: Sat,  4 May 2024 23:28:26 +0300
Message-ID: <20240504202834.399780-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
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

New virglrerenderer features were stabilized with release of v1.0.0.
Presence of symbols in virglrenderer.h doesn't guarantee ABI compatibility
with pre-release development versions of libvirglerender. Use virglrenderer
version to decide reliably which virgl features are available.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 meson.build | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 5db2dbc12ec7..f4a4d71c1978 100644
--- a/meson.build
+++ b/meson.build
@@ -2286,11 +2286,8 @@ config_host_data.set('CONFIG_PNG', png.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
 config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
-if virgl.found()
-  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT',
-                       cc.has_member('struct virgl_renderer_resource_info_ext', 'd3d_tex2d',
-                                     prefix: '#include <virglrenderer.h>',
-                                     dependencies: virgl))
+if virgl.version().version_compare('>=1.0.0')
+  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
-- 
2.44.0


