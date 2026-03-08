Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86F3EA853A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHyQ-0004og-BS; Sun, 08 Mar 2026 13:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHx7-0003i2-Nh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:06 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHx2-0003oj-QR
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:02 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FE0C600CB;
 Sun,  8 Mar 2026 17:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4EFC116C6;
 Sun,  8 Mar 2026 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772990998;
 bh=lUwAO9km4/S+zD0o1NtjbvrV7Uoam/HK5Wb+d30GVks=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZNqTUY8JIlvP8SFl2DhtBWSnz6r60oFCHRsXcRR5r5sNfcApvIaV6ESFjFt/F7b7p
 sZEBE5xZk4WAkc5Z0U+loUv66s+uKVTrgsfKpwckQETZiwC0IfAn5PLGzVd9lX2hrj
 9ync9oY/RYr+L4a323fAaEskfyeMGU634QHiRNSeZlE3+npF5OFw1WVhxCrWon7FkC
 OurG/WA5Ikars53rce/01K4Fy9DuOak5JinG9Wt8MKH6pEuBM9gBnkD6aOZO23yKsu
 RQWgB5VoRs/7URcpgOvmQ2o9NF8ZvMt9iuj6+oyzJyBCEcx4naRVnHMBezcEwIFB2x
 D/5N1YLLHBoww==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/12] linux-user: fix TIOCGSID ioctl
Date: Sun,  8 Mar 2026 18:29:31 +0100
Message-ID: <20260308172936.2835-8-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
References: <20260308172936.2835-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/ioctls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.53.0


