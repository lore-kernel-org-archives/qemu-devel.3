Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1D1E94100
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNE6-00067I-Iz; Mon, 29 Dec 2025 19:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNDy-00064q-W1
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:32 -0500
Received: from p-east2-cluster6-host2-snip4-5.eps.apple.com ([57.103.76.186]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNDw-0003fD-Sn
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:30 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 088FC1800104; Tue, 30 Dec 2025 00:04:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ksqwamjc+5RKV9piY5vkALtcG0RUP+bOT4m8O729l+Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=IeTO4EAJaskILkwmrPSG4kX3kFNjuTZS6XDIvNLHlgtk5FRobL/9yOj/4sD6pxOI/qJRZ3IXcgsLie3ceXAFwsoFMFeFkC9ngkQRXkXWlLkOIXgIrEqTNanEpfHdQU/Boxc2pKB+ShdMEH2b3d8m529qiN2XB/2b5qMBIrXaQFrjTGMhl79QE45pz9kxibdDurMCtO5B2uxzYvXN0Nk62xHFYFYC33AtNwbF6B/erHeQWFaV1ut7nt05EukTr2N+jJqGEgqmR+hTVqFdlQZ5zyrRysbmgxamo5NqJD7mfsg5t+TYuAqRhkTJOim5MFMTxgL/lbY6MOewnPPDTt8aMw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 D1AFE180044B; Tue, 30 Dec 2025 00:04:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 02/28] accel/system: Introduce hwaccel_enabled() helper
Date: Tue, 30 Dec 2025 01:03:34 +0100
Message-ID: <20251230000401.72124-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX8A3e5VI9gTYk
 4iWLrn3Na7gZVtKmmnTAq4Km02QX7BtZ9VC9BWMiIJNj23WZz7bnDVnbt4nAhyVUFS1ROWz9DNH
 85LmP3LrwJU4qiRCE6Lv3hOKSylDb6zc7m4y6E9JEq7lA0y5PQ0sP1wsiOYp/iNvfoLURt5/8iX
 RtAEwZQGyLcAEMGnGaNZg5PCae0kmTo+h+DtNeZkqs69NpxRETrbo0XYJr6v83FI00jVIEVpQMv
 0bTwCbWEImGuwyxiI/NgzGHNZVindlvUPT7sWUpGUPfo7A23//zXzdvRTKvPzy8kSQw2VJ8RlHr
 OZi0E6uGVJr2COfVCaG
X-Proofpoint-GUID: GYHqfl_KwuqUF2XqLQwV6LElwrRIXSEF
X-Authority-Info: v=2.4 cv=GMoF0+NK c=1 sm=1 tr=0 ts=6953170b cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GYHqfl_KwuqUF2XqLQwV6LElwrRIXSEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1030 phishscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABIm49ooLjVKuAwB2QOZgn3wUJ/U7uK1cBjRqN+lXbVs1L1KCMcM8/mIstllxM6cqkHbkAXR3sWjTpYHozwhscDyIyGDYSOHJyou/tgB7bqCrL0LyAbjWs6ZpADNcHFD1WX8opTu7i90e52rpqrxf4WJG8o4iPJHWoScbluF04DUgv4ZyR+EYJcLjyXvf31bInHlrM/JXGqmKCvt+gMELVppE55a2LShwJp3qBdrSdqQfg3OWhA3l+dLFaHgS8GqulvzmDeTZGVJrYuzpyVbEt94tpG3z6TuPhIz/+0WbYHJyFbC0E2FRwZokbQmi+J2XuamC4KnKcVCW7zAlE8EGsk1gC5dAbgli+JksuwQtzhElmCcLrnjp3HyPAHCLC/65ernGY2TliUBbiDt2v+/miEjmhyj/5fE2msoDCvGNxD5kzob8E19xDRHdqGCAjt4Y+yVSfFLvpc5leCWooHsq/ITGafnnTzlyJjT4U0ft60a/+CVP2dang8fXbiB577pUU65z4QZ0t3NKJBCcjsofOx3Y+ePm64M0O92AJqnQObPTrkpyOJXIGLcik044cyA3E3mO0gmAb7nReOQgQJks4orhS5g15bv2S3fnj18sk5MiAMneEhxihn9HnKk9P3l8Pg16J3LHGvkcPPqLF6kbxdySYBDC8Jt58AuU0v3JksrywTFDH9Y3yqHUsMKoa30QUMke6x2El0fsa/LXyzd9cOg6cY1ZsBr5ifKzEckYJDcd36h4hu+TQrHaXX1G9Ne0IzEfiEqYFmcYvle19zGEkCLvY1WhbOsc6VPf3Hod0MbWOQgnRCLIoxJoe9moW9U9x7VVKMKAfDr0Br8NxiXS7rQz2+53AMkP2yHVAEodH+AbmcLJT9YwMOO2y2V/PmMklUkigz+JoobulOvuVaSh3j47t1HWxdjgIOqFVxK0EKxrSy7kS7csQXK7+R31WfSmJCMcn/MAcijPO8T0=
Received-SPF: pass client-ip=57.103.76.186;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


