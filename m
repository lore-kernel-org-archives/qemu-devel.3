Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C0DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQf-0001bQ-Ar; Wed, 12 Aug 2026 10:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQX-0001Wa-B3; Wed, 12 Aug 2026 10:59:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQV-0001UW-Oa; Wed, 12 Aug 2026 10:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=MJYPxo+463r2tN8uZYy7+D1TxlrCRWFFexblE/bup9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tfwUNuRak/eL+xLoK4PMMRqTIOL/bgq35yfOFpgO8fgza0xLK88gvqLejZIBDW38s
 r7mFsMEUW3NDBfKbLY+W7+svc7AmYgmSazntTfwwKmmm7falHrDjknzbIbJt8+UZvU
 V5ElidElT7gCstYF5p/fdu+FvJNWAx7ASo8XsU0HhcwtQuMzQsMnuYFhasNGBhCWNd
 rh/+Et+Ku9eDgmgXRXNOgyd/aS2PSEgHb3AQxPGAScN55fqQteMd4IiG5RNSibxoOT
 W8xnDg4bdLYCeUwMqCvjpkFnj3xB5pSRYXONK3SMmEFHrfdHA+tx6YSZIcb21QyWar
 GwYTBtYWmqjdA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B7CA1CA65C;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 95C9B409D9E;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 005F42FA13; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 088/120] linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN
Date: Wed, 12 Aug 2026 17:49:11 +0300
Message-ID: <20260812144955.649205-88-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Richard Henderson <richard.henderson@linaro.org>

The token is not computed via TARGET_PAGE_SIZE, but via a fixed 12-bit field.

Cc: qemu-stable@nongnu.org
Fixes: ad1afe433fa ("linux-user/aarch64: Implement map_shadow_stack syscall")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4106
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 8d0ac5933aa3476283c14680f165727268103fcd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dcf461806ad..85ef8261e63 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6848,7 +6848,8 @@ static abi_long do_map_shadow_stack(CPUArchState *env, abi_ulong addr,
                 /* Leave an extra empty frame at top-of-stack. */
                 cap_ptr -= 8;
             }
-            cap_val = (cap_ptr & TARGET_PAGE_MASK) | 1;
+            /* Note the 12 bit field is unaffected by current page size. */
+            cap_val = deposit64(cap_ptr, 0, 12, 1);
             if (put_user_u64(cap_val, cap_ptr)) {
                 /* Allocation succeeded above. */
                 g_assert_not_reached();
-- 
2.47.3


