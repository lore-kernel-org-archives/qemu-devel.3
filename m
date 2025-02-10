Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E17C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUwy-0007Rt-Rk; Mon, 10 Feb 2025 09:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c32b228592cf7b4f18b404e1b91a6eedc83d3f85@kylie.crudebyte.com>)
 id 1thUwx-0007PQ-I2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:39:51 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c32b228592cf7b4f18b404e1b91a6eedc83d3f85@kylie.crudebyte.com>)
 id 1thUwv-0001GT-R1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=DaH5KDHgomo+0iGZmUJRIIWnIfIXhKZQs5b/ihv6qzQ=; b=ndU1+
 Qk1+W05xGU724YbfKNqY7GkvUdm7p/G6WTTMGSx65NYmdQ482KCin82NEzJSC9bMCeNNymsnWOh9V
 qeEjdLOULBH0H6HyNNZjaZvYxQ7uEUPZLUpdcMV1RxmqyjaglOhO4UygzeS1MyYIF11mbA7SoXRDN
 Q4sHbt6+nwGNNlwsVJ96ZI1MTH3NmnedCCrSQ3k81JYyFTJp8j+uXI3LgqEOVlftFFisVRTHitmSi
 5LDdkFuO2lfI5GM4rkxU2zSk0Z/NNBfPrWf8E0Mm5F1AT6eoyyOHS5BiRVRIzbSEGuOAu1i/BgMjg
 kgtM6G3Giw6TrOhwPIqB0HEy6Pr9GequKP4ZgIRUYTRepGKJByzJbB+3jK8cdJShALd6DAI82/9pW
 flrou45I8a/KH74bD+lFtGYxq2P8MxLAPWX/J2X28YpzCNAyYeDIKXTA2vULdDW5PI9rjvP+yWjjN
 c3xqNRWEJJ72oJcT9+8p332YnbQ1z5Yp1VJfKZddPGxFJE6wdcWQfD1C2RsbRXCq8cP7Zjqf8m6Qk
 6/gAIhYjgWQAbmrHaE6mH9ZEh5isQbdB+yuJObv2oJr5QLDQf+r1bYkmewouMY16lV4DUoRnPNWKM
 QwPVfcf5Vm/1foX9bLnW3+jIgpXOEWPmKoTxrOdkUIaFp5w7XfxHyumn8A3rHU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 10 Feb 2025 15:33:59 +0100
Subject: [PATCH] 9pfs: fix dead code in qemu_open_flags_tostr()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1thUwq-0020ux-5f@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=c32b228592cf7b4f18b404e1b91a6eedc83d3f85@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Coverity scan complained about expression "|LARGEFILE" to be non reachable
and the detailed Coverity report claims O_LARGEFILE was zero. I can't
reproduce this here, but I assume that means there are at least some
system(s) which define O_LARGEFILE as zero.

This is not really an issue, but to silence this Coverity warning, add a
preprocessor wrapper that checks for O_LARGEFILE being non-zero for this
overall expression. The 'defined(O_LARGEFILE)' check is not necessary,
but it makes it more clear that we really want to check for the value of
O_LARGEFILE, not just whether the macro was defined.

Fixes: 9a0dd4b3
Resolves: Coverity CID 1591178
Reported-by: Coverity Scan
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-util-generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
index 4c1e9c887d..02e359f17b 100644
--- a/hw/9pfs/9p-util-generic.c
+++ b/hw/9pfs/9p-util-generic.c
@@ -19,7 +19,9 @@ char *qemu_open_flags_tostr(int flags)
         #ifdef O_DIRECT
         (flags & O_DIRECT) ? "|DIRECT" : "",
         #endif
+        #if defined(O_LARGEFILE) && O_LARGEFILE != 0
         (flags & O_LARGEFILE) ? "|LARGEFILE" : "",
+        #endif
         (flags & O_DIRECTORY) ? "|DIRECTORY" : "",
         (flags & O_NOFOLLOW) ? "|NOFOLLOW" : "",
         #ifdef O_NOATIME
-- 
2.39.5


