Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8931FC44532
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYSg-0004MN-DW; Wed, 21 Jan 2026 08:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSe-0004K7-NI
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:28 -0500
Received: from p-east3-cluster5-host12-snip4-10.eps.apple.com ([57.103.86.251]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSd-0001A6-2f
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:28 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 58834180019F; Wed, 21 Jan 2026 13:41:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002886; x=1771594886;
 bh=SWoKAzpGYO4A5Cj1tO6xJq2URNGyAg2S13AomBdIRUg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=U0u1gHXFakE1rGsWNQ09Q3rumB/AM6y9mH3Xcmv6QFhHLFwXk6BZWb9bZv67gO/SP1WI2a9X5bHYjgkLUp5EX0EKoBY5VAbaUNUriDv89c+3/oy3LVPN3zBa8p+6FgAgvtFLc7w0F92q57vbqN+oIGPNNI7AfN1QGcFLU5ybCk7Xlit6XW2m8Dwrem+Q1n3FZrSRdh/pdX8zl5cUPC/srsQUIgr0zxO++HdeUgKhKT9vMT89JeWQOPKwAsM27hI7uH9choQtZZDvvnuTFrExHn+qNo2I4kdruaLZOysSYVWIiXoLXuZ8ifsaqUc4QBiVqjp/SvjgnMvUokNFX2h3JA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 077FA1800168; Wed, 21 Jan 2026 13:41:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v17 01/21] target/arm/kvm: add constants for new PSCI versions
Date: Wed, 21 Jan 2026 14:40:52 +0100
Message-ID: <20260121134114.9781-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nYrytPTm7KeOedZzJxO_UkHD4ZvUkwNH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX3htBDv5RbAz1
 2zXy+80ETCqrTAsWQ+1I/p5eTxfFWuL0xSyAp4S8/vVE4ZHHo79xRT8jsDlq/+5iIJR6IWmkLuC
 t807kMWcg6BCvkQz5ntURJanB+3pTHb5iP7SY8UQ2X692s874b+3g2E0WUg5BqjaXxqmBhcSJSB
 NNyGtRer4ls9/arQCtHLKp8ZXuR4lMEAYu3Jk+shJpwvg5loBaDy/YwP6GZizBU2KcdeZJzlEJI
 LQKaRiVYRLMPhe2HgMeSW9pc9N4jNdCkI/Bo2JecFtYntURzBdHrrbqwiAdzjBMEhQ1VVW6iH/I
 gviP0Zg14OBjcolu5GL
X-Authority-Info-Out: v=2.4 cv=EpXfbCcA c=1 sm=1 tr=0 ts=6970d785
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=xyHcjBD2kxMnvwf2DskA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nYrytPTm7KeOedZzJxO_UkHD4ZvUkwNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0
 clxscore=1030 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABd8TBF5C3yrdDckenC7u02b+qzPml7bE1GBZnPOJ5e5bHsz3ncCUmNgXcDd5bb+sJl7YIfGFzSJ5wAGeKWX5gV0SscqPympVRofsofH4Ej3yT2cQXiR4POmrRSYXrpOwK1g1YKStfyxMMb4pIO1y93dp1QH6WKirCddKGX4FZY7HCKSKoY3hqJ+OZbLQyNZ1fe1KTnYj0TMQ0F22kkIpp/59Vxl70/uOK1N/XEFe79vV+0VfcUGx4J9ifJ4yEF3U3Ou6ZEKJfjY017egalWTGjGDkwQS5zewRlJ5E6uxywemXbbRPHxh2RQsGhl/k7bzR+/4seWJEt1Cr7brIGY2PN24oD9IsFkorhGDPu8wghApmG+WeZ+LB6D5DEgaok3RVHr//F7EqeVI5znQOhqtezF1R8JDuty5r79sK4TRNYBb6l775i9LtfcFl1FcdyerJMjjkR4w0DtdfF39fPKKbnxiKZsyQm0rLYMYQrHj29PES68/GJfe1jXdeIeDZaqPKVTQ+oR0lxpgJJD8Y2y6s8UK1NLOZpp6Sy+uBSY797YD3tUOugCUcKO0UPMZ6UhSUs0UuEg34DNueCTBYoxiyD3o5/db2Ohn1qcJ67oQJKrsjTTbjGqK4wpSLfwXX8sXrrvnkPKHrcSS/QYLGRPoxndqql08IK0twuRx/DMlW1RlQbALKojyKGSndBR9Yw44qPFuVoufhxkqc45i4V+BgxnT+WEQdKxK+wpJZRdkU1DTafnTgwskNnepSYwAH70JPt2u3jjn8g+d2Oebout9IIxGkhB7jHEwUIPJwqve60ZjyYY4rh8C1uBs1sjAuJkfKj8jHfLZSWiW73pzQHQ8e0plcdjgEyTderGs10IiARjyYQeXn6Q8F8Lnr9SfzeBRHNhhvVJYfhnYzlw==
Received-SPF: pass client-ip=57.103.86.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


