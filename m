Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3E3CEACEF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 13:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKcL5-0005Pm-6Q; Sun, 16 Nov 2025 07:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKcL1-0005OY-Mz
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 07:58:40 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKcL0-0000Aa-3r
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 07:58:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763297905; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TxpjQioFn9Q4bOaBiHXd1Tj+cbnpFB6qTGbCG+Mf1BJoExZWHq4pZ0tggwH/im2tcx46IP5cg0DY3mMDtK44VVM2Zu7VWQi5N5ThU+yKaA5CvRwSxEP2iN8GWiRt+wIebxujDqxq+6jRHDbzV6luPpeE72GmTjKWuAIeUly2/Zg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763297905;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=guz391IfkciUZStHJ9lbnMWHISEW5aT88BZZlGitg3k=; 
 b=krdxqIHDGb/ls0mH1lorh741Xqltp1Lbvgt3lp8Pl+7UbqnY6YNXRPpz62nTVGC2f3wKTZdXF+U9cySJYafofG0jo3BPGLDEneVTJU3QEsS/IG6x/RFgnjqrFbBL+nwChfdC810mpZHr/6BGC3Bd/rA5DkLIeSsGDe39mbRsjBc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763297905; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=guz391IfkciUZStHJ9lbnMWHISEW5aT88BZZlGitg3k=;
 b=UdRzA5TgE1f4e5YGX4puGWlL3z0WH371dhEaleSMx6gimahLL9NrH5XUs6rBitZI
 DYgA9BU1P0qllQowbtBRwYlCT4PK3QIxbLlNw5tkqhO+IAqSEHvttNdhYSgs4q+BXBD
 zUXmVFbjhMx+sqrVTHYmgejgLZ/OIbI6OQPCJfUQ=
Received: by mx.zohomail.com with SMTPS id 1763297902247866.1751678316062;
 Sun, 16 Nov 2025 04:58:22 -0800 (PST)
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
Subject: [PATCH v16 09/10] docs/system: virtio-gpu: Update Venus link
Date: Sun, 16 Nov 2025 15:56:40 +0300
Message-ID: <20251116125641.2255794-10-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251116125641.2255794-1-dmitry.osipenko@collabora.com>
References: <20251116125641.2255794-1-dmitry.osipenko@collabora.com>
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

Change virtio-gpu Venus link, pointing it at the Mesa Venus
documentation instead of the protocol. The Mesa doc provides more
information and also has a link to the protocol.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio/virtio-gpu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 89153103b9f8..ef5fb0401d5d 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -83,7 +83,7 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 .. parsed-literal::
     -device virtio-gpu-gl,hostmem=8G,blob=true,venus=true
 
-.. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
+.. _venus: https://docs.mesa3d.org/drivers/venus.html
 
 DRM native context is supported since release of `virglrenderer`_ v1.0.0
 using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") requires
-- 
2.51.1


