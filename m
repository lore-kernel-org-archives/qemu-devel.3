Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D582E92734
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaF1s-0001bP-W0; Mon, 29 Dec 2025 10:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1q-0001ZU-HU
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:26 -0500
Received: from p-west1-cluster3-host9-snip4-4.eps.apple.com ([57.103.66.87]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1n-0004fB-Ba
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:26 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPS id
 87933180059F; Mon, 29 Dec 2025 15:19:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=FNuw/1w+nGWHVOq38C1g66qh9K4tOBSity8k1sxxShU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ToiMIoahNlipkaJm78I1AI0Md/uyZqC6ql1RZsbOxlQ2G4P/UoFVLaeed4I3NbjsTn4Sd1mRVJarhOsMl5Gw349zBibKwUZKm927JXd4mRmDNAVRIC2YmbyJrzqzbB8TWFnLWfCfanlkIEH/qP8R26UiO0Ob+ZUxL7ClAHn4lMqFpJUIDKCA8gLMYaLiH/XnZc+VbYChheZkVmJyxJVfcrmFtstY+d48h/iXPHo7nLae/iriP/SQutxRyxb6tHH08Q5cikrdlfPIEPbazr+vDh1PK/2Ej/pyeuSvqpCSOZDapjTxmB4SypqSR4p9AxemZ7DwCryps9tLDgjGc2LQfg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPSA id
 663EF180017E; Mon, 29 Dec 2025 15:19:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC v3 4/4] vmapple: apple-gfx: move legacy memory management APIs
 away from inline
Date: Mon, 29 Dec 2025 16:18:50 +0100
Message-ID: <20251229151850.96852-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251229151850.96852-1-mohamed@unpredictable.fr>
References: <20251229151850.96852-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE0MCBTYWx0ZWRfX71Ri1LYNKNOz
 uDFJB74T1xSXfjZ/NkVDbmmxxFfpYZEinBs//hgc8xMUbin2OcasFYhk81l2HmMwt5YRT9Fz9AI
 gAH948AzhNPn0GvHsvC5kTwiYYZ9MRHYfMNuDy3HVCrC+5qTOizq0thkM3pmJ1eWHR6Bilkdw/9
 0mNAcMJT3PwYYQ0LcueUeZXOFw4Tam3YL1xjO6q4R4WjvbQKMqNjJGGt+gMKyKXmSlD1hD8WqJ3
 jWNlsdYIObBJg/xWJDRmTFwX8jL+Pi9egDTEr2FfDNn/bWSjLuCMylG/sIN2HA6vUim225Slo9f
 rDSuLUYv2HRz/VAyk5u
X-Proofpoint-GUID: bY1_-ADT44DDryR-Mxtfl0iz4gVDaC9W
X-Authority-Info: v=2.4 cv=d+b4CBjE c=1 sm=1 tr=0 ts=69529bf8 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=FpLd5HJXVXburdsqXX0A:9
X-Proofpoint-ORIG-GUID: bY1_-ADT44DDryR-Mxtfl0iz4gVDaC9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_04,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1030
 adultscore=0 phishscore=0 mlxlogscore=873 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290140
X-JNJ: AAAAAAABktGsXMBwZy3ujeKEHyvxF4hasdvONxMh7/iPdXA+oioWOe07sTjhLIqrKnx6B8Tbt0x38F93Vyn5P+4Dec/1qrWyEELLQt9y5TsyCm9V/620fDabeV3fGpoIrcmPHEz4HF2+MfYrag/MS33K5LyCXxcCyxwnTD/BXH8S4WNQOE6MRY/BFWWO/di6RnPEfvTt/k5x+tPXhY9YKlYmoPQ08rq0MR47PFWvPwmErMreHyrD4TG2k0a/0tEHxxt245Y3pUWiifZPua6U5pka2Lt4U/f8KQbigM9NT5Q/UqGmqQiYKeGFdFv0GccIjr54YKWROwNGpSwsX1CoLt9BhGuTxZ3HIqc+0kcfspp77aP8SNFNIWFVPlHuqYPOjR0YeAbVVWdfF1NXyt92CRlzFOzAB2gfraH61IH5FJAJti7SHiM751WCVwsfaI1hzmRKzNZjKPeH00X5v7n5Aae/24qtP8E6LCiokMVaWBbdfUCPujVtGnpb5yddg3shgA2H5ryrXQLSZoBUyyyb+h3fcWBE8nxEIvfXAl85mO6FF5K3iHoXHEujfMSvhX1T52xsRIej6ma4AOSmet2iQArqUf9tp1yfFM9F8ISSXmRMqTxQf4M+mxiU0/wNhuXv2tOlrt9pq0woutT+CCWax2HTscdrfLM2hIssP7OpoK+LtZmieiVAMtTxyUVdO9FFxr0jTCyBCr7rHjMe/E3XR2a51yg0jvjk2yBovv+glryNdg==
Received-SPF: pass client-ip=57.103.66.87;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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


