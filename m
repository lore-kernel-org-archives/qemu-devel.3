Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAD1CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuXi-0001a0-9I; Tue, 12 May 2026 17:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuXV-0001Jb-Bj; Tue, 12 May 2026 17:21:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuXK-0000VQ-9E; Tue, 12 May 2026 17:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619498; bh=6iBCX3m90W+n7ynirIoE5e+d9cL60E7Odafty5zebwo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bdXPmbl5WiEFSId3yH1RcmWMalGwDXEFGVW0V0s8wpedyQ5lhxNnGb5LIeNrwbNsJ
 ta8tzNrJ0O78W/mq7Z+g+ZuK5Vu4oThZxU5eV6AFjs/7UAxp+H/RxS04uC1hPcJ2iG
 RlArlQTX58CIWLqK076SE7Dxxu+g76i82bbp6xmpot5Y+CNIVm+0TGm5o2Cniojv20
 7b8//JdQt+NItuFICetVXFKgE1GgLHnqv/v2rkZtfeAxl3GGWYpuHHzMFKMG+ge0kD
 ef6axaSsljCtqSC6M5D2vY04eLesTOenYGIYao6La3MyfZUqN8cVA4YmbTHLjStWS/
 //3F+D1+vJZew==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DB1E11AA3E9;
 Tue, 12 May 2026 23:58:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E7A183ABD41;
 Tue, 12 May 2026 23:58:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 30/58] util: fix use of pthread_get_name_np on OpenBSD
Date: Tue, 12 May 2026 23:57:51 +0300
Message-ID: <20260512205820.361821-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
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

From: Daniel P. Berrangé <berrange@redhat.com>

The pthread_get_name_np function is present on FreeBSD and OpenBSD
and has 'void' return not 'int'. We didn't notice this build problem
on FreeBSD since it also has pthread_getname_np which does return
int like Linux and we use the latter preferentially.

Fixes: 215235d365e49c72a85ea2940751e45419676031
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3399
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260417120531.2215549-1-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit b8c2426157f51391b74251a830371beda43358c9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index bd1c2ad2a5..089606c93f 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -568,7 +568,8 @@ const char *qemu_thread_get_name(void)
 # if defined(CONFIG_PTHREAD_GETNAME_NP)
     rv = pthread_getname_np(pthread_self(), namebuf, sizeof(namebuf));
 # elif defined(CONFIG_PTHREAD_GET_NAME_NP)
-    rv = pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
+    pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
+    rv = 0;
 # else
     rv = -1;
 # endif
-- 
2.47.3


