Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6706ACEBF92
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 14:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKdXR-0004Cj-8D; Sun, 16 Nov 2025 09:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKdXM-0004BV-Mu
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 09:15:31 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKdXK-0006Y0-FA
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 09:15:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763302508; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J+nGUO459phXb5ouWl4Mt1UO9gU1QGdSXgA5IliVFPzZDjQcjb8XCM3VgqdjjPAFrTdvogewAmOWh7yHw3u6hJ1/wuW8HjbHmEoVpeAkr9nU1fLQnF4TRDo8qDm1E6vGnYvhmx1pATFzihrcQeBk5lzqOcHaPpSi5FuRFgIPBQY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763302508;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XsovyN1uJw3oPN5EZ3MKWO6PsNz0oy48jQOUBV0dtfg=; 
 b=gGcdR2FW/Y6yiLuWDjp6W33X1DhfdKM2r199aM6r4VOocC+A867jhZv/K25KmPvKffCAd5Qn7BCCQao/AD3TedczmhxyWpvn4xN01EDndCL9msCG8phds/nqZI0XuvhnxysyvEFD/CglQHWZhwbwMM+5ZdAOznVyKXl2B7fyd+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763302508; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=XsovyN1uJw3oPN5EZ3MKWO6PsNz0oy48jQOUBV0dtfg=;
 b=dbaV9bKdBG7NGEjMjGWZLC5Mc7R0M1R356+DiofHcqsbJUbqdapDKCoAtRSl0WRZ
 O+BKSyXllMNUzydbqGtMR7KbWF/ISR2djh45PH7O5krjs+kngmWxVQ5Oj1oBZluhvMC
 hXLC42Mj0bUeZte+Zx6uOmw2I3yBL+fEn2a5a5LM=
Received: by mx.zohomail.com with SMTPS id 1763302506158891.9670769515335;
 Sun, 16 Nov 2025 06:15:06 -0800 (PST)
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
Subject: [RFC PATCH v2 1/2] virtio-gpu: Remove superfluous
 memory_region_set_enabled()
Date: Sun, 16 Nov 2025 17:14:26 +0300
Message-ID: <20251116141427.2325372-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
References: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
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

There is no need to explicitly enable/disable memory region when it's
added or deleted respectively. Remove superfluous set_enabled() calls
for consistency.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 80f71c0b66aa..a6860f63b563 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -139,7 +139,6 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
-    memory_region_set_enabled(mr, true);
 
     /*
      * MR could outlive the resource if MR's reference is held outside of
@@ -201,7 +200,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         b->renderer_blocked++;
 
         /* memory region owns self res->mr object and frees it by itself */
-        memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
         object_unparent(OBJECT(mr));
     }
-- 
2.51.1


