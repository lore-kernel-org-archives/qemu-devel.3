Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D9CC27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:31:05 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf6K-0006VJ-5k; Fri, 07 Jun 2024 15:18:12 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf6J-0006OM-1u; Fri, 07 Jun 2024 15:18:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf6H-0003Am-Ah; Fri, 07 Jun 2024 15:18:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 46A5C6E572;
 Fri,  7 Jun 2024 22:14:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7D5AFE276B;
 Fri,  7 Jun 2024 22:14:00 +0300 (MSK)
Received: (nullmailer pid 529481 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xinyu Li <lixinyu@loongson.cn>,
 Xinyu Li <lixinyu20s@ict.ac.cn>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 68/71] target/i386: fix SSE and SSE2 feature check
Date: Fri,  7 Jun 2024 22:13:49 +0300
Message-Id: <20240607191356.529336-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Xinyu Li <lixinyu@loongson.cn>

Features check of CPUID_SSE and CPUID_SSE2 should use cpuid_features,
rather than cpuid_ext_features.

Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240602100904.2137939-1-lixinyu20s@ict.ac.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit da7c95920d027dbb00c6879c1da0216b19509191)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 426c459412..4209d59ca8 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1485,9 +1485,9 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     case X86_FEAT_PCLMULQDQ:
         return (s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ);
     case X86_FEAT_SSE:
-        return (s->cpuid_ext_features & CPUID_SSE);
+        return (s->cpuid_features & CPUID_SSE);
     case X86_FEAT_SSE2:
-        return (s->cpuid_ext_features & CPUID_SSE2);
+        return (s->cpuid_features & CPUID_SSE2);
     case X86_FEAT_SSE3:
         return (s->cpuid_ext_features & CPUID_EXT_SSE3);
     case X86_FEAT_SSSE3:
-- 
2.39.2


