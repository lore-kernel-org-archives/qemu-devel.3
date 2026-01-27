Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A840D2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknp1-00031r-El; Tue, 27 Jan 2026 13:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknnf-0001Q7-TQ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:29 -0500
Received: from p-west2-cluster5-host12-snip4-4.eps.apple.com ([57.103.71.17]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknnd-0003PD-Dk
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:27 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 7C82118000A0; Tue, 27 Jan 2026 18:28:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538504; x=1772130504;
 bh=rqevPYI5PNmYfO37aWp6zQDTk/Z3PG7nW7DuJwvRyUM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=HqKrL98rMh83K0fkJGFhcSoXQgOdGl4GiCOv65gQHwO3u4SytyE6hvS8EphVkPfb/9zeHp7WiI1YSQv+MY08FQPTapbJVJv40MToCZG/MyP3wXGU4WG8RWF5i+1KI5sq65nW6Nlb3xAW/ZiKphwhyshllN1G/Ys4SGSlIjbNqkBU/e1aHcnr0SPaERavYx77qSiY6iCvTi9GViabiYpfO8xLtnKChgG3++8sfYa0Z9nqvBSleqHqvop3FE7vxUrHYw00zjx4slNGMRh3jbAJYjZNZjaMfr38jNGzPFKsQ/zNY3KQpwXN6IOFehIgvWM0FN8UOwiwJx/W01xIVcbBvg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 E2E561800104; Tue, 27 Jan 2026 18:28:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 02/22] accel/system: Introduce hwaccel_enabled() helper
Date: Tue, 27 Jan 2026 19:27:42 +0100
Message-ID: <20260127182805.73212-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX24A50B1zyrNR
 OMK0+ECQnD8m0cZIoII7ubD/gI0SAzOmrV5QX8pa0HrwINeFyaHBQhOGoiajqX/+5omewxRwGVb
 sjcRVmsjLVURtOfZsB2XU5daiee/7MZNU3b+DP3fHqLNc56RIt2xgnBf9kD/qsa4DZYoyotBjRO
 5FzxmSSuI3kRazjaTSt30uXqaHtR6giFcTexlumERjEoB6qgWR14KV35/+XWuiiirukA79uXQlE
 5EBdug5ZIAf8Jq68lpP0uHn2iWGAYrlo1xb916TNfysVs1nXchOaYfocMjx56fIGg+sUg4hxwXn
 EbAPr1FPMK/Hzj6w/chvrl+UJbj5+D73xJ8Xj1hUDLVGbvMFij6Ste8d/y8U7U=
X-Proofpoint-ORIG-GUID: jlc5NKOWNwEFtfrhCD0ZzAd49ShdE8MN
X-Proofpoint-GUID: jlc5NKOWNwEFtfrhCD0ZzAd49ShdE8MN
X-Authority-Info-Out: v=2.4 cv=FPAWBuos c=1 sm=1 tr=0 ts=697903c7
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAABpZ0dHkUgFxuAjnrz1TRRNKNJbVDYmK06wKHRM/+M3OeB09PrvfTQIHF2YO+0ygZm2PP3VY8PUDsF1ivQacyFMNbKvmxFeedpqob2a5SgUQqR2yY2GjSMCQJH70rhHeLMsyHug5ybWPpRaXlQtA8Ecc33XtIPJ8L1K2UhKOdDvoPnGAJkZKoQba+QzsEHEa7ga0H2eU+mWW00tq3328KPq71gtLKSsYmq0jttsG6arXYrrTlhrglVv6aXnkDgIGFjtKFjkE/oLjn24BBq1nSJcFY0L9F7xNR8bYAofroHO8QfcA++UbgERDHbWB2tgD206iI9aH06DuoYTJ8xkIokjx2LQgTPGBd2/qcDLFSzSH8IhiW9Yjlk9ZXpFpMVEIbgg0N8/exJVsqChwlInWGGKnWb9B92yWu13k2ICL6IirMjahdYOAQcRXq1uscwcAKMzDFYK63kxxsQnQ5TvuuzbE2tbbeBF5/ILrwD6MPNmazB05dxkSoaMaANEXpoNkk+rxRNEs+87AEmT8+OfhMjmKn3L+YV1vyefEGgQDZiuxD3JfSUPpUNRhJlvnc7tD3BrX6VtDl7b2CNcqxTnfllSBkXjKnSHM1I6JxhOjHNRsxzzI4GBCr7Ctg3UfVMnKoIzfQPQ3oc+/KYGh8UMavGbRQWaPtuym7WC67UcAMOUTRexSjnOX/VizntstpyLdM2uOddvrJyxUdJwwAPB3BTmPj7lXPobVJ6SSvqbpeGYZirbHVOkMBnSxVKRZXZa09FlGEq7r3t3yAOPT6qKx1u21HZuV2WNnxbfzaKaLtcDBqm/m5Lv+GFS6NyjBqcqC6UzQuHwdbOhFhVfnemlBUB3czM8Lu0civLBS66109+cWa1hwgaxCuhKJ5A6yQL+oGzNLT+eFRg5dD/xsDtU6VemKIbz5znmQDasmZEEI8gWYSRpvPTz/tAnRAUiMKVycPkjw==
Received-SPF: pass client-ip=57.103.71.17;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


