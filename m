Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95210CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 07:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA15B-0005gh-HZ; Sat, 18 Oct 2025 03:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1v9s7D-0000aW-2p
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:35:59 -0400
Received: from out-189.mta0.migadu.com ([91.218.175.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1v9s73-0000uR-EY
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:35:58 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1760736945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVIPlUW5oXm0hcESztel9HH9+opylms8y0YgCdufQAo=;
 b=VYTOpnn5DbUYwkGf+IpIDAkrSdwQ7dApZ6vLz44sUjNoG+CYsrwXO1kEgdzyGk0xX3+f/J
 JUt6jqfpApgvm+XpmdTl6BOFPv7/7tDKiCJArd/xSNYU1enefPgzbDYI69na7nRBEsew47
 65aJk4bRtWi3sdLo/rLPcE4dE+A+uDU=
From: Sean Anderson <sean.anderson@linux.dev>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/3] semihosting: Fix GDB File-I/O FLEN
Date: Fri, 17 Oct 2025 17:35:28 -0400
Message-Id: <20251017213529.998267-3-sean.anderson@linux.dev>
In-Reply-To: <20251017213529.998267-1-sean.anderson@linux.dev>
References: <20251017213529.998267-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.189;
 envelope-from=sean.anderson@linux.dev; helo=out-189.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Oct 2025 03:10:26 -0400
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

fstat returns 0 on success and -1 on error. Since we have already
checked for error, ret must be zero. Therefore, any call to fstat on a
non-empty file will return -1/EOVERFLOW.

Restore the original logic that just did a byteswap. I don't really know
what the intention of the fixed commit was.

Fixes: a6300ed6b7 ("semihosting: Split out semihost_sys_flen")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 semihosting/arm-compat-semi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 6100126796..c5a07cb947 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -316,10 +316,7 @@ common_semi_flen_fstat_cb(CPUState *cs, uint64_t ret, int err)
                                 &size, 8, 0)) {
             ret = -1, err = EFAULT;
         } else {
-            size = be64_to_cpu(size);
-            if (ret != size) {
-                ret = -1, err = EOVERFLOW;
-            }
+            ret = be64_to_cpu(size);
         }
     }
     common_semi_cb(cs, ret, err);
-- 
2.35.1.1320.gc452695387.dirty


