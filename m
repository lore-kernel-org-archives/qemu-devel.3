Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FADF3C265
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaxf-00044C-3s; Mon, 09 Mar 2026 09:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxU-0003yQ-3O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:47 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxO-00067U-4A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C79B40A9A
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993B5C4CEF7
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773064039;
 bh=lUwAO9km4/S+zD0o1NtjbvrV7Uoam/HK5Wb+d30GVks=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=W7h+APUsFYJIVBosWIE1LMGSX8VZNHR/8cctveleZ7rjpWIOkFZUIWmSD//oHqdxP
 2XI8i7Rb5XKVcUYvafaU8BPL1kZeKsknySAlP88gToY+vuyLB3nQ7hJoxJDjXXWifG
 EvLXRHBpc1dm5RyeHX+LCO+loATQzq7it1xX5E06KXQRYSyU2wEXHD7VeX/oDQIGNh
 Pigj+JEyP61dUluP7yITiyKtB3kspL8S6um9RCH38ftEfysBQoq1jieKELXMl3RX6r
 8c79VE43UtsK8cU6zXjqibD4GgVUqYNavQhhj/Iz+i68SwbBH264V4Yyof770VcHdL
 CEhxPbnuTkM/w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] linux-user: fix TIOCGSID ioctl
Date: Mon,  9 Mar 2026 14:47:06 +0100
Message-ID: <20260309134711.5312-6-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309134711.5312-1-deller@kernel.org>
References: <20260309134711.5312-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


