Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B66EEC2B1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXu-0007zK-ER; Mon, 23 Feb 2026 18:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXp-0007Z7-4Y
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:53 -0500
Received: from qs-2003g-snip4-5.eps.apple.com ([57.103.86.68]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXn-0004UC-50
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:52 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 318DA1800395; Mon, 23 Feb 2026 23:40:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890050; x=1774482050;
 bh=9BGts0SO+ELvn9DPQ6ozA7TaG8Ww+N7E7c4pnrVSxIg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WuPiaSfSmXFMX53RCRmZeMpfr6ZQB7zwYfclsvc7SkjIhoEqrsYbGlkWCTouToDEOUSyPBls8rp9ugACbI08y3BU/jqB+Lh3qdHtgJVpKMRZhDivJ7jReB/D2jfu5weN0PbtG5ovOXL7F/+BiyuoHXIeVMNHpVt0iTaJdI4CL4AqhlNCsRBXqTsaOjWISowzXpjsVg+r1WmNlokyRkeIe1zZg7ve0QJpH0jCVN08UTBKu9up11QA9SKl/nrSzXDixJG3lDU8tZpXgWXVWokSPYZPw9Pv2wUEFXBaurhtElgtCCrh9jZWdLm39XOKsZWKrxPzBOtHZVh3Pz1lSgUxQg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 C19651800161; Mon, 23 Feb 2026 23:40:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 27/28] whpx: i386: ignore send_msi to interrupt vector 0
Date: Tue, 24 Feb 2026 00:39:49 +0100
Message-ID: <20260223233950.96076-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ds2OBX7QPwKU-qSa6fhIv3hqRn8fcs58
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfXzITFXzLo7eFy
 mS0f+KHADNCG8dVt9n1gW6vQBKOIk6nEHK+ytMsFpPl7JVGWAIfxf+TIEyLNH9NkrZKw02dlqUy
 nVaGut41nc9xk4CpfRrWPQLFYGVivjzHTXUNFd75/mbX6/CFdchi9G5tehqLhk8VNikCXXmWs6U
 WBZYWuO2qbTbY8nfQfynDXzhzV25ZHuISTsdoIptjgmhoUvih+zDPVk46QP3H2RjsBTQqJunTyG
 mdQhTQiQsCt77pl6d1dkqxsVhg4Q8XDGbNV9xW1rYBmz3twqoN0Ygq3o6qD0L2YG/STbp7cvwEn
 h9RBqeN1k2+ckNgwVAPIAPbsSA9hq8SDPhvKQoMt8d75IgKz/z4xmAr3+BPV8A=
X-Authority-Info-Out: v=2.4 cv=WItyn3sR c=1 sm=1 tr=0 ts=699ce581
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=P0CsU09aOh3OwRgeKFoA:9
X-Proofpoint-ORIG-GUID: Ds2OBX7QPwKU-qSa6fhIv3hqRn8fcs58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABxZKCxX7kfs1ZGwZHA3iJ5G1HqnG1IL9fTspOy/w6ygMxg3voKQ2lDy7FLOU/njoE52y8o7+08S3RDnjoSXIM+qEv/c87pO7+/KYdR04PQgzX2Qybbr5mgMR/ZylaHlR5HXAwNptpVmrVlvbT1DuU8k5NO3mn1H6hfzJjlesbskuyek0CEacj/o3RaKX6k6gevjJpVJk7uUiJPAFBijv10CdeOP/aeHR55Gi0HA2l/7WXnv1Tx91WcD3AzQ+W7NTmp2GvJzsWRa9pHLl9OdazLjYQTBAKqeXvv9nh8iigZXzby+X2dp0F5XKIJVz8nw/QOxPyPRA6OjeDrGMP7bdBuwp7a3y6slYmiaH0CXej6Y7TuoAVTqQAQnD+iwGHngLPtb91B1kUq9mrUL0bCGIWVxh3EZXtdySB8fdnrkbaxKtj9jFeJQd+iexC36Bxe/iE9zuK8cHtlBxfj1X7Y8kl5/AF57hhi7zEbK2tkIydQBz/wBZCujaKM8h2Ad1eVSNEiApt5fmH/bw2onGeD4/Z9OEJUEICD4hQkp1QRum5EpmTQ50INLS8YS5IwFEwAO7x8oSGXAVDsIRnHPQST8Sh2YbN9P5KlGL1Ed22ey5dHyuwOsMzIxUR/vZ8XNkPn3G4QyUg5af12rMnx6nr0teONZd5MlsNRA6zh/L6DvxjFYo3gX/JBYD4iCH20z3jUhS6roNEVXGrHT5/A0YLb212kZjr774WdKeWsn1Pi7Uz/MnUmhumT3hYiM9hFT6QXXEXZX3mzizizZm6dBjSYznOXcGk5z1rHBvnpzpT1CkRWg==
Received-SPF: pass client-ip=57.103.86.68;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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


