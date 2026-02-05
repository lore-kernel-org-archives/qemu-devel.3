Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1354E9128F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0Jq-0001CY-E7; Thu, 05 Feb 2026 09:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jb-000143-I3
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:40 -0500
Received: from qs-2003d-snip4-2.eps.apple.com ([57.103.86.35]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0JX-0007yY-Jg
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:39 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 5ECF41800DA3; Thu,  5 Feb 2026 14:26:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301590; x=1772893590;
 bh=c9xkU5JKUppgK3M6NvIGvHRbHv9MZvro5B1lYG+DJ2Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=R5GKQ65RIYVVoB1ad1pWdp+GuDCN0u2/0hymMkX7AoEILpxEwJIKDdsGIXK4s8QnmcjYvieH+iosLqB9tnOooNScf4GHuV2g5EJjvyJgb7ef24Tot90mk+h1lzswMWJoUeyNEVwVCnCSXdQZiy0Xl1wiJ8PqZ6yXxnxDGkLlbIozQvos2X9wuvyMAGl3a2bwLNu2ZCYgFRMSGOKZYLZygWt/eMHDTQnHeoJp83ERzhl/SnmYvcPONFJScGGIgkgwfCFN02K6TSj47Nsg+T12Zehx1ToqfPKefkiK4f7QZUsgN0WCsfZs1zbdLB4jbeJcrykc1cy5Sy6mzqP4C6FqkA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 42CBE1800178; Thu,  5 Feb 2026 14:26:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 12/22] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Thu,  5 Feb 2026 15:25:30 +0100
Message-ID: <20260205142543.64818-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QvVhRmNCY-ySj9T9MqBAglko89EdGRDp
X-Authority-Info-Out: v=2.4 cv=NKbYOk6g c=1 sm=1 tr=0 ts=6984a895
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: QvVhRmNCY-ySj9T9MqBAglko89EdGRDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX1bngqPSu37r5
 3gAHZWoFHNyaQehfCDy2O/tnBHUASTOe9oScICrZP7uiRXuWeZC6zZSdEtbbCFelWvDxN8/UJ84
 UjzUjK5djRAkvfz5G7v6Bo9nYwmCXJI+Vk9UMal5qpDFOpEcsBlXP5gir7rsU4N/ZULq85r9ict
 EtgOLzBuLuM7mWunrZJPE7IVeMIOlCsfbPsgKNf20G2BLc9TtoJ1Bu0DfTCIAzrss7LF8SoO7bp
 EEfg2GsynfuB5VdJZvBaA5TaQCG/ol+c3EqfYezqnEO7o2w9JqoLoYl7wu1OyVnG6KijY9rL5Xm
 PA7nZ+VN7k9DmQxki5B8RUx+eT1oe+1Q9hAfq6DZ7Eq4oJwn/o3TRRnXjathdQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABnmSDw9LYq4v5N+VCx0aeqTwhfyNUQyyTwinPTsmYJ087u4IErS+1/cM4EpKe/q7qVZpeZgJeupC7oM54qHrhO3/Q0nkyXw5o5uhcHyfR8IzfI4MS96dXbB66YkgIRReL2lc1q1gL1tkaITfEw5cyqlI+EJ+0aAnryUxCZ/Bfi3wbOiJNHXDHkjo4zdYb2ZhB3cgqa8EuMX9sfIJe1UiIDoRPG/sE5UXUwI9KacSBDBQEH2RXggS27RMfgS/FeFdwF+smAh7QAbN3yFEK8c9DlqgozapJgHtYeQcDH4PfPLKnC8NrCwfPAX1Rk96ckGDOzHPhqpEVjAOa+OGMXhEHZuMMisR2Yy/FAnYbXRdJqMsv3vd9ZalZPphv/X2NSFIb8tSjj55obO6N36eUbz7I6MbC3FRNoHrrAy0sq6ICXw8nJd9LP9SlB3NQEBes7ywJKHLZSiiSQyH+P3B9O6FxclpQkpEixB8BhFiWQQ9xzO3On8P08zN/8avvhNuXtY5QBBmMnDmsvn2+syAfuDx3VtyprmUq2jchfUKL8BnI2bKnhzWyD1+VnxI63qV8gUAJZLELLuttMo2wglXjRoM41LReduDei6XVghGuKZqc/ZU18t5LHv3IKXnej6KB4fok6JUkZC8fcYyzwx4/4TJPt2GN8bxZsZ2Ilox+ZAgcMD128sJNAG58xPlHoJ/WzimzTPX9yFBGFHxpnXawR60qSXOXMs76KrZsnQ4+utHw7/eNwHrVbEnIizxceRNikeOhm19T5ALle1H1RtHVmLXZLV3Qccu7U+AhBXFjyNfCf098di6pMfmcZ8iXXigAUp0KJlgaag0cPwS6g0MX/pigf9DxsNajsMOaaxPrn2i7phQEN13ynzozzMn16w49mQcaVB2f8eY6HmH7luL7GUfa1Sb20iMQqig2b7q4L5QpZhlSsk8kcPXut/4X3L7IuWrnQiot4cVSPDKilYaO9Zg=
Received-SPF: pass client-ip=57.103.86.35;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


