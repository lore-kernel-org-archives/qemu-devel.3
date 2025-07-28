Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B3EC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGtM-0001Eg-0h; Mon, 28 Jul 2025 01:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGre-0007LZ-HB
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:39 -0400
Received: from p-east3-cluster2-host12-snip4-10.eps.apple.com ([57.103.87.251]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrb-0007GL-Kn
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:34 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 415D71800155; Mon, 28 Jul 2025 05:57:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+I0eS72KXDJ7+FwHhj/Ya3f5pWsr6GfQlGxIXf2fQwQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=BWWcUbf+sGAbVsTGuGEP0nIOMjKtHT1UpS4AgCaY0wvR0c4RTk/nTDhEaM552zzYeKYaOVSWiMv3/M+J7XH+hhlBqG1gTpSBZcsBDpSdBCTxMHClK+nHflAXHWme4BAuaLLEf80yZc6hb7+VyKPByHAirPLww4idFGhfAeV7lsBIrzL85juYmvHHzV9VYaclB+OL2DPAMzerGm0u3DgOkN39wQMVO0OItqZHwWxD723eAGVokI+xoJMbnOvokD2Eh05Z/bOKFllvcZf5uUpZ330JHeN+qmWdMRXYZ0UjZjWs7vHkH68ynqNYYKwhbrQHwQ95R0ZYrlNaFqjU/AJrGg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 ACAB418000AA; Mon, 28 Jul 2025 05:57:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 11/15] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Mon, 28 Jul 2025 07:56:57 +0200
Message-Id: <20250728055701.38975-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728055701.38975-1-mohamed@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfX24jx4lGQZ/t5
 Q8HxcvCZ392hwf6nnHnsAb+0Ut1RhO1eQ7dJJtINyW+5Rp7EvXdwLnU5o3BdWZu53DlQlnLWUvD
 cEQ9+oukqArPJuNDstk35SCY1baAH8UJ82eQ2REepJcdytve8myq0DEMajihPrIxie71ufDmAFB
 U6q1GMUWg7RSFknS8Z6z/QgKhjy9JhiUQer4S5rTa+SW4h7VjtSmgPfhZT84ktQx20pb4FKwp7F
 xTsHIg91aLSjtohTe+dW8omhTGDNG563UmLH9sXA5sTu4125KbNCC3tPFQ9QlOvfRECXBQ92Y=
X-Proofpoint-GUID: F-ojjvsQmN_XwIwEbHaK64NV6kKvFFkz
X-Proofpoint-ORIG-GUID: F-ojjvsQmN_XwIwEbHaK64NV6kKvFFkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1030 mlxlogscore=890 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.87.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f17fb0695a..afe09a216e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2047,7 +2047,8 @@ int hvf_vcpu_exec(CPUState *cpu)
         g_assert_not_reached();
     }
 
-    hvf_sync_vtimer(cpu);
+    if (!hvf_irqchip_in_kernel())
+        hvf_sync_vtimer(cpu);
 
     switch (ec) {
     case EC_SOFTWARESTEP: {
-- 
2.39.5 (Apple Git-154)


