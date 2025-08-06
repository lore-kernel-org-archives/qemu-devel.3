Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA98C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhAx-0002P5-8R; Wed, 06 Aug 2025 12:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ujg5Q-0000Qb-90
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ujg5O-0000Fu-J8
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754494188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TgrchmPCcxWZE5JRTmn1h7oP3WhsqECrwNMByBWHJo4=;
 b=LyYJSHrs6jhuT/MSVTWz3A6uyvs6TmwvGJl4TOqEfkgp62p+hRyRcGaRwCmL6XG8wjqhIL
 31S4wlGVb212aiR53+uKGsRAAwK7fhVzOvFPPIQ4SY5ZM83hcGS29c3osS52X1PyEpDvtZ
 CL68Knw+lZyRAZ8Ci4b0nKqHg8q4lNE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-Wq9s8mI_OLuAV94I7HzI3Q-1; Wed,
 06 Aug 2025 11:29:46 -0400
X-MC-Unique: Wq9s8mI_OLuAV94I7HzI3Q-1
X-Mimecast-MFC-AGG-ID: Wq9s8mI_OLuAV94I7HzI3Q_1754494185
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0B651955EC3; Wed,  6 Aug 2025 15:29:44 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.81])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 449303000198; Wed,  6 Aug 2025 15:29:41 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
Date: Wed,  6 Aug 2025 17:29:40 +0200
Message-ID: <20250806152940.362418-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

A race condition between guest driver actions and QEMU timers can lead
to an assertion failure when the guest switches the e1000e from legacy
interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
RDTR) is active, but the guest enables MSI-X before the timer fires,
the pending interrupt cause can trigger an assert in
`e1000e_intmgr_collect_delayed_causes()`.

The function's assertion (`assert(core->delayed_causes == 0)`)
incorrectly assumes that it's impossible for a legacy delayed interrupt
to be pending once the device is in MSI-X mode.

This behavior is incorrect. On a physical device, a driver-initiated
mode switch would mask interrupts, reconfigure the hardware, and clear
any stale interrupt states. The legacy delay timers (TIDV/RDTR) are not
used for moderation in MSI-X mode; the Interrupt Throttle Rate (ITR)
mechanism is used instead. Therefore, any pending interrupt from the
old mode should be ignored.

Replace the overly strict assertion with a statement that clears any
stale `delayed_causes`. This correctly models the hardware's behavior
of discarding obsolete interrupt events during a mode change and
prevents the QEMU process from terminating.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1863
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/e1000e_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 24138587905b..d0ec892488d4 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -342,7 +342,7 @@ e1000e_intmgr_collect_delayed_causes(E1000ECore *core)
     uint32_t res;
 
     if (msix_enabled(core->owner)) {
-        assert(core->delayed_causes == 0);
+        core->delayed_causes = 0;
         return 0;
     }
 
-- 
2.49.0


