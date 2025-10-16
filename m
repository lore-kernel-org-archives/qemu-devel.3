Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD534CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RHm-0000kI-Px; Thu, 16 Oct 2025 12:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHk-0000j6-Ra
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:04 -0400
Received: from p-east2-cluster3-host8-snip4-10.eps.apple.com ([57.103.77.251]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHf-0001Y0-Ka
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:04 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 A43D418004B8; Thu, 16 Oct 2025 16:56:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=nGiC4vvLFeGAkADkjW8ilOYUekcixIQky++Ch/YLq1E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=aNJT16tkt+vUVMUOid7yxBIV7Hv2XqidUy/lyY9mQ7ekLGWclZ5Po/kkaS0aDANnlubOYwfazWHXuXUwzt44+ZbE8TMl3fL0A1GTjqbhLZdot0m3d9sRpQ7i5vPH11tN/8BN/QcLPZk+93LpBWKQCJhDUIYWJrWC6wNe95h3Pnl+9LWJDXGW+GFURJu00fiQ0wTfva2O1X533ESUSTq1HOJ6WwCWrpL7+5FOOCr+ZCumlGJwgIzGmbONME6Wj2jMWddzo65+HliOhPsehKQ9OFbZ6jiN+wI2wQuiXeQvEyN5NIyHXEA2LlCFpBswjsE3qmX0nMjf2ZJqfDBalbwJYg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 AC18818015CB; Thu, 16 Oct 2025 16:55:26 +0000 (UTC)
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
 Roman Bolshakov <rbolshakov@ddn.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v7 01/24] target/arm/kvm: add constants for new PSCI versions
Date: Thu, 16 Oct 2025 18:54:57 +0200
Message-ID: <20251016165520.62532-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2P6_nQ2K_PRuQ02V8I4qDASI7ROqXait
X-Proofpoint-GUID: 2P6_nQ2K_PRuQ02V8I4qDASI7ROqXait
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfXxB5pnUHnDdsi
 mz6YyRcCSi5qjr9uWadFnzELq2h1KKKtv8X/17mjYVwfWsQhUgOlpN+lmtx3ehV/8xOgGWc7GxT
 RE8I2frzn/+FgwNThJi3u1+QTTI1y+nGGYi94a/RWVvDVszbesxzbltq6luc4XDtLjFevTHVPNp
 mwX7JwZIMwjUGyZ5axUIq0ZJ8GPmjOtwESJm5SlToKFlBO5+3WxlcPA88loJKcdSDmmY6D8hOd8
 mz45lvciM9JjeU3y2INUA4/QVOe+R5fH2UB+lgJKfeerF/gtWndpmZMvm+baPfNoPSlZ3Tsws=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxlogscore=989 mlxscore=0 clxscore=1030 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABBBnjGaA5gXCJrkVbwP6mm1FeJgj5gK6PMGMlGeibz3Uy+7iaEd48txmnGkRtl7V8kvn0bFrp55QwD6iQWn/NwDhwh+koz6t5763lUHtRjBYrHR9Uy7xs83ks16Yldg4SLSis0kW1XXWO2otvtJUbDdDFp1uVKQsemOHttSDWXqkbrVyB58pH9snscfBXh9izk9ItSvDo2OkSSr7Ft4c+JMeeCfYnUX7iC0BBUkEQnNClCtIxRcNplf7rkEMh+7qYYROmd5Giz2diWmm9Y7ypRhKnBwx90NTIXDYG1pbinPxvXAo108TXvDG1rpeT7cXYmFa3AiA97Qt6qBWFn+fLyY0TZ0rJRoQ16i7cV3IGc4FWVBfEb46gaMaVt9jI9yD9UnhsPp0W4t+SonQZRI5bXH6kxF4Vvl75Bpt/lBCYHoEsWYLVLxcVhH6i0L2ZRPqpqDDBfWeuRzAXjpznnuG2Xqljvs1PwsQESxVLGb+IiaZjWdHkDUWoJevjJQ4CdkG6XncDOvqVNFMWh2iKoW32VBPhzaBRr0Nsgrtf+8P5sa0EpBirgjC5Ii8TwOJr9L7tKSNiozKJDO//HMLZJ9aWFeeeyF0HiRd3WH+/ZspR31klc6wXyMH8ezBqZioyoM3LXGr/oK1LB7ogCzLo4tcWv8ffIdJl95NAeVEfKFsUHHvkSouFvbi69PGqwgE1Mq9fvbH3n+mXUgyLGMzgXE7bGwM8BhRmKSRphzTeVw6sray1OTZh8Giu3VRNtilHu1piiT5z/A6EW4KuzpUWl4MWz6sFczpKrMVxDbezsi9LuJuKCnI5zvju1QccpkHi6ro7mJ1swjQNhRhZImAcvpN6YNuruuqOBMj+vw4bPh6tSeKdRF9dcFTAVfH3Bdy6IBIAWSk09bTaO80Gim5+
Received-SPF: pass client-ip=57.103.77.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
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


