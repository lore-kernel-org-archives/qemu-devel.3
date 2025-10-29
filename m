Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C92CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6M-0004LZ-Ld; Wed, 29 Oct 2025 13:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA64-00044x-8X
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:32 -0400
Received: from p-east2-cluster4-host4-snip4-10.eps.apple.com ([57.103.78.151]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5c-0003WU-CI
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 433A118270D7; Wed, 29 Oct 2025 17:35:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=NOUCweN0BwDWHptjKrVueVuLmTbPgqxKBFU13NRtxRY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JiXz4u5ARNp3HoHOx5tOCnrqlTwHaFzOHmpuCA6ZAt3TILLP2MzSXYhcsbw0ID2ZWWXKKApo5jqnnFE6XciiYm/IFJ4bUH0m7+V7nWl+810ga1sX/s981utrFM5hnVbHQxOa4c+fsjhdo+CrSWV7/Zvr/Bd9jIXrunxJmRUZeggktCoo9RrksDzRaRH04anYiKmn7rp8qpsYvSdNT9/K8ghzUX/CmhOqzH1BaE8d0ofUQ+eBUKtYxyCGBvvbV2v/ma/4EeKdtxwJuuRBNy4jk6b7lbeizbhsq1Bxq1zq3fikyTRCbm+T2C+omgwGe9ZD8UTe3stbZuJeOJn5WbjsXw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 BF7F6180DD80; Wed, 29 Oct 2025 16:56:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 27/28] whpx: arm64: check for physical address width after
 WHPX availability
Date: Wed, 29 Oct 2025 17:55:09 +0100
Message-ID: <20251029165510.45824-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NgaY8in12Kp1RhqVMaNsMAdawsC0c5yJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX8IaYA/Yq7yHq
 xvqZVwtQbOyAQH1PepRFS55qKlKtlZsmUfmIG0mMBczk/nVPcdJRzQFQejc45/LCNz0T7MdKsRb
 PsvaeLuLFOjEic6JzkmVeCiPo5nA7dkkrb5B3wNDYhnKaW3A71jSr/b+a1d+cnf+44Wi30UHpDW
 ByjTiFuttXQr0Gwx56qbfjHAILhbJNouorex9uNKrsA9SA09XPV+qTGNsvsvt2sTJSWfRXYU5ow
 m/FsM2fxwc0Dnb1ZMNyUysa+CU993NoF57a5FRSomEOiw7ijbX6ASOvCA/XaYKE45HGjSKF48=
X-Proofpoint-ORIG-GUID: NgaY8in12Kp1RhqVMaNsMAdawsC0c5yJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=784
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAAB+VxYt4b/atB6I4oT2qs0HWp6bQBQlQLoYuqwTvr4KigekV2wNAKIdwkbgGaZf0EqMhEd6gynn7HxJmwl978kTaMSOObpO6zlwVsljxUHlwW2a6j7iNz1/dgq2Dxpu4PYp/uRqOkconOCPwMdvW+LBhIRRiwmmqnDuAaH2sTYGpkSow3dQipDhOGrZJs1+mzKg4+4DwL5sOqhjmiV5NW+1XdZyKJ77FSiK+eLgXzvZcS/bjRqv1NL+s5fCUbikfTlks31vANc5bSOcKlxdjO8WUu7p2GWexCR10LxlhyFbU1uHu/XBjkoJmZYIAQ69S9W2iW+LNNchhyJjRdTl/x6C+pfAoZa6R5lKO27JvmpZvpKbrO63SwISK7x5rPagEf+1AV645h1R2BZEuF0JLveiPf0DU9XkrTFJPOQOw0vGx/Dl0lY0XApE9RKq37V2EIP+/8pnRTdWyL3+B+DfJAycamRAhVv+64H0DDCqi7Stzh1AZFKZRb3GPIoLs5mdcfPt95T8UpLX6rPqsddYpMyY4t/Nks7hm/CEmkGbOeVDznrS5GZBa5sS/tTfCMIH8uKYzhVB9hSY2jVO/f26aax+ZATVmms6LGKrq9a2Zhf6HiuBxZEC2l99WAeG7iNyibgXrn/ZnNs9dh4EbKv+FXktacYVXGAqjG8ZXhHm0z6bP3FTVlyVFbb+ukZvwwC690/+symaYLFXzXlqNLFD/KTqDRbv3GxTKvsLd3ZDL0R/DXSRJO0v5jEOA==
Received-SPF: pass client-ip=57.103.78.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 4d58e5e939..ce1794952c 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -678,7 +678,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
         WHvCapabilityCodePhysicalAddressWidth, &whpx_cap,
         sizeof(whpx_cap), &whpx_cap_size);
     if (FAILED(hr)) {
-        error_report("WHPX: failed to get supported"
+        error_report("WHPX: failed to get supported "
              "physical address width, hr=%08lx", hr);
     }
 
@@ -909,14 +909,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->get_physical_address_range) {
-        pa_range = mc->get_physical_address_range(ms,
-            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
-        if (pa_range < 0) {
-            return -EINVAL;
-        }
-    }
-
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
@@ -943,6 +935,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    if (mc->get_physical_address_range) {
+        pa_range = mc->get_physical_address_range(ms,
+            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
     hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to create partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


