Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4039CD3427
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 23:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIx3d-0001Qq-UP; Fri, 01 May 2026 19:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIx3c-0001QX-Cy
 for qemu-devel@nongnu.org; Fri, 01 May 2026 19:14:04 -0400
Received: from qs-2003a-snip4-1.eps.apple.com ([57.103.86.4]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIx3a-0005Fg-Ot
 for qemu-devel@nongnu.org; Fri, 01 May 2026 19:14:04 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 C72AD1823FD5; Fri, 01 May 2026 23:13:57 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXgJBC0sCXgJYHEYKSQtZGlofHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777677238; x=1780269238;
 bh=CGSs6CJWNP1wY+Ol4DxldizRyP5cLjjcFoEWVaZx0V0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PoKnL/FClq1LtCzW70rFj+adz6rGPG6Cvn7/ma5ehSyeWWxvCqS3XQi8Du1FcveSf3lzmbSoZFrOyrRtphFdpxXupL/aDjRZ5gl7c1z4/GoMBvsTXY3pwle2N2hGcFy2oW0+dnqnpwgaBSyMEkf2umrs06PHOtB7Ma6tj1B7z0uyF9bizp18fLZfLOwPhwutEKwT8a2x0saxSiBlwxIclPOoOI2AekV0pxiyTl4ohJvYoEEUv9pNd9+yJU/U2uN6P9jnDimu4d+2FhCDenH/VbR+5EQSV8QwW6nxY84mvSMi8WcFRgGQ/vQpQ6f4oiN5+t78xJtxbtDEASaeeILJRg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 032B21823FCE; Fri, 01 May 2026 23:13:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] hvf: arm: override HV_SYS_REG_MDCR_EL2
Date: Sat,  2 May 2026 01:13:53 +0200
Message-ID: <20260501231353.63184-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FUAH6HWu1Bov-7rRZiUtYvdvycdJn30K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDIzMCBTYWx0ZWRfX5SdMU6Dwsh6j
 0M8BaVWuBXO99AYcvSn5JmFDm0wiwtM25P5QHzl621+TQqDL8mo9Uih3eGlx0zpYBp8qar6+qKr
 oXAIodf0jKT17arx64dN3ZDfWWGniOiHjNTBzNlnGoTt1QnBptX7DetDuTPdQ4Cso2jWnh2Tpv3
 YJ7WQ4g9HmLEuljo1DTZmDXDVx8mxm/4Kz9iC4glwrlEKTVVCC7CU+/bEMEdY77IHKSMsuqkrXx
 DXfnf8Zh9m+Ka3YNs5hq+XgLNZr/SpGAP56pWxEDxx435QZGaZhWR2vidbG/iHK4l2qLABjOze4
 6wSUy29YRE4t2sNDHjEjSjgnjMpWljkeYPEh+Q7Wu+B0PaaBtsJs8iwMH9Mzuc=
X-Proofpoint-GUID: FUAH6HWu1Bov-7rRZiUtYvdvycdJn30K
X-Authority-Info-Out: v=2.4 cv=Pu2ergM3 c=1 sm=1 tr=0 ts=69f533b6
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=t-IPkPogAAAA:8 a=KvODUgOX9gEuU6Qg7WAA:9
Received-SPF: pass client-ip=57.103.86.4;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In older SDKs, MDCR_EL2 was defined incorrectly.

As such, override it with a #define if compiling with an older macOS
SDK.

This is a workaround because the macOS CI setup we currently rely on
has not been kept up to date, to be able to land nested virtualization
support.

Once CI is updated, the SME stubs can be removed and this
commit can be reverted.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4f0f7ffba1..79209bc8e9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -468,6 +468,15 @@ static const struct hvf_reg_match hvf_sme2_preg_match[] = {
 #define HVF_TO_KVMID(HVF)  \
     (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
 
+/*
+ * In older SDKs, MDCR_EL2 was defined incorrectly.
+ * As such, override it with a #define if compiling with an older macOS SDK.
+ * https://lore.kernel.org/qemu-devel/BCCED674-EAEF-4755-9BE1-116FB36FB5C9@apple.com/
+ */
+#if !defined(MAC_OS_VERSION_26_0)
+#define HV_SYS_REG_MDCR_EL2 0xe089
+#endif
+
 /*
  * Verify this at compile-time.
  *
-- 
2.50.1 (Apple Git-155)


