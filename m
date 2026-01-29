Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6778DD73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXbx-0002nS-Q5; Thu, 29 Jan 2026 14:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXa0-0006f6-Uh
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:28 -0500
Received: from ci-2002c-snip4-3.eps.apple.com ([57.103.88.154]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZw-00069l-Q3
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:24 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 4626C1801891; Thu, 29 Jan 2026 19:21:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714468; x=1772306468;
 bh=ft7NDgYiYqiw1s4GAFgXJGjZ30ULMWoWyn6p+d+kiGo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=eSz7kh7dWPptDpQhzf0IFCe69bxAeqlQTO67Krj70SyexXQm+OavvpqHBg2Xp48yOC7mAuYVMOorIVv3A/VUoJ1bEdyV3QJHgkm47Zw4D8FfqbGXdowDS5QIByBPAqIr+FdL3+6af/NX+hMKDOO7PGZln6ySk/w4EF8s3QE7wfOv2nVmQgU3xxWwaUDbzBbRWUOFhWPvyzIw0v6ulSdVLh0SL9Dbkf7AwC355D5KlIC2dDmY9q63oUmBMEoBvbol8apHSoQSswrgniWeeuEBB6hQ64LZg6k3cm7dkBMW4mS/baC5mjCeGSol6zo58hQq+0vqJNoZ5K+c0J4WObbtpg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 BC05C18018B4; Thu, 29 Jan 2026 19:21:00 +0000 (UTC)
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
Subject: [PATCH v19 16/22] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Thu, 29 Jan 2026 20:20:01 +0100
Message-ID: <20260129192009.14707-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xrIIdjJVtSJ4DkcxLSicRuXE25PPPR-W
X-Proofpoint-GUID: xrIIdjJVtSJ4DkcxLSicRuXE25PPPR-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX+Svbk+sfdi6i
 xpzzCIS1N8GCY3jhF65BLF9XFjj1GgJrfFsls8BCtcN1Fpa90oAInxE6bnzORXm1590EQ20hBSp
 eNLPyCsHiPW6fbKCjG2hlpn4E3w86TcjP3KFQUpEU9ttIBdCh+CJZH6+VOZks5LM1STcjvCMYIL
 cIfgChBbNHR7X0w1YbhqdjQu8aqwr4SrqgoUDf/XygleS3C2rOxnqKUkqVnyHy4bnDYU3G2+ERD
 2UyuYGnRvwVQ6w9vfRzses4UBlz2UznnXsrym7SonFRVQN4D+FhWB1GXWi4Y9pnJCim5Se0aS1N
 FlJa3o8P6dLw4Eg+46mIrGBvjZCjypQzKd5m3xJzzP4FG4hD22rdX25xbHEFQk=
X-Authority-Info-Out: v=2.4 cv=ZYoQ98VA c=1 sm=1 tr=0 ts=697bb322
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=emIkxkYSJqCgyAM8kcYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1030
 bulkscore=0 mlxlogscore=993 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABWL2P2MAH8KhYlxW8jKIk+mivem8Cs/IaD3Tn94pbGABAMc1fppSP2XNAySA9zxKkX8tBL1rDAgP+6lz56tsebm2M3A2HkR413gKvHMlR9wPNcjgwUnXMnyx4kvkyPdSEXIkFje66u4tRp4IAqmTXuGDB5k6ULRoEysvNfOH2rWTpCKxJuwb+u/kjekXYImIxy9HvtbTOVfWJB11xaZUYQ9vWsk4lUI7LsKgyjANfTXvKwbXCJFUIWAmoS8DtQK16yNhkKfLj8HoJhvPKYySMaWtkZAt3j+ApuZ1XX/FnwGbrsTfw38r9yVE9ik0xvHlVT00Zfd62+NXgW9FElnsErT2xaLh5WxQ/RbKHa3nCnWS0KHnLoRLKvQMojPDxhnUrmxbq42nRfCZ8AN57zy+l01hARixAHx5eDLEk2XFvL3dyjse7Hl7gUXTcHfFsJbCwdMiQWquxPFK+/1y6vMF5+omrZLmoL03xwOwkYEalHL7pdHo1pVJ8/FRCc+vMzUTTdjpDw9AAaXKUnHl1fe81N7p4sKoRVCRvs0gV/M0MTXr4ZmGAfaN/kA/6+OlHBZ2GQF7d2u9T5JWw5WPsdpXxhH1E1iTPrrYU0wwhKigd3K1Zv494BjQVxupk3+2aXkt2AqiL1OwBReQCJ57nkviRj/4cbBQXDSg56C9kUVFtFI7XwM/DwHafS4b25tIxHSb1M5JssU4i+X31ZceqsAXbSC60zUbFTO+4JKzBjp02XJ6FTJEtzfaJKQ36F6PhfZXa6mutxOcL0q18tsQ6uWzoT4i5OFOBq6cCajg0pqLkYFllMf24LJv2I92/2i+qSkZqcQ4sCTRsOOQ84j6jPa/x4RppJFySJwR0zRywp+xe7SBQksD6rIi3HIKmQfRx0+h1TOjPHw==
Received-SPF: pass client-ip=57.103.88.154;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 586202071d..5a08fc8057 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1143,6 +1144,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


