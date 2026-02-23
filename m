Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40C7E98E0D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRTh-0001w3-UW; Mon, 23 Feb 2026 03:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSq-0001BJ-O3
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:49 -0500
Received: from p-east2-cluster3-host7-snip4-3.eps.apple.com ([57.103.77.234]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSn-0002Lb-GE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:46 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 1C0F51800222; Mon, 23 Feb 2026 08:38:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835924; x=1774427924;
 bh=9BGts0SO+ELvn9DPQ6ozA7TaG8Ww+N7E7c4pnrVSxIg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=B2FKKIDXHo2gmpmJGFi8LibfHq8kJCHsgROUgWlg1dA64AAn/xK+IKtMoxdjeIKmXNl6bH/ZtGMzIZr2spwxcgvLW2JPlt1n3xkwVnR+yKMBsWGh0tqiJqGd36F5SYBO4bM2Qpiy0V3nULVy+Luw4842D9eMLS2IfSz8fF6t5urJ52TIs8xnDmskoct8lycKUn8Vyc5S53OL2fgUgxmUeXbPHVeY+Zbgjr2WZWBZMABip7Darx+27kOQY7AJ+EK6xoLjeU6jqNgn4gtUcQh3TyVFBbhrjvJ5YuNONFwJqGRPw7Mi04fUJJyIrF1xyIiLZyyUqPOF3wsljCBDyT/76g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 CA88E1800215; Mon, 23 Feb 2026 08:38:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 27/27] whpx: i386: ignore send_msi to interrupt vector 0
Date: Mon, 23 Feb 2026 09:37:33 +0100
Message-ID: <20260223083734.48533-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=U/efzOru c=1 sm=1 tr=0 ts=699c1214
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=P0CsU09aOh3OwRgeKFoA:9
X-Proofpoint-ORIG-GUID: MLStYARdgZTDIfSmQzhsB9lDgjtiWZkw
X-Proofpoint-GUID: MLStYARdgZTDIfSmQzhsB9lDgjtiWZkw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXzu5k77PfxO00
 wrwvwZW3a31RnGrsFzm9OpOwBXmCF4tSh+6cFd2BET3NxvsVV6OZKH1gNhberL+lej85VZl/vV5
 LekD4FbFt3VbIaSNOLcxK7XlXU2YG7RXoJba4yqlveBK2dwh0D3nvV4VGjSrraxIQS/uXqrSqa9
 EDSWso4EYt9txxg6g4QrNhzHZGqn6Wz+TKmlLcZU5KZWW0IpVPhl5iBXUZKmw5lzQ9SnKBD+6dh
 kzbTXOLTC49iV8hyVXgbmjWspWJm7Fk/qJtx+o54g07d/YDITOIixSkoY4yyKuHGpvODG6WMC+8
 gPZ6m81IpEDRMNO7ptR1BX0WUwjMt+urmeJDc0+4+tWljHDT3nMtalTyhTWwyc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0
 clxscore=1030 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABByb2izpc8SyX4Yc7GdW4d6wzLrbrIkCBOc+XcvNjc/1xloUNX9Gg7FM/yD6K1AIa8M6Xz/baVfx+TMpmtQDzdGQUe5FOm068dMvfNq5Pn3Ath7V783hPUKTgb5U7IuwiKO4f4Br+4K3zDoNQopb0KbCu/EDrSoAXMoVgIGOwX/0nxytl/bySiAG6voSP8BdqK31fRYS0KuWwNnuQXeZEbAsqmY+NzMjyPVGwSROzMPn6MU1chTSC7EL1jrZeQtt5NNWlChgGs1EKo1F43kdP4iR09UdyMiK4P3BWbYW7Y/YkAOZIetTH/1FsQMELRdd0I4YWg6kYNs110JcT2aK+WKyIDMZttivdGmTM3gYMyQRdR5nyDvnMbIRZojSHWXNmCfniqdRyj7A9ELpvPUiQvkglqm/D/ajQ3lsbqnoSAjS7bwL696bviU3Ud45KWJAXlorZh/U65TqUPQ9EeBOGhXl9K3kTTWJnxQqz0RIbsK/ZmUMuVzoibrUNj7eTBMkWav97voSr0FhIqR/LChXbupW6i7Yk32jR4Srtzffw6aOuqARgRGZXGEJzxVZCG9Sj3VeCyMHLzd1ndNQlLKHYJur2+kC21jbc4bH2o4QhpF5dFDT8hLCr7rqA5sMRgCCySAETbksZ/SQwjvOZbF/c/Gy4hQTVfTXqpDgi6yqys5EtgDKCL9MJPH40+qvY/bCaXMEC36FvWkzkjM0Na4z+3OaPvZIqmIDWLfKiz8D319s46gid7kkE4wsfvKatyhStvme5tfy0Jt8m5YNdL7s1iAqSbiK2Iliu+icgxudG3ZriqA1QPnfGPg==
Received-SPF: pass client-ip=57.103.77.234;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index b934fdcbe1..f26ecaf6e8 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -192,6 +192,11 @@ static void whpx_send_msi(MSIMessage *msg)
     uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
     uint8_t delivery = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
 
+    if (vector == 0) {
+        warn_report("Ignoring request for interrupt vector 0");
+        return;
+    }
+
     WHV_INTERRUPT_CONTROL interrupt = {
         /* Values correspond to delivery modes */
         .Type = delivery,
-- 
2.50.1 (Apple Git-155)


