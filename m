Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A91F94CDC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLh-000879-4D; Wed, 22 Apr 2026 17:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLd-00085J-Un
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:06 -0400
Received: from p-east2-cluster1-host8-snip4-10.eps.apple.com ([57.103.76.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLb-0007It-Q1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:04 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 2D7A01800216; Wed, 22 Apr 2026 21:43:00 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGloFXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894183; x=1779486183;
 bh=rcvN8W6TfAn9CQxzjJv35V1zHDjrUIY5UE/Zi9pAWEA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=b2sZ1HsNz1wrMGrhrPl2Kof7x+wPmDXULiZgaSosqI4ezRTy4Uuk7haWxxXbLcs8pkZH0HJtDWqDj5/4VxM5KR/mbiyPJZLnN3JYMX0eYjOpYA7IyTCHaUrTVJyjGgBC2mftzJux74IC4oYr3YQCNRBmyG7VSFctKeY+zIuv5Hc4bhAysPQcgXldVRjsqNyoOPcVdxg/Z44vVJeGRwhVjlfkrZBUZfANd3z7tVizBlcchUExp0GXPC73+RKhNlDWIk2zlG8kOduP7uMkPU6rw1bL6J5j2/ZK9ttogOY+CRNUuq/qvg6M7Vwp47ctIwWPT9LcdG7YsgBV0igoYQie1Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 EF828180021C; Wed, 22 Apr 2026 21:42:57 +0000 (UTC)
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
Subject: [PATCH v3 16/37] whpx: i386: set apicbase value only on success
Date: Wed, 22 Apr 2026 23:42:04 +0200
Message-ID: <20260422214225.2242-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX+onR1LftCXT0
 bUjPt0lHqwfsz6VO4VDHg35D5D8PNvhIjZKxbbv6v5ys+LHdiKCN9j3iBR+ZNNbspk3EWJi0vCL
 m93ftWmuAHclzHtoSYHY8DXd8+7jYIG1KXaDnm+4s/R2m7u+RZNa9LQI59L3r1bbPbgjyHUTkpU
 MehSTG/2vwLy81PPDmititxwkyoVosJTvlsfRQbe/39Bjpbgr31Tg1FdrUyb+NCR54FYTJH2OXS
 gtY5eglFG5jUHOPlxsz2Yhpx/rZEJTaYm8151m5jeSWEX11YG//jcqs3ABjieDGwFJk8EeT6HrJ
 9pcdslurS8ziuGOhpVvBcvf/mH9AqqZNh2qYYiiG6kABSZ6b83nsvbVnNse6v4=
X-Authority-Info-Out: v=2.4 cv=cIbtc1eN c=1 sm=1 tr=0 ts=69e940e5
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uh2sygq7LFHjsVUyvz4A:9
X-Proofpoint-ORIG-GUID: 7EKII59BFvYIRmMjkG74dlLA75Ieewe3
X-Proofpoint-GUID: 7EKII59BFvYIRmMjkG74dlLA75Ieewe3
Received-SPF: pass client-ip=57.103.76.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/whpx/whpx-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b055644580..3426811c48 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2086,8 +2086,9 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    } else {
+                        whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
-                    whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                 }
             }
 
-- 
2.50.1 (Apple Git-155)


