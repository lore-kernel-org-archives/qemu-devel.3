Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A19DC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0do-000586-R6; Wed, 29 Jul 2026 05:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dm-000571-D8
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:54 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dj-0007kh-TW
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 6292BC0A16;
 Wed, 29 Jul 2026 12:31:48 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id kVacraKWFGk0-bFoU36hc; Wed, 29 Jul 2026 12:31:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785317507;
 bh=lT6x49rCgMcKUxA2joZ8Kg0kOzDg2rmq4tXt5gh8gno=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=WAi5mXggKJ9ZobV7sksMIc9cZYtC9pKqk3HimhhxQKYMEEeJuWThedU1oQ1xlMrs2
 50AVqRW2L6eyR6ZGBGunKFaV7/2NIKkX7FFYgHt3WX3CUejqhOws4z3BGodvx9Dk94
 YzNsDYhO+eF5QQD5CDFMTTzQ0NYj4xLPYXoDmNGM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: [RFC PATCH 0/5] tests: CPR-test-cases for live-TAP local migration
Date: Wed, 29 Jul 2026 12:31:40 +0300
Message-ID: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

Two new test cases to show that "local" TAP migration works
with both cpr-exec and cpr-transfer.

The series is marked as RFC, because I don't like the design (touching
internal fields, etc.). Testing cpr-exec is not a simple thing.

Still, I think, I can rework it to better design if needed.

I don't want to merge this into main series, as it already large
enough.

Based-on: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
  "[PATCH v20 00/15] virtio-net: live-TAP local migration"

Pushed to:
    https://gitlab.com/vsementsov/qemu.git
      tag: up-tap-fd-migration-cpr-test-cases-v1

To run the test, use sudo, as test needs to configure TAP device:

    sudo PYTHONPATH=python:tests/functional \
    QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 \
    MESON_BUILD_ROOT=$PWD/build \
    ./build/pyvenv/bin/python3 tests/functional/x86_64/test_tap_migration.py

Vladimir Sementsov-Ogievskiy (5):
  python/qemu/machine: add possibility to postpone qmp connect
  tests/functional/qemu_test: drop *args argument from .get_vm()
  python/machine.py: store qemu console fd before closing
  tests/testcase.py: passthrough monitor_address
  test_tap_migration: add cpr test cases

 python/qemu/machine/machine.py                |  55 ++--
 tests/functional/migration.py                 |   3 +-
 tests/functional/qemu_test/testcase.py        |  12 +-
 tests/functional/x86_64/test_tap_migration.py | 251 ++++++++++++++++--
 4 files changed, 267 insertions(+), 54 deletions(-)

-- 
2.43.0


