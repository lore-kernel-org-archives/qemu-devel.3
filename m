Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339B6F55105
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywF6-0005Gz-TX; Sat, 07 Mar 2026 13:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF5-0005FZ-10
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:11 -0500
Received: from qs-2004b-snip4-5.eps.apple.com ([57.103.84.18]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF3-0005Oy-I3
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:10 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 ABD521800108; Sat,  7 Mar 2026 18:19:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907548; x=1775499548;
 bh=yWjafZ03qoa8K6aHIxNQpbKVyqmuGjHcqx92A0qwutY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fJW1sVScyULHjZ/O+HnoTZfiZtkj1Ikh5oTulUVVpdHJKVvJqo3BIbd0vxZgzdy3t5i++y08QAuX6lXui1SvrG5gICFwu7fijY0PxXeQA/nLnbysi5+QKmpQcYAcWNHjQCnvC+CWUoNBh8IP9QlwsaBgFMKXuMBViq0voKorAHdmEQ+Vsd4ZEEjq3PZl9nPp3iw4ErGczLc7ME7IBn3kvWtkX4p6DZeehV8CZglpGAeJS4r5mAmnitroRB/TJaMyK8bFEaU9WjZvurOD/glYYQvFjA6yt/XLDyNzimWWR71FsLJDHAKJ/LmeW3SOtERWSU31Z/8nuR9y/zRBuIGYXQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 C226D1800130; Sat,  7 Mar 2026 18:19:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 4/9] whpx: i386: do not enable nested virt when
 kernel-irqchip=off
Date: Sat,  7 Mar 2026 19:18:51 +0100
Message-ID: <20260307181856.2209-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Sm9vfYyPp4-ec3RicGpXkzCFUHmGXTF_
X-Authority-Info-Out: v=2.4 cv=cbXfb3DM c=1 sm=1 tr=0 ts=69ac6c1c
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=eKpLbWQDCUPTAuIwU-0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfX5P7eVL5U/UsQ
 k5eLrUfemoWYwwVJlmdxPjw91B/pNHjFsolJXo0BN/kxTY9krQ7mw5JvV9LGO8YmXJFGyNEEZ9w
 652XQca/n7uJ0EhkmIOUxONNERu8m9Wi+Al4BsP/F0uiBh2eBPrm7elznaAhXTDEiUP7sHPKKvf
 5XElES1LEkc0UKnCi8kG6sWAcCUTUwVL6tvr8pDAI6boZqfODDFk9Q3dbVqA7aAt0Y8o4AbY7IX
 r1F3HRPxPb/U0wJQcLkOi9gZAnu1/BG4tNXDfqG2aJHlwElKw9COvN9Y633OIOI0YEDHgoND49m
 vgYcl5mDByYCt8oyqPQktMbYewJZqIs1tecF/Em4GQN0BOvbXkR4skO0eyU/ac=
X-Proofpoint-GUID: Sm9vfYyPp4-ec3RicGpXkzCFUHmGXTF_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0
 mlxlogscore=942 mlxscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABw2ECQ5Zr4xtiWsqMYs94oNr6Dz0Q9LvuRxtuI3jQyLGlIMKFzmIGfE5QwB4uDjkdQHvBM6XQQD/AS8cYElyElcxpGCivCQb+/pBvYVGAccdI78DviT/Xrj2G9Hc53qBloOqVoY6QVtgRjkaCDx4HrPiA5I53BJRlzYPMMWdU3dbQKIc7R2sEYwFbjaNKKZ57/z1Y20J/0OOJIoqDyIYRNG6/7zld/jZF20i0aEuYSdMxWDoboxfGCmlxK4q1vPNkZD+L6HfOpS+xr1RrBl48SVefPzN/KYC+5b6NygWvhjXE7Im72KxQ7QjbDJ5NuEeESZAGMf9DQONDbdwtugYk9HpTMB35IW1eK0paEpjBcy5oogOpf8kkhqp5uy3lwys9x9AHggNtNFu+wBM0LIp5Ufjb7gN+sTrhB1csPGeCQCRKMG+tcpT2pHBL0aSQoSyXaVInyXmaEycexujFQOOvaw+kZct8atjiYxRJtd8LSs7OUeLgmveLxe/PSEVjwG4U2HnTp43drPn4iyb73WaIuARaqZs62DNdySZ0v6jKmZ7qZDjkGeervxPdmdYMCw64EgPItgZwRTnYmXw/8gF8Neq4ExkBdIjUKlrSKf7EHJwbVw/F0c/7BHVWKvd+0E1xj/c1Te9xj3NsZoUt83zKOtdvgkvs6LKYo+TqbQZMjof6Q9cL6qDyMVqIJjsec5QyuPpYaamubaQDT9xE7RF1hXuDUBvQCK0HSV8RKZTjOhHTGT75y0HbIRF7LiD+7MEek4TRog9e/2wSYm7nZvbu+3KBGh7Q5Igt6oRH
Received-SPF: pass client-ip=57.103.84.18;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

This combination is not allowed as of build 26300.7939 and results in:

qemu-system-x86_64.exe: WHPX: Failed to setup partition, hr=c0350005
qemu-system-x86_64.exe: failed to initialize whpx: Invalid argument

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c172e86886..9c60295d55 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2160,7 +2160,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (processor_features.Bank1.NestedVirtSupport) {
+    if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
         hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.50.1 (Apple Git-155)


