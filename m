Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB53D2A555
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AM6-0004pB-Rf; Wed, 16 Oct 2024 16:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AM5-0004o7-6A; Wed, 16 Oct 2024 16:10:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AM3-0000gN-Hd; Wed, 16 Oct 2024 16:10:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4566998F98;
 Wed, 16 Oct 2024 23:10:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 260E9156378;
 Wed, 16 Oct 2024 23:10:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [Stable-9.1.1 38/49] meson: fix machine option for x86_version
Date: Wed, 16 Oct 2024 23:09:57 +0300
Message-Id: <20241016201025.256294-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

s/mbmi1/mbmi/

When configuring with -Dx86_version >= 3, meson step works, but
compilation fails because option -mbmi1 is unknown.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/r/20241004223715.1275428-1-pierrick.bouvier@linaro.org
Cc: qemu-stable@nongnu.org
Fixes: ef7d1adfa85 ("meson: allow configuring the x86-64 baseline", 2024-06-28)
Revieved-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 461a9252e249adab5f0bae3b9634be77dd5be17e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index fbda17c987..6e467cbe7d 100644
--- a/meson.build
+++ b/meson.build
@@ -362,7 +362,7 @@ if host_arch in ['i386', 'x86_64']
     qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
   endif
   if get_option('x86_version') >= '3'
-    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi1', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
   endif
 
   # add required vector instruction set (each level implies those below)
-- 
2.39.5


