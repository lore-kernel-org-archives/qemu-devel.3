Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8495FC9EDA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyncE-0006lF-Md; Sat, 07 Mar 2026 04:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncC-0006j6-BV
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:28 -0500
Received: from qs-2007e-snip4-3.eps.apple.com ([57.103.84.174]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vync9-00011F-7p
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:27 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 34B89180011C; Sat,  7 Mar 2026 09:06:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874384; x=1775466384;
 bh=ZP3unKI1M4eoMiNGulIAhIzwyD2Qc4GEP0+nr2HF7pw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=eKOeAun7CbWA2wCHgaVBXcN2AbznfZXr/+dWS2Ty0XeFmpSE8dR2dForJVqzuXMB5bO5aTuXJBMju4jmAjoV4yr98qslPluJgv+/1WhUTAeyXaI1d3uR7LIPMwmS6Ar5la+Na6CQDa34hgRS9QJu4zHUyT5/VxKeG9kIUnPxPB0/RgDGkCJUIymieHiamBwsrxn4KL9u5kZIkYfx+Bl/FeuAVYsng9fDu6eqJqK/lbSs49X2Scw0a5nSkucaBTM6ASf9P2S2yeOM8fmwZMVw+A4oN3SQ2JsnYzkZfovYzkBX6e3wwVK0y0xZet1OGFL7v40G3nSxq7Q3sxwrPePwuw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 A0EB9180011A; Sat,  7 Mar 2026 09:06:21 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 08/14] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Sat,  7 Mar 2026 10:06:00 +0100
Message-ID: <20260307090606.95300-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XLX8XPc0l57Z4OE1z0XqDi-xHwzMN0JQ
X-Authority-Info-Out: v=2.4 cv=KaffcAYD c=1 sm=1 tr=0 ts=69abea8f
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=DEZpVyLLCdwXg5o-P5sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfXyvmlDqlVpnZt
 3E4SYMoEbEqONTdVdeoEsUlkqpo1kLsRxk0NYHwJZJViyVe2XzpIO3mbi7G061t6lidlgAvylT7
 fz3YUbzqkvkduTvqFDiJk0TSFqv8QWMjaJcTIJ5qQ9VzQWOegrSffJcEl12/2kb0wwE6v+ArOxK
 Vmcm/H5omvtJ0ab8ZybGRRHtikn61suRAVzuPj0/oTXuZfGJdd9IY38KD7H5tMawehaU974DBBu
 TCtNpVuaGayXHFjYuis9/ulnu1hZD3D/YqyDdzG4j8is/2+R0AJx6NTlvlkd5RVzKYtxqaFDbHz
 d0/Y6HHAvGKQ1CURJIID2sRy1PbQ5ynUTj9BHt7rFsdP/crJS3Q8wHf/mSp5po=
X-Proofpoint-ORIG-GUID: XLX8XPc0l57Z4OE1z0XqDi-xHwzMN0JQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=647
 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1030 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070083
X-JNJ: AAAAAAABS653C8NAbgRf83hRbN0R8ZOIKVia1Dv0NpiIPjcj6csmuzBDle3x3qa6TMXVIna2R8uA/vrEedy6N/21jh8e7A9saGqxdmII5Re8Dz3HN9jOmVfIVwcxZKabPGs4Lz1Xe+QdItAhRhHSPF/waGWvcek088C4ne9hBV9G80OInDy66T4H+y1RBIB4jUuxnqHkD4tk6304tYm/zm9PkRwrOwdniZM8M1LPWdmpWTxuZdHjku/nCqgeY6RTMJqfp/kFIPmklXy3+Va4X0aibLTBdfT3cutOxrh8Pe8sSR+3GC0T+hqCi8aTAESfmhQr38eb/1hF3ctoWslozMBBbpOp7tdVXENUWZD5/MdS1rbkbsKjrMOpgSPiA1cisCOSyDNFweHuiVhQ1SHh+2MqmHIokErIq4g40T4QDwAhGoEk9ga+GQgC4jcFx94xIT0qpAt4K3aafNtaRlLyhcP9VlGB1bt26+7BTFILIXuykDup3jsBzNi8hOB3eE05wtOKdehuEZd3eBnRLVTEyBM79D4aXv+gkZd0FjbYTgIr61PTNU7xu5Sb0UrttuNes5usGdmuWikFFtMgq3Ss9vAIY2kgA0I1nvnWmS7B+dlcmmFgPJ/1J1wQtmAVlXK7vmNdz3fGN66YQhl69W7ipzUtUuNe/5pOymz2XzJMC4QLFGkV2J6f98u8E5WL6zwh/5b7TqFeAltLn/bfPvOQgJsAWz5jS6/98nl1U/5FPxqlGYyNkeKI6duBNVK/s8qYNDWULXQK8+6ubQ==
Received-SPF: pass client-ip=57.103.84.174;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
index f926e16fd7..30272107a3 100644
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


