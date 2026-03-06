Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90893FCB613
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWiW-000787-SK; Fri, 06 Mar 2026 10:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWiT-0006lQ-NJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:49 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWiR-0003Ii-79
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:49 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so7180934f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772809425; x=1773414225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+im5SJgec6TggcdmfdMNWEhq+VXtMQYffqaLE1Rbtn0=;
 b=XD0k7ceFVdNWVa6GwfqGIYWvBcCb9Ek0S7MlQRDumCbw75CUogpcEE6ZFEeDbWlFFh
 1v0Cmq1WS43Ff06qLhVRMnCeTZlAA2BUMK3ukZqUcx2Ztkk1umEHDEGPsO07GwcDtWBC
 2NJTWdi8irNDEb+cigtMHp5xABvV8OTyNSgyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809425; x=1773414225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+im5SJgec6TggcdmfdMNWEhq+VXtMQYffqaLE1Rbtn0=;
 b=UEuXsSLMOO7Uwn4lYzAg3PCkpX9uIU/GgiieoIAmaVcQ5IaLDY9J2GcHXr6PXcfefP
 jqOjnxx58ERbO2Iim8r6+GTK8Z3a/7oYXtLG+krfuw6TRzp5LyJlkYWMRoGmNrnl4pyP
 P6WjF/wdkb7dz9u/6dx5mWD/ZBqriiaOfBP2zJOt94PC1IUBORvXELng7tmdrysuejbR
 6hjHDNW4gBi5ed9plUZSthu6+ESH2CSilDLMTS9hPK2Gb9xp7mgbBulTp4ygdvzC7kb0
 mqpKtmkXP6OkZGfHLXhJTraCx9Kxy/ykt4PWcPz+sexiViPv72qj63y+XlXFGMyzWhY7
 RTBw==
X-Gm-Message-State: AOJu0YxGjs65mnggiku36UXHIEkpYLTbxMR7k/rbO81InynHbV9IaqnN
 XWnMtivj27HaCYq8SCoY1VXrh0vMgchKShQlMMrCH7DMXjmE7pyZz3PewB5KqjIHBhnJpGn9N/V
 zLLicVhw=
X-Gm-Gg: ATEYQzxDKBDzqbKQ2l2/x0aNSxkMAcWy3FnCK8Pm4Ld+AVZuhLI2gHOUCW8lte3WSIG
 mf9JnrelAek1cXKEHc7rEdSI4DxG5HeUWFsRt3X1opPOhIqZwruEwndhpYSk6Ug91pG1+Z7BZ1Z
 jnP2vKwXa9iFahT+NmyR8rmmZIfbbnw69NV+KUAdY0MKqowz/TA61mgBbmC4LSzAjxU/wNtgJE4
 D9q+j0eNUAhUTSr3L6OfHUqWwrLQKb4B3CQhb4NEBCbeBFB301cEurQZCseOSKPPXqjuRw6I1I9
 DQF9I6lm+9F0yOMp4vBqTDnNdhPk1yPN7ASqdvy2KVhN3cNIXnx50B3fXpeZHmMStD1MebkM7zR
 3m/ry/hBGvezIzw3SGhJXqTQ2E20xMekyt/wC5aR4eov++uBVpIbneVbtt6MihSdvxqqEwDn+w6
 7kmi2o3jGrCnvlG+K1zVg6XnwOXez5Trrj9FWD9REm16Tl2KcfOkv8dewVBaLWPjy4sQo4j1XsC
 oc7vllnbxln6DGD8C8cwb4=
X-Received: by 2002:a05:6000:1a8c:b0:439:8bee:b986 with SMTP id
 ffacd0b85a97d-439da885f06mr4554572f8f.32.1772809424038; 
 Fri, 06 Mar 2026 07:03:44 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00583f1937c9b9cecc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:583f:1937:c9b9:cecc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm4703623f8f.27.2026.03.06.07.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:03:43 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 0/6] hw/nvme: add basic live migration support
Date: Fri,  6 Mar 2026 16:03:36 +0100
Message-ID: <20260306150342.395923-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I'm currently working to address feedback from Peter Xu and Klaus Jensen:
- improvements on migration API side to make dynamic arrays support more flexible
- figuring out what is a right way to go with NVMe feature migration capability checks

Changelog for version 3:
- rebased
- simple functional test was added (in accordance with Klaus Jensen's review comment)
  $ meson test 'func-x86_64-nvme_migration' --setup thorough -C build

Changelog for version 2:
- full support for AERs (in-flight requests and queued events too)

Kind regards,
Alex

Alexander Mikhalitsyn (6):
  migration: add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
  tests/functional/migration: add VM launch/configure hooks
  hw/nvme: add migration blockers for non-supported cases
  hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
  hw/nvme: add basic live migration support
  tests/functional/x86_64: add migration test for NVMe device

 hw/nvme/ctrl.c                                | 665 +++++++++++++++++-
 hw/nvme/nvme.h                                |   5 +
 hw/nvme/trace-events                          |  11 +
 include/migration/vmstate.h                   |  33 +
 migration/vmstate-types.c                     |  88 +++
 tests/functional/migration.py                 |  22 +-
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_nvme_migration.py  | 159 +++++
 8 files changed, 951 insertions(+), 33 deletions(-)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

-- 
2.47.3


