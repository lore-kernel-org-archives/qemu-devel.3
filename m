Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DBDC53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 19:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo4ed-0000Qt-Jf; Sun, 26 Jul 2026 15:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wo4eZ-0000Pz-My
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:36:51 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wo4eY-0004wG-4F
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:36:51 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C4F74166B;
 Sun, 26 Jul 2026 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90C11F000E9;
 Sun, 26 Jul 2026 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785094602;
 bh=bkZ2H5TuZE7h4EbnfmA/D810yCl1zvvzvVMjl14NPlY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z+bRai80MQ0XeCpyOl/680yX0VlUVzjSizekqWa7el0mS4AEl5+JmIgUnryblInC3
 CRBSUm3s72MQkw448giogMc0YlaWI1jT1kNwhIeqRaaQuMKRblzktpYmRY8qslF/Py
 +tU7gv5bEU4RtPtEUp6NfK7zRtUMX7edjBXh93/NzPwM1oEePI0kezzjM+7i4M8qiK
 3VJQmcfL25RM+sZDAEbVLXF6GW1KC9uhNp5tl/7S8ipZPvnueY6kPMT69/35g0HifC
 N3oTfxstZ7QuRBYeM6DEIOpEFQb984atfERE0rSJQv611TnaYnjuOfYQgmhyMV/0be
 1beymGqV21GkQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/2] linux-user: Guard local FUTEX_CMD_MASK definition
Date: Sun, 26 Jul 2026 21:36:35 +0200
Message-ID: <20260726193636.110586-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726193636.110586-1-deller@kernel.org>
References: <20260726193636.110586-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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


