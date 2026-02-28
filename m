Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2CAFD0046
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUj-0002aD-DR; Sat, 28 Feb 2026 17:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUi-0002ZP-0g
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:09:04 -0500
Received: from qs-2004j-snip4-8.eps.apple.com ([57.103.84.101]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUg-0005pz-Lz
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:09:03 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 94043180012D; Sat, 28 Feb 2026 22:08:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316542; x=1774908542;
 bh=noRRGPyIxt6k8TuB+IhP3+kP/Xn5iPl83TtkVUKS/A4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=N0Y3tiXC+MFt7U0AMbUdeUhKpjIoKOV9JhzLhIw7eTmI08eRmd82uybSDTmlE8GQtguffa+qNm7yEXpR0MiCfCfRa0o5nzrQmJ4g1hl9QCx5p0wOE4gfTaUWKfo7cjQUDuZC7qAA4xmGBrcpp4FRxPkZHPoorVkwQmOZOA9qGvXS+WMciPHX3fBkM7tFzx/Hl2flPIdDnD2dIybxzF9BSWaH4cc9Vbrj/5hSpAiLMalkjah5g5LjVs1zym9bFVjf5r1MMvP4S2JQ8+ZmKClOJGAErqqz086a5H9r2JBpluNjDiwAQ13TUt+GZCHDq3pWBl56ptsVnyFo4vMORdi+JQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 B148618000AF; Sat, 28 Feb 2026 22:08:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v11 12/12] hvf: enable nested virtualisation support
Date: Sat, 28 Feb 2026 23:08:37 +0100
Message-ID: <20260228220837.35275-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XKudXIwO3cqAeosVPEqqUbJa1WUlu03H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfX8Ujd1VUzaCJh
 uTo5jMB+pVJ80wbPI63zux4wR45nb2DwFd2mgfdifGVOCOivFPj6v0oCgEkKl75AQDu2ptPU57A
 6Nuav6WIr/TOR5jPbCT60463ljS0S669zCBpY/z672rEXyds4Yi3esZZgzoBjkfa85ogwfdk8va
 /QZt1zkKub9HP8at9RzfEVNPz/fRP4cfY4kqqw6Tdhznz5VpBnfbNmC8DthRtwXfFmdklCHOf3k
 aUdZvKOmDLiDQ6k1uUnUiN9QSYDhNZmakUAsZyFKQBfp7367nEpHF9D187DolJMzKx48lVpeefP
 tWZsU6VMcjUpwoJUiNouAlMIL2T2xrhrMD2A6lYDWDn2Cv1+zznl76iiOVmfh0=
X-Authority-Info-Out: v=2.4 cv=fPw0HJae c=1 sm=1 tr=0 ts=69a3677c
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=cdDYXil7g4BivNFjHqQA:9
X-Proofpoint-ORIG-GUID: XKudXIwO3cqAeosVPEqqUbJa1WUlu03H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1030
 suspectscore=0 mlxlogscore=957 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280207
X-JNJ: AAAAAAABC7bHZ8h9Fl0Eoth43obTZFSqdFjzEfN0i233Ac+W1ZxxTCFKbu6xgLTXR0gFHXovfyw3Q00dxudUNjgtN1yFQDgqcIjRrFF1/bKE+COe4+NrYe2c3F7OXgGhe+2WyxhSnZKs34lRPsncYMGoHuyQB7I4SoLd1eux5WftFGv8u0nyfkyyFVFlyTaHNICjkZNU9WgdCbRjjnB51gzoCVKWTYv5mVsFLS7F8/FTPl4SRbapHN86fpflU0iYsxtHP0kf4YsQlR9UeK62ignlERSs/t0oj14ZpmvMRBc3M5xB0yfUVCk313txDhrGR96flYWlP1OWtY+v9wwwMV8ODnKLlUVpJAO3H6QswgtiWRyxchAfo6jZii8CqSsAPDG8KCHv6CBC5ykdz4jmC2SjmvG0k4ryEPj+uzmTI8B8LO+OopM1u3egpi29uknvMRr/fNbPB8U1753H/Xx02Zp2VwGOw1mPRpxsxaBeEgYaQA4lOU426Fey9GCgvewc4hlTyTcjkOIdQr/xhYPapMHku0pr59UqnAa4rkYjTHOxtnFmxwyy5K35IVwqbxCIikozj8jgBSLdqlCFbQRkAX63Y406DAwyG+svnJFGvgcXyLVoSnNOeUsLeNJfekXi38JKzzLCWouc3bT2fxZrp5h/dr7hUx8NHYS8oA2KiRXCm3vEro8P0diAsUX/zglAmqueXhi78lesoUh5r370oIoUeCs=
Received-SPF: pass client-ip=57.103.84.101;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3fa4f41821..731ada5d28 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2394,13 +2394,20 @@ static void machvirt_init(MachineState *machine)
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


