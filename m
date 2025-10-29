Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4A1CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5I-0003Sg-Ux; Wed, 29 Oct 2025 13:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5A-0003O2-J9
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:37 -0400
Received: from p-east2-cluster4-host1-snip4-10.eps.apple.com ([57.103.78.161]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA4x-0003FO-6u
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:35 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 79011180179B; Wed, 29 Oct 2025 17:35:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=aRq3YU5535mG5uSPAFBSlmsbBJkL1R5+IAqIsTf/zZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=A2hSRdwyl/UgrlpqMy9e0ENjN/9vOSCMnpMjmPp9QUDlatQeknhegGxjcEtmD1hU6oVXAGvrNgZd2/PuoIfzJHEF2KaPoRL+pcPyZjkhfRmQr1VuklzAnW2Xof18cdpQ11bFmG0d80abjRCobqykOmoIW6sTpj8eaWpwD8rIG3uZQJf5oT9xy62jzqHM9zkybehvnedrV76YzjZYRwi6q1UgDmvViGVj/OZev4T/t111sULgwXB12H90Ql/iU/3rfFn2x+jhTclz9XtKp9XDVbgaDqKSQMk1h3HlS4YmQATowwGQ+nhoLBEiBJZN2wJWO+wtX1s3bdHABwVhY6RB3Q==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 AE9BE1859E4C; Wed, 29 Oct 2025 16:55:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 02/28] accel/system: Introduce hwaccel_enabled() helper
Date: Wed, 29 Oct 2025 17:54:44 +0100
Message-ID: <20251029165510.45824-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX9Zc91t2wIyIn
 kcLwL9xhkPz3omenZw39rx8nJm65DusyzOT9dRVwz0f8Ub2XQFiYEfCs/qXJIy1r3Rf2fzAPPRS
 66I5a0t+CtrcUdnAn2v3jAF7CU9MUhpW5Kya6Cevw01PXdjk/bBLQMfXiD4ue1EF8DsVaHBjFdT
 lEKOv83CdRZRv2BrffO4J7XohM7Q06mgPsbhMQ6hPjpZ35B1NjAs8pFVd43l5uqnqHBI4OHzbMn
 k2WtofSsmHSUQsxlvLQq1xSnRuI0mjz1gvic2R+wJByQG9JMNpppkWoQl0dCsnaYwSEBpGQio=
X-Proofpoint-GUID: Xl-M6ReIRqEvTt-9Kxm5akcbKx1o3hBc
X-Proofpoint-ORIG-GUID: Xl-M6ReIRqEvTt-9Kxm5akcbKx1o3hBc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=987 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABVOJBTEx9oKbU9OF+tEOYNDibdFl5ejT3VYlKfTY/azh0pHBMuBoy9zJ12r7uSqHVNt4ywWYW1hfYihnntuxw+4nm1Nng2TBEDXldGOH+Haj0BkgkArd16Lj3zJeKbzo2f+zKGK+OdN2DOtccHKPFo6Fgo0fzg+urJHN6qWWE6iodU5iSGowU3RVTnoLsMuuGIphj1Vc/xYeDiuXEg5ae8Qz8oR5QD6vCjgHsalPiO+uKuXov1iTXaA6/2TwbuB+Iz8WOR4VqIS+N3Kg/SMmE0mYnVztHiIjoJaYsexjo1bowT6PnBkEtfYD2NwA6NcCSBOzm3XbnK1rpgtdPh7feGFcEb5xN1Ko7GlZHm6CjeXeb7lTLzQY07nsjszM8pvyUdvFwsxzwbUZi+5KEYzCQ8vtbmT8eysdTOm6+4RgrgEv7h31XcRcfrVv1oUNH2oY3HgXZYmVsD32aNLVwXvgIMd97hIKpP9lvidMysM8iB6i9V5bEGp0iv4ktuihmRnklSY6XLddh3PNdKxG+btxxY5JpqQhovFNYeeM0I01jHODlcSFqHBzBT/nM9CG8mg4jhBuZTn4FkxhxO4eMKuJgsugYcXE9KiGAP/eMEzgqyhHRChlFhKrHTB97nJ2o3U5sQvWGeqyPDj8PZ2yJjP9nY12pb0xY9J8zg6qvWQrGNoy0GnkxOa6+wy96yibFlrk/FWNnKV5vB5wsRJJUu9oF8duwdxi52FQBxbvNB+DuntaCMuETxKixaPgt4keFSymdaJs=
Received-SPF: pass client-ip=57.103.78.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


