Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7484BF0180A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQdJ-00021M-Ul; Fri, 06 Mar 2026 03:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbW-0007VK-A9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:22 -0500
Received: from p-west2-cluster4-host9-snip4-10.eps.apple.com ([57.103.69.181]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbU-0002ad-KH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:14 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 4412718003E1; Fri,  6 Mar 2026 08:32:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785931; x=1775377931;
 bh=ijV/TFHDkMx/sDtjnbI4Tcf5/3qsWHHZ7tvtB+wJk+k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=DRy+u4MkfoHvcsgevxW4O+Qb0TV1yrUObVkIcwuxneDLl4StcRK1ti63ij7PGD0qhtp7/7BLx8HaVSp8Qdv967o3ITWXZ6ifc/xbD0+BrhHmb1MLsY01b3k9ABA0hRxz9yL0Zny3gKMt/rOeIReAMLfu9vxulB2vJxi0QbpTpcLpPyTIDw4fEE9s+GsF5v5L4rbDiC6FEWSLfGxMvKnA1nkWYkQg4l98mN8rNtbtlmv9fW7Jx9lU4Fi3d0cIvGY2EMMUQU+yZuVnNRWx20rLOLkzPqqRVHa+6RoK5URGsnSrRGTiMrEiP/DJEEbHQF1t+g9a9WX49c8g44LrgxuTvA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 5627218003DF; Fri,  6 Mar 2026 08:32:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 19/19] hvf: enable nested virtualisation support
Date: Fri,  6 Mar 2026 09:31:13 +0100
Message-ID: <20260306083113.74177-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZJ3WfdBU1EmsH_YpNnCyJqO4CQETGPP1
X-Authority-Info-Out: v=2.4 cv=D+lK6/Rj c=1 sm=1 tr=0 ts=69aa9109
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=5Chse3eIq3h0lgOaJ4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX+AfqhkMgcyf5
 v7ud5nxvKvoNdE/tlLnUsJmfQZDIvzEyWsGcbvcWjMHhCOE5Nf9Fn+jYZ2XZwBLxSIce3MA7Hv9
 wtfjpU/YaW7SBzw5Co/3i0Z96pHFOQXPAbWO4/37O47CYqI/Bq8N9mfxgK3qMSDt6swhjag9OJN
 R092MzZXpb70VKv2aLbHbc2RbKTUZVVh0E9723mGij9mte1rDwk6RJ2u5i7DyjkMmOHKeXPxDn5
 BuBanYNG+HITkpmgK6Q+nj8tBvR9jznDmNWBCV8wlN3u0BH0R/owHwu78bnDH5HJtmN1jp0gLbw
 9dJmBXGjQXFs9YTSLXAFBSor6hLnF7JVbP/JE2VP35GYearRUhc0wkrHhvfu+c=
X-Proofpoint-ORIG-GUID: ZJ3WfdBU1EmsH_YpNnCyJqO4CQETGPP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=985 adultscore=0 clxscore=1030 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAABlqHWyI3VKc61yGz+ws5L7PUv/XniffHGc4eFhG2r9cIxZw4UV1CItRIYfiyytMjnuaEW3nEc+OSfkHs7/gbQeGg3zeh4H4KP4wZDT83l98dFVE8jFjKtpaEOMgc8SRHLsSEbW9uc8SRb4qk9/YRDJ/lz3KuFImV3O4lW7/UdCP29TlTLTeecwvm2az67WV2T5cWFdFFnY2QbFC6x7leG6hCgR6zw15BbmLnQGTdYl7FJZ2edegtpkQRHBqBwviRARdjkzrBvwx1Tks73Qlb5bmDYhmGK6fqEqbBkr/w9tidAv57M1KfR1KFIOffQ6UOjWWkmnGgdkNehiEwrNt683sIH+7EsePTswZ0ilulfp344AtFr9KITDJ5/xldK25dveLn6Rc5AZn77dz5JDFMer2tzsHFirzvDGJW+46BLMd2DYJr9jRYIGBo7XvPiTt85+mZUDRV6jXhbh0z1GWakIWPcanlnWcdmLZj52IR+Mer5O8bVrgglUXFONFI4KwIgF6Z5kDygh+9HSBzV0Lh0HVLKCUB2LTZLNtI5eeCZAGs2b5B1fb2vGL6dy3t4+ZNuDlQil3XZP14d8d1xmA3rZajnARgjO/BEUnP4R1rcf9Ij+V7Nl3odolz7M7Wn5LjsMIcwPinxtvuNtdzND7QWGp/jnEX7rwQ7gY52/1kmNow2B3PGSrrhnG2OzUHl/ra+koXh8dbNMQ0cwSeyUoKtcNkTzcMw5hraoY2zU7atf7tfc5cj4x0tpi6j9oTmGmuwCL+JRNqF
Received-SPF: pass client-ip=57.103.69.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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


