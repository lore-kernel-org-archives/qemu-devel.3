Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5348DF01810
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQbi-0007YG-H8; Fri, 06 Mar 2026 03:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbH-0007Iw-Gi
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:03 -0500
Received: from p-west2-cluster1-host3-snip4-10.eps.apple.com ([57.103.68.73]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbE-0002W9-Kn
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:58 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 73BAE18001A7; Fri,  6 Mar 2026 08:31:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785913; x=1775377913;
 bh=OUuDxgqNdZmzpnnMy18wEMM/IqxNg59OjqOVW0/0Og0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=JtyF4GLmpWF/4mKlFJzw3zIyiNmKAlP0Vqy7IIhPgfQ7gMQdk+6K/glU7vLZUchoiPBYFhtLHTAyjAjWWKzZyAqim8TlHw69Q2Rrc7MuitS5nUy+8G0s3KIcQsrTIVOjY+heyqZjxO+lhmSxY0SR7sTGD+4T1vrQPNdAfTuG3bsEXBLoOXIFTuDrBuIaLkU768aBuhtWNDiyUtHDrqPwdmYbijE60ecDkfOcjzWPIITdLXnD5t4AgqelLgseNVD0X7c5dD/Jb0GexdnEmybJ10235IH6WXRzW6ltxpH9jJ4jWwrDdTDwQu1jz5ViuOTar2nSLCfvA3chjwN+4v0Vgg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 21D5618003FC; Fri,  6 Mar 2026 08:31:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 13/19] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Fri,  6 Mar 2026 09:31:07 +0100
Message-ID: <20260306083113.74177-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0M89AbIRmRwsL-DEmagYZNfzH9m4jV2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX1W9oU8jHN13f
 Ym1iKVUBTkfRX4csYH/4G+a3YagZZK54l6hcQPhFyaEiS8Sj1LWxDUYBTAWrxgbMaLXbcc/yEKO
 cRRr8YR6CDi2lR6aKE2ykNp/lQlHb9X/bYX4Vvq2u+UkcjvTFzVI0U+syr6j3NHd+2ATojgsvMq
 zGFQdyRzLiemsLILqZIwVUmur+gNfN6oqxJ4VjTFMFcbpoGa6TzgIQ6822jrdDccLcGmTtrabJe
 8Dsr11SB1xyWZtmb8+PMcZC/D0ewcCLnElEfeRJUAEh0Ek/lqtaqz5kX+gUTKtP37PZp3F/7YXl
 VCVNkriEFMMF7PxE4vdPQDzSB5lG0YUGL8YyI15+fcGG/JzZWnbp9JFJMLjA4I=
X-Authority-Info-Out: v=2.4 cv=KqNAGGWN c=1 sm=1 tr=0 ts=69aa90f8
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=DEZpVyLLCdwXg5o-P5sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0M89AbIRmRwsL-DEmagYZNfzH9m4jV2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=651 clxscore=1030 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAAB7GyCJiQEqIuB6dZKGHEShm4SovYCRTDnrJ52Qpq7Rq7xZJa7QuH8UKeT9B8vHBq3+SxNzIX5fpWU0nmZ9FHnFYcVrqQzaOwX6mSTMFW53DOoCLtGO44qnWCV9Le226Y4znnwsnXCJ4aiJhR4M8Gm4NhSP6P38FTq3jarBv4nsXK/+10SJVgdANJz54aylI28NTuH2wEPoZQfos7XQr/ywt0OlKJLIBxYE4RxWEFxihh88LET3yYfjv6Pi1DiIb2su66hfU9PfWPSqH+zZ64Y/2XoJm/L5GIoNUhs3aOv8kDmD1yiA4Y7iXP1VT/WXcVEMXSDhYu998Bc+KcSUYB2ZFPnEOz6vrFMrASeAmBdsKM6/eNPx3Kw5KR59JB6euPf9lr/W2Wvww00UYcKedFzGb1NSU88NPI6d6c14oZ6d1yDggYsSnaoX9UGDSj0I1HVog3dbX5+XOaUW3jd9uEisyBNkP8BINa8n9UWN7TWXw/FbB+/VldduDY1Du1WNBFnAVIQG0cyA1gNC38J08W9U4BVkxmp3l+5ggTye+LRRMbeV0Ixob8+xSEMStmsSngdy4rfDantjx/qgDfthVSa9BKDiBJh0m7q4xfvz9pi/SS8EQOXAh3RKW0Z3YMHX6oWm99+gv82tY9Hlj3piGNpuUpwazcTKuKOC1xHQ9W5ieFvlIKAOMGoLRTpKM+2lA7ZjIzGjC0+G+ESi62Wv6aP5/Jie1I9BfbdXYTQRg86k8tb7dK3UNTKmka0H6FHBJpIiMI3H9bphuOWcOxInxhelw==
Received-SPF: pass client-ip=57.103.68.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
index da6b548880..212efab731 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1127,6 +1127,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)


