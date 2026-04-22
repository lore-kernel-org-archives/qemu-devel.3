Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA0EFA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLt-0008QG-4F; Wed, 22 Apr 2026 17:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLr-0008M7-Az
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:19 -0400
Received: from p-east2-cluster1-host8-snip4-10.eps.apple.com ([57.103.76.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLp-0007Rt-Pt
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:18 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 5E78E180096A; Wed, 22 Apr 2026 21:43:16 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkEXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894196; x=1779486196;
 bh=KGlSyiEn7EzenXn+uJJMW3fVczBtJ9Bohq4GV29ka30=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XgHrpO0x23bfzG8VxYDx4d9gb4RSNMcJ9jaSvVpjrkMkZ2xnWVsIED5KI+IElvARNpuGT1TN0iK7Opl95PmSv4tCAT8QqSP3KuL1wS9ku8uU5mf30YEcVou5QSh2c5w5vY2CRF/ClrEydXGBIY27YRk/Sz2ArHgo6nZMOi4csVwFJKZzKwqqQlIV6Q+Qhx1izUSvoEjkyNegGWBlxCz4X6qEI0w1nLvHh238GOkDd+YoxBmTHBS3ncMIJkR46G1Y6RCsj4DV3MjgWAmhlnJfMkWXzMXVW7F1Ixd3tnMNF9wiSc4akmIJDDoDlZcoSVsVCBigL0k+eIFcLyTdu55Qwg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 A30161800956; Wed, 22 Apr 2026 21:43:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 25/37] whpx: i386: Pause VM on fatal exception to be able
 to inspect state
Date: Wed, 22 Apr 2026 23:42:13 +0200
Message-ID: <20260422214225.2242-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oZZR6BRpPuLggXf98MdovbI8bJ96iuWu
X-Proofpoint-ORIG-GUID: oZZR6BRpPuLggXf98MdovbI8bJ96iuWu
X-Authority-Info-Out: v=2.4 cv=TY2bdBQh c=1 sm=1 tr=0 ts=69e940f4
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CGn8axfqn9I_s65QuTEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfXzUnxx8nJUHRs
 xjWFXHE5a3f041+yTEQetJn/1g3HKxreZKiiBpxNxXExp1Ugm6SlN5F4Hs+jWQ1sRkunk6ZmvYi
 cEEJPQS5/Uw/I07yvQc2hOzGK+X3nyTZ0P0btvzpwXkcJk7D6APG07y2PtbGg6mlUHIseEkVApO
 4x3QPLG+Y6Uawd5rLy6DzdMijqwdrVdkmDctAdO4OZf9iiH/YCFSOhTdrD5bqz34swl9zqJ/WiN
 CTe0OFNpDx0GYajnGfPWDCVvow83OqpmPjHITEC5ddArGzcMQxPH8CXzRZehZLL6jQq4Gziwrv9
 uxlpOphZgAf6bucE95RF3fjqKgcxX8ozRL7SxIUU07jgRss+L+1J/oVh75PR+s=
Received-SPF: pass client-ip=57.103.76.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 09ca7b5a53..8e54fcc403 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2387,7 +2387,7 @@ int whpx_vcpu_run(CPUState *cpu)
                          vcpu->exit_ctx.ExitReason);
             whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
             bql_lock();
-            qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+            vm_stop(RUN_STATE_PAUSED);
             bql_unlock();
             break;
         }
-- 
2.50.1 (Apple Git-155)


