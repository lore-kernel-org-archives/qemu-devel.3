Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D81C112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBi-0000ul-BC; Wed, 11 Mar 2026 11:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8M-0002kx-FD; Wed, 11 Mar 2026 11:06:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8K-0004mj-Vf; Wed, 11 Mar 2026 11:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241306; bh=zsJdKC1oSdqH86t/OM5dqP2jvqDdEPy1KD1EWd5IWzA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rzdOQy6TTiooLLtteNAI/m8OMCF7btBK1UOD9LJ4Vh3jYCIVVKU8E+NEkLvhGoQhS
 EodMMvaep/vjlq30IWx0+CTX3jRm+CR8vA+nw8OitE3vblCzivX+z1HMTzv3kWGUNs
 O6RF/ZLBD1eajNVFIGkODI0jmXIZ0CvKI2OCzjcShw4fECV+QWoP+T2OluvoI1xU30
 AE/Nz1L2acuv59vraJE5loJmG7kd2L5A0OL1VX2comqdu+LtQxIlzM7KqUUb80NvmP
 Cug/jZaAAqHAjV7fJFjqHRdCf3rAX4fiYacHFQH/GCAD/W95l3zRbOjbCxF0pdvz8M
 Q1cuzCFHIG92Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F2A6191E67;
 Wed, 11 Mar 2026 18:01:46 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 336F137C2B9;
 Wed, 11 Mar 2026 18:02:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andreas Schwab <schwab@suse.de>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 41/44] linux-user: fix TIOCGSID ioctl
Date: Wed, 11 Mar 2026 18:02:13 +0300
Message-ID: <20260311150221.1084186-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
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


