Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3050FE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTdMb-0002cc-6q; Fri, 03 Jan 2025 03:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1tTdMR-0002aY-OB
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:48:55 -0500
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1tTdMK-0007dz-3N
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:48:50 -0500
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5038mSAh1820053
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Fri, 3 Jan 2025 00:48:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5038mSAh1820053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024121701; t=1735894114;
 bh=tHQ0O4NNOOY1zKdop+Ullx68t2A01zOtKHg9Taqtneo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mpRKG3RGPY8+DWS0zPwF+y5+Itv2YYRJS2Ha+ZtDD17SlEcqNV41YSIJxiXcavvnK
 2vmDLUDsr8UEcwdRlV+ARsFBtsrWT+nxnqC7s3oCtKN//SErEte4mVdS+Gjq3YZF62
 Pj4sLyK76UvUOiwX+Hi1yOOzD8OaC/uCiqF3NJ9O/Gu92HHw+jmn5+gDr3iZMXvP/Q
 Fo7OIu14jlUjY1Pnwai6dolYR/pcX1uXHXxUTRS1JSgCyDw8W9jZs32G+Fkc+W2GCQ
 PJmZiHBXmS9iHPd2N8txmkIa9HtwM415EA0cqbaIe6YpS/S0UhhB3/i4eicVsx43R5
 Zkm992Gh4VfMg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xin3.li@intel.com
Subject: [PATCH v1 3/3] target/i386: Add the immediate form MSR access
 instruction support
Date: Fri,  3 Jan 2025 00:48:27 -0800
Message-ID: <20250103084827.1820007-4-xin@zytor.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103084827.1820007-1-xin@zytor.com>
References: <20250103084827.1820007-1-xin@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The immediate form of MSR access instructions are primarily motivated by
performance, not code size: by having the MSR number in an immediate, it
is available *much* earlier in the pipeline, which allows the hardware
much more leeway about how a particular MSR is handled.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2fb05879c3..83fb059d09 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1138,7 +1138,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "msr-imm", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d23fa96549..df27c359d3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -987,6 +987,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Non-Serializing Write to Model Specific Register (WRMSRNS) */
 #define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
 
+/* The immediate form of MSR access instructions */
+#define CPUID_7_1_ECX_MSR_IMM           (1U << 5)
+
 /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
 #define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
 
-- 
2.47.1


