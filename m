Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CC1E68156
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHkn-00036j-1c; Tue, 17 Feb 2026 04:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHkZ-0002rC-TF
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:52:11 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHkQ-00068N-6E
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:52:11 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a962230847so33780955ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771321882; x=1771926682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RA/xW5zJd5cGLeWZe1fjyerEL6z5rrn6x+7ECtoAUpw=;
 b=lMn250cDqgLgp8eNhGsLjHr5VhbSHRHkAdZ4V3x5/l10lR5EGUdfeuxssYNDqwYMf5
 7a1KwjTPOwZ6MsS4JhExC7xq75YTGJ5egc2r8MgTCIksvE7Wdf/U36vAzdiuwwGnJlwH
 /95inPHlrSBxhZwi+wKzshr6W3N2lCjV7VujtUe90YGguEtVXTFxFF+ADkLNWSLkskng
 PR5lcFYZpaEkspfZZFMEXS9JzIjLEWWtvAtUT1d2vp1bm33BqjaL6Z7SnbKlO0S1VpUr
 d5CgUur+ra8sKK1U5ep11yfy2QA9aK8siRUk15BQ6j8pdQ8EKkadtauGLESv/gaEn3q5
 6ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321882; x=1771926682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RA/xW5zJd5cGLeWZe1fjyerEL6z5rrn6x+7ECtoAUpw=;
 b=SiS8eHN6GhOXc+1cWTYQgYCNNCHrLVLnvd96O6TrwcVKGtKp8r4z/hwxz/UmsMM0vE
 BJWtgoUocNIiAk82D19ap9kQbzbo7Y6xyHZ7Wh0YOH6o2CVzNtWbX+6D/nErDdBQ3wvv
 UAEvQ5W1AkV3MQmvG2aR3ZfXd5efSBzwEC730nhBf1Au0CHeAZkrTlVS3J75ujpT9Q67
 tHCovVHuFsjxIbTqKTzJ19p6xervJLYi2e4oS6DY7aD7aNV5fO42p0jWUhNCoC7TwXxv
 ZuL+I1VDUnwz+44mFMTRDnpYklwJy66GswRPfzN1ZX1VRffQjOCgKVipsByWw0TlgJQS
 gf7Q==
X-Gm-Message-State: AOJu0YzrAQtlXBmXB7D+Ge1U8W735etWhJUcZq7I+b8hddQCW6v9O6Bw
 l3SGe6ODm6AWXaBwwNhHCGfu1G4GHAb55JLrh4mbK9DWAzQYt9GG9AyG8bVuE9uAyz7gDAkZh/P
 LIVD3mv0=
X-Gm-Gg: AZuq6aLDXNccoahAGn3d5sshpKDB5LqF6O/qkGQYauZ1IKx34aPcdYqF2uRpSmyrfeC
 U7UOHfSVWJ7gyDWKWfNmgTRCBtg/TXZUr8ZUfZOnMzZwI6MXj2l2uISZsrp2mjP7aSbLS6VLavb
 I5+C4IlR3kBoM+nxou86zc9nGTnB+q2silr+NBorCWPIy+zacPYKDrql1pkJxz1GBZLlcvtH5we
 Y6jClJqmfhtEdyV23B1Yn9BYbwOc60hY68sKRg+QXJMXTtWgzIdarOMRO21ijbv12wY0dm6SNUg
 kTgQD9hdiaV4ZB1G91A0K8pEVHC5JWAdLxp1X9kzYplTheFy7Ux0PvzaXfpVCAl+i/wxjp3AiKW
 65NssKJebSDlQvmx0wM5HyhhyY8fmhOfNf3q3xAhLtJkurSk9WsA5SrFfSCIYU2zwbcHZ04F9/f
 msV1wMxVDKgy3qaiHGLDkD4jPGZnK+MWSd7BVGrVfTu0yyikxhJjHw6W2m874xwiix9fH3EPw5O
 TQMbqksKpobWivvq7vYB6UnoHOtiQjhbhIJkkMlkLSUcbcsVw==
X-Received: by 2002:a17:903:2444:b0:2aa:ec1b:d3c3 with SMTP id
 d9443c01a7336-2ab505c34bcmr139135335ad.43.1771321881566; 
 Tue, 17 Feb 2026 01:51:21 -0800 (PST)
Received: from localhost.localdomain
 (2403-580b-742d-0-10a2-dce1-aa4a-dd32.ip6.aussiebb.net.
 [2403:580b:742d:0:10a2:dce1:aa4a:dd32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa33esm99108675ad.13.2026.02.17.01.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 01:51:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 4/7] page-vary: Build set_preferred_target_page_bits as
 common code
Date: Tue, 17 Feb 2026 19:51:03 +1000
Message-ID: <20260217095106.598486-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217095106.598486-1-richard.henderson@linaro.org>
References: <20260217095106.598486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use target_info->page_bits_vary to merge
set_preferred_target_page_bits_common into
set_preferred_target_page_bits in page-vary-common.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/page-vary.h |  1 -
 page-vary-common.c       | 29 ++++++++++++++++++-----------
 page-vary-target.c       | 10 ----------
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index 3c77689ca5..c4dc56634b 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -41,7 +41,6 @@ typedef struct {
 } TargetPageBits;
 
 #ifdef IN_PAGE_VARY
-bool set_preferred_target_page_bits_common(int bits);
 void finalize_target_page_bits_common(int min);
 #endif
 
diff --git a/page-vary-common.c b/page-vary-common.c
index ab77672dd4..b41137c644 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -20,25 +20,32 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
 #include "exec/page-vary.h"
 
 /* WARNING: This file must *not* be complied with -flto. */
 
 TargetPageBits target_page;
 
-bool set_preferred_target_page_bits_common(int bits)
+bool set_preferred_target_page_bits(int bits)
 {
-    /*
-     * The target page size is the lowest common denominator for all
-     * the CPUs in the system, so we can only make it smaller, never
-     * larger. And we can't make it smaller once we've committed to
-     * a particular size.
-     */
-    if (target_page.bits == 0 || target_page.bits > bits) {
-        if (target_page.decided) {
-            return false;
+    const TargetInfo *ti = target_info();
+
+    assert(bits >= TARGET_PAGE_BITS_MIN);
+    if (ti->page_bits_vary) {
+
+        /*
+         * The target page size is the lowest common denominator for all
+         * the CPUs in the system, so we can only make it smaller, never
+         * larger. And we can't make it smaller once we've committed to
+         * a particular size.
+         */
+        if (target_page.bits == 0 || target_page.bits > bits) {
+            if (target_page.decided) {
+                return false;
+            }
+            target_page.bits = bits;
         }
-        target_page.bits = bits;
     }
     return true;
 }
diff --git a/page-vary-target.c b/page-vary-target.c
index 7c0565dd8d..d388c5c3d6 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -39,16 +39,6 @@ int migration_legacy_page_bits(void)
 }
 #endif
 
-bool set_preferred_target_page_bits(int bits)
-{
-    assert(bits >= TARGET_PAGE_BITS_MIN);
-#ifdef TARGET_PAGE_BITS_VARY
-    return set_preferred_target_page_bits_common(bits);
-#else
-    return true;
-#endif
-}
-
 void finalize_target_page_bits(void)
 {
 #ifndef TARGET_PAGE_BITS_VARY
-- 
2.43.0


