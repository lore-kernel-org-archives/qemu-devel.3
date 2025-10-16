Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF3BCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Rvu-0006Fy-Bp; Thu, 16 Oct 2025 13:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rvs-0006Ej-Ce
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:32 -0400
Received: from p-east2-cluster2-host10-snip4-10.eps.apple.com ([57.103.78.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rvk-0007b8-GM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:32 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 0B684180010B; Thu, 16 Oct 2025 17:38:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=aRq3YU5535mG5uSPAFBSlmsbBJkL1R5+IAqIsTf/zZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=b2qFVsXgBzjjOYrGCsSGuF3CIZSBecsxutWTAw1k7fboouzd15OBeREYRPiZDl5lv4Eg15k2Ce5QOpO7H6iiAkpPm5zjLqDcc9TOdyo8tUFhhbWGPQzaFW9/Bx7RYo3t3cGd0Z+nE/gMW/vcFCaE++qqA2jg8r9FHrWcAv2XTwdMxPq6thisq1mSwGXhOXRxfWJ5F9qBymfm0t6WvX+t5Y2XH5NoenR2eYsY1+JiINIhLe6ymep2MnMkMqmGfKCkF8cLkX+EvLS3dgAu7PheDlUNnK/BT3jgpGCBX2LcYdldupG/EoHIG/p+275kLge7s2dLlHC45d/NEBe7fwFlJA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 70455180009D; Thu, 16 Oct 2025 17:38:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v8 02/24] accel/system: Introduce hwaccel_enabled() helper
Date: Thu, 16 Oct 2025 19:37:41 +0200
Message-ID: <20251016173803.65764-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016173803.65764-1-mohamed@unpredictable.fr>
References: <20251016173803.65764-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QAwfuhYe2JYUcoIdMrURBotqdvTmE11z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyOCBTYWx0ZWRfX73d3UabjojQn
 BmUc4G2wNP3DcBH3dw6RWMunMfzPGDMatt6qRtQaSNK6MSk74lWzGzjqp9lH0uyDRx4UUmFo6Wu
 GPoBlisb8vKkYLC/xGudMuM7d3tOHgEnj6cZ6ESRGuhjTR7hKDN1hsIfnsWNqpZ8ZsbFGzvBkYG
 jO6RF8gZZT8s5WdUQTYtJSzxGQhjvnHlUvFY9NM4AVyxZ7w1W/8toPqQoD7tqWEgq7pJohv/NL0
 VHUbh65bZdpe8Tvx4cEZRo1C7+/xJdhROF5UUAfO+1WtDZ60RV76yN+2ZABaAgg8/39nKCGtU=
X-Proofpoint-GUID: QAwfuhYe2JYUcoIdMrURBotqdvTmE11z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1030 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510160128
X-JNJ: AAAAAAABYb2fM5ExWIiemk1nPoapfp5IdDJUiZ9mtROZdnXQrB1ItAC3f3lhbmDhqMn+MEZPFB+NMkqjl2jVxQslUpLacaLuiYIRELb7dHpyhWv+ojVso63Ix7VUiz7wt7kA+bpaWx2+YS3oXK+xPHt6SLgv8FdIf00Ik94nqSwq3vsNxhCD7QheQxkkbpzCmf1l1ojiuvjduKNAhNY2ckqEcPHb+wIqrcDFm8JE13KeLQHhOm66pz/Iotl1Xu1kCTGJncx3qesYAH34CaPAocYT22HhIAAHtgdIzB4TRkjDlEvv/MShu5awpFWpk0UCTg+vHMlK14p21pcFY2pfYGYhik3Kx5TmRyC3g5NxDJirbMoMmxp8mQUyE0KLrdDDqD69Gd7WqAzizePh3rh3YM663ZnRGEbB1YwX5nxNwgUy3mICWrbz7PuBlHtdx5QNRN9EDuFzVqkl5Bhd3fQG57kGk5rAp+97+4Q3y5/KaLqF+nYCUxZ08hlrjkaZzD4LZNy5BpyU5iD6rclahr9wE75ZZ0+aNFovDDXYKixpHvDmbiEoggoCiFp1bffH/sZGJ2nO0BpyF4Z2gKIOMHaDAq04gdfVhUob41Ap3vIA+QA9PAt/udiO5cf4YvoSqYaA71FzmyWdR1cwAgOzkuVct9HTaVpzcvWCPTB1u6F5bLkghLxvuOkvY/p5YT6KrVypvFahs26lQgy7NxexC7FS9K9cHtPi0a9gIrmunU5FslCNWpgx8nxpgmlJ9GUj540skIEmbKYAPufPpVQ6RlcEmazhVi6Psg4JSsarHpWNJSWScFE+kJyyDEldxl5Yv5slFTw9lKFOsdQYFYH4+KD8Zs9VwmDrIzz+l4+AObEuWK1tWyZg3wFrk/21C18pY9ghsruaPjbjMcQd4F1/695jW2aE+SmRg+cbTQ==
Received-SPF: pass client-ip=57.103.78.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


