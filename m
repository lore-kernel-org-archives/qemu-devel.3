Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5AB606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=RqqGsJpb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLja5-0002WF-QL; Tue, 27 Oct 2026 11:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0000zr-LX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:13 -0400
Received: from ci-2002c-snip6-3.eps.apple.com ([2a01:b747:3005:206::1a]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYq-0005nz-No
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:08 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 53969180015A; Tue, 27 Oct 2026 15:58:01 +0000 (UTC)
X-ICL-RepId: 01a17e15-3429-7fa8-8731-523096c02f0c
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZeHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116683; x=1824652683;
 bh=67F/rdOaCu8mLBRLTBMEeqP7tt8IubwPGfymsAi0sYk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RqqGsJpb4wIdJNubI0RRhkL6BsDXAYXabV9YBhKaCqcGGMScTGVaEGpIR84ZFxCHXC/P8Of8g3ckF/wVvqsZ8P6aKNmLLKeAeWO+JCDN46Um3AbEohNC0dYLirubyStU226SbYqcGaqTjj3rPGUrGyzGXwfhWbUWc1mvrOZaxj/Nbm3SyHYx3CN3v0x/8HNUMU1qBUYpEhQ7Wcph0ZdT2Ja93+VJoFD7+iqLA7v+S9EviDuAzDe14sX6RGmhwYt8UGzk+OwHlPpQN1IGFkwGhv46EZk23BBobvNNfHUnA4A46Q9Sh3I2sxRQf6VeYww3g6PIq0KQog61P4uA5UIM7w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 B330A1801A45; Tue, 27 Oct 2026 15:57:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PATCH v2 14/18] whpx: i386: fall back to xAPIC when the MSR exit
 bitmap is unavailable
Date: Tue, 27 Oct 2026 16:57:33 +0100
Message-ID: <20261027155737.59271-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=IYiKmGqa c=1 sm=1 tr=0 ts=6ae0ca09
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=LzqnFUZUDoiWbgQmKAQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX+NUrECHB5iBV
 USEHsROIE0nsSl6dXUKPtBMIus6WRDG7zRJDXiVxaDCAAKo1vg/LpAKopPcveY77Q0NltFay/x0
 T9FzMXoTiy8Ao7l96Ti3CrLv5LwNBzakXsaAvYl7XFk0FdISg4+qDdLEBHs7pkcnh8MZnfKphCh
 Ku3vcpHGR9d/JBnit6xxa/B/W0NJgodNIaHeKOFVGs7nragL5L4zCIkqi1HteFN7G9gAwahhpI+
 14NAtOfWlWDF5IIkK7roRvzWe6n6FFeyfEu2yYyNcgmhpKXOkJORiJ6WmVbRvp21x+gr1vvILl1
 zWTsBn1XG72afKq5ANAED6EsjIJauHiZFoU0CTpD2FbMaH9aWppb7wuL0DGYOc=
X-Proofpoint-GUID: uoP8Z_TQdPUCMCVylfgueGCsXdgXqEfV
X-Proofpoint-ORIG-GUID: uoP8Z_TQdPUCMCVylfgueGCsXdgXqEfV
X-JNJ: AAAAAAABd2mPjGHrkr2Jtf8slrwtxDJYM/aU8SlQBx0aMKmcaGRxY0th9Omf286aulFCVrzE4IijGHjI9mBGdJhCK2pq5p3byv05Lhi9apuScDENXSFOyFHKhhZVP1TW35NlQy3ieGz0MkMTy/2RSt8DWWWpWg1FsJqartBuHkVnSMi7MbKolIBnJr+QNfdlj4wxcE5//mRpHvxfkolRGAFlvTmm9hKU2GDDngP4sHGxnCXNthSEmOqwuW6aG7aqabMAJcBLMpCaM6eYuJiJtT29mVKt/4H+5ceofTvy4izEKuuxTYT/yybr6KaCoPMpQkX0kzmfoghgGEq+swJGVJ/MsaoE8umgCK6vlbfNgsfMyqfaFi7O0r1CM/BaNF7siWlBDMbL5laSb9t0Ua3dVYQiz3d9zQ0NRK6sDGLVb2pJy02clMV42HeAs9xucYOMV62v0/UUI58n+6BoEtFhYyUdT4TpTezHyf0hgBpsM1WSbvJ4sUx2/GwVOT0WZCpBT3Bbb0p2oxaKhWH/cXbsTv3sWniR+kNiOcDe0vBUWaZs5g9ZJPKtTP50xuX/ALkxprRYvt4NL4EptnIULTfO3DeWq0pVt0xOw0/86IuUN2gXLc7wy9vOKc5mdVpJ0AjScBIGncnS61k84OcRTS6XXj+tT8xvzsn0iiTHLo7eomeZj//V7PXggOWUIswNPw2F7hAieV8Q9M6iwbvXpaZIZshiAn/c1AGTn4GVyEabpBMFJuAgkK3r4V1Rtd+Dve28TW8Y4oGrPsnAQSMGZMY4RYfuRz+qfzprmAV8u7oKsd0X5JK5YYdNYmixkl9JP+nMBg2C
Received-SPF: pass client-ip=2a01:b747:3005:206::1a;
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

From: Akshey Taneja <aksheynew.tanejanew@gmail.com>

WHvPartitionPropertyCodeX64MsrExitBitmap is not implemented on Windows
10 version 1809 and earlier, where WHvSetPartitionProperty() returns
WHV_E_UNKNOWN_PROPERTY (0x80370302) and whpx_accel_init() aborts with
-EINVAL. QEMU started requesting it in ba1bda25b7 ("whpx: i386: x2apic emulation").

Treating the failure as non-fatal is not sufficient on its own:
whpx_default_props unconditionally enables x2apic, and x2APIC is reached
through MSRs, so without MSR exits the userspace LAPIC never observes
the guest's APIC accesses and the guest hangs immediately after the
firmware hands over. Observed as a black screen with an Ubuntu 24.04
guest that otherwise boots in about 40 seconds.

Record whether the MSR exit bitmap was accepted and, when it was not,
apply x2apic=off so the guest uses the MMIO based xAPIC, which is still
intercepted normally.

Reported-on: Windows 10 Enterprise LTSC 17763, Intel i7-6700
Signed-off-by: Akshey Taneja <aksheynew.tanejanew@gmail.com>

[Patch edited, version 1903 is the first release of Windows 10 with this API]
Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7552e9f4da..26ca879c89 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -57,6 +57,7 @@
 #define HV_X64_MSR_GUEST_IDLE           0x400000f0
 
 static bool is_modern_os = true;
+static bool whpx_msr_exits_available = true;
 
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
@@ -3027,6 +3028,16 @@ static PropValue whpx_default_props[] = {
     { NULL, NULL },
 };
 
+/*
+ * x2APIC is reached through MSRs, so emulating it in userspace requires the
+ * MSR exit bitmap. Hosts without that property must fall back to xAPIC,
+ * which is MMIO based and therefore still intercepted.
+ */
+static PropValue whpx_no_msr_exit_props[] = {
+    { "x2apic", "off" },
+    { NULL, NULL },
+};
+
 
 void whpx_cpu_instance_init(CPUState *cs)
 {
@@ -3034,7 +3045,8 @@ void whpx_cpu_instance_init(CPUState *cs)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
-    x86_cpu_apply_props(cpu, whpx_default_props);
+    x86_cpu_apply_props(cpu, whpx_msr_exits_available ? whpx_default_props
+                                                      : whpx_no_msr_exit_props);
 
     if (xcc->max_features) {
         whpx_cpu_max_instance_init(cpu);
@@ -3478,10 +3490,20 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             WHvPartitionPropertyCodeX64MsrExitBitmap,
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
+    /*
+     * Earlier Windows 10 releases not implement this property.
+     * It is implemented starting from Windows 10 version 1903 (18362).
+     */
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to set MSR exit bitmap, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
+        if (hr == WHV_E_UNKNOWN_PROPERTY) {
+            whpx_msr_exits_available = false;
+            warn_report("WHPX: MSR exit bitmap unsupported on this Windows "
+                        "version, falling back to xAPIC");
+        } else {
+            error_report("WHPX: Failed to set MSR exit bitmap, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
     }
 
     hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.54.0 (Apple Git-157)


