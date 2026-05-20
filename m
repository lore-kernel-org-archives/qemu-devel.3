Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE792CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYL-0000x0-Db; Wed, 20 May 2026 17:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYK-0000wq-Az
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYI-00077d-FE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3BsNqJu1R7ooa5iYn9h/mr67f7YjQnrlrdINHf4i/e0=;
 b=QpFvS518iJH6ZfaRGHn9kUzFCQTQX2x7oagElOWPlnc6PmQR5uN6e9g+fORoatK24Yzxhf
 x3OjvnYSZHW8E6BXxbvBdSdGANKC5lWcXqLWYHeVeBBh4b1+SEiJjpAhGwHgGi06wZvmLa
 DNCcny4HMCa3/G28bU1Wd0tc06qMQlw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-GN8dE76jMFG9OyZ80MoURg-1; Wed, 20 May 2026 17:34:02 -0400
X-MC-Unique: GN8dE76jMFG9OyZ80MoURg-1
X-Mimecast-MFC-AGG-ID: GN8dE76jMFG9OyZ80MoURg_1779312841
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8c3bdb60dadso24075756d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312841; x=1779917641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3BsNqJu1R7ooa5iYn9h/mr67f7YjQnrlrdINHf4i/e0=;
 b=XZYbP40GV1zDCdyndjMRvpsuSI5A6GHuDsktJ1+owFJYtMaQPqoEjuYpWUK/U2qqU0
 jJwDQOaQ6VupKXOCNaSS05htIodSJnu13QUJjHBiN+BR66LpPE4lwDcI6L4jSxTtjoa4
 FCj3sWa1ZxzFhQeBt2MTH5ZeKlfpkJqUzSqKtYiYG5lhwxU+oXIXH3G4k4sMIGAAfiXv
 Uu/BOBFL/ahXky2B2i0Piqioig149s8CsuI1LxqfpllEO6DTa66KzXGVQex4L/ylAyWz
 8vbUZ6cJais+GfBHXiF1ABBwAP0bZTVWa1Kfp1XIVcH74ZlDk8BOQt2pvfI+Exs60O4w
 UTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312841; x=1779917641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BsNqJu1R7ooa5iYn9h/mr67f7YjQnrlrdINHf4i/e0=;
 b=RFPOQpFv7u1DHFktuT6pKrj36fhn95uUzxXS/KGTO5V3rjneeUR7Lij2BuQH+wxlUl
 YBalCcHofEH9LkKzehYmKgDEXbh46olFGJyGxxxIico88rdXlK9fbk2j4NxPUDi+JMTK
 YLF9rRsXHWA7twetc4Hd10qejChbKaWlw/olxL8VRfHk/iu+hG57eoWL4mWlgZrXGkMm
 8upRw6sj/TRqfDxTSk8lOMNJnHoX9D+qovpIygnYky0tzDc+3gskTg9UfQExC79yGmAI
 EfNqwZQMHWT6M4c0gEZUmz1e5RltIhD5vfyIOf40RoKigTghtqu9/+i0wjjKSvxEu7iy
 nEag==
X-Gm-Message-State: AOJu0Yzf4Xk9w+mHZNut2hD4rATlA2aV2d3OpjgHdxH0eniXbNalDS4V
 EL6sYr2XU576Xck9YnwzbclOffYw80fbOV2czjajqWxDoExkyLoC2OZs+AKIysSRcjb//4Oz9s3
 AXTsGzNs7y53QzufQATkIx86HgDLUk1ORfDOIyFJRV7rXsFhJNJVGfhk0rgGfpOd4+ZkzCMeaJV
 3p1M/b58dBnf7pTQkalqfCANRXeNCgaAoW32GhIQ==
X-Gm-Gg: Acq92OHSwUyL8G/gwQTNQHCmt3tbrwLPRir2rAZOJZ1zCBqJXoTGWxjIYe21k3q3+r5
 uJjcKYzjyzAk7aBI9YPxWo+gyaJ56ao2PP5iacBShbvUKwfohHcc/AURJkI6Z++VynDFstVM/xT
 nM/GjWgzjmlL5jaa2N07Ec937smYPPXm+cHPbOOQ764XgOuFADZLVBvIY4uDI9L50Y3XY46B2hi
 H9CFxf7vvuoEyZpH6K1tqQuJujJwn+Lux0LHDppYXJoVSOMUrvkuPf8HE8jSgd341m2OQLZRtgV
 WNAkgOI0PYKke0+oPBxv0eqcSJRkrbAjVuBw9ibO1kgkW+2D6sWGUIr1f2GWA6Yvh9A1Pw2BwKX
 9z9vQ06RlnDlDX/PxlJ89eMkUzJ1tQq5e3Ha+EJLpw1jK
X-Received: by 2002:ad4:5ce8:0:b0:8cc:d61:3559 with SMTP id
 6a1803df08f44-8cc6e6b2b46mr3461616d6.46.1779312841301; 
 Wed, 20 May 2026 14:34:01 -0700 (PDT)
X-Received: by 2002:ad4:5ce8:0:b0:8cc:d61:3559 with SMTP id
 6a1803df08f44-8cc6e6b2b46mr3460946d6.46.1779312840714; 
 Wed, 20 May 2026 14:34:00 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:33:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 00/29] Next patches
Date: Wed, 20 May 2026 17:33:28 -0400
Message-ID: <20260520213357.40646-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 343a88cb022e5cdb1d839a0499f9a33f8614598d:

  Merge tag 'firmware-20260519-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-05-19 09:28:07 -0400)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to 7a4b1c333ffe8358664430e1f5a676e1dee7175c:

  MAINTAINERS: Update email of Yong Huang (2026-05-20 17:01:37 -0400)

----------------------------------------------------------------
Migration and mem pull request

- Peter's fix on 2nd migration crashing if the 1st migration cancelled early
- Phil's patch to remove VMS_MULTIPLY_ELEMENTS across tree
- Peter's fix on possible division by zero in recent query-migrate change
- Aadeshveer's cleanup for current_migration references
- Fabiano's fix of auto-converge test
- Maciej's maintainer file update for CPR
- Fabiano's migration qtest refactor to stick with -incoming defer
- Bin's cleanup / fix series all over migration (part of)
- hongmianquan's cpr optimization to use ghash for fd bookkeeping
- Yong's email address update

----------------------------------------------------------------

Aadeshveer Singh (1):
  migration: Replace current_migration with migrate_get_current()

Bin Guo (6):
  migration/global_state: replace strcpy("") with explicit NUL
    termination
  migration/vmstate: avoid per-element heap churn in vmsd ptr marker
    field
  migration/savevm: use stack-allocated bitmap in
    configuration_validate_capabilities
  migration/multifd: fix off-by-one in recv channel ID validation
  migration/multifd: cache migrate_multifd_channels() in send/recv hot
    paths
  migration/multifd: cache channel count in multifd_send_sync_main

Fabiano Rosas (16):
  tests/qtest/migration: Fix auto-converge test
  tests/qtest/migration: Move cpr transfer logic into cpr-tests.c
  tests/qtest/migration: Make file-tests defer by default
  tests/qtest/migration: Set file URI by default
  tests/qtest/migration: Group unix migration tests
  tests/qtest/migration: Use precopy_unix_common for ignore-shared test
  tests/qtest/migration: Use a default TCP URI for precopy
  tests/qtest/migration: Defer by default in precopy_common
  tests/qtest/migration: Set compression method in compression-tests
  tests/qtest/migration: Remove multifd compression hook
  tests/qtest/migration: Use defer for all tests
  tests/qtest/migration: Use defer for cpr-tests
  tests/qtest/migration: Use defer for auto-converge
  tests/qtest/migration: Use defer in dirty_limit test
  tests/qtest/migration: Stop passing URI into migrate_start
  tests/qtest/migration: Unify URIs

Hyman Huang (1):
  MAINTAINERS: Update email of Yong Huang

Maciej S. Szmigiero (1):
  MAINTAINERS: Make Maciej CPR maintainer

Peter Xu (2):
  migration: Fix crash on second migration when cancel early
  migration: Fix possible division by zero on calc expected downtime

Philippe Mathieu-Daudé (1):
  migration: Remove VMS_MULTIPLY_ELEMENTS and VMSTATE_VARRAY_MULTIPLY()

hongmianquan (1):
  migration/cpr: use hashtable for cpr fds

 MAINTAINERS                               |   5 +-
 include/migration/cpr.h                   |   1 +
 include/migration/vmstate.h               |  22 +---
 migration/migration.h                     |   5 +
 tests/qtest/migration/framework.h         |  26 ++--
 migration/cpr-transfer.c                  |  10 ++
 migration/cpr.c                           | 116 ++++++++++++++---
 migration/global_state.c                  |   2 +-
 migration/migration.c                     |  57 +++++++--
 migration/multifd.c                       |  27 ++--
 migration/savevm.c                        |   5 +-
 migration/vmstate.c                       |  45 +++----
 tests/qtest/migration/colo-tests.c        |  16 +--
 tests/qtest/migration/compression-tests.c |  34 ++---
 tests/qtest/migration/cpr-tests.c         |  85 ++++++++++---
 tests/qtest/migration/file-tests.c        |  56 +--------
 tests/qtest/migration/framework.c         |  91 +++++---------
 tests/qtest/migration/misc-tests.c        |  62 ++++------
 tests/qtest/migration/precopy-tests.c     | 144 ++++------------------
 tests/qtest/migration/tls-tests.c         | 110 ++---------------
 rust/bindings/migration-sys/lib.rs        |   8 --
 rust/migration/src/vmstate.rs             |   3 +-
 rust/tests/tests/vmstate_tests.rs         |  55 ---------
 23 files changed, 396 insertions(+), 589 deletions(-)

-- 
2.53.0


