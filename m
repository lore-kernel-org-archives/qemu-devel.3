Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3123F513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytdR-000195-8Y; Sat, 07 Mar 2026 10:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdP-00018b-Ol
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:08 -0500
Received: from p-west2-cluster5-host11-snip4-1.eps.apple.com ([57.103.71.4]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdO-0000Or-Bp
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:07 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 7F9A8180055A; Sat,  7 Mar 2026 15:32:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897525; x=1775489525;
 bh=eCZw8ecsKyAPOmb83e7ghwj/bQ3BfEAJzVmCsc2mLa8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=QkQasoBLSFYehyj1DDK5ChLm23doHJfmBVTieh0bnec8qjdcX6xLNFTLATMMrqI5imLSZs8NdaTolMtC9TlaAVwiQDQGQRNsikfxy9jJND3IUPBb/Ss/Ie0NzfGiVgA0yfNL8+//ZSdFN6xnWPESBxCKFnPDpiJmft1zIHoGXirVWRPqGFNLVmjQbC/Ds8t5YDyn+pqMqR+neQAm7FoaKnd/VJAFuWrxKRR7TL9xNX9INc8x1/jE33GR6e9+k/ymR43lqa8R4OfxtlLHsT+FGIjGTJQw8jL2ox6Bl/EscNS88GAv1/B3Ca/7BoE085ooRgPUl3kNzvmAPrzOsBU40A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 96CD91800168; Sat,  7 Mar 2026 15:32:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v18 06/13] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Sat,  7 Mar 2026 16:31:36 +0100
Message-ID: <20260307153143.76893-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gG0dO_id40BrLS-_rnOwFEZBcQqMsOnv
X-Proofpoint-ORIG-GUID: gG0dO_id40BrLS-_rnOwFEZBcQqMsOnv
X-Authority-Info-Out: v=2.4 cv=TZObdBQh c=1 sm=1 tr=0 ts=69ac44f4
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PzQS8Z__MZ2uSZov3vkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfXy5RH3+Oujl6W
 mykAAZssZwif6XRLYUFOEIBWA6vkvWJrhj1nUyItE91HjcMBy3q6E7oRl/4ipnA4tjeEjG2yNOG
 1DwwnyuOW8ifX/WO2clqEO/2eM+7oanTApBNgTkZ0RXrGphe4uFJBu0ZcfrU+rpaRHzn0I8c6Xf
 24zDwCM2O52h2kZmJIb69w8gmX3XoaIrMWeGtkgy4MxamctHuSjqY7e/38Z/wVuUdYtUqFR9Qu3
 rgWtj6lQKA1DRfuC6FNzRWg4RaCslepw5cq9G2mUDm6C6nlzpMZTPVV3gU3tQ7tav/+NJM0GtDT
 xq/6cqLlx2AZbg+lHwWeBE86d+Y1YWwgqwzuvok749iZLYmsCTBNIyfue5da98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=896 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAABa9P6uPeuMHpTDEpgow8d8XuXoNP+FOfwC9yJ66P99LheH8rcGdL9gRCag2St5JvvqBOy3RjhzsR+E+w4z/k/8s25ILRydK8s9p8LuRwErizWSrQ7MAS/j1q5gO6GoLedemmL9Zt3dHCM1TksjoQWekFZgrm+fxsoTtV1ZyqUIAXMWZfYcjsFj9+MoQkAKJu8ZEdcXROAjsKaBCDx1mZiJfxQ1+EIoj4QYGpMAqaKE7YA2kK5CqBMLm/okDupmR31y6wXCU0uX85h6OzcEEaljhT7Ad+OWKJwjvnNhQNJFhA0KtwuvOOso9EfkQOVj/WENuHKMY/3ZfzFh+ruFC/qT2M8wzx4AgqHPOoqqIKmcPbcvg3gO8u/S7dSk0YUOj9yixu+RxrSV27nQSnsCyXV4MFK3cVUVz5FhA/vVmC9njAdr75uqD39wSkAVv71x6UBC890Qb9CwguDoP3EkcE9WEAXH7+RbvCJNPGkNygsUwtO6txVhtt8XFqkMC4nAF7ltUXmzw9W2ItXnP71vhcCfwpF4wNHvH1khaZ7gpwGR692qDLUK6eWJ3JoznDkAiS2WmGl+WHzFq+PGOvwpd5WlBOX49q1uJzsW0XgWAi2Z+eipVk5WoN2Y9cvnqOm8aOtRb8dxcXyPdkCmg8oHmIJR59Cx6ldVdIVNlT4HzyplWYiuBspVmsLZ05LFvvZgqZPbnY6XyZ1fRhxI2LSYgMtJ7nzWL9S11qgq/OJEiInvohVHAaL0DyuZ9dQkEWKpzxRBB18Aw==
Received-SPF: pass client-ip=57.103.71.4;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d6ef4488fa..04c4106a3e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2368,7 +2368,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
     switch (exit->reason) {
     case HV_EXIT_REASON_EXCEPTION:
-        hvf_sync_vtimer(cpu);
+        if (!hvf_irqchip_in_kernel()) {
+            hvf_sync_vtimer(cpu);
+        }
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
-- 
2.50.1 (Apple Git-155)


