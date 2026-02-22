Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDEAC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnW-0008Va-Eh; Sun, 22 Feb 2026 13:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnM-0008R0-Uc
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:05 -0500
Received: from qs-2007i-snip4-5.eps.apple.com ([57.103.84.216]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnL-0000Pk-Id
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:04 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 EA42418004D1; Sun, 22 Feb 2026 18:02:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783381; x=1774375381;
 bh=mfxct9QuL+ifLWFIShtfDThHLnEEVf+FJyNrc4eM18s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fIDstVwS2fk1OH4UyvdG0y3Bi6T07fTyXiLQyduKgiGvYl9iTalTxQJLLZwlh/QYnW5b5/m4bB1p9vvqKOJrB3kY+7gCdWa70AkKQQ/7BHWtAsR8A8cvkBt5pihcrqh/HeSJT6C4NNrnvO7S8uIt/iXzL1wBIItM/j5wMzUwQAyz4Rz85Ghovyz/PMwCmuXishJ4EfWh3O9TKTavy9St5nEjzdjzPxASq18569Bg4UQ3zXFJ6oQImP7Q2BTavtv7pEikCtZgWCiL9/yi4egNFEJ1piP1hr8063WQbl9tNclj+iTcHACFUhogFpAClM/rzGIVtgjCGaAA3J7y4QJXIg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 83AF118004DD; Sun, 22 Feb 2026 18:02:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 07/16] whpx: preparatory changes before switching over from
 winhvemulation
Date: Sun, 22 Feb 2026 19:02:31 +0100
Message-ID: <20260222180241.14621-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfXxMyTubBn0QuD
 TvgP6xB6JHdNhjemQcrkGDBDsi79JQnDFjUNCJWJtuheTpu37cE8TyF0QRYwDVz0Dz+47dK3wEy
 yTr6LXVsMBFdgKcnxEJ9MPLZzoDEc9u1R2flQiBQWgieBNsjkFHtK75up6Za+piGhuDcVxMRnnM
 TjHC+GvpuM9a/RM1wEBFYwfF1Z/I1hLwDyXKG/lqFkRHUhgLm08a5/bcRxTQOwlhTH5+ZBJqriR
 PzXP93g7o9R9Prl6rpPCV27HUwGLCRkGuD0C6Cyk+ZkfkztwvdTFJp6d5m+wKuci9CUlYKfHNJ6
 n1wV8a+VzH7IOtoGBUo7nJJbNeMmDwz3+wYzXMnXHi+s5XhgFTfCYiJrTDIFE0=
X-Proofpoint-ORIG-GUID: k2eEcyaTMW1kiRG9gDgJWYsiyN_Ij4qu
X-Proofpoint-GUID: k2eEcyaTMW1kiRG9gDgJWYsiyN_Ij4qu
X-Authority-Info-Out: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=699b44d5
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=qtJoQR36IQ-qKrO0xoYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=941 mlxscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABOx4hcPqrYOy1S7qGzJ/dmmwmF/VR8sIkgKWATvryXmE1OpUK4Y9aoybXhDF/C19v4aIwjNByAhF+FrEJ/aAjtSfwDLnGhbLVlKu4XzL0VRGwKiPcBp/Dz/3coRxeuddPU0l1R0hjeR0vRgr90OEhyloEjfBR1k8c0PgZWuY8599ctC7GuMAb/xSHyZL407U3Wj2vN9UH3E+J7X5u2MufcO+FEdSC0AvUhsT5LA7XaYjzaZe+LO2CuznRv63mvrGpcOgOpXx4KA5bZO2lqpQ7HeU34FQW4lWsIeCiOxBu1qBpNsURiQjL0n+aBBADOO7fZ+ohk4rV0QHGHvdd5W2lr1wssOIT5yn4CXsELtiXfGxXvQEVDcM2MQW+wPL0TwSSwPZ71n2nx1M2CRFZJryKQ5qN8iaXZDIVnGGXpGuPEr4l/QDF1q7RbLYPZ9opI/rWrlDXw6dZY9zVszGYT9tdeOnPhP6N9oD8iLzqL1ZaQttGj03zkCui4gVDdam6jRZkmMje35mPfT1bvW26GShqwO6a7/yIvP3LchzvC5zDGoxuztWmBvZAmSOuLIdsowYJVoYiT97Fcf6/HQO/yz+0PPD7ht4mQl8/oOiZ0bSuQ0LHXrgen6sFi2rqhNq+w7z1jo89PNj9TIMTKVkQ7CzObF2DHkWhgf8ErwljsPFLomXExs53LRiP5jvIIqbH9CYZVhQSABDp4FvXWglGIPt1kJ/FhwaJYAgi0/FpCEB+3oOZ/cDbeyrHmu+sU+izZc15fMZBLezB62laB11o2gjgBMSxKzONhkwNlElZKX2vQIF4
Received-SPF: pass client-ip=57.103.84.216;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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
---
 target/i386/cpu.h               | 2 +-
 target/i386/emulate/meson.build | 1 +
 target/i386/mshv/meson.build    | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9f222a0c9f..065613722f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2286,7 +2286,7 @@ typedef struct CPUArchState {
     QEMUTimer *xen_periodic_timer;
     QemuMutex xen_timers_lock;
 #endif
-#if defined(CONFIG_HVF) || defined(CONFIG_MSHV)
+#if defined(CONFIG_HVF) || defined(CONFIG_MSHV) || defined(CONFIG_WHPX)
     void *emu_mmio_buf;
 #endif
 
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index dd047c424a..1bb3516249 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -7,3 +7,4 @@ emulator_files = files(
 
 i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
 i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_files)
+i386_system_ss.add(when: 'CONFIG_WHPX', if_true: emulator_files)
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 647e5dafb7..3fadd4598a 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -6,3 +6,7 @@ i386_mshv_ss.add(files(
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
+
+i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
+  'x86.c',
+))
-- 
2.50.1 (Apple Git-155)


