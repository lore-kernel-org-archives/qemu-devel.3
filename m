Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF87D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfYq-0002ob-Ht; Fri, 19 Dec 2025 13:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfYm-0002oG-Fp
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:50:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfYk-0002hc-BR
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:50:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so15429385e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766170234; x=1766775034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytV7sRjMhiZ+N36QlRegSL9F2KH4Bl+JY5tBc1NaTPk=;
 b=iXVnuoVbbTp1ys9zVX5YSiWQy6VewtHikpvRsm8XUjnCWMppM6A4KPEATr/WMyX9gY
 4tFkS1Z7dGy5AVv0Wivws55FPh1O8hJuErRFUvFxQg2s2c3iRJ7NPWrSAKoVxTl4H4DP
 4djwUClnokYvJsCY5KtB2ytmfHKuR1QyiIr1pzPLN3AwU4f+S/Jr5COzSwOiU4M1GU3o
 dicUVqF6rQR5pf7hDJYF+vDNUKu93vUomlkbERMTTEFC3oKEpQtUJCJVGn99O1Z4Gi/9
 xl8VsWsyfxjjesKoZu9W06zQdF+mbQ7uzp9zuzm0X5GOFYR3yeho2NkQVYnxJbvdmPqm
 TyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766170234; x=1766775034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ytV7sRjMhiZ+N36QlRegSL9F2KH4Bl+JY5tBc1NaTPk=;
 b=mtFiWs1XvXBD1bbjtSR8PSAl1IlFxWitCTZdUJNZGdcGwJRNSTABK871I6jPGiI3hW
 aCzOzfvumZlLwqcWAfj9PXz2x/e5Bdls6xmiPGYp7jotVKnJaq9Bgj+MWZYV4VjEocfI
 xgVmq+LjV/QnhPeqzORkWjpsrsKmMbLitR46RnpzQjf/ZHWyhTsNFvIGwYDBDAeIwFoO
 PVAph8gvUxaYofoO9FaKJIkO0zbSbGNpcFrg4lroMgsaea/gAr0uark2KQnQyW6cMlbS
 5bIyBzy8gxd5/71yUFuYnq+h5mW3896y+Dl+P8PfiKpHCKJahvy/KgCZ4UDue1rD6wl1
 4M1w==
X-Gm-Message-State: AOJu0Yw+iBU0hSbDJvUUDU67pT8iHFbkKi6DZjayhLwpdipZcsv0Sezp
 OLFFfazB0w2WVlGXTbuj2bSXJOqVMUTiOMd6BDxwafdh23uygBIWIEBapC8yHP6nOupqWPRBlMY
 xR/d+0Gw=
X-Gm-Gg: AY/fxX6DMKXJbv2FNDimHyLuWHHV+mHM34pkHvj1nuLQ5xv6txyZC9qv7gZMrC33x/c
 fW45gYqlwcyWDS1Ct2cBHSBudKF0d6d83+nVVYzGktqf0pD5hjDLi3lwGKqRaf9RA1tgD6IMmYr
 bjFdRXZp4ymkVztDQLPgAGAA/TQliC0FX9ZzpcbT4ukGmPTAGzkNS8r81brZzMbH9jSVWRX5Wrv
 XGieBA0Pj810/nQRX6yWd32HeUKxTDLPc2aza76g1cwh7CdNK6yAuezHAfy04zsWaKEn7BGVREa
 LpcrQK37w4P0BLruAN3DgQfGw+yYOIM+hX6p0IM1i8m+aTiRD/iT57JF6Ka1Y+cymXZf18TntMz
 kvtfO15F8ww/pMbWIvNOTxE69w7exzpNPtO5P5dc16xiD8aTekccNdxL3NZLrnpt/jPJ61Mzf7N
 +wG7F7yNJCCGcKpUS57Og/3hH4kHwf+T+etSwBN/wWZ309Ls5tAs4vyHuYwIy9
X-Google-Smtp-Source: AGHT+IE5XV49ii2lrZyHGFMU+c13tmmtGc+XTdQTA0fULgrQ9H9/DATWMwiUSntspkjMRGFT5z6iGg==
X-Received: by 2002:a05:600c:4ed2:b0:475:e067:f23d with SMTP id
 5b1f17b1804b1-47d1959eaaemr39063745e9.25.1766170234461; 
 Fri, 19 Dec 2025 10:50:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279d6d8sm108821205e9.10.2025.12.19.10.50.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:50:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] target/hexagon: Inline translator_ldl()
Date: Fri, 19 Dec 2025 19:50:23 +0100
Message-ID: <20251219185025.97318-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219185025.97318-1-philmd@linaro.org>
References: <20251219185025.97318-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_LE
since Hexagon use little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8fce219c0de..c37035c4774 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -203,8 +203,9 @@ static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
     memset(words, 0, PACKET_WORDS_MAX * sizeof(uint32_t));
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
         words[nwords] =
-            translator_ldl(env, &ctx->base,
-                           ctx->base.pc_next + nwords * sizeof(uint32_t));
+            translator_ldl_end(env, &ctx->base,
+                               ctx->base.pc_next + nwords * sizeof(uint32_t),
+                               MO_LE);
         found_end = is_packet_end(words[nwords]);
     }
     if (!found_end) {
@@ -966,8 +967,10 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
     int nwords;
 
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
-        uint32_t word = translator_ldl(env, &ctx->base,
-                            ctx->base.pc_next + nwords * sizeof(uint32_t));
+        uint32_t word = translator_ldl_end(env, &ctx->base,
+                                           ctx->base.pc_next
+                                           + nwords * sizeof(uint32_t),
+                                           MO_LE);
         found_end = is_packet_end(word);
     }
     uint32_t next_ptr =  ctx->base.pc_next + nwords * sizeof(uint32_t);
-- 
2.52.0


