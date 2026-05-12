Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB16CCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuPS-0005jU-Bd; Tue, 12 May 2026 17:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuP9-0004j3-4w; Tue, 12 May 2026 17:12:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuP5-0004rV-GF; Tue, 12 May 2026 17:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619304; bh=xcmbAb679+u1NHzSjARVhUGbo4dVqE2enyKyDONBdjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vPt4vDpqg3my3Uw+QiI4CYh0g1GjQsIu+JSWyuDVIXMJrYvGbh+QSSO23x3g+Bj7R
 O0iqT6dRTICojaSt5pA1gQE5tViUrt09h4l02kDFW577+dd52VZHrw+RbgzG9Mm/Cf
 byzKqNU/iyqJGzHedDMK/ZIEVqRihFb8/AEMcTYZg2599AzlED0MuSNymb2WL0RmMv
 NFCyAxquiiXB7kfSonOpYDl6WYsCRdbjmeep7dmeDv58GiolYCBgdTeDud7oddNykF
 I4wdN9b62miRQ+Z/vZFqdM4a4tK0m387kRClYDZQ8CPU0TcfNPTmFA1h1ypxS0IL6H
 ESvAsmXrARdtg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 29DC01AA380;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 338683ABCEF;
 Tue, 12 May 2026 23:55:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 066/117] util/cutils: Fix heap corruption under Windows
Date: Tue, 12 May 2026 23:54:08 +0300
Message-ID: <20260512205503.361097-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Bernhard Beschow <shentey@gmail.com>

Under Windows, QEMU would only sporadically start successfully. In the
G_OS_WIN32 case, get_relocated_path() first determines a cursor
to the end of the "result" string and then increases its size with
g_string_set_size(). Since g_string_set_size() may reallocate, the
cursor may become dangling. Windows may detect this and crash the QEMU
process with the following message:

  HEAP: Free Heap block 000000000499B640 modified at 000000000499B684 after it was freed

Furthermore, QEMU crashes spontaneously, even long after the guest has
booted. For example, it presumably crashes due to the guest setting a
new cursor icon which may be a result of the heap corruption.

Fix this by determining the cursor on the resized string.

Fixes: cf60ccc3306c ("cutils: Introduce bundle mechanism")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20260414114033.2360-1-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f1b1db98cc3b7212d7efffab516d38d0a913f432)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/cutils.c b/util/cutils.c
index 9803f11a59..76a9442085 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1165,9 +1165,10 @@ char *get_relocated_path(const char *dir)
 
         PCWSTR wdir_skipped_root;
         if (PathCchSkipRoot(wdir, &wdir_skipped_root) == S_OK) {
+            char *cursor;
             size = wcsrtombs(NULL, &wdir_skipped_root, 0, &(mbstate_t){0});
-            char *cursor = result->str + result->len;
             g_string_set_size(result, result->len + size);
+            cursor = result->str + result->len - size;
             wcsrtombs(cursor, &wdir_skipped_root, size + 1, &(mbstate_t){0});
         } else {
             g_string_append(result, dir);
-- 
2.47.3


