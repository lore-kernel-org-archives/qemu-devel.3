Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2CACCD1A4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RHp-0000m8-7D; Thu, 16 Oct 2025 12:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHm-0000je-1w
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:06 -0400
Received: from p-east2-cluster3-host5-snip4-5.eps.apple.com ([57.103.77.196]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHg-0001YR-T2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:05 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 CF92318015CB; Thu, 16 Oct 2025 16:56:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=aRq3YU5535mG5uSPAFBSlmsbBJkL1R5+IAqIsTf/zZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Z4TrpHlZmLiaLR6Sg1KrtcVpRUdNZUOOVtXdn76Gguh7R0omitbqSciTYNm9CSSTxCLroGH5Oq3BhJkRv78WG/dYtVViwBn9Y/GOzhsNa6Qyr5IeGZ0M7sJYpzy1EObnXCMQ9DpThz/cYBnay7OS/17h1yaweIfgFi8TJL701+T+5saL7iGKWS+dM844t4cKj9gVAzRnLMHTNRNX87ytVF8Jdo9/4rINXtjuxUY13zlMXhJv/pooqU0fjvL6Q7/xPNMb1wIUpiHboUrZ4H0fVnjVNeNvfJ8d+NNY/ds4mZnHRIoJeGzL4aAwjXx4RaKL/sWo30mijvIPSswvS6I0vQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 2184A18015DD; Thu, 16 Oct 2025 16:55:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 02/24] accel/system: Introduce hwaccel_enabled() helper
Date: Thu, 16 Oct 2025 18:54:58 +0200
Message-ID: <20251016165520.62532-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vD5EzDsWCJz4Z4lDlJyrb8NHhGphDKRR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX4c29NuAP62vx
 lTfiBTU/UN9satvFymRaGrJr+ozALLeyWBy+kK6mX6ktyoo8AIsD/AAHG8DLFEoZw7faBXmPOGs
 K5oZfSRefZs/vTcpT5bP9qajfO/pWalQADviaqFCYcREcFv/JUfysmARbjJanmXXgRtWXDgvM2Z
 oTwS4z44x7T1+w/giJD4Mlnz+mqE0iN017gd51os/sWXnFLDttORgJV85TUYk6S824qjHHmMmjs
 BHFAQNN6nsBfBlnqspd74B1bXf5Gt9VCvBSEO4oCjg4L+PonFupkhzWkiQH3UZiwj3in0gE7Y=
X-Proofpoint-ORIG-GUID: vD5EzDsWCJz4Z4lDlJyrb8NHhGphDKRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 clxscore=1030 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABsmOASnny4X2CRFISDUbWAtSRsuUB/eYQp2Tlz+REZhLD17j/M+mLXozH6hRgFS7TfkM5HBZvre8qOLBNaiHviMRILOC/thqjPRB751ZbBaWVN3DKsrEdOd8m2nJdl/3jMLmKg08975dRcRT/psDQSdiUrr8CdNvcSFvc1ff99ag4eMME+Sc5/Pe6GSKxFACpOxnXw3Wd8j4x1+4lgYS5aW2RztNm7oZeoXCpG/MppSc5+t3B5Ww6oxAf+CUQXGNi9+kIIHnVwmtv87c6R+1OpAk1y1g8aJO+CSHKyC3/k7J5zxOdn6I4TAsxPA+yXdjzPDUdKIKT1UJe55YU1VAl2odOGvoUrw1NP0KgHRduBZA+FlXt1LRKtssKXfiwsAk5pdml46GfoEx0+AuzFJdCYIYnJnLLQEvqyeyt2XQbh/SbH6yG31tm1n1VSIeyaM+PSDy/812uQ6uFrr3o50F6hfphuv9SXVGQ+8WNQM3Koe4VskBZI5RoPTTLy/0pSfuNbYEJ9ORBnWB238baSQLBwzjIeOZ3hs5vV0thMvTu44JHmFNYGvCLXl3PRDbqBwv1p1SIXvFtKg3hl2QfAkoNf7+EHjVFNZMsMw4DcEtryy+X0Dg1oaNBTvobxlFX/UgM7ZTYZjqWlCjmrI2fVlMKXZU7q/xvixkxXpqtftJyDkS8RUe09HRGUiIC1rmXFIDcQix/i5HP9koFZIM8owDzS7ybt8cNg0P9mZgX3M9LlObJpWuy5EpMC3olZ0FCHuLTtuyLKIrMlN4pDY3qmxtT4hAC9r+/CB25d+dgpWlTXqb1o/+8yS9HubErahJlZkqAZGtU3Os7EVya1eXFefIweSIGeGycCZnE51Jj5z/gAt9Uh8SZGPbs+Lc9srHCngyTLzNsRuBJbwrHZ6akjHrmyMITUg==
Received-SPF: pass client-ip=57.103.77.196;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


