Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E95CF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkoM-0005ef-Ln; Fri, 04 Oct 2024 12:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkoJ-0005QP-Eb; Fri, 04 Oct 2024 12:05:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkoH-0001xw-IM; Fri, 04 Oct 2024 12:05:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F00D59557B;
 Fri,  4 Oct 2024 19:03:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3519814D989;
 Fri,  4 Oct 2024 19:03:33 +0300 (MSK)
Received: (nullmailer pid 1282572 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 22/23] docs/devel: Mention post_load hook restrictions where we
 document the hook
Date: Fri,  4 Oct 2024 19:03:30 +0300
Message-Id: <20241004160331.1282441-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Accessing another device in a post_load hook is a bad idea, because
the order of device save/restore is not fixed, and so this
cross-device access makes the save/restore non-deterministic.

We previously only flagged up this requirement in the
record-and-replay developer docs; repeat it in the main migration
documentation, where a developer trying to implement a post_load hook
is more likely to see it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/devel/migration/main.rst | 6 ++++++
 docs/devel/replay.rst         | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 784c899dca..c2857fc244 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -465,6 +465,12 @@ Examples of such API functions are:
   - portio_list_set_address()
   - portio_list_set_enabled()
 
+Since the order of device save/restore is not defined, you must
+avoid accessing or changing any other device's state in one of these
+callbacks. (For instance, don't do anything that calls ``update_irq()``
+in a ``post_load`` hook.) Otherwise, restore will not be deterministic,
+and this will break execution record/replay.
+
 Iterative device migration
 --------------------------
 
diff --git a/docs/devel/replay.rst b/docs/devel/replay.rst
index effd856f0c..40f58d9d4f 100644
--- a/docs/devel/replay.rst
+++ b/docs/devel/replay.rst
@@ -202,6 +202,9 @@ into the log.
 Saving/restoring the VM state
 -----------------------------
 
+Record/replay relies on VM state save and restore being complete and
+deterministic.
+
 All fields in the device state structure (including virtual timers)
 should be restored by loadvm to the same values they had before savevm.
 
-- 
2.39.5


