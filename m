Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC5BCCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91VO-0001cD-6w; Wed, 15 Oct 2025 09:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v91VN-0001ap-4j
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:25:25 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v91V9-0003TK-Tu
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=zKU6myrwXMXIlgy4yFFaEUrAYf8RL5GyRb/aBqTqUjI=; b=VnDuutva7dR0oXK
 rtQEy/5gdTLDTrzr6x6gJz+i0t2RykF8qsZ69YilwtmdFSBw6VGd/D+ODb20vzw4wcmyx5WU+FFyq
 Dvru2ZyMkvGUGcphQenpzIM6Kr/Yv+IfcFo6R9LjRZzipbX6Tb24alSqM987oDTSrOQNc5sHtYgJ5
 Y8=;
Date: Wed, 15 Oct 2025 15:27:41 +0200
Subject: [PATCH 4/5] target-info: Introduce runtime TARGET_PHYS_ADDR_SPACE_BITS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-feature-single-binary-hw-v1-v1-4-8b416eda42cf@rev.ng>
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/qemu/target-info-impl.h | 2 ++
 include/qemu/target-info.h      | 8 ++++++++
 target-info.c                   | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 17887f64e2..80d1613128 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -18,6 +18,8 @@ typedef struct TargetInfo {
     SysEmuTarget target_arch;
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
+    /* runtime equivalent of TARGET_PHYS_ADDR_SPACE_BITS definition */
+    unsigned phys_addr_space_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
     const char *cpu_type;
     /* QOM typename machines for this binary must implement */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index abcf25db6f..8474c43404 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -23,6 +23,14 @@ const char *target_name(void);
  */
 unsigned target_long_bits(void);
 
+/**
+ * target_phys_addr_space_bits:
+ *
+ * Returns: number of bits needed to represent the targets physical
+ *          address space.
+ */
+unsigned target_phys_addr_space_bits(void);
+
 /**
  * target_machine_typename:
  *
diff --git a/target-info.c b/target-info.c
index 3110ab32f7..3d696ae0b3 100644
--- a/target-info.c
+++ b/target-info.c
@@ -22,6 +22,11 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
+unsigned target_phys_addr_space_bits(void)
+{
+    return target_info()->phys_addr_space_bits;
+}
+
 SysEmuTarget target_arch(void)
 {
     SysEmuTarget arch = target_info()->target_arch;

-- 
2.51.0


