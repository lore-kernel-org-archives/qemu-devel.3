Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D49CD3CCB2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 05:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgG4y-0006uT-Nr; Thu, 15 Jan 2026 00:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG4v-0006su-NZ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:39:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG4n-0004fB-Kg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:39:27 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60F5cwVa061416
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Jan 2026 14:39:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fTeyggx/dI4xbMSuG0TslJjx3WzvGbWT9CLiF/W9IK0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1768455547; v=1;
 b=DusKrq542FG4DC8bee0QFe8hxkvnpgC3onMJEbgfDAPT4E9lVFIs2QOGJBMmI2HS
 izGtRaLnClANMNPcOc4XFCV+5xyjZJTCmOAg+x2p8bqTYcGyhhqtm8o4d9ZlFOzw
 pU8Fxvwp9gOLVxLTdVrkv8/ssrwx5pPJl0IH0mKXfchWudUFIlhGbjKq5YE77y+C
 u09A4Nd0qfCX4ZkC5M0/bBDxm8STMUah4eVdfB3/hZ5ltaS4FRRb57a12WkLOhHj
 FaK/myn7D3lux0R+iy2rIjtCH4lVyXMwCcvOBzFsrO7vAWQV8sA3WEJm7drmP2Fj
 xqHSsHP6jj9ZbTPHBW+lvg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 0/5] virtio-gpu: Force RCU when unmapping blob
Date: Thu, 15 Jan 2026 14:38:49 +0900
Message-Id: <20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGl9aGkC/3XM3wqCMByG4VuRHbexP7ZZR91HRKyfm67AyaYjE
 e+9KUSedPh+fDwziiY4E9G5mFEwyUXnuxziUCBoddcY7OrciFN+ZJQrbH0Acw8wYskkqFIIJax
 C+d8HY917s6633K2Lgw/TRie2rl/ltFMSwxQ/bCWpllwpLS8hNgQccWTEg39Nnmggzx6tZOI/h
 jOxZ3hmWG0Y6KoEWf9nlmX5AE64Ox/2AAAA
X-Change-ID: 20251027-force_rcu-616c743373f7
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
  Tested-by: from the previous version was not collected because this
  changes the logic significantly.
- Merged the rcu_call_count and forced variables into one to avoid
  the race between them that used to require a loop to resolve.
- Aligned the type of the duration variable in qemu_futex_timedwait()
  for Windows.
- Fixed timespec of qemu_futex_timedwait() for 32-bit Linux.
- Link to v1: https://lore.kernel.org/qemu-devel/20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (5):
      futex: Add qemu_futex_timedwait()
      qemu-thread: Add qemu_event_timedwait()
      rcu: Use call_rcu() in synchronize_rcu()
      rcu: Wake the RCU thread when draining
      virtio-gpu: Force RCU when unmapping blob

 include/qemu/futex.h          | 36 +++++++++++++---
 include/qemu/rcu.h            |  1 +
 include/qemu/thread-posix.h   | 11 +++++
 include/qemu/thread.h         |  8 +++-
 hw/display/virtio-gpu-virgl.c |  1 +
 util/event.c                  | 28 ++++++++++---
 util/qemu-thread-posix.c      | 11 +----
 util/rcu.c                    | 98 ++++++++++++++++++++++++-------------------
 8 files changed, 131 insertions(+), 63 deletions(-)
---
base-commit: fba5c49719875145f1dcb44fbe85f541a47805c6
change-id: 20251027-force_rcu-616c743373f7

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


