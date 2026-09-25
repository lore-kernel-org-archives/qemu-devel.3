Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2857AC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2OY-0000PE-IG; Fri, 25 Sep 2026 05:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OQ-0000OD-V1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:59 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OO-0006E5-Ij
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:57 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AAA9343802;
 Fri, 25 Sep 2026 09:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106071F000FF;
 Fri, 25 Sep 2026 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329135;
 bh=fmt/heT7BOpUd0wmehd5KZosBvTHmqytpQH3KmNzulk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a60iDHHwT1KEjDhRvuOEl3T88tbB88g11i5heMeFWbiPIqIQGll7H/fcQnsoNWEzR
 2q4DtD2CaXeqIrpvfkmHPd9GvaoKszWKWZpV4GAvL458AZ8t5jK8A9zW25N0hapck4
 dB14Kl54P+VKDDwa/Gl0I54P4jwlwQtI5+FU8mhG5cJm88iXmUI0U2WHByCvs5+ggf
 jgyhYOesrhkXFNFj22old0J/NqBTCOCFYNGWoeeQkjY7wVsszH+T2O8m+6FK/8JhrD
 Rw1B17FWNGjqNHRIlTGZfoIezSQdvZKGrfcK12MNLHb6I799Mic2zOHE2G4ZjMj6zQ
 Pac1RUe3e9FEg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 4/8] linux-user: report EBADF for setsockopt()/getsockopt() on
 a bad fd
Date: Fri, 25 Sep 2026 11:38:40 +0200
Message-ID: <20260925093844.5685-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
References: <20260925093844.5685-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
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
2.54.0


