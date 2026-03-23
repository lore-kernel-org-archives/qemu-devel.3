Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BA5F483E7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5Q-0005oH-7n; Mon, 23 Mar 2026 15:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5A-0005m1-Bm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:01 -0400
Received: from p-west3-cluster3-host2-snip4-10.eps.apple.com ([57.103.72.171]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l56-0004Wf-U4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:36:59 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 92FDF1800241; Mon, 23 Mar 2026 19:36:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294615; x=1776886615;
 bh=z2ljL8wNGZuOd0h+jeGsCuyzoynr3r/rNkBTVv1fgB0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Z8v458xNoTz351qwyH0X5fiHNij0gFTC7bvu73pPohiLtJ0Lg14n9yL60dhuRYu6jQVVB8wzdi0pBWkqhQnxW/wWc+Yo6QHjsm7j766cfJOdeTapFLYsWDHPg++/+HuzwovCAAMxyogj4FOREbZyN5NXwyQU5MYYLY1Op9wTqPE4p4NA12H0z93LfN9dFwuocen487iaeKaPPTthqihL84kIE7p/hQmF3GCUp5ZhwSq5A9VY4NrsOLy6PUEXQpooqrA/ufmwIYDKPvNMEA8aviILIVIflASRSDHkOT5z8OUBBhsDVXJJ5EkSadVWbR1KyeognE0LTKQv32KgnCIhGQ==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 8037D1800275; Mon, 23 Mar 2026 19:36:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 02/12] whpx: i386: enable exceptions VM exit only when needed
Date: Mon, 23 Mar 2026 20:36:35 +0100
Message-ID: <20260323193645.82602-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX2+pml8t1b3Da
 kmsK23gVNYXuCCwh89cZU9UAJLoh7WqjKU3PRn5KZoIqV+V4MiMmGcU7CHs25Hs+v2szp5T2zdW
 vQ4ATGGpWDUVgb4jY5/9xLrtD+jJ+H3/pDly3yEesVqm0/O2GmyJiQhXBRCDRziRYUzPmHPcHNO
 I7PexymaGTxvLZbZOfu7gwIPGRw2emv7BpMI7eSeElBqdQ4UU/rVXj7xsngixil4mldaeFgNXLA
 DQa4ximYWlZgpCYtufvrnSeUVslA9w7vGws5aIJrDdqBJ7hSV8ywBxOq1FcdN0O4npn0gBk4KIk
 YNUzlwitmPK0AKReUA91s4kwv19iY+fytf5JMx0rqa5vGCHtvFXsPLQOgb4r6M=
X-Authority-Info-Out: v=2.4 cv=JNQ2csKb c=1 sm=1 tr=0 ts=69c19657
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EmEGBKFVNSqW8m1RzRwA:9
X-Proofpoint-ORIG-GUID: rddMkaxQ1EUjFfAbPg1RmI5WWYqazOcf
X-Proofpoint-GUID: rddMkaxQ1EUjFfAbPg1RmI5WWYqazOcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=903
 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1030 adultscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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


