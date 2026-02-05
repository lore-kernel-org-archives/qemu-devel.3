Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C67E9128F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0K2-0001bH-1i; Thu, 05 Feb 2026 09:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jv-0001Mb-Ut
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:27:00 -0500
Received: from qs-2004e-snip4-4.eps.apple.com ([57.103.84.47]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Ju-00087Z-IZ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:59 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 CC22718000AD; Thu,  5 Feb 2026 14:26:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301618; x=1772893618;
 bh=+zW8Xnd3fSoP8tYABJv1S0adhsQ8kwT3yFXLBoRfW4c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VL4cS22G2plkqaJGUq+n7Nxuizfz0OPOne8BoUrNgGf/+wjXlOS0CLxTsAhpdE+a1FGipaGIwCaBD1DqANh05AyCfPp7pACr5Wm7/SVpByji11LzS/4EoSO76Ea94HMxaJ5cwza8u0fmaO+kpG0ruRmHqFx8kTIWXM2BqvgCMy+MHOe5wX+VTJgQkIdWouQhIOOsGTYa+amBkmc5IADSSYHxMKAAeaFAp+0UfTftS8Dmsk4yMZkGDFA7++JxPT7NjjLsy6dQSNNeAEKnAqntCj1m8Hh2en/idJttKQRrIlcNToXL7YMI8SxOdQyxMSy0VvOjsFoppxDZYQu3ycCZXg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 1B79F1800D8F; Thu,  5 Feb 2026 14:26:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 22/22] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Thu,  5 Feb 2026 15:25:40 +0100
Message-ID: <20260205142543.64818-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dg_AeEbeDrNi7jZZwMWPhvl8yA95iDH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOSBTYWx0ZWRfX20SXi9yodk6K
 DMZRDeshrU0wh3jEcF+JimXeGEv2smOBo3hpHyeEHkrwtChPCV7C0MhmmqO2/TcW5B0jrXXZpo4
 4bjUsQyjhd74M95pn2jGxW8y9Woa1uFvjXtCPgEuG6GhWVXuVnAQXElUJ/AAHXd3zyoXF3hNuFy
 h4dgl4C1TCyadO99wdFIc8/pTGZoMNniPkgt3v9pi+2+DyPfzTOAsIkOy7sfeII8MzW+2PPdWu1
 cXBzurEQpdJDjgVOM1jGv2Fqi7HGccT2PvobG7nGeagOQZVPR2kBZwEAMXb/4cyLdCkX8FViOfv
 3TE5m9DcvLCJHn3L8w+9INUx5MscKFUk1qdjz9IneJxcbavykTr3BdR/MQ3tIU=
X-Authority-Info-Out: v=2.4 cv=ApjjHe9P c=1 sm=1 tr=0 ts=6984a8b0
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=h5GvOLqLgfJ3vAEETv4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dg_AeEbeDrNi7jZZwMWPhvl8yA95iDH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1030 bulkscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602050109
X-JNJ: AAAAAAABFhYUAz/ZfjASw/R18HeMpWGv/jShe+rYlItH+RY7KovTl8sZqe106btsWA28XcuCIsRd7/E6N/+s7ux3ZpLNKHPA5Mvmoyq4JOcN8ApAXCuU4m5r73kXlmZY2oIA5C20w/etVIoTdy47HfV0ht35f7PJ8UsIjgNQL0yVVK4r5IjS1Y6I+jTyKCn4UxkbbKG3gzVtdQnaF1meYkciCvv9Z8fMHCSE6AZ5zE6Rjl8tVv4OZ9pQQiSNGyGqU99ylnWYA5fitkR9SbutrQYXbOpLVVTM809tu6F5PftXo4TeEnPh3TNSSCDJPYS8H8KX6iJ3HdxvYOsowEu0MVNPQ7qIax6l+v/2B4NylJKV3fjEzLwCjUBE407sWXfpAEn6/H7ric4JbwQRuZGXQ9Y0LknGaung0LLKfFH1F5VGGZh1gapDUTKcX+kIyzlndfeLadAWtj6hhlBUJNrFZJcyWrifX2V+3ObkWb5JreKv3VFzzDm8Sm5ba38K/4vY8nSDf2XO6R9f2dTTxHIURZoXogZlxrAkAJlMlyyK97spthOB8GZoO9IZV9NYyF8vyXHeerzHKTba1IJqSJO7Ggejo1fgnFuLd2X93K6IU8F/mLSqosr/z/JKpEpvEUzTaMn9NWOKQPhopfPfKVz41ZXdn4X+Uz5pb1sQUTtQKJECVqY8SmiI4PnG2AHoSychqaw+wbkbXdZwxi1hhquSU+Sf6VRcTI/eNkdQDrUKnqsLfRqz+tiHYFTXSJZNRoknk7D1Ou1biU2A9CMbZRb6eC3qrDjIFOl6+FmWfc6IbCshbRq03gk3Hb8GyM+wQoxVGRJGdeSwHFRtiMibKtNXy8Ekfa9rqbHRzgpMvdyXzCMfeMErW3KJsK6VRvsmhtZTCDbRcHY0yyYWCRADS9YgabR8nm+a/KXAR6UreUNNlPz5vGKSGU4V3NdAGnDLUZaYDZ8gdXR/
Received-SPF: pass client-ip=57.103.84.47;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
index 44ef42307b..36c5e30a03 100644
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


