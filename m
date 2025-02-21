Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF8EC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbL-0008Od-7P; Fri, 21 Feb 2025 09:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWi-0006RK-Jf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:55 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWc-000150-VJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:52 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 61F46204E5B6; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61F46204E5B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=Xu5uMVkqPXXOik9fNPZh9jORCU3wzqq5Gvflw/QcqSE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hLQ6sLfO+xMbPQ/VPPIcRUgqovvNdGaDEWJWWDsQ5N3lJZPpLlaM094LwXL1C/EBq
 0Dp7Kf3Je4wDSacHKRVTrrjk5mdep/kUEY+2Na2QCPoJbQtbmNVUnb36K7JTzj4hiq
 Mj9KKfbBPxb5kak2noEHg42n83qTsgDZvF2TaoD0=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 03/19] target/i386/hvf: use x86_segment in x86_decode.c
Date: Fri, 21 Feb 2025 00:36:11 -0800
Message-Id: <1740126987-8483-4-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:19 -0500
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

Make the code to rely on the segment definition for checking cs.db.
This allows removing HVF specific VMX related definition from the
decoder.

Introduce a function for retrieving the CS descriptor.

No functional change intended.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/x86_decode.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index a4a28f113f..d6d5894e54 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -1893,6 +1893,16 @@ static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
     }
 }
 
+static struct x86_segment_descriptor get_cs_descriptor(CPUState *s)
+{
+    struct vmx_segment vmx_cs;
+    x86_segment_descriptor cs;
+    vmx_read_segment_descriptor(s, &vmx_cs, R_CS);
+    vmx_segment_to_x86_descriptor(s, &vmx_cs, &cs);
+
+    return cs;
+}
+
 void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
 {
     decode->addressing_size = -1;
@@ -1904,10 +1914,9 @@ void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
         }
     } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
-        struct vmx_segment cs;
-        vmx_read_segment_descriptor(env_cpu(env), &cs, R_CS);
+        x86_segment_descriptor cs = get_cs_descriptor(env_cpu(env));
         /* check db */
-        if ((cs.ar >> 14) & 1) {
+        if (cs.db) {
             if (decode->addr_size_override) {
                 decode->addressing_size = 2;
             } else {
@@ -1941,10 +1950,9 @@ void set_operand_size(CPUX86State *env, struct x86_decode *decode)
         }
     } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
-        struct vmx_segment cs;
-        vmx_read_segment_descriptor(env_cpu(env), &cs, R_CS);
+        x86_segment_descriptor cs = get_cs_descriptor(env_cpu(env));
         /* check db */
-        if ((cs.ar >> 14) & 1) {
+        if (cs.db) {
             if (decode->op_size_override) {
                 decode->operand_size = 2;
             } else{
-- 
2.39.5 (Apple Git-154)


