Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F191CD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 19:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZU5-0003Lj-KV; Tue, 03 Sep 2024 15:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1slZU3-0003L9-Fd
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 15:46:35 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1slZU1-0001zn-A9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 15:46:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id ADD5CA43D57;
 Tue,  3 Sep 2024 19:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3770CC4CEC4;
 Tue,  3 Sep 2024 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725392791;
 bh=ysZPsnNd3kpF3n+8IozMgz2v1zNkNppqWJ1IaiWjDiM=;
 h=Date:From:To:Cc:Subject:From;
 b=lHbsP6K+Z+Yw07JvPU9U4ZHcRYoP+zNZqQ73tjeOl7IZNpJY5BW13Y7HHvb+e5ost
 NIvBGIY/Tkn6rdQVrLMahHOxlojmZPltdPzvw1L5Sq5gFEfK9Yxj2zF22//IctGzhG
 AItQsKsge0o1h/VqBKlwZxbyeq9ZZ+862siqPSNkF/VdVpn3+jtgEiCCIqUK8UlRIP
 4Ax8YVbpYqcHlswj4OVLJBl+DVtb3FQMGb7iolrwyzniriKuzA7pSBjHQQlEuQxRuQ
 qZ7uLktnrhXEU31gczK+OQWINpOA8U3C3hP6dZ/CaivRhoORNb/ZWSHR4UnXgNrVs8
 SY6x4SraNBIYQ==
Date: Tue, 3 Sep 2024 21:46:27 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: linux-parisc@vger.kernel.org
Subject: [PATCH v2] target/hppa: Fix PSW V-bit packaging in cpu_hppa_get for
 hppa64
Message-ID: <ZtdnkxJP31cxxnf3@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While adding hppa64 support, the psw_v variable got extended from 32 to 64
bits.  So, when packaging the PSW-V bit from the psw_v variable for interrupt
processing, check bit 31 instead the 63th (sign) bit.

This fixes a hard to find Linux kernel boot issue where the loss of the PSW-V
bit due to an ITLB interruption in the middle of a series of ds/addc
instructions (from the divU milicode library) generated the wrong division
result and thus triggered a Linux kernel crash.

Link: https://lore.kernel.org/lkml/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
Cc: qemu-stable@nongnu.org # v8.2+

---
v2:
- added change to cpu.h (as requested by Richard)
- added Richards R-b
- added stable CC tag

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index b79ddd8184..d4b1a3cd5a 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -53,7 +53,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
     }
 
     psw |= env->psw_n * PSW_N;
-    psw |= (env->psw_v < 0) * PSW_V;
+    psw |= ((env->psw_v >> 31) & 1) * PSW_V;
     psw |= env->psw | env->psw_xb;
 
     return psw;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 56d9568d6c..43074d80bf 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -211,7 +211,7 @@ typedef struct CPUArchState {
     uint32_t psw;            /* All psw bits except the following:  */
     uint32_t psw_xb;         /* X and B, in their normal positions */
     target_ulong psw_n;      /* boolean */
-    target_long psw_v;       /* in most significant bit */
+    target_long psw_v;       /* in bit 31 */
 
     /* Splitting the carry-borrow field into the MSB and "the rest", allows
      * for "the rest" to be deleted when it is unused, but the MSB is in use.

