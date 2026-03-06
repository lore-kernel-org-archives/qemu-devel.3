Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734F5F01835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUp1-0001gz-Bu; Fri, 06 Mar 2026 08:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUog-0001KZ-Oa
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:06 -0500
Received: from p-west2-cluster2-host6-snip4-10.eps.apple.com ([57.103.68.243]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoe-00079p-VY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:06 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 92E0D1800179; Fri,  6 Mar 2026 13:01:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802123; x=1775394123;
 bh=iORd2sa0bYfvhgSzMM2My8y1adv78PXwtxDxgCcDzhc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=WhZrStSo3KnvADHpvEKMS6rtWZ8ok90WhTCVjnsLHQrc3U2QLNxxIfXUkCh3l8mKQnYi5P9POuJpn9BXPcBovFTZDzOnBelVykp2Fk1ywYaO6jGwVmYF38Q8rnFPMOi82WsIWBlHh2bxCxHHsJJzpfuA9VYSMt0YNVF+OVafFYgIFY4R6TwP/Nm+WgpTON2/2SB4N8NjL3/j/NMwpLXo/n0YO5hO7eW/t8lgHVonKb3kKyLGVedfO1/8JiZ7cnMBpwcBTaxvYJgS+kPULYqZqclzb/4KwE64dFZlA0u4Qa01OnMkvAvUqkyXkRKxo7Jz/ManL3MCQeGAn4NrxafBBA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 D0C3B18000BA; Fri,  6 Mar 2026 13:01:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 12/17] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Fri,  6 Mar 2026 14:01:02 +0100
Message-ID: <20260306130107.35359-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Yb+wJgRf c=1 sm=1 tr=0 ts=69aad048
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=DEZpVyLLCdwXg5o-P5sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Ghr7951DR8M4r4yVYiHGlJUM2r0gGJ4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfXxCglk11IsDBo
 O1lmXQkNNg/2PLHLeSjApfbD1uq+b/aU8YEimb4djviXxwN9eSp3+CwxpvAO+LVfG0FneyQNx7Z
 UmMjXatuFHyZhDwhLAd/lmYmag+zexQzBFajqJoLXsUO8gBKiYV+dcX87rtHszBfoLjgVMUeGij
 AoLMITVYNcp3oiObkLrz8UemzwExlygLw/hYDg3r6cLWUzjiNTlYv7UdvpTSKYlpHSLXpKPjL3r
 LKB0DXbUuJcKMXLMx5f/nt6th6ijcO+UlMlQxKeO8whuk1FmpYZX1WE2HtsEI+RkZRGaDD0gwMo
 LbRnESE3PIu9UN4qCrIoZobclxIK243FLGIEVde6UAunramabp4+9xkAMEKEZg=
X-Proofpoint-ORIG-GUID: Ghr7951DR8M4r4yVYiHGlJUM2r0gGJ4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=673
 bulkscore=0 clxscore=1030 suspectscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABxkFARHEgJcyWKW2FQO1jQl4nzK8G1RElRZT/34ipFBt2Syc8CO4/WnH/ucTuztklBaX6Nzh17dfcoqzhBkehHcDZnntVeVBMgTvoYIwcQ3Vofxfm5xNItP9J7B+ijvVzzwJdLyl7wykZPuPnNeahxLjHmyGTfFNiGrP1DT+yvqVf5exJdU3UL2/bBsrnHkNoZOhuecj6EdzzMdlLfYcL6S5XVi9WZPr1ZCLFFcBuZByqhPOHuFIrWp1FLprbWWQjFYYGWsMTifcPx59j0pGy53+5pKbGEa4JIITcY+62gYT3kYvCbk9jqBTO0z5lXL3ZB0pHxjPJjeNrxo781GpJiZTPbVP0fydNDMxb5EGtszSSzqpY4yFB/DxHvZA+3pns6ysp8tyDydD3OG07rZpMIwEIhevC4llyEdIJoO9HWKtSymJvH84k8derxI065z7VeT567++mO5bePFoB3LrfRwv/+CW/ax4r952lcR0n9QMd8ODif/NkzPwu9QMyDAid6oU7XDaobsD31SUg+JYylhlYoKG3OqX+eFWtCeXxEUvLabl62ElzlZnQpjVa4kKtnPIFeBKLt46+hlPwwffvP/l8eJS5wTlCZWlpwaLpwp+dRCow8aN7WGB2Meprbyt0d9jhbc4s6IGdOdGbDHZ+hu7H2NQtP9Bhf4Dw17zb6yhK5Q+bbe8xE7NK7P2+JrFWUsXi+f4ERCtC42Le/AtwyAI9vZOSWqveybP7VfrsQbJOANiloOzzKpuM0hO//uEqpjKqAYuiK1bK8M2h7P1YJeY=
Received-SPF: pass client-ip=57.103.68.243;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 91bbb2013b..b50400d295 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1145,6 +1145,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)


