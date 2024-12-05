Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107CEE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJL8O-000566-In; Thu, 05 Dec 2024 18:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tJL8M-00055f-CU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:19:46 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tJL8I-0000Wb-RM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:19:46 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:44a0:0:640:8777:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D607B60A98;
 Fri,  6 Dec 2024 02:19:34 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6b8:b081:19::1:8])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id UJrB130IfiE0-NncImZyA; 
 Fri, 06 Dec 2024 02:19:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733440774;
 bh=JUoFTttEF3Deo7ER7IKccgih/eqluYY8jvvlagW8rA4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=RUYZq7MkkSpDKc0uq83E21jYGHO9q0OOi+lySrnMSydcpJUvvc0zKwkpGETW2F6zW
 amlwePFuA0JD7xTiXhOLaryM2bEKjEqU6gvhxA3+jj49qkyYol6iFTsJhfnTq7nyjU
 bt1uW08J0oQx3mTU75GQXx8jMB+40vNwirxDS7l8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] overcommit: introduce mem-lock-onfault
Date: Fri,  6 Dec 2024 02:19:06 +0300
Message-Id: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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
    $ qemu-system-x86_64 -overcommit mem-lock=off
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    45652

    $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    39756

memlock:
    $ qemu-system-x86_64 -overcommit mem-lock=on
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
is what this series allows to do with a new command line option called
mem-lock-onfault.

memlock-onfault:
    $ qemu-system-x86_64 -overcommit mem-lock-onfault=on
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    54004

    $ ./qemu-system-x86_64 -overcommit mem-lock-onfault=on -enable-kvm
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    47772

You may notice the memory usage is still slightly higher, in this case
by a few megabytes over the mem-lock=off case. I was able to trace this
down to a bug in the linux kernel with MCL_ONFAULT not being honored for
the early process heap (with brk(2) etc.) so it is still write-faulted in
this case, but it's still way less than it was with just the mem-lock=on.

Daniil Tatianin (2):
  os: add an ability to lock memory on_fault
  overcommit: introduce mem-lock-onfault

 include/sysemu/os-posix.h |  2 +-
 include/sysemu/os-win32.h |  3 ++-
 include/sysemu/sysemu.h   |  1 +
 migration/postcopy-ram.c  |  4 ++--
 os-posix.c                | 10 ++++++++--
 qemu-options.hx           | 13 ++++++++++---
 system/globals.c          |  1 +
 system/vl.c               | 18 ++++++++++++++++--
 8 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.34.1


