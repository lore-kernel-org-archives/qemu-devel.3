Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAAAEFCBD4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226g-0008Ij-9c; Mon, 16 Mar 2026 03:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2265-0007aN-Ca; Mon, 16 Mar 2026 03:10:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2263-0007na-Jl; Mon, 16 Mar 2026 03:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645003; bh=CT78znMoqlimioiS3DCVYWSp9dDqIuP3u5vUnyJl+7Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rItyYghhnhE/pkKNHGjhyI2Jk2rmGaRyAUmKgMG3cmC2wtfchB65EnEWScXqlEja7
 Yvn23IjYlcppzBwhPniitU14syuFVaAgPFMGoG9XeML5IB3zD69hm0lRJv3wJjbHxT
 2dNHee4NuKQGLt0vGVoUFyAzCt5guUq7NAeRkndT7ZeROy2Nv/tzv8yaTz4lqEApeM
 AwtlwWf4FLchATKmgvMrBzDPxCmkZr0XACqd0EroaNqaQwgXXoNkkOtowVIS1HFIns
 eHqLilHzvfNvEpIbLhCAsOvbgBGiox+POdCR6lxW2fZYIPdYk9b5VYw9/eS56dFk5n
 QrrJSwkgHk7ZA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 236C2193C2D;
 Mon, 16 Mar 2026 10:10:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 23FE0380055;
 Mon, 16 Mar 2026 10:10:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 11/14] meson.build: stop checking for inotify_init()
Date: Mon, 16 Mar 2026 10:09:59 +0300
Message-ID: <20260316071005.91624-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

the only place in qemu which used the check for inotify_init()
was linux-user, which now assumes inotify_init() is always
present.  There's no need to check for this function anymore.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 meson.build | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 59ed1a527a..a0f5e900be 100644
--- a/meson.build
+++ b/meson.build
@@ -2675,15 +2675,12 @@ endif
 config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
 
 inotify = not_found
-have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
 have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
-if (have_inotify_init or have_inotify_init1) and not cc.has_function('inotify_init1')
+if have_inotify_init1 and not cc.has_function('inotify_init1')
   # FreeBSD 14 and older need libinotify-kqueue wrapper
   inotify = cc.find_library('inotify')
-  have_inotify_init = have_inotify_init and inotify.found()
-  have_inotify_init1 = have_inotify_init1 and inotify.found()
+  have_inotify_init1 = inotify.found()
 endif
-config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
 config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
 
 # has_header_symbol
-- 
2.47.3


