Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53C7C5B543
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 13:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLjDm-000737-Ue; Sun, 01 Jun 2025 09:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uLjDR-0006g0-Ce
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 09:59:10 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uLjDP-00048z-Pl
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 09:59:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748786334; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XTw4dQioNEkORbMJXNEJeanWs9mVApmxHCzkMVj0UZpPMvO7shdwUidUDvbIlRayUihLXtgKdJvcZo/2DWCeMw/0xSlk8AwFSBWLamy8D1JRxnAWpyOcR2DK6cj7qvRIO6ccLIgXk/tCrR+JRvRriiD3d2VBtwxB+COSN8nw0Fc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748786334;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Lp9cqI4Ti85zNZGmypdLQP06ZhCb0glJ73YScOd9ajI=; 
 b=BsvDEILJzS+SZCKkyaaTKM0GA0PJ+H4NGQJ28RffONM6MVDDwEPE5XfbF1Es2qmBB8f+YZ+4v+Dsf/CwJgpvRgtzCUWYG7yhDUMm6I8FKPbG2/bcnv29V5F6wkNCLb1JJkUwvaCPg66Lve13NoJs8nD4+2XHs7WC4vby2k9KAY8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748786334; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Lp9cqI4Ti85zNZGmypdLQP06ZhCb0glJ73YScOd9ajI=;
 b=OPtYekj0gt19bUKexg3D35yYiAjEErHaRQtc0IUYFnZthrwEtwcLEUaiFssTNANb
 MyidLFzS+APq/wMHwlTvoSNbmOImF13IL6KmIuspuv9KPy9hPDxVY7rmlv4fsK9ubXQ
 iVOtkEV0oNvvs+Fs3kXsmVMn9jrD/M8Eu+YxerqM=
Received: by mx.zohomail.com with SMTPS id 1748786330546833.3142927966037;
 Sun, 1 Jun 2025 06:58:50 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v13 08/10] docs/system: virtio-gpu: Add link to Mesa VirGL doc
Date: Sun,  1 Jun 2025 16:57:07 +0300
Message-ID: <20250601135709.847395-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601135709.847395-1-dmitry.osipenko@collabora.com>
References: <20250601135709.847395-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Extend virtio-gpu documentation with a link to the Mesa VirGL
documentation.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio-gpu.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index f20c60016376..f8963c1f13cf 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -59,7 +59,7 @@ on typical modern Linux distributions.
 virtio-gpu virglrenderer
 ------------------------
 
-When using virgl accelerated graphics mode in the guest, OpenGL API calls
+When using `virgl`_ accelerated graphics mode in the guest, OpenGL API calls
 are translated into an intermediate representation (see `Gallium3D`_). The
 intermediate representation is communicated to the host and the
 `virglrenderer`_ library on the host translates the intermediate
@@ -68,6 +68,7 @@ representation back to OpenGL API calls.
 .. parsed-literal::
     -device virtio-gpu-gl
 
+.. _virgl: https://docs.mesa3d.org/drivers/virgl.html
 .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
 .. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
 
-- 
2.49.0


