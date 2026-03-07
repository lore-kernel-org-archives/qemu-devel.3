Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C035FCB63B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyte6-0001cS-Jg; Sat, 07 Mar 2026 10:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdp-0001Oy-0s
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:36 -0500
Received: from p-west2-cluster3-host4-snip4-10.eps.apple.com ([57.103.69.23]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdj-0000Qy-Dg
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:31 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 5434D1800879; Sat,  7 Mar 2026 15:32:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897541; x=1775489541;
 bh=ijV/TFHDkMx/sDtjnbI4Tcf5/3qsWHHZ7tvtB+wJk+k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Du9FX1A1mPwzQR9Y97j5AUcNkTZUTgcsauBhE1N94oseNfDMiBcy0vn1wOpmqKc98LGKQ4WfMHGtoB5lRl1ruIvPivbJcWjiUv7xIcGtx88N8PEYPZ7UQm4OA3laSxMPw48h2TdyjqBu8KpjivraGC2Bcnewoya1wVMsSG4jQTPIcC2KepUTLOn6Y7HqASVtUeLnMOIYhXzmp6B5NLhgSyaKSX+0TKg2ck9VaV1oHAbfkq28D4JL6atNb+R3oNtM9xV78vKX+ooZW0eGN/DrnKMZ84RNWfPbyv/bzt6bv8JHQ+WzJNtojqvjfFEiOrSbP6CJI69odJlHzPHyzcnHfA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 C03081800866; Sat,  7 Mar 2026 15:32:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v18 13/13] hvf: enable nested virtualisation support
Date: Sat,  7 Mar 2026 16:31:43 +0100
Message-ID: <20260307153143.76893-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BQBlXeDnY4DqFvBNYmKapHqKE9AfH5vi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfXzpL5edynW+7I
 luxq0DNYtUKjueBqXBQgOcPn8MKi30Vg3w/ZkYdhzWi1qWgB6sjyKHgu8bRafuqdR23l3bUy7W4
 gLDYE57AE8kxtXcyU5Mh82u3XZJ8kvsi6xuSKBPYYtIPnpm5Ha4RHb2Dvm/WW5G22orQ0+DEjZX
 hvLQvVvBFqb88vOOuIsfxWIgGnsImm8O0uD1gVOmiwSHDeStIpF/Khc+UsGkm2H0sN1JMSAhpqf
 YluQ2/AiN3RvbA3otwOaU/Ll5a8e0gQs+gbm3eL35DHW8h09LKnp3htDG9BH6O0sayYftiacHRx
 lQJUGyElbsQNaGPp1XCI2qAQRej3CVk29mJq69Ng8BCi4Ns6yJEyeki1lrhMok=
X-Authority-Info-Out: v=2.4 cv=RKC+3oi+ c=1 sm=1 tr=0 ts=69ac4504
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=5Chse3eIq3h0lgOaJ4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BQBlXeDnY4DqFvBNYmKapHqKE9AfH5vi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0
 mlxlogscore=916 bulkscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAABuiAwzxe2MqPD+spK9FWyYl2wZMzdUwc7jXe2d1TglTgN+m7XoiXwkm4ZStKUwrU3uAYVKI9vzJwfPUDxXOZnoS0RCUwUnYkvhWdLdyIU3dEi8RLWjoukjRAL7ajTUN0A9LJc5yTF4iZ1GMPEqX17G4yC5Zzz2dja30ks4lKUzeaQWlq24Pb8KX9x1UMFEEOHGmRp0V6Me1saNSAgPE1v8u2KMiFmG8OwyINNIuBqVhXyNNcv3miJ/RHg/LrNyOOXYMr34zE62byB2ZTPYqCV+RCZ9K+ysb6b4zLHY826DgrSWBQq0fechnbji4iKefv5ba7kfZkBhNFPo6eK9cJgYqNy7W8NwR3lNhZudt2M/4TFjbSUTVQPCKgdSCfbchvv1x5miqFVJic//ujCvpWzETADxq22hCZFXhQF63UarW1BQijkk4aK/JgXmfD1K943oX9+TwxaqwtoC1HYFWnxuPkUEJ64rXHF/SZ2hKG/3YiVSayi7UZbDMxwYfZyEbs5pdCaRkTvMtqku9XGOKH3yWb6jiQ79DnAbhRtgyvn2IRCvdzt1w1q+9MURuPTKZiLDgLpp/q5l4KFoQZtIWo3UjxOeCstX7PQgLfzjWbtIkZrSQejwevdApWFMBnobHOXIoRVHGVA94cYNUNuOLqGdCCazoq30Pevww+JT2GdqnTvVlL53VUkACEI0CVPaIGaEbOQP2VAfN3RcxEFeci5e/qQ6mOq4QxYXBa6saXA
Received-SPF: pass client-ip=57.103.69.23;
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


