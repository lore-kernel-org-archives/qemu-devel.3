Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5229EC1EB6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnz9l-0007ac-9R; Thu, 05 Feb 2026 08:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9d-0007ZC-NI
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:19 -0500
Received: from p-west2-cluster1-host3-snip4-6.eps.apple.com ([57.103.68.69]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9Z-0001WB-Ij
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:15 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 03AAA18001FF; Thu,  5 Feb 2026 13:12:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297132; x=1772889132;
 bh=rqevPYI5PNmYfO37aWp6zQDTk/Z3PG7nW7DuJwvRyUM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Deg1g4X7LBsMhyAczha2LVjx/yuGNNlyMzTqkqCS4tknk7YqXTGWEhs9JTbRHp4tVy17jjhokqLhFju/vkh8r1iMF+EucYGhBf6PCYsRQS3SwUpTU47kMs26Z5dR/hXFxMnv9SNZ1ZZB/KGm5F4JbJSGUu5oNqbcGc8V3IOxLxI5orR1xMO98i7ALUxOGyoe5CkdGIFbAlqdrWStomiSZep7MeC7JENOpBa1hSBG38k/NLtHddFcWkO911nAK8kI1BGnKBSwpPk3VStrt66AFI9Ppz7pLxETVrNbEwsRvL6UyDb5L6osYX23ugzfwDLA/zIIwYz4g/KbMZ+BInyfcA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 B02BE180026B; Thu,  5 Feb 2026 13:12:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 02/22] accel/system: Introduce hwaccel_enabled() helper
Date: Thu,  5 Feb 2026 14:11:31 +0100
Message-ID: <20260205131155.22780-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX5AGvw3819jnx
 iQBAQ5JIdjYnQkmcQtFjWIMbllRVpwiJfO9yt53NV0kiqkKBLBugnxM5ZhBwoWuHGOeZParwQHS
 zer3u0IprUOjamXsCdjazVNYOdxbm3OHwcgH/jwWfDdOXqHM1GfN6fjR0vf0NrI5JLsKk/PKa6t
 HewQbUVCB11VQywXoxdJG8OVHW7GKtkMwMlP0tDUvXzJW0e2NbBf+v7MRieXIQG+6OHGC94liCv
 nECL0rEzKSXITef1HoCJpk7QLBS7TbswD8oBZ6DJwgt8Hjn/sG+Xqq7mDwb1EQDPUsSkxO/KJGk
 B7Wp6YOOZuAVw+lrQUpEd05pAsszS3lu25hTBDhkDJTySucXctCaY0rJdgk4f0=
X-Authority-Info-Out: v=2.4 cv=dunWylg4 c=1 sm=1 tr=0 ts=6984972c
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6ETJn9Bems13nisYThUHLtuKPZekP0p-
X-Proofpoint-GUID: 6ETJn9Bems13nisYThUHLtuKPZekP0p-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABivwl5K261Q6kaptVP/RZQ6uGaxAcVrI3El3f7u/Ernti73N+d8S3LFu1hBzMoX4XaS7v1SUHo3lWEHGDJNNEX3JxrcUsyqU4jhwaNYy2KY2gQ/+roHNJRZCT6JyEqCI1wZbxIkKumkTGhv/uPZGPTWMt2iwn4blJPC2O7145sAIsxiTUAwechxXO//PCo7P8bCcwRlJLyqZ3lNNf3V/iYQh5758ov4BSVTIQaL+2QXhnVkqtGCjffv62EWB15YeTbGR/J9TnYTANnAb/wkskxBnLEiY4caVx6YHx0THiH93+dLmkAIakzikr8zMJbm9/yS8Ss5sUH36I/0NCTZGO89utVhpkq1aFmmuBEc6L+VZHc6E7g5+9VOnc5JJ2kAmRRHRIKQiQHOjechqR7zXOdB87yVAzBIQtGNQJ/OweQrfUkMDPVlsGLRYVf4UGaH3rOYE6UEGBpJ9A1nvbn4y7L7I+y8I4Ka8gIhrDgqdIwHyke0NSJOwELRRgkHx9imMJrVGROOgRDrywH8oKN7WrBe7yL4ZCih5tZzl7RUDKLEYBVtfvFNyJp0FHqCS64AbC+U6Ek6UeP8UR3YeVHLIcUo4vJ7xSmpOaQ3+kchNJ5GQrGT/08LDbsNU8XJ/pM51sYOHxyPeNd6EXh7N2VmPecfmHOXJEeiPv3QwiIviMZmyv3SoXBKD0+MiI7WTQMHi5s/m26EvjezWE3ZYPtuUxb5HzRglIT8TN37HrW9eyQtAXFES3L5sh3Nr2RFE+MyOWaYpGCG3qZvR2coPVB+ukGQ8zQtTIc5rt2kBU9sFayTWxrRvuMlN173MA3/hguM9keoxBtMFB0E2tXm0a9aAm7kXIZkhM2ci1rl1ojxewZLI3fx30dC9sDOunVWF0mvhx1sk4XJ+Xj1gjg/x2FSq/LfR2EXhbInlMv4FG49RvsWhIVW7nBMYFx7Y+ioNe4vV2aXaIIYcuETo=
Received-SPF: pass client-ip=57.103.68.69;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


