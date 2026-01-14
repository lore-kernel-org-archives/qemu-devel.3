Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F15D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1AP-0003RQ-Ql; Wed, 14 Jan 2026 08:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19s-0002EL-C6
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:40 -0500
Received: from p-east2-cluster1-host1-snip4-10.eps.apple.com ([57.103.76.33]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19q-0000oS-Th
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:36 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 DB74218004AE; Wed, 14 Jan 2026 13:43:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=j3gxaGgJ/UOlr7E7Wf1HhS3Y6+PzTtQg7lYYYapxm5A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RU+2KcNujGjxulwvIzEEbDhOcz8wnlAcOFM4d4IIBL/V95GMTOFIFhTOLsw4LlpwnAC06ORD5DNUveeoOSGGizeljvnyEJzPL5abEhLgphVOSGqXcKR5rSrY3RfBUHpwPVudcMMo2pZZs7xF9ejTRg65WiTiqzVAIsQfxuqcrojV05o/FnXLlqU7DO14vGEZOg0inatNQAN0mNHirJQig4fYncIxHj7Ur2ygs3vS+yiMtVYRQzs8+Oylx+vfLKTQHkajC6/V39BrCUMdbHu8ul2awpESyvbsX+V+zG5J0b+60fqYkJ4K0Z4pv1Nzv+7/g9Y3gD+yTnbKNXKY4shbVQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 EDF2E18004A8; Wed, 14 Jan 2026 13:43:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 24/26] whpx: arm64: check for physical address width after
 WHPX availability
Date: Wed, 14 Jan 2026 14:41:41 +0100
Message-ID: <20260114134143.26198-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6NgKvat5Oz7V9uHfFBTenwlBYnT7UZnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX21yO8Akj0Yet
 tEuzaQlssLoPNXIxfIs2YFV3taT1LhWcwjnx7mGP0niqYZwwwGQdq60NJOYW706+CKXQ0uB/ePp
 cnsuw5VW8RZ2ljjQYRsymcz04WnrySFAt1nWfmKQaJQQKMEoZfgVo10/GXxu5ar4VY/az0HoK7F
 f0pO8NG5CVko4S3dciQ4RKkf30x/QNcHgtEdZsjug5Q0x+TkZK6xIVtOUsGcg9C+bbqgnCUHlkJ
 njlsjj242DsDjVFZh+kz/mhq7Xtn0H4RnzsOF2GyjUdsBmgyp7QY6obDU2BiarfegmH2ANKACz5
 qdCAajk5NBU4nK0zRra
X-Authority-Info: v=2.4 cv=GZYaXAXL c=1 sm=1 tr=0 ts=69679d83
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=lhTSZ31de6YUvqMuns4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6NgKvat5Oz7V9uHfFBTenwlBYnT7UZnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1030
 malwarescore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABRRHxN6XBzADakdxY9KFrXndTk9BZVvF+eUIgpw8WYSTZjPq44OmwdwwmBnvdv9sfnolghfQUD+kI1YGigN/EHcyTx4S+6+IX9Jez1hMPSQUAPF5MuUsT/zIfjgCQ3GgXG8hMnwIKyBM+Amj4IBtfG/jvBrnrixJX0ZgZCvUvZIRUNy+WtfsZuCbnHCcZAMeEwae+7OV2kGnajqY46fG2bxEDOhTW6iRmMHoQM9j3bc9ut8pWmVzJHhIptS8TkGVfBLTAerR8HyTzh2u7Qe5nbxr1zlrVBfpp39K9+ITNl4SAj/W3H5TwvrQPJHuQbS+cL/XET4HqgE3pAdi/h7z1kg6V8OvbzfoAQY+Lq4Uxth0WcgQpCDyOWxgOnL9OKRnqndcLYrCaUtwsuz++JFVcN1D3PfYqHe63EiNcCY7DvPrE9Ncgcfx++KndgQ51wTjNgPDXgZdZiFGr0oyF/AZUCuIVSbTrEM9MvQWKZ+M53Wte1QpJcSqXNnXd2jyvRG4e5MRUfGk4TVj3Iwb3mDfBO/oHN20QcW3RbamgoiS7zQmm9Z4i/z7h2keOb9J00fweMiddVYRsskDdsVkrWcgKxqPoVD84XSIViYjkJNXtBbQKdGJJ6gsITu314/2XFIx4K+H4+JDvOLJO1cb94uwJaAmBDihhCUPxFPP078g+Pv+SW8UCh8/+yj81pWcxuoTbapfDoExX+ONMNNuyGnhCWS5nOT4f4U8oWuabAvKfZuveTnV8zipQJoGij1nF8u3WW842j26JYebUE9TIksTQHNgHsF2lVdjZPz7mdZ0cOTDJYhMxQn9R45V+61TSeUb7EpKp0azGwMxcKcqGlV47e3d6WKpXMYsnZZdJ1T3WzYdQk/+f8f2rpZpmMJ51z+GxN2Ofu6GhOQRvY0uPk/JnhRufUmFhfmGh37oplfSHpQg9I6IiIg6kjunM
Received-SPF: pass client-ip=57.103.76.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index ab31371aea..def85988e7 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -654,7 +654,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
         WHvCapabilityCodePhysicalAddressWidth, &whpx_cap,
         sizeof(whpx_cap), &whpx_cap_size);
     if (FAILED(hr)) {
-        error_report("WHPX: failed to get supported"
+        error_report("WHPX: failed to get supported "
              "physical address width, hr=%08lx", hr);
     }
 
@@ -879,15 +879,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->get_physical_address_range) {
-        pa_range = mc->get_physical_address_range(ms,
-            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
-        if (pa_range < 0) {
-            ret = -EINVAL;
-            goto error;
-        }
-    }
-
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
@@ -915,6 +906,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
2.50.1 (Apple Git-155)


