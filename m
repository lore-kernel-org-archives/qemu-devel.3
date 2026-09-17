Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2E4C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KAf-0004YR-9F; Thu, 17 Sep 2026 18:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x7K9N-00045T-Mg; Thu, 17 Sep 2026 18:00:27 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x7K9L-0004Kt-C7; Thu, 17 Sep 2026 18:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=X0coV+oi3hvoEbKAiwh+e4SUhuLgaoL2aJO66pAXpEo=; b=I9CXymp5pFXjXOV
 Z7ryk/lehJ81WbAeJwcExePPWfG56L6qH3IWrNEowkoP5PLXGiq2vscXjFS7I+zNRaSplFrZt2l70
 dc5Pygan3Vv52X11H8fLpzU33X1UPosq5LL2u5HYhfFkR9JzkqBL1zMrM4tTNvqpQID9mk5qDtkyh
 ec=;
Date: Fri, 18 Sep 2026 00:05:03 +0200
Subject: [PATCH v5 09/11] target-info: Introduce target_riscv32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-hw-riscv-cpu-int-v5-9-f98c5a244636@rev.ng>
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789682744; l=1209;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=7XxnFUSw4Is9LNbqT940ttli+604jlutDoDE238ejgI=;
 b=xgmERrU1cPIloEDkD5qymm4yWg1/Kjwgc56D/ucdC34PFZyNopIuO+elEyYb4gcE7JrhylQij
 94aU8KZcsQxCQ+cl3zQfp/VqC7cJFUaOUnYR9vt/RNFsP6NdobhBAYO
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Will be used in the following commit to filter machines using
TypeInfo::is_available, so a simple !target_riscv64() is not sufficient.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index b23e5bc586..c09e5d2a3e 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -91,6 +91,13 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_riscv32:
+ *
+ * Returns whether the target architecture is riscv32
+ */
+bool target_riscv32(void);
+
 /**
  * target_riscv64:
  *
diff --git a/target-info.c b/target-info.c
index 012b384036..bba4503151 100644
--- a/target-info.c
+++ b/target-info.c
@@ -89,6 +89,11 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_riscv32(void)
+{
+    return target_arch() == SYS_EMU_TARGET_RISCV32;
+}
+
 bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;

-- 
2.52.0


