Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DC5C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pCU-0001U4-00; Thu, 24 Sep 2026 15:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1x9pCS-0001Tm-Qp
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 15:33:44 -0400
Received: from mxa.tachyum.com ([66.160.133.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1x9pCR-0006px-D4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 15:33:44 -0400
Received: from mxa.tachyum.com (localhost.localdomain [127.0.0.1])
 by mxa.tachyum.com (Proxmox) with ESMTP id 2C0901E267D;
 Thu, 24 Sep 2026 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tachyum.com; h=
 cc:cc:content-transfer-encoding:date:from:from:message-id
 :mime-version:reply-to:subject:subject:to:to; s=dkim; bh=Bni5hAp
 ZSUlHuI5RUtVwa+xm0lbn5oYYIQstJA8iXuI=; b=fs0ORz632PxIBgnja4daOhi
 DwP68+Qe6C7HMRX+dHDZDueABmhwll+O41cin265kvm8LHq9H08vNfzKQaqxGh1X
 MNBp1o/1Y36RNisq2yeotMcG60dU/Zpg+T9onUcZk/yVD8Lm/Sh5bpXppr97hTL2
 rCxWAhJKybTFpqM4PnO/XdSfAcjAei9uHRsj75lMKoGIDedudFL5MElAzAkXh9LB
 oj131HCQcrsPx7Ix4gzVsQ/YeWAX8kXLdRVemUzQ1mJmMCUS50iT0JdxbV6CDsGO
 HlUN2s1FLvvGdEsd6keGc/+hhKApm2F3UZu9JFa4pYcggdasbCd21P6HmfGlPNA=
 =
From: Michael Morrell <mmorrell@tachyum.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Shevlyakov <igor@tachyum.com>
Subject: [PATCH] linux-user: report EBADF for setsockopt()/getsockopt() on a
 bad fd
Date: Thu, 24 Sep 2026 12:33:41 -0700
Message-ID: <20260924193341.2064665-1-mmorrell@tachyum.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.160.133.173; envelope-from=mmorrell@tachyum.com;
 helo=mxa.tachyum.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Igor Shevlyakov <igor@tachyum.com>

The kernel looks the fd up before validating the rest of the call, so a
negative fd is EBADF whatever else is wrong with the arguments.  Several
arms of do_setsockopt()/do_getsockopt() reject optlen or optname and
return without ever reaching the host syscall, so the host never gets to
supply that EBADF and the guest sees the argument error instead:

    setsockopt(-1, SOL_TCP, TCP_NODELAY, ptr, 0)    EINVAL, want EBADF
    setsockopt(-1, 0x4321, 1, ptr, sizeof(int))     ENOPROTOOPT
    getsockopt(-1, 0x4321, 1, ptr, &len)            EOPNOTSUPP

Caught by glibc's posix/test-errno.

Signed-off-by: Igor Shevlyakov <igor@tachyum.com>
---
 linux-user/syscall.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9f454502cb..e7c9fb33a3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2119,6 +2119,15 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
     abi_long ret;
     int val;
 
+    /*
+     * The kernel looks the fd up before it validates anything else, so a bad
+     * fd is EBADF even when the rest of the call is also wrong.  Several arms
+     * below reject optlen or optname without ever reaching the host syscall,
+     * and would report that instead.
+     */
+    if (sockfd < 0) {
+        return -TARGET_EBADF;
+    }
     switch(level) {
     case SOL_TCP:
     case SOL_UDP:
@@ -2623,6 +2632,10 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
     int len, val;
     socklen_t lv;
 
+    /* EBADF wins over the argument checks below; see do_setsockopt(). */
+    if (sockfd < 0) {
+        return -TARGET_EBADF;
+    }
     switch(level) {
     case TARGET_SOL_SOCKET:
         level = SOL_SOCKET;
-- 
2.43.0



