Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498B1E7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTdMY-0002bn-C1; Fri, 03 Jan 2025 03:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1tTdMO-0002aJ-D0
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:48:55 -0500
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1tTdMK-0007e0-3R
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:48:48 -0500
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5038mSAf1820053
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Fri, 3 Jan 2025 00:48:33 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5038mSAf1820053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024121701; t=1735894113;
 bh=XQowdhXm1E4FQmtEO4NlPQK/0brMo0zEM6tx6xcgiKM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KgrXaPMVBd+cAeSloisV54S6Zxns19bNybPoPqhDQpSVYogVjj5sxl/v/21oq12vw
 kEUIqRCJpbzWxn7CPbS9hD6g4s5iRoZ606GmTOFbL41h36DJWVY3OzFSLdVmPh171Q
 iMCc35pcNP1UD0uH6Dvv5UkjrKNXeRw40RoOuC+dlrez1vsqQMLHRjtuXyf3uwRzBq
 t7aT9sBqXSaQYGkCjTCWAFaVdmwW2eun8i+bMn8MT6KSQMOkG2jQK3O7SZAFhy5qr2
 C5QN8fawR3NcTqtniiGdWmhv5lN0q+7vs/C93+DcIMZRPpMy2yvV0ws6ZBd4zo3Wa5
 4Yl6/+c4XA7YQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xin3.li@intel.com
Subject: [PATCH v1 1/3] target/i386: Remove FRED dependency on WRMSRNS
Date: Fri,  3 Jan 2025 00:48:25 -0800
Message-ID: <20250103084827.1820007-2-xin@zytor.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103084827.1820007-1-xin@zytor.com>
References: <20250103084827.1820007-1-xin@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
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

WRMSRNS doesn't become a required feature for FERD, and Linux has
removed the dependency, as such remove it from Qemu.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 target/i386/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b639848cd..8a1223acb3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1771,10 +1771,6 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
         .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
     },
-    {
-        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
-        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
-    },
     {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },
-- 
2.47.1


