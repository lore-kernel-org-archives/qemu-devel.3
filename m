Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D0CF55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 19:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyxhw-00084g-4v; Sat, 07 Mar 2026 14:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxhv-000841-AH
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:03 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxht-0008UY-SR
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F55D600AE;
 Sat,  7 Mar 2026 19:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE01C19422;
 Sat,  7 Mar 2026 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772913181;
 bh=vm/aA9SwjzkHcfVSNxqZDO1EuMwbYIzCIFfKiGC9xog=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tVzaRF69REcr3kFJ3j2yYnKYW/6RbrBZ9qy4PENdcPbG7mvyIrhRTabMN808TvVKi
 Hh5KCPYoQMybwFP32oS0Gx2PArWM829VHiMK7eTm5imxOPR3UCkYmWWb3RluZuEY5o
 Zx2SAmxyR3rXrx8+0cTXVKtqjgC8QtzpQw9+jhN+fb20iZZORRlORGbKKOW4fhLl9o
 Dd5QcSSjoVzE6u9cqK+CP8iS4qA7UD0EkCSgXIqgq3r4obnmcFhXijEaY+9ItQerxV
 ZCD9z4K4YhPPbZZ1OuyAxj5Cp32yB/ply80VG7R6hItAVMRgLn+2kXJ5KOSWNzyJqw
 WDR403+JmJ6cQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/12] linux-user: Check if RESOLVE_CACHED flag is defined
 before using it
Date: Sat,  7 Mar 2026 20:52:36 +0100
Message-ID: <20260307195243.8813-6-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307195243.8813-1-deller@kernel.org>
References: <20260307195243.8813-1-deller@kernel.org>
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

From: Frank Chang <frank.chang@sifive.com>

openat2.h was introduced in Linux kernel 5.6. However, RESOLVE_CACHED
flag was only added in kernel 5.12 and later. Therefore, we need to check
if RESOLVE_CACHED flag is defined before using it.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index d253b522bf..02d610a7f8 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1129,7 +1129,9 @@ UNUSED static const struct flags openat2_resolve_flags[] = {
     FLAG_GENERIC(RESOLVE_NO_SYMLINKS),
     FLAG_GENERIC(RESOLVE_BENEATH),
     FLAG_GENERIC(RESOLVE_IN_ROOT),
+#ifdef RESOLVE_CACHED
     FLAG_GENERIC(RESOLVE_CACHED),
+#endif
 #endif
     FLAG_END,
 };
-- 
2.53.0


