Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E1FF0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUp5-0001xS-CD; Fri, 06 Mar 2026 08:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUov-0001dW-6y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:21 -0500
Received: from p-west2-cluster2-host2-snip4-10.eps.apple.com ([57.103.68.203]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUot-0007Ef-KM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:20 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 342791804C45; Fri,  6 Mar 2026 13:02:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802137; x=1775394137;
 bh=ijV/TFHDkMx/sDtjnbI4Tcf5/3qsWHHZ7tvtB+wJk+k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Ww52ooeQbdLCzz4etGaTJ1uRzf3hQwvIOL2FRxmO/OfpX7PkwS5GbA2dZyy85ZeBbp9IVoitpskUuFtBbeUpPND/egXObEgT7dnO1VxWaW90fGIJWkHHB1+Ik5NPYzfy1/bBqe899gpA+qjAT8+jLf9UK0ZchYJst0v5aQoMirgXeKk4wsKWxncjRt3lhxEZ1hB/KZW5eueJTWUtljcBMlmVXMJ30SNEp3Ol4xjjKWCqITUKx5PjZqB8EOriE8qgQ0AK87hGUSFsBJaf1Xc8gl1q/TiBpYQf8w7acna4KL/jo5foiN/wiLfRA31LkOFabgYdflxLQxiGqawBhpAiug==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 C1EFC1802E58; Fri,  6 Mar 2026 13:01:54 +0000 (UTC)
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
Subject: [PATCH v15 17/17] hvf: enable nested virtualisation support
Date: Fri,  6 Mar 2026 14:01:07 +0100
Message-ID: <20260306130107.35359-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ra1zt2ScBiFyufZxQyJy8EzjeiTBJrG7
X-Authority-Info-Out: v=2.4 cv=AoDjHe9P c=1 sm=1 tr=0 ts=69aad056
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=5Chse3eIq3h0lgOaJ4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX4OA41oyDuECt
 GGNVL66XSfKf1++Lif2j5185mncOrPk1doRHFT/8XdDtslZcmE1tDsAzb2x090nvIV+SUfTCf7r
 XRnn8+i433r6c6e+gFExu+rcfDuWZ6BHzydlN29VKoVJPRqyS9OdPrZrF3AU0zlH7uFoXfgCT8m
 UM13znY65/LmCE06CvSDbQyE3xkE3aJWGXJWZuog+M+/OXDwT37qokmLnU0SVAleq4xYhyRCC53
 6GOthlU/PVi4fcedAFa5H5IrHUDtQSHJkgyV2biM60DC1Qb+2Ys/pay0hYX0ipIPDVn4DTebDnD
 OR/w9Cl8WULzO/SLrYmX56xkJ2sULXATcIxGeIzQjw1RKceIS9ia6yzXB1zi4s=
X-Proofpoint-ORIG-GUID: Ra1zt2ScBiFyufZxQyJy8EzjeiTBJrG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=985
 clxscore=1030 lowpriorityscore=0 suspectscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABrT01UpygINF/hghFByWhbJlxN60gbX0rzPTZCCNGKNo0zb9FjG0qxDigwPutFPvZUUl/ZgQeacXzeIsi6iqy/jlk/ugsQ9sQzN2mwOdQ7/Fvjg8qsHj7VTzRe8EzmtA/EbLvXuc188RBD1FUAbNgy8UlEMb8WMZqYSdRS/HWl3KfNkZciCTIirNwbTBLO1Cw7BrEniZw1e10gzJ2pdGph6C2Z/25adj+eJJrG4cX99FvfH8wCG/PpH3UoUQbhwDHcq1pjY/JhZEN80ciBZuGURtPdAfFvHDxYZ6yXl4c79+525aAJFNfdpCvkBqRbGr9akPk4as5ObtorBt8t90CKmNZx7c1j6DOA/1fKaKxdnJBppgXq3LzAkpajAUzpfNNtmglnteOw9uLXUZ5BC5bVwClzfuKdVTURgxSB6bm8z0E94w8qvpXYMBaeE4sNUwIql9sa5HehXcU4lT/+2pQk+J5Af8bjWKdBjz/1VDxMfB7U9NMwmCabxe0GXAB8zhHYKcz+47iaNPsCmrtCW2q2PkQXG2zOdxxzq9cTSPSw0N9kiZCW64Qz5wYxtu0zHST/vkrXjJ9lRzkhSKQVkdn0FjxJeZexPJvGbIatC4eJS5u4bihoSxMJe3mWD+qY79Z/UZ7c30x1YX6y6P2tgOQLJyTA/jgZuSNKepIBFI9OsV2T9wpjROsbH993hSXIAHPG+VLXnJxUfeenab4FYXS9HDIMG+rVTz+MfBNcZzem8pdGmCsGbz3fZwUHJnLfLkpQIxe8JE=
Received-SPF: pass client-ip=57.103.68.203;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


