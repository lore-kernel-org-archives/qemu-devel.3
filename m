Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703CFE784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0bt-0004ON-QE; Sun, 28 Dec 2025 18:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0bq-0004MY-3V
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:55:38 -0500
Received: from p-west1-cluster3-host3-snip4-4.eps.apple.com ([57.103.66.67]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0bn-0006Jd-L7
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:55:37 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 1DCC31800149; Sun, 28 Dec 2025 23:55:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SleugD5OwwHvq60FCCY9XJKbneAtTEhxhwh1FA3hN4cMn5sdRyX/lilZdcKo4pXDn4EoW4rxTuB1VtFS/cAaByMjjkz9ORCnpCy/l6S+lBFSS3PDdeQaIUCbQcmyc1JjyNd7KzfK3cfYhdy7nBolag64MXJRFusTQGtpRjlvbQq7lrM2cpX0sHqgLYK+y8dwrQLYsQDEFH3CSPUobGp00OvM0aDuPAcp5AOUp+sdfNFkscH3jZdU3CUO2/rTX+ezXlBOLd2aJs++zZptq0khHkDtaSJMiHJZyJYuh8xZn8VnwAYuGef+7tP8fsYQEhOxxwsaw75mYDVNknYM4e8HTw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 C2F12180015B; Sun, 28 Dec 2025 23:55:27 +0000 (UTC)
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
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v12 01/28] target/arm/kvm: add constants for new PSCI versions
Date: Mon, 29 Dec 2025 00:53:55 +0100
Message-ID: <20251228235422.30383-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SNZ6xNcKZ3xBEpaTKHVSyrO12DX6ztHo
X-Authority-Info: v=2.4 cv=PKACOPqC c=1 sm=1 tr=0 ts=6951c376 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=DAm2dGrMCKCYv6Tpj9cA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: SNZ6xNcKZ3xBEpaTKHVSyrO12DX6ztHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX22FNvVgOBC1F
 XVrjDt7R7aVMvB7hE2+UyJzmf4R/+xlw8IdnmpD+WdONSHoUPAP4T7aoZ8c0oAXuMTEmpe43SRw
 AmhT7FYbao4t6UezqNjgTo30+8HONY1c3sI7U7Iy1b24/4g4ltxHV8SSFPQY0yBdsCTKZ0jUO71
 psNxH48Bkvyn1RQ6h/0YFzyXG+3uzqsX54IwPhDZl7Zeu3pmYcm6K6ggJXEPFzVfGZHZ9OVnkpW
 R1Df47g/ppOrFm95ropYn+zLdFnOcPcMlfVRo1Cw10KeHisKASAWl/s7ht0wqKNNWN6sH7QLi0T
 Znz5Qvo3s8pYI5b6oUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1030
 phishscore=0 mlxlogscore=942
 adultscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABTnVjIl+sOYrF97gB4T3WCtY9hMXrp2t8yNWUV1e7RRPxOKoaRU8qYJnXnz8DLe7C5QeJ9crIXPha6g5D29bXXK8TyBpbJ5H9/KevwEO5GraIZ1M3DjTgNC+wrZi+TMFEzRfpXsVNg/d75uI9cNWyASHLl3nt7Z9jaXfAT3f2+KPyPmAcnsosfjQk/tSoSbwg9eQXAbkUL9nezwc70A7gb+mEdw0FNr6CLP45s6X3FfotJa1H6k9bYov6j3UlXKTJoaq1uisA/8fvytcIIZvZHpy/WkLo3FzyS/0W+fttv4qKpUX5o4PeKMDJsg3tahIye7TFYf5SRR2SCP2uTD18feA/JSODylECxG99mAZGnpmgg/PEDpMJZwpwSNdORRjy95gVYrw8NmZg3fVZyNLGL936Wmkba907JUbcjqZFyClLKDbUHJi2mKW3o/ajQSluFWS+YMobASCAvUcrLfDYnINdJlIXFAUnEtnpnpi5C0t5ZNwCI+KrKhWHnPhIFaGIRE5gTTn0YcFyOBNyEQGnAK4blY3BUSa5ypDk9wSt6VSYvJJtKuu3pqBZXDNcfWctpTYmgOW5JdQdOspxvxgTNgMzZ1ZZotbrfpif6ZTk2uWFi7yWUDtA13sv5+SrnadRJaZDVlYNSLlDAkxdbb2K/LQD7xZNWu7m34qQCE0ab1tN09MxyDoTpBAuDmcd+OggH5vEB1Ij7D7ISsmcub3yzWl1WWVwruEl34HnquCCSQi0Bzv7B0vMW1bI8vwhFO/gvl+ZFY7S9BWRv/gYBfRVCFvjxA1BG5Ejlew18AN4Db8PLUOh6L/s+dZt+xJjmdpnGpA7+4dUX1nIOpARTc7MBdA0H4TnEPWSVQ+LiDyhZoRB2w4CNNcWjW+1Bub7B1Zj+QqXBG0ytthYCQokS1G6amawjnxD8TONKk8acR3VWhn6ZUmPPX3VPx+9LO9XzR/tHQvZXCK4068ahfC5jOI=
Received-SPF: pass client-ip=57.103.66.67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


