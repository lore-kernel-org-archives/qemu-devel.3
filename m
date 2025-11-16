Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DA7CEBF61
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 12:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKcL3-0005PL-KE; Sun, 16 Nov 2025 07:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKcKy-0005NM-IZ
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 07:58:37 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKcKw-0000AM-SD
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 07:58:36 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763297899; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zn7if7IETeKzaghJer82n5v3OxfeV9skxhc74KWVScGD8Rc1pja80fsR6z3d2p+bHjA25uHxZiFYEbnw179oeiU2f9Lxnm6f4BsEtJjRpaCiwBYM/ZV/3kPX1c0ESxkWG9VirlyHRIcSpkXoWh1xqmGLx7+Nw8BKzsb/AlVuknQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763297899;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=moGEi+GhDC7kxHX63xr3v6wuLxdpQBtNuyukZeS38Pg=; 
 b=AtQQC5YChw6S0dvTglpB5PBc8gMTjySHEHOki+T0mUuH8Ibksy64TNHuTLGQfP9xxF6AvwJIqV3q54wKf3NmAhBukt2wHJNk6ChNpm7gVf5mjQYExMHsT3SKEbO3NnKLxyoBkMoUxBrPk2KDLOA+jrxqf8mwEJyVa1k5cYehtzc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763297899; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=moGEi+GhDC7kxHX63xr3v6wuLxdpQBtNuyukZeS38Pg=;
 b=C7rCyJl9iVSfFPfQ2Jpu902wnGFAEg1EvMt7oeJ9UFi7KTE95Dx7R87ZtH8bHwYQ
 SHUg32gTbdcfKB9Av4m8VPji1C/8K107bPib43bT033V+SE7mRf/vcttfs8C9q1xEyA
 WA6oDLdsnm1NT7CkeZhYA03dDDBABybxgfEVoU04=
Received: by mx.zohomail.com with SMTPS id 1763297896208166.35914614613296;
 Sun, 16 Nov 2025 04:58:16 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
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
Subject: [PATCH v16 08/10] docs/system: virtio-gpu: Add link to Mesa VirGL doc
Date: Sun, 16 Nov 2025 15:56:39 +0300
Message-ID: <20251116125641.2255794-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251116125641.2255794-1-dmitry.osipenko@collabora.com>
References: <20251116125641.2255794-1-dmitry.osipenko@collabora.com>
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

Extend virtio-gpu documentation with a link to the Mesa VirGL
documentation.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio/virtio-gpu.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 086e2fcf27b9..89153103b9f8 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -61,7 +61,7 @@ on typical modern Linux distributions.
 virtio-gpu virglrenderer
 ------------------------
 
-When using virgl accelerated graphics mode in the guest, OpenGL API calls
+When using `virgl`_ accelerated graphics mode in the guest, OpenGL API calls
 are translated into an intermediate representation (see `Gallium3D`_). The
 intermediate representation is communicated to the host and the
 `virglrenderer`_ library on the host translates the intermediate
@@ -70,6 +70,7 @@ representation back to OpenGL API calls.
 .. parsed-literal::
     -device virtio-gpu-gl
 
+.. _virgl: https://docs.mesa3d.org/drivers/virgl.html
 .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
 .. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
 
-- 
2.51.1


