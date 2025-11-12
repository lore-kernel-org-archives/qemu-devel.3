Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D062CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 23:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJKKH-000266-Lr; Wed, 12 Nov 2025 18:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vJKJr-0001tl-5C
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 18:32:15 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vJKJl-000072-HU
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 18:32:06 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1762990297; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GxfD6SVds4xJTY7VY5A7hhmQfLYMEBecGZ093H6GqRtHQ/69Fw5x3k0abKJB6lUO094DEHizog7uQ64dkXybT/01JJb7MYXkhYSlYeWKmrfSpA7efxrKXgxXaXMePB9YcidG+tc6HLpiqTzQo9n6IBDe6Z239ajA6UlwRq0i1D0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1762990297;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DVgpMMTmWwQvIrYz06DczYAcf1tuZ1vkrtnX6IKEx5Q=; 
 b=W0GeiKHKUTdzSu5ZtvWfzvGDOmYfljpMT0gJp4WTguPF3GDDp8PLaNoonwXNkzBgR2wbfO9zHhs3w9wY+QQCWyyPxxeQCii8f2vi7cZYIoq+aXuS2XbdttEo9tzzWavrtW+veAtXoiLepNynqcp9Ngi9DkARHzhP1B4B4esfC/Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762990297; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DVgpMMTmWwQvIrYz06DczYAcf1tuZ1vkrtnX6IKEx5Q=;
 b=Mi8RcCdLSZzGiegAhmcVNM4HOtZvYmVi6hp09lZQZCOqUqnUVsG612tEIjUy/tPe
 Xhw85m3+vmBmP7seeOogsLC1mSirD5393MYpXH4pOApBirV19MCLqBeUwAMILV1EXYO
 3Eb7Ztf4dI0xLvdrJe4WrUo4HcX7bIzUf5oWzElA=
Received: by mx.zohomail.com with SMTPS id 176299029622126.029501134625775;
 Wed, 12 Nov 2025 15:31:36 -0800 (PST)
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
Subject: [RFC PATCH v1 0/1] Support mapping virtio-gpu virgl hostmem blobs
 using MAP_FIXED API
Date: Thu, 13 Nov 2025 02:31:17 +0300
Message-ID: <20251112233118.1475381-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
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

Virglrender got a new unstable API that allows mapping host blobs at a given
memory address using MAP_FIXED mmap flag [1]. Usage of this new API brings
major performance and stability improvement for venus and drm native contexts,
see commit message of the RFC patch for details.

Sending early to collect review feeback and have patch prepared by the
time new version of libvirglrenderer will be released with the stabilized
API.

[1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1374

Based-on: 20251109164711.686873-1-dmitry.osipenko@collabora.com

Dmitry Osipenko (1):
  virtio-gpu: Support mapping hostmem blobs with map_fixed

 hw/display/virtio-gpu-gl.c     | 37 +++++++++++++++++
 hw/display/virtio-gpu-virgl.c  | 72 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-gpu.h |  3 ++
 3 files changed, 110 insertions(+), 2 deletions(-)

-- 
2.51.1


