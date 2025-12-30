Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDDAE92FE3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNE7-00068A-JV; Mon, 29 Dec 2025 19:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNE3-00065v-CC
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:35 -0500
Received: from p-east2-cluster6-host6-snip4-2.eps.apple.com ([57.103.76.223]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNE0-0003g4-RB
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:34 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 2FD6918000BF; Tue, 30 Dec 2025 00:04:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Se0g1VKRg3DjgzK0LZc7TwLED6q3ZUdxA1NWOSx7r1uxYRlz25akrcG0/hlVgNvkweXnW1xCrfOlgcOKiqjTOZBTPppZfyvJvm/cy73Q+FazL2phxOPV/zIjsGJ7AFs+RGE6Ij3uIo6K4YYRuz12DCKfd4LaRpOxqUjPtsBKH5rIiYC5hY9S1U6Pp7gYyk66dx9eWgkInJDUJ47yfT/XE6vhNwKIH0Dzcn+4gWh+Sguzxf+6qfdO6WCtX9wT4SsRI4P4WVLSvYvTAaG5udyfrGEaQYDeW8WCcew8xiLAeZocvRQCGpVVLi9CQPTPMfvnLpgYabTe61hkzcxOKsG5Aw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 22FE21800476; Tue, 30 Dec 2025 00:04:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 03/28] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Tue, 30 Dec 2025 01:03:35 +0100
Message-ID: <20251230000401.72124-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfXyXkUAZd4ITq2
 DjTZnkeu1btv7GBNG3EDOHiMnr3h66LHdc2h30gqChlIzP98b2EUKZ8ELFhOP0EQSNXs/xMQjlg
 bksiYsvYiiOyw255fcFHDQCJKmPfqCKB+83C+o7u8d5ZCefPR4sWMxTAdi9IkGwhVUGWb56/QJ0
 xaFQEJg/4MWcsfMSus7xW+bJR+6uNoQPAKKBBo7sO3/Aw1dI4EiOqIFICSbRebAEd8KAEKw9sTA
 n+ZjzZQ1+7MUJOp01S7cR5j0/0Mq0G6hbN459blbbwgZQl3tREQpZPXBB8L0jQWQYLF9CQX2noW
 XQJ2QUqltn9PmMiUGjL
X-Proofpoint-GUID: TlCDSoLcv5FADbGvH1upDxAB0JBZ711U
X-Authority-Info: v=2.4 cv=d+b4CBjE c=1 sm=1 tr=0 ts=6953170f cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=1t8nasy7xzbR8br5Zw8A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TlCDSoLcv5FADbGvH1upDxAB0JBZ711U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1030
 adultscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290222
X-JNJ: AAAAAAAB114fQsAYS/fvcdnwLASkJw1XctKmQQi2Dxmt2DH/MLBbzoUp3jDK07Yc4W8Ou9QSsA+RBWib2eX7cmrodwyz11mNqzIGhKOziIQTCz2aRHRt1P0jQweqaSM5WKxav0knMPiPjRpLTlg4XCkG6F32pUT8TjFj/wcZgplUuTQC5aiBpieYqqrCTO0yl+17z5CiJqWVCVRj88/gSB65G/UZ0vm0mmwXq+MKaWumS2sLTLIpf4Gio3ausMqyHL1ZZEar7ABTTVh2Yvm0/nuRhdo+jzE+AkB0UfZCIifheqtEIYkvX9b4FYpEBWTqBPPwtxwJpUtfUbRGgBiAEf5ZMv62xybRqOIdQcWOIjupwG2JP4v6ht3EFVMZHNTZf3VPhA6IzFg3vjJarGnVBpQbmnZUEVqB45FPWeQk2a9iW1zU/r6DJ00kaDlJ3cB2ARMWZw8UjyjCjYA7Lh9vrB3aYbuISSPLeKcfcAte3Jld3+1aBQ/LV2GlaJgIdCIskTYw6yOBfNg0NHSTme8QrJoqUQ3u9esZxOpvWARuNF9VKYOFnAhqhp7xjoQ9h+m0XKPHlkKht+8sxgMtUnlscgVG1WH9SqEaOlsy0UZ1eM9dMYk+S7ZcLna5zTIpVbK0gDXp+/Z5KLO3qWKSm+Zj1QFz9Pq/+kyOAIVRpA55MCAHrMCN3fC1+DNsp/cMW36yF4ZhchMaDdNlQwcjXX5kgN3rTYmz7SKdS2LPtw/88En9nmCbkHZSVUd2Kz9IyQcWro/yLoPXM/nMeSMG70wbLdA1Sr7BhTpMIxz7ngRNuiJQrYVZLhjo1SdjO2M5PfQeEGe3ACSf5G1tSk2iOk0Dbcvzlz50ORDjYtVD6jqMW1yKSMIhEV0JTyfJMLeKsXq7xbcDLr4kLXkK6BoAFGl7Ee6shLYkkxgvROgHQ5QJTgMEf3WScYtk0XJwzeLm3/hHwQAjYn8=
Received-SPF: pass client-ip=57.103.76.223;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bfc4d60124 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


