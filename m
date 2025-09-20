Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56528CAC5A8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyAG-0006NU-7J; Sat, 20 Sep 2025 10:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyA8-0006Lp-Gk
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:05 -0400
Received: from p-east3-cluster4-host5-snip4-10.eps.apple.com ([57.103.84.53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyA6-0007is-TI
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:04 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 79B1118172B1; Sat, 20 Sep 2025 14:01:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=eeT/YbFgYShwKXnEHJa6J4507nsTPfKIv6b6mtMjEHg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Rqy03qhdIs1EFS/ZyY2jw9hca5NzQJQMwiRfEPs4SukbOgZu28khrT4nPdFFqF7+d9PgyBfSNi5lzATPw6CZlzvtLyrWKxsrmR4rNoj2VgxuU3gDj+7eA4OG4IYG6Koc+qYsH8TdmQ8P6aSRF3w4nuFvlMTsUhWdlJKICMUI/30pKSSWTbP52XOicD06CUwrwfKyy7EYN6oAvbr3AYoMYdklte5goHbV0e7T8+54/R+VPdwJDEy2rNyrKtcTqxzcQeDo8TGgXWPtWqLkkkoMJAv/apdu443F8VBeWA58oW3OCsdR5pIF7H0ZskeLkpPqEuMekGhj72thnQeS1jrPUw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 A2A421817266; Sat, 20 Sep 2025 14:01:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v6 01/23] target/arm/kvm: add constants for new PSCI versions
Date: Sat, 20 Sep 2025 16:01:02 +0200
Message-ID: <20250920140124.63046-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k17n26mTSa35KUYEk3o98Riozrr78qOD
X-Proofpoint-GUID: k17n26mTSa35KUYEk3o98Riozrr78qOD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfX/M8qCra4MTV9
 tUoHmZoHGOZToQVCcajsy/PcwBgiOnOOfz3C/AsjVN911z3u2aNthe/vx/sBoYsNbiBY6iN4UYe
 dsknwkIV1kDTdj1cTYgWgMg1hKdiYbFL54e2hcCMxMX9EZsTwnLBhb4nccU8yvsxEgNkYnAI2NJ
 TCquC7MSzBbFNV3ebIl9CuvE02CNt/lOjDkUIAuHSQl23CvWdGy3eELTac8GIh9AFLcbi913bN9
 5wSBTnveXheV7uW0UWM0U3qtpn16wDm8KPso5BKMDqtj9ayAlHaZBdiqafbTpwzis11RHAFi4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=968 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1030 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABapcCK+84cQiSwPl35THzvb/5uGdOoidliYK+ZB43ySAvKcpCSLPFEXQRclcXzme+q93A8S/GyNkK63pAIoGGhnmgNDfZrhhsVo5GERBdfldyA4DMA8e0Zpu2R7bRMUjXbwk6PKDKyHmEnGsZDe6fpZt/7k+wlxLaD2SCBjCsJHjMUHKwLcyjUVXWFxzx/3UtKoHXtdwcUVkFwBVp1d34HozbCS6sUzUxell4kPFzXpW5Zcp/MuLUyntcY+GFqNKE7DYpIeNd9nYCw6S6an7/S4Vqsc5mvB/yK3hRzGVOEDCVf9AZ1brYdf1aYmkvPooOqGZEPktO8ua1yhDIlrqdB2e9kSGoKcRQR/+4Sz1gyazlcImALceFLJt7qAMWrB2pbN/V9k4kTDc/aadxWBs/qbcuiPBTWH/ObRy5DuNCzHveS7+DPN5feVrvUywP+XZQ2XNVSRXAkVGXaxzMYd2gzCS8P26W+Z/1wWQERyKJDzIJBd/kUWzamv1PMii5xTVh4iRQRRD1wC2fbPstv7b59BaXrkDXd9zGJgvCr8f7GJsIVJBNHSIKXRQL/9Zb+sRqqUB+Vl2laVGxTU2J+9sQYx7s4MKRBEK0pXRq7So4efV6/JZXPLqIJcFAYlZzr/wd/h/zeTV9fpclAd/QHDWSpKeyGKTFjfqkBmqyZIxDH2erfhufqiBIfJgyc4v8tEnqCjV5fXwPyyJy/RDbbjdXKh2Kzvzvqn9R/Vql9dETW8BJNopUzpqJzjmKRFz5knQWy8T+Rq+6R96nqk+DDhUfTV819hlZCa2N0+AMHr0iZfiwzalQDNkznU6jN6mqLPrBZqP+kzsCcD3H+G2K3vyTV9xAKMw5+AB8xPG6KJicgM7CTTuMlP4=
Received-SPF: pass client-ip=57.103.84.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index c44d23dbe7..239a8801df 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.50.1 (Apple Git-155)


