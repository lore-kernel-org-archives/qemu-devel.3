Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3C4D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18T-0007lb-45; Wed, 14 Jan 2026 08:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18N-0007kN-W7
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:06 -0500
Received: from p-east2-cluster5-host2-snip4-10.eps.apple.com ([57.103.79.23]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18M-00065p-FR
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:03 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 D317E1800176; Wed, 14 Jan 2026 13:41:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ksqwamjc+5RKV9piY5vkALtcG0RUP+bOT4m8O729l+Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=cRg8K7dkwkk/OYWV7omYuM+ur+mvkscjYVc0rB71ffACkcnwM7cVvYga5oBssuRZsZIq11YPI1awdMz/1q3WNrWQ7+6CVTih3ch+d4uM7UtGpktHWyu4r6jBAKfBspFDm22t4d2ooO46B+E2kBHlu33jff4dTCwxxu07mryOOtlLBWigpQOTLRc2ibAavtAyF4z2mt4M4pO3h2bgvM/Sv2502yWF68J1nlW/xrW4q+Q6FLWZbFFGAlVP7vIjZueeMo6ssJLHyDl/Uyp8335AAkANCheV7PkMBbWuiI8urzd6cINm9BJjaY8s3BfnbrJEtkjzAGP1Q673wfeHvZ1cIw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 DE6EB1800482; Wed, 14 Jan 2026 13:41:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 02/26] accel/system: Introduce hwaccel_enabled() helper
Date: Wed, 14 Jan 2026 14:41:19 +0100
Message-ID: <20260114134143.26198-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=HdAZjyE8 c=1 sm=1 tr=0 ts=69679d27
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rwZv0HuuZQKdxPWHYRnHK2OoliuL43vu
X-Proofpoint-GUID: rwZv0HuuZQKdxPWHYRnHK2OoliuL43vu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX6yjLWRYZITPx
 7rGZYJHfBPzjISxWtxf59Av7YfyQOCkijOica1RxrWsDPk4PVdlRBBcOKH+9cHRKJv7taIlKvfH
 a6BOr2BB0qSjxPOpR6DKxVzVVb95awo7b7ExeHRvA9Xye+T6KImZ64zkUmKOwRv4aqZJzoGnlJt
 k9kXgbRYrZo0iZUAVCCtXfnNeXJzTpBTti+HeFmK3m+Jb9VpF1aIrlVUGlbGFpve2traHynhg0c
 B0Ln6dTslkaZFJWgCTcy1pSo86D0N9Ud5d4atHeJeDI1pmwkmfH7AL8mjPFdZkz/3SNZK+mCcCk
 HkGjmfQ3culyIQ5LgtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0
 clxscore=1030 mlxscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAAB9fabTtff1J1ZZVPeua9OjrzUJs+7fRALZzEV1jNTvVedJuSymxJV5Kc23Z7ysdWjhrvf3ffa/0d2pT82dunhwuhkFDZ9Rb2VaS12q1ePOIIfNzRzV7twl9TDZO7YdMNiMwJES7ZDVaR1fVEZlDFiHKeo7mkoJ6yoZYmB64tzCmubZC/+sFi83/Weyia0QdfRQKDiio2M8lQ22Gjsvcp8im5RwzSY9DEwvB4GVAtqxFFUDwmNtGYBfu30rYemmkHEGz3OtBqtzuDGkN7ZwI4XktHyijQqj9CRyU07bvcRDJMOjm8GyIrBZeHBtjSic0KrSOGpCIs6kI3+jYsFdVNA4TnzjWRS/8bRsLR0kjzxa66WIdOHu8YJt3LojixV12UXdWAhIl8KSpO/iDSWEExt4JGS3KYj505i8JUKvjsf5QRT/77fERIoesBJ3EaOpCzNrSNjUJfNL48qLxQ8l7Okg6EamtuDzTZXfNm5lWVEsjHNBKBtvdLNrTisiyvgguhU7xHlZdfk64kPpECbOXOuWPBoODzvSCAGE9CGo9/v6EzPb8Ant82KJBjel2N4OXrli6CURwCPmRISluxmjpqgWfIrte8gMxK760+g6BV4f+KFozgmZi4X/kP9B45cevJiUhmfBkqVkAstOmDUffA1IEWuHmavdXxgc/PpR8D2ASU4xaEqI8HywBlwap/y/nHBvFBYKCPKquHe6nxjuc0KfC4NCvwFdogfTvRuU9ZqkgfAQKi9T4IIqkCzf3T/fdaAACXqbitCrmSfsmFExoBhB0ucyPh+JMUwuqpqwO1tldT5MUNnd2Ac0fMt7aU20LprFQK7PZu/JRMZ2rbXeqnWTUMhQ6xn6SrbcGh8mVbrwqJhfbFZzaUfy1Y3kRazfhMQqkS5ewKG4c/s9XYyRH5rNrHG94XcWbk+nFLvJP0Dzz0DZ/Q=
Received-SPF: pass client-ip=57.103.79.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


