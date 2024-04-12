Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C51C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ6-000703-EV; Fri, 12 Apr 2024 03:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ4-0006zD-Cz
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ2-00076y-QP
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e50a04c317so3847065ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907233; x=1713512033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnSXZctlzd8Wm3DUoANmQRZQ2vSrRZB+EmzfSv7sIGQ=;
 b=jfS7hNKjWkfRCMcM1YDj6JhZgolCUtddi8g4hfJjyh3vwZpAhb6pqMfliCbFChFCz7
 QJyeRsvFgutfHRhb8dJ8XuVFJw96SL/NMyBwSTTHD4yEzYmo9vCA1eWzuOzbXzIH5yxQ
 bnbYuJLzhEkkdfFUD8Flwh5T18sNGdMw7cnhXf/qDNEujPF65ks18vMwp4vh4oAlh/YS
 GfroGsNUqAaezoAYjClvZUN1RRSoGoFGF3aYJTBzHbN55ojbyWNA3QZBzg8AB3S3ndvd
 OQuzBDcub1Ln0gFvS1uuVDoJEl+bSWKon/cl3ZB93TI2pP8P6+zav6rSNZyoBIJjbRtL
 Ggfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907233; x=1713512033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnSXZctlzd8Wm3DUoANmQRZQ2vSrRZB+EmzfSv7sIGQ=;
 b=I5DntoSogwyRd0sYc2E89v/P8D7pfMORlHHlJ4EKTcI73dFP+QgUR/LGmLO2BDWkbL
 fOU4jQEQ3nEctjrbr9T/YdEjjzDFLP/tmQdk48d50N/NE/xX6eQJPpBHQOH4lk14AbNW
 WpPDol4qPN5rLiLcKxHd17uY7ptJUqIVGAajFZ5ieRSO6WXyUzqlT2X3lsqg442ukl0o
 2nGbv1Pki0EsbKjGX7N47p5Y8nlENviH60VWnEjPtHznWg2JG2SU2sJq+A0MY+8myRvC
 Vqhqbc5CbHZQoLBSRPMhjMJCuzZK67pVKO4d0BzVDQ4kmsAziBNyITUnaPWFI6TQND2L
 waIA==
X-Gm-Message-State: AOJu0YxtGDSLRISbZ9YwPzOQXdb3ylipxQfV3DkLJHHW+iEqswBes7Rs
 RwiK4oyFNaUTcCOcTbEARQqdSc9a4CTUWbt7HGaRqeFfVJFOQLbml3Wz2o4EkmvBgWaffOpNL5S
 i
X-Google-Smtp-Source: AGHT+IGt1RoBHzBXLy3l2+OuGMj/MegPm8dlfRvCyChDb358gcnNq+Q9QCQ15LguqFdJjxv83ugXKA==
X-Received: by 2002:a17:902:ea10:b0:1dd:135e:2604 with SMTP id
 s16-20020a170902ea1000b001dd135e2604mr1977494plg.40.1712907233310; 
 Fri, 12 Apr 2024 00:33:53 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/27] system/qtest: Replace sprintf by qemu_hexdump_line
Date: Fri, 12 Apr 2024 00:33:26 -0700
Message-Id: <20240412073346.458116-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>`
[rth: Use qemu_hexdump_line]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/qtest.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 6da58b3874..507a358f3b 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -601,9 +601,9 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
     } else if (strcmp(words[0], "read") == 0) {
-        uint64_t addr, len, i;
+        g_autoptr(GString) enc = NULL;
+        uint64_t addr, len;
         uint8_t *data;
-        char *enc;
         int ret;
 
         g_assert(words[1] && words[2]);
@@ -618,16 +618,12 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
 
-        enc = g_malloc(2 * len + 1);
-        for (i = 0; i < len; i++) {
-            sprintf(&enc[i * 2], "%02x", data[i]);
-        }
+        enc = qemu_hexdump_line(NULL, data, len, 0, 0);
 
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK 0x%s\n", enc);
+        qtest_sendf(chr, "OK 0x%s\n", enc->str);
 
         g_free(data);
-        g_free(enc);
     } else if (strcmp(words[0], "b64read") == 0) {
         uint64_t addr, len;
         uint8_t *data;
-- 
2.34.1


