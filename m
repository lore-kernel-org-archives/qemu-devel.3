Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BEEC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDu3-00026R-SL; Wed, 12 Feb 2025 09:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDu1-00026I-Uf
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:39:50 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDtz-0007zC-JR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:39:49 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a4:0:640:7b31:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E170D6117F;
 Wed, 12 Feb 2025 17:39:42 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b518::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ddQHZB0Id8c0-2vXIFM6L; Wed, 12 Feb 2025 17:39:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739371182;
 bh=sbO7GXompC/Vaw0pJENt/+KvT004eLssTuG38vMXEz4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=pH6sys8cS2NasgGjd2BHfLRusV4URcYXORFrVGkH9U5LuTMLT2FuqHf04ZbD/J0bO
 y3fAr/zfP5gNN8Iw76Z2DQAWUWn+mw1KoDAKKO4rrLCRAPXMb09tY3yvvcF6KKoPJb
 FN2UzxwOSj5FbYw9+Jw7r0WnvIjQA2SUH8sswCDM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH v5 0/4] overcommit: introduce mem-lock-onfault
Date: Wed, 12 Feb 2025 17:39:16 +0300
Message-Id: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, passing mem-lock=on to QEMU causes memory usage to grow by
huge amounts:

no memlock:
    $ ./qemu-system-x86_64 -overcommit mem-lock=off
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    45652

    $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    39756

memlock:
    $ ./qemu-system-x86_64 -overcommit mem-lock=on
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    1309876

    $ ./qemu-system-x86_64 -overcommit mem-lock=on -enable-kvm
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    259956

This is caused by the fact that mlockall(2) automatically
write-faults every existing and future anonymous mappings in the
process right away.

One of the reasons to enable mem-lock is to protect a QEMU process'
pages from being compacted and migrated by kcompactd (which does so
by messing with a live process page tables causing thousands of TLB
flush IPIs per second) basically stealing all guest time while it's
active.

mem-lock=on helps against this (given compact_unevictable_allowed is 0),
but the memory overhead it introduces is an undesirable side effect,
which we can completely avoid by passing MCL_ONFAULT to mlockall, which
is what this series allows to do with a new option for mem-lock called
on-fault.

memlock-onfault:
    $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    54004

    $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault -enable-kvm
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    47772

You may notice the memory usage is still slightly higher, in this case
by a few megabytes over the mem-lock=off case. I was able to trace this
down to a bug in the linux kernel with MCL_ONFAULT not being honored for
the early process heap (with brk(2) etc.) so it is still write-faulted in
this case, but it's still way less than it was with just the mem-lock=on.

Changes since v1:
    - Don't make a separate mem-lock-onfault, add an on-fault option to mem-lock instead

Changes since v2:
    - Move overcommit option parsing out of line
    - Make enable_mlock an enum instead

Changes since v3:
    - Rebase to latest master due to the recent sysemu -> system renames

Changes since v4:
    - Fix compile errors under FreeBSD and MacOS

Daniil Tatianin (4):
  os: add an ability to lock memory on_fault
  system/vl: extract overcommit option parsing into a helper
  system: introduce a new MlockState enum
  overcommit: introduce mem-lock=on-fault

 hw/virtio/virtio-mem.c    |  2 +-
 include/system/os-posix.h |  2 +-
 include/system/os-win32.h |  3 ++-
 include/system/system.h   | 12 ++++++++-
 meson.build               |  6 +++++
 migration/postcopy-ram.c  |  4 +--
 os-posix.c                | 14 +++++++++--
 qemu-options.hx           | 14 +++++++----
 system/globals.c          | 12 ++++++++-
 system/vl.c               | 52 +++++++++++++++++++++++++++++++--------
 10 files changed, 97 insertions(+), 24 deletions(-)

-- 
2.34.1


