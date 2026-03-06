Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2A4FCB61D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXq9-0004DY-Cg; Fri, 06 Mar 2026 11:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXq3-0004At-FN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:43 -0500
Received: from p-west3-cluster3-host9-snip4-10.eps.apple.com ([57.103.72.241]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpz-000785-FC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:43 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 385EA1800129; Fri,  6 Mar 2026 16:15:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813738; x=1775405738;
 bh=Za1A/rWYBemEiFnwIdoGUen3C/FlkRo1GZfGqCovANM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=NYTH1+VTQCik2QtN91YViUpD7/ZVvs3sSru4thBRbQV7uhBpdaiQcKr4a+ACrBHKKKk5L3Dccwz4DO/6T9CN3IYbUVJCYUt1XZn3Cl4/nSX8CkO19Bxnm14RYoRbnGtgeQnKjk9Bhz7zXbj0UpqCjxHkDnZgz6cHSG8B4DcSNdy8R2HNTQVt6NmtUfUGDe3Hr1qG3Z0+8XqCdsnPCCvVUEJBXcboDImu1GwOw/Od1cdhLMZhP2B7Qi6i6srCEYehkTTVo8+i3py0CJecZ0NnwWvlntri89kj9XS6aAlkgcCw2f0QwT+PbsTZ6GZQLvs45ysSZoDSoVMMtFI836MTvw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 584C518007A9; Fri,  6 Mar 2026 16:15:33 +0000 (UTC)
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
Subject: [PATCH v16 08/17] target/arm: hvf: instantiate GIC early
Date: Fri,  6 Mar 2026 17:15:00 +0100
Message-ID: <20260306161509.79712-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mKEqkHlW3SDjbnlZ6E9eFL4BIgReXTpE
X-Authority-Info-Out: v=2.4 cv=T/qBjvKQ c=1 sm=1 tr=0 ts=69aafda9
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=XPPznyVi1VJc6oo_AzkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mKEqkHlW3SDjbnlZ6E9eFL4BIgReXTpE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX6OMkpAy4HHBh
 15mhIUv/DBheKIg2q20JddlAuM7lZoOzCelKb4C7hta8DHGd4Ax2nH8BLSVkAwD0xD0gFFGnUNJ
 286lCS5SmMphorpeen7sR8WQxxoeInecmNFOC7LTlzlj7M3pg3Nu9KCY8vQQnsPiZPrpCtsPfzo
 PlxefDcntWK0j2HlclsCEhPQR+MRjpCL+S3BxCFtuQwxcudNY7+b+DiaUp9y244tZLqDKCwrjjU
 RlpreF26nSRgl4bQ4ltlvgCFK9jA7LVagANXfcOIebXc/RJMAreFb0QU2ehFrMMVzraH/hFhTkX
 5AevfuJsZcTvzxXQ/L+SOfhKGc0d8qZnYnwSMBrNyMdlLlQh7WUNdSmBjuyacM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=674 clxscore=1030
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABKqVFaVlnmGnOlGV9fI4aMnaIr2SshVI85taPDCV0Spe8o6GiZ9lVqEKdkM/evGIOSus40j8NdhBXmNWvj6VRhry7B+K0oZZO7hMbd+fQlyCukrbpFvygWSu7M2wv0ELNCsD9W2Wsg06uEoS8phGl8BQFU184XDkZUKaAGDZDblkwL/LlgWpvDzW8sO07O0JTo3eeddyGdaaXdvmeHO8RfdhbFvKgt6PHPSxB5llgmpNvn3gPTzFOcd4rNzBkxz9FkFVbRs962EbzZtrhLR0zAlkQy54zKtX9qlgxhqVcDAuE+6Ta9BJeWbRaEStyTw24oUjU/cZH6OFF9gO2JX7EmsOFUalLbPMtj7Oq/+byBJN+EyWdYAkD7x8B/fUCt43Bw2tgPfSXGfXXdeFsnM4lQln0QLeicuKlck2KL8RlSjguYML4y701V61eR8ZoFiMTVwvEsgS9cF83ykD78n2+wQ4Yl26ATuy6cdIcrYbgOiI2be/soVv9/w/3Sd4wTIlbO9f6HpVFCqFr2xTgNM9NRoKrRTkMhHsbd1SjNcwG0A7+uSHSDeDXhSNe8/DrfiWlVnXcmDLTFT8I1kNx05TTxvVn07983xk/vAAx6VTdM+ashFxnrTAlx/JDjOWxJO9KaWvl+eqltvetmYRnh2bFdTI8vF5p2q7cg7B/OJopLrOLJD7cYLby2/0Sh3WIbaBMCGIaWhrOX/RJNBZxOyBmt/KNfFQUhZgSYx4O7v6RfVIMnY+9+1y5NDROw9h7yNFdGcM=
Received-SPF: pass client-ip=57.103.72.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..2ed1268ac9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,24 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     chosen_ipa_bit_size = pa_range;
 
     ret = hv_vm_create(config);
+    if (__builtin_available(macOS 15.2, *)) {
+        if (hvf_irqchip_in_kernel()) {
+            /*
+            * Instantiate GIC.
+            * This must be done prior to the creation of any vCPU
+            * but past hv_vm_create()
+            */
+            hv_gic_config_t cfg = hv_gic_config_create();
+            hv_gic_config_set_distributor_base(cfg, 0x08000000);
+            hv_gic_config_set_redistributor_base(cfg, 0x080A0000);
+            hv_return_t err = hv_gic_create(cfg);
+            if (err != HV_SUCCESS) {
+                error_report("error creating platform VGIC");
+                goto cleanup;
+            }
+            os_release(cfg);
+        }
+    }
 
 cleanup:
     os_release(config);
-- 
2.50.1 (Apple Git-155)


