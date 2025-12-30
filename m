Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862AFE92FE3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNJv-0003J8-Ni; Mon, 29 Dec 2025 19:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFs-0007tQ-Rp
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:30 -0500
Received: from p-east2-cluster1-host4-snip4-4.eps.apple.com ([57.103.76.17]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFr-00047T-Aj
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:28 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 A139118010DD; Tue, 30 Dec 2025 00:06:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=biA5GQB+MtXtFsJVC9XWBKO9XV75Ppx9LVI2WhigwCY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CLKqLONIL+0z0TpmmjT0xRy1rhuYlD2JtpG3cEc5OEf7ZwCgiDh0w+OhySk26JXR7YzdtlR8XBBQG9fyslbwnjPz7msdqL9yYECsHRqJ/OT7GNT9if3zUxJusUtuotISjk7Crco/PFTjwMV4XYBqkrGJgt7ZH3r1IllNwYEUzqRXPmRdv2vzq+vX2QlyctgYpK7KZPbDp00BMXs/Pr5/RqpV6/tuDK0+iF6rpjwbnze55hpvGXmR9IHw5a6rOBPe9v++8+vSHF5GiaTVpkwiVwsKXX8MqwuYYn2fDF+AYtomHYq+ncD5WaVXi/I0t7bmyQ/jeVx17QGPtWAXRCwBhw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 F30CB18010C4; Tue, 30 Dec 2025 00:06:17 +0000 (UTC)
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
Subject: [PATCH v13 26/28] whpx: arm64: check for physical address width after
 WHPX availability
Date: Tue, 30 Dec 2025 01:03:58 +0100
Message-ID: <20251230000401.72124-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ztUozClcA4vnGCk6YXB4BV9gQ2_vYxNO
X-Proofpoint-ORIG-GUID: ztUozClcA4vnGCk6YXB4BV9gQ2_vYxNO
X-Authority-Info: v=2.4 cv=GrpPO01C c=1 sm=1 tr=0 ts=69531780 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=GePjjIfFpqe_pMnJkREA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX9kV8XmXROEq4
 WlZhnwwzrOLZCxMCCoW5BVRxxtFKB9S92lqWENS5eZ49w04daieCXBmQ6e4eDq8zW0Em6cQccCc
 lNpuw8Nte7+ANx09nO/ZsNPxC2LUg2REe1ynlDqcWvJzOfQjV5jTjbJ/ZitHb4gowDGGL/qaWch
 swmGAR3WNSzlMDA6PRUNtLGstGdE/okAqLNxjmyjhfhBXXTlOpTib66ms9/k4b0gn+2vvCL2KAx
 aO+iT8dQ8PRKVi8W8uBQYXA77eQCQGzSjSIMyxk1aZFF/4JZIShDZEq0xaIUORbhHKOvG9u3eZd
 Yio9pHHykc4BzuYBqPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 clxscore=1030 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAAB+O883FZWVbIxXsU+HJgPQxWBmBsHw0MqOfRgv8iLEfJM7yOqibhCQwFZaq4fmq7VPTooKZB/KGJCgEQ1HvUANLZkjWScl+BCmf9iJvWgBAG75PFatUm9Pp9KduAh8joh4vKphg2zK+UBoMP2bLi/x8BG0TLc54gSII16jRnnt9XumNZRCng2Edq0kgcaRiX/KP4qmDt7dnCJm3ljIsZrD0Z9quElrUGmHxEhtE2L/4kPsqhetO++rlgNp5MWPEtQY4ZdE5z9VWTJ/y9oPVmmehxpX4VMq6YFRWj6AQLiAhxYg9LS/pcDtlvyvASJCnMTdABDCqukSXtS3jRlwrfC90gRoL1rm8F6VPfQNWqa/IVux0SoTrvDssc0/PP5Q5PiA3IpoZt+yxlIXWP6YmZZpKf9Plw44ICiMuh8lSVvBY1uWVLJmovN7xKIInoEvR9/8fmTEO1Ng6VmiRNKnuoKmd7bNgpKeUm501GlEy9HooJGe/oBiddsAs3x3rsKmTaY6WlzLTzGbYXfM+iWTVmbUqMbpCy41DjR3qDLw/E/yRyxgY/ait6BhUfl6TLE5ir3P6PFzGsoxgY3jocxc1TbZmr6uk22P4a1d1K99WW5rMncRkDbANRTqk+r7Wl+h484pjNpUAfalCfrQ/ddZY8qHa281p1RAM00S/IEZwBqKjrYeFpME+lU62qbhoI5VMFvLqHXe6DcJGXxjc/Fben5h3aJa9KLTBYAT+hTK3a92/1mCXvwdam7YsiMXUnZfr7+v7kSeVuA/lAz3oDvWRtKelCDhkZaXxodPAFAZI9aq5MopCP5/7vK0FH+0RD4STxNFiwKfGt3XrwyOKjsF84cZ+AaMmbZFAzcLlWr26Q5L0mFXM8eyEMPgJzF2ozFDkHAk3/epjaCxOhMjgqCFgoHkgOGzmn5ppWShlJXNlQV/I+f1wku5y21cxJD8Afg8HbmGZoYrZ43fiSVbkknBxo=
Received-SPF: pass client-ip=57.103.76.17;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index eea20f5e5e..2e5ece45ea 100644
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


