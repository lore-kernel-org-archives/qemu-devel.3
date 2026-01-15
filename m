Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADACD3CC84
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB3r-0005dY-9S; Wed, 14 Jan 2026 19:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3p-0005Um-Fh
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:18:01 -0500
Received: from p-west3-cluster4-host7-snip4-10.eps.apple.com ([57.103.74.141]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3n-0002Jr-UW
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:18:01 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 2C8BD18000EB; Thu, 15 Jan 2026 00:17:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=8BCQd7Pm/bl3RBBACCAJWlsvec2RfbtyFInvh6wrHr0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ArQJYhCtloiSoSwbZQPSe+22e5nAuMlk6sg8Ww04E4019XBd8wcXENKs0ON8MRTAkaLF3TCQ5V6c23Dj14o96FAVYzX5CjlyQ/MhylQpByDB2niq1Dsz02Zdd5xRDc44d5GU4DlfceOglgNAKpvXNuvS0+SqsUsPVjjaOm69wy8GeYFs4vGMq67bfFf4u3j32CUzp5kbrSKQS/8OGqa9F4gkEbcGVlghsyS8wms86hpIG4WqEWm7byiw0n2FWfuh7FOkxSpHZxmWFm3pXCNw/s1yAVytcm+v+hm1Z5WDhOy+e0+Pn+klgkOgnkushMBtvQukWU/UHtPjK4bc170urA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 3564F18000B5; Thu, 15 Jan 2026 00:17:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 25/26] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Thu, 15 Jan 2026 01:15:04 +0100
Message-ID: <20260115001505.57237-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ul7neQda63ds19tib5uNEVJs1L9o1M0m
X-Authority-Info: v=2.4 cv=Ev/fbCcA c=1 sm=1 tr=0 ts=69683236
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=h5GvOLqLgfJ3vAEETv4A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfXx0EhmOpTUp2A
 qrYGUVnHxAYSbKVK+lDXCXPeh1rRs+8HC+v4QaAiFeEwZB6rxwojH93RrwMlTqSmp/vlAk0YLrX
 WzLRptCjmqFUxMUH+1O7P0WYjNUbn+ViE2CxMb1gxW0F46D5F5tPdNPvTFq0XAremzfPWPKw3AP
 DMiW8KhOZcFmkHRszAP1EQtK+cz8LyZFkMfYaWBX4vEXm0sbNs0U+prO59Qkp5cGoQuR3ZrofzF
 /RrUFffqbVRljQECI7T7z1hxNO4fddJzqOpy5cXlGHu3F5ix8GrZd+xrhMUP8jzMdNw8ZPMLp6V
 5e/z5JpWXPDSuLEiO0r
X-Proofpoint-GUID: ul7neQda63ds19tib5uNEVJs1L9o1M0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 clxscore=1030 bulkscore=0 malwarescore=0 mlxlogscore=932
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABU8Ikf7h5VuvgN8QhO4l1miLWzOvERXoruMGnXE5XYAEJDZ2z6MMe0WtpCTv/2itn2j4RynFwL3NsDy4a6Lx7Cjp1PByhQa8Qvm2d+Pts8pu9mO/pUmzW7MJ28pj5BmG5nXncXEhX1Y0GMXgZhvX0esrTYlmLCCxuHsUGBgCvWt3tPH7JV0vdpMrB01P9PjfYJ1hyDSyteFhCWMxidLM+RV4aGjkJL0I5vCdVL8ptZsSpoGFhLDUmP7prxW26mbcseTGwnBlfDepc+ckKCqICP/26g26cFS7yDGvhNA/efBSpJfwzKMpFi5yWlwcMhh8tDR1dNPKtzrEZuuKqWWoTgmWBMpszure5TfYle9Iwd0JzpcbGI577+QHR05vVr9ffMVCtOe740QS8PvmvCgqO/tEOlolwAp7OI/AfR3w5vMq5wxtxsIMgB37Ve6RG/0+Whn6v/CCLLQ15xwgtE9QRPhlaXTBuXXkimmRCnHtWIbCqNWfXsjraubGnaNh3ZcwhVBwOM40OWaJhQUFfbYAAlXRW1+v58of8sWs4Y0GkEcgK9up8TfOqPUbHzmVHOcUXOpcsGn3v+EkHE65wEEZEWTQOdubjIDSXkRk1mnb0U4B9LQngdcG1Rf25JklxNKmToaHUViSmyP8iS0I2+6New1mIFIuWWHhwrMDjaSwdyOkwygyLTDu6ybmSvm6orCkIVQyuy3yGeiNMb5hQoywqd7NLH21+owJ7qjStG+329r5lL/zTx/MODwBjQgv2ThAArXII9QVDQdjOd757oW4NnaF1qVueiNICQ0mSq4eI6iIjS9OGJ4TlxFEt7HPDBqEOqRNTSNquj7Jbojp8fojqlAmYDFyjiWxtHyWwZ22vOvIS6gyeN/+CjOop3H+RuD8lPlQEU7/cuKTBN3LlMAYF445nU3ZuAxfYUQI7TGwaMJdgo9m+yeKhAUBniwTs
Received-SPF: pass client-ip=57.103.74.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This resets non-architectural state to allow for reboots to succeed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/whpx-internal.h | 2 ++
 target/arm/whpx/whpx-all.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8ded54a39b..ad6ade223e 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -86,6 +86,8 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index def85988e7..e1611f8660 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -497,6 +497,8 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
+            /* Partition-wide reset, to reset state for reboots to succeed. */
+            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
-- 
2.50.1 (Apple Git-155)


