Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3530CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNK-0003Ah-14; Wed, 10 Apr 2024 03:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMu-0002at-KW; Wed, 10 Apr 2024 03:27:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMs-0004pu-Sx; Wed, 10 Apr 2024 03:27:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 06DB65D6A1;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A0D44B02E1;
 Wed, 10 Apr 2024 10:23:07 +0300 (MSK)
Received: (nullmailer pid 4191795 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 49/87] target/hppa: fix do_stdby_e()
Date: Wed, 10 Apr 2024 10:22:22 +0300
Message-Id: <20240410072303.4191455-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Sven Schnelle <svens@stackframe.org>

stdby,e,m was writing data from the wrong half of the register
into memory for cases 0-3.

Fixes: 25460fc5a71 ("target/hppa: Implement STDBY")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240319161921.487080-7-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 518d2f4300e5c50a3e6416fd46e58373781a5267)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index ce15469465..3d0bed9e44 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -281,17 +281,17 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
     case 3:
         /* The 3 byte store must appear atomic.  */
         if (parallel) {
-            atomic_store_mask32(env, addr - 3, val, 0xffffff00u, ra);
+            atomic_store_mask32(env, addr - 3, val >> 32, 0xffffff00u, ra);
         } else {
-            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
-            cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
+            cpu_stw_data_ra(env, addr - 3, val >> 48, ra);
+            cpu_stb_data_ra(env, addr - 1, val >> 40, ra);
         }
         break;
     case 2:
-        cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        cpu_stw_data_ra(env, addr - 2, val >> 48, ra);
         break;
     case 1:
-        cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
+        cpu_stb_data_ra(env, addr - 1, val >> 56, ra);
         break;
     default:
         /* Nothing is stored, but protection is checked and the
-- 
2.39.2


