Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2A5D2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknov-0002OF-OD; Tue, 27 Jan 2026 13:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknnc-0001P3-7u
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:26 -0500
Received: from p-west2-cluster2-host8-snip4-6.eps.apple.com ([57.103.68.137]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknna-0003O3-1H
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:23 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 EB38F180010B; Tue, 27 Jan 2026 18:28:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538499; x=1772130499;
 bh=SWoKAzpGYO4A5Cj1tO6xJq2URNGyAg2S13AomBdIRUg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=aGjpD2QTSTUp8UFwIGqwm2xBGpxCskWc2fkdeYG+NW96LsHOKx9edzEF072Nd+Q4rGk6Nqpk763d+MCpWASDECXlaIXpER1P7hnUuNchDtBhjtOb3hl9zO7fOXwvzAi5EdbqAevvFSOzfjQYOTdM3VDW0mojl0+l7zgWCtBbQe/6yPxnOSUscP4UtYRL68eITcTNxk+0iZJ5BrBSuOLXzEtA6gsDgetmffyzf1w7J9x4hd/cozguJDcXGzB1ILrXw+7PM2nLrqQ2gp1CfxFoU2lGBDxOd5z8idQGkafKZYDC4i7tItsxF0WQN7iat7IWK2y0pNiHhXigxEf/cxDPLA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 264A11800126; Tue, 27 Jan 2026 18:28:12 +0000 (UTC)
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
 Phil Dennis-Jordan <phil@philjordan.eu>, Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 01/22] target/arm/kvm: add constants for new PSCI versions
Date: Tue, 27 Jan 2026 19:27:41 +0100
Message-ID: <20260127182805.73212-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX1Xd/wtBk79mG
 A5V9No8VON2RC6XnVLnMI0hoo6hPckfB2OAdgW4KguJJCTurA46zzYVzneljjr1PM16nTpvscmg
 zVjhhIOZCY4XzSXGP2HsExDep0Lga8S7oolIOQ6bKSRJHNn2GhnhPUZgaK+xP/Y9n/JcXda2Z7u
 XvDNaKsbvMFDIeS3TSdh24uPX9dG+FeMbD7XUfVVI3bUSteIO8gFbdtcbiYKHtr1pV+XgiOBW+k
 z+uz217wbVa4oaS2o5FTzCASoHAAWVGHYyka7GosFLX7SBq0q31kvNwEO6+YdO2qReh2c+A3aH9
 CjsNEIiylIymmF8Zl3FZ+2DMa5vJA+7jmLJ3v0uu6TJcmmKMv9RPMsudrajMnc=
X-Authority-Info-Out: v=2.4 cv=G6sR0tk5 c=1 sm=1 tr=0 ts=697903c3
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=xyHcjBD2kxMnvwf2DskA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: viGJ8bdwXqAytzZWnAkUcJmu0e10HfS2
X-Proofpoint-GUID: viGJ8bdwXqAytzZWnAkUcJmu0e10HfS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1030 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAABrufv8wHFjZfanQbrRsq+F7g/VhHflfTNL4KDp9o1nwvmxAi1ofnIgt99X60lfXT5pPHOD9tQGVo683tBM2NAru3EAmDTPexpAAawHzAhZIhnGDu2iZePkt0uJI/9pTgHns5xt9UvAVrFMTFbG5IXoR24VaEPPb3h8znkq6+qAFz2qoaoUcwvOjSiAbr4TIWZMTAbQAs5TLb6jffEl9VEIthDEvAKAgTh21vTdMQmWfJ+2e5QQ2wF/M2q9H1g/tC3OXkwR4rZe/y5/YTWJfv3PgB20gpvLZTiQYNqUUmCEtcxY/dHZk020WrjmFhRLdJegw/HYEEcjTefgAxdnqW5stL6aHF1BhtaDb2E5LyUOz+uxR+4+6FlvdyR+s2vMhwyb2i7gEDXbCBp05y9YdFEVU9FO26trt35rughySVogoPb7cI5czqOvX4tGMpCYP739CmYOFfQ2bXbQIpM4gzt3sxjbJu8VmSHfhBMIx8LqYWsHPo9Cv6AZv9sp4uQyzL4KcpAG6XWuBvX5o9sqRYHiNj+MwQNmZG/jXLZ9Oe3stsNVC1NRvnsTrKrLNOC3i7g2uNbVXuW8vAGSbuMWvMamBCk069wChkYxWZwjxPDWiO2ZVs3sm02T0C4hxnboZp8knv2HaG9m2O3n2Q71SPmod3jYFM00oNVo6a0B88FSZiNz5b+wG5TIZzhWrrkJvXN6mjWf6WQHORVbNN34hR8/VYxa39Qf15pOr+c2vyXgmkpQyo21Hihm+6dlOt3refXaHa4Ali+4Q4ssO37+aI+ke3AimTIPEmEVwBb+1KP/AstpAaSlD0zUIvTbWS9XoAKnOveJwQQf9RYjFqDv2aE4BYUTS/6P0R6fiYfBYcEK3/7CVa1pEzwfwpPJGlNEd4OPx3qnlYR/spKw3wnFpiIT34I/5uYs5gts4Pd0REwYNsxbmrLrpZ2
Received-SPF: pass client-ip=57.103.68.137;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


