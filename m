Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C898ACFA76E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO1l-0006gu-VG; Fri, 21 Nov 2025 05:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMO01-0004zp-K6
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:18 -0500
Received: from p-east3-cluster4-host5-snip4-10.eps.apple.com ([57.103.84.53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzk-000804-Ai
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 5195A180110F; Fri, 21 Nov 2025 10:03:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=eAmoCvdmeUH7RDmyttUu0uqfe08uF7aiATJn5hX18FU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NCnoXYcYxZXbghqQLdUtT62ABCceVENngIoGJYBi57G4bwdfJjSwyLGmISenXVseesV9Lax13oVwwuVqH0deV2H0idus3EUOUY8/Kf54UUlb5UV3h/iCg41iZhy4arFt58ExTKE4I1tJZYbpKvzOhqZT0dpHuo47KZbQ/sX005Zu5rg7a5zguZBPiPpATlrbC+AV8XxhgIkgQZDFmspVZAcdiUsAXdV1SA+msQWHlGAA/1K1yRc88he2iS2jlF8YX4Sy15/2uINR6hwuNP0NkgAoVlHcjT4AckQ4NEf2h38/9N/xktCoNqyp0EPjW1r5I5T1xQeyD8HCu+lvPz1Fkg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 23C661801111; Fri, 21 Nov 2025 10:03:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 28/28] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Fri, 21 Nov 2025 11:02:40 +0100
Message-ID: <20251121100240.89117-29-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfXywWNvmXxSQie
 Vb6qBCV5VNEEOMxXUNP3BAqC+Rln+EVI6MLBtG7pY0C8RuSc09LnRoTvrKG6VR44FP+BIiBEwEQ
 VSWUA+gwKyvqQYEExoeqArHUYTlt4ouFmpxOIdamqmvTLbBBM6/je6W4gV81PeJpI8nUAckOzoV
 b3jJ5nmWV4SwKF7WXnow4VRWujoGAPzNqf2eZay4jDXRx6MU1Cr//NTWVEdG1/N2fsxxvFvGLju
 mF2QqPydlRaUzk3QKJ+zlg6cYpOUE/fdoLoHkKaLKg5c7ngqA8MsCatH7z77RQ7elvRt4OYGu6J
 EtMos0rECB3jsfB1nPS
X-Authority-Info: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=692038f6 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=h5GvOLqLgfJ3vAEETv4A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-GUID: Xfz9P3z8f4Z0h6Ci4Xbytf1YW6m3ApBB
X-Proofpoint-ORIG-GUID: Xfz9P3z8f4Z0h6Ci4Xbytf1YW6m3ApBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=775
 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABvleb1oXAyC1D+VJ43Z+yUJUoejr417KljzLJD+y08KtXzFNwFdH3xQrhvD1wzBMvNdiU+nh5GeXW6XJTMpjOQwWI5wxFV8YvoMiQrPIjdaAmWgAvUP5pwHwsFBq9lqqjcC715lPRbwY5lW4XP7hfrBPGXi5Czam7vxxH+F0wsi7qT1HSLfMoT1VAbPrJRf9FVvpPE/yMbPv3IRwx7M3W9xxED2623PZc/tiaoC2MhBEUZKNHgJAqJHWHBCfG6DuPoM8Rrk5i0cshDyGmxycmZHaSULFvx4VAWpzUvgGqfk1uTUsJCOzyORshGc4ltUL5Lqk3CgK3h7b5Et5kyHBgNpktYeyEgfKZuc+An5zeBpcoUnCS+RXHbKFZwI1dLZEB3Q+TTrqAb78aiuQmtdYMatjKZEAToj9y2iuGK0ndT5ivH6/f/xiPB3YSmi7QC/ZG1OCEa3ybpSdoQaUKgpMRF6BT7d7xCSBMETq4u2kqyhlhfaHIPFRDYND0eY9CgZcE92bIo6C6tJKtdiVuwRGHskwLT+SYoLEOfMe71MOIKw33r+jJukfdJjZzTESBESR2QnCvcMS+BMy53DuHA72I2NLrXXcugl7lvQ7FPUsTcGQrDByDap+gRnP7w2PHa3PUtbJXDjEmu8ogkTq2qb+O4B/dSvj6RJMYJOV4nosLWzFqBjxWK68AlxPvNpSAFSGo6Pi9wNwG52A9rz/TEOvC2GzXa/1xMB2XzeKgCzrzw5c=
Received-SPF: pass client-ip=57.103.84.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 include/system/whpx-internal.h | 2 ++
 target/arm/whpx/whpx-all.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 0de6568ec2..248057e7b6 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -93,6 +93,8 @@ void whpx_apic_get(APICCommonState *s);
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
         WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
         UINT32 BufferSizeInBytes)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 4c8db22e8a..c40c153c2b 100644
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


