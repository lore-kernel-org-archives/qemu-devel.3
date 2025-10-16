Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A173CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UTC-0005Zf-NJ; Thu, 16 Oct 2025 16:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UT7-0005YQ-TG
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:03 -0400
Received: from npq-east2-cluster1-host4-snip4-2.eps.apple.com ([57.103.77.15]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UT5-0000x7-Em
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:01 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 6446318005FE; Thu, 16 Oct 2025 20:20:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=aRq3YU5535mG5uSPAFBSlmsbBJkL1R5+IAqIsTf/zZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Q5Kmf2c2LdGezhxzE/ZBDH5dAE+7LDDxcHNt9UwEuQNGNZViB26aJEMT3KAaLmC2SSsLH8x4Y1nNuFBbn7gTRvkbB+1ANf5gNQZTLy7ncr6gWwh4eImz8U5mT1+/ngdgf0RP3jbQhfTowsJErpmoJSV6E9nEQUKzBEDV/Ui2lG666RkfW86T2zXAmrWhWyWhsCqNnTJNE1HFdD8eSLMhbIlfyAhOKZg9+6dAfINeRpku/olTYPWjyUkhJ3D0wxKcxPxQ/+l+5ya7CypePaT7ANA4ax4GeAOtrt6Lq6bV8GSGSjFHnbZo8Nd4n0OHFqeRCpswZ6j3KA7jRYaSwW3MBA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 6C1CF18002F6; Thu, 16 Oct 2025 20:20:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v9 02/24] accel/system: Introduce hwaccel_enabled() helper
Date: Thu, 16 Oct 2025 22:20:22 +0200
Message-ID: <20251016202044.75261-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016202044.75261-1-mohamed@unpredictable.fr>
References: <20251016202044.75261-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lsNe0lHgjcNVy_cnFFeQXn3h1LeDuTFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE1MSBTYWx0ZWRfX7wplO7uq0zvI
 FQ/06r+hxWefs72wyXV1Ee48WIbeDHOe3JafERcVkVs2nEc681SkErY38W5YB/Eh0mRjT3ecLl3
 Z8rg21+h/XX4LcO8rJ/221xqXv3iPQjAudtwiGB1HPXhLQsL5Eo5Wd568tOlww3jAEJ/82td35o
 YxjWd4XaCDnGs15/pYHeLRvJaRoSA1x4KyCkJzyn3Bi19UJJYqv0G3U66TuOHIPs3c0oLaitSsm
 rDoQa0fJJm0Zmw/7Hm066KJoDrdPjfX5v542FgCVPTRvgD5I+IS3UQ5a9V2658es4/il2RhvQ=
X-Proofpoint-GUID: lsNe0lHgjcNVy_cnFFeQXn3h1LeDuTFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160151
X-JNJ: AAAAAAABMqHCHrhiGcn/ZdyUuy4d4ZoGQOKtR0E2CDrv3ZrPu8A0hu4+NQNWoRTMGRw84Ukel4wyw5uKXtqrhWkNiW1t6ty9kinFAgwCIeuqyGY2x2l909QBb9ip5prwANJdr5gR6xZr4pwdpRZkmbMHdgFDFqDqlLKKQEXkxd/nxi8fiFC47xmb4V0VpE1wUfQFUMM+6krHqtGvaLRupIq2DfANORa/Oda7/fKvzY59eRlS7ySc0LeBDTRWWGejL8EDLCE49R5NNGH+ptQrlugvIgGOn1RQpvxkVC65Cxc6cZJQfjb0OfrpVEugiSmMwLUhOa7xINnXAkKGYU5cn9cK+80Wej3kVtjO+hCUXJka9s/5qVCDfqCDufIHoJLCtl70j0hHgojIhVLug9qqT9EY4G2EgWp8+kz4Qk4M1N0d4U5NHfRE9vD+TgnXPzZSmiitn/72bqmuffZCbgs2oURmhQ7aUv7K2mS9kILi/KkHAGGSVZNM/lEMX59mh0fab/C1o/jhdc605noUG3kycyuSaoQXPsIfOoULNH/6g8hKWQUnrSxT56hW4hbP1F6u0lcDYqQcgLA825h08A+ztjzi0/6t/mOwEV43fSLKzTagvbUABninybBjtj1wE5u0XQlA+P6zEIe8/YEjVLJbrxar3Shxxj4Je6pNoapsZ/HHMYpdvPWRdLA2Onrq
Received-SPF: pass client-ip=57.103.77.15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 55497edc29..628a50e066 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -40,4 +40,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.50.1 (Apple Git-155)


