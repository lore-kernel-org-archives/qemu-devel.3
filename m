Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B25CC5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAPZ-0006ga-Kz; Wed, 12 Aug 2026 10:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAOb-0004rq-FE; Wed, 12 Aug 2026 10:57:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAOW-0000wb-TB; Wed, 12 Aug 2026 10:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=VOPB4WCD55uxq2KYuKgyk2kGQFVTYP2t7JDIwGKDNQU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=F0SwwUga9E6iKgc0mH8BjHiBhaetBYA9i0lsJ0p+QlbIp0ZvnW0vU5OEkcAkSzShl
 BheaNqP4BryzhvQgEs6F52LLENXxWYizva6nbrc419nZnBSv/B0hB8jwwlYyZXBR3N
 p4IOpXB0+tstQsic1GO9wba3/Zzj1rm8vAT1y4KGH+HWOcKn9vrMxs/X2wPRZNHi7C
 fLLRKRwa4n2wLMzyswARHvvdkawqr9N7M86fMoEn9yR6ry5EWMMRlAeoYwPT2nizVY
 /Pia/NTgrJNXZrypnOOexQ71t8x0/Phr2DVIs6cg7Uub9Zvi3Y0pn5k4Ojc8jKa0mQ
 YOh653KyTHdnQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ADF661CA64A;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 14D94409D8C;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 72D922F9EF; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 070/120] linux-user: Guard local FUTEX_CMD_MASK
 definition
Date: Wed, 12 Aug 2026 17:48:53 +0300
Message-ID: <20260812144955.649205-70-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Building linux-user on a host with Linux 7.2 kernel headers fails with
a macro redefinition error for FUTEX_CMD_MASK. The kernel commit
3ca9595d9fb6 ("futex: Add support for unlocking robust futexes")
expanded the mask to include the new FUTEX_ROBUST_UNLOCK and
FUTEX_ROBUST_LIST32 flags, which conflicts with QEMU's local
definition.

Add a #ifndef guard so the host definition takes precedence when
available. The local fallback is kept for older kernel headers
(pre-2.6.29) that lack FUTEX_CMD_MASK or define a mask without
FUTEX_CLOCK_REALTIME.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 8268d216a004d884a07db20e973158d81760a07c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 5799769f832..e033c7db341 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2593,7 +2593,9 @@ struct target_drm_i915_getparam {
 
 #define FUTEX_PRIVATE_FLAG      128
 #define FUTEX_CLOCK_REALTIME    256
+#ifndef FUTEX_CMD_MASK
 #define FUTEX_CMD_MASK          ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+#endif
 
 #if defined(TARGET_X86_64)
 #define TARGET_EPOLL_PACKED QEMU_PACKED
-- 
2.47.3


