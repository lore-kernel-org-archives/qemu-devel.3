Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF6AF55103
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0H-0001kU-3i; Sat, 07 Mar 2026 13:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0F-0001jN-OF
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:51 -0500
Received: from p-west2-cluster4-host5-snip4-10.eps.apple.com ([57.103.69.161]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0B-0003Tm-Iy
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:50 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 63711180062D; Sat,  7 Mar 2026 18:03:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906626; x=1775498626;
 bh=I39KlZsy6P5F3w8BmyZE0FxzdEcPXKIH1UdSg5cxOh0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=GA/qIy6xXsGMQGnGHzR7So5vFsN+Sl+W1EKdEY22Ef9qYXUE0ToL77xTg/ytHUNLElY/J/Zds9zttqzVtvVXdExqUHbdHz3M1eA6ycsebl3Q2yi3KFvg1mPKoCnq+5gV4dtEtokkYW95/NqdNmfgvC9LHn5XhEhomJmEopct0TAe+kiHfQ2aNEUygTTFtPl+AujFXKlv5/KEIUB/ujTAYswd1J+2jBXnJjLoqh0L57BelN92TJSiHrJhwOfUslk2nf+/sS7mQG7cxprBoDldKFeMyw8xbd0N37zzW8F2kIEKQ9uPtUnAqYhVEf5r0BCRekgHPVFrjoUerc59UhvYGw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 04E0218001BC; Sat,  7 Mar 2026 18:03:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v19 04/13] target/arm: hvf: instantiate GIC early
Date: Sat,  7 Mar 2026 19:03:21 +0100
Message-ID: <20260307180330.75168-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfXwIZxnU9R/bYt
 yBKMXNSN7zRZsrlhTY342WvVGcDfINGLmsvEIW6ySP4PGT8Jou8V1daL53+OJeJ6yOLRhDZiLD8
 ltLTf9wgVOlz/BxOOzfjOZGC3x2C8CrIB0PdHdkX1/Gb6ctAycLfgaQuxkY0q+1Ql7vBcxpczn4
 RgUIU3vHwsvMqvbLSjV4k2HWOXp5Kj4RziAN7FdEn5sZPWMGXRpSOHHchaH/LDTZupWokZamRGS
 MfREJyWCYrght/FdrJ7P1pHj6tyW6e1o36/K8dCTXgSIgLegNCoWTYZmchs7kDX4f5UPLCigc9G
 x+DNjN3oQAYFWXGwErDQWLDrx1wv7wtbPWMklxqLzIGwNPHyuQW9sowiEjwsWE=
X-Proofpoint-ORIG-GUID: 7nU3hdl70mOTh7vsgGsS-ajB8xsSLwWK
X-Proofpoint-GUID: 7nU3hdl70mOTh7vsgGsS-ajB8xsSLwWK
X-Authority-Info-Out: v=2.4 cv=CL4nnBrD c=1 sm=1 tr=0 ts=69ac6881
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=8CAvFU3GWpP82fccr8MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=551 phishscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABeWQekmaofsKwllgqXsaoERV9NmJBHMVeQpFaqaL5OBtZyCHRK/RGSr4z6glXebRfen/fbpKz2grVDRK7fsUMIs1OKZWIenXYb/Nu05ArCjxBkVrOHktykNCpc8NBK+kFrHyN9P3hysrloBMhwE70dj7NNlRD67vJzmx4MrSuti7GkgHOza9AdiZIjmG84NlCqznTH324zioXiQLhlIHXUGABFB81X6mX05wchEapuQ5FmvaJdlucaaEt0ksIAoh4YORxt97C6tB36vAfDWfshKjUsPEwybyt7FkEWTqh2MufDA920JATFsNYW5zpHoDY2AHlcFCB8ImL+E58OILA5kDu3MKU3Nr3/Dj28Y1XEW+zyFXmD2lu9/FJjQ/FU2GrEgDD5KM9KPFAO/65JNI4opmv2tl7I125Gean1HfEH8yxMVoDD1Uu3L0jrFcIQ4us0m8U+Txk9rk7ZdOtgYUOz57F+InFx1RLRG/5nRszyL7rMqKwi+Jvw501FBn4fwFQiWFT7sL8hVxiokRgglTiK+9I/wkUMUgaW7IsrHgAR/FVl4tfO0oQJ+D5FtZqTBZCypfbN7RrjqpG0FMy856kqV4Kez50LSBOKVWvfHO2pq9FNw+zO/pFNp+WGgigMq9gyDHSPWJPk4SkFIvPvIfOUEEUdDgfrqvtWgJ9ehEbeZMDsSV09clEcxhsAFdcgwhakPJSgbi+mfTlLfPltORMyr/altlH1mRLKR7yZA==
Received-SPF: pass client-ip=57.103.69.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..d431d96ba3 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,28 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     chosen_ipa_bit_size = pa_range;
 
     ret = hv_vm_create(config);
+    if (hvf_irqchip_in_kernel()) {
+        if (__builtin_available(macOS 15.0, *)) {
+            /*
+             * Instantiate GIC.
+             * This must be done prior to the creation of any vCPU
+             * but past hv_vm_create()
+             */
+            hv_gic_config_t cfg = hv_gic_config_create();
+            hv_gic_config_set_distributor_base(cfg, 0x08000000);
+            hv_gic_config_set_redistributor_base(cfg, 0x080A0000);
+            ret = hv_gic_create(cfg);
+            if (ret != HV_SUCCESS) {
+                error_report("error creating platform VGIC");
+                goto cleanup;
+            }
+            os_release(cfg);
+        } else {
+            error_report("HVF: Unsupported OS for platform vGIC.");
+            ret = HV_UNSUPPORTED;
+            goto cleanup;
+        }
+    }
 
 cleanup:
     os_release(config);
-- 
2.50.1 (Apple Git-155)


