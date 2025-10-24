Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BA7CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 15:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJWr-0003Oq-AT; Fri, 24 Oct 2025 11:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nir@lichtman.org>) id 1vCJWp-0003Oi-Ih
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:16:31 -0400
Received: from lichtman.org ([149.28.33.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nir@lichtman.org>) id 1vCJWo-0008JU-39
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:16:31 -0400
Received: from nirs-laptop.local (unknown [85.130.135.138])
 by lichtman.org (Postfix) with ESMTPSA id 91E06176F09;
 Fri, 24 Oct 2025 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
 t=1761318988; bh=OZoXMZTuvGeLNm82h6eJHrozsmkbdwEEqaPmABTYX2E=;
 h=Date:From:To:Subject:From;
 b=jJNDgG2MKsh21mBmv4Z/sP3IdUIcH23rqdjP3n4ndI9IU7ORgqVgljBjKJ7KaduWC
 zo0aikNE9sddZo2LyR/aGwkfpE9EJmVI9xHj2+cWb8LK3VAHsI/ufbbsOEicOKX0Yh
 /TIJLSjjeeu9/2VRylV6oEbicTvyRnJywNuelTtrbl4Y3JYYOkV6i2Wuq1UFfyc3kQ
 Ge5B2I25bPp1R6G9kYerRQjhlJfWQ5Seulmdy9etCsok1HEP4pgtjiRSpGH10DMIzp
 8vbhtAFKcaDSEkiwyiBCJJOJX7IvUvufzlz6oEsMhTg890K0bRgzW7zofGCeIO7P3k
 Dhp4GM68nr2Gw==
Date: Fri, 24 Oct 2025 18:16:21 +0300
From: Nir Lichtman <nir@lichtman.org>
To: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Subject: [PATCH] hw/i386: Add remedy tip to initrd too large error
Message-ID: <aPuYRU83h0YDg0fK@nirs-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=149.28.33.109; envelope-from=nir@lichtman.org;
 helo=lichtman.org
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

Problem: The current error is very confusing since
the default x86 machine memory size is small and it
gives a sense that there is no way to fix for slightly
larger images.

Solution: Add a remediation tip to the error message.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 hw/i386/x86-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 7512be6..4e6c098 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -874,8 +874,9 @@ void x86_load_linux(X86MachineState *x86ms,
         initrd_data = g_mapped_file_get_contents(mapped_file);
         initrd_size = g_mapped_file_get_length(mapped_file);
         if (initrd_size >= initrd_max) {
-            fprintf(stderr, "qemu: initrd is too large, cannot support."
-                    "(max: %"PRIu32", need %"PRId64")\n",
+            fprintf(stderr, "qemu: initrd is too large, try increasing"
+                    " the machine memory with -m."
+                    " (max: %"PRIu32", need %"PRId64")\n",
                     initrd_max, (uint64_t)initrd_size);
             exit(1);
         }
-- 
2.49.1


