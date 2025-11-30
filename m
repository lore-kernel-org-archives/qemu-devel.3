Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6EFCFD376
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Nov 2025 04:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPYmv-0003Dg-NF; Sat, 29 Nov 2025 23:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vPYmr-0003Bp-S3
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 23:11:49 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vPYmp-0000EO-LI
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 23:11:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764475885; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LjsuWIzzF58emLB98iSTbZH5B48gfzueoUpMhjfQIDRCVJuzr+v7tzCu96ReDF5eSAqfTQyiyp6VKq0vi+grU2F88nLu8A0QUVJJIaQVOXCTXI8mIa3UPq9qkraSGr61/1WdFMuuAlXCrMNmfDDljZfpGLBmk47KX9zSuT7lmNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764475885;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1LzwSPWIfCFLVL2qmTf8Jou4yWskLltSY2iIwvCW8lI=; 
 b=mGf5yVgxJ4ffCuDclNr9sEC0BGkTkOlZ6X+M0NWjxerxxluShIKLk3U09BPu/kGg1s3hyyTJ10o1Ag9R/26WWqsbK7AyeWFlnznMoH6vJco19mOViOiP1vtel365cLOO9z4ziIcQ0vrxawOlXnBHQQIplUidSVCxCX3Akhd0/sk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764475885; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=1LzwSPWIfCFLVL2qmTf8Jou4yWskLltSY2iIwvCW8lI=;
 b=D9r0dMJX/ns6u/Cfk5KN5Nzgsfgwwal1FYooRaah5Bza0LJyqRvI31o81ZZUc1sc
 u/rIZjpJYjXrV7faeILeKAH7XeV8BeIynMsEiERvThJmj916ZVKlThM2zF9ejrwUOrf
 pvmXILm0v18C0xvSvkvv/9ecjWInXEyq8yWxbKxk=
Received: by mx.zohomail.com with SMTPS id 1764475882931763.381390527455;
 Sat, 29 Nov 2025 20:11:22 -0800 (PST)
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
Subject: [RFC PATCH v5 0/4] Support mapping virtio-gpu virgl hostmem blobs
 using MAP_FIXED API
Date: Sun, 30 Nov 2025 07:09:36 +0300
Message-ID: <20251130040940.1611949-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Virglrender got a new API that allows mapping host blobs at a given
memory address using MAP_FIXED mmap flag [1]. Usage of this new API brings
major performance and stability improvement for venus and drm native contexts,
see commit message of the RFC patch for details.

Sending early to collect review feeback and have patch prepared by the
time new version of libvirglrenderer will be released with the stabilized
API.

[1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1374

Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com

Changelog:

v5: - Switched to use error_setg_errno() for qemu_ram_mmap() error
      handling, as was suggested Akihiko Odaki.

    - Added r-b from Alex Bennée to the first patch.

    - Moved hostmem mapping offset validation to upper function as
      was suggested by Alex Bennée.

    - Dropped all patches and changes that made funcs to return -1
      since it was rejected by Alex Bennée. Refactoring can be done
      later on in a separate patchset.

    - Extended clarifying comment of virtio_gpu_virgl_reset().

v4: - Addressed v3 review comments from Akihiko Odaki.

    - Dropped patch making resource_unmap() error reported as a host
      failure instead of guest and added patch improving resource_map_blob()
      error reporting.

    - Re-added CONFIG_WIN32 checks.

    - Added clarifying comment to virtio_gpu_virgl_reset() RE unsupported
      context restoring.

v3: - Addressed v2 review comments from Akihiko Odaki.

    - Droped check for CONFIG_WIN32. My current understanding that
      MAP_FIXED is supported by Cygwin.

    - Added new patches resetting virgl resources, validating hostmem
      offset and improving error-handlings.

    - Added r-b from Akihiko Odaki to the frist patch and t-b from
      Yiwei Zhang to the map_fixed patch.

v2: - Addressed v1 review comments from Akihiko Odaki

    - Added patch that removes unnecessary memory_region_set_enabled(),
      suggested by Akihiko Odaki

Dmitry Osipenko (4):
  virtio-gpu: Remove superfluous memory_region_set_enabled()
  virtio-gpu: Validate hostmem mapping offset
  virtio-gpu: Destroy virgl resources on virtio-gpu reset
  virtio-gpu: Support mapping hostmem blobs with map_fixed

 hw/display/virtio-gpu-gl.c     |  46 +++++++++-
 hw/display/virtio-gpu-virgl.c  | 158 ++++++++++++++++++++++++++++-----
 include/hw/virtio/virtio-gpu.h |   8 +-
 3 files changed, 185 insertions(+), 27 deletions(-)

-- 
2.51.1


