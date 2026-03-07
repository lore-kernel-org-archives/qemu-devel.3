Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491FAF513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytmP-0000ll-UO; Sat, 07 Mar 2026 10:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmN-0000j3-69
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:23 -0500
Received: from qs-2004e-snip4-11.eps.apple.com ([57.103.84.53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmK-0001vn-V0
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:22 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 8C2251800ABE; Sat,  7 Mar 2026 15:41:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898080; x=1775490080;
 bh=yWjafZ03qoa8K6aHIxNQpbKVyqmuGjHcqx92A0qwutY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JTVnUUxmGBxvUBTj5cKFn22dAukErQiTXQBnauf6EANwS1yjsZdn+kAvnVktgiav7O7UO1uKi39ZKZ5OjNl3gJ2lyAAfS7hyEPCEmIwMLV5fym9LT7Eeq07bA/BYzj+ejACiVEXIeP271rln4qpbOP/hvzC9ZUB5UHXDOjM/N/rb0lQvHFCVk7TZ5IyLh1634nl50AEA89vYhqAv6uPVy2CZe2ZxqP+khiXAlkGdcYD5DLx6DeqRrfW8qfsiQFo128rBW4paKV2DKc8aTAiNgyEOlZ89OJRyCSk0/ZZPOiy4XsN/YqOkmFGVygmhefQie8FyVKiJ3DS6OPASkpesig==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 E4CAC1800AB8; Sat,  7 Mar 2026 15:41:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 4/9] whpx: i386: do not enable nested virt when
 kernel-irqchip=off
Date: Sat,  7 Mar 2026 16:40:59 +0100
Message-ID: <20260307154104.84567-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cxsBDsXAtHxL4iMZduF_SEGx_rEsCjNx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfX07Wb6XH5JVMo
 AYBsIvdctHd+cbBxYLaNz+tbpPUKDDnMad1WdjfAJOrdFUIG/l2lSvvDmxal4Ju5rbznFykNpFK
 NZcmXkN4RIhhcJKdaPcY73CkCX6lRYyBxmRnQc5gQoTcSMDoc0pVkEirrOzXxHMyhASoVspbWSM
 dZjrSUzZJWxjaNujniO8vy3Dc3dOoWvKxx1OSHPdymyuTwoveGI1CYO5PtWuU+zAY4q3ySljm96
 eQhCcKiIhhYvo5gAZh8/ft8RwYKGbF7QIXMQ04JItC/1shbBmDxyEb5MBS3X7eR0qr/Ip7tVEAG
 KQM9gBTmZOnfg5+b5iUkXCUyvQKXLThsn80pNbnpbn8jJ8XTBawfqJLKUx3cxU=
X-Authority-Info-Out: v=2.4 cv=SPhPlevH c=1 sm=1 tr=0 ts=69ac471e
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=eKpLbWQDCUPTAuIwU-0A:9
X-Proofpoint-GUID: cxsBDsXAtHxL4iMZduF_SEGx_rEsCjNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1030 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=942 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAAB0f/ExbjT18k556woQFpY2drdhTqZn5JEEH0s/ddQihxHgzZdgwl1sIg+hmxPqeOGvOToKY+FOpAdVWR9dzgTZUX927d4zQSNJDrS7DZkGnfz1BMyH7KIaooxpzdl+hIVfqCmDBmG50YBMABrx+aFztVttC8tT8/JRyL2GLkqFgXVtu5Bz58zdC8xw8MQRDGUulSp435bodxu0fh6VU2SK2FHQYzv2EX2gsEMjd6D5BPnIkBNJeNnonoZp+GOxy0qMoXSrmKYP5eMG8Ye0jKJ4OW8QQcHR3Htgk2ETMFwrXC4p5L4kEBZFeM17+Jt8qZ9vkEGgkMnjn7yC2p/EIsek0BBE4vyGGIgHRFRnDBl/FSoNInNm4NatbvwJ61+hY9xCBGOAPWfAHmK1XZGUIndxbIL/qgtnTY6vudsN1eO3XcgRS6GV3YflRH5ArF7WomSJdHBd5CdzKqhHQzqKQxwzN2qVZEVDTlq8lz6POe5GNZskYN5+J8KL0Dwut9BwEethOisGAGhpqHsezYCv7MldDjbsTHds50Y+epLuM2RdR/Jdv7fOjdmqdrPNqR1VC428bAUt8wpeBqNbDB1Eo9SOuKSAPiDQYeqm0B0KrO9oDiIpdvvdPzS3iPnuQz6SiTjnJiwVVGM0AncUUhWY1UJXpzDqfNP17KOeC3WZNxMK/JjPnch5DR37VvJZzVGD4d4fErgc497Wu0OJGJANEWtvbufdIOIrNbw/PDvBhDHST83pBq5cDnwGN7MeQXxVxEiyMUQVkqBXZ8FzhX+TztxjweeIwdEn69KaDfUQccWl7V0+IRz6Q==
Received-SPF: pass client-ip=57.103.84.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


