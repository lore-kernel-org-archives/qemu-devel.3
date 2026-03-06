Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564BCF01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ4o-0007Vu-JA; Fri, 06 Mar 2026 02:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4n-0007V1-4B
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:25 -0500
Received: from p-west2-cluster1-host5-snip4-10.eps.apple.com ([57.103.68.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4l-00066v-PR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:24 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 D4F0C180024B; Fri,  6 Mar 2026 07:58:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783902; x=1775375902;
 bh=o4Lxm1TA6Kcx7liGCFRS9hTpKNWDkwXTIIQbMAQVIyk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=bmoa9uHRBTGUrp6Y0WWINJxbe35VLA5zJBxCJnm+F1Elx7ljbJeQL5My/d54cmd07YYzzdnRorv8tW/c7lEg45tM0lIXLAEsl0FjmtEaLe9X56aIwO4f68E5yk/kLBoCyRDWVXjwdW9ZkRk5JbcGzAqNmi5+NrODYhNCKpnuoXb3gDFVtZ+lP79y6mT7Qt5QmpnJ98c2aPLB9cIC1jpzi/nHjnUyM73CJhpI9RDvzEPsLmBFh7kzXekKqEMutFhWqIP1aC73OpTVVgGw7m6V9m+VOQc0UdLAinL2QxV3cRkSAQLI+qrO2pDrAnsQ7/NoUcEiDxx9oHCzLK/fbw23Fg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 0B9E0180019D; Fri,  6 Mar 2026 07:58:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 07/17] target/arm: hvf: instantiate GIC early
Date: Fri,  6 Mar 2026 08:57:46 +0100
Message-ID: <20260306075756.88922-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CgDkqctUPa12qg15WxE9x-dcavLBIgyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfXwIpo/OGmaAxM
 3wMOp7SLoY72QRXRi8O5twpNqGtXyd66v1rrYV+zvpkMxtah3Y53nDDdsqXnpeRC3jU1V72ikx9
 zBRBecEPswkZMYrXTTCj0mr/jmGs4tgz+MUMVd/9fdPkm0yeroozqyBin4ncc8fYhB2bFk6zwtq
 jcH1+p8jes9mTgvFEnYrj/t6oiu77CNP5n1a9ZTLA1+v9E4HMkCxKebxKRGLNBAUOTWnQIUDuOU
 MKkFSeTHKNE3xvyKQ0SIHlxfq23mZIr2Ho079ew7YzteHaUpmbEnMh53iX/IuAyKkcn198QksQo
 GFBIF7pl1/AmAoG3OOanC39BPvDlaOLEsgipixz6hZYvuZyNvGzbfC2gzDXCcQ=
X-Authority-Info-Out: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=69aa891e
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iW0rYzIOeSeTUJq9hTUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CgDkqctUPa12qg15WxE9x-dcavLBIgyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 clxscore=1030 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=731 bulkscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABM00CIXuMFIUULxeDTN2HK5AcfUeY+OSiB6uGACgTi1vchp7QlKZGM+/YFGEZBWvUFBrhwNSmVcxT216ZuJpV7tQFDvt8u0rCgtJFkWno9z9yFEHLMmCyyGSdMSdOkjyvRMY1QHhSbuatV8zzfptIrzojqGsjZ1a905LYXofOBqyIoCIuDaG7oJALQqzqUctFgsq/YjNC0ysItWnkQTUKO5aIBXGH4zrp5lxYznzgU6JOJULz4Tk2v4jFiB0iJveL6HrnbDK6ZY/9zNQXragqGf7EC7U4fKIACf/QqL4umJt/9yvySHdQ1xcPRfFiew9Dt8vftixyCNSYjvyPmF/JaXb4TbPc0Kmkomlv7Z97zS1C92loZKe+cQ+tDG26aZGVXYCzKqRIQASN8GYdNWQocmKyz38Md+mmBOcaCKaoW5uNrt/2i46MNXrcxrMlzVFjo151+5LIG1tCbk3r4mcd3GkxHqmmHsWnI0liBZEle5EwX//9yC//K+c/u7BHliFAfUNidHFSE7adDnRGHcGWswrb8H/5+GhhyaJgU9eS02yIimBg/rJgS1ctBw9jTQve+FaPOAW9mWfT/hZp7Nk8eo46NqpUMTarGPlw9xrFC1DTgJpY3rwcyzuvWSnTwiaSdfeG+hMtFOwJ88Lp0dEfl2TdgX98Z9EWcIjle74QhikrTlmZKPB252t8cjqt5f+IJGw6+7pWGOD1Jok8YmJuGEe5GRh9uhbz3rbNBSNzDQwS3g==
Received-SPF: pass client-ip=57.103.68.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


