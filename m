Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E739CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27u0-0004Sz-Ve; Fri, 26 Sep 2025 08:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27tb-00036H-GE; Fri, 26 Sep 2025 08:49:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27tT-0007HH-KG; Fri, 26 Sep 2025 08:49:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1476F157F60;
 Fri, 26 Sep 2025 15:45:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6AB1D290F1E;
 Fri, 26 Sep 2025 15:45:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 24/38] linux-user: avoid -Werror=int-in-bool-context
Date: Fri, 26 Sep 2025 15:45:24 +0300
Message-ID: <20250926124540.2221746-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

linux-user is failing to compile on Fedora 43:

../linux-user/strace.c:57:66: error: enum constant in boolean context [-Werror=int-in-bool-context]
   57 | #define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO(!(M)), N }

The warning does not seem to be too useful and we could even disable it,
but the workaround is simple in this case.

Cc: qemu-stable@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit db05b0d21ec1e0532cf5f5103ae6520a838d96f9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3b744ccd4a..85b956fdfb 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -54,7 +54,7 @@ struct flags {
 };
 
 /* No 'struct flags' element should have a zero mask. */
-#define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO(!(M)), N }
+#define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO((M) == 0), N }
 
 /* common flags for all architectures */
 #define FLAG_GENERIC_MASK(V, M)  FLAG_BASIC(V, M, #V)
-- 
2.47.3


