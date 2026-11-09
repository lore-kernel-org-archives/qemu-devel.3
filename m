Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A7606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=RtUQ0Fhb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDSC-0005qD-64; Sun, 08 Nov 2026 19:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRy-0005l3-29
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:30 -0500
Received: from ci-2003h-snip6-2.eps.apple.com ([2a01:b747:3005:200::4b]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRt-0006NG-90
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:28 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 39BE618001EC; Mon, 09 Nov 2026 00:41:20 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-a043-7aa3-8061-7f5a88cc6e5d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0cZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeXARGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184881; x=1825720881;
 bh=opYY4a7WwdY0NtTgAyFUM3t3WZLewxo/9KRcUSqAG0g=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RtUQ0FhbCsefbmXSY3G9fVLIR7SYnw/h5TUzlX9/o7Ow83YE37uVhzMwfdW44XN/8radMujw5OTXnfjYzYmZDnHmv6Hs2qawsS7ZiddbTCYC/mw0Q2Flbh6SE2D+/S+6sfIw0tWmJ6rqZv6Ae45oLwWfRjVtCorS3ZS4vRU0V9FNmCnd/+trKjIdPR2vgLi0vXHofk8u8pzMnm3gAr4Avrx0TtxzeyN+/cusuaOFR40oRi7h0WgnoJicvB8kVm6EHsn7JiaX5GzFGM9hcveLe4yQ6fkUP3MCx+B2jNvGY2UCPyymSFLwmBmb9kid0waHLJwc6mfLBgprSm3POQGj+Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 6C8B318007F9; Mon, 09 Nov 2026 00:41:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PULL 12/13] whpx: i386: fall back to xAPIC when the MSR exit bitmap
 is unavailable
Date: Sun,  8 Nov 2026 17:41:07 -0700
Message-ID: <20261109004108.85808-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfXwsiCgeOtSiHg
 0J/hmviWrv8irIrAzEgSQ5aCTkKxWMh+Y6ecb7oWCf6/CzFU0hM04USWYzVZXBAE76mPeLAzHxI
 PkrJGLyA8jtTkqqcgORhnIKFXmX0VJJb1lXKCznq6dHRUV7ZV81UIec4cE5gH+uwWmmZEZKIx0i
 I4Q1P/w1ykTUYdJMcqypReW18KG267BeQRlWmZVpheNE502ovR0ACY68aDlOhaFIY6UNkWWbvi6
 /oNn2SNJSaZzEyeGxrfzlxrPUFmb+RFzmOWyS/gCPiKWvhjXAFAeDuRPx1o/Jn8Vi9A5ORjvc8Z
 1hCEX/GT3RdMA8s5FRNwZqgD+sADEs4BE2vtxlHTmYHplfTCwbNjCNv1+xLiWw=
X-Proofpoint-GUID: UfoURmnHxwdj60kzB8Gx0FYE0ta-E3qa
X-Proofpoint-ORIG-GUID: UfoURmnHxwdj60kzB8Gx0FYE0ta-E3qa
X-Authority-Info-Out: v=2.4 cv=UL7Q3Sfy c=1 sm=1 tr=0 ts=6af116b0
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=LzqnFUZUDoiWbgQmKAQA:9
X-JNJ: AAAAAAABkYZYzOukb4gCU7Vywt0n1AuWWzENR57CLjneQe3jjFnMd+KKTYoFjsiprDj57J
 5KlPMF6E5Q0xzGQObfsWUvrwo+fxU1CUtqE3sLuCJ+qHxEPLAWbiwGXvEbqUfaBEkA5/8W
 mdYJHU3FDek6dwTkTtIT0W6RKcJLMSWHxGK2O9La5P9EGlwluk8Iz5+8iPXCr+OVseqk1Y
 mxPhkPP5To3XoTNUsALKs+NjJRCkPSDHohBakNpYDUqw+K579gKWpdrB+w7Ex3zXTh8Evu
 YjZ9/iJvzIzGC+iwfdbieFXuyOrpmh3m+S2XVjUmsEhfdBKfs+fVA46MaJSxnFPJA18f2d
 gDoxiSMEea40Sw2em75HW3uwd+hyZ57jLbugJ3hP5sQbg9167HCT7e2n2tqOLhudnnDBWf
 Xry4Bu8u6G9ZRjv6X6rltcle+MUMRXzXt97Qw2mdBG1Y5R9kBhHRaZn9L+6dvb/Mrdh3oK
 Mow2QZ7hk9Awy0lrP3k633AZ45MQl4iOiBQG4FC4Ks7gMWIGPs7/s2HNqSLs85/YOrlAvg
 kRENZ1nvGPf6e0HV2UF0HT3t+uqa1SkTM4jGQpnIpJjHeIjrdFUSpfI5u7hWy9jl1SgwoP
 PosSfhmfUqW3A+aOcgA61hqWwialounTikbhKQHlvHh+cf+A0lkNoDaE1fy19UKvK3ZlVV
 HK6uGdirT4cJUtcXejL1UY4sgep593ASYwEdcuTBgL44A8Nwmaqb1t528GPSAPWUDNpR7S
 yEOAjB0/LFGwbeipFOA6KgO7VDElTy4xR+fuBJvYfHQ9atytwywlzHf+d9vzPUQyIvE0CI
 Fbkucg1J6iTg7lZoG1PGhh7ApOzl+ie7/WseoH5/TOIy
Received-SPF: pass client-ip=2a01:b747:3005:200::4b;
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
index 7c2172a7ed..19a552c456 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -57,6 +57,7 @@
 #define HV_X64_MSR_GUEST_IDLE           0x400000f0
 
 static bool is_modern_os = true;
+static bool whpx_msr_exits_available = true;
 
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
@@ -3009,6 +3010,16 @@ static PropValue whpx_default_props[] = {
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
@@ -3016,7 +3027,8 @@ void whpx_cpu_instance_init(CPUState *cs)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
-    x86_cpu_apply_props(cpu, whpx_default_props);
+    x86_cpu_apply_props(cpu, whpx_msr_exits_available ? whpx_default_props
+                                                      : whpx_no_msr_exit_props);
 
     if (xcc->max_features) {
         whpx_cpu_max_instance_init(cpu);
@@ -3420,10 +3432,20 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


