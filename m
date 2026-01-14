Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92673D37E4C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2iA-0000ZD-LF; Wed, 14 Jan 2026 10:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg2he-0000Fy-BK
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:22:39 -0500
Received: from p-east2-cluster4-host3-snip4-5.eps.apple.com ([57.103.78.136]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg2hb-00007f-OS
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:22:33 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 0C44118000AC; Wed, 14 Jan 2026 15:22:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=FNuw/1w+nGWHVOq38C1g66qh9K4tOBSity8k1sxxShU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PonSutA99FjgbRlz504SAXOKsBLd2vN5964IWVR2flYWuOIu8kyomKNSzYnbJyRfu6UbnUSvghOVn23TJ0ORKW7bPFIhEjD+2OQ8mXI2KC8PhXMKFWz7oT05YtUwFeDNbh70t8pyLPBSW3Pp18U9oJjweVrYgwQwipS555Cz57tpnWnAplu7s05Ou8uI9geq2pt+XETYNbEzYlmyAzOosQxMQTMGlh/vYytBvzUC284t7yaGTZTEXXpCBIfKd7PaUMZr8iwoySDp0r/TNhDjU8zibRDdDuyliUyAS6/Q4aIYmz/IgXOT8QrUkWgostfVmD2YLfbNy2CPslyVe881Cg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 9B91D1800435; Wed, 14 Jan 2026 15:22:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 3/3] vmapple: apple-gfx: move legacy memory management APIs
 away from inline
Date: Wed, 14 Jan 2026 16:22:20 +0100
Message-ID: <20260114152220.89640-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114152220.89640-1-mohamed@unpredictable.fr>
References: <20260114152220.89640-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=YqIChoYX c=1 sm=1 tr=0 ts=6967b4b6
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FpLd5HJXVXburdsqXX0A:9
X-Proofpoint-ORIG-GUID: RZUHg3EUkUvVL3DqdYvnVuamffxs9rzq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyOSBTYWx0ZWRfX9vuVKW7ds83+
 fNQ5ZvdwyLwcmhTygNgnbKYcQ+kSDj0HBagmwWONkyItOvLq3K4Vea2+NEHmqUgotVbUZzOLoZk
 Q9L0pc7xFLEHrx52lc/3PoNASl4/hj5wGGDLaPN0vNg1Df1/BBXpdMOIsSQ2xMOWL8wV0uVBTi8
 dqHzUr84SwlM/op7wMpqL1HRaeQKw8C/GNUgm1J3fFUsBf45ZRHCTogniZYqOl+LjLv/3xbikLy
 3Gxu4nG5p+Wft0gzLsC8cUz7sNQYLqivIoauGLVVrJZg2oClAYrypqS5ts0yWZ4zK9sqeBj+kZH
 OMTjIF/d1g44FugJARC
X-Proofpoint-GUID: RZUHg3EUkUvVL3DqdYvnVuamffxs9rzq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxlogscore=936 clxscore=1030 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140129
X-JNJ: AAAAAAABfabA0tP3S9fOM5ncv1dufd2rbYm1SeAIrZk3z735cmDZRzLcR0y5jOe2MnZajLVDWVvQryaJDuO9F8hTkn+zGzPGErxZeWgojH0T68POcCAZ5pVieIIuSk7+zmE3dI1Ambm7BmwDMoLFI9aEpkxA3R+uggmuD9bxmutkpGpX1JgunzWFcms8vSZPb/BIvm/9am+M/SY0WtS+5nFOsdHWpGRozrB0wfIlDw9t0xYY/ZBLRHkvm11uyDcBuBs0FdtDerBp7QYDTRZ/1ax2Rkba2ZH39nglKzYsjQlKWdwkep0AmlQ09M5IahBr/2y5whIm6OH6JYTYHh6VL4/7zVr9OlVi+/O4LuOdnQQgfJO5YQfPKUFcwSni+QmqN4+TxTTUSPGX885UMhy+Q21C/JUUMZyel33phS7x56Q0/oBhQobevO0nf4ZJx4ie3B8fHfJA/IoOEeXJa9aDkh3mDcESNnmKqxm6zAGLdrH/kqE8IsaG5SP8gcn1TQ3J8PjVwaYp+fsYkWDPdMjq8EeySdRAYV0YRynhz4176XyfOTbstXcoWGQsEeHha1yLsoTu4HS7+oz8ZKr2gdXSW5RULCAcgRZHuHVF60wV4O9aMkeVDKVGTY8LPwmx8SUQXMfICmadkfOhhNqavUdtVcfpSstF/EenWRki/6FObZdlrDuEGX7XtE3aUBqG18EcLdL1FS1kIuHhhDaNwt+r3i21CHcKm2+vI2j7ezfs9A==
Received-SPF: pass client-ip=57.103.78.136;
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

They're not function pointers but blocks.
Adding this to address review comments but I don't think it's worthwhile.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/display/apple-gfx-mmio.m | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 2031baceda..fa4362653b 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -188,6 +188,22 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
     return true;
 }
 
+/* Legacy memory management API: Gone in macOS 15.4 and later. */
+static bool (^apple_gfx_map_memory)
+ (uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f)
+ = ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f){
+    *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
+
+    trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
+
+    return *va != NULL;
+};
+
+static bool (^apple_gfx_unmap_memory)(void *va, void *b, void *c, void *d, void *e, void *f)
+ = ^bool(void *va, void *b, void *c, void *d, void *e, void *f){
+    return apple_gfx_mmio_unmap_surface_memory(va);
+};
+
 static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
     AppleGFXMMIOState *s)
 {
@@ -207,19 +223,8 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
         iosfc_desc.mmioLength = 0x10000;
         iosfc_desc.memoryMapDescriptor = memoryMapDescriptor;
     } else {
-        iosfc_desc.mapMemory =
-            ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
-                *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
-
-                trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
-
-                return *va != NULL;
-            };
-
-        iosfc_desc.unmapMemory =
-            ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
-                return apple_gfx_mmio_unmap_surface_memory(va);
-            };
+        iosfc_desc.mapMemory = apple_gfx_map_memory;
+        iosfc_desc.unmapMemory = apple_gfx_unmap_memory;
     }
 
     iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {
-- 
2.50.1 (Apple Git-155)


