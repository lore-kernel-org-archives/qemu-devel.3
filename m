Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F0AF55106
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0J-0001lD-3F; Sat, 07 Mar 2026 13:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0H-0001kX-JS
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:53 -0500
Received: from p-west2-cluster4-host5-snip4-6.eps.apple.com ([57.103.69.157]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0G-0003Uf-8e
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:53 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 0B50D1800127; Sat,  7 Mar 2026 18:03:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906631; x=1775498631;
 bh=eCZw8ecsKyAPOmb83e7ghwj/bQ3BfEAJzVmCsc2mLa8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=dSGcJcm/x4+7pk9k/njNWfFqfTs3sJQYHaaHTcs9nF01VcvMhmc2Z8mxhXUiIlTDrsyVe+RgLYQP9q82BjOdTW9sfHySRWMETw/ttSmqo1ICIUYcGSbJhu9jewdp8bocIBdUFd12tC4eWQ8rVTFn2xt3T1hDnwaMR2xLJesomyXNhsQ7KHs7cGw3gTYUvpeeg9V9Rfkx4cr20cs2fIckEx6S0teR+kRp7DQCLI00YP84NzLhykW5IOqUl/4l8ioynQA1EaazrgHuKck4h33QrX3D898iW1uGSTdsi5JT5RddvBbGvENEdgY2Kr3tg0O0ofnzwZV4iCHQyLXFQCH/ag==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 887C61800E28; Sat,  7 Mar 2026 18:03:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v19 06/13] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Sat,  7 Mar 2026 19:03:23 +0100
Message-ID: <20260307180330.75168-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vH-WGnR56IlYme3c1XS7J_5Zx0HHURwK
X-Proofpoint-ORIG-GUID: vH-WGnR56IlYme3c1XS7J_5Zx0HHURwK
X-Authority-Info-Out: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=69ac6886
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PzQS8Z__MZ2uSZov3vkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfX7YLhoFBVjbM2
 H3VTVXTqq9R3jNBPVVgleKwp3JA66saBPyc21edqDnUlncacRUXlv/1id0U8haiPlpyJ8RZwpJ2
 r/gdBAkx1vgaNUGkE+51OXIbU3MfbZQcCT0s7P20BqwCYkDJyKqaEXXgG9T1tB9GaNO8/dIdz0J
 kvmhYDBcJMPOfUou9oiMt4wQsb1YwWKA/JfTj/I3RbgqnqQjfbYCmfee/zIILrnlVBtkMzkiASq
 V86adecmgrUOzj6+zN/QWobk0h45CyBt+nlJKDb/Lijoq2A/tKFWt29NyI15ZsHRyRoIEKuJJZ9
 O8u80TxUins1mIwmVq4kxkP88/V00QMHhKf7TweIICuQ2wyKvRX/KEUx2P9op4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=896 phishscore=0 clxscore=1030
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABc9ztQRpcF0BI6+elZxBVCP7PzFlHkjtNhXI/0/zeSmAENh6bbhxZET106ghnxLDgq+DpjXvpl0mVzQXGTwZQY9i3Z+ZRkquM/I91sYH/8ZPgKXahboCqE5y7mdIPPErVgVbHEgLmxHWBr5cBhdDbOy79DMjKMRfqJ6FRy1nh7d/LwXBGtkTFJGfVLyEfQdYkNhSURNRJsCV0TzQ3FgdskH518xmjmFNJw/EmmCWF8Jc0wvIgGdApl+yTObqJdrobF+YqspzohIMmTGH2u9MXS4pIV52pkuOTBKpahSqEdPCSuY8dLfKEVFJMNyA5a+8DPiv0ZFsSTlZ6ulJ2REXM9yee+aU0kUGW42J2ZQddq29eZdd/QXx1SC7sQL4RsoP+vaZxR/V1aAGuUJ9zBA20A9GFM6wDKspsMvt5RKYQNj3SKirQca7AEg3PoDJ05vAnXuE6GXmOsgp5VBYJ7WpYVn53BjRUdCziCU++o5WQsjh5CWmra8gAVAiVlVGXfnzXeu5Fyd94THM2OVUUjDXNRygfwN+4tLdf1yG46W88m/seZVrmIgnYhlrvxYgtOAs4a994EaZUHO7wugMlUCc5Xl6KS2Q678sRLLPMU5wfygJBSXPNYl3tMcs48jG37tSx+5AAMwCRAPkzAScP0BOcXSmCmbMiZhlNelBDCe2hVDrEqZwCSlTWKGDOlKMhV6k5lHapKhIdx0A+pIu4KI6t3NSLmDjCscbaOUH2jvarcbrMf8Ptl14mfbS7EVbcuRa9oQ==
Received-SPF: pass client-ip=57.103.69.157;
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


