Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F420ED3CC8B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB1P-0005xY-3t; Wed, 14 Jan 2026 19:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1O-0005x8-46
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:30 -0500
Received: from p-west3-cluster4-host3-snip4-10.eps.apple.com ([57.103.74.161]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1M-0001oU-Lr
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:29 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 31B7818000E8; Thu, 15 Jan 2026 00:15:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=I61uW1Nm2QuzauSvKY214qwLyGuL22ZUatnUrBCFRDoinpg05YPDfib4Cl5XlOKCyQhlsLFdLlWH+B/CS51Oyk47Ta+5UXX1hntX2okMgznx1lZoHc8uXlO/tiBQN82CsR0eKdX7qNeI694bDdfzOa9E0ufg3lV7MfB0oNGHMMjA9uf1SX2fsp51hXKHTiMRp18CcO5yaVbgBTuIkTkDCrij112MPSTNvkEC9juGaXLQLfEWP3/HR8rSaU+cbaZvATqAi4GO0vVTY7b7qAELrJKaU2/fi6Yi1nxqM4Vu355168sT7rFpRTXhbEqw1wCm4rYTRJLWaHxdpCM7bUmLtg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 504CD180042D; Thu, 15 Jan 2026 00:15:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 01/26] target/arm/kvm: add constants for new PSCI versions
Date: Thu, 15 Jan 2026 01:14:40 +0100
Message-ID: <20260115001505.57237-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4iZAi-0Bzmj7suMPTLlg_VLQCCdr-urK
X-Proofpoint-ORIG-GUID: 4iZAi-0Bzmj7suMPTLlg_VLQCCdr-urK
X-Authority-Info: v=2.4 cv=N4wk1m9B c=1 sm=1 tr=0 ts=6968319e
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=DAm2dGrMCKCYv6Tpj9cA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX+OeMywoMADm/
 TMT3e5Cea4Fyao7PuTBAlkuQQXKuj8nKbQH2VsK8FTkDlscHJFXV/+yt2EjCmb32HICDTksS/Xe
 i6o25tNjNGFt1vwPPdS71W4Aw8lQNcEj/Dae/rPyB4WjdGikr2rifCOyrhgACQM4HCjhRXNZxcu
 D9mkbwJBkh6EfmKv079gu509LkVUzXLWHkzREpjFZtI0esQz1bHT4uDm0PW88vqw3REblcbuEW3
 D7diRSru/8VtTFv3IY6VICqUCdWhYxRwDfGTogK9skkyzbfQ3Zhskzmm7gFdzcvi5dHvCpwQvib
 JR5Nf2j/Tyt3Vqqp523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1030 adultscore=0 suspectscore=0 mlxlogscore=934
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABi3egtGi9ijrMiKQjNYbO59Djg4BRJ7wVr36qyArGMFiK/vT1iMuwa61K0um0ALcns3Orshn/UHAw8A0it7KmkfpC6MN89aTCDwHjLO7j2vJrj01OqASHTJUyNT96lLSpwFEeUp0d+iLP7xi1DBP8xrcZxDo1kr5ta3BdRz8cen2XgD8AjiWZFNZFzsvBMo9TVIHnDdlV9mYrwqpW666xWFwDLYnyrT/9YfnNKKNRyEbiHHfGh0Y1qty7BaNXK3U0qDmh++jYraTXZbkkNTTwlyZWhXb99uIddaAAe/duTsbBPanRBJnsXnGj4s3rf4K1RCwxkAX6s8RtTu6ehFqQnySmVsX7p+Sums3Llhgj5oQhR/6j+XcQS1urvJCfAwcbNzDorKGvDohB2g3KtJ7N86RV3CNSdrlHVodSbygSxxc57kN5LKqbqJ0CWCasOXw1lyTvRZzQ2B99a4YXjqT0Kh7f8l1hSDtyxAUo3WT0XSkrG0/sVcixopU4M0idufuaCwdDlMCrnXGbehZQW6sgXTRA92AGaHWJoCyG/d9bcWiwwWEeeJcKBMzCKotX7MzaRVThpHnXNCN8qs5z44qYbDrApoMyXWUhZF7FQoo34sNgjoKs2fTxs15qKf1ufyiu5UeR8NLKcAA5xRf6+wv7c+MS+H4gKklq8/dlJznWPaVAzhygoDkGMaWTWSZ0QMEntkVMJe6MHjm+PsJTzOo0l1wz3yfwYk6dlC+dU2lNeUb/2FC8yG086cUWB5GiT2b18R1UvMhUhRAwVs8xni14CT3gHfrd+OClIDEj3crl82XnghLDk17S8px9Bxps5SDYlNVvWFzWljAdAC+xu9kA8JuiA2yotU7RkVZxsSI2KyE+13VTb1EtuHZvI2mrzKr9/ZABFZ2vaID4NsDWBmTtFrEJpMo//11lYnaTeP6C6ZkWaupHY4ZaevJtcyaugujCOULE
Received-SPF: pass client-ip=57.103.74.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


