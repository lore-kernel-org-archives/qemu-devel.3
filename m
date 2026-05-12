Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB9BCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuJa-0007kO-HK; Tue, 12 May 2026 17:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJC-000745-Kn; Tue, 12 May 2026 17:06:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJA-0001h1-SV; Tue, 12 May 2026 17:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=Thxy7mBG0faqw0YplSgnKR3TWfk56NDAFvbCxIIpGf0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CXAt/y1pB0fEMkYRqa9fmCJ1QhRLktJU+DOLsv1+r/RK7E8JFjPktSVLDwxaQyi12
 iDd3bZE9Xv9dN7NM0Mj7eGB10ksxBjbbjIRyBm5x5/ogpnzLfrGIdJ6cuDl4O9z6L8
 DAbutr1GWqq67XdBQP7uq2/b8xFm3MIkO1DaH5UeWxLkdv34FxdfmdfycRsiRDVaff
 NYLCAyMLBjSj2BYPYNub4Yx5iaxEyHfOHNAoO3SPB0GOj7fZts2ebPRP+8nQdVyBlc
 5qM2kCrGxGbdwUWKp+dE8xePMQ6pJjU4yPnYPq//wIOiAJ90vA8ICrFX9POup3TBfy
 UqdTxdcsqMVBA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 473521AA344;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4C02C3ABCB5;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 008/117] contrib/plugins/uftrace.c: fix depth for exit
 events
Date: Tue, 12 May 2026 23:53:10 +0300
Message-ID: <20260512205503.361097-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Uftrace plugin was recording wrong depth for exit events, resulting in
incoherent traces, especially for partial ones.

Thanks to Honggyu Kim, one of the original author of uftrace, who
spotted the issue.
https://github.com/namhyung/uftrace/pull/2031#issuecomment-4051762627

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260313063441.2048882-1-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
(cherry picked from commit 48221e371686f7704f150aafe46b76bb9306c7b6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index b7d6124d2f..88e34e2d6d 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -705,7 +705,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     if (fp == caller.frame_pointer) {
         /* return */
         CallstackEntry e = callstack_pop(cs);
-        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
+        /* uftrace convention is to use same depth as entry */
+        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs) + 1);
         return;
     }
 
-- 
2.47.3


