Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47BACD4F3E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 14:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKdXI-0004B9-NV; Sun, 16 Nov 2025 09:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKdXH-0004AE-1z
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 09:15:23 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKdXD-0006Wt-Nx
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 09:15:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763302500; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mjC8zh/EN09kOMmUImLDSrUAU/C5JiU+8PKOJZsXr7m0yRzdm1OcV05cdtBrJUnOxnSX1yuOJnltSRsCDijvYLcEbVXyW53kb/UFH46/lZJdE6IaOLF6bWVDvc7BcqTfBWGe3Qmo+OsXlJhVohOYOWRG6393cCF44HbqEmuMDcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763302500;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Hor3doUuE/Bf73ao9N725v6mFrX2o0L2um/3cr45rJA=; 
 b=TqX0D85gI/6tE7A5mdbgqXnFUFOoOWa4NoQ/3PbhYWwS68J3n5LfrV6ZU+vkGcAzdkQDFZDsUHmmD9MJK18SZBEZF4b7aOlgiduS/iczSU3rzn1+TCAlK3lxe5vAi5AXz53NjI6ll9XNXNtzD4AKWDK6MuHh65VOmxj9jAM9P0I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763302500; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Hor3doUuE/Bf73ao9N725v6mFrX2o0L2um/3cr45rJA=;
 b=KtbDmCa1X2ayxbMlAMX0grvQ/HYJWcCH10RgHZJke1qSrSOrO2zXjoFt5G3yhQcj
 cNiKwv8/Df6fNSZzIx6rPk55EMCnlDIEPDnjMp0prQ8dd0lnV+FT7HFcyF8SO3PC5Bo
 yM+1qKpxySOjgn4yuwde3iY7DoqOCy6PM/xeUoPw=
Received: by mx.zohomail.com with SMTPS id 1763302498268227.6121586120463;
 Sun, 16 Nov 2025 06:14:58 -0800 (PST)
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
Subject: [RFC PATCH v2 0/2] Support mapping virtio-gpu virgl hostmem blobs
 using MAP_FIXED API
Date: Sun, 16 Nov 2025 17:14:25 +0300
Message-ID: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
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

Virglrender got a new unstable API that allows mapping host blobs at a given
memory address using MAP_FIXED mmap flag [1]. Usage of this new API brings
major performance and stability improvement for venus and drm native contexts,
see commit message of the RFC patch for details.

Sending early to collect review feeback and have patch prepared by the
time new version of libvirglrenderer will be released with the stabilized
API.

[1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1374

Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com

Changelog:

v2: - Addressed v1 review comments from Akihiko Odaki

    - Added patch that removes unnecessary memory_region_set_enabled(),
      suggested by Akihiko Odaki

Dmitry Osipenko (2):
  virtio-gpu: Remove superfluous memory_region_set_enabled()
  virtio-gpu: Support mapping hostmem blobs with map_fixed

 hw/display/virtio-gpu-gl.c     | 45 +++++++++++++++++++-
 hw/display/virtio-gpu-virgl.c  | 76 ++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-gpu.h |  3 ++
 3 files changed, 119 insertions(+), 5 deletions(-)

-- 
2.51.1


