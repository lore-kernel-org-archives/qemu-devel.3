Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97A4F43690
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgtl-0003Db-IN; Fri, 17 Apr 2026 06:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDgtf-0002ph-AI
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:58:04 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDgtd-0001lP-LC
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:58:02 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de
 [80.134.214.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 80B5120B7129;
 Fri, 17 Apr 2026 03:57:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80B5120B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776423469;
 bh=S92dx0H1HZeFjxrVBmrak0WH0pq895/vNqGc9ASOqFs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QzG34/USBCzLRxtfv5Cfx0sEjeo1SylWPk4y4zWIlWIewfUlKAhglnunro8MJfv+8
 WCTTwoq/QIt3HL80tqW5tW4Vi6tI/q++c85z8pQ5tOErvqywwrpP8oLifxQkN++19N
 ROttbN3jyNWSKd2HX/dhPYE9FXj40826SBC9xhes=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 23/34] target/i386/mshv: migrate CET/SS MSRs
Date: Fri, 17 Apr 2026 12:56:07 +0200
Message-Id: <20260417105618.3621-24-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This change migrates the MSRs required for CET shadow stack and indirect
branch tracking. They are gated behind cet_ss_support || cet_ibt_support
mshv processor feature flags.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h | 11 +++++++++++
 target/i386/mshv/msr.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 4d1e062e48..75e953b86c 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -168,6 +168,17 @@ typedef enum hv_register_name {
     HV_X64_REGISTER_TSC_DEADLINE    = 0x00080095,
     HV_X64_REGISTER_TSC_ADJUST      = 0x00080096,
 
+    /* CET / Shadow Stack */
+    HV_X64_REGISTER_U_XSS                    = 0x0008008B,
+    HV_X64_REGISTER_U_CET                    = 0x0008008C,
+    HV_X64_REGISTER_S_CET                    = 0x0008008D,
+    HV_X64_REGISTER_SSP                      = 0x0008008E,
+    HV_X64_REGISTER_PL0_SSP                  = 0x0008008F,
+    HV_X64_REGISTER_PL1_SSP                  = 0x00080090,
+    HV_X64_REGISTER_PL2_SSP                  = 0x00080091,
+    HV_X64_REGISTER_PL3_SSP                  = 0x00080092,
+    HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR = 0x00080093,
+
     /* Other MSRs */
     HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
 
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 4881e15f4b..b985500797 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -83,6 +83,26 @@ static const MshvMsrEnvMap msr_env_map[] = {
     { IA32_MSR_MTRR_DEF_TYPE, HV_X64_REGISTER_MSR_MTRR_DEF_TYPE,
                               offsetof(CPUX86State, mtrr_deftype) },
 
+    /* CET / Shadow Stack */
+    { MSR_IA32_U_CET,       HV_X64_REGISTER_U_CET,
+                            offsetof(CPUX86State, u_cet) },
+    { MSR_IA32_S_CET,       HV_X64_REGISTER_S_CET,
+                            offsetof(CPUX86State, s_cet) },
+    { MSR_IA32_PL0_SSP,     HV_X64_REGISTER_PL0_SSP,
+                            offsetof(CPUX86State, pl0_ssp) },
+    { MSR_IA32_PL1_SSP,     HV_X64_REGISTER_PL1_SSP,
+                            offsetof(CPUX86State, pl1_ssp) },
+    { MSR_IA32_PL2_SSP,     HV_X64_REGISTER_PL2_SSP,
+                            offsetof(CPUX86State, pl2_ssp) },
+    { MSR_IA32_PL3_SSP,     HV_X64_REGISTER_PL3_SSP,
+                            offsetof(CPUX86State, pl3_ssp) },
+    { MSR_IA32_INT_SSP_TAB, HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR,
+                            offsetof(CPUX86State, int_ssp_table) },
+
+    /* XSAVE Supervisor State */
+    { MSR_IA32_XSS,         HV_X64_REGISTER_U_XSS,
+                            offsetof(CPUX86State, xss) },
+
     /* Other */
 
     /* TODO: find out processor features that correlate to unsupported MSRs. */
@@ -291,6 +311,16 @@ static bool msr_supported(uint32_t name)
         return mshv_state->processor_features.tsc_adjust_support;
     case HV_X64_REGISTER_TSC_DEADLINE:
         return mshv_state->processor_features.tsc_deadline_tmr_support;
+    case HV_X64_REGISTER_U_CET:
+    case HV_X64_REGISTER_S_CET:
+    case HV_X64_REGISTER_PL0_SSP:
+    case HV_X64_REGISTER_PL1_SSP:
+    case HV_X64_REGISTER_PL2_SSP:
+    case HV_X64_REGISTER_PL3_SSP:
+    case HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR:
+    case HV_X64_REGISTER_U_XSS:
+        return mshv_state->processor_features.cet_ss_support ||
+               mshv_state->processor_features.cet_ibt_support;
     }
 
     return true;
-- 
2.34.1


