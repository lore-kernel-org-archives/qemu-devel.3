Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F363D1125892
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0POw-0001EZ-Um; Wed, 11 Mar 2026 15:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POq-0000R2-Vb; Wed, 11 Mar 2026 15:39:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POp-0000k6-En; Wed, 11 Mar 2026 15:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257670; bh=zsJdKC1oSdqH86t/OM5dqP2jvqDdEPy1KD1EWd5IWzA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MQ01ITpDHruRhKGxZgli2OIptjhl2XQEx+31EdTzj1+6hDwLDOSQ5/w8VTkRgCpZa
 MVSi6ld1Um3agz6uBbv/xpt21/o7Ou4q1j97PhIO8jGOElsJMiMjD0IJZi+BCsgx9A
 8U+v173HGFQgHPfn6KAPIa8n/gcBTKV5EViracu8iL+nL7dVpw1iELjamCyrmtq9oZ
 CVV8SVjLCpYyMxKgyKaCm91ufZXcrnLRu+WVQgtSrqLa0GO3Z1r81NsWUyyLb04VNg
 4Sa04XCHospHES4pcaSj2IY6SJUAFT0Az0lrt2VrJngM5iHvNw0HUP43WYKqVJlHd+
 9lNUDG6DUu6gA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1F64B192118;
 Wed, 11 Mar 2026 22:34:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5727437C47D;
 Wed, 11 Mar 2026 22:35:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andreas Schwab <schwab@suse.de>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 48/53] linux-user: fix TIOCGSID ioctl
Date: Wed, 11 Mar 2026 22:34:41 +0300
Message-ID: <20260311193449.1096110-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Andreas Schwab <schwab@suse.de>

TIOCGSID is IOC_R, not IOC_W.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 6a1221614fd9344a22cafea78e48d6ded95f317d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 6ecfe6306e..5b7d00e92f 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -26,7 +26,7 @@
      IOCTL(TIOCSCTTY, 0, TYPE_INT)
      IOCTL(TIOCGPGRP, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(TIOCSPGRP, IOC_W, MK_PTR(TYPE_INT))
-     IOCTL(TIOCGSID, IOC_W, MK_PTR(TYPE_INT))
+     IOCTL(TIOCGSID, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(TIOCOUTQ, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(TIOCSTI, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(TIOCMGET, IOC_R, MK_PTR(TYPE_INT))
-- 
2.47.3


