Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CE9FD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 20:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwnln-0004hr-Qv; Sun, 01 Mar 2026 15:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnkt-0003Ku-B4
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:51:12 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnkr-0002IF-Qo
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:51:11 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772398244; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lx15ABIGgj3U6KDnnr1MurADu8EPvcRadvrm8QqimdLoGC/MOXu2RiT9xMVdLYc752XJR1WhRlvW+ttSvgQPOQmbIjTAw63IeumEyQevF0yrAlj5HLpjbk1p9dMIvoZQuzKKJi3QOSo1ioYQLzUwhXl0tn/2uqJLtjChC3DGaec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772398244;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zQ/BHsRxHlqyT+V9EEAF/Zmvt9alFM0l2mI2Obajrvg=; 
 b=Y6B9badFBCr+93lZvtDgToz8qyyNPLwEouCqHKKMzPzD2YWvhIRTrLbGb4ZFDbwqvVHnk9rEu0Mt00r/fgcu5LdWUWN8ZasVjlw/g3ZOuj1nEQnsbz19elyf0d7twWV6kl5CeewVv3AWB/qntQyANnxIHcZgzEvQ14Qkq+A3y7M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772398244; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=zQ/BHsRxHlqyT+V9EEAF/Zmvt9alFM0l2mI2Obajrvg=;
 b=T/MdWE8WpcFUl3jvWdpj2BrNTkAvjxVYNdtQAkdArSc+U+lUUailUCNC2TosxMrD
 Jj07vfz/bE8gDb50ikUfE08Ex6RxKVZZ+dADfm8h13fEeoi5JqDZTUQAVoxhtEyYUtZ
 lIwauZvPVuKdjx2t/OVKmsw1P77uZoY7Ze1S1NIE=
Received: by mx.zohomail.com with SMTPS id 1772398241709112.97271371515615;
 Sun, 1 Mar 2026 12:50:41 -0800 (PST)
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
Subject: [PATCH v20 17/21] virtio-gpu: Remove superfluous
 memory_region_set_enabled()
Date: Sun,  1 Mar 2026 23:48:34 +0300
Message-ID: <20260301204838.596994-18-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
References: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f8773039d01d..5b6474e3da90 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -171,7 +171,6 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(vmr), "mr", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
-    memory_region_set_enabled(mr, true);
 
     res->mr = mr;
 
@@ -225,7 +224,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         b->renderer_blocked++;
 
         /* memory region owns self res->mr object and frees it by itself */
-        memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
         object_unparent(OBJECT(vmr));
     }
-- 
2.52.0


