Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEEDD2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko51-00013q-Jo; Tue, 27 Jan 2026 13:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4i-0000WQ-Hd
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:08 -0500
Received: from p-east2-cluster6-host6-snip4-5.eps.apple.com ([57.103.76.226]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4e-0007db-UA
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:04 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 552A71800662; Tue, 27 Jan 2026 18:45:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539544; x=1772131544;
 bh=P41uTtz3LduPGS25KkekeKbSnm6eE4vUspp/Ai5+3DY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LlkjvKF6KQ2gkOvJbq5ZwgT7nTPmZ/UJaRZ1EBpAee4vAt0RoQVlNlxDLmlrPxjoE7c/H0Ssc+l8FKbOg1hvcmyq8jpmcDlasQSlOXJNdr7fLnIiCCtV1l/zcFRhcDSjNxQwFi0yOB8IfShnhMrGXcj2UsJ1PjD1Kh2k2qDGUwr7lO5chnlnu3vrXCD2jyUpucJ2tMpvXlyOXhfswcmEe7XlROG3BKKka9pvmE2v2R2biuDSoyBp0Yiu6NIlNhR9TK/gZkBwjmre2O/NMurO9/4pdrhWyOgqGGGEioYljR5RAh8y2hg7QxRy0pkGOLYK/0L2ufhUYSi+Z9fBf19+Sg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 07C0C18012C1; Tue, 27 Jan 2026 18:45:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 08/12] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Tue, 27 Jan 2026 19:45:19 +0100
Message-ID: <20260127184523.5357-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Jp6dSiMzh7a-M8bPkFDmE2p5iiY_e5kw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX0qQDemtyMzqK
 2Rfjv3hsseSPHTAuF5xmaZA73zTujdMh1NsaaHpTZV3DFKlkkh8eIFK645dqLgw5BMCTn3wlijU
 o6aBxT+j2E5VCCDnG0BIPI3BSN3OXENXrIyH0Vvc0B7S/yYVZpIUadGxgoxKo/QLJqJUnpf68Zl
 r8imh7nLgXo4UaI8Q8K8QuO8HdI0fTT/jjAn34jgP/4i9sQXxHsRo2PDzS0m3Ek5Rg5MRCyfqWv
 cuTCIhog5/UyFfQjvaM8a6PgCNsmsAGAtSK/aXxZ8+y0vbWV1m2W/trI2riOdQXqbVdDvU0hvOA
 RajGlAXa+jBSb1RnXlHxFqmg4hNsYP9KhKDINg2vViG57qt26VAXYEKiPGmyJA=
X-Authority-Info-Out: v=2.4 cv=R4kO2NRX c=1 sm=1 tr=0 ts=697907d6
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pMrQYBbJY-ED6Z46rXwA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-ORIG-GUID: Jp6dSiMzh7a-M8bPkFDmE2p5iiY_e5kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=678
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1030
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAABnlGCVJqckcaISO3p7Au+SAgS3yu19YIsIJlJ5VvYfa+ExnW3cas5dx5DqIvTfIM635IP9X1dhAUt/iDoSuofODZ2rqnNQsQ+6gVNHicKIsZsaUwVnACIQm7B+iqNUHsR/nB6c8gpICZfImizSz0Oy8Ssy5eFbChXU869UWx6p0XxH2XSbsD6Eg/GFdWR2f7XoKlE/ZIhRctVX0UeYpd6BpWPglYMUqhVUxEYWEdnxO8d5ynFZv+sF+8SCzNRJsMdGjXzFE9+9XWF3NdmYl90pP3ObaKb5neiPfHGbZCIzPYTZ41f1PYlTyNbych+A7jSdwZY6wHnDqE5FStF3LzzfO/6B0DBB1SOhs39fb6NarIS1SDqqEEUX6vXJsROX8+kjdirhA9jxaztkujm8QgGb6dwspbqv/XYj6z4v6dP2G/oxCNv5G37pG2d8/vLGSKPJl1WFOlCG+pAn2qJlAkUkK3wKMnGnRAz9jsOapg8DSMqpGCgHsrvSIL/ird4yUZ/TSgzRRP1uBTUFSS67qXP2U35sRJ01pYCkYKhRQ86sg6uhZUPe17ts+9Y6M3TU8gqKnohz6vKA0011h0ZkhzAJgnuCJg2aHk5o5jbtT58IxiFrKE1Nn5tGZmvth0GrSicARh+yq2mdbpGy45EpICdpOBPrIdFuS1HjD0c2pDVTrgJLLvTAdhOwdrV1M2HJblQolJ+7t2FmTrjbr6oexcXvWxB
Received-SPF: pass client-ip=57.103.76.226;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9cf979d402..7701d250fa 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -808,6 +808,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
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


