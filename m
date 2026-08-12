Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68AFC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jj-0002Rn-KL; Wed, 12 Aug 2026 09:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8jB-0000ar-D5; Wed, 12 Aug 2026 09:10:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8j9-00066m-Hr; Wed, 12 Aug 2026 09:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=+jdJArWd5gZKpLZg4SMZ/PgGfqxSxZDnvhzCvYXIGXc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jC9GiXkOrIgS7qkjIWqCbAvZ7hjpr7dXzVaUj2uHoJEUbRHzPs4C3CsWeYtHMEcGa
 929iQKh064fRYFAdUL6q3k612GqAkJShxZCr8Vn7jWPFIKEAjZz02bqE0Sh0XOssz1
 nC/JGhOlE/wsdqiHkd5cfaSSFOD3SZaqPzL0fCx05MPdHI6/x1eJNV/Gqw2hQbb1fo
 8C2UlBU30LMcVtMLjmRAK57fDBrTBYyIUIQAvwg+tMcWdP8WKbxjMwQn5EO8cPFooN
 M3hInX20MFu4B+l+/9EJBnDmt/TsriplUzOTFfTMqSUiwfYt3AuDSEiXSMQTB3bMXX
 PRg+DR5d1/PFQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E4A11CA4CE;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B4874409BB1;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9DC952F932; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 079/102] block/accounting: take stats->lock in
 latency histogram setters
Date: Wed, 12 Aug 2026 16:01:54 +0300
Message-ID: <20260812130233.621965-79-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

block_latency_histogram_set() and block_latency_histograms_clear()
replace BlockLatencyHistogram's nbins/boundaries/bins without taking
stats->lock, while block_account_one_io() reads those same fields
under that lock from whatever iothread completes the I/O. The result
is usual use-after-free and qemu crash.

Take stats->lock in both setters, matching the lock already held by
the reader.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260724111311.4086859-2-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 5b0ba385a024ad92c63c175317cd9374de2e6165)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/accounting.c b/block/accounting.c
index c7feca40ab1..c5584abb76e 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -182,6 +182,8 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
         return -EINVAL;
     }
 
+    qemu_mutex_lock(&stats->lock);
+
     hist->nbins = new_nbins;
     g_free(hist->boundaries);
     hist->boundaries = g_new(uint64_t, hist->nbins - 1);
@@ -194,6 +196,8 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
     g_free(hist->bins);
     hist->bins = g_new0(uint64_t, hist->nbins);
 
+    qemu_mutex_unlock(&stats->lock);
+
     return 0;
 }
 
@@ -201,12 +205,16 @@ void block_latency_histograms_clear(BlockAcctStats *stats)
 {
     int i;
 
+    qemu_mutex_lock(&stats->lock);
+
     for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
         BlockLatencyHistogram *hist = &stats->latency_histogram[i];
         g_free(hist->bins);
         g_free(hist->boundaries);
         memset(hist, 0, sizeof(*hist));
     }
+
+    qemu_mutex_unlock(&stats->lock);
 }
 
 static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
-- 
2.47.3


