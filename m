Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76085E9129A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0J6-0000o5-5H; Thu, 05 Feb 2026 09:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0J0-0000lu-4y
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:03 -0500
Received: from qs-2002j-snip4-11.eps.apple.com ([57.103.87.231]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Ix-0007ow-Q7
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:01 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 92BE91800D8E; Thu,  5 Feb 2026 14:25:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301559; x=1772893559;
 bh=rqevPYI5PNmYfO37aWp6zQDTk/Z3PG7nW7DuJwvRyUM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=eWpboVVlzJFCqBmLgbwNlHMcFB0hEODWNHcWscT81dby4jxVLH0zwSy9jfFuiNbDklppWjwzu75UFEjK8FMBk4vvRE6HM/NfyoDdY1Nd1fv9P6GS0Su8H0uq7Lzg6G0Pq9pjnaqq3ybus31JAOnSsZVBe7z9T3aJgbNL1mGNmvAVeOFKHXy5kh233ufzxsijHARBu4Fs4TmEJI5tb2ADenCqQxDZHB/TWC5+xFCDBCM9cmEGDaYHCAKo9NspSlTcA0ZABO5Q6AudOigyse37FeyY1dOVh7cbl8liABuWg/PzVsMcbapcu3e88SqoYkfD43cSQVeQ0q6SKu63xjYeRg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 5AEC2180027B; Thu,  5 Feb 2026 14:25:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 02/22] accel/system: Introduce hwaccel_enabled() helper
Date: Thu,  5 Feb 2026 15:25:20 +0100
Message-ID: <20260205142543.64818-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8tD6QiDTpZMLH8UuSsLGQXC5ZJqFhADU
X-Proofpoint-GUID: 8tD6QiDTpZMLH8UuSsLGQXC5ZJqFhADU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX4so4QKJgC6sB
 KtsmE2iL4wPZEoLhkKPuCdPQ6U0oncf6Sjm8Emmn9u4bHhzULudRd0W2bxzPQBD3e5bV8twwOah
 tTfNBZfuH1TIkoNQkRjB2d7bu+JMAI9sGTvBpohOy6gxmlcwIsa5jLvjJy7XVZw0zQghPC3alGv
 stNf9mxpXshCij/TbxbTRJmrt5I8BFEJVIq0N2WWVExLCAgHl2stz8S/LW3yAnVVRiMCI9Gs0tL
 lX4iOeGBTJsToXd1+0sxWXUY92mQaVijA7bIF2OxYTQ0o6uWpnOrwL12UKJBT+OcklrS4wAm4h7
 Faka4ZFwQKMeywYL8frZY+zOiiEJMdIfxO5zmy37soi1xYyI1z73WRz2Rg9EBI=
X-Authority-Info-Out: v=2.4 cv=dLerWeZb c=1 sm=1 tr=0 ts=6984a875
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 clxscore=1030 spamscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABkaiDMd8DfTFQWRhWeYZsJrTMio/BJX+Nt4Q5U62TIGe4shOWXMnpUTACuz7Y9+5dslg5Ao22+qO0sCgfwNpG/A+AhaJF0l0NHI/JkRGk5oa/kDR8uRrqcJ9HM2h5rYoj+SM06fuVFVfb2ZH2iuWqFBYhehMUg+M30kiMHuuf/W6CJJHDdA12uk/GJaQ7bxAegHiDXZrcmgGYK9/CLs0Z3bcotT1PoybWYuPzCh2C2gHSyZiUQl+PnbRC602ZwJ7imNsazMlVTMfsozr2fjHtfKXazesT/ABzyTOVeUuPHhcv6199BNNeRxCbfj4omLq7qwl/VbJ5NskPmLeV6+nniRWqcyzgnFO1KvL59qYeCboS5yP7dzx56tdQJ/58PxcVUBqr6fcPHyBUsCC3RkyrTAod0L/yKhckL97T8APSge1c5J0rNP20EURvjDF0hFXOoIcE0l8Qs5D1XcZZyOobFeDCswvFZmeXiQISQD9SWr++7WgF+QTkVydmX28Qmp4/R6THsdCr64/xMU3klp7UpaOYKOViOPp977SCWeXNsPbjjyN9QyxJ3nasybxbtB2PiFMgBgHOq937ZT5x81UOil4aHPeWRpcj/3I82/7rJ2JTL0I4Kxr6hZZCOzpYSz49F2aR2Isi0YIo7/PnnuB1/MoKMUDVnxax/41IH/08MQJEYKAWf+ijMk+fuoQZaDaK5t3Ha7zhnIbb1lmm+UEPzgoQfygS1/q4JjCkUep6aqsik9kf1XTjLtq2c47KYzhWi2tDguNjTAbuCESntGXRTsDMOEJegpPZvX18GC1Zc+GcRNIpVNddfEWBRVrg63rC+rQWQhh90F9LiFRlc5ioETTrJbHtLINm5uYWk5TjVNaATxCT+9qJ82BHKcw7dTP+TMRxov+clVkeYkQrKzBRJah5NCXBlWtRxL+mWzHPXklqMmlsyIK2JQnIHVgHz0PKH+sKqWP5VLM=
Received-SPF: pass client-ip=57.103.87.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


