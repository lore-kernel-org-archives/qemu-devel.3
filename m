Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDB4C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylGu-0000xo-36; Tue, 25 Aug 2026 03:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGs-0000rS-KX; Tue, 25 Aug 2026 03:08:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGr-0006BY-1y; Tue, 25 Aug 2026 03:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=jyDHLYyFx8aID5ljQaabr5yvdmqXq6nzYKO/VNwHMck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cgMxfYqf6wn0Zu3V5Hs1Y1M645LjYPhFuKrmMYtsKbFPU2xMA02gW3YfXpZw6AaD2
 y7tglfpA2S4KkEvjRpIASOKMAnRfViNdfgdegULKYWIWyJVazoHmc1MuPZLGaKsUtP
 Nfo7ki/aAfYx95AnV+XmNuacwhalLk15zD+Pj8PZsdQk+bWCz9V0vANNmyJysbGboW
 hECwuxX89UWV+gAHKpcxJ2hEQpekWsz1EsdFu0YhSYzVMrT5/zZmBmWUSyqcUsnRWQ
 DJSuhuoFdn8cNaxy68h10bNLTKt2Z/CcMVw6s+IAlmF4oOEDkyi6zeilV8ZrzYqifl
 LhlkUJ2z1yQzw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 562CC1CE224;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 16419415F9F;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A08BA32428; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 63/91] whpx: i386: fix xsaves enablement in legacy
 probing path
Date: Tue, 25 Aug 2026 10:05:35 +0300
Message-ID: <20260825070619.174584-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Without this, Linux will crash in a configuration where
xsaves is expected.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 7c84752396d16c3379091fa8341c902aa67ec3d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/whpx/whpx-cpu-legacy.c b/target/i386/whpx/whpx-cpu-legacy.c
index d341e6f4fd1..3fb5ed79e39 100644
--- a/target/i386/whpx/whpx-cpu-legacy.c
+++ b/target/i386/whpx/whpx-cpu-legacy.c
@@ -113,7 +113,7 @@ uint32_t whpx_get_supported_cpuid_legacy(uint32_t func, uint32_t idx,
         if (idx == 0) {
             eax = supported_xcr0;
         } else if (idx == 1) {
-            eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;
+            eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES;
             if (!whpx_has_xsaves()) {
                 eax &= ~CPUID_XSAVE_XSAVES;
             }
-- 
2.47.3


