Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A40CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJva5-00015P-2f; Mon, 04 May 2026 11:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJva2-00013R-OC
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:34 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJva1-0006Gk-5M
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:34 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-900fa9f178dso191370385a.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909892; x=1778514692; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=foXIRPjA5gS3G5f+1cVTKO/YSOx+Ynfsprdlu+eUN/8=;
 b=BuLTDv24yql2lSBBw1H+RfdCGj0LLfS0qiFcPWwotyXciKvRpOwzJCWcvnVX9QdmMe
 Ivtg932wCAjf3n9ElcIcLY2/SJNxZgyWtgtQCA8GLlXhVxVGGj5jA1kGUEu0lS2Tird9
 m5SQLv8J/ONkXPnBBmZwsA4PRa9+zLQWHZJSKAD6gGu4uL7fe1Qp3M8yozZ9Y3CofR67
 myw4weFitiBztc4q20q0meumYfcxj+ag8pIP71uOix3CCY3hoPDCUwYbZ5cv+zpUIGxb
 0CzoWW6721x5IQ9atZFafPUo23CRzwDCaoqVv1crUGk/Tmz4BYBk50BK/KlPrPC2lT3h
 nOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909892; x=1778514692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=foXIRPjA5gS3G5f+1cVTKO/YSOx+Ynfsprdlu+eUN/8=;
 b=lzE7WeN8hHKoLTNhrY/pEI8CY4Ny/nbpXdU92tfiLSsjoFTisvCuVGn36cdA3P7Xje
 YQ2It0K4Li38bNlc3otpOidyon18pYiK2dh3J6qjqTzQdjAQCMhbY+EOsu1pNWem9bLt
 a9WxlfhvHtrhEwe8bPu0RdsFB6aMieOTV9ANZrplxu+oJwon7N8P1rwF8qU9L/BnFKHv
 jNPM+gXr1E1ymQrtkCiWjg7ZFGuEIKVnDCoXAn8vi0ZVLwv3OZ2lG1/Eigs6GdSWom7G
 6ef8Cg7Pacj9JVX/6/Yr1sN4V/v8jQQSssLEn8Ju9uuBQn6mwaiEMT31gI0WMA3+yb7d
 DM0Q==
X-Gm-Message-State: AOJu0YwHU4hkaT2AI5IH6i0dhDIbzGInIWWGJlWOkxvNB8rfHpEskQU8
 mPZhCqfW97NP/xTNbhK1i3yJdLYGjN981sEBVZ3b1eOvJrcQ7YHZ4Sh6
X-Gm-Gg: AeBDiesu1hYkv/memK7ozG0AzJYsQfvON4t+3YgrDtdt91E6r/b3Z5tlfUaTARI6zwo
 VSt6Fe1Xo8buBTqHnC88Oru61atmqnwaUk9wezjTO+P+aZKE6IwKiKQWpwoKiJLC5pEKLHMHkXG
 V/vjAOCpJGPWVYlIWbUJWJ5X2Lnjm+whu12T0Li1vAXvZh8drqEBOltF51greOsZW4lMUUzXH1C
 A4BhGeIgN+pv4+cLbuodx2sAJmsDPlR40gJiZjCcuebkjY/AD9L4HjXo3uLingKnVEDYTlAkZza
 HL93KdRke5n/3U0cog8pmjoYS28Y03ofjxuiOnKh9oOmyeu37r+ONGmzAAWp2Mj4cZK2tXZDQeF
 JdWMa9GKgS+pECoDQH2fXZIlJU3H0flHjZsUujfV1QutOsPh7EmWfkz+NGap1xx1TnLGASdLlyj
 ik4wd927ifKnBZVeVNYbbH07vC/2cje1PU++SBxUaPtkvj1BWfwvE=
X-Received: by 2002:a05:622a:208:b0:50f:b81e:c663 with SMTP id
 d75a77b69052e-5104bf2cc57mr147276451cf.40.1777909891781; 
 Mon, 04 May 2026 08:51:31 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:31 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 04 May 2026 11:50:48 -0400
Subject: [PATCH v5 15/15] tests/tcg: add test for MTE_STORE_ONLY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-feat-mte4-v5-15-232a648e63c6@gmail.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
In-Reply-To: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=2991;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=mAwPuGJQelulccRrIcbbltCeg9NHZ8EE7GZcbX8aqAw=;
 b=Sqpq09fEtblXyJ18AAhCaSO4jIAAdZ0t/rwE+imXdahW0euiZhu1Vhmt1ANRknj7iakgqF0mg
 7jACBhixnvKBTazCr8APVXrnTBHbGHjg05wphSrsxmYa1/nmFlULgoN
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Added a test that checks that MTE checks are not performed on loads when
MTE_STORE_ONLY is enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-10.c        | 49 +++++++++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/mte.h           |  4 ++--
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index b491cfb5e1..6203ac9b51 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -64,7 +64,7 @@ AARCH64_TESTS += bti-2
 
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9
+AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9 mte-10
 mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
 endif
 
diff --git a/tests/tcg/aarch64/mte-10.c b/tests/tcg/aarch64/mte-10.c
new file mode 100644
index 0000000000..46d26fe97f
--- /dev/null
+++ b/tests/tcg/aarch64/mte-10.c
@@ -0,0 +1,49 @@
+/*
+ * Memory tagging, write-only tag checking
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "mte.h"
+
+void pass(int sig, siginfo_t *info, void *uc)
+{
+    exit(0);
+}
+
+int main(int ac, char **av)
+{
+    struct sigaction sa;
+    int *p0, *p1, *p2;
+    long excl = 1;
+
+    enable_mte(PR_MTE_TCF_SYNC | PR_MTE_STORE_ONLY);
+    p0 = alloc_mte_mem(sizeof(*p0));
+
+    /* Create two differently tagged pointers. */
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(excl));
+    asm("gmi %0,%1,%0" : "+r"(excl) : "r" (p1));
+    assert(excl != 1);
+    asm("irg %0,%1,%2" : "=r"(p2) : "r"(p0), "r"(excl));
+    assert(p1 != p2);
+
+    /* Store the tag from the first pointer.  */
+    asm("stg %0, [%0]" : : "r"(p1));
+
+    /*
+     * We write to p1 (stg above makes this check pass) and read from
+     * p2 (improperly tagged, but since it's a read, we don't care).
+     */
+    *p1 = *p2;
+
+    /* enable handler */
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = pass;
+    sa.sa_flags = SA_SIGINFO;
+    sigaction(SIGSEGV, &sa, NULL);
+
+    /* now we write to badly tagged p2, should fault. */
+    *p2 = 0;
+
+    abort();
+}
diff --git a/tests/tcg/aarch64/mte.h b/tests/tcg/aarch64/mte.h
index 17b932f3f1..7093b93dc7 100644
--- a/tests/tcg/aarch64/mte.h
+++ b/tests/tcg/aarch64/mte.h
@@ -40,10 +40,10 @@
 # define SEGV_MTESERR    9
 #endif
 
-static void enable_mte(int tcf)
+static void enable_mte(int flags)
 {
     int r = prctl(PR_SET_TAGGED_ADDR_CTRL,
-                  PR_TAGGED_ADDR_ENABLE | tcf | (0xfffe << PR_MTE_TAG_SHIFT),
+                  PR_TAGGED_ADDR_ENABLE | flags | (0xfffe << PR_MTE_TAG_SHIFT),
                   0, 0, 0);
     if (r < 0) {
         perror("PR_SET_TAGGED_ADDR_CTRL");

-- 
2.54.0


