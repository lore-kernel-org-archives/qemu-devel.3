Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5A6C2A07F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkFw-0002up-SS; Fri, 16 Jan 2026 08:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFu-0002tY-AU
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:50 -0500
Received: from ci-2003b-snip4-4.eps.apple.com ([57.103.91.145]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFs-00024i-UZ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:50 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 75F4D18007F0; Fri, 16 Jan 2026 13:52:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ksqwamjc+5RKV9piY5vkALtcG0RUP+bOT4m8O729l+Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=GTh9gostxkOef5jssb2a8xOxa7O2jATrtTpgU/gUEX1/8n0CAcaOz9AqmmOS9qfNYKzoAO9t5WkQQ3HGrGPcXYLORWXXeDkCHhdzlhAD3oLT1tGJCLbwwwHe7hQ2DRqUGyPBWcsovlQRbo4qGN9y1uUPsptDWhyQxJ9sFFraV6tYKoB0nNDXdieCxq4m4PbdG/2PKGLJw5Hyi1nO7FzNeKeOUrvy/MA5Hio7JMrr8IhyKuLaMBua4H7203a2gwt86kGnq9qrWq9TOmlsRvwV2/DDPkDlSpb24H7mXNViJYjgndM3XBp1Rv1qnYRSP28rdNL6MBSdR1QSAgzEu1bHQQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 2E638180F919; Fri, 16 Jan 2026 13:52:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 02/26] accel/system: Introduce hwaccel_enabled() helper
Date: Fri, 16 Jan 2026 14:52:11 +0100
Message-ID: <20260116135235.38092-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=CcEFJbrl c=1 sm=1 tr=0 ts=696a42ae
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Y0smF5NtWqI19Mecxy6e5KsISPuGYowK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX4bQRisPaBtpK
 QYRWNP7t/gK/0j7b1e3NpGXYGwmtpOIK+NFaPa7hXHo2IdFJNTmQFTp7q21xwkTK86Y9iUT6TV5
 yvTHNJPUrxMZjsueGi3ECRJR5rzSnZ2LKrazhBJzrG+nr7PN5AbFK6Xok9eSmQ/fKecKIo2h82T
 t0PK5XmGuEqDkuHi82i3RAeeonHUr23yO01JsHr5Br+WsjA0R9trvSGYpaTsPoogJMkWqwVwKyX
 oO7ruQZd7ypRZiRVkkIj8G+NRX3r+cHyV+wfcwPFk8PvfRXyGv3ZR2d8uqTYQsl1jFaq2r1q/07
 /IrkVwvfE+jDyn0vIli
X-Proofpoint-ORIG-GUID: Y0smF5NtWqI19Mecxy6e5KsISPuGYowK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1030 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601160097
X-JNJ: AAAAAAABfHICVNlQpcT7s/hw5PxnLPNJDi9NhRYhcrKW1bKDDm1w3zWswKmRsJFq9bSDlhNR//QU30VHTFh/mw4tMcfahzw4/TK1mAseXD/VZaJInn84cmus1/my0y+YaM+JeE9ULnTxkqSGQa+237a7a/7m1G/xQFQbiWJxC9jgE0G4VwVzGctpx6A+bm6N99y+kWoQNdSLm+ug3P4iUyeyw3p2XYCBVMyK5I944k6OM+Fk0QVwzfk+1ZrQwiuOA+DsmHyNuLwMSdokGxAIe/QAsoR+Hgwwc84YyvwApCR3TvCCvAqdYdIfI2WezFqA/PRKEWOXsuwivKhcBg73AyCkqErApq6R79P8U5n795TxUvUZFgyagcel4b7QVkiWh5J4I0rzazENhrl/m9nRmt8GXS4/z3ue7EDkeIrBZdaCQA5vrY1jVjk4iTagX8KDx5908SbmF4xbT7lL5KXVmmTYO5+066J2j5CP1+KMD4kmziFF8tX9txNlazJmU16cYQShf0TN7N0SfSIHYBkVm0Mww8YMbBMRC51ufczT3VrgjVhAm6CwllcVaIWLlAjfUpyl5Sk2tVLjskesVZ5bnWgY25vqQisbqBAq/LK4lsUTe5naMx8hNc0PCv21425w0M1l+3/7+xEgavo5Ax/7Dp8v9/8VYs352Xel96udHUPckPmWOY4d8veo99NtzXA+3PFWEn0YO/DzdP1n+L4gIMYkb2Yvia0HBcQgXfdpr6KAUjVOauZfrW9FxQgTnwaBJ+wErgWhBV4Gy10Y1VxePyX+WAFZMKJITAzJsg8zLooawNuf+KazjB8p2tiRVPfwD4K4RQ==
Received-SPF: pass client-ip=57.103.91.145;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


