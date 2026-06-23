Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF0CCDB47C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YF-0004Ti-Jj; Tue, 23 Jun 2026 08:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YA-0004TV-FG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0Y6-0006yN-1L
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cvxt+Kd17B9fN1ONcSujVDKlJnnS8bCIAKhotmueqno=;
 b=cZFgt4WpnXmt/Sv35fRUcTzIDD+Kn/wbUhhFrzubH9lRlVnd8ap2QGVRj6MQPMZ7GupFzW
 pCE/PWmg7wq2FntJFwujWHTODUm1Z77j78JKD4FF+RAtOtAxOHSmuhzSjOBRNC2/6oJceE
 gCcMM8/m2g/cuvatRHeBR/OLMTbTSMU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-RQtoRvepNQOHjPLHV9IVGg-1; Tue, 23 Jun 2026 08:48:15 -0400
X-MC-Unique: RQtoRvepNQOHjPLHV9IVGg-1
X-Mimecast-MFC-AGG-ID: RQtoRvepNQOHjPLHV9IVGg_1782218895
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5195760750bso108320971cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218895; x=1782823695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cvxt+Kd17B9fN1ONcSujVDKlJnnS8bCIAKhotmueqno=;
 b=tRlq/bTHgRn3IebJ6Rljwtzv/vnMsqME6CtS5sYUdEVhHvHH9e34GfJ0MEeSc9Wcud
 EdcwDL7PgkVxHxQv3QaxyZFeAwp7C3wipfnJZUO/M6G50oqXVa20yFEGKOG5UY+ziAMi
 6/2sYzLnubDLHgUltS/sGBTsbpWswoKcczrrlKs0QH/lA80zsjfrHTmhN4I06gFjAsqO
 lbZ+q1Te7H6ALVkHC8T5BpA+TXhIN/tf9/D01qLLGVZg+Z+cmRoF4KCFfiEwE+Rqx7+x
 CkfPvWG4LKKF3NXLXOVjqQia0HwePuqrvujUV3whgcYzNkDJEkPiQqT4xMf8kn56CORc
 zjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218895; x=1782823695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cvxt+Kd17B9fN1ONcSujVDKlJnnS8bCIAKhotmueqno=;
 b=AU4Y5mUhfzq8GqY4HeLneaEqVgkES2hEOnOWCzfCXfCQbBmY8rRVKxrvau0nfYJ665
 St4ipHdoUgs3ZH1BXvKtqkenf2JNAu0W7wcH73u6iblan9dZxAurR9dcBAYBJPsZZxr3
 0U1oE7+aQJ7GTMvSkEoqudRwQ9U7cYnMi0V7CPEC1e+pvlTYVNiChfTzuRoEWexHc0zo
 FWS77yOwYI2KKzGkOyJlAggtBOoAwV0XtRnWL9xIJJAYrmZyIkihMR1s+laYr1geTjBz
 ax/3QJVdbKU5Q5QO0wzugLgHG2C6Azt/LeS5AAfEdW6hxFbttlKdMBOGq/syfuj5tpLA
 HpSw==
X-Gm-Message-State: AOJu0YyjSrp85LFSnW9WbrbcP9daBJG9w8E83rWLjWjJNDT5b3E13TSm
 OaDYtPaG47YWrQ5WhBYVNapf2VsVd6SGsrODNqyPeLTWvxP+RGGicvxN/8V5Ud+A1pHHH8UYr4M
 Gex8NtrNybWtmBKKqRk24GwVAWqcJp+TE6Q41PMtgdnyBaVXEx9CPhTNvvRcmn09b4+y6ej3e3B
 f176vJu5KEekMIm6elJUBHwE3rnG9dWMtcAHHk5A==
X-Gm-Gg: AfdE7ckDg8Fl3rSwyZT0YZFuE0mlSUNzXuQ4Aek/9w15MhcbWfPQYxSwFp2E36NARM7
 3Z317YZluBwotoJZ4P8rcxpbU7k0wcsOeoVTjgL9sXr64eJYpPsjjH9Rym0oAN8Cql1is9Wq8In
 PUnLoLDUlOcEPGU3OtgBWADHRg+RaakJegiPYokO5hOR13Hn7bGO76l6IhxeSmjVEcJHzPgDykM
 0xX3fgG+wGhDcHN8NHAsqkzsw8oo+/gDxCTbs9H5o6hW/z4v9CytYWKOF0oAxaZdLVGMKidL8lZ
 aB+Ef00JIyizIDt8kDQgSZtyGXZhHFWAM/PeO5hfae07NPsd1Owmnr56JkKKhyh2dmR0t60+9G4
 5ew==
X-Received: by 2002:a05:622a:1a8a:b0:516:e6f3:c1f with SMTP id
 d75a77b69052e-51a55b21c1amr33071931cf.47.1782218894539; 
 Tue, 23 Jun 2026 05:48:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8a:b0:516:e6f3:c1f with SMTP id
 d75a77b69052e-51a55b21c1amr33071241cf.47.1782218893814; 
 Tue, 23 Jun 2026 05:48:13 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/18] Next patches
Date: Tue, 23 Jun 2026 08:47:41 -0400
Message-ID: <20260623124759.125399-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5fb:

  Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qemu into staging (2026-06-19 15:00:01 -0400)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to 1f3241bcaeee0df47f72edf6abad71fe36f3b0e7:

  system/physmem: make ram_block_discard_range() handle guest_memfd (2026-06-22 17:08:49 -0400)

----------------------------------------------------------------
Migration and mem pull request

- Maciej's patch to fix rare crash in VFIO multifd thread pool mgmt
- Peter's cleanup of @cpr-exec-command doc in migration.json
- Akihiko's patch to fix a TSAN warning on ram_list operations
- Bibo's migration-test coverage for loongarch
- Peter's update on a-b-boot image
- Marc-André's virtio-mem fix for CoCo

----------------------------------------------------------------

Akihiko Odaki (1):
  system/physmem: Synchronize ram_list accesses

Bibo Mao (1):
  tests/qtest/migration: Add migration test on loongarch

Gavin Shan (1):
  system/memory: Remove MAX_PHYS_ADDR

Maciej S. Szmigiero (1):
  thread-pool: Allow at least 1 thread in
    thread_pool_adjust_max_threads_to_work()

Marc-André Lureau (11):
  system/memory: split RamDiscardManager into source and manager
  system/memory: move RamDiscardManager to separate compilation unit
  system/memory: constify section arguments
  system/ram-discard-manager: implement replay via is_populated
    iteration
  virtio-mem: remove replay_populated/replay_discarded implementation
  system/ram-discard-manager: drop replay from source interface
  system/memory: implement RamDiscardManager multi-source aggregation
  system/physmem: destroy ram block attributes before RCU-deferred
    reclaim
  system/memory: add RamDiscardManager reference counting and cleanup
  tests: add unit tests for RamDiscardManager multi-source aggregation
  system/physmem: make ram_block_discard_range() handle guest_memfd

Peter Xu (3):
  qapi/migration: Remove @cpr-exec-command doc in MigrationParameter
  migration: Use OBJECT_DECLARE_SIMPLE_TYPE
  migration/tests: Update a-b-boot images for all archs

 MAINTAINERS                                   |    5 +
 qapi/migration.json                           |    4 -
 include/hw/vfio/vfio-container.h              |    2 +-
 include/hw/vfio/vfio-cpr.h                    |    2 +-
 include/hw/virtio/virtio-mem.h                |    3 -
 include/system/memory.h                       |  282 +---
 include/system/ram-discard-manager.h          |  358 +++++
 include/system/ramblock.h                     |    5 +-
 migration/migration.h                         |    9 +-
 tests/qtest/migration/aarch64/a-b-kernel.h    |    2 +
 tests/qtest/migration/bootfile.h              |    4 +
 tests/qtest/migration/i386/a-b-bootblock.h    |    2 +
 .../qtest/migration/loongarch64/a-b-kernel.h  |   20 +
 tests/qtest/migration/ppc64/a-b-kernel.h      |    2 +
 tests/qtest/migration/s390x/a-b-bios.h        |  272 ++--
 accel/kvm/kvm-all.c                           |    2 +-
 hw/vfio/cpr-legacy.c                          |    4 +-
 hw/vfio/listener.c                            |   10 +-
 hw/virtio/virtio-mem.c                        |  259 +---
 migration/migration.c                         |    7 +-
 migration/ram.c                               |   16 +-
 system/memory.c                               |   88 +-
 system/memory_mapping.c                       |    4 +-
 system/physmem.c                              |   43 +-
 system/ram-block-attributes.c                 |  255 +---
 system/ram-discard-manager.c                  |  612 ++++++++
 target/i386/kvm/tdx.c                         |    2 +-
 tests/qtest/migration/bootfile.c              |    4 +
 tests/qtest/migration/framework.c             |    6 +
 tests/unit/test-ram-discard-manager-stubs.c   |   48 +
 tests/unit/test-ram-discard-manager.c         | 1235 +++++++++++++++++
 util/thread-pool.c                            |    2 +-
 rust/bindings/system-sys/lib.rs               |    2 +-
 system/meson.build                            |    1 +
 system/trace-events                           |    2 +-
 tests/qtest/meson.build                       |    3 +-
 tests/qtest/migration/Makefile                |    4 +-
 tests/qtest/migration/loongarch64/Makefile    |   20 +
 .../qtest/migration/loongarch64/a-b-kernel.S  |   46 +
 tests/unit/meson.build                        |    8 +-
 40 files changed, 2656 insertions(+), 999 deletions(-)
 create mode 100644 include/system/ram-discard-manager.h
 create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.h
 create mode 100644 system/ram-discard-manager.c
 create mode 100644 tests/unit/test-ram-discard-manager-stubs.c
 create mode 100644 tests/unit/test-ram-discard-manager.c
 create mode 100644 tests/qtest/migration/loongarch64/Makefile
 create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.S

-- 
2.54.0


