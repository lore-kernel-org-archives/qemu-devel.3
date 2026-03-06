Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D095AF513F5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMdq-0005o4-9j; Thu, 05 Mar 2026 23:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdo-0005n4-5j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:20 -0500
Received: from p-west2-cluster5-host7-snip4-1.eps.apple.com ([57.103.71.64]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdm-0002Ur-K9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:19 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 18AA21800118; Fri,  6 Mar 2026 04:18:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770697; x=1775362697;
 bh=OUuDxgqNdZmzpnnMy18wEMM/IqxNg59OjqOVW0/0Og0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=b8Lv9PuUH361QUZ4qdiqrz+401sburT0y6D0Q+XHzv+iWRcoc2BHrBWnuvyN0qjJdawseTKAjzDKEAsHFuHqY/MBI6+/4inhOrgsTsAZq0qYgPOvZjVWVR5Y4Ox/7MXZywYuU+oa9QP3x+yPinBRR+Uhe1pbn+u1hk9/UM2nSoTO61r1o08OFTz3dUz4Eby6GbkPxU4SII0iT/ofsF7ZmgZqs+8CZnrn8T3T3ipSwkKUXm9Io6op7I0f4xiIgoTjcSYzIGeKnTEmHBrpbVQs8ImgxwVNEFbzWG7IoLz7VqTxNH7cjB4vRp0lfXhKVaJifYTv4CQlgb6XDapdk2YiIg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 15AEE1800147; Fri,  6 Mar 2026 04:18:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v12 10/15] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Fri,  6 Mar 2026 05:17:41 +0100
Message-ID: <20260306041747.54554-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfX5nxr8K4DAsOp
 s+1ReWhK03jmlyHa+WvLrevI42129oiQa+YpnFQ0ycI/+WZRHuDDV+joS5szXEJIAu96Hgu0ft4
 TIH1GRFGrZ/DvEPIg4lzdBZAFubh8VW062x+c+CP5p1soY8XOqbPcfffSq8rSyWV5Q02UfE28jf
 Maq7fd8BNkE0B2pBjDccY2BXw8aWlJym3fLkXDV7+LPFDUs8dp3x30udOfQFcfkavnXw23oqmaz
 3xG4ACdit1+m/9Dn66lH3LXupCwVgxTI47L7y1PGGGZNf0yJqKU8xtzCwj9MD4vQ2AyVI46J/1s
 PVVEkmi7Foue3Zb47iFC9e95gflDO0IY6oXwsDQHSQAJ2/6Zi96owiEqDq3APg=
X-Proofpoint-ORIG-GUID: quvC9HfkXALhE48pfVjTQ6canl27mJvZ
X-Authority-Info-Out: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69aa5589
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=DEZpVyLLCdwXg5o-P5sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: quvC9HfkXALhE48pfVjTQ6canl27mJvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=660 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAABS/tiduHyoHO1aqMR1FFGSOOkW4yYyMNWdkhCy8NNQVRdebt11WcXVfyCqtrUpbuNobPNJNXq0jFnBL92C+PMJNXCKH9ECtu2xTXAJw+ReUvpjtLOzgdea5RQkNL1m37P1y1y0Gni7ma0u5iLSRWQDh+zeXfo8F5YWxkOa0/T+n+b8x/MJyFxgug4XqAK9BJj4wmOe9EvfSt13SJss/YCNuucmnBHs4vjs48SfVww8l9ZsL8629KYYMMMhcNd1zqTM4NK2Pk1CderIABUDleLkPBnSX3KcBBE5r3xWBwlrB+xEgGK8Z+I/YiS0OYUwxWiFsR+KhBcFuzmkKDnH1e0HOzekynVyrkzrtUyvV6VXaz4F8ozsv/dpOstJtOVzZzMLlBwwY2QYD7p+DS4ZsOnt1uEXmy8zPmKkx0Zz6h+2n9+1CiAvxQUXAhHIf9Gwk9iJzTStV9Oi2uRFxTmlXchV/WKdssX90ACS4celG0T2zR7bnKTUUcnupr8em+13wlfgiN9P8WIUuIfcQRr84ey58GQCZqb1vs6b9Pd6DtLZMhjpuUJO1tQd/4a4Tk0lr3mGbJW+Vcxy92z4sP+CsTs2RqWJKLV6L7Hj+ZO5iwxqnelMuX+J22WB4dkkk2MX8bFd3qZCpTn+NtzZ5CIRjSks/4IGZHUF+SaaJCazk4ydcsDihYtitM1IDjpEfbvwZoeXWh3fMB1bnwKxhN1iKNEhb37zsDofinKOjNIm+5yfftCxgtgde8uwdJs
Received-SPF: pass client-ip=57.103.71.64;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


