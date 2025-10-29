Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED09CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDzRC-0000fg-Eg; Wed, 29 Oct 2025 02:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDzQz-0000Yx-Ne
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:13:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDzQr-0006qQ-0J
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:13:24 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59T6CsDP077258
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Oct 2025 15:13:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=MihL8Imz3Qp93peEgHj8rvypE9CkuftylkJLKRLgtoo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1761718383; v=1;
 b=YTW8J7WGNqNWm/GY/SlQBDAWL1faan4/ZaU5uvlMZYtJ1ywxk00iEtdrVZuERsZF
 uweM3xO1IJpFtrx3gmVR45YvvBkmDldpe/YaCja4Npeg1IVgiKP5He01mw7V/dRI
 EOpuW5hqp6ekEhbtBOv8qaYLLPdUZPPHqY/21/welIsdlCblSKoKtnp3elUc1YWi
 59Dg8Il40Dts+LRX20Tn+F2yd5/WAtddTiI8ZFU6nToiZhgJRidQUo8hyGhB0Xhz
 i44CYq4otlx5F3D1cPweFDmPscye3Um6O5JInr8gBs4B1EccjtnxGgYrC8P7db7r
 F5SNiXOLisxWtAA+uHNlgg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/5] virtio-gpu: Force RCU when unmapping blob
Date: Wed, 29 Oct 2025 15:12:44 +0900
Message-Id: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFywAWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3bT8ouTU+KLkUl0zQ7NkcxNjY3PjNHMloPqCotS0zAqwWdGxtbU
 AFMsok1sAAAA=
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
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Based-on: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH] rcu: Unify force quiescent state")

Unmapping a blob changes the memory map, which is protected with RCU.
RCU is designed to minimize the read-side overhead at the cost of
reclamation delay. While this design usually makes sense, it is
problematic when unmapping a blob because the operation blocks all
virtio-gpu commands and causes perceivable disruption.

Minimize such the disruption with force_rcu(), which minimizes the
reclamation delay at the cost of a read-side overhead.

Dmitry, can you see if this change makes difference?

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (5):
      futex: Add qemu_futex_timedwait()
      qemu-thread: Add qemu_event_timedwait()
      rcu: Use call_rcu() in synchronize_rcu()
      rcu: Wake the RCU thread when draining
      virtio-gpu: Force RCU when unmapping blob

 include/qemu/futex.h          |  29 ++++++--
 include/qemu/rcu.h            |   1 +
 include/qemu/thread-posix.h   |  11 +++
 include/qemu/thread.h         |   8 ++-
 hw/display/virtio-gpu-virgl.c |   1 +
 util/event.c                  |  34 ++++++++--
 util/qemu-thread-posix.c      |  11 +--
 util/rcu.c                    | 153 ++++++++++++++++++++++++------------------
 8 files changed, 163 insertions(+), 85 deletions(-)
---
base-commit: ee7fbe81705732785aef2cb568bbc5d8f7d2fce1
change-id: 20251027-force_rcu-616c743373f7

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


