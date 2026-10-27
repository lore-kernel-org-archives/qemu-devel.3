Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518C606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=E6IjADUp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZv-0001yf-EW; Tue, 27 Oct 2026 11:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjZ0-00010M-Pg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:15 -0400
Received: from ci-2002g-snip6-3.eps.apple.com ([2a01:b747:3005:206::42]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0005p3-6T
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:14 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 B428F1801A45; Tue, 27 Oct 2026 15:58:04 +0000 (UTC)
X-ICL-RepId: 01a17e15-4173-7c1b-88ea-2b6207ce6efd
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZTHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116686; x=1824652686;
 bh=45x198cocFqRZTEY88kZCTN60ge9TWP19GDSuyvAUEA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=E6IjADUp14RG/5+8NpzZ+9DCtpi1y+Q2f/RYWrd7imZ2CdRX5buQfMVkn2YM9lV7eNoC4QesuAAqgBJG1Rrfmf8UcEmzq+nUwppq1CJo3deIbmeXYj0cbaKu1kQYb/tM/Cl2NXMe/V+5qbDA30++fc3NRqeHRVtmQpZGMWwzGL1OBsHNK/gPxwEk+4FqI6sPp+Aq5+3UroEki+0RfSyys3u96RicJmvryR4ocB2mqJsHeKMsfDU7jtg45GRH8YUjOps/NtMDiOgEJUJ5fGGmXQU4KFhPpz3Ue2pHQbJuO3hpr0NP75t4g/p92pknTzF8bok57acg4m35fxBMgNwmuA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 2C77618004B8; Tue, 27 Oct 2026 15:58:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 17/18] whpx: i386: save/restore pending interruption/events
Date: Tue, 27 Oct 2026 16:57:36 +0100
Message-ID: <20261027155737.59271-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX/IvviXcuwIBx
 Ea2Vc1OPkLOOaMRv2/ZzqSgn00S+EAvkKCaTEqyUV3oiprDwoqIBl9c/yLEyECKdPmnFk/8lNvX
 X971/i7rThsX+Un5kcuEA8voI0kCaraOvQQgMP7RYpUWZAqI4V0slLvLYR013++iONMyqirxck+
 Do6uM9AmOPNHGmpYC8geemXckNFl58vt/Gc6kEDfP1heARoLUkUxFb9HYTMHzsMWdQ08n8V1zfQ
 +YbJ/ZiiN9vZ2q7Zzb8RQsivddCnZY2B6ZuEAqaQjvqjwLdnPs7wFC0/556OqKWnV/upA+S4peN
 EB3M7GDsW1mXB0Ww641gJrHqb2xT4MHNhWDhDp3W2er9A55/6cA7kkmTFJXxTU=
X-Authority-Info-Out: v=2.4 cv=deyNHHXe c=1 sm=1 tr=0 ts=6ae0ca0d
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_XAUb-8rtZnliU9HzusA:9
X-Proofpoint-GUID: XmYW8TSBa5f4ZXz5CC6t91gXc08I9qnH
X-Proofpoint-ORIG-GUID: XmYW8TSBa5f4ZXz5CC6t91gXc08I9qnH
X-JNJ: AAAAAAAB2g1bl4QhlwpqT01e63KU1xYObdSI1i9TJyZvARAMac1rY0oTTYDFpgAy7LBI1ver1o8rwUZGz31WQngeySZM0qFSfceU2brr07XLcTufDwXkDnMZ4Q0zqPIOYYymi8dNKCAcmb1O68KUfPkZnCpnupH/sE6niGZ+1g+BHjCfVJ7IxY5wajWZ8dXgWAZg7Mvip0zYySpn2IF+bB7OUSCFynD8h4WNcZIDDFmzqzmXIKG5ANjoO7TKH8KUNpVN0U9ta2xIoNbhpWCi0EfxrRgyCntbhXplr1oZkIX2b/geUeHfK9KqXKyARW4xb2yrPbqqM3bjBj5GTlWwHrVm8m/ticcIgAmlO1EYsPMmZeVqobJRrp+wz0PacjLvKiL7YE/+WtkiKf0Fy6Wk5jrXs+r2FQTgN4p46xOqd/rKNz8QZWq7A67eI/pYZpgGe/k6itcdyDju/Dor1GOy7MaABm0ZjB2RP/km03lelO2u4oHh/O6innG4hkYciT+ghYNi2dyzeJ8nqUa2mhcOzMsNz32rwoKWj0pPHji6gv+FRNnQEp+799TZoh4zb5tnglfegN2LJAAR2bYApXuO7cye5tpQukwZs/m6WBeX1t5wGPRJAFZfhk+hiPV2Y+v1JlbasNhj4EHpCIK0vQ7TDM3dWvpjNNhRsBV4jzZhnFKhCxTSmzCAiaY/3MwdQTJi/uALRj2BNxW5mIoeZqDUHV9erfYOO9NndkjV/qfYXhYmick7HnPH08p/ZauYkFhv0T+LXx2zl7XeLw==
Received-SPF: pass client-ip=2a01:b747:3005:206::42;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 106 ++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d2cd8e8001..1447c777d3 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -121,10 +121,11 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterDr2,
     WHvX64RegisterDr3,
     WHvX64RegisterDr6,
-    WHvX64RegisterDr7
+    WHvX64RegisterDr7,
+    WHvRegisterPendingInterruption,
+    WHvRegisterPendingEvent,
     /* Interrupt / Event Registers */
     /*
-     * WHvRegisterPendingInterruption,
      * WHvRegisterInterruptState,
      * WHvRegisterPendingEvent0,
      * WHvRegisterPendingEvent1
@@ -694,7 +695,47 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         assert(whpx_register_names[idx] == WHvX64RegisterDr7);
         vcxt.values[idx++].Reg64 = env->dr[7];
 
-        /* Interrupt / Event Registers - Skipped */
+        /* Interrupt / Event Registers */
+
+        assert(whpx_register_names[idx] == WHvRegisterPendingInterruption);
+        if (!whpx_irqchip_in_kernel() &&
+            env->exception_pending) {
+            vcxt.values[idx].PendingInterruption.InterruptionPending = 1;
+            vcxt.values[idx].PendingInterruption.InterruptionVector = env->exception_nr;
+            vcxt.values[idx].PendingInterruption.DeliverErrorCode = env->has_error_code;
+            vcxt.values[idx].PendingInterruption.ErrorCode = env->error_code;
+            if (env->exception_is_int) {
+                vcxt.values[idx].PendingInterruption.InterruptionType = WHvX64PendingInterrupt;
+            } else if (env->nmi_pending) {
+                vcxt.values[idx].PendingInterruption.InterruptionType = WHvX64PendingNmi;
+            } else {
+                vcxt.values[idx].PendingInterruption.InterruptionType = WHvX64PendingException;
+            }
+        }
+        idx++;
+
+        assert(whpx_register_names[idx] == WHvRegisterPendingEvent);
+        if (whpx_irqchip_in_kernel() &&
+            env->exception_pending) {
+            if (!env->exception_is_int) {
+                vcxt.values[idx].ExceptionEvent.EventPending = 1;
+                vcxt.values[idx].ExceptionEvent.EventType =
+                    WHvX64PendingEventException;
+                vcxt.values[idx].ExceptionEvent.Vector = env->exception_nr;
+                vcxt.values[idx].ExceptionEvent.DeliverErrorCode
+                    = env->has_error_code;
+                vcxt.values[idx].ExceptionEvent.ErrorCode = env->error_code;
+                vcxt.values[idx].ExceptionEvent.ExceptionParameter =
+                    env->exception_payload;
+            } else if (vcxt.values[idx].ExtIntEvent.EventType
+                == WHvX64PendingEventExtInt) {
+                vcxt.values[idx].ExtIntEvent.EventPending = 1;
+                vcxt.values[idx].ExtIntEvent.Vector = env->exception_nr;
+            }  else {
+                abort();
+            }
+        }
+        idx++;
 
         assert(idx == RTL_NUMBER_OF(whpx_register_names));
     }
@@ -1091,7 +1132,64 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     assert(whpx_register_names[idx] == WHvX64RegisterDr7);
     env->dr[7] = vcxt.values[idx++].Reg64;
 
-    /* Interrupt / Event Registers - Skipped */
+    /* Interrupt / Event Registers */
+
+    assert(whpx_register_names[idx] == WHvRegisterPendingInterruption);
+    if (!whpx_irqchip_in_kernel() &&
+        vcxt.values[idx].PendingInterruption.InterruptionPending) {
+        env->exception_pending = 1;
+        env->exception_nr = 
+            vcxt.values[idx].PendingInterruption.InterruptionVector;
+        env->has_error_code =
+            vcxt.values[idx].PendingInterruption.DeliverErrorCode;
+        env->error_code =
+            vcxt.values[idx].PendingInterruption.ErrorCode;
+        if (vcxt.values[idx].PendingInterruption.InterruptionType
+            == WHvX64PendingInterrupt) {
+            env->exception_is_int = 1;
+            env->nmi_pending = 0;
+        } else if (vcxt.values[idx].PendingInterruption.InterruptionType
+            == WHvX64PendingNmi) {
+            env->exception_is_int = 0;
+            env->nmi_pending = 1;
+        } else if (vcxt.values[idx].PendingInterruption.InterruptionType
+            == WHvX64PendingException) {
+            env->exception_is_int = 0;
+            env->nmi_pending = 0;
+        } else {
+            abort();
+        }
+    }
+    idx++;
+
+    assert(whpx_register_names[idx] == WHvRegisterPendingEvent);
+    if (whpx_irqchip_in_kernel() &&
+        vcxt.values[idx].ExceptionEvent.EventPending) {
+        if (vcxt.values[idx].ExceptionEvent.EventType
+            == WHvX64PendingEventException) {
+            env->exception_pending = 1;
+            env->exception_nr =
+                vcxt.values[idx].ExceptionEvent.Vector;
+            env->has_error_code = 
+                vcxt.values[idx].ExceptionEvent.DeliverErrorCode;
+            env->error_code =
+                vcxt.values[idx].ExceptionEvent.ErrorCode;
+            env->exception_payload =
+                vcxt.values[idx].ExceptionEvent.ExceptionParameter;
+            env->exception_is_int = 0;
+            env->nmi_pending = 0;
+        } else if (vcxt.values[idx].ExtIntEvent.EventType
+            == WHvX64PendingEventExtInt) {
+            env->exception_pending = 1;
+            env->exception_is_int = 1;
+            env->nmi_pending = 0;
+            env->exception_nr = 
+                vcxt.values[idx].ExtIntEvent.Vector;
+        } else {
+            abort();
+        }
+    }
+    idx++;
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-- 
2.54.0 (Apple Git-157)


