Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB57ACA5FF4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 11:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDKcj-0003zc-Dt; Sun, 04 Oct 2026 07:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKch-0003zJ-Ug
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:20 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKcg-000231-El
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B44F843FFE;
 Sun,  4 Oct 2026 11:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1D61F000FF;
 Sun,  4 Oct 2026 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791114196;
 bh=0rlaOawbBJkQZZRjtHgciasQn7rUe/EsTW9LOtgsfV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FZ7UvaZxKlj+0An3+ntXq3lbtHi4h9t43aN0MzgdXSRJmgOnPUNUhtP4YzK5PxDkP
 Ey93axwVjkgInZw7zeDg5ymexjJlsZkVKeWzLUi+ahFFfkfHg3PmlCDiUOOqbo9QGm
 qkz2+rV2T9nrk+KX8IilDNvDdm4hcMLzCvSrtrJV1aPS3lFgW9pO1giZz2Kzd92FmI
 fl2kjeVc85FFXHH5LmbLayh7lLkubh8/EV8+1kFfKYcbWGgUxQL1y0yYPKn5thoGLr
 /KDL05WxHKns2knGIY7iwErXV0/48VBxoH9+XbUgsQUSJFeZs4S4JB6peJ03fErGZG
 ozHab2b7CjN7A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 1/5] linux-user: add elf_core_eflags() hook for core dump
 e_flags
Date: Sun,  4 Oct 2026 13:43:06 +0200
Message-ID: <20261004114311.3874-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004114311.3874-1-deller@kernel.org>
References: <20261004114311.3874-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Matt Turner <mattst88@gmail.com>

Let targets set e_flags in the core file header. Default to 0, as
before.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/elfload.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c4bdaa146a..c188fa03c3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -144,6 +144,10 @@ typedef abi_int         target_pid_t;
 #define EXSTACK_DEFAULT false
 #endif
 
+#ifndef elf_core_eflags
+#define elf_core_eflags(info) 0
+#endif
+
 /*
  * Provide fallback definitions that the target may omit.
  * One way or another, we'll get a link error if the setting of
@@ -2212,7 +2216,8 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
         /* Create elf file header. */
         hptr = header;
-        fill_elf_header(hptr, css.count + 1, ELF_MACHINE, 0);
+        fill_elf_header(hptr, css.count + 1, ELF_MACHINE,
+                        elf_core_eflags(ts->info));
         hptr += sizeof(struct elfhdr);
 
         /* Create elf program headers. */
-- 
2.54.0


