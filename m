Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C322F506CD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fX-0000tY-KU; Mon, 16 Mar 2026 09:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fV-0000rr-JV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:37 -0400
Received: from p-west1-cluster3-host1-snip4-10.eps.apple.com ([57.103.66.123]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fT-0003c4-Vr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:37 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 EDEA91803D08; Mon, 16 Mar 2026 13:07:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666454; x=1776258454;
 bh=eCZw8ecsKyAPOmb83e7ghwj/bQ3BfEAJzVmCsc2mLa8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Xk61ASNOi7uemAwFH9GmD0yP0bRq1G25+TGZzvMxuAh2+ESl2ExTptP0ViuzJeCc7Bzw+FRVl7flEcs2JuTopbkwHaFV3QxANiiWS4EeOyMbkZr2XBQeI+kHVRERYlYDmwJ4uGZvcAM+uN6RfPaFy+/cT5HxTCd+IxT5jyJTGTOlMI3dModt6qYb4v2Ey1gsRRgVtbBdArJ4fz51cbD29ADMl0oiZX86E+O5phuYPXENTxOZgi0v1sRYxs5ns5qrwagYla6pMQ1DC3JCo1L8X7V1GNzEM2N+Mm53BBQQ8qvYaG2wRPkDwYyxOplWY2dSOB3Y6xFFbwTORblZWSqrIg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 BC8921809D4B; Mon, 16 Mar 2026 13:07:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v20 06/15] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Mon, 16 Mar 2026 14:06:33 +0100
Message-ID: <20260316130642.13246-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=PJICOPqC c=1 sm=1 tr=0 ts=69b80096
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PzQS8Z__MZ2uSZov3vkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5imUvgXvop1KHFkxcf1b0gNw0Xnm2euj
X-Proofpoint-ORIG-GUID: 5imUvgXvop1KHFkxcf1b0gNw0Xnm2euj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfXzOXTzFr0ZVSm
 rK2ldaNVuO2aM33sxz0w7HCUsJBg9EOmKWMk3Pkrjn2Z7QgpZtTiZXHqCPt3V2yTIpJihFW6KT2
 zgiR8OekDmMZw7A2vxrYRQmbgOlMdkkT8taV6OOjIh5msxDJaowdZbaupDq3HJ1EtlKz8zt8e8F
 c887fTDUBJsiZ0DpiquZrOOg5Uj7h+CjYBS1BXa7rJL2FbJDYeqISDqZxJRj2NUFzVwhQgcIAka
 SeEY3CIOf6z9EpWZQ6uatyIxzlUp9qH+ywmG2xQg/y7YfeEbKLljgRjwrhYqO0XcqnIH+0Y2qrU
 Cz5ILAicwzvYkTH9xfWq0OFnw+VXMVIWTA6SumsUNis7GaT1tNqzc6jHA6hKek=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1030 mlxlogscore=984 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160097
Received-SPF: pass client-ip=57.103.66.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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


