Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47870C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodvZ-0001Md-9j; Tue, 28 Jul 2026 05:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wodvX-0001M6-I5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:16:43 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wodvW-0002Fu-82
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:16:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDBF260A70;
 Tue, 28 Jul 2026 09:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F981F000E9;
 Tue, 28 Jul 2026 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785230199;
 bh=bkZ2H5TuZE7h4EbnfmA/D810yCl1zvvzvVMjl14NPlY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fs9f+I98DkMJj2PnuQITuDaBzIAfpGMpLjQUC8+AHMXtCR9xXcuNWr1PfioTcjmVV
 GP/lU4Ym2lXPbyH7hGBbVcHuxB+I1HhTLTaGx5GRitEBwh38amvKyr+6Q7qR9X8moo
 Eb3w95Y3eVu5h3uFcqlQWzGvBkxVESXkypbcXA7SgDPmx+6tFmmc6jFHyQ9IK+zfGU
 gzTwXO3c9Xf5SvWgQwvTiuVQpQ2Nw5xfvjvwq0bPkFTlheEX2xC83sClj3GgX2ZEZp
 vVvBJ8+QWhs++9pfkSX6aVnh+W6YEA4E8NEThlO4B5cTl2ZrxEmoFJ7FeigJT3C26L
 qxD4Ec8L7T11g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Matt Turner <mattst88@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/3] linux-user: Guard local FUTEX_CMD_MASK definition
Date: Tue, 28 Jul 2026 11:16:31 +0200
Message-ID: <20260728091633.29765-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728091633.29765-1-deller@kernel.org>
References: <20260728091633.29765-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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
---
 linux-user/syscall_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 5799769f83..e033c7db34 100644
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
2.54.0


