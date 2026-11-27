Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74C4606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=h8b4p6rU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp8k-0008Hy-UQ; Fri, 27 Nov 2026 01:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8J-00078T-DX; Fri, 27 Nov 2026 01:08:33 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8H-00007c-JW; Fri, 27 Nov 2026 01:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=mlVG467w4nuE4uTadl1wOxS56G0ePQvyMbZoiyCM2/o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h8b4p6rUEIbw7yZfYTQq8eTjQiH4dy8bWxAi+gx7aSf0kAQyVN1+WB9yiQy1qQKvZ
 2cqgOQ7BOB0+muIyuST9SoUUhWm7YzMqe+8LeutQ0e7QNv7pdBTCKjqkqRJJCkpXLX
 mz3nrcAXxSmc3ZtY1gNxUeSm+G8cUcK7f5pjN81pzgq+wvY50I+okGN0zc7Emtp4AP
 uhcXuhCj8DjvEJIYznWMJVE9EfCS/De5N7mZlNIGodudOBZqdJw0onVj+KyrjY30px
 iccjdBKhrq2acnHDzPkSXibt3OX9kUirJbqWgxxDfhZnL/BuvGs8Ifh3N4rMrO9GbS
 yvVGlh01sXNJQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C4C51EA36D;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 39DFE469998;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 176DACF328; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 123/152] linux-user: copy nanosleep's remaining
 time on EINTR
Date: Fri, 27 Nov 2026 08:54:21 +0300
Message-ID: <20261127055709.39630-60-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Brian Cain <brian.cain@oss.qualcomm.com>

do_syscall1() copies the host's "rem" timespec back to the guest
whenever safe_nanosleep() fails.  But the kernel only fills in rem when
the sleep was interrupted (-EINTR).  When a signal arrives just before
the host call, safe_syscall returns -QEMU_ERESTARTSYS without running
the syscall at all, so rem is uninitialized stack.

That is harmless for a guest that passes distinct request and remainder
buffers, but musl's usleep() calls nanosleep(&ts, &ts).  The garbage
then overwrites the guest's request before the syscall is restarted, so
the restarted sleep can last arbitrarily long.

Match clock_nanosleep(), which already only copies the remainder back
on -TARGET_EINTR.

Cc: qemu-stable@nongnu.org
Fixes: 9e518226f431 ("linux-user: Use safe_syscall wrapper for sleep syscalls")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
(cherry picked from commit 2bf4854e7924883223fccfa139dbc87427c7f758)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5343bea0f87..099d3aea84b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12228,7 +12228,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 return -TARGET_EFAULT;
             }
             ret = get_errno(safe_nanosleep(&req, &rem));
-            if (is_error(ret) && arg2) {
+            if (ret == -TARGET_EINTR && arg2) {
                 if (host_to_target_timespec(arg2, &rem)) {
                     return -TARGET_EFAULT;
                 }
-- 
2.47.3


