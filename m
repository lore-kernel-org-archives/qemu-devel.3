Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECFFF513F4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMdl-0005lf-AP; Thu, 05 Mar 2026 23:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdj-0005kJ-AX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:15 -0500
Received: from p-west2-cluster1-host7-snip4-1.eps.apple.com ([57.103.68.84]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdh-0002Ty-Ll
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:14 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 6215D1800107; Fri,  6 Mar 2026 04:18:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770692; x=1775362692;
 bh=piYFY6zwrd04Sa9xxLjLf/dk2zFIxF6bTXzzDY0hs/Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=SxwNKHHjBWXCz/TFG4il2Kx9jW2nlyNWEe9Ll0NinSJUYd3dqtUUMVhsa6pY0Xw293Q3nB8KtE9XGlmmpOJBJcKJi+HakSlu1UwFGrzR+c9FFQebsAGt8lfP/9cMefIu2VSGJT12FcekGWJ1oOJeXAuBTzTUsEGzVHNjh/t9UV2cll0L5X91ob+mQku76KTrJJFWPPScCzPSvzQTR4GJ2lWUkOi+gPPzSNeFGYWWHFbc37TFVuYGZV5CHmOX5w41UbjO2xqkovbPmPDYdT6YqAsH3E3nsEwczLfvLXgmbwbl7YRldQ64tpwh133o+Xw8GfenbnQdrw6kgB+eDqk9XA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 37405180054A; Fri,  6 Mar 2026 04:18:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v12 08/15] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Fri,  6 Mar 2026 05:17:39 +0100
Message-ID: <20260306041747.54554-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfX+5MyvbfVcUH6
 t9PJeFwVhgNo5tP2ObJUeRoNHDz8Wo8ww7HVTBkfrEDF8EIiF90Lqp6PErc0BNRhVW0N5wBQHwQ
 6b2/DlN9e7ulnHegovg5+kxYVdeyUbxCOwftqDSeo4/w8o3+dyMVw6EtI2J4B/4Ch2yg0noi+vf
 ttHr7jVJHU2LbJ6IOqmzpev9YkZOLsm+CdVNpr0eTXooO8HW1h9KynNsLxrKtVshtDvTcYXag4Y
 mG/89Q7dVTk0i4IBXRlJXGcwENt2uw46sL3MRyfOwTDbAzvq6gk6kkw6Sd4Rd0DV0GYHBt6i+i4
 i9JLo2mBm6PcE/gZiystup6B9Pqcgcrg8HqEFQIAIJJsJeQnBN8yp8vbGLAQ7I=
X-Authority-Info-Out: v=2.4 cv=beFmkePB c=1 sm=1 tr=0 ts=69aa5584
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PzQS8Z__MZ2uSZov3vkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EZLCi0EpHgdD1hZNPGwdiuWvUPcF2-S4
X-Proofpoint-GUID: EZLCi0EpHgdD1hZNPGwdiuWvUPcF2-S4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=910
 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAABkl0AIsapnPoN4p0F5BwirAaYCT+1ijGJekW02uLNdfv9W79CfB4OOAcQl7mlAgJDQ3eWx5rm6mXmX2lLMeRjLTE0GTBU5WyiM0VoxbZULHfRutjc+nrRrYRyCXWeFbdWd23ABkWrjwG20iGEnKOwEh1lL3UiigGpY5g5V+ap3L5xqE+G3cSKYxbkjHkcCMAEhrFLbVyDxaHfVlbM8Dvz/TXIdHQFw+YyInaBWQ6D4I3UcJKE8VddNhORMlL5YKXA3iJ/M0TejGIE2GUbkJMc+XSkD9bYyvydDhdoNxgDT6/88wBdiAH0goqzVLTKD8i7ElHPcEC2TpotbLDFBu5p/2gJUVZ0FVzz8ZR5QDnhDdccqk++rPZgeBbgcfNIbiZAEqpe9R1i6F1my5mybAATOTFbsKA6eIVB8VnePve6Ne9tML408bOe1zFFyOH3QoTD+2caIIFJFeLgnpkHICAkyJVp/WtP/6lV2J2x5N9OQeFpiDcG38VB5CnoJoAVqGHKZHuWco0RS3ZKaVCJnD3G+WIsqrjckBl4lkgZ2FmeE6D0YiFhv2lN6ufiUe+jWJxDx+R5eDGowAOhZhbwJ0uKytG7YpxZq686gM1C7Krmmw8AoaCeNOnzn/1fxcmHz9R6G4JK6+Wj1r6UJfAHoHcdbTw++nlGFs5SOJn8jN3zDGbeKTQQbtzK6kJvoQfR8hO5T43snic93+Q12x39hAgLWjTWuQngYynxRb9PC6Rdn9fsUDvFpfAJhw==
Received-SPF: pass client-ip=57.103.68.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c90124338f..047b3601c9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2334,7 +2334,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
     switch (exit->reason) {
     case HV_EXIT_REASON_EXCEPTION:
-        hvf_sync_vtimer(cpu);
+        if (!hvf_irqchip_in_kernel()) {
+            hvf_sync_vtimer(cpu);
+        }
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
-- 
2.50.1 (Apple Git-155)


