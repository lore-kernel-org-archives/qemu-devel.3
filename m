Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C505F55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0a-00026A-Hm; Sat, 07 Mar 2026 13:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0X-000259-Qb
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:04:10 -0500
Received: from p-west2-cluster2-host9-snip4-8.eps.apple.com ([57.103.68.171]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0W-0003YZ-Ah
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:04:09 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 39AE91800610; Sat,  7 Mar 2026 18:04:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906647; x=1775498647;
 bh=ijV/TFHDkMx/sDtjnbI4Tcf5/3qsWHHZ7tvtB+wJk+k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=cS9wpwexRd2DmDCDCCBDPdx6xA8D729/dZiZ0LAPW9YAq4RJeOUR3WQawp/5TQyvTAJmN6pABVxx2V4mU6yRO5DPm9NtzlTmDxeB4RwWKk6r+nCvww1T+HeGyRjAv5rPAqZw0bcqtvNNUjzBvuKu98Z5yolg/huX9ssFsNZvftNTt7es6+HffgTNcikbIwUJ61YAZAtRueTBooCHbNe83E7xLeuz0LpZjdNAJWn4/gL2MAOQ5+i52DiKXD+KN8jE+k7D85FdTw3dHFtrkzAK6rtrBYFk2KyoWeLGIgzyIkS2U5EJK9A92Cd+r92xv99VRFZPuRTOkmsZgz451a3YnQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 E12101800E3D; Sat,  7 Mar 2026 18:04:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v19 13/13] hvf: enable nested virtualisation support
Date: Sat,  7 Mar 2026 19:03:30 +0100
Message-ID: <20260307180330.75168-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ULnQ3Sfy c=1 sm=1 tr=0 ts=69ac6896
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=5Chse3eIq3h0lgOaJ4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3NZ3uJsnvmkrXTPepIezxGsVkDRv9ynS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfXwsFgiMLeBTvn
 I9Hw4Myg8ZI98fGqsqTPA3Ojc8fArN832NVQiXruXgHBUzHC9GYr2bIH55L1yENpTHF9euLZWXc
 bdqkQB8kOEmCycGLK4LZonzrVsYOurv3x6OJRstPDoSy2qPkbjR9yj5S8im5J89p3mDygwBkri4
 m3YN6NlMGmdbySoMK/C9Kw9ReAEykD7viLYdxyfDTx8Vojm33CyGCcVmG/+HiN6VtKMXtsacxDm
 GkQZT8u6ifpdSMXinYiZbVVmD4RZOAwpylSGbIpYCEnvhGRGpMZmFFAP0bsO+zs9LuIzCqX5+r4
 ipV4ANj84lz5V+oJgpvednyLnMcnnjTfROS54RO7g7Lbnebr884FbSLs0o1Jco=
X-Proofpoint-GUID: 3NZ3uJsnvmkrXTPepIezxGsVkDRv9ynS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=916 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABf8E5S53Yuh0Q9EC+aukOzswYyYa1Xu2RrCebRg2+5u3DfsUkbAu2Um6UfRnpfZuMeODCHynqCqcqWexKjAg+Up0c/lufcsV1c6r/1+ULyzNP+NgeXZgrdUbkX0scTkFb5rqyftfxYZJD6aFhi9x/C6rhu8bxuYD6I+onUqeRxl2BdqieAHaX/4uSgUz7QGuYNkuYwdIsFluje40wAz9dbegTu+x4wD5V/WB3Yezoc0yV5DYw3L+1Vcqq4O8zjRRo/WerAIps4eZns2maxH/6tFoU8DGqaN711/m2WaQ7S0PLUCsYAH/JrSIL5pkaF23ZRgQ1vMc79ZLRBWXc7CKh/J0yL9Jm0Q8iOoRHrRD5hp0VZL2yDQDY7I054Srqjogj2RdYj7vyWm4ur2J2sJPUgEu6L9gjuBKHbyVszHqzGSnauGwAbKM8+pcL5dwAsalKTTZWt9XxHXyac2ZRh/I0YS4ePoqYYMEnOqdiAQRVHgETncRymoshH/ZKbxR0Nyzny1QdkXEVFXx7Q5yfufjCcjcor75dLn7nkzyjIO+Um5CwzCd81DDB49rM8ymu1n3Wbe+M9OCNXjjI/mhWub6bPFYNs1tih95Wbc4JMkxwi1MZ14GWkqPnwd28v0E/TVdsQvr9EAnz3kQbYsCCzyVB2OUjhfB5sggpFUJaRi/LzURQytURHU9H0gOn8+wJzh1lvFo4XkXFTSmUKUv+G+VySlCBG86gmJUGChwYoW7waQ==
Received-SPF: pass client-ip=57.103.68.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 90769936d0..bced9f67f4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2393,13 +2393,20 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
         exit(1);
     }
 
+    if (vms->virt && hvf_enabled() && !hvf_irqchip_in_kernel()) {
+        error_report("mach-virt: For HVF and Virtualization extensions "
+                     "only kernel-irqchip=on is currently supported");
+        exit(1);
+    }
+
     if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
-- 
2.50.1 (Apple Git-155)


