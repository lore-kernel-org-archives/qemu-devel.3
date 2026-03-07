Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9AEF5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytdl-0001Jf-MP; Sat, 07 Mar 2026 10:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdT-0001AJ-C0
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:11 -0500
Received: from p-west2-cluster5-host1-snip4-10.eps.apple.com ([57.103.71.113]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdR-0000PJ-VD
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:11 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 A04FD1800142; Sat,  7 Mar 2026 15:32:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897529; x=1775489529;
 bh=CFkZ1ydlJzWs77CaHK66tAU5BFl4876/9Mp4Lq9BU3s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=LX/Kl2gZNRAld8rE04YSjbRZGtCdkblRmvNZ3P+RW17Mwd9p0f76viaLNba0mNs7U7xj1ZI6nBJE8KS/nJkdSff/tSGJKIciWxia1laG/RYL94jhCjchsJgark2lqd0INWWbvrY4esDlHqzF3adqUN11cf0otJhXrCGsDYUxbrCYQ/lsSbpecyo1ecFYebHp/nwp9U4ta5AKQ/oJCbyLff/zKcAxtRtXeGIRP+a5RmQauAmPWHM2ybQl/dFv9HP+dokHuq6QdgmBrLJNZZS9+PwBjyiJqjXCDxyrelf06Zmf74qdDDdX4QfHvnLiEdt4+qXib95f1UbJZaaHAEio+Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 5352E18022C0; Sat,  7 Mar 2026 15:32:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v18 08/13] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Sat,  7 Mar 2026 16:31:38 +0100
Message-ID: <20260307153143.76893-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WYKqkAvIq6IM6i_9hjEAYO8g6tWXWXQX
X-Proofpoint-GUID: WYKqkAvIq6IM6i_9hjEAYO8g6tWXWXQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfX6gv2IU+PGXwq
 gxyZNOBGqHRXo7Eno9Bf1qKPWGgJ/jTh+duGZuDyGmDn1dNcABDkD9zKnh65Cz8p7A9boytgigC
 /e6ERevL6/OUfTIjFBWowV4WUYohFE5evRqiZjwQACYZBiSGsTHFqs5HwAA3gFgWaHjyZoCWf4G
 LD5E5Fhzw9Rziw8UWPZd8VCRZMcZcAOim3kl1ppsimOqcM/q3AnuCunJqBJMrM/CIwEzllF2Jit
 KW+l8TET9hub/mz1ZTudWNKRHcmf2Bf6pvcRPBQu6TwRIRlAguB55Y3JqpaiN8OKEyH8C/17p4w
 mTyYtyrHWSFVfylfSaD3L0DfnfqB9GMSYaaXuHp2j3IuhslXYipogeS7gz+isM=
X-Authority-Info-Out: v=2.4 cv=DMeCIiNb c=1 sm=1 tr=0 ts=69ac44f8
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=DEZpVyLLCdwXg5o-P5sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=582 phishscore=0 bulkscore=0 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603070147
X-JNJ: AAAAAAABucEE+bACwR72KPap5ZrhouyFJ9HiHJT65uohPgHZ3iZvxbp5o9+drvF/1nnMWxugOSHhWeOfah0keOhJi8NRSMNx+FwwK0Z0uJurHxCeThfNRYMPSn3+3Wjxq80pRHjod85MEqKT6wbP3lMD4xQsLyBZ/+3S0LSOIafmEzUen51Gws8hk94uF30XOD9b7FIQ+t99HK+vcdxayOhdtBgQpLspqy/tF6m22F4QUwhz+oiRBhBGAP3rNIiBhNGtGi9LWggDv9AM6VZk1eHnKnrZAvqTr3SKbuutMOL1R0ZU2YW+VNRyqWeA7hp7p9u39dQLKRBokf9m9dLn31bwaL1N6UWYX0rgnFu50EQ4P9HhII/G9JHMpqsX3V7LtcUXYCAnZMZ7zzqp8EqltM5w+RDTaKNJvam49NP0gz1lQJD3pSG05LLWZU+OzaK9eudC3+6bfkZk/M2MfshYKVNEwCXa+egP7ftuAIm6XLlP9BFknCIh5s0eZRd4sDH3rl2Ii2Jqv7Spb7gwkTpBX8YhQUcyJxk3o7mXPSRV4ZbYncAfA0yKQqeZnjT8JjHBYeWh5WZRhDcsc/QfrI4HBtgAjS7quzDTncqUyiPWCDxl3nVr3Y0slfTKDSBzQ/9YHVRckgLAjt3uhGcuiJTxCTC1XbY4ZWN+kzRGXP0a8U5BiDkk5ilNmnOoFRfrzKry/87SEXYB2MapLY9ZRnOOt0gAwdPVahi7yNGonnaHPxPdVfMdDHKFgKpoaQWn3g==
Received-SPF: pass client-ip=57.103.71.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 14c0c7f540..8c568d60bd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1145,6 +1145,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)


