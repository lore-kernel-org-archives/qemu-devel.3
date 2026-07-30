Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09313C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKxL-00086Y-Lq; Thu, 30 Jul 2026 03:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxJ-00086J-FF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxG-0007uT-VI
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785395600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=44nwQ9y1Vf7SOSVKpRhSRfojZXzHggZgTOO9Ic+Hab8=;
 b=RL35WoVNmSQRTNueAn0Nd3k1/mWF8Q756KMOihCTyuMSUB8rfZHR62x4V9F1ucXxm4xAdh
 pqrhvSfC+fzLL0KYRo5JqRc7NfUwf2Oxg5ho1XxzdtNZITY6QivD8lf7GcXFnwy5AV0zVD
 zGZ3hxMCt9tggM9UQHcUsUh5mqrg6lE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-OwB6t-b6M1OMr0qWhiE1Zw-1; Thu, 30 Jul 2026 03:13:18 -0400
X-MC-Unique: OwB6t-b6M1OMr0qWhiE1Zw-1
X-Mimecast-MFC-AGG-ID: OwB6t-b6M1OMr0qWhiE1Zw_1785395598
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cccfa32670so20404055ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785395598; x=1786000398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=44nwQ9y1Vf7SOSVKpRhSRfojZXzHggZgTOO9Ic+Hab8=;
 b=IhueEXe7a4LDNaj4k8aUKLs+lt+9NHYSlMIw5NPNl1BIgm/u8XR7JIBEvtrXjimjqy
 Gs6z+4zJcMxg5tvM7ToCb4KqPq1wkvADLV0kE/NTAQwuZOIN6FrTIB+o5smp6ClwtgQy
 NUSWMQ6RGOHVricQCf1D/GwzJYqfBTu4ZxDIrfolhF0D9aWbjL2unq/ElD5ZnY0mhgnO
 xqI8K8MIfizoGcIvQZgOc7HpsbJFMe/xlH/7KBFNbzbpEvdwnUz9YR2PJw7DNvongscw
 9S1RgDyCbFvGNk1hO/03aFSxYveYfZc8AgW28SqBMQikSY+lCvsxXCQqW+9VhDQcwXF9
 S+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785395598; x=1786000398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=44nwQ9y1Vf7SOSVKpRhSRfojZXzHggZgTOO9Ic+Hab8=;
 b=K5PBdtIFU5tQ9mbn4HEYZWXJHFqW7uczj2FeNLy4l3jzKb3fsrnwZusdyjlcKPAIGX
 o3IGeFsZS9eektVs/OpSk72pKFm9TteSvwv4DSZtv2fFAYIR0fGB2FrEyO4RcjN1D58N
 7KRaPWeNucg3lI2gRxBWYdPGqCEFuWCdSRhdzmYjZVJI+A4bDQrCLLZJ4SOFJ1JUu5T3
 cEhkZeN3dGyUQMvsujp4E6eU+xPeeSNMZkY2M+2hLnTgYJWQKj0a7sNO3UVYKAohr4sY
 bYTdZau1MdFxScvRAiR8quEColsLT+MpJ/mc94tFC/wEReIu8EmQ8SlvqQEIRqfDVS3H
 euOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBe8PmiIZC+AujiSzrs0Nmyv6t4mgfkizj1rdLEFE6lKqiXQymXoqlGYy7SJlUVR52vcBpzoW6Sdva@nongnu.org
X-Gm-Message-State: AOJu0YzrlMZHiDn/AwnQPlFLOvHvKAK4TmA0Nrk+ApKpZObLmv3o2d/R
 mcbpkx3rNUTjZcG4NKP2PEyTyLyIf1pe44I7IBi/SgEO+UY74uvxu/sFX0DcZ6WZnmP9Pg2RztN
 uPMBF/nXsXFs6GjmLhKmOF3q+Sw11dfgLgmZZ4YhoAHXBUdPn86JRSKU3
X-Gm-Gg: AR+sD13qHh078e5M1358reuziDo/FtO5xX0t4SBajgxA3JZBip5/etSleJf4ULYFh5J
 TlvXZtKRBsZG+IIUWDsByK/C9zEK2pPUmcF15QGcQe15Xii/CiriDywwSxqbT/lroL0prwJSxCw
 nY4Jr9Xy9lYo/iuPqLHmAX4KA4hmvPOaNICc/q6FciFcKXhGCaGOCsjV/VOuuZR5ZSzBeu/ht0s
 bziIQvJuavbbyuQP2QjEUTVE9ZYNXwpwSLF1rGiJROfdnyjbZTYoiWd1cIcSFg+KDEDFfv+a2iw
 7GTrDIv0jUWhNXue1pGiPLBVDeNab6u6r6dSbEDp1Xal5SAjPGlQcs0aGlL15Mht/X9VJLG6kC0
 DuhoAzmNJKRdQFYUIXfyBLVvwBLJax7mc5jE=
X-Received: by 2002:a17:903:ac5:b0:2ca:d818:61e5 with SMTP id
 d9443c01a7336-2d035d1a6abmr16216155ad.26.1785395597771; 
 Thu, 30 Jul 2026 00:13:17 -0700 (PDT)
X-Received: by 2002:a17:903:ac5:b0:2ca:d818:61e5 with SMTP id
 d9443c01a7336-2d035d1a6abmr16215905ad.26.1785395597333; 
 Thu, 30 Jul 2026 00:13:17 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d022a15893sm21864835ad.4.2026.07.30.00.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 00:13:16 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, graf@amazon.com, agraf@csgraf.de,
 qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v3 0/9] Introducing guest driven VM launch update mechanism
 (BYOF interface)
Date: Thu, 30 Jul 2026 12:42:27 +0530
Message-ID: <20260730071254.80695-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

This is the resurrection of the work that was previously discussed here:
https://lists.endsoftwarepatents.org/archive/html/qemu-devel/2025-03/msg05872.html

This relates to the 'bring your own firmware' work that we are driving at Red Hat,
now with IGVM support.

The patchset includes a spec doc that has more details.

This patchset implements the hypervisor interface using fw-cfg. Using this interface, the guest
can pass its own IGVM file to the hypervisor. Upon reset, the hypervisor re-initializes the guest
using the IGVM file the guest provided.  This is useful in order to have deterministic and trustworthy
launch measurements, mostly for the cloud confidential guest deployments.

This patchset has added functional and unit tests that exercize the hypervisor interface. It has been
tested for both confidential guests and non-confidential guests. Gerd has also independently tested
the patchset.

Changelog:
v3:
 - Gerd's suggestions incorporated.
 - Rebased.
 - tags added.
v2:
 - API definitions moved to a separate userland header file.
 - A new ctrl flag is added that will restore original host provided IGVM. Tests for the same are added as well.
 - doc updates that describe how the interface works with the new ctrl flag set.
 - A memory corruption issue is fixed.
 - total size of test IGVM files reduced to 270 KB.
 - other review comments addressed.
 - tags added.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>
CC: qemu-devel@nongnu.org


Ani Sinha (6):
  hw/misc/vmlaunchupdate: add api header
  hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg interface support
  docs/spec: Add a specification document for vm-launch-update device
  tests/qtest: Add small igvm files for testing purpose
  Add functional and unit tests for the vm-launch-update device
  Update MAINTAINERS

Gerd Hoffmann (3):
  igvm: store IgvmCfg pointer in QIgvm
  igvm: track memory regions
  igvm: cleanup memory regions

 MAINTAINERS                                   |  13 +
 backends/igvm-cfg.c                           |   3 +
 backends/igvm.c                               |  99 +++--
 docs/specs/index.rst                          |   1 +
 docs/specs/vmlaunchupdate.rst                 | 172 ++++++++
 hw/misc/meson.build                           |   3 +
 hw/misc/trace-events                          |   6 +
 hw/misc/vmlaunchupdate.c                      | 309 +++++++++++++
 include/hw/misc/vmlaunchupdate.h              |  38 ++
 .../standard-headers/misc/vmlaunchupdate.h    | 102 +++++
 include/system/igvm-internal.h                |   8 +-
 include/system/igvm.h                         |   1 +
 tests/data/igvm/README                        |  24 ++
 tests/data/igvm/hello.igvm                    | Bin 0 -> 137112 bytes
 tests/data/igvm/qemuinit.igvm                 | Bin 0 -> 137112 bytes
 tests/functional/aarch64/meson.build          |   1 +
 .../aarch64/test_vm_launch_update_aarch.py    |  33 ++
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vm_launch_update.py           |  48 +++
 tests/qtest/launchupdate-test.c               | 408 ++++++++++++++++++
 tests/qtest/meson.build                       |   2 +
 21 files changed, 1239 insertions(+), 33 deletions(-)
 create mode 100644 docs/specs/vmlaunchupdate.rst
 create mode 100644 hw/misc/vmlaunchupdate.c
 create mode 100644 include/hw/misc/vmlaunchupdate.h
 create mode 100644 include/standard-headers/misc/vmlaunchupdate.h
 create mode 100644 tests/data/igvm/README
 create mode 100644 tests/data/igvm/hello.igvm
 create mode 100644 tests/data/igvm/qemuinit.igvm
 create mode 100755 tests/functional/aarch64/test_vm_launch_update_aarch.py
 create mode 100755 tests/functional/x86_64/test_vm_launch_update.py
 create mode 100644 tests/qtest/launchupdate-test.c

-- 
2.42.0


