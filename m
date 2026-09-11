Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F9EC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x55gY-0005RG-6d; Fri, 11 Sep 2026 14:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gP-0005Op-8s
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:05 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gM-0000Gi-Bw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 1C8D8C0B5E;
 Fri, 11 Sep 2026 21:09:00 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:641::1:4])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id u8VTLcTagiE0-JE55Oi4i; Fri, 11 Sep 2026 21:08:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789150139;
 bh=fWay2CtptdPUxMr7RhcMr4lua84eW9BE1W+kNA3m5gk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=oZIaMDO9yJCLcicInz2Hzyv6oGERlGkHcAIj7VrO6yKzlUiWwo3ZI3AwerRUsGF4+
 6tdnT8mgiWJocGA9l6ytYjmkGMG3LDDDG2Pc2zvc84cGVr5RTayvME7vBqXGaGbs6G
 WeMrpQFywzpFkwOfAc11oErK1fTeFu0iy9ZwtF8U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, sgarzare@redhat.com,
 mst@redhat.com, jag.raman@oracle.com, elena.ufimtseva@oracle.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 4/4] util/event_notifier: assert that init_fd receives a valid
 fd
Date: Fri, 11 Sep 2026 21:08:54 +0300
Message-ID: <20260911180854.123969-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911180854.123969-1-vsementsov@yandex-team.ru>
References: <20260911180854.123969-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

An initialized EventNotifier must have a nonnegative descriptor. Callers
can use the initialized flag to represent an absent notifier instead of
initializing it with a negative fd.

Assert this precondition in event_notifier_init_fd() now that IOHub and
shadow virtqueues no longer pass negative placeholder descriptors.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 util/event_notifier-posix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 34a2716dbf2..c6d2caaf9ff 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -27,6 +27,7 @@
  */
 void event_notifier_init_fd(EventNotifier *e, int fd)
 {
+    assert(fd >= 0);
     e->rfd = fd;
     e->wfd = fd;
     e->initialized = true;
-- 
2.43.0


