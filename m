Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5B7F506CE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fs-00013x-IQ; Mon, 16 Mar 2026 09:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fl-00010p-KA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:54 -0400
Received: from p-west1-cluster5-host11-snip4-3.eps.apple.com ([57.103.66.214]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fk-0003gp-2e
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:53 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 B638F1803641; Mon, 16 Mar 2026 13:07:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666471; x=1776258471;
 bh=ECTi6T3kt/sCDTsg0PhaKfkD9w0ZdnZYNR9x/xBgrQE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ahvJd1+Pnny49oX/FnJiLwH9INtrWMNz4HSNLzk8e5UAJGGYIcjwf4T+5Os7nHA3XWXDqeyra/vE8vJ3+u39Ru7oRJyqAmrCPXdhQ1fxr0EewFVcpuipKaUd2/VWsPSRgP77IgTKFmXkTt+pNZyjH6clETZW67+LB8mlrjtWLJmvEzb9bDmEzZ1Y6I81AjptxicqgJtPEuVFKzV6I0SnLaNwZK/eebe527cz49rACNgpWAI6jKNuCkbW/LnakguPJA9lwFFeOK0nfv2JaKQGLZPbYYzXOZjLns3a/stNM6s2gkN26OQo9bnGnR4ENhN/NIXDlL4Tj+Zs/Dtm7vC8lg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 B7FD51803D0A; Mon, 16 Mar 2026 13:07:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v20 14/15] hvf: enable nested virtualisation support
Date: Mon, 16 Mar 2026 14:06:41 +0100
Message-ID: <20260316130642.13246-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _TjF7yMv3cygCE9AihFzi2bMc3jtjX_7
X-Authority-Info-Out: v=2.4 cv=ctSWUl4i c=1 sm=1 tr=0 ts=69b800a4
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gc5wapfoLYamzdkEL9IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfX5ZlSWL1Aaeup
 eoIoghzbQasyPCFHCJT6Q9A2kH6w5ulAdjOdN8zVmPg16cPmCEb4z5X9eRXVcJOmlDXC3Y/Pzkw
 LURf7wQnbzk9JwJfDeJUSsvaipW6Yc1hWSUa7BI5gK3tSY8Vhak8k8PTkG/mslxcqYE94SO5STu
 8TRfracwe3bijOVwdgsHVtjZjbW1C4S4mvbB+hyVbDSnewOCvCbTJZPkwTsapHDJ7HujjAfmr+m
 ciQVrMt1rRiar94st91IXx9F9kRPnF9POo6C0hJ0Z898Eo4kHUHWVtT5TKk8WRG5pk9hu7LBW/Q
 5emqB56CgQdgKUjgzgOYPHMYAQiZYtVZnvEU2/YUEMzCb8Tt3iD5WFpvZpagpA=
X-Proofpoint-ORIG-GUID: _TjF7yMv3cygCE9AihFzi2bMc3jtjX_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160097
Received-SPF: pass client-ip=57.103.66.214;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 90769936d0..391ec722c0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2393,7 +2393,8 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.50.1 (Apple Git-155)


