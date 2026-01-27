Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24340D2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknrG-0000RE-TO; Tue, 27 Jan 2026 13:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknoQ-00022u-3c
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:25 -0500
Received: from p-west2-cluster1-host6-snip4-10.eps.apple.com ([57.103.68.63]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknoL-0003Yh-Q1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:12 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 E61C91800260; Tue, 27 Jan 2026 18:29:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538548; x=1772130548;
 bh=c9xkU5JKUppgK3M6NvIGvHRbHv9MZvro5B1lYG+DJ2Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ze6I/zai4Bwt3qsbWrUfDuoMM6GlFK0jBQG4pahZEA2G3Mg52h9hHy9L0EON4ike1qFM5lTxNYWHFkzguaUg2nanvwfruwenaAhqZ+AB1qqONIbIwiXrzZe80eHmSvORptSpOIGSi4yElC4WO02i6h/QHIbdn2coEfx3IiwNwtFTW5UExlOlg32FZG+6q6YY/Ysl2m3jddcIf+hBP8S2iC+85LjOMOAhVSR33GPzkmWBN6SAd0NMZ7LchJSKrIjdYHFtgmr/KGHiPMcAq6T1uDKsrl888qEf0mUoOnxRXcBj3RsFT0fHa+vWKonsIKbOGSpke1yQeCXAX+E7L5ftMw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 08DD018001E9; Tue, 27 Jan 2026 18:28:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 11/22] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Tue, 27 Jan 2026 19:27:51 +0100
Message-ID: <20260127182805.73212-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SCxStP9zBChahjV9Odw3Gm95lp8Zg2QL
X-Authority-Info-Out: v=2.4 cv=GMoF0+NK c=1 sm=1 tr=0 ts=697903f2
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX7V0TDuc7PdyO
 DXBkGJOwhwwi7jw2wM/K41TF0CHXtRgb1MWMUuIPmYuoEDF6TwCnzps2YEmMcZJ3M1ouA/SzLVl
 oNWM3iK2eYN1wlNykGdo8DOR9rqgbhm41SmTHv7BkyAPGM4ueB0QTt/ryrF/14ex7fxjgxuIqDF
 x6CezPq0/ZAYRHMkI12Y+fxJv5rnjhimU4OCPgmmVAqlg/MRRQo+Qo3Vrbbj7K9hpMmr4/bSK4g
 w+Gu+P15VkQrTgfUaKDRkUDOrlEGF/sbl5lVYJE4inyo5OMGTUGda/xZ3hpFdOurL4QWxR3l6M5
 aHPULYdM43+bmFNKASvleubY4/BB5IKDn1D3WbypvF3NZKvGWkrtb4MkCQzjp4=
X-Proofpoint-ORIG-GUID: SCxStP9zBChahjV9Odw3Gm95lp8Zg2QL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAABSHoa0zhsEjAvfAyCkkdwAJfPeiM1ISFshHZx0HGPmBvo2gT7kfqNDCKJmvpOjTTSakqL9OgGXMUCg222ombx+OMeNkFf41mZHfoxl6f9RLYc8OOZeJ36AHc2Y8b7e3tSU3TTv77XCjaMWhjvlUKYGEOd5IRUybl30VZnVlO3F+cyOeAXDQgXmvbiFwJFIe+d0SAcV1mvv5gCye1hhtSl3yS1kePeJ3CsB7L71iR1HfoJ59yHFBAKDiCHM1e9iMDu9o1jIYDWNR3wLEhUKfLKDfItoeJRFdzkcYhxkKPGyUa35RkGGfHVml9NzYcv4oBIvho/BcPDfgkJVdKzBMdS/HxVxcABhaZf9h38HLlvGPw6ICw9GJwzVw4qBS7qZ6KN+IqljrfdwQwadXwaGIhCAQ4gTR42oZqujKx3xxCks+yOggAUf1qdusqa+rtMOVmfRZGURoP/juElH+LYzsmPhR/QTcgOMPpu2JZTr+xLOFa17xe1Jq38VtI+3D7f7m2GROXKNYUimsMnspHQOYxbtWgWFWEb9kMWjZ3XCcpOBUEC5FbgWryAcq3Gl8Gl2rUVK4a/a58lz0rDphYQx+k47cy/4Eld468mg189OR0+lQW0jX+IZ0Kdid2cpLZVf9EcIxSMzpvj0cKBJ0r+VeY9kqefruPISNo3B930L+JZnlL9NfvjvRPoKLQ789bg9TayGVdQslBaT5RyJ5L08/ji+U2BUnv3hnqFCF/kaEpKWeyvvrS9Om+Tp3vjMCruawOqIKtIeQsgt7i280mv2syQhcMeI6AbnwG0QMkBQ9NX3jIg2ir27BNm57gg7iDV2p3+TNHjdABKzkow650zlUvtpt5tpeDyPUHyldlgGXRMJPrNp+K6nl2WfZqy/ogfxkTqc0r0VLWAuX58minakPKmRC6M0mTVLElCETEypK14Uxd4+eX/RIloeCgB/w==
Received-SPF: pass client-ip=57.103.68.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


