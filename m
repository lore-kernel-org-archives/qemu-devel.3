Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45033FC9EDE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyncT-0006s6-Kb; Sat, 07 Mar 2026 04:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncP-0006nt-8G
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:41 -0500
Received: from qs-2001l-snip4-11.eps.apple.com ([57.103.87.123]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncK-000164-HV
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:40 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 BA0021800408; Sat,  7 Mar 2026 09:06:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874392; x=1775466392;
 bh=yzxkgOl2guir8XqGgTOwtCi0aepwJ3dRIj3hzOek3c4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Lnyp6mPiKfERdNKoUnqdf6h9mdIdFzbO2xaADQkgTrJBttwA+WvTfccY0QAUJ1h9Avw0i4xOYhlVdnRyha+F6MZOoSO7cOQCWO6TmtsqNby1GuOIq5w2Fd8MAT6idT1+0GZmNzl4M7ySOBhqhTMiGu/rp5xtRgtx4pclNdzAsy19QWU83Zx1KCrN0CH2i4FuRE1qo9wjDRXVux4o3iJSjd4BXCWvlNweUlUmStvRlsiGlghXpG5W95wOjbEDY6sM3O5A9j5O/MICqu1HGHtWxzsMuapxZM21RPKgeOPfkuOV0OfHAyifcE2U7lc3kowU2Ci1hwL6WIUgV35KRccrPA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 C71851800124; Sat,  7 Mar 2026 09:06:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 12/14] hvf: arm: disable SME when nested virt is active
Date: Sat,  7 Mar 2026 10:06:04 +0100
Message-ID: <20260307090606.95300-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s1FhqoIQHqJ5W6-QRbrIU2lpmomIoL7v
X-Authority-Info-Out: v=2.4 cv=Qblrf8bv c=1 sm=1 tr=0 ts=69abea96
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h9724yil-ocX87RSi0QA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-ORIG-GUID: s1FhqoIQHqJ5W6-QRbrIU2lpmomIoL7v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfX76rzzUEScLuG
 zv8OvddAGyT5XJ4pzpS9MJ/0wUzAdoa0lSz3ENbTRsz/30bcR2PtHaN7BDvun0MeqAywFB6Ji/l
 SAuNodAt2crhLSbNKAUcDRijDUokJF7Ws6ulBEcj8pG+TWnQ0iMXX8pbsmrclEqQ6KOlTXR6HtD
 CuJnOpZojDGxJJDL3XHPtl83kneAQrulz1aemvMcIH8D2tKSHZQ7sy+IblhTKnUX2UtIEnJ270q
 m7vpKRc4BCu/xsFHfBXEfx0piBJoJtuOTVtNcGuptyVZzBEm2AffcAyIQ7/aGEvKlbwTi2SMwN4
 fekP/cJltqgzSvI5B5TW+/O8D+Bv3RcGEU0pha6yR65JUQ8FakkK3wJ4HRFk+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 clxscore=1030 mlxlogscore=859 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603070083
X-JNJ: AAAAAAABXFWmQL4DLTAU+5bKSmU8/hegSIMKerwd8ky2IQ6iHBg3RxSH4QkiwMi2oi+RLGKZAdhXMjByE8wDCE/FJoJwYNJNxGsad+S2jjRuiwHb4U6hMQaheU8CNhJeTkFbZvsTssiXasE/gVycjEejo85FVkuplC1+/pB1tXXqbVffXlZ33+0r6YGTSUTK408IP80A7P/SxcwQcNDVOynhGaWI0dYeoqbeT/mSbRN5Uw4EzDzUk2CphEleMd/yzh8Ssi5LuVaS59Y/jdA0O8g7eqVEv5EOdQJzRKF6aF7Ft+XDevY8YKAM052gs3as/5ivJW4GT/1yYcK+vej+tJ49Y+3cWWHidtA8FACMZUYE3RWe/tWNEmACdFKnpKGo8hdpsBD9i5RQAIytrPRqWqt9aQeuHTvrD+mtTlGawl/OUZZxfp7RDG8ScF3lOAEqpGdprJ02opfHjiwzj93IGiYKHm7dbndjxW512z3U16nDIBdLyYWLtVngqqRLb7Je/9pbEIK3MrQYDxpjwILpihgNepByQvT8KmqEGvs8sczHEwNPHF3C8cmt9Nn2jECpfY8dmFi+xt1UbGCifc/XYfZWaqRZnh00Fo8QBzHoX0dJsEMgtsaRQWJn34a+VQF7AKPKC4hhaxIv+iZ0OJ38hibjKw5qy9tbPeQ7nsi4HpwUwuaGNJIAJy8a9VrEqIUprZ2WyUBxxWCzz4fIMw3cgPs9kcOXhc3taxetTijEUeKWTgAlLpdi5zV//5v7+Q==
Received-SPF: pass client-ip=57.103.87.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, Apple doesn't support the nested virtualisation + SME combination.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 3 +++
 target/arm/hvf_arm.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6666d77e18..2cb4c4aa4e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1189,6 +1189,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     if (hvf_nested_virt_enabled()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+        /* SME is not implemented with nested virt on the Apple side */
+        SET_IDREG(&host_isar, ID_AA64PFR1,
+              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
     }
 
     ahcf->isar = host_isar;
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 6b1c3b9792..9cb58ad9ab 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
+#include "system/hvf.h"
 #include "target/arm/cpu-qom.h"
 
 /**
@@ -35,6 +36,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
         if (__builtin_available(macOS 15.2, *)) {
             size_t svl_bytes;
             hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            /* Nested virt not supported together with SME right now. */
+            if (hvf_nested_virt_enabled()) {
+                return false;
+            }
             if (result == HV_UNSUPPORTED) {
                 return false;
             }
-- 
2.50.1 (Apple Git-155)


