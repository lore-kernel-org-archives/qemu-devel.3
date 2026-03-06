Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C53F01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQbx-0007kp-Vn; Fri, 06 Mar 2026 03:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQb9-00079b-Pp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:52 -0500
Received: from p-west2-cluster1-host3-snip4-10.eps.apple.com ([57.103.68.73]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQb2-0002Ts-8E
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:46 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 444D318001A6; Fri,  6 Mar 2026 08:31:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785902; x=1775377902;
 bh=o4Lxm1TA6Kcx7liGCFRS9hTpKNWDkwXTIIQbMAQVIyk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Ya/JilGS5ZCqg0dh5UWOCABYtpD3EwzdRNPOuMJ5puwcPQuaSDgm1duFVgNFfelaQZg2W2RdTESL2Kcaw4vsSjhRi3yaUq47QlRV0LJmwSqAcz9CqQHtR7xYcNypqF5Z7AghOvB6jaEYpcQd9DHEhuGyHfTDmVm4jCCo6RIVdnkEPSrcsBshkLFPNeGmDrpcZPkYilHhr8X2WDCib9CQe/b7nun176SYTcMhTM361qpE1Nv2TtyqnoliwJSeHgdyUVasCf/oXGZJmmu8A0MnY8ai5J1JBiEJe1VdhPz6TX2nuMWytvX0jvoZ04zeUANSgn6grzHcdOtOALUXZGQPAA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 CB072180017F; Fri,  6 Mar 2026 08:31:39 +0000 (UTC)
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
Subject: [PATCH v14 09/19] target/arm: hvf: instantiate GIC early
Date: Fri,  6 Mar 2026 09:31:03 +0100
Message-ID: <20260306083113.74177-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AGcwy0zRpDYKWevTAyob63daUaMU4i4e
X-Proofpoint-ORIG-GUID: AGcwy0zRpDYKWevTAyob63daUaMU4i4e
X-Authority-Info-Out: v=2.4 cv=K/gv3iWI c=1 sm=1 tr=0 ts=69aa90ee
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iW0rYzIOeSeTUJq9hTUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX74DU1w68hA6n
 kbBSSzqitv/cPc1sQaCXFo6DBN30MKWTRUumfduF3bK+zj5/ao1FS9kkL9eQK7gPZaBTMHipkvR
 pMd/v+SLc31BjKi5KWYpx7UD9dhVcO2oFmjjrFpL5OZKTzi3d8aVmbyvZvwEVe6wiZ4xBUG5S1F
 viL/reaBcJwY+vKUkXdcxAnb6UdcTbWwGI4JwG+rmBtLP0eFGbKnZJbv9IOT55Jl6SGHMXv+plF
 CzOckyeu9iwhPaEvcie1Xg+4b4HhawZ9zEvE7LJgEOPSKuRq/yI/4QVmt5d2kj+VUZYGAKXQJAP
 vnnKSbeVN/96xcpcqEVwKlLnlfJqnoVmG0+4NL0qPR2IdvyquIGiILkFxu6qSI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=721 bulkscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAABalGNOqX1lr5qSOM3TnefHRs1krT7WKViChVtiInlE0uFN5mv95i/1SAm2JORpTCG5e81V/Oc5mKrAqhh7IU2t86GNyMojWUwySNABtmjXnCzIr8xUjXYMS2nfgjIHCgU83qsu+qft8Iq8FP1gTHr7nchBeSBTzCoG8JOQJ6VE+z73EPebhp0yklVCeAtmDQvqqzxoK33wZ8B9XQg8n+y7ZLnlhqyYMLPTj1sG34ZZZSGndBwbRzGmRBjVICT0pP6HLk6BbfADvcw5jyWey+tWJ1+McGpxOPFP6HIaBVvdGpwN7/GdE2PWuQznaTpwExydlwZrpDzVOGit4D8TKo9sjMK2bXNJeubdOQ3pBm7c/YrQSf7rmxK6Dr38dZZX5Tcvb7LSJoF9oOOJEZcG3OGXuKKQ75Y1KVXSO4Kz9lQbdNzjHWXFBrkZesCuqU0wnPQJt6Gt/NWOEJAqdXmTshEg0y7N0FATFmJtyN1YHervN9S1b/C9E5/IIqFyBCbDlTVoyLW9ssK3j+eaAuLLSvNqWazbw0WKrK7+iY2zgJbtC0SSXAnphESbEBE1W1WuVWtRxWP+8P3/qMNT8qN7fIeqQtTgxZ33+PBttdtj2U+zg0LzBybPkymPFFmdTvm4YesSOPktInQ7G9x1elT2Jzv4Czn0jfLpi1WM+hj8fIxH8eUJjIug0CbVJTBTVlj1AV41dsPybQyEdwaQg39dSRybf59ba/bnkXIRJsfZ6DLO2dM5aijJnkQUYMcXctFvlXM
Received-SPF: pass client-ip=57.103.68.73;
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

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c9787b3ea1..c37493b92a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1212,6 +1212,22 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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


