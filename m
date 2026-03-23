Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2663CF4613E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrH-0005w0-LZ; Mon, 23 Mar 2026 18:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrG-0005vh-Ls
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:50 -0400
Received: from qs-2006g-snip4-6.eps.apple.com ([57.103.85.197]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrF-0002v8-0h
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:50 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 5C43A1800206; Mon, 23 Mar 2026 22:34:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305288; x=1776897288;
 bh=z2ljL8wNGZuOd0h+jeGsCuyzoynr3r/rNkBTVv1fgB0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=X5WcmC5OkjPi9H3XuWm7dN8JkL3i5wjqokRr+gQ7wahn0sqgJT8cc9ubdzigMl579gv7M9fqnnAlPwZuuaeAXeOfiiQiwHV2qqU/aJxN9QbJ0ZIZPC70x9MqyQwH74p0amU1etkwxNbzC0mAUT6ilpV5ikaa2noR/rby9fVIyALPxG19qYXQGZT0vQlkGntwkDGeesquQTY2agS5HoigNq4hlm/m00dX2s6GGNpeOBR9ttH7Af9C3yjno4hje9nMWby9sPpoTpVHXMx7gMYsRywSbOJJ0omP3oagZGvlLwtwJPywpiu2+4vyE2PU1bHV5sIGwjciAyrU+yLe7SCOOA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 D9CAE1800158; Mon, 23 Mar 2026 22:34:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 02/13] whpx: i386: enable exceptions VM exit only when
 needed
Date: Mon, 23 Mar 2026 23:34:23 +0100
Message-ID: <20260323223434.81780-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Bzf6WGysw66rS9M69STm-bDteDJkiMly
X-Authority-Info-Out: v=2.4 cv=M8dA6iws c=1 sm=1 tr=0 ts=69c1c007
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EmEGBKFVNSqW8m1RzRwA:9
X-Proofpoint-ORIG-GUID: Bzf6WGysw66rS9M69STm-bDteDJkiMly
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NiBTYWx0ZWRfX7DzatJrKbxuu
 fk9yGHEDfR2S0Zme1LEvARLjO692bq4Ecj23Wr02R1Od9VZtjWgw5k0EWSZEKvkQ2ik4OfAgjdl
 CAybMkpujP/XCPWw0m1p+v8HiQ49VcTPzKUqmIs/FMKyLckeOttlNIx7SXXXp8Ivh5bI/SHVGsa
 I6uLfMHguCMKOvp3ViwwBoQrhQzHNspkjABScXXiuZgn5NOS0xc1AHEvTrnHCponb4HgzdrGvH0
 Hiy8+4WdjaJMeYEhsoGIEiKWkwV6DWVxfsI1v3yQnJ7f2f34Pst8GB9i9cnZf3nJPui2/P1TiyD
 YWS+ExrLVJqugYTNQzJ90gxXs+tkWAd+BcPuQBUZHZnuKkKY+gh2L/gYbvy54I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=902 lowpriorityscore=0 clxscore=1030 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230166
Received-SPF: pass client-ip=57.103.85.197;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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


