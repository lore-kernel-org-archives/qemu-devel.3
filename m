Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F8FE784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0bw-0004PE-QM; Sun, 28 Dec 2025 18:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0bu-0004OW-PH
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:55:42 -0500
Received: from p-west1-cluster3-host3-snip4-10.eps.apple.com ([57.103.66.73]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0bs-0006Rw-VQ
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:55:42 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 2EA8F1800748; Sun, 28 Dec 2025 23:55:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=aRq3YU5535mG5uSPAFBSlmsbBJkL1R5+IAqIsTf/zZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=bdnMWOfahgz6fnYRjVy9cKGOj3Y7JQrUtnQV/V1AH1KWi/smWESPc1GCYDO4op+vOO/FmuQJw1udQ8a2/7fGXrQhFARizktQi756xP3IKFKXVQukm9tlVGBW1wD18u5hBUIJy8R98/TDnYJu++Cg1NXAI9ZEHZqC8iFyaCV7HkShIWgFFdt92Y5nYSBf4P8AG1R6OItSRSO4mzr+WvQvikxTYANrFsvFHCghjC+PsSoM+EaxErFuYTWlivDE43/qcpLtChkE0LmEUstiQ0qKHJW1mIiwAT5JbAzlVsRmFJByUQvQwEOp6X6JJnp6HyX740TyEPCdHrm7r+D7fiAtKw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 2B5F7180015E; Sun, 28 Dec 2025 23:55:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v12 02/28] accel/system: Introduce hwaccel_enabled() helper
Date: Mon, 29 Dec 2025 00:53:56 +0100
Message-ID: <20251228235422.30383-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oGpg2w8p3aeBitWq5trlw_Fg7qxPMaNM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX9GX8lbpm4kCp
 PIFvOwMW9hJXdbT+uj0FZHxRAdjwdPN6XgUpzAQ43Q8SN5pwqn8rYdWXRfup6bz0Z0NpzwaslwT
 MGjDcGqbfNx74L6ezlTtZOYz/SQ118CSrmADCw+dYAl3YK0NVNgPdl8xepDucorTu56cA2BXkLn
 mfxK1l5Yz8Ot6cDGCSZJrFixVIeghbo2ObKE7UjJXwFlbNZjHa0hn4omtjmsN0fv5CFCK+6gCa4
 58raDOcBn+Bt/JGMoyp8L3qHOwc2VJ2qJfmoiJm1oUU/n6NSegOAxziUH6F1aErpTbInht9U1m3
 8dYs0I8qPXWZZz2Nl2S
X-Proofpoint-ORIG-GUID: oGpg2w8p3aeBitWq5trlw_Fg7qxPMaNM
X-Authority-Info: v=2.4 cv=drDWylg4 c=1 sm=1 tr=0 ts=6951c37b cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=e3h0T9cBdxntahtQdW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1030 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512280223
X-JNJ: AAAAAAABoVcFCB49ye50TvD5t5xrezN5WMd1ltYhviWFt8ES+u1Mhf60pkgNJ1wnWeihX0LWzVUrVKg0Ha45cpHgIbtg5CzspMmYHYMYumPT84+V/c2+mq12Kqkng49lv3x6cP7bFEyNu2wbsQvqCBokK94aB+UXTYNhoiwGZSQ0BODJ3SPkvWvt0ov/l/S9CeZc73POUpESFuipph3wBdbcQ/7PE0ehutadZFAjoj25ko/yYdQZPi8jUvnkjmzPe6EIGogFcjP+OuZPu8ABSX0SnqUoU3TlbH40hEZ7dTwPV9iuHTa20zCPlPHhcBmzGsRfdWHl2aY3vTSKlYQhL/6L2qqeSG7I560RH/Xm6B88eBMFkNcVev0s+rUip2t3ZtA8qE2RCzsg9xZ9MSVo5F7QTYz8nKccmfbaQllz6aOLmRL1hjNSKm+SwNK4pmcfyKgokPYaz3gClsqoxBhuS3QyBX/NinA+Igqg0TEBDG4ZeWSFazKt/1ufFDBVWvqRLeR7ZKgHkVSJpTsi7yVqaPc/C+qtanbTwymyXpwM4b/NyS46Li6JFpkpW4Awyb+IEV3eCJ17uN8j04KLkFG/79YidXV3ni3m8aPf4wpkpiDSrV9Fua/zAuG1GiKWn6nO5otQpRqbiBNSYcCB7WbMsIvXeTXUFI+P6vCTEOAf4pM66WWvHgoCnM1jCVObW6WFi4AcHMBvnp1lkNDKPUsOx44BRTQsJ4DqxJEH4uMhp81sd5om6/6BYC+h8XIffsn57wsWRxJEcgI88eQQ8sauD35NM04P8J5CyndzcmIQvkUiqyM6kuZ7M4ruvzZW6gIZcBptDozFST/mIbBU4iZnLzQMTcnGmcZZrpfaBIgsWqWFRBK4W5/z79v123ox3mrmoYr5PXnIXq2mgwSGdFCPU+LUkdFEqAlNfZq/Tw8Hehvo0x/i1Jq1emOGgqNYr6iS14uUdthxRuBvwftxVUwjng==
Received-SPF: pass client-ip=57.103.66.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 55497edc29..628a50e066 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -40,4 +40,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.50.1 (Apple Git-155)


