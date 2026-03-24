Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E404CF54AD7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54F5-0002zL-AY; Tue, 24 Mar 2026 12:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w54Ev-0002wK-47
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:04:25 -0400
Received: from out-173.mta1.migadu.com ([95.215.58.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w54Ep-00071y-Db
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:04:17 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1774368232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tggIhwU4ah+M7xrWWbu3SutZ4qjR8wO0kzZh129W/Js=;
 b=IKDmyoIa9QUZtM10EJ0f+1rxICSGldx9DDwzlgsIO4nRsWhHRfeOVxIcBP/jmAwcpCu7I6
 udf4tIRVlR6EAuB4J5Kv6ksq90pr3x7s6GuPhlEAv1zWh90WU2JT/ItMk4Zzxa54VD9x4Q
 jGSSCFCtqBWH/QttQR6uCBNf7VDZIsE=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH v2] target/arm: Don't skip access flag fault for AccessType_AT
Date: Wed, 25 Mar 2026 00:03:21 +0800
Message-ID: <20260324160321.96347-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.173; envelope-from=zenghui.yu@linux.dev;
 helo=out-173.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

As per the pseudo code from DDI0487 M.a.a (on J1-16021) AArch64.S1Walk():

  // Check descriptor AF bit
  elsif (descriptor<10> == '0' && walkparams.ha == '0' &&
          (!accdesc.acctype IN {AccessType_DC, AccessType_IC} ||
           boolean IMPLEMENTATION_DEFINED "Generate access flag fault on IC/DC operations")) then
      fault.statuscode = Fault_AccessFlag;

an access flag fault should be generated for AccessType_AT, if the AF bit
is 0 and !param.ha.

Besides, we should continue to not raise the access flag fault for
in_debug = true which is what we've been doing previously (before commit
efebeec13d07) for LPAE and is what intention of the debugger access
codepath is.

Fixes: efebeec13d07 ("target/arm: Skip AF and DB updates for AccessType_AT")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
* From v1 [1]:
  - handles in_debug = true (Peter)

[1] https://lore.kernel.org/r/20260317122517.47627-1-zenghui.yu@linux.dev

 target/arm/ptw.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8b8dc09e72..fa6db9e5a2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2118,6 +2118,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr &= ~(hwaddr)(page_size - 1);
     descaddr |= (address & (page_size - 1));
 
+    if (likely(!ptw->in_debug)) {
+        /* Check descriptor AF bit */
+        if (!(descriptor & (1 << 10)) && !param.ha) {
+            fi->type = ARMFault_AccessFlag;
+            goto do_fault;
+        }
+    }
+
     /*
      * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
      * and it is IMPLEMENTATION DEFINED whether AF is updated
@@ -2127,15 +2135,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         /*
          * Access flag.
          * If HA is enabled, prepare to update the descriptor below.
-         * Otherwise, pass the access fault on to software.
          */
-        if (!(descriptor & (1 << 10))) {
-            if (param.ha) {
-                new_descriptor |= 1 << 10; /* AF */
-            } else {
-                fi->type = ARMFault_AccessFlag;
-                goto do_fault;
-            }
+        if (!(descriptor & (1 << 10)) && param.ha) {
+            new_descriptor |= 1 << 10; /* AF */
         }
 
         /*
-- 
2.53.0


