Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DFAC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHQA-0004YG-Kt; Wed, 14 May 2025 15:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHMN-00052Q-BK; Wed, 14 May 2025 15:01:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHMK-0007ZB-Up; Wed, 14 May 2025 15:01:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6E86121D99;
 Wed, 14 May 2025 22:00:32 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BCC0220BA8B;
 Wed, 14 May 2025 22:00:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 15/23] docs: Don't define duplicate label in
 qemu-block-drivers.rst.inc
Date: Wed, 14 May 2025 22:00:27 +0300
Message-Id: <20250514190041.104759-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
MIME-Version: 1.0
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

Sphinx requires that labels within documents are unique across the
whole manual.  This is because the "create a hyperlink" directive
specifies only the name of the label, not a filename+label.  Some
Sphinx versions will warn about duplicate labels, but even if there
is no warning there is still an ambiguity and no guarantee that the
hyperlink will be created to the right target.

For QEMU this is awkward, because we have various .rst.inc fragments
which we include into multiple .rst files.  If you define a label in
the .rst.inc file then it will be a duplicate label.  We have mostly
worked around this by not putting labels into those .rst.inc files,
or by adding "insert a label" functionality into the hxtool extension
(see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
argument to SRST directive").

Unfortunately in commit 7f6314427e78 ("docs/devel: add a codebase
section") we accidentally added a duplicate label, because not all
Sphinx versions warn about the mistake.

In this case the link was only from the developer docs codebase
summary, so as the simplest fix for the stable branch, we drop
the link entirely.

Cc: qemu-stable@nongnu.org
Fixes: 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label argument to SRST directive"
Reported-by: Dario Faggioli <dfaggioli@suse.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250501093126.716667-1-peter.maydell@linaro.org
(cherry picked from commit 82707dd4f07613eed8d639956a43bddffca5cd5c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index ef98578296..085da10a22 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -116,7 +116,7 @@ yet, so sometimes the source code is all you have.
 * `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
   `Monitor <QEMU monitor>` implementation (HMP & QMP).
 * `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
-  QEMU `NBD (Network Block Device) <nbd>` server.
+  QEMU NBD (Network Block Device) server.
 * `net <https://gitlab.com/qemu-project/qemu/-/tree/master/net>`_:
   Network (host) support.
 * `pc-bios <https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios>`_:
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index cfe1acb78a..384e95ba76 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -500,8 +500,6 @@ What you should *never* do:
 - expect it to work when loadvm'ing
 - write to the FAT directory on the host system while accessing it with the guest system
 
-.. _nbd:
-
 NBD access
 ~~~~~~~~~~
 
-- 
2.39.5


