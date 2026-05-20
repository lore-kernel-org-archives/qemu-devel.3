Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF6CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgf3-0004nj-Gl; Wed, 20 May 2026 09:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgf1-0004km-3p; Wed, 20 May 2026 09:08:31 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgez-00013u-5N; Wed, 20 May 2026 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=kXQCxYVHFMM1nUyy6C39DCIekHrCMvYBNxec4wN55FA=; b=CNtqpxcnT8ZL2jU
 rHzzTUFdXMH1frMstueyhRu3Sub6iaDtkYkPsVv+K0ABUZXPrZuS5C3vGJwn2FP5URt/HrZSBo5cC
 D0S+uHyaQVSqOkW6cN7rxegStsNLKsWYuR2TnfMZ4b2ONY1NG/CRc4EQzs4O2Oar473BH0IwAqm5q
 d4=;
Date: Wed, 20 May 2026 15:12:58 +0200
Subject: [PATCH v3 06/14] target-info: Add target_riscv64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-hw-riscv-cpu-int-v3-6-d1123ea63d9c@rev.ng>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=1033;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=UuzonCfdVLFu4uWvJ8Tyw8MHppDRMUrDUJIZ+lK8Ow0=;
 b=BJQMOcgb0ya3vxbOlu4AANNuBzfVwGqlOGUpaau84j8x8WR8UsPMZJFCxZczuaZUaQuqAia7Z
 800P52e5zKJBfKiYMgqlTeZ2TjEFbo/T485XSfAyD9256u0QlDs6Yxt
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

Adds a helper function to tell if the binary is targeting riscv64 or
not.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 23c997de54..6c5b714288 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -99,4 +99,11 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_riscv64:
+ *
+ * Returns whether the target architecture is riscv64
+ */
+bool target_riscv64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 28c458fc7a..04c69c41f8 100644
--- a/target-info.c
+++ b/target-info.c
@@ -93,3 +93,8 @@ bool target_s390x(void)
 {
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
+
+bool target_riscv64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_RISCV64;
+}

-- 
2.52.0


