Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB77E98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSV-0000i4-T2; Mon, 23 Feb 2026 03:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSA-0000G5-IE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:06 -0500
Received: from p-east2-cluster3-host1-snip4-2.eps.apple.com ([57.103.77.213]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRS9-0002Dr-2g
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:06 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 D46911800216; Mon, 23 Feb 2026 08:37:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835882; x=1774427882;
 bh=Yw2iHtZGO16hdnJZFWAJ0heEY7g82L70ivWsP1jY3Mc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=W+UA8sN8GuU4a5hYAIC7ZLk+MVyc5CiL4DDwSNs2A45wGZOACP1emDSKcdJqxNM/dLstP3PixeO1cRtlN/FyMJSoPGS4sQpHi9IRJaBDAjkpkPhF1KUU9Pqnqj2RES8QxTD2o0SXL0hQM6/6OtebJGsl5xsPtuz5NBwqvADW6v0ArN1sLyjp1XCaz9ExNrI6mSf2fUwz09eiApXiVFhpO1pukC6VSgUkk76yJLc5PrS1faGuV8cH/BlOGWi93zsOEjSXGdkv8dCO4JmhHwv8sBRPamuhZmrGRC35cWjQSjmLcV85WrWP2VXxHqUebS78JsO3Y5IfBHbZOE03cjeORg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 CA1E5180016F; Mon, 23 Feb 2026 08:37:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 08/27] whpx: refactor whpx_destroy_vcpu to arch-specific
 function
Date: Mon, 23 Feb 2026 09:37:14 +0100
Message-ID: <20260223083734.48533-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=BPy+bVQG c=1 sm=1 tr=0 ts=699c11e8
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=MnziPJL1nimGiMRD7rAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: i8J1UlTfHBm4xyC2pRreQvQe1dJCorGz
X-Proofpoint-GUID: i8J1UlTfHBm4xyC2pRreQvQe1dJCorGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX1u7HQ61P8VQ/
 dZoN9TbqHNO3QbA1azoOmyYQthCtviiu3Hqls5lHGJZqW7HQIkOMr2pd5xlo/0GgPG7WlLECUUV
 Jj8M4XEZ8H+ZGYElTaP9XsGEjpe6BtDQEUUn0Iz+DvzubOb4WBHlbk3zuBScOsrzhkk0ngGITGu
 Zk+jdDyKGPnAJCEl7C0gW1/cwAdDT1ZfP5TFi7cNwDY9s4Yp3Sbuqp2tkFEt1Um7ELN7Bcn6s5D
 h1XpnNdEziLIJqdUrHoqBe6GyBKViUh9/5lNAu2xToSQIlzOZPgomM1hp5MqkUoTPRFpIbNoBO2
 HRoawbex8xkuqYnSHlt8Xq4wrQ5WNZHMSCtZ1oPe/aYw8lZdDikB37y9j20R3E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 clxscore=1030 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABAsQCyXNpMfvcV5CHKvstyp3KhsVgEKfp7XMwjab3cbJ4WtxG3ZuYnM35L/tbm4y1MHJgb6dBwHep9Qwo/dIckGrtU65GJiURPsxBngSoeEzPCAZB8wA0iLd/n2S3lnTaBdDXIxcdSISpX1PxK/tf8vJ6P38r00rdmgoMvNif4y9/4Is50aeu27UeE7xkkotVIYhkP6g45dES+5ypt/FPJyj2Dcma33VH4GHI66FvdgQ2IYKa/3DiEsqjphTaL1rnJQiCXvS6E7aBEpPfDQC2JqGviSFCQODiMypwt4JIA4F6BF71OzdaCOfBbmsvwiHvtc6sodKzqpZnaHMMT+uEOLHjc8bfREhLrmKk8UxSdDZSWSjBgdsGOCGa8yy7AFpQYLBG6r4ENla5u3s4DyETj5TaNNAVs53bN6wi2FjbKNEEb4AeNZTxVyIV28pUb13VWOoTKnk6HG8AFnpnC0Lm2ZotyZE0oejLz5T2zoffSV/sPDltYBAYtjcmqRBEoMo7NY96NmIntkpo5MozDaxoxFYr8c7rdRW9tpfU2MuIA1z2nm05t6RqxzH0VPQa62jQkp1ELwCpD53oLpOgm9Bb5iUHdnXTeOS357TsLiqiNaARFiUOlKoH1YOfjHFc5gEpTQTtkGECXpTbHW0DOqbnFzCcKvZyReTpp+p20ZdiwRm2ZlD8lZxuJ6VYs5sbu7zU2XPS0W9lpMnF7kO2wc6Qj4sx33GEhw38w7RasebSx5rjRooVRQA3L/LpLfZMzf7Wuk082ZUnfyTxRo8XdXC6F9EA2k3O5G7A/1Jr
Received-SPF: pass client-ip=57.103.77.213;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Avoid a TARGET_X86_64 define by moving platform-specific code
away from generic WHPX support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/whpx/whpx-common.c    | 5 +----
 include/system/whpx-all.h   | 1 +
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 6 ++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index f018a8f5c7..c57a0d3f0f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -236,10 +236,7 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
-#ifdef HOST_X86_64
-    AccelCPUState *vcpu = cpu->accel;
-    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-#endif
+    whpx_arch_destroy_vcpu(cpu);
     g_free(cpu->accel);
 }
 
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 3db074c38c..b831c463b0 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -17,6 +17,7 @@ void whpx_translate_cpu_breakpoints(
     struct whpx_breakpoints *breakpoints,
     CPUState *cpu,
     int cpu_breakpoint_count);
+void whpx_arch_destroy_vcpu(CPUState *cpu);
 
 /* called by whpx-accel-ops */
 bool whpx_arch_supports_guest_debug(void);
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 8d0ca794af..d52580a082 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -309,6 +309,11 @@ bool whpx_arch_supports_guest_debug(void)
     return false;
 }
 
+void whpx_arch_destroy_vcpu(CPUState *cpu)
+{
+    /* currently empty on Arm */
+}
+
 static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
 {
     struct whpx_state *whpx = &whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e1f0fa5e77..cdcaebbe16 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1277,6 +1277,12 @@ bool whpx_arch_supports_guest_debug(void)
     return true;
 }
 
+void whpx_arch_destroy_vcpu(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+}
+
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-- 
2.50.1 (Apple Git-155)


