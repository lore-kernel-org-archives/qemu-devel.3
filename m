Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDD3C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjTA0-0008Ms-Gv; Mon, 13 Jul 2026 22:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjT9z-0008Mb-Lo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjT9x-0006b6-6A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783997170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=o4FSaPc2iRCt4tFjCRbhKxD1BOZXi7CsUwqtwp1ugaQ=;
 b=B1jaE01u2UGpYLLy1zpw5CdIuMzMhob3Vqgnbor2dMishoCSzxHAdE2ZDv4iGxtzK47Lzy
 DkeDw2iRikkP9xK3tsGy4NA907uoBYCTGtU7tGnwq1kLVBlha/OyoLFO6CkSvAK5Bh0nAP
 Y27uIHswVSLLAdpPFohytaakbIVGNus=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-ZCWPpGZBNqabipVSdbMeNQ-1; Mon, 13 Jul 2026 22:46:07 -0400
X-MC-Unique: ZCWPpGZBNqabipVSdbMeNQ-1
X-Mimecast-MFC-AGG-ID: ZCWPpGZBNqabipVSdbMeNQ_1783997166
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c891ed872ddso6682077a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 19:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783997166; x=1784601966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o4FSaPc2iRCt4tFjCRbhKxD1BOZXi7CsUwqtwp1ugaQ=;
 b=bNm6ix78ovIGk5RpHfIAjd0+LrQTJczQ+l+VqLHhJtn7UQl2Jae5GPwOy76BK9nY2H
 ocEgsukGYNIQ/nVQTD/aHj8R8vwV1lheLJtRce32WXtp5AZKERORTb1UxxeTUQM4EBW9
 +zbzDK4f/y6k4oLvkaVEVwnFLxpztwKHW4Gkqo07PYV9mwaf2DdORBSbBdTRof+gbDYn
 IQTJuYGuRJRwmv7UIUbm8qO9qgQJeQiRgXo6i0nsoCUuIJNMiZvDx/oeW6bYN4Grjim4
 jGPHxIs2dYRSt/SFUjN617Fx/Z1tHGpoFy95kzUm6slSGdS3IKymgiursl9bFUOraF4o
 9BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783997166; x=1784601966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o4FSaPc2iRCt4tFjCRbhKxD1BOZXi7CsUwqtwp1ugaQ=;
 b=LWYwkFV6cOh3cq24A1uPRKLpDDylA5SIBc04nT4p/nHHUh0oGt8zBC4DllmkyIqzF+
 Cp7Qohf9ezKepoTNjHditB3B5XTOneAJBfrKgO4AV1wntIhxF3og/wBpzafi2DYSGTVQ
 ciHgkRBIeVVE8Nb1/77ew2Y4Z9BwaeKEZ5PP92Wqd2dd8PUZLkDaOTmukUPvdL4TGFMK
 9d+SZYyTscis0ElFdHNvlAcNZLBVwCOeEeoJVAl2e5uTdl8p8j1X6tx34rq4receW5e0
 nKfkN7kkcNDuBbJBpY4L/83b40+4tHq0MIuMyY/a9YaW9m0dpTbHpiZPv7Zt1DUyNGBU
 qFGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+Wp+4rSXUwUeIg80BylII+C8IGHz+XMKkbFIle0YabME7qRToSni9ovFcGqJYryDqKba2jBmx4Sjo@nongnu.org
X-Gm-Message-State: AOJu0Yw10rzHuDgS003L6UhbVMbCwf3YlK6MGXrI1X0vPOSsL97H6mbM
 zbF1cUu4wpOxLv2UkQmJL2Zq70BIqKJkgGzr5Iy7J4de1D7h0fqvQj3hBoVmyvIp8rHWnqUBEmD
 X9JGDnFNlV6FwBRFsi/jAG7dU/beYE0p7N8ljbBLK8385vLhPqQZi0IJH
X-Gm-Gg: AfdE7ckImWZ+aZ7FNxxf3OeHulfUvpsdVyFeKWhkDN/PCZy49AvUCteyouJ8GHFbYNF
 DzCSicXnLArpGWpwjqXCSQu2hS6X7yvzii+5QpLjcZ+KsxOs7y1DAlt/a5gj66+w3TnvDhkWVYq
 cbtvkAsC2CVgn7NucMNBCwlna5IAzNXOw7zpyG7+4HinUg09qI+mWqiczke2S/hlc3Bgd9LYITl
 5OlrZuoauR9DDEhwhU0yrx45vp1OQLOlSmn0kFbmRxw9PbSFkVVNoKa8aX5YTRXspPBN8qZHR4v
 LApXcWDpIGQwh2pshwSw7MPagsQg91K59R3XvTlSJ9/DK5iJ74HV7XCX/fjm0hh68q8FVLEgQM7
 6mSGiA+//s5vGubCTzvsmFbIJD52c5TkzqXCzoj0yl4soiA==
X-Received: by 2002:a05:6a20:6a0f:b0:3bf:a8d7:4f4a with SMTP id
 adf61e73a8af0-3c34d71984fmr1904623637.40.1783997165998; 
 Mon, 13 Jul 2026 19:46:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0f:b0:3bf:a8d7:4f4a with SMTP id
 adf61e73a8af0-3c34d71984fmr1904595637.40.1783997165513; 
 Mon, 13 Jul 2026 19:46:05 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-13b924258a2sm60184658c88.1.2026.07.13.19.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 19:46:05 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>,
 Gerd Hoffman <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] Introducing guest driven VM launch update mechanism
 (BYOF interface)
Date: Tue, 14 Jul 2026 08:15:19 +0530
Message-ID: <20260714024557.204578-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=anisinha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
 hw/misc/vmlaunchupdate.c                      | 307 +++++++++++++
 include/hw/misc/vmlaunchupdate.h              |  38 ++
 .../standard-headers/misc/vmlaunchupdate.h    |  73 ++++
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
 21 files changed, 1208 insertions(+), 33 deletions(-)
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


