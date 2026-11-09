Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0B606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=yZujYE0c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPSt-0004el-Qo; Mon, 09 Nov 2026 08:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSb-0004dB-09
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:58 -0500
Received: from st-2001l-snip6-11.eps.apple.com ([2a01:b747:3001:206::79]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSX-0004Zz-K2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:55 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 A740D1800E3A; Mon, 09 Nov 2026 13:30:43 +0000 (UTC)
X-ICL-RepId: 01a1c081-0619-7353-a8cb-fc76f51df67f
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQdNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQABJAF4HWAdeDkELWBpTHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794231046; x=1825767046;
 bh=wmPIzf1jg2PnIDoQSl7uyALTt38GJaFl9tv4frcQEJA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=yZujYE0cvNvipRst2syejENR+zWLBv4CHQddf3b5jhOYw3Txo4XOyVe1ubJEyYZ0I3EBtIsoBNmA0lJvKLWn8V8pMV0dfsZDwLt+z+e7YKKAyPeBCggL1sG5ngrV05q9OFBbL3RgZpAHZopGCAEOeSqIeVV114ZmBXs+/pi88/DLnvbtG+H7et67qYtSFqlmkfv+vF/PvnKB7R2dAqfTE+1FKujum6cpZXfhGxfoWcI+lL6+aohOF6wacRHPsmXYjqbyiQ9i3oZ1HLTXgP1Og6v6QM4xt6/Zdd6l3R1czodFPO8L3dl82qjVcLFRa1dyl4n8rA9tq6nus30QkF/yrA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 A4A9B180137A; Mon, 09 Nov 2026 13:30:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PULL 7/7] whpx: i386: fall back to xAPIC when the MSR exit bitmap is
 unavailable
Date: Mon,  9 Nov 2026 06:30:35 -0700
Message-ID: <20261109133035.7985-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109133035.7985-1-mohamed@unpredictable.fr>
References: <20261109133035.7985-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TM57wAsEUFrJMw3Uh2wbS1oBoVIkcRhL
X-Authority-Info-Out: v=2.4 cv=dP+rWeZb c=1 sm=1 tr=0 ts=6af1cb03
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=LzqnFUZUDoiWbgQmKAQA:9
X-Proofpoint-ORIG-GUID: TM57wAsEUFrJMw3Uh2wbS1oBoVIkcRhL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfXzAlsqSERl9P/
 bj4YIB3KIvxHkK7CIyKV5c+cvebaH81q3j+3sr5rPIAsBGDPx57YcHLzkl/+DAmnEO/OCZETMFZ
 ajFVFYD8xbjSy32XetoZzalZ7b+yzNA1duEFhFpLQ5joxXsJcKxcZKx8uwDCdAqV+XjHqSi1Che
 q3aHzzxsWaAsxjXptxmL0Nw65qICyB3HrWQX/ezB9Gm6tv5L6VuYc5exlX1wLSbBYMoVMb6OBRS
 7SMM984c/CInjz+lRquG4E6zJEsylQ3w1yk4nnWCuVjrpSxJEeU5ght8oPo3QYP3cCGDeElfoh2
 NZWoM+A3EO40V2PXQLWl1xuZ7tfPrvgociSdpFKrSm6Eeu1naFCr79kSUPXD9I=
X-JNJ: AAAAAAAByjAileoU7XYLUfjUJyP9muXztxWHyo8EEz0FThCSmfqQxHHwNOQraNZOhVZXoi
 73heKNvCDKVTxncSm1gXOAVZxRMT2jC3a0t8QNo6uuijLzVyT8L3xyhGm6Kp6nbIZEM9Nh
 jqzYKYNh+4rX+OA2lQAICEdU3v3siq6WAvJicsf1kIyvLhkxg4a2WfganWK4gu64rU4ZJV
 RFkXSHFoMEIJlK+kYima/sQOOowJTfa3n2VlCCWaB3t6D00J5Ee9d62WxxmROCwQnQ9PJ2
 Ou5jQpqrwS0DqElo/V0aSPakeJmufohfPb++GEDkrgbsOwzC4XOhwsoThK8HDtEV2UCusK
 GyeMUvhJWyze5sYhnfqlPSX0KNYsjn4pywrTA0hqg2MeSRZRpjjtosO+HfRLeYtDB2e6bA
 ieKaajgXiYPJQDKghzPbqC6wWE1d5fSwVoebvCFSobPq6vMfKLU3lIWrY1vjNpbcrZyybC
 JtxPvQMdEctblg70VANcfJSjoky4pxRKl+RzCA1iZLTwc2DO2OL/IY/YLyN2BAL8OiR2v9
 ErO/yUKS14gknEdV8CuVS27jfPH1/ak74Z9x2M139VOAP9EECLQwn6VC/O0X7AKMVCRZmN
 aPv3+3yHOP1es7FLHqlytJV5MIm9BWpURWRKqIdHa5T2jYG9eHqqq6FzWSGAfhlzD9jo/S
 AMTSG9FRRW0y7MMWPjPV31ckxWkDjbY/rxMLA2er2KLY8i+3ptFhsRm3L9oPH408hZvSmv
 eCl6rV253tM6g53VjkghEw87B1Yrw=
Received-SPF: pass client-ip=2a01:b747:3001:206::79;
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

Reported on Windows 10 Enterprise LTSC version 1809 (build 17763)

Signed-off-by: Akshey Taneja <aksheynew.tanejanew@gmail.com>

[Patch edited, version 1903 is the first release of Windows 10 with this API]
Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b386368f1d..df1c772eb3 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -57,6 +57,7 @@
 #define HV_X64_MSR_GUEST_IDLE           0x400000f0
 
 static bool is_modern_os = true;
+static bool whpx_msr_exits_available = true;
 
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
@@ -2981,6 +2982,16 @@ static PropValue whpx_default_props[] = {
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
@@ -2988,7 +2999,8 @@ void whpx_cpu_instance_init(CPUState *cs)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
-    x86_cpu_apply_props(cpu, whpx_default_props);
+    x86_cpu_apply_props(cpu, whpx_msr_exits_available ? whpx_default_props
+                                                      : whpx_no_msr_exit_props);
 
     if (xcc->max_features) {
         whpx_cpu_max_instance_init(cpu);
@@ -3396,10 +3408,20 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


