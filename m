Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631DAD73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXZ6-0004Qd-EF; Thu, 29 Jan 2026 14:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZ5-0004IB-65
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:27 -0500
Received: from ci-2005k-snip4-4.eps.apple.com ([57.103.89.235]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZ3-0005nw-Jl
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:26 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 D14F4180200C; Thu, 29 Jan 2026 19:20:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714424; x=1772306424;
 bh=rqevPYI5PNmYfO37aWp6zQDTk/Z3PG7nW7DuJwvRyUM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=DQxeMuVHDxRYIOn1ZzD/5UbZQDg1Fx5jar8kbKRrmyavKr3m91u15pidVvY3bko25Jcy2PQOAK44Y6VpQRYHgM8luwgNjxdbVqNcnnM8sERt8P0tbUbglCa07DuEWhWR5IiDXOgzxqiiWsRqsEyVUHvgo3y1cldtFBufX5vyA7ieiEEYfzIqPcu4uU427fgxsNTNz0befRMnapC8Tq0xxyqngUO3mDYLcjzAGuCiFP/AKYNjetaH9fjE/TChWbWwNt4G4UlfElRaa4epROiYogcGaYl8Wxzf5rFKsU5Fkusj1VlnX+zsj24YwOGHPL4N1DZkU+pwHt0QVvdBzqnFkQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 6698418005D0; Thu, 29 Jan 2026 19:20:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 02/22] accel/system: Introduce hwaccel_enabled() helper
Date: Thu, 29 Jan 2026 20:19:47 +0100
Message-ID: <20260129192009.14707-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX7mwDuKSg0E9o
 mnxMNvGSMGmfbLneFnzCezbPkOPWvGx6HT+Aa9SxwBRkWI6xvKY381AztfSuIV+AWEXTzaG63BT
 d7lXfpvVFUIadWfw8pyl23FLYAJ1IzdYn1MRinUabUhuqQKtul7yIcOcGXscH2MKONv9D5zpVIK
 3Pb11h7HkUJZz8mr3hlip6mTYHsKChTlJIdnDZHghy28hGqrHysov7GFa9mkMywOK35nXOVZyQ4
 f/Ux8CnkmI6cyLzliPL+G4TDAaRZTIl/IIfXJdv0GBEwH3PULa68rJEESiNfLrH0xZ7qfrmhR/D
 Vwl+2lgFuuZiFgEmPPOx9GEpPErXTqerj4KRUV5Ci14Uw6tr1Vg/rvGiQW+/iw=
X-Proofpoint-GUID: 8RkiDrklnaNJe2_lFPtMCpeHLtA5VTPC
X-Authority-Info-Out: v=2.4 cv=XZmEDY55 c=1 sm=1 tr=0 ts=697bb2f7
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8RkiDrklnaNJe2_lFPtMCpeHLtA5VTPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABnTd63JXmR30+4fPTW98caPmsZh2vNPcdltYRDf2iXIvbfrBTOml8BBH8xGZkSog3QirQIJMLeMVPNrZSW8jb5Ochex1oKp31Ct5G7j1LufE4WaKFqUoDZtzZSlxdesMbCwvvNiaTbhCMfvqz65BFrYvmqfbUdcq218F966kwToXy8wt5wZSpv3T+oYI2X6YT0Y0dCoL3MC8KLR8N5YfMSXQiqsPPbOqaM/wxSw5zU6DCNGLBcU59JHvNAdzGfVNoBRUJs2INOeWYn8Z/AefiL1VKg74vTM80ysNE++wooro5aH60/t9+XlQun57QVY1aYRieQ0O2yqzCccWmhieTho/V+8oaJnQ3j7j8BL3NMt4TgZbWTP7ghgXJ1kybY3wBM/VqD01XbdZ8ABirAuqh+yrbOGqmgVYZLhuhbd70NJ/QsInUjAUp3aK4umdgokVDVApDoBszk2+XLIcEAIXXVSHpil+CddFW5ruSZpPAY5EhBVx+Obesh/+FZJlrOI5D8UQFOMksP3Ak+4WXjd7b8NCAUkKIpHPhtVSl6qpSkGYTUMSLSwaKHUmKdRfCDTDz6AeYftnPTd+DjAfP1r3sAPHekmm+s4I21F7duzqtBI5BQBkjX1mp5KXULDKSJ16xmQy2J3OZZ74LWDWv8n/gJqMLxYjHnEAmpJWiftnQakA4ba5gGinG6wZWK6kmisnKYz9huWSETXdkhReYu0IogQaFUWUsU8dLCCI5WrBGEYAyjemoEbkVe6g5auk3bc1lpQlHX15dlHufScSYr8MouUivzEKRYx4rqMMSD7FcHhS4dGQd/CFVlT8JNdrjrw2/Ay+6c1FFk1PRZDdlJqf30eQPrQLxNrpgjDODjgfZrPVo41DpGg==
Received-SPF: pass client-ip=57.103.89.235;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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


