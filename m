Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD140F01808
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ4z-0007Zw-V9; Fri, 06 Mar 2026 02:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4x-0007Z3-Um
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:35 -0500
Received: from p-west2-cluster1-host1-snip4-4.eps.apple.com ([57.103.68.7]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4w-0006D1-HN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:35 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 A90A61800250; Fri,  6 Mar 2026 07:58:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783913; x=1775375913;
 bh=OUuDxgqNdZmzpnnMy18wEMM/IqxNg59OjqOVW0/0Og0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=cqD7RGhyeqxAw1fFJovaqYsjU38DIj1dLuh60IZSiTJ64yMdLJUrBDmkSzl9PbpSwWVnlmg01eRYTaMoI65+8yeL2xi/zbShYHni/4NlVAyKK9PoKqzZRfhEabxGuOciSpK+PojqFWYoCS/QrIW3+dNT8Rem5vZGHV6oznYKp1//ZyaNKAsp2Qm/TMD+5FqP1gEa1TEWHUl2ug51uP6cqsHv5ShzaxIJlQXyjSFrfKqdUT3ECXalwOkpVmTTLwBJgm4ay+gC3MSOZhGplsjaYHbgXrrLEGiV+tOQfDb+e22+kYkpx4sX/4maah6zaRTHDTeSjGdXjoFcGu3QYEoYiA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 2C217180010E; Fri,  6 Mar 2026 07:58:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 11/17] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Fri,  6 Mar 2026 08:57:50 +0100
Message-ID: <20260306075756.88922-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=NbnrFmD4 c=1 sm=1 tr=0 ts=69aa8927
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=DEZpVyLLCdwXg5o-P5sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 14hZo5cBuOnrrLc2LQumBOsvlcQCxbC9
X-Proofpoint-ORIG-GUID: 14hZo5cBuOnrrLc2LQumBOsvlcQCxbC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX7LhXf2ZtL+f8
 463POhL/o664ov47//eViN1rGHKfuD2QJFJPq8npJoyzlWiurZHwBcvcu4arqRzuaCwLEnOkIr7
 ipXejJyB6GIGfTrYEGUffa3n2H8BFoldpUEiA0Wq0qf1PO37bvJRwLXBRvMrMEEFMj+1AD4qTVV
 OqWifZjXuLIylj37i624jRWYHAtYmEEHWvTkObzZJhGFrwmN9HfPMptQv5V8+gZeGb/MwCSuPmR
 IoO5uaApab3Z2sxnCoABpQy7VdoSltsvOkId098VLU/U0//yrS/ZqcvL4SntbZnX/xeWHQsnrwH
 m2hLMXpnQuVe1alr7MzT0zBU+M86h0q3Dv0J+Zw5Cgprl2/GmXdm+G77gWq5n8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1030
 malwarescore=0 mlxlogscore=660 mlxscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABpKEyt0Sm3g7hB6PHYpawexTezi789NCU45nqM2TZ3D4GAg2thIKr14dEOdQmCBIqu0NEzD2odknLE5NIuUotDx7VoL/2QQxVRNj4X8bM/4TaRfbO9PIigI4VCBwnrXFc0jIyss/8rf4MlZrfNrZUFsYH8ggYGHIqqKXmFSk+CbXGV2rg34AA4oCufyHX8RX1vDhIhlKOdo3SWwmTKZGRP7ZDahJmvH+ta3/MRaI6Rhs4ty0rJ/3rd8S++Rh4hCmohi6dFQjY8cAhNE/j2lBoNGd/W1zSMmwNerOkA1FOjes0lGRdqjVt7/OqMFMWgykT6CSzXl0Ko1oK5TiN50mKRcnBxY5zVAx6AjH4TUI14dptLSbvbZ5QAUN5JVkVm5iQXgjnn+Lh2idC9kbk7PZZs1M+K9mGRFYRavPC2PKWvsUiQqgXecBNw4KjCUBLHEY2MrpCyusxGdSko1H3FMsXm7F2SC3N+Hh3750R9fBo2NHW0DI/T0rV7t6RueeD5O8UVv0+3j1KD3E3/39tKTo/++61B2/nJCxC762snKxFDRZGXmsWefV+4brYfeBVAljIOerzRXBAwdKB2qMGhkr1nt5/Okd5EFS6p/7BgmXgi0FqINcDEM35k/NG7clFkl75bYafp4PWlQ0XXwcSFsfUsWX+pCn85paTgNlacCy11PrbMDQ/p7lIy1KwIzOzM1RwlbsRHzItzNqxzUPXQfZQx19gclmC+G1XUgbOQubTHD4D2UJB12uWeSIc55k=
Received-SPF: pass client-ip=57.103.68.7;
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


