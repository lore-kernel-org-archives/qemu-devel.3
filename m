Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021EEFCB61E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqP-0004Nd-2Y; Fri, 06 Mar 2026 11:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqN-0004MJ-4E
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:03 -0500
Received: from p-west3-cluster3-host7-snip4-5.eps.apple.com ([57.103.72.196]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqL-0007Eg-Jt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:02 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 3CDE218007A0; Fri,  6 Mar 2026 16:15:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813760; x=1775405760;
 bh=ijV/TFHDkMx/sDtjnbI4Tcf5/3qsWHHZ7tvtB+wJk+k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=cSBN92suwee11dbvU1n1NykgNdpxvn90GB2XLHYes9IJMTbe+iU5yaI1AdbGpxNJZY/3T6rD7axywq6WSVf3t17CQkzpOU/wYv7RdOYPvgPjLthPjRB1DJdooRV+zxe8477F/UVKP1E+1aNK/oHsJry7Bc73R11IOuysbXZdkVv8wQiYC7lVbs12wNYnCAhwe0WFE/wpbvr89G8tTol+QL7+hTl1rRJ9AiUTbBFWB0hqx59qrZrX0vg59dZSYYItV/TqQM1sdFlVWnrbD0SGLPGfDU1w2jBbKawFIaKwxm55olRA/z3KcwB7zspfUpimi5Na46k0jUXPYs/cDnOodg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 7B80B180010E; Fri,  6 Mar 2026 16:15:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 17/17] hvf: enable nested virtualisation support
Date: Fri,  6 Mar 2026 17:15:09 +0100
Message-ID: <20260306161509.79712-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SHk51t-eAu_qDSYTmJ5Hyb6aw5lJIaHN
X-Proofpoint-ORIG-GUID: SHk51t-eAu_qDSYTmJ5Hyb6aw5lJIaHN
X-Authority-Info-Out: v=2.4 cv=c5+mgB9l c=1 sm=1 tr=0 ts=69aafdc0
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=5Chse3eIq3h0lgOaJ4gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX1ssP9WRv0f+D
 1rA+AqDN9L8oLBolHfWQHW+EPWJ/DayD+HKWXIzE0VOosIczDoFIBDGli/Qb/TmS4+tLxlbrEQn
 lhFFquuovOqYAipOoFgVm/7PGA8ZqtssR97plBh5wAHHEA6gBEOa47Pz8WvA8Qh3OI40lqQ08KL
 mamZhH4jEiaq3fmzWDTpEPlxB6YWdmgDzlrw2AEpDDiirYXkyoJi9GHMWhAivIqvaRXrgBxZV8k
 WHrp/bzA6Jw9J2CjuQUEtH54A2JMyKY7pjRbSvPqQOtMeRjVpP4Y2fdmBfGYejQTpGtpns5Fo3r
 xkISTnIyHclYNA7FWadBwDFqYOIsnUGUjhjPV0ZI6WjWj653QUwWTsJCYGoY+U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=985
 phishscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 clxscore=1030 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABHYgTnmz2yZhp0t6uKmhyjPwfoLAK7hv314F+TwF9QUuJNtNAltZDd3svmPBNAZ4q168+scWMpCNTG1ykW4tNPnjj3JPLi6GiCkTt3E+9Q/rcJ8u8s265YF8CovXDcEyrXAa65ohz+/4mm0dtL5Ttd72YST8QAmhks1S0PlD3f2KINmSXnbBQV2C8vzRV8for5etJRO0A88bgvyNK2GwkIxO2lOZHSpy4fbo75EPIwnCT/fakV+rr68UvgepvoFjuxmtDwrgs+S36/RvhgAuy4i/UMKgCJ7cqFGY0Oh8p6D58RsvephYk3cmDbMAXDoQ2b4UJ+mRd4ojN26x7xlkVPn0l92VJDTkmgAwIsGo3TUnF+gRRW5J+aTjyRPCl1TglVvqRtr7X+Hr53EMgWXGTQXxZr2ucm7bHmPNB9pCI0p1KK49eUTdzyg80WAluLCcKzgUEW4fzgrv6/h8g1cnnGrGjGvGWSXtWMIbdrclweDeUrSpmVUt9yDCrqb/QbDhbPSKiTHhAvELYQ9+SyM3cHY3sZuD3T4CS3FYpmX3CydJVRiuS72YNVZ8MX8ot0JMrV0wrCvjDYNW18lX/UTd7aEJArd2UWcKlekXgZvG/wWGbfzuPsNMn38QzyTrZsl27baDFzdaY2xnlCg7bvX5nQl/VUsgi7R+DSnFjxjUPFlI774upNhxiUhnuJ5RH3GycBg3pHmVT3xgFE9G1B5Zlmx+XSfMKhxtRio1t7Sw6ZNOzDLjI6TZi+YQPCeEV9YtHFLE0lg==
Received-SPF: pass client-ip=57.103.72.196;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 90769936d0..bced9f67f4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2393,13 +2393,20 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
         exit(1);
     }
 
+    if (vms->virt && hvf_enabled() && !hvf_irqchip_in_kernel()) {
+        error_report("mach-virt: For HVF and Virtualization extensions "
+                     "only kernel-irqchip=on is currently supported");
+        exit(1);
+    }
+
     if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
-- 
2.50.1 (Apple Git-155)


