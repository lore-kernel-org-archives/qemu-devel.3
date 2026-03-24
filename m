Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AC2F54ACC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Sv-0005tl-Tw; Tue, 24 Mar 2026 11:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sn-0005sP-Ip
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:38 -0400
Received: from p-east2-cluster6-host6-snip4-3.eps.apple.com ([57.103.76.224]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Si-0005rj-1B
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:36 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 067C6180312E; Tue, 24 Mar 2026 15:14:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365264; x=1776957264;
 bh=z2ljL8wNGZuOd0h+jeGsCuyzoynr3r/rNkBTVv1fgB0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=U2NJbg7yaMTifGpiEy9VkReb2hW8RTckA7AYBym+hgED9wwgOUoyTROwYsYRYYys774RyPN+B6pzqnZoQlm7tDTmGgFOeiFajMc8x5f6pvq6LgtxUwMeMswHe5V1HkvNrwBUTo9Ia0rm5jVcYlV7ympmZkn3A/F8mFYNOof18JDsiLus7wSKPNio2wRdHlCfoq7DKSxIrSdu1VFJF41eEQfghJI943rUBA7iCW5lK2AnrFl6cZsewQdKNvLrwxjHZXBMhm6x4KriTVHEm9lTvQQyrIgb5/c9rx0yoyxTCs3faMnM2ZapLQvgnu7kaMFDWconZZ0lx7E/YSJ+sMbtaQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 137791835339; Tue, 24 Mar 2026 15:13:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 02/12] whpx: i386: enable exceptions VM exit only when
 needed
Date: Tue, 24 Mar 2026 16:13:13 +0100
Message-ID: <20260324151323.74473-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UfoLyG63GY8L_1exhujuUVY1-pankLNB
X-Authority-Info-Out: v=2.4 cv=aJX9aL9m c=1 sm=1 tr=0 ts=69c2aa4e
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EmEGBKFVNSqW8m1RzRwA:9
X-Proofpoint-GUID: UfoLyG63GY8L_1exhujuUVY1-pankLNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX8rIlCKm9wJc9
 6Sdx1/Hm/Ta2l+cK401QBOaJArCIIxn/4dCdfWJvLTKAIA4GlVQF3NEFMr1ShSRVLnimkGONrZm
 2nnuA/hdD0hkuU7jgkks8Htv8RODmCxgwwIL1p3aFa34l6+mP5zmn1h6oa5ZSOeE94CXEsp6WLz
 LyWdoT2Ewd0b1N3G2JEIJ+jthdly11M1Asmpl7sUKFFQFzFaJxR0b6Gdcm+WIkezoHsVJ0eRrFs
 HcS68piFQB44JyGRsnhiivMxJ8oh9iD4J+5rc46IzLjmFfIVqfrRUyQrs/Zgj0fMiDnAt/V6o+S
 haa4HXBg4FtIeGROiNxPRdjsGgdCr5jXO726913Y5TSl/M2XbSVsRnZrbY6AU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=932 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.76.224;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The exceptions VM exit was enabled with an empty bitmask
even when not used.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 015c0f1dc9..8f1835ee95 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -903,13 +903,31 @@ static void whpx_init_emu(void)
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
 {
     struct whpx_state *whpx = &whpx_global;
-    WHV_PARTITION_PROPERTY prop = { 0, };
+    WHV_PARTITION_PROPERTY prop;
     HRESULT hr;
 
     if (exceptions == whpx->exception_exit_bitmap) {
         return S_OK;
     }
 
+    /* Register for MSR and CPUID exits */
+    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+    prop.ExtendedVmExits.X64MsrExit = 1;
+    if (exceptions != 0) {
+        prop.ExtendedVmExits.ExceptionExit = 1;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeExtendedVmExits,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable extended VM exits, hr=%08lx", hr);
+        return hr;
+    }
+
+    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExceptionExitBitmap = exceptions;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
@@ -2167,7 +2185,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-    prop.ExtendedVmExits.ExceptionExit = 1;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
@@ -2175,7 +2192,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to enable MSR & CPUIDexit, hr=%08lx", hr);
+        error_report("WHPX: Failed to enable extended VM exits, hr=%08lx", hr);
         ret = -EINVAL;
         goto error;
     }
-- 
2.50.1 (Apple Git-155)


