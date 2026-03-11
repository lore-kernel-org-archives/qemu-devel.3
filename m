Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA2C112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LEz-0001V8-Cp; Wed, 11 Mar 2026 11:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCn-0003Oi-Mm
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:40 -0400
Received: from p-west2-cluster6-host4-snip4-2.eps.apple.com ([57.103.70.15]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCl-00067n-QX
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:37 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 522F31801B7D; Wed, 11 Mar 2026 15:10:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773241834; x=1775833834;
 bh=MhnkV5c/dOH7V/+SH0BEkMY4F6uembWguGSpYqFssOw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TtIX8DhrEiaEBviC8XpEYhvRHN2mMMeIVvWZH0TCbXLsf+Ly0Tdx0hdnSjv3FL8QsW9HQC/fyf3Gp2hhBYRhd3poANEFAMVyiWzC2Z+LiG4MD5ql+NaEVSnb8tK3GsE6ftzWHn3LzdR7YYEdTI/xWT1goAnia4GYuMmJYH9tBMd342d8BLB9Ercyeq/zCuGYpnHOA1/nH6ngl4BfBA82vKqlLo3SHS+t9eTdIVFSfvrz5W7uP339rSf56dfHz89T3Jg8aYE+j39LuyMn68C8D8KBNGjf34tXSeTX7dF895iwaxmJZCC9Z2EnwOJfSaFAUmgUAIpgeRdjHbqnuikciw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 1CB9118015F5; Wed, 11 Mar 2026 15:10:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 1/5] whpx: arm: fix -cpu host
Date: Wed, 11 Mar 2026 16:10:10 +0100
Message-ID: <20260311151014.55915-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311151014.55915-1-mohamed@unpredictable.fr>
References: <20260311151014.55915-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: N1dWNxlakdOa5Ye1CvQc4y4H_AF4W9FP
X-Authority-Info-Out: v=2.4 cv=RJO+3oi+ c=1 sm=1 tr=0 ts=69b185e9
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XosdkutOKJZ40ZxHwN4A:9
X-Proofpoint-ORIG-GUID: N1dWNxlakdOa5Ye1CvQc4y4H_AF4W9FP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyOCBTYWx0ZWRfX7Wcs15bYTezi
 4Ujm2ZpkSRsid/zVX/tCicC1n+Of7S3vmxgKypmm0KQFFduS+MXS8y8K3etV91OkijlhX8+eZTz
 PtQx7gC436xIS4WS6DR10qAxLO1DtdQPuk54Mi5SYBz3WZ/C3bQpV9+Y2gDxYxfRjHd52l5XRYT
 Ur/HOQZPWbu2cXg3qEcTr6/9rF4Q4cHrsXn5lm35P0H+oAjY3wKQ42m3n5FMIXcGIC5gKv+F8E3
 cGLcb5dl8Hia8jewTYikDYU+k3YZTv3m/q81n+8rySztUDe97P9VfAP3v4WSyjwZUk35ITn5+Ap
 7mWhJsGCfLOzgifrqw0B8DaFlFo8n+oG9z9/hK484W+vFqyFT8iPXy4ejKznXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 mlxlogscore=909 suspectscore=0
 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110128
X-JNJ: AAAAAAABFkdV9oYQyTg8xUkE8h4uQ/lupJXI0w/zpS+TsR2Og0ZKjYF6iLOPJzXcWQp1MGLkGIMimfXjMfkwNp39cHnS+n8lSr3gVWYYyFpiwbS0Gb+U2A7WC8DIky/6JLwgi0P5LOll/EzMMcJBkS9jGTcRBMxk93zXXgUMgocYWAFhqIkI+0vXOdk5vTEnOFrc1KXkKWyVWxuwW8Z91bLSJcscssuiqlCZjcHnTvu05sK0QVM0CU2peFKkf9LQhIx3fAEdXGCKtyn4zAoiHIx1WnIhUnxvdabWOUtYbMYQF95xZ3L7w1c3CNJODtOJMgcFKUUYrT6pGFCbEgbwCH5vktVjgNL3mrIvwYCfJ7On1LFLjK/wOL8PNJvrk/FM/0hTEoaB0yeIBtfkyrbi1V4U2jn1p7gqSdYMnPu2d7mkTCr9NFypjUd+GBvdkKR5Amn4AZg+DFlL6naX83R4gGbRX4cX5y9abP64a5cJhMgs/caYo1yIMZ6/NfyrdILaxVE/XLvX9w6S6nlV8f7tb4tO6WzJiB+7XdDpWRH/EnYQDaHlwGCndH8Rna3L+KHKAP/aX2pqpMyOSevTFuVyv1sSaLyqIXPhGATB3ZCGkc0iQr/5LTBZM5fCrevJ7ZgGvxg80zXqeA==
Received-SPF: pass client-ip=57.103.70.15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

"hw/arm/virt: Register valid CPU types dynamically" went under my radar, so fix this for WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bced9f67f4..af3f03ced3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3477,7 +3477,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
-        if (kvm_enabled() || hvf_enabled()) {
+        if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
         }
     }
-- 
2.50.1 (Apple Git-155)


