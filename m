Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A26C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yNG-0004zs-6g; Wed, 16 Sep 2026 18:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6yND-0004ye-Eq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:45:03 -0400
Received: from qs-2006e-snip6-4.eps.apple.com ([2a01:b747:3006:202::2f]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6yNB-0007rT-DA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:45:03 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-10 (Postfix) with ESMTPS id
 5F9F81800D08; Wed, 16 Sep 2026 22:44:58 +0000 (UTC)
X-ICL-RepId: 01a0ac65-0af3-7c6e-b2ec-b16d92aea6aa
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDloEQgtMB1gDRQtBAEoHQAZGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789598699; x=1792190699;
 bh=ynDkUo2CoJT9npSAJxkZxqV1KtENNiO5PtdnOdDATtw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ei9aYrOiiMSoJqaCrRKSTjL9CjIu7EkzQtz8IF5jerwTM1oC2zGlJeyRFe7SnuJbmqU5SWY8Y5tRAMEfZzW74xJyJ7DFd0geDVh5TmU3J+UXZJazFKf52I5SV4ZUxDWLiPsQmU1mk4/d0S4wTrVtuJ7LJ27VzV6HgYSlof1UL0xywZp7FKxrSHzPKdqLJB4gHlbbwgzrsdymYIFw9fpNdE4yy8rEvnh4wfFJGV/UGWyX4+p1pNJ1cMFM8yrqpdG7dg0yt+NbojeLtvcxbxNcpqTV0d3jeanTFTXPWJ2yl7Xn/942Xy0686thaMdQMPci2bG24SzvhSCoc/HJn74DOw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-10 (Postfix) with ESMTPSA id
 2018118000BF; Wed, 16 Sep 2026 22:44:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org
Subject: [PATCH] whpx: arm64: check for physical address width after WHPX
 availability
Date: Thu, 17 Sep 2026 00:44:54 +0200
Message-ID: <20260916224454.91924-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMxOCBTYWx0ZWRfX99PjkpwNZuCm
 wfrPiqv4fVxt2nMelaHkg95K0hBy/E6nL2bFRmf4/FlXg4x4ugmpak8k28dbeK51D4kzcU3FAEJ
 +mH1ykTKLrm2KHQeLAF9ZgzGA/h7qYO43BnmjEP8L9d3qRF2bHiEO4BsgG98/Sjxoi634mHN56n
 Q03j67OF86aYlaC3XR+oCkmiiKegfv1CAPM6L47djeoA1hP4800q2zuCoMR9JqBv5Y9QGVfEKyj
 jONZiOaitzJ3+18Q3/OqosRjkj0NQsCpbQpw6B+idwMylKfK0GjGvdLVoKrBuYTrQNx9o/A4jsk
 BnQzauhM617SRgyBkeZw644XAAl3ChQqbzC+UI6QPlNFRnND2XX4DIpNuTqL5U=
X-Authority-Info-Out: v=2.4 cv=TOJIilla c=1 sm=1 tr=0 ts=6aab1bea
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nolE6rQyg8ZvnI8C870A:9
X-Proofpoint-GUID: Xim5sTxEYZNah0DYaRkXL1G6MZbp8AZQ
X-Proofpoint-ORIG-GUID: Xim5sTxEYZNah0DYaRkXL1G6MZbp8AZQ
X-JNJ: AAAAAAABYLny/DmO0HogjuYOClO2yf/lIiqOhWszgRtqcaf6+BCdtZfr0Mkw9v1eVbtKmzonfNj7RMHskdZIFvqn69n2MuzPiIwWyx1iiYkeaHkITIFNAmmke9GyBGkvSYOltMV743YeZOxR3znj70Ypwwjjxs6rBFPISPSsw6ARx1NUzvo0WW7WSs0btukIrJ8lip8fG2Vk73ElbYeqepH7mpPI6nxRYsdEzMFDisb1gQ1eYw6wJdXrhNSC2myHpGxYLcY04XuWCpK3Iuk0EpcUpqIP0segM6EBl8N8UKT+a8CZP0R4E1YVTfpK/BKwm/CNP/z2P+sFoc0Tk/5r19q31wFPFXdwCwCWg8/XOxWyEIqWbBS6NwTM3gUwQnE8k2RfBXbdkEZNlxfgvlrEWF26GOMUpovjJLpyWvqFL55JKZ5eqMLUqWTUEAsD/elY/6rgD0+Y+derMisi3n6wYP2cn3xrvAD/seTdAihPi8RIHvVXE9Lb5mF1Omq2T3QuioPUjUIjh7DsuSyPilzxGaq+pkper1/2yqHyQq+vn46yrJQInvLrzWpZdss1t0NIaNBvwuO661WxY4W4ervj1UloY/VzOkvWBb6IREvPM97E6nauNAI4/nKRaROidIooR8SwT3s/MRLoZ5X8yeTz2OJJnn11SQ+Qkb+qlfeWw9FJAcm+bP+CEs8Lj54kKbjhmy+qUL3ejLvWXYgbco8Y+ZzvdHsq939I3P60zaCHNStTUaDgNC02BPqXNb2DdtDFKhTeH+smhe7PBMeLB1lWE06V/9epY7D8QeTDTDUgYq82v5c44JP3mhYAdp/2LYKSbDyLG2Fj+IERAGhWznRsThNw6c85ThAhNgWYhKkiGK/JrfWyrddh72N10rw+Wb0beJR+FJy9czZJ6L1eIIlveX5H8fPgXw1UrvE3lLbmelo/KWLZlUl2LbGD93KkrRHUFmcebXck8vWUtAz3NYK5OVWWIzkjjHh
 HcgAmg/WyhCmMEV4j0ezq7vAbnVDVsJ2me2n4D6+Yww9VmjguIAhc89v3VvHsLuSGuGs0Dboa9oKbZdJC9oaqjh9uTIpUYKNI+S3zHl3H5gvHp1qhAqloNX3eT6tXKBpTq8bpY/Ayk9SiFcPH+v+TvUF765JQDIqvH83LDhjI8sxFqyPDJDnzoKhiUmGzrblCfuS3
Received-SPF: pass client-ip=2a01:b747:3006:202::2f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index d106400686..46f0b9524e 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -879,14 +879,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->get_physical_address_range) {
-        pa_range = mc->get_physical_address_range(ms,
-            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
-        if (pa_range < 0) {
-            return -EINVAL;
-        }
-    }
-
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
@@ -914,6 +906,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    if (mc->get_physical_address_range) {
+        pa_range = mc->get_physical_address_range(ms,
+            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
     hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to create partition, hr=%08lx", hr);
-- 
2.54.0 (Apple Git-157)


