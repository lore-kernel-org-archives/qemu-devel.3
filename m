Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8997FC61DCB
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtjpi-0005mm-Tx; Sat, 21 Feb 2026 05:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpd-0005l3-La; Sat, 21 Feb 2026 05:03:25 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpb-00051x-4y; Sat, 21 Feb 2026 05:03:25 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBXrdDggplpFBdzAA--.2745S2;
 Sat, 21 Feb 2026 18:03:12 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3TevcgplpBk4cAA--.34138S4;
 Sat, 21 Feb 2026 18:03:09 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 01/31] hw/arm/smmuv3-common: Fix incorrect reserved mask for
 SMMU CR0 register
Date: Sat, 21 Feb 2026 18:02:20 +0800
Message-Id: <20260221100250.2976287-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3TevcgplpBk4cAA--.34138S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAJBWmTeekBBQAZs6
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZry5Ar43ZFW5GryDXw17GFg_yoWkXrbEka
 n7Jw4Fqw4rtFsrX3WUKFWfJry0kw4rJFWDWF1rXFnxGFyDAw4Uur1vv34kJ3yfGasrCFyf
 uan3JrW3X39rCjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The current definition of the SMMU_CR0_RESERVED mask is incorrect.
It mistakenly treats bit 10 (DPT_WALK_EN) as a reserved bit while
treating bit 9 (RES0) as an implemented bit.

According to the SMMU architecture specification, the layout for CR0 is:
| 31:11| RES0           |
| 10   | DPT_WALK_EN    |
| 9    | RES0           |
| 8:6  | VMW            |
| 5    | RES0           |
| 4    | ATSCHK         |
| 3    | CMDQEN         |
| 2    | EVENTQEN       |
| 1    | PRIQEN         |
| 0    | SMMUEN         |

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lists.gnu.org/archive/html/qemu-arm/2025-06/msg00088.html
---
 include/hw/arm/smmuv3-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 67a23fbeaae..2df54ba60f9 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -355,7 +355,7 @@ REG32(CR0,                 0x20)
     FIELD(CR0, EVENTQEN,      2, 1)
     FIELD(CR0, CMDQEN,        3, 1)
 
-#define SMMU_CR0_RESERVED 0xFFFFFC20
+#define SMMU_CR0_RESERVED 0xFFFFFA20
 
 REG32(CR0ACK,              0x24)
 REG32(CR1,                 0x28)
-- 
2.34.1


