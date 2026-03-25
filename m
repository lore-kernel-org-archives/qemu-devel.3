Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B470109C033
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RLw-0004n8-A7; Wed, 25 Mar 2026 12:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLr-0004hC-Fo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLo-0004PH-U4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4Z3hJrPqohCZ7xz0oBjIkGXpc7omqy6yqnrqsopU7Fg=;
 b=Dzm2ULQr0BknuW0jUhYtXGEUP/SPa0ybrY3xBQSm0c452Jn9Cr4a6WQd2LaE69mEIzOqic
 qISiAg6yIVZPVYENjln1ZnCrlYeT78k1LRphjdeYagl8tN+KHhu1ojlbzSSnlCXzojrPli
 BXhzXDeD5mMcdbcNr2szcgNNXCX7QkI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-k1TFGmWMMgqozXClgqRhMg-1; Wed, 25 Mar 2026 12:44:57 -0400
X-MC-Unique: k1TFGmWMMgqozXClgqRhMg-1
X-Mimecast-MFC-AGG-ID: k1TFGmWMMgqozXClgqRhMg_1774457096
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fe36cf73so758395e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457095; x=1775061895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Z3hJrPqohCZ7xz0oBjIkGXpc7omqy6yqnrqsopU7Fg=;
 b=GEKHdwz6m9h7aY3fg+wfUDTPrqR7M3ThyLiyewLnrEsPhsBZKgwWMvbPYqWt5Ntx+y
 4sP5fkg+WLJiOmEj4BLkavLf1M1yHGfyVc/tvHUUMPhU6PO36X92/Sk2OXOPAzIXdOaF
 DYiMmtfSRvol3IwJBvPe0wFH4Fh2FWoKvq9K0Ner1IMP/vcgVR2JKdqvNJoNIp4D2DPx
 GU0KmvCRI/GMkdMWrG8HdAmIsr/KKxdfBrU2+3Ltj3kKIEJGVUwGLe4fYB8LB2OHvMaK
 Tae2MZm5E+GVz1us13WATgL1qO5E0KhOmU1DemMXkyJt8oRKumBZfIVVdBOSBxQH90Vx
 6C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457095; x=1775061895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Z3hJrPqohCZ7xz0oBjIkGXpc7omqy6yqnrqsopU7Fg=;
 b=rq8mIFr7VwW9p1/N6nkWeW3BjifLBwF5kODv242DKdmof+kZyRnEhWZNKIlJUhBvZh
 4DCN6/ohVAirz5V3mZwn42Gi2aAYyiVr5nSra+4Q+PpTyrqV16lWCYb311hggWL6TbtL
 3u0F0EZGF6VYctbjAfPnXUNQCezs7JRPO2FH6LtHqQ4NsQfTi3t17rjaTPMLGr9ZnTiM
 XYgeWp8TLC5a5LRPqFcrUf03O2A/fiuyHXZm6d5rRyrf3PxnCTrS4kv+17cwiUZ7aoHZ
 4OKKwK2ogBjcX0XQyWnwKayFybfRUYgVQZ6evuFk3LUEU613xV490jgF3wUtKJ767fjI
 hpxQ==
X-Gm-Message-State: AOJu0YzbhfUK8Y03dTZ3b5/+mAQcsw6u/9KAf3cY28fq631CCttSEkZw
 91v1nA0C4a7GUGt2Z4KCQ8g2UiLun+Rao6SNTDzlPb+VMXFyvmNQDGRZBFx5akb1X3Uw1VIiXcF
 5hd+dOuM/tXJworyHWHnccKo62X2lsUPdeILiLwtJHkO+AMFI8skjC37J/Jc2a89buk8xkU5cwz
 Ldojs7JkhRP5LsxYjmCSe/mLkBP3B+K8gOGUDYAGuM
X-Gm-Gg: ATEYQzyiCJUFE9Q1KLZXUQflvXUSbiVSWz7ia16BRJUGj9tfOXkqSOa8VJnrnnFL+ZB
 3pde6vtiW2rf7a89BV2gw5+iPfiWKNCgZyFm93VxOZkbQk/bWVh0qGkmajnGKkXQT+uOutAWBpK
 Ub21dxssTagOkZNvbNjRdNhEDYVyg/c9KTbLU8g7Ee7zDiN+sjRkCjFZviziNJ37BZr1LUKyB8q
 2U3BwTUKKsMEPcmkFWeDu4W41JxXzFUplS0XasRhE/s8oKsGNTHZJ3mU9CwTNHsr/yHsJ8joNL3
 hTKP3wJODRj98hAi6bI++7bE6AmCNZnTp/UWyexgep8fqEXTnSUPNXqMRFyQEytQGjVSdKU7ojn
 JeSKvUoNCJx0t591pBUB1RTJnabh3y3OzXhweg39S0ohaY20Quhkbqa2x7Z0mh+GqGEArrl1qYb
 L1eYp2q9LLPbuFmaH3TCitQdVM
X-Received: by 2002:a05:600c:3154:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-4871608d862mr65928875e9.27.1774457095206; 
 Wed, 25 Mar 2026 09:44:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3154:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-4871608d862mr65928345e9.27.1774457094642; 
 Wed, 25 Mar 2026 09:44:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871738c16dsm23505835e9.30.2026.03.25.09.44.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:44:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] Fixes (including big i386/emulate performance
 improvement) for 11.0-rc
Date: Wed, 25 Mar 2026 17:44:34 +0100
Message-ID: <20260325164453.72127-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 8e711856d7639cbffa51405f2cc2366e3d9e3a23:

  Merge tag 'hppa-fixes-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-20 10:04:48 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to dfbc524fdd8932951791e78121be0ddca0529162:

  target/i386: emulate: follow priv_check_exempt (2026-03-25 17:43:41 +0100)

----------------------------------------------------------------
* tests/functional: preserve PYTHONPATH entries
* target/i386: show GMET feature
* target/i386/emulate, whpx/i386: on-demand access to runtime state, MMU fixes
* tdx: fix use-after-free in tdx_fetch_cpuid
* treewide: replace qemu_hw_version() with QEMU_HW_VERSION
* sb16: detect invalid migration stream

----------------------------------------------------------------
Alyssa Ross (1):
      tests/functional: preserve PYTHONPATH entries

Jenny Guanni Qu (1):
      hw/audio/sb16: validate VMState fields in post_load

Mohamed Mediouni (14):
      whpx: i386: workaround for Windows 10 support
      whpx: i386: enable exceptions VM exit only when needed
      whpx: i386: skip TSC read for MMIO exits
      whpx: i386: skip XCRs read for MMIO exits
      whpx: i386: don't restore segment registers after MMIO handling
      target/i386: emulate: add new callbacks
      whpx: i386: add implementation of new x86_emul_ops
      target/i386: emulate: indirect access to CRs
      whpx: i386: indirect access to CRs
      target/i386: emulate: segmentation rework
      whpx: i386: fetch segments on-demand
      whpx: i386: fast runtime state reads
      target/i386: emulate: set PG_ERROR_W_MASK as expected
      target/i386: emulate: follow priv_check_exempt

Paolo Bonzini (3):
      tdx: fix use-after-free in tdx_fetch_cpuid
      treewide: replace qemu_hw_version() with QEMU_HW_VERSION
      target/i386: expose AMD GMET feature

 include/hw/core/boards.h          |   6 -
 include/qemu/hw-version.h         |  18 +--
 target/i386/emulate/x86_emu.h     |   6 +
 hw/audio/sb16.c                   |   7 +
 hw/ide/core.c                     |   2 +-
 hw/scsi/megasas.c                 |   2 +-
 hw/scsi/scsi-bus.c                |   2 +-
 hw/scsi/scsi-disk.c               |   2 +-
 system/vl.c                       |   4 -
 target/i386/cpu.c                 |   2 +-
 target/i386/emulate/x86_helpers.c |  83 ++++++-----
 target/i386/emulate/x86_mmu.c     |  27 ++--
 target/i386/hvf/x86.c             |  11 ++
 target/i386/kvm/tdx.c             |   2 +-
 target/i386/whpx/whpx-all.c       | 284 ++++++++++++++++++++++++++++++++------
 target/s390x/cpu_models.c         |   2 +-
 util/osdep.c                      |  12 --
 tests/functional/meson.build      |  12 +-
 18 files changed, 343 insertions(+), 141 deletions(-)
-- 
2.53.0


