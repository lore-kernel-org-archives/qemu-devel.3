Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B66E94100
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNE4-000665-FW; Mon, 29 Dec 2025 19:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNDy-00064o-RR
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:30 -0500
Received: from p-east2-cluster5-host10-snip4-4.eps.apple.com ([57.103.79.117]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNDw-0003f9-Jf
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:30 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 2BAF31800467; Tue, 30 Dec 2025 00:04:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=U/0VYWGy0v0801Ea7exkY1qcvLhYs7O7zgKWHhCeBWmD+2+4l1FPSriOHZJmb72hdBs721NHMHvfX56JXKmPOb7OTlZD/yYtNxQah+hY4kDc1yYEudn6Q2bDoBhg4O7NMDRDHeP2T2ASO+zLhzztamAM5n4mZE3nrY8fHi+waghEY3R68SiX6h8jlYVL9HfYFpCQRs+OkyPNm844zSchS0k8syWw2pbrMTUSIYlkVzWLOxulDRc84QC4syKZeMv3aAggWozqVijUxkcXm1PHfGJoj/T5JH21IEiSHCAaQI7b3P5ymQalAokz7kVBCrpTukC0+0q+kz2+M3TgVSRjaw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 A4C6E180044C; Tue, 30 Dec 2025 00:04:18 +0000 (UTC)
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
 Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 01/28] target/arm/kvm: add constants for new PSCI versions
Date: Tue, 30 Dec 2025 01:03:33 +0100
Message-ID: <20251230000401.72124-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX1pegLrn0iQNK
 AKqU/CW6v8+Hm+GZ7+21plNHSkhgerePNubAFnEwrUfKKvMbeGbU+8y4VkNiHteOnWs3DnMINBN
 mjkpm0WNWRTe6a/zlhYl7O/zJMC2Qod+SQIUiuKRgMDN/KQUMZa+yIepvcM1ObDnIl9Y8asZpqr
 kuKkeGDWKgsbMS1xGXFf6wbDAi0jf4Z/nwDOi1k8rdPeT4kexQlrqzqwXf9DKqT6uKjGhPOswWH
 7UB3BC8uZ6oO18XnN/g5XPB9YDPxC0edeC394EwMKTMtDlZKee9LYzo6rUP5dFsLFyCzWK/2quR
 NT0uHFKQd6AE/rCi44v
X-Proofpoint-GUID: _n_W7yLKmlDjOqLxhzQnbsD2fLHVUQBo
X-Proofpoint-ORIG-GUID: _n_W7yLKmlDjOqLxhzQnbsD2fLHVUQBo
X-Authority-Info: v=2.4 cv=afdsXBot c=1 sm=1 tr=0 ts=69531709 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=DAm2dGrMCKCYv6Tpj9cA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxlogscore=934 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1030 spamscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAAB5ur3/7IPGrlS0/s0d4P7sWXGT866xmUKw/43k+NMBw12zkTvEHpXnnpgHMBPLjzttd0gPfUbl3zFoMk5yaKMenmM1Kkk/PKJJ3f+c7Q2WObQXQrnmSyafoVMK8ZCM/0tmpb2Lwtlxs3pNEei9uBhUlujGRLFT0jQ0FW2gxsAwS71C3XH9Xtm3iQYAcLj1J4CQckGp5MqtLrE9pAVstxUQvZzt+aGIK41YQ5mXJe7s2DpEv0kfI0krfaizgw9d1wWn5aT06dhFl3ouhJw2cmvzl/zdpdTNXyy9XgUQAsEix+KMABlHt+LeAfdqJD7pb+2JJdlVchgRKT3sHm9G7BgYXFtebTJQEXlMWdY5s7eiwDWdIRvH8y/ogQ3zUE2kH1/CZDxplatPOPjoSxwnPSN2T/tb8bkEQZlCkPaAbyF7wwZz9UkTAE5sAVjuglwIzFNAo2PxYxiM5nf1UZ+QiYg8wP+6kx4MhdaTawOh2LRlUhTmBAVKQRdWNCu8C+dOMwAeWM1O/i7NRKGwMSY3l6bxf3NZjF2RampkMv1D+pGLEPuVzxgH+XxNJbqgBwNlZZ8YIO7LUPpZTlb0h+pB4FMDgK+BGdcmALa9KcR2/blg2mwItLXhPos+2d9tpYPgv/LjGLA9Qax0Zuvc3RQ2o+OT8ABIFJR4KNtyvnqz/eJERp/8Ui23cAvTGePid54Kx4fWGDKOKsFrE/jYIC1NKx9ENN3KC/lDUJfLfyNgTI9q3VN+hqtIRsqv58ae8LlUb3/iEIW8DdklDDQgBIscerqukCQVRsyuofxu50f4ZHRrDWvtekbszYIO/u2fYkL6ahDr+CQhtqNHC9q3lfUMqd9Rcc5P+DhiDez5OgznzEnlBfaug3YDzC/2BMxFNWavvjc50DjCzu/IWkyCQYMQQYAkPyJJ9tVc1P5ZuSLcY8dtJVd0MJ+U/wEs0l0hh5vWGqtjXcX
Received-SPF: pass client-ip=57.103.79.117;
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.50.1 (Apple Git-155)


