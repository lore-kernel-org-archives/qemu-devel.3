Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B34CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 11:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDKcn-00041d-Ed; Sun, 04 Oct 2026 07:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKck-00040C-M9
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:22 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKcj-00023I-70
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:22 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B460544501;
 Sun,  4 Oct 2026 11:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6DB1F000FF;
 Sun,  4 Oct 2026 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791114198;
 bh=nOMaH/oyEOX/ovUtmVmmwZ3m8s1Ip7BIfc3mQ3YLV98=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WDl85bi0OlJXyQm1w3gn20irEtn+14GgEKZvgYXHv+iYGf0zMTdTdiQWAlATKHL8b
 5mGHnbX9U9OIRTnYRb69UYDCbpAi9qK3cwMuSAmRm5XKLSd74ZiGJzLLKIxXzl6baW
 SICN3LXiXIMlojyOoaGZ7Y09oHs7Il9niTPYM33IiQxrqOBScZ9ppxhBIspOlLBNyt
 mfMPN1T0GwTmsETuQ9iKv6vc0VbGOMZRRM3hnYBcKoeRl09l7Yx7VBVsYNAdiFH778
 c+daDmh/0JJc5T8SfNWX6LRBvvs0sXRnnVSPmqIBYnAxvh77nOILr0r0bUTvsaYVnH
 Z/pz7wGNjb59w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/5] linux-user/mips64: set EF_MIPS_ABI2 in mipsn32 core dumps
Date: Sun,  4 Oct 2026 13:43:07 +0200
Message-ID: <20261004114311.3874-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004114311.3874-1-deller@kernel.org>
References: <20261004114311.3874-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

mipsn32 core files had e_flags 0, so gdb took them for o32, found no
general-purpose registers and failed with an internal error in
frame_unwind_find_by_frame.

Linux sets e_flags to EF_MIPS_ABI2 for n32 cores (user_mipsn32_view in
arch/mips/kernel/ptrace.c).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/mips64/target_elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index efb5d97563..fd9fb89269 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -16,6 +16,8 @@
 
 #ifdef TARGET_ABI_MIPSN32
 #define elf_check_abi(x)        ((x) & EF_MIPS_ABI2)
+/* See linux kernel: arch/mips/kernel/ptrace.c, user_mipsn32_view.  */
+#define elf_core_eflags(info)   EF_MIPS_ABI2
 #else
 #define elf_check_abi(x)        (!((x) & EF_MIPS_ABI2))
 #endif
-- 
2.54.0


