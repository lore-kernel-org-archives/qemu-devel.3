Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30F6D59F6D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 05:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUIOD-00061S-Ck; Sat, 13 Dec 2025 00:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vUIO8-00060N-M9
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 00:41:53 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vUIO5-0002lq-IY
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 00:41:52 -0500
Received: from [10.200.7.128] (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BD5fMh4021206
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 13 Dec 2025 14:41:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hhQtYxJkiZ1Udf1cmpL+dQs6MdP+kU8frJpKL7LDR4k=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1765604495; v=1;
 b=g7ss70VSmdSIbnhyyj0HkUwrSDKIDGKSppxkrIB3C1MS/Pey2hS48VaT0wpNINMd
 oaErVkiMyS78TQ5bCEwGfBWsD57QeO6ob203DATqgDBUZI2leUKffdhMiDaOtxMg
 tzAd4Q4hWkLbP68hzuZlHoVLJRqCTJq4uBSEt6wLlaK7N0Kdzs+dJNuq0n3QtaLf
 IgOSMLTzmZFFLRK0GxpEOmPa5artcRbOddpAEZPRD+v2FFiHaKKVURNPF1xirgV4
 yxkKKA4WlOmxZUiVNrbI3oh2davUDewxAZa7CZ7EWu+IOkTlelg5BoyxHEzJsuzH
 61fg7OnkMEAgtcn+BTGnoQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 0/6] virtio-gpu: Force RCU when unmapping blob
Date: Sat, 13 Dec 2025 14:41:19 +0900
Message-Id: <20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/8PGkC/03MywrCMBCF4VcpszYhF03Ule8hRWJM2lFoyqQtl
 tJ3NxYEl//h8C2QA2HIcK4WoDBhxtSVULsKfOu6JjB8lAYl1EEKZVlM5MON/MiMNN7utbY6Wij
 /nkLE92Zd69It5iHRvNGT/K4/5fSnTJIJdo9HI5xR1jpzodxwjxz5yIb0mhN3nj97qNd1/QDg/
 0jLrwAAAA==
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

Unmapping a blob changes the memory map, which is protected with RCU.
RCU is designed to minimize the read-side overhead at the cost of
reclamation delay. While this design usually makes sense, it is
problematic when unmapping a blob because the operation blocks all
virtio-gpu commands and causes perceivable disruption.

Minimize such the disruption with force_rcu(), which minimizes the
reclamation delay at the cost of a read-side overhead.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
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
Akihiko Odaki (6):
      timer: Rename init_clocks() to qemu_clock_init()
      futex: Add qemu_futex_timedwait()
      qemu-thread: Add qemu_event_timedwait()
      rcu: Use call_rcu() in synchronize_rcu()
      rcu: Wake the RCU thread when draining
      virtio-gpu: Force RCU when unmapping blob

 include/qemu/futex.h              | 34 ++++++++++++--
 include/qemu/rcu.h                |  1 +
 include/qemu/thread-posix.h       | 11 +++++
 include/qemu/thread.h             |  8 +++-
 include/qemu/timer.h              |  4 +-
 hw/display/virtio-gpu-virgl.c     |  1 +
 tests/unit/test-aio-multithread.c |  2 +-
 util/event.c                      | 28 +++++++++--
 util/main-loop.c                  |  2 +-
 util/qemu-thread-posix.c          | 11 +----
 util/qemu-timer.c                 |  7 +--
 util/rcu.c                        | 98 ++++++++++++++++++++++-----------------
 12 files changed, 137 insertions(+), 70 deletions(-)
---
base-commit: 466e779e05b5087bffe39ecc51ec97fdf9121e8b
change-id: 20251027-force_rcu-616c743373f7

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


