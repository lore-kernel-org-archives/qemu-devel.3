Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D27EB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxiHb-00010j-7E; Wed, 04 Mar 2026 04:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxiHX-000102-GY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:12:39 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxiHS-0000Hv-IN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:12:35 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so2606278f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 01:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772615552; x=1773220352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lwzz4kxfMbBjOhChGv+TPEiXdtwY6I/0AWARAPWIn4U=;
 b=cYk5yCAudwYIXUlBECeaD9rQ0ojV5R0MIpwHvmtInx6UabHUoO0UbArDTf+rZ5Dv6x
 xm1MYslyN+76XuBNn/cM38JaR/u+VkzGvLlt2nFWCuD6wXv3pk3zu6cWep1wpzGIa1nf
 TALTGNnUl9SCOSlo4vlq5n3IyFQIrEXOPbrhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772615552; x=1773220352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwzz4kxfMbBjOhChGv+TPEiXdtwY6I/0AWARAPWIn4U=;
 b=mCrbwYIP0WhkTlnRhSnilIYafu6VfL7FTPMVBhwekY1CMhwVIdCFeOBNWnQV2rTid9
 0IPsK0XPSGZQgcaUphNlB8f18w4+6XjVVi5Q9Q++BZF8MhGDhcrBYZE3ZiAg/D/keHFT
 8pxfSKwT+Agpv+MmDr0L2tsOIQiNo2rCNuLldnTVaVRhFtzBoK1Ja9TzXiOUWkEZZCAp
 efDqNoY+XAobSiuS/8wfOht1GzdveiDlMiJR6IMk+apJFsQm1tiY2JL6F9WVg+Of5rEW
 PeA/Il78Iy6cIdC1QkgMEK3UM9u9P5i4YuYMIKlriL5fjJni3Tf+sj4BTimdNBtgou5e
 NC/A==
X-Gm-Message-State: AOJu0Yw/kc981OIQKNgVF+g0daOoNgcZKTVhGXiV/cilmLQVgLJOfYGq
 1ZOcjV48XAia+ydgtBMT7PZt47d8GJBtK0hvJgJwF/zHfhRRK4TgJ6b6WuKhFC/81RIMNkRIbG3
 /g66bmUQ=
X-Gm-Gg: ATEYQzxiHZhwRV0f6GtUQejDFUqgawVU3i+vk8e3SJ/jr8J0wFaZCe3UlzWuA2TphGE
 I9Ydoxho8xT//yaJOUv3xwzjuXkWUA3mCCMSI0ittKLoJpcDBUR7BvxjHMLIVjd0Wt9ex04R4j3
 QCvGZJP0K4RIL+Lf7xkTDBzNNTSPibLnJnKj8+siTlj0Ct1MyqnkQwwLyMkD0qPgkMERIRC+MTy
 GhiDWshdzSLNvTrZRf+68z6y3dcC47YnHQr9UL9yYzuvIAWt8q3c/+jdFFQCTnck5c4AmpfcZJo
 awsHZo8GdFx3+nWMjnbMPKh3BsuGl2jAHfkjdHK6M4t53px+MWYTcboLEfzEZcI+h8bPUbLaYlj
 fONgkU0IKNGHKNaKe4XZQmFUXq9mRKfF7wn/RZMRuymiz1XK+jiKrfENB7C84dhru/bO+hruAO6
 IXbMVvFFuXMzfxu3Vm9vFhi9WYC2OVZ+6ucP6g838F/Tym9pITa9zS1/QU64b7HN0vSv2ulxX5x
 U8zPZe+f3xfhETxGv6eXyM=
X-Received: by 2002:a05:6000:26ce:b0:439:c356:9f65 with SMTP id
 ffacd0b85a97d-439c7fadd3dmr2432173f8f.15.1772615551391; 
 Wed, 04 Mar 2026 01:12:31 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00bac66d1b6d99e025.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:bac6:6d1b:6d99:e025])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439c4489279sm9674234f8f.20.2026.03.04.01.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 01:12:30 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Keith Busch <kbusch@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 0/4] hw/nvme: add basic live migration support
Date: Wed,  4 Mar 2026 10:12:25 +0100
Message-ID: <20260304091229.80725-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset adds basic live migration support for
QEMU emulated NVMe device.

Implementation has some limitations:
- only one NVMe namespace is supported
- SMART counters are not preserved
- CMB is not supported
- PMR is not supported
- SPDM is not supported
- SR-IOV is not supported

I believe this is something I can support in next patchset versions or
separately on-demand (when usecase appears).

Testing.

This patch series was manually tested on:
- Debian 13.3 VM (kernel 6.12.69+deb13-amd64) using fio on *non-root* NVMe disk
  (root disk was virtio-scsi):

time fio --name=nvme-verify \
    --filename=/dev/nvme0n1 \
    --size=5G \
    --rw=randwrite \
    --bs=4k \
    --iodepth=16 \
    --numjobs=1 \
    --direct=0 \
    --ioengine=io_uring \
    --verify=crc32c \
    --verify_fatal=1

- Windows Server 2022 VM (NVMe drive was a *root* disk) with opened browser
  playing video.

No defects were found.

Changelog for version 2:
- full support for AERs (in-flight requests and queued events too)

Kind regards,
Alex

Alexander Mikhalitsyn (4):
  hw/nvme: add migration blockers for non-supported cases
  hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
  migration: add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
  hw/nvme: add basic live migration support

 hw/nvme/ctrl.c              | 665 ++++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h              |   5 +
 hw/nvme/trace-events        |  11 +
 include/migration/vmstate.h |  33 ++
 migration/vmstate-types.c   |  88 +++++
 5 files changed, 772 insertions(+), 30 deletions(-)

-- 
2.47.3


