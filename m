Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A4BD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0ek-0002p4-NL; Sun, 28 Dec 2025 18:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0ea-0002c3-RR
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:30 -0500
Received: from p-west1-cluster3-host1-snip4-6.eps.apple.com ([57.103.66.119]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0eZ-0007U6-5P
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:28 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 22ED91800754; Sun, 28 Dec 2025 23:58:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=L7mT2nD+Ba0e7wIL0PqN3n0dkcKAmO0tlq8DUQcg4f8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GTQ8V6ndVUzUrSiGyLws8UAnMMl58UJC+Ze8/aSifDruSX84u49YTwlCWQ8r9MsUr+kmDHE3RXGhvBaW5PNtr1If/W2KMm5WdpCoJAa9HTx4CkAHubNxgRlofP80724yBKeeWxuyAxypwXgFGot5OoecuEsVLbUOnDIdcbekOr0GqCkUqnWbDYAPrXxRHkI2CExiOeQq1GK/430V6JaaBEH8SiQtxj2Uv/JuO1U84txsrnHqdAnzcJLHCgC9Y9tZfKOI0SYW7212O6A//4HK8iieGWakg+n6r93dmJ8i/bLDIIyIfV3iSiMse40K9Waq4VUdkTtDbp1SvYwOoVSwyg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 2A9A11800756; Sun, 28 Dec 2025 23:58:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v12 27/28] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Mon, 29 Dec 2025 00:54:21 +0100
Message-ID: <20251228235422.30383-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KPGogu3uV69M0IsFu5oeu1r1YuBd0nfe
X-Authority-Info: v=2.4 cv=CtOys34D c=1 sm=1 tr=0 ts=6951c420 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=h5GvOLqLgfJ3vAEETv4A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-GUID: KPGogu3uV69M0IsFu5oeu1r1YuBd0nfe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX9m0KKcefk9NP
 E+ec3UdtAYe8dx20IV2y+aQmpLPrfgqKeR0pm5jvIBTKUYk3qexQ8jh6ICBa9YXr5tRh++xtmb0
 y37Ppv8YCHmW1Xm+VfQM9rf/bfRSmTAHRD+KUeW91sEwGK3FSUUIWIPVzSaZykiXF0s8t2Cfywy
 ItUnrwlFVBoZO6CQt3EXrlmeBDxRMYbnFcK3FvyO2Tl2DR2xugA+1VDg9J4AAOE7rS+HTWpOonE
 ZRppL95gVLhGuR14ENIIuVNbRc3C0BS/rvzoVFSVTgbmV9bhXmVGCQLda7e13i6M2ZB6ZJC8AiO
 sjarmlwJ4qjG30Xq+Cv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=883 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABYC9Pt62b4I1ZKDRcZql1avM8R/AM7rMiTQRLB2KPV3Db7n/ZDmAlB78DDj8xUTUANSMBNi/RvyqwZmokoM3Z8vqjN5mFOwZPo64tFN6EzAZDImPS/VAE9VnqsMtwUPil+K3lwK4Uxz6uCBaUNhH7Yym4DyigERoPcZx16gmbn6QlyVS7AnNKfVt6AP7sbWW7xfXb/VmfA2PaxtA3LGErjBMZYchZO3iEhblJ9CPi+o+DJCFZFzs4M3i2e5ANbVTSBskXZX/rDzyuey30JiV8hH1dAMgKSnhDtLZ9lkwClQJNIhSwlF0/Un9BJxIQ+Rc5KDP0Nt6+FPzUe47rsiSV2mE8GqOr/7eOg11t1SB3x1WCzw9YdK3uOS1yBV0aWm0mRRwC7jlQ6q3vpuJU8cpIYENopGEinl7kW5CJz6wh/VaatnZwoj9jl6RHOv2xvSJItnhpF4iERFlO01jqtQ08bowLxefco7nxi0CVV8Ci9BjXSXVGHHhe9elUuMQSDdUgLuQWkSfXlc/jcEiWNlnxR17QW0UYaxxvAG3qAxYEtNcXvFjXcohRQ/YPsMoQQ+f7x8xIL9YZJsLO6vdBUDZDQ5di+nzqo4CBcfSFzVbfw9KkeYWi5y1cYv6jIgOZ96FH5TB7lPN/h94u7ik9G5z1RXZMSoBNW5eJOphqBLvt2AEnbULdWsTlvqI3jYWov6bkId8G3HaFMJ++JKGf4VQeHgroP47CNkchPk4Xd/qjkEO+0C/Uv9DcBODhyrtLyxVhtumASgWRIHlU5BRXl6YER+6OsuKK8jhPX5Eq7067X+1SK0b24yMuhs7K2RFbccY7UDSHLeUcdMDzZ4Y0/HI2Io+A11L7IPV6NxpY2TC5kI4FQhItkunJTW6TkjEMPMhsKYjoX1PEXlgmuBv2lIU2gkEWZuw9T9EIlfQjtmPD58mklT09EzRiEdt34cw/COJ1
Received-SPF: pass client-ip=57.103.66.119;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


