Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96227606A326
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=MsoOWVOt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzd2-0006cE-HV; Sun, 08 Nov 2026 04:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbR-0005TV-EL
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:22 -0500
Received: from st-2004d-snip6-11.eps.apple.com ([2a01:b747:3001:201::29]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbP-00060l-4O
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:20 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 664E0180019C; Sun, 08 Nov 2026 09:54:17 +0000 (UTC)
X-ICL-RepId: 01a1ba94-8280-7734-843a-bb352d765178
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQRNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGA0MUFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131658; x=1825667658;
 bh=rBqaDytTLQzvHs/js6ubTESPReuCXdmTqeK3frThc2k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MsoOWVOt6lGHRMNTdWVnIzElO1evo9o3/N5k3cCYFsG0toftfP86xRHyao57n+zO429Y3u6QlcG1CsSVYW+duVj0Ikf68QMeb24T7gosp1OxvHuBj1Kioj4cClgjfMDfvyQa+wdgi0Rguv/1MChjcnXIshzkmv5WI0rnCBYWsqOS/yO+a2Eo0Fc9IpJzHezYIndvkSxmBjsm8wixN+xkwb4XQvhd55ZaeEsu0KmHM6IJtEzEuhcncDajy14UBWuB817xvxIYygiyEVYgsQvYOF3QLNlrb8HFsVcj9l2vDYUU+vWqDs8zluTLvqS8qn09fYceDFoMmZaBK9ilc7sb4A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 2E8821800199; Sun, 08 Nov 2026 09:54:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PULL 12/13] whpx: i386: fall back to xAPIC when the MSR exit bitmap
 is unavailable
Date: Sun,  8 Nov 2026 02:54:02 -0700
Message-ID: <20261108095403.70813-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iSRCx7dfCVX0EifqZGyX19ly3aQICrnj
X-Proofpoint-GUID: iSRCx7dfCVX0EifqZGyX19ly3aQICrnj
X-Authority-Info-Out: v=2.4 cv=VLfQXtPX c=1 sm=1 tr=0 ts=6af046ca
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=LzqnFUZUDoiWbgQmKAQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfXxJTtGTzIWbpA
 o9FuYfvqiyidfCGZOYMF3a384iZFGrxwS/A1PQgzxjBLz7Uk8yvViuwt+7VXm83QoaM2eGniyRm
 /rWstlkr6BrwooPv3bCjZ5W8HPWdlLavX8MRcB7h0FrdyKyEKlAqzcjklyKekrlRyMVHQx2KYJE
 74Xjbh6VeESc1dKrJ9wOQiy6BWYrv90t3Yhlr9RQK/wQgTWunIjuUDZxY/TAY0cE1vB1Uy5sMui
 TTL4GNYWB4buUnBCUdB2mGS3m2upldYFteeSBqbZAI8oXpRNV68QM0FtpSIwSajdyy/wFC+yU9N
 1FpSpJDAMLhuc3ztWc5Pe3gSy6hsWuzFEtwVvGyk3WjxxymmdrG3muIpUztCHw=
X-JNJ: AAAAAAABS9VgKkJykG88w+KrvLzvu9Bk1t0BsHTGwbHf8WB7zf16SUp5PUxeK9u2ATzejn
 fNsLypPaa2aigKtafg+bCI3gR1FnUdwF+ERAVlIE32Ayp9lDeq9TJUpU8GSaST+OHFVzs/
 xWQ6AhxZFCvsUybDxPIMPNmw+9DN++gmD3/wIMam4DJ+OpGkZec5Z9we/fLfWw/x03QYrI
 wBmZddWlR59pzWOd0nhkeP5CFD9fw1P2Kuk9AeHNjcEhV64vIl3wr7oAOuKTmrYTjxudZi
 zLZF7Fr5l1jaNYeWSVftS6sUzA5ye5mxrglLomv9DGI+vi2w9qYGC5SPJ+FrDDTDk0Bbdz
 1u18Plz+pqn9wozv25fbL12/xuL5R5H32S8qD1d/hoXPLBV1qTi+xefnHWQnuLS2WKEkQb
 ORQ4aOm2AMjiZQVohprrrchoxroIaeyZgpDlg6E2vFwX2GKA0bq+uhZrJbZeyryVA7MeyO
 rbo1NA5istvXg1HTjTYta6Sw8BU8hVQrw8HptWTKrQbzvo6cMD0FHmRINqeR8Yd4sODQio
 pkevomGWGbtry2fV4+GErLguB+FW3H7Hu/sSCTq4aUA7RGKCEUZcws8MK5sunLH+neLNcV
 vAIF8I9V4xK9Q6O8AbDHr/2OhiRI1qdyBkRNI5tAscdl+7rkOQhL0W85v58kboesBWfVtP
 pdm3EKeLGoOo5X8VOscrb3PTdXrlbpz+mDcoJAyUycR9psQglGFPHWBTblXXnSpPPSvb+Q
 cGwnoseD+3Mzs3giuDoJ2W+MXtATASsSslWCh63p9Y0tOOkt+hhVZ3yp3Rl2MgUdEkp4ne
 A2fO8L4OClXQK7O5invadYncciTJvPTAiZlDJ4b5aBc=
Received-SPF: pass client-ip=2a01:b747:3001:201::29;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
index f40409b330..7a41ab1542 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -57,6 +57,7 @@
 #define HV_X64_MSR_GUEST_IDLE           0x400000f0
 
 static bool is_modern_os = true;
+static bool whpx_msr_exits_available = true;
 
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
@@ -3008,6 +3009,16 @@ static PropValue whpx_default_props[] = {
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
@@ -3015,7 +3026,8 @@ void whpx_cpu_instance_init(CPUState *cs)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
-    x86_cpu_apply_props(cpu, whpx_default_props);
+    x86_cpu_apply_props(cpu, whpx_msr_exits_available ? whpx_default_props
+                                                      : whpx_no_msr_exit_props);
 
     if (xcc->max_features) {
         whpx_cpu_max_instance_init(cpu);
@@ -3459,10 +3471,20 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


