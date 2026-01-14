Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0C6D37E3C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg19k-0002AN-Oe; Wed, 14 Jan 2026 08:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19g-00025F-5W
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:24 -0500
Received: from p-east2-cluster4-host8-snip4-5.eps.apple.com ([57.103.78.246]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19e-0000Xb-KY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:23 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 1729C18000A2; Wed, 14 Jan 2026 13:43:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ECjpVySg6XZ/QHOAAJ+X/A1Hu2Jhdy4KwMcQqAyYNsk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Q705/zI3BhB09e1KAaKgXuQ4+qDcavAJy681RvRD9UiteRo770bB3kePm8hpGntaD44vdIMBjwdUr+1zLxcaviSH+385O0l9BFeiS5IrScH9DuncD64oyzflVIBqvJjtwMBrMlaspq21uizsNfdsClOcpO7lkbffYTMpcvqkHlw+T7uGP70Bfx+rbdkiwLgTKsSADmhpJ+0JlkzDES2FVc0V5cXwNwuUab1lLT3XfZUOMasHCnPvGNHecLkKL29GQYahQOh3fV9kl44WtUZHHp7PB1Qd1l6JpESHQH4EQPCoCbrTDfYBVRP8dzptVfjbg44HMakAZ6Xt1yCNjM91Rw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 1161318004AC; Wed, 14 Jan 2026 13:43:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 21/26] target/arm: whpx: instantiate GIC early
Date: Wed, 14 Jan 2026 14:41:38 +0100
Message-ID: <20260114134143.26198-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=QcBrf8bv c=1 sm=1 tr=0 ts=69679d77
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7Fk3nt9UQeXDnHDDq6myu2bgwdTL-n_Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX+jXNIQBMUh2R
 4Mhu5t17zJxwvUiyyFDC4gvI3kIzVr3zb6RhQ+6L2rMf0K0Z8S8lkm5ivtujjHKwLq4zB7MW8Um
 I3tp4DKIBSerSMCO4xk3AmrLeOEETeMsEvDTXfjKCbIF4ixbZaINlKptNptdYuXoiU4kka2kk2j
 9DywZJ1QkpRu392ty2I40mMNl0FBQ0bjvO2ZTMzxyCFowbh3Us8AnqvenP+X4Fv2u+sQsy9ArxQ
 sVDMTbMzjYP3+qEKfg3YNNmki6KFtuT9t3wM7SoJybUqj94QzdKUrBaQRRsKVpM3qhczpecBw7G
 2wJ5yWKlrTzJS4JUSo5
X-Proofpoint-GUID: 7Fk3nt9UQeXDnHDDq6myu2bgwdTL-n_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=729 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABlbdPisRf+87r9PIqUeV0LvoMUgMJuB7hPagzyWT93dbl7AL1IVmtyiG7uzCYMTpXLvWYdyOQpWVV5ZWxsYFpcp7NsgaB6oRUwS4x2HMqg+3xM89uimZ5pJGoQnvjoxPELG8wTeLgHMTEb8N9N9ThQ6HVq7iI2y+QjJYfZfrOWmsejodZIV8SbMolisvrF69/R9NW0kgFkrGvb28hzsOmZ3bActuYITAUBaLRJ8wkwsvKaESS7rZ0TXsTdkBh85n39sL0aLTTjbYoYE/65Ny1Rsqdou0Jn/LpTHZUDsP4baj7j6AqZd2dp65WZIf2dloCjum18WGLE/9M6KZxd0JdpWGmpLTDevOAMxjVFXhhD1icE1wM763kYI5UWom9W8xKpvDl7ZRbSzsZcjb+yKrnjjFog5p2BpEgGkqpFf321cukWJIe/mSPd8HufV/oayQMDT+9Ucpo9zOolqAdjT6XQG8DP/L92ce+B3Kp06Lc1bbbaZ1PQc0hkxQl9fM37CLHxa3k/d1QdnX1gUn8OfsaV8Bzmp9snQ4R+nLzqc3GuQqgfoNTFumSFahz0mWBYZyp/DJGUujOV1Ho1CMJj1w4+fiRJORThicqCvcoOWwLipIxh/adRH28BdryRR+U47DFyIIrpychKfp1ttK0OIsA2AA20af3DR5Ma1aR6kMQq5mLrjylR64jxZ76LcSEARkddKXRlSfYsCZwYYKk/NlMLyaxJYu3yiNE2J7nn7yPdIg7/1GwGZfTde1AG29M6Zs35eOw6jUMF8LjoRKPN0/UIY7AlEjlwQuDRsyd/DaZNqi0f3Olj/3YIwCojefClMkbNMSIOjpVZlONBWWsmqPC+sBglYPX5mxf2nqgQt76hD3slJa0RqW+4RGuj5ZkeIRmYESE87E/61jmUS6yB4pmG5M=
Received-SPF: pass client-ip=57.103.78.246;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3b79b8b376..ab31371aea 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -945,6 +945,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(prop));
 
+    WHV_ARM64_IC_PARAMETERS ic_params = {
+        .EmulationMode = WHvArm64IcEmulationModeGicV3,
+        .GicV3Parameters = {
+            .GicdBaseAddress = 0x08000000,
+            .GitsTranslaterBaseAddress = 0x08080000,
+            .GicLpiIntIdBits = 0,
+            .GicPpiPerformanceMonitorsInterrupt = VIRTUAL_PMU_IRQ,
+            .GicPpiOverflowInterruptFromCntv = ARCH_TIMER_VIRT_IRQ
+        }
+    };
+    prop.Arm64IcParameters = ic_params;
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeArm64IcParameters,
+            &prop,
+            sizeof(prop));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable GICv3 interrupt controller, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


