Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11F6CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 06:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz83M-0001UT-CY; Thu, 18 Sep 2025 02:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uz82j-000102-Fa; Thu, 18 Sep 2025 02:22:59 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uz82f-0007Yc-B3; Thu, 18 Sep 2025 02:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1758176555; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=ULgzuprIqooa/StJHEk6sp/0KMZO32CdfNIHRFWHelY=;
 b=md7hyCR6lJX1qujkqIhfoeBA9jXTVs/g7+c5ZKlyxJx6LKXvjWFzRz60p35BdcYVac0dXDZJHtvkMmmoJQOVvCtMfItRtBBh83R+K4DAYt70IZ2WLxtD2WXM9JmXUOWVnl89QxTNMZXmkEkZlIOAMdPLb3EpfVHMwlWAKfJcnrs=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WoF.sFP_1758176553 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 18 Sep 2025 14:22:34 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v2 6/6] target/riscv: Enable SMMPT extension
Date: Thu, 18 Sep 2025 14:19:11 +0800
Message-Id: <20250918061911.904-7-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250918061911.904-1-zhiwei_liu@linux.alibaba.com>
References: <20250918061911.904-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ad5597c9ac..959024a0c5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -204,8 +204,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
+    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
+    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
@@ -1371,6 +1373,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-smmpt", ext_smmpt, false),
+    MULTI_EXT_CFG_BOOL("x-smsdid", ext_smsdid, false),
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
 
     { },
-- 
2.25.1


