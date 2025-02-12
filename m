Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEF8C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGh4-0003Am-JU; Wed, 12 Feb 2025 12:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGgz-00039x-S3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGgx-0005V0-M7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qYE6l8/PKY58UvcYlwDTCILx5IqXbldQmQyUbg6qJok=;
 b=TJt6OZo3qIltsLnSNQ7yGQpzezdGWdwob8Ef4DMbaGXh+xjXrnG5++VzpltdnFOA2RqvPJ
 olDGivpHS2VTs+y3YWrK70likMXLDV5FK3TWaJ26QXXxk63XGIuVvLl2j/80mEBY45x5/k
 pUupSb4CxYYzos9GlDeu/e+5JYA0YVc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-rMN9VsfrMXOIL1xjFKO1QA-1; Wed, 12 Feb 2025 12:38:28 -0500
X-MC-Unique: rMN9VsfrMXOIL1xjFKO1QA-1
X-Mimecast-MFC-AGG-ID: rMN9VsfrMXOIL1xjFKO1QA_1739381907
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-726fd30b5a5so198613a34.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739381907; x=1739986707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYE6l8/PKY58UvcYlwDTCILx5IqXbldQmQyUbg6qJok=;
 b=hWn146wMC1xocGb6MZfqZLYniG54/guRcMC5X7nEMAfv4KyPfAsGR63zpR2Gjqg+/X
 /tl70AZQ47hCLnavv5MZgs1wmU0SeQwinLennF2h8vKCoXl0zoILvm5dY4Wlr24CAHuv
 ORftgQq4K1/AWiRudtljwBUlWIl9Tp3QKi9SE+iJjmk1jm9jF1pLO+mm4s13iU1rfgG1
 lpC7qwCHeQJqW5eJvXs+SAzQVShxKtYPgOAYpidWEKz0fDLN3PqT5SqZWmYLRtDj+E1c
 4Eq9KJlPOm+bZ6SFQTIZR2Buy3Z2ydsPjPdLZEeBZIq80yMD20xD4ZswOr8qy30Be6N/
 L8HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4OM201UyrTU109xomMgo4DR5x5c7ShvWJ584bQr3dh1MMhX2v+9G5MJA4PKBj71viailwGrNGFOke@nongnu.org
X-Gm-Message-State: AOJu0YyGer2m4zCm5qeXypUvxOJZ5ksQ5x9coVltgR1jrH7SSyWaKDPL
 S6dEK/4EjmQNuH1UZdSf9J9wAz0Ywvi+7t8Bq1HKfEcQ8PApsizhypKIwKh6WwAGe8CL4GmA0G+
 gCZXPPkH5grl7qm43EC31NVHJctg6JBkmIygw5t/XmPo8uqO7byCd
X-Gm-Gg: ASbGncthgMCr4rOu3EAV68WN91IoPfPrQQKw//+LPy4ySm35qf6j+bg7nlqkw8Oe0o9
 0hbqlOFcLUYAcmSnOzkMxGg4g+aeDcBiGfVWmH+TKus2/cAVJc1r8kEpFRmDoAbYDWpOvRI14xh
 DRPeLPQK5xmw/dJHJlxVpfKvx5mAf5rsfFvPkgqBcJF+GlWLk7HRQeaw/IYheGf5kBQ/dIyZDof
 iawTGA4Y+Crqro+jhaLUg8yUlmuQqDSjscex68Siat7BiVuIR3dDETC
X-Received: by 2002:a05:6830:1e34:b0:726:e598:e07d with SMTP id
 46e09a7af769-726fe60a4b8mr138492a34.0.1739381907244; 
 Wed, 12 Feb 2025 09:38:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNKabKxhbD1f1mH6VMyhDG+ZbMTUXPSSwK8bBVIZgyBEcFOBZuEHHYa6x2+mvLc4ipG04xhw==
X-Received: by 2002:a05:6830:1e34:b0:726:e598:e07d with SMTP id
 46e09a7af769-726fe60a4b8mr138481a34.0.1739381906893; 
 Wed, 12 Feb 2025 09:38:26 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc544b08d4sm4457194eaf.2.2025.02.12.09.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 09:38:26 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 00/14] Mem next patches
Date: Wed, 12 Feb 2025 12:38:21 -0500
Message-ID: <20250212173823.214429-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit ffaf7f0376f8040ce9068d71ae9ae8722505c42e:

  Merge tag 'pull-10.0-testing-and-gdstub-updates-100225-1' of https://gitlab.com/stsquad/qemu into staging (2025-02-10 13:26:17 -0500)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/mem-next-pull-request

for you to fetch changes up to 13057e064a3edae7abf9ca2c207cdf48b82c5aad:

  overcommit: introduce mem-lock=on-fault (2025-02-12 11:36:13 -0500)

----------------------------------------------------------------
Memory pull request for 10.0

v2 changelog:

- Fix Mac (and possibly some other) build issues for two patches
  - os: add an ability to lock memory on_fault
  - memory: pass MemTxAttrs to memory_access_is_direct()

List of features:

- William's fix on ram hole punching when with file offset
- Daniil's patchset to introduce mem-lock=on-fault
- William's hugetlb hwpoison fix for size report & remap
- David's series to allow qemu debug writes to MMIOs

----------------------------------------------------------------

Daniil Tatianin (4):
  os: add an ability to lock memory on_fault
  system/vl: extract overcommit option parsing into a helper
  system: introduce a new MlockState enum
  overcommit: introduce mem-lock=on-fault

David Hildenbrand (7):
  physmem: factor out memory_region_is_ram_device() check in
    memory_access_is_direct()
  physmem: factor out RAM/ROMD check in memory_access_is_direct()
  physmem: factor out direct access check into
    memory_region_supports_direct_access()
  physmem: disallow direct access to RAM DEVICE in
    address_space_write_rom()
  memory: pass MemTxAttrs to memory_access_is_direct()
  hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
  physmem: teach cpu_memory_rw_debug() to write to more memory regions

William Roche (3):
  system/physmem: take into account fd_offset for file fallocate
  system/physmem: handle hugetlb correctly in qemu_ram_remap()
  system/physmem: poisoned memory discard on reboot

 meson.build               |   6 ++
 include/exec/cpu-common.h |   2 +-
 include/exec/memattrs.h   |   5 +-
 include/exec/memory.h     |  35 ++++++++---
 include/system/os-posix.h |   2 +-
 include/system/os-win32.h |   2 +-
 include/system/system.h   |  12 +++-
 accel/kvm/kvm-all.c       |   2 +-
 hw/core/cpu-system.c      |  13 ++--
 hw/core/loader.c          |   2 +-
 hw/remote/vfio-user-obj.c |   2 +-
 hw/virtio/virtio-mem.c    |   2 +-
 migration/postcopy-ram.c  |   4 +-
 monitor/hmp-cmds-target.c |   3 +-
 os-posix.c                |  15 ++++-
 system/globals.c          |  12 +++-
 system/physmem.c          | 121 ++++++++++++++++++++++++--------------
 system/vl.c               |  52 ++++++++++++----
 system/memory_ldst.c.inc  |  18 +++---
 hw/display/apple-gfx.m    |   3 +-
 qemu-options.hx           |  14 +++--
 21 files changed, 229 insertions(+), 98 deletions(-)

-- 
2.47.0


