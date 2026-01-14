Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F32D37E3A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18R-0007kF-0C; Wed, 14 Jan 2026 08:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18J-0007jZ-Hu
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:01 -0500
Received: from p-east2-cluster5-host2-snip4-5.eps.apple.com ([57.103.79.18]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18G-0005px-3A
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:41:59 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 CADEA180033E; Wed, 14 Jan 2026 13:41:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EsRYpYGP/t0m/rLnATTZbW9wKpoybIRotW00WyIUK+l6hFwGAhbqhKC1Avi8YvxDgqPx03nS7IEk+vb5AHFvzwjlUUa2qN3WV6eo950yEuY9f+q28+iQZ3n6vIPtTTlIOL7r22NbDPE17QJbPIq+mLT5GlKWFSZYnDVxBaHpehhzRh4xtfSrv1ebEgZszDqDHd6d0TtglBHYtP+ALQRQPzH9AFVXS8qYRXL0mY8N6kspmi3qSwZXvaYxjAlBoNppQ5baI70IvAdGS9/2S3XIiSKRt62NhdW5SGMie6NIOraRKWo7mmOj8nzhzWCCCQJXIyho7X9deLGNiupP9dT61A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 73F66180015F; Wed, 14 Jan 2026 13:41:50 +0000 (UTC)
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
 Cameron Esfahani <dirty@apple.com>, Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 01/26] target/arm/kvm: add constants for new PSCI versions
Date: Wed, 14 Jan 2026 14:41:18 +0100
Message-ID: <20260114134143.26198-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=GM8F0+NK c=1 sm=1 tr=0 ts=69679d22
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=DAm2dGrMCKCYv6Tpj9cA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX4v/uzu4JCdx5
 Na/mTMDdBFLcoUg9FWejEYQcKZ7dVt95QCx+a5dv2239I3YZnzXgkd3+g2j0DhHZqzuG0i+gN/D
 v9tLVwqK1pBdnwl04m7h2TPPjdCISbjGz9Z4aCJ0bLN30iH6589l/MAVMnlGGrLwPI9LVxmWi+R
 xRhhexCjnWc4Vdm1UbQ/75QPCIIDUYE3Z6oK8x1j6D1l29aVx7n1RObuJmLBrpJQip2A/DeI6PI
 5FQUqMXp73tRtBuEgtwZK+ojIt0ecZvd5MrYFMaz9m6FU4VBlqIrXvtZpn8cnPKhfuAokeCZoSG
 WPWwRnfAnXJJDn/A9IK
X-Proofpoint-GUID: 31TOOjUwacCEpyc4E23NqzcZokk7VUBy
X-Proofpoint-ORIG-GUID: 31TOOjUwacCEpyc4E23NqzcZokk7VUBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1030
 mlxscore=0 suspectscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABm9zPgXNFfcJkDuUSvnWaOpK0tAUQy5mUsCvrRugSIdK0jliGJTy8FuJ9Ifbb2L4sLBxBi38qpAe8P9bBDToMnlf53Mwu09LRxZMRe1+hKtfBtXabYF8zMh7G7ple8MQiZQRnYcljjJUpAW+POm2VfQ9nGlNKO/ccK4+BL1g55Qx/VA9ZQ42tmPXtvfJq2FoqcFp+FZzmR1Hgrly8reX2Y0ndaGYosBWH8HhI7NwcU7w1wb3aOYmTQe5JAqKShHbTYtz58frGGSaS3+FB9VvN7ATHEA5fq5swKEak7AotJAP6BHq2irZHjOjF819fsIOhRtFWuJq4r5PduTq4LvcHfAva+sQuuG98mc7GZWq+6YGlFRIkFI1kXpNnAH6Uf7AyHPSorK2n/TI1ITSyngmz6G6VFl596eQi2WVFT3slqyZgQdSvbVFMjESRaO+saetjqFW9T/AwWG/6/YiqRxpqWMJVFFm7V3s/zSFqse1xU+zAN3Pc1remlYXyIHAgQbs+Z1V1EcA0c5A+h69hZxv+mc1eT3N/CyxBtFpByPKwuffBE23h2YGGjGK71PwGkf67of/NE3RX97MhRzDkEvOBF77DaQ6tvjnUfAwxP5MYD64xV3KGTxUZ9BYPQDuxJTiuD0DRmF6oBecb5z9oEx03dA3usnt+yGTb90yz+A2NozlexkI07GXK4LqTdklwLYbaM7wUdmLi6UqCkZ6MM3b8Qw2Ox/5lgKy3wf49F8OXJEGWv/JPwRQPdnirLS86PB3MZ6JCYI93ihnWhHARZBYQXdQAEuNd/HUy7Zmwcf2f6jFVAW6QwIEJGye2PmSAXXQJM0za90wIE3soHz61ZwjIGBSpgnGSdxHCIBJyiMxpO3hwWgkN7u3f8LcAMiKsVLZO+ZA7/Nuj4gLvdb1R+eOtC6Tr8nEX68Ixmc8=
Received-SPF: pass client-ip=57.103.79.18;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


