Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280F9E94106
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNMa-0006GU-KG; Mon, 29 Dec 2025 19:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFw-0007yd-TV
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:34 -0500
Received: from p-east2-cluster1-host7-snip4-10.eps.apple.com ([57.103.76.73]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFu-00048N-GX
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:31 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 C781A18010C2; Tue, 30 Dec 2025 00:06:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=wiU+HKhv0NxXO8z8GjCO8FE/mL3g0nXT19I99VvdiXI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=hC2VAfW9fB1bk1TdlDsIfinbNJSs0a/tdul7UKRo9bbR8f6KZmNUzpZYrBg0MEvAF+h0SON8r8WnAAA1NYeCOOCobfVP8txdyF3HvJ/fYZpu5MtHZab5vicaZt708WIqdPznZtE5ULL1hIiEFZbBNMvajK3jURI2ytyU7RkikMs51FhvZB/2/21Joo686+7M/R9qc8lgoDGFck8ZI1v0yvVqaSgf1VKDDp+E3/QrwNSEis/b1sxWthhKtMfSys60bGHq/IxoAFPUEjzveMCFIMZtPnWCS/JXo0ZunYgx+0Yr0mh/OPsFzXKbyVnkwKhL36cO2UhNhEfuX22kUU9oLg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 6771E1800101; Tue, 30 Dec 2025 00:06:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 27/28] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Tue, 30 Dec 2025 01:03:59 +0100
Message-ID: <20251230000401.72124-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h8BJLb8lvuiHd-jAxB195h5MGXafy5EQ
X-Proofpoint-ORIG-GUID: h8BJLb8lvuiHd-jAxB195h5MGXafy5EQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfXzqKwyY/1iDuS
 V22xOHPdURX1sI6uZmJBx3X4iaa9AsqgfV7YgwZD9EkR4Huki/HllgK+AV04MnRu9For3dIe6LA
 MVSYf2tc3iiuteKk7VutEAELt48RajLCkm8AmW/2154CoVVTJWPk89AAQMnAWznHsyE377Pk4+G
 Qz2vLhA5x6VY/2Hr1V2nrtWGVHangBfAo8t+yUkB6fdObEiwViiaEE8Nlhm2hlswpG9poEZ7lh9
 2+m3W2ZTFk4NkYZvnr9AxqQM6wxS2dMoaEpvkXcUDyowcQRO/eWYY4KhAFBxODlkMd/E5kmNdV/
 5RA8zGJ5MNTE9dXEQuc
X-Authority-Info: v=2.4 cv=SYz6t/Ru c=1 sm=1 tr=0 ts=69531784 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=h5GvOLqLgfJ3vAEETv4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=879 adultscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290222
X-JNJ: AAAAAAABpJQanFl5y+kOZHG/UPcbxbka5hMigAbpRnMpiyLsHkLHvgjz3RNLH4+csh1AmPgsOF2TWCItinnhORnBd4cHrtdIkPr1xT4+KfXEKsUPRwjDJjtmR/vmhxVwBS67MRrGAIOg2V37PpA0WKY9UkEjJ3e/kedxkagJRyyw4VoTEjeZl/1jfNU+xqb1ps9F7XCLpS9A5xcFxBbMylVnVSrWvO7dmhT3rXncKjI4gV03z/PNnXocpphYBNdYsISr3HZi2lBgaMEpSBXwCxYoD6enENbzImrO/HKRqj2pO1b4HmrFDUGOFCfYLnq7ajRyXQi35v1CbaEC+5fFiza9Br+QhCDsGs2BSUuSIob8AvDMK3Mvsltiva3m7rP7nnyOiJFggxINMFBp+itQTsEt2aia7cXBoBuSByiAKApaGYPmb/bA0bH2TEaH7N3c9c+qzJG4QXvns1DJWwqYr7SBUktfrvrFsuVJPoMmq/qQZ96tF1RGycW1hLWJNtnNcVAVKellfhq4e8DUwGLmPQgRmVl44AHw6cTfoim4WrB1IFaK/h97OXEgZFh3XOaxrr9lQwbN/pBjg8Ae4cW8K1D0Il6W4mUbrOiBbROIuynNOz9gnw4kVV+OZReS/p7WaDZrj7GFetXwxSoTTKYfOsEPFzsc523XFyOPO+m2TTNKTgDYKx7GR6Ya0GhchTgT16wb6pGznWQq48RLR7BFV9PTksMo6DyMX0XCkYJK/MKTEBb7K7UYfWZHb5KUQFt2k1pvUOZIcOV6FXmbbhWfp4xZJzz4/CTKq9fez/OBhRaD339uOUXmy14AjwnLmLUEOWA0gjHzTrRatLShG8RtCXP+UbYpvRwGasxoMj3YCTyzTzw7O0ceT6dDjCF6Uzf00Y6HFAgZzTDW15qtE9o2/KkGrr0UOngSA+0RB+mAA0BdjHGcQb4O1ueZJbweDENnm75LEQ==
Received-SPF: pass client-ip=57.103.76.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
List-Id: <qemu-devel.nongnu.org>
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
index 9e872e5f56..802fa87765 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -94,6 +94,8 @@ void whpx_apic_get(APICCommonState *s);
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
         WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
         UINT32 BufferSizeInBytes)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 2e5ece45ea..0e80ef771c 100644
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


