Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF27EF587A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGa-0005M4-Hl; Sun, 15 Feb 2026 06:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGV-0005J6-Qn
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:15 -0500
Received: from p-west2-cluster1-host7-snip4-7.eps.apple.com ([57.103.68.90]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGU-0007zy-2o
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:15 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 31920180018C; Sun, 15 Feb 2026 11:26:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154770; x=1773746770;
 bh=fXwYscBvvtHt1b3c45aaMrtykZ4/ZWPzlwZ5Y4HBqO4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PUhI02Xu2UnuMth3Pl1r0LhrD6zXnWNWsGz5RxZ4m9HXA/2FINZFOc0tqK8QOLFU4C/PtQsLMX4U0lTllyvEcOWKIF0ULal9HfJ0khRUjxe78+gVB0GCM4IBbhw0h+vicKhERGzqjJpd3SxbgG5TUHaz6b3YkbszeQM3R5OqQD9MeOO5B5fwJrT/ZThtEs8gETwuOU20ortdKQb+Bi2oTKRIh3TrhYLnhmieSaFPn2K4K1YN1cNZmnPbUIv9OHjMSwUIap1IW3IUl80tdjXnMY9ysUZNJ94xhmrxlxKXTa6Q6t/zHzpEWDQGbcNGYaeG3wvVlgRa7qzX5kl4Q2Np5g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 A99951800145; Sun, 15 Feb 2026 11:26:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 09/14] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Sun, 15 Feb 2026 12:25:38 +0100
Message-ID: <20260215112543.4817-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HRsGl5R5cTCJ2cFH03flXbArNxYXOSme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfXzvvrL8/0/AX4
 mh/knK7g1CEEMH6DGIW6Q5G4NapcEaHfJySJRt+Sb7VIwrejhyTpkJieZbTrNwEmUDFlJ4upPru
 qFWZTGCr4Zfm5I372VWA7hx3KQZzMB+oo9aESA1PeVMSmq4D18HuTsvvhChmp8rgiKJvDBCDdk3
 mEYo92J54d4phnBAeZfY2v5CToQBARgQI3s4yshc0OAWBXbwSp/3k46vFWE35h6a9eNydv5y1LY
 GkkIQmLdIp4k/LrjhkgrdDg4noX2dnAZi4mve4e7kDnDiJ9GriWWBYtrTYXE2cg3QmVxBtLIRSr
 3AR+u9GZ/x4+6iHWeU6wTJIvzKfBDd9Z4AwCwo1tcT8Nh0jBS+KE5RVkH0iYbo=
X-Proofpoint-ORIG-GUID: HRsGl5R5cTCJ2cFH03flXbArNxYXOSme
X-Authority-Info-Out: v=2.4 cv=SPxPlevH c=1 sm=1 tr=0 ts=6991ad52
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=z0ix_qRbhGH81XwssrYA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=638 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABd81Xva63T/UaMXidulM1fAIhy/7xbspg1v5xStqTld5CKkZYWrmBglY1YF4w9+YsxMvLTtQ10A0aXluu4N7QyH4enA6/0V0RhrJKkNg8revw6meYscKr5AlR0EM8k9239LZTXZ8HSAfAVWHNBMAjTs7JWXkQEQk69tYtPIdT2E5bmYP5gOM1Zl19GMPsk6jECXrITbWrQbWwjnNAcV7cu4RwxMBTvyPGqE7QvA1M8peb3hrJiTT6Ve28+39HnUn0gwWdGKJIkGOMiiZslRR5xgB4+/WfEMaxD1r+KLc8+Cx/O4eIKkVl/CbKFOdTyKTs2iy7G2aEqumEbWSaiFJV5TQKCEgj5OGDjfGUN9N8AjxPHS2yNyHKy4+50eU5aKm3UmjjP7rmDUuPPSWydo0FQRvjCcZ/4W7EIIHiE5Q0FZAzPJ4iqtLBL4+dv0M3PMAg5sqrfFZFCGjR3peYddzqDkHpqUb+dLIidkdjGDNnkGhYNxcc4HphxSsONKzhMMVDhB2dpHKkcDdSg/58rR0o7mY231CP7FoX3G3bEZNUCdNi+ovPCodgpz/vVo55UGRFkZObG5Jq6smw3YElDBX2JGrnfG4QyvL/fSpfMlAQE47lG2zC+QuxFBzlvt9/DRg2qieAlJuXZoDMZASRQo9ISOKOa6p73phzAh+rgjLRDllEDQ54IjXnUDXQ/i0jgb58XQiUnvs/J9F9DW2A7nEQ
Received-SPF: pass client-ip=57.103.68.90;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index be1ff93e0e..0f45e22221 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -879,6 +879,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     SET_IDREG(&host_isar, ID_AA64PFR1,
               GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)


