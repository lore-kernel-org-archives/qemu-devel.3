Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D214FF0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUof-0001K5-Va; Fri, 06 Mar 2026 08:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoT-0001EO-Om
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:53 -0500
Received: from p-west2-cluster5-host3-snip4-10.eps.apple.com ([57.103.71.93]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoO-00074H-FP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:50 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 26D0D180084A; Fri,  6 Mar 2026 13:01:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802107; x=1775394107;
 bh=iu9z4Qaqbvb3bLLoCWv/RA/OBk3cWzRedwd1Mjw58PU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ckJaVY2ekglgJhStH/65OmGE90AVb9oi8lSJFHHlnyKe6z391+nZ3xW6Em/XMWFv6amafq8h02Cykqz9z4xDl1DJcNDdv7NDBxSlS3z7chd4m4bWn68PRmdS0UHm+ZBYaiMp3m6p3T+Mv8pg8ZhfHAuiWC4Q8SbJF+hyoBhpzwuSjV2jE9Qr9Ks4TFsKn2uZmNJAzCkOePvDQyhuYivASPq1+BgsL6lkdz01PoOSGL99LnXqgb3p3FmPOY8OnGD4H8FTUhMzuxzvAKhmQLYTZ6jOH4U6gGR3wXRsfg2rHDX8dZkc+SzpP59JYY3wIkVr/GIe5OwQ4Z13Lryh+5sC6g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 5D0A51802E58; Fri,  6 Mar 2026 13:01:31 +0000 (UTC)
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
Subject: [PATCH v15 08/17] target/arm: hvf: instantiate GIC early
Date: Fri,  6 Mar 2026 14:00:58 +0100
Message-ID: <20260306130107.35359-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX/44O6npp2zSH
 oUk9jA3Bm6v7Hz0d+8sjOhjRreVHwJZqhXswvMnje5nLyMYZeyhNxx0y3WzBDKPaB1pwy0kC+CN
 e8KDGJsPY4BHds36MEdxhKuE0hZS7SUaqUbHNVi8o8z4Dodle8iNW/hWTDsyRJ5+rVZnuAi472V
 WI84TGjdVD+lZ3Za6TkSIcdRb6ZPfmlYqaxcnlmJobm8O4Vv2tPGiLrMVGLFfGSlC99kQ9S7B/l
 IpfC9U3hJ0OLHmvJZsXurBKytVfb2c9FCAKYyR1Ft30ryvI9xGU2DTV/hrKCCKTSowqVz91XsD6
 AjCk/DZVPrvOFwblDo2HUb6aYxsP8kwmOgf29ufctfIO5XyT45+lS36IkI0ovE=
X-Proofpoint-ORIG-GUID: 50h--J6Na0c4sO-3yOTK3EXjQFQqe5Td
X-Proofpoint-GUID: 50h--J6Na0c4sO-3yOTK3EXjQFQqe5Td
X-Authority-Info-Out: v=2.4 cv=CL4nnBrD c=1 sm=1 tr=0 ts=69aad03a
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iW0rYzIOeSeTUJq9hTUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=721 phishscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABYQ1ykuhcdhMYn+BS4Xx9SPtmRJDHGIjVCEio7ScRUWO6RcaV09/ZBl0oa2OPrjWuhYFOZEFTfhHZiquY+2zIcyJub9Rr3jomTt43DOPv34f6KYFqtCEubsZJLG1FUPUA0oVCD4Rvpgpst8gF3SrEnciJjH1a5S+l+hstJuM5ChwRYjOgqxH5k+RnC46dxlON2ud6V4xp6wxgm7iDeDcwtYaOiWHmBuYC29qm93Q5s9W9hx4PDn4aEeQHzcP6USWwKT6B8iKKDDfyyXkWAH7rj+eBULslHSHWY4ErJgNmvhm1QVhJR2tx4FMiFlpZSRyBdQyxUKYZ0J7HHoq46GHNZXuBOo+p7Px1TMVi09Bz/J5J2an+XF1qaj4rJiNSPEG1dHjNRlVPuWziE99FsyTEPgKZSDjuUxjuzf8JMNTyxEKQapzPR8WcWx0YoBXOFDqAZZVaKKot/WhgRc9he9zultJtpmf4cBn29EKFnKBoIan1Nkaz9bi/A4I+2W/quv+dB5tA4bENkKbgQIBxUKMLNb9Dit0e0EyCdx3OZRNCVTk5lYBGOsRJGmfW0wtyKxkSPBahUW4dSAv07amg5vqPqKOQ3y3X9meuzJLOXGUbrG2swbnKpqDYvNrgnR91j2m6Lse20JD9Bic9sIu9sC6ZX7BP08+D7p5o3BU7BXkpptaXEZbiyFQ09MRrrFCTh8+PSBtnVseV9kmv+y5RKgBllCDP9T/edNsuWhQ8+VaIsnI5CQWysHa79vSf41puivU6
Received-SPF: pass client-ip=57.103.71.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..1c45125036 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,22 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     chosen_ipa_bit_size = pa_range;
 
     ret = hv_vm_create(config);
+    if (hvf_irqchip_in_kernel()) {
+        /*
+         * Instantiate GIC.
+         * This must be done prior to the creation of any vCPU
+         * but past hv_vm_create()
+         */
+        hv_gic_config_t cfg = hv_gic_config_create();
+        hv_gic_config_set_distributor_base(cfg, 0x08000000);
+        hv_gic_config_set_redistributor_base(cfg, 0x080A0000);
+        hv_return_t err = hv_gic_create(cfg);
+        if (err != HV_SUCCESS) {
+            error_report("error creating platform VGIC");
+            goto cleanup;
+        }
+        os_release(cfg);
+    }
 
 cleanup:
     os_release(config);
-- 
2.50.1 (Apple Git-155)


