Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FEFCCD1A4
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 07:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA157-0005gC-2W; Sat, 18 Oct 2025 03:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1v9s7A-0000aA-2l
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:35:56 -0400
Received: from out-181.mta0.migadu.com ([91.218.175.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1v9s72-0000uW-R0
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:35:55 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1760736946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GyZkspTFi4AGi8wBN1HJrgsjfpx8vJ4xmyKiff9sWvw=;
 b=lAxQiny/ks4nyaciP/Z+26wcqOeGEmRgQY0Ya1kmIId4EWp6UEQwdynTw9XZpp5nAsqtfJ
 674fC0HKH7JFgPstcQh1+N/viipoTFzlzccaP+Scuik1wMQd31cShlQolK+bkshcDjb5Cs
 AW4hEswLeA4PkobLoluupkXIDGFv0ZM=
From: Sean Anderson <sean.anderson@linux.dev>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/3] semihosting: Check for overflow in FLEN on 32-bit systems
Date: Fri, 17 Oct 2025 17:35:29 -0400
Message-Id: <20251017213529.998267-4-sean.anderson@linux.dev>
In-Reply-To: <20251017213529.998267-1-sean.anderson@linux.dev>
References: <20251017213529.998267-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.181;
 envelope-from=sean.anderson@linux.dev; helo=out-181.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Oct 2025 03:10:23 -0400
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

When semihosting 32-bit systems, the return value of FLEN will be stored
in a 32-bit integer. To prevent wraparound, return -1 and set EOVERFLOW.
This matches the behavior of stat(2). Static files don't need to be
checked, since are always small.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 semihosting/arm-compat-semi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index c5a07cb947..57453ca6be 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -305,8 +305,19 @@ static uint64_t common_semi_flen_buf(CPUState *cs)
     return sp - 64;
 }
 
+static void common_semi_flen_cb(CPUState *cs, uint64_t ret, int err)
+{
+    CPUArchState *env = cpu_env(cs);
+
+    if (!err && !is_64bit_semihosting(env) && ret > INT32_MAX) {
+            ret = -1, err = EOVERFLOW;
+    }
+    common_semi_cb(cs, ret, err);
+}
+
+
 static void
-common_semi_flen_fstat_cb(CPUState *cs, uint64_t ret, int err)
+common_semi_flen_gdb_cb(CPUState *cs, uint64_t ret, int err)
 {
     if (!err) {
         /* The size is always stored in big-endian order, extract the value. */
@@ -319,7 +330,7 @@ common_semi_flen_fstat_cb(CPUState *cs, uint64_t ret, int err)
             ret = be64_to_cpu(size);
         }
     }
-    common_semi_cb(cs, ret, err);
+    common_semi_flen_cb(cs, ret, err);
 }
 
 static void
@@ -517,7 +528,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_FLEN:
         GET_ARG(0);
-        semihost_sys_flen(cs, common_semi_flen_fstat_cb, common_semi_cb,
+        semihost_sys_flen(cs, common_semi_flen_gdb_cb, common_semi_flen_cb,
                           arg0, common_semi_flen_buf(cs));
         break;
 
-- 
2.35.1.1320.gc452695387.dirty


