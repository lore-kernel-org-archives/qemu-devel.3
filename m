Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EACBFE51F3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCq1-0000L4-Kk; Fri, 24 Apr 2026 05:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGCp5-0007Q7-02
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:27:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGCoz-0007a9-Sl
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:27:42 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63O9RHIc004358
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Apr 2026 18:27:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=lX2DrJ15GFa+OK9kpXU5Omtv6JD2l+5NZcELVoCPJXY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1777022846; v=1;
 b=pxhTFz/34d+qzWUPkKOAl9qnQxQfGAWOTTRUdWAK/VRv7TzRScTi0MgCJrAp39do
 H8JV77fij5ko3LVHP3tkaoAlXXdAq+bVmu5EpWjuxdm2GT8r8y13qbGnLOKOzKom
 xwp2r4vnixZHM9+rcOQoVJjT3nrfeAux4dOXLyoKzhjSrZRA2cv14jC8rkByb7cJ
 UWN7qidvrY6u5UjtH3uBBbdCL8OPJlHyhkTHLzQV4/2nQFbPIHtIasDtvTgqAAjV
 Hc23WVwZzH75v0LGpki4QyX5OcpT2KWM+hkDLxcJyxyhp6hnswgInBkBGA4NBIpU
 TbZUkQeflPjhNN1PyltV9g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 0/6] virtio-gpu: Force RCU when unmapping blob
Date: Fri, 24 Apr 2026 18:27:05 +0900
Message-Id: <20260424-force_rcu-v4-0-feccfaca0568@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33M0QrCIBiG4VsZHqf466aro+4jIpzTZsEcWtIYu
 /fcINpJHb4fH8+EognORHQoJhRMctH5Pke5K5DuVH812LW5EaOsAsoktj5ocwn6iQUILUvOJbc
 S5f8QjHWv1Tqdc3cuPnwYVzrBsn6U/UZJgClubC2oEkxKJY4hXol2xJEnfvj76InS5DaghUzsy
 zDgW4ZlBloDWtWlFu1/hn8YQQGqLcMXxtaNVdaWNVQ/mXme3z/6d4c9AQAA
X-Change-ID: 20251027-force_rcu-616c743373f7
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Unmapping a blob changes the memory map, which is protected with RCU.
RCU is designed to minimize the read-side overhead at the cost of
reclamation delay. While this design usually makes sense, it is
problematic when unmapping a blob because the operation blocks all
virtio-gpu commands and causes perceivable disruption.

Minimize such the disruption with force_rcu(), which minimizes the
reclamation delay at the cost of a read-side overhead.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v4:
- Keep qemu_event_wait() retrying so it preserves wait-forever
  semantics.
- Add "scripts/checkpatch: Avoid false positive on empty blocks" to
  cover the empty wait loop introduced by
  "qemu-thread: Add qemu_event_timedwait()".
- Link to v3: https://lore.kernel.org/qemu-devel/20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp

Changes in v3:
- Fix immediate timeout in qemu_futex_timedwait() for Windows.
- Dropped patch "timer: Rename init_clocks() to qemu_clock_init()".
- Link to v2: https://lore.kernel.org/qemu-devel/20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp

Changes in v2:
- Stopped overloading the call_rcu1() and force_rcu() notifications onto
  one event. This fixes a deadlock after try_dequeue() caused by
  incorrect masking of call_rcu1() notifications, and eliminates
  spurious force quiescent states caused by being confused with a
  call_rcu1() notification.
  changes the logic significantly.
- Merged the rcu_call_count and forced variables into one to avoid
  the race between them that used to require a loop to resolve.
- Aligned the type of the duration variable in qemu_futex_timedwait()
  for Windows.
- Fixed timespec of qemu_futex_timedwait() for 32-bit Linux.
- Link to v1: https://lore.kernel.org/qemu-devel/20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (6):
      futex: Add qemu_futex_timedwait()
      qemu-thread: Add qemu_event_timedwait()
      rcu: Use call_rcu() in synchronize_rcu()
      rcu: Wake the RCU thread when draining
      virtio-gpu: Force RCU when unmapping blob
      scripts/checkpatch: Avoid false positive on empty blocks

 include/qemu/futex.h          | 36 +++++++++++++---
 include/qemu/rcu.h            |  1 +
 include/qemu/thread-posix.h   | 11 +++++
 include/qemu/thread.h         |  9 +++-
 hw/display/virtio-gpu-virgl.c |  1 +
 util/event.c                  | 31 +++++++++++---
 util/qemu-thread-posix.c      | 11 +----
 util/rcu.c                    | 98 ++++++++++++++++++++++++-------------------
 scripts/checkpatch.pl         |  3 +-
 9 files changed, 137 insertions(+), 64 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20251027-force_rcu-616c743373f7

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


