Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318F9F55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 19:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyxhu-00083x-Qb; Sat, 07 Mar 2026 14:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxht-00083Y-6t
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:01 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxhr-0008UI-OA
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:00 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A8B15600AD;
 Sat,  7 Mar 2026 19:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3556AC19422;
 Sat,  7 Mar 2026 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772913178;
 bh=Q/dSbHczdz4sFIvaB36AMEBCEZDprQsZ7Vlhqrv2Nk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P52kXPp42gDPLo25CZoXBEkosb3nidJjgF4SbmvrBABavaLE++qyu435ViYtXXM/b
 onn7bRbvaqgueF27Bmu88rmzEpD3oetEANpp37v6o4xMcffR05WHJ+LYF3sITEjiKQ
 sqjxJ1u0Uxysuw6DKo+7sgo1/AQeye42WNRyFamjZyVOsmsLfryamJNNXt0ELqg0mV
 3l5p6e5QJ9lKhmS0M45dNWGMvt6QU4Q/zdF1PIOmdQN7Dicct4X1cjVRoXNEqGNjSf
 0TFAIqprm16fxBD8soL2x44gmnSrL3mi4ISnS4wDJqX9Z5A/asnE5AHTldrjMwSUUR
 gYT7V0b1U64vw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 04/12] linux-user: properly check flags in openat2
Date: Sat,  7 Mar 2026 20:52:35 +0100
Message-ID: <20260307195243.8813-5-deller@kernel.org>
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

From: Andreas Schwab <schwab@suse.de>

target_to_host_bitmask truncates the bitmask to int.  Check that the upper
half of the flags do not have any bits set.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 99e1ed97d9..064bc604c9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8831,6 +8831,10 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
         }
         return ret;
     }
+    if (tswap64(how.flags) >> 32) {
+        return -TARGET_EINVAL;
+    }
+
     pathname = lock_user_string(guest_pathname);
     if (!pathname) {
         return -TARGET_EFAULT;
-- 
2.53.0


