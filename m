Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6365CD12D4B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 12:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQlZv-0002g6-HX; Wed, 03 Dec 2025 07:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQlZp-0002eT-JS
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:03:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQlZn-0007HQ-M8
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:03:21 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so65204295e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 04:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764763397; x=1765368197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rDxcJTIXeLoMko0NxMKG18lkuBIFq7ECWIOhE7BilRw=;
 b=AsPi7fYyptFE+DjOWND7bPnTNa48F09N2vITNOSOvgAIyq9j7XsdzXxpRYTo5nINap
 9RUSIWeHSrgLC4kUhWtfS3Gf5M3a1M/3MATXLSy3MvwDfL2DUQEfgzwm+dp37Q0ThlhB
 BwLv4BEIzO+pIGb3gY00SubFRJz4QEADkYFpvhTDcrrV1TWAZYuSZ2S9asgbJ19FWbmv
 JbOd4FOYJsLWn/8OIdLtdwnU2i8gY54VzNdtY9cY7HB8UkZQ0RINLEPCzL+2pz/3bqhm
 zubkPvNyi1o8FHp3GBMyvYAp//CNp/DLeDj+OeWdh7qTS5lv0WI5ULRm64Dmx2eLo+OR
 wkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764763397; x=1765368197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDxcJTIXeLoMko0NxMKG18lkuBIFq7ECWIOhE7BilRw=;
 b=aFY6eYJmyJqG61Q7oOpRv0uzozILiaf0yGL3vf/Dm113tBLd0CasssWS3Aky0WiMJM
 /SvRiJ7qHDZfb3/IUgTV2bafclSo1TrxS8TFP/sgZGZrr/aMZqtTsIGkV3CGLfKxK4of
 ddk1VnAhQKeVwx/fEfqmnPi5mmfexH4cgiQZlxDYTgJvgaGoB3NLr/DVxS4ZrMrMQXHz
 k1uD4hXbXlkFwZAhfKY55XSYnC32ZQAkCBllG3bZ1DIIcSTBG/Xfjyjxsi2M96JXWnPF
 pOcERqGrYbT3VZoHQ8C1Jk5SoXC2wjgVcoGp1loW7lI2boBP/NZGJ2lRksXG6KaHOmfS
 1QqQ==
X-Gm-Message-State: AOJu0Yw9+FIi/TVopzhI90zGKd/Z2A9YvESA0PZXYrh0JHgmFD6MOg2S
 qx+3nvrso0EUb87HiRe+fiuLB3cijMdlXfQsqLqCyWlRH2cpNr2L1Wd9P3a+Rkas9/QXjDhpWxp
 dJ3z72QY=
X-Gm-Gg: ASbGncsPs/pjK9AM+0/yREnbJK7OASTVgda44hBEJwcA4dFS9LNOfOZQp98jfGfGmm1
 LDzZvKG3vRtcNdHyP5FsHN3f1qe7Ih2M45vJEcIqc/Nee/fgC1dHIHumMz9GbFcAcQx/0R5Jxrf
 EzvsIwYhW9BTz4uawd7eTs72/55s8puaycReQZCIF3EnYh7ZiwNqnvReZh0puQz3LbfsBYNPAl1
 5smIKtuALBbPP8LCw1T2XFTm+24cKdyI3N/lbv2/KtI3GQjoyUG52KzD7VMUjqn2dmVGiacVTv/
 LrUp4V83wLKx+skyHIxMBi8Wui/q6nwEwdBXUj2hDK3HYnumhPYd30O+CLGWgHEhkxlrvCrSc8i
 Fnfkjv8fhQBodHvE3/h4jkc/Dll6QpJH/WP5oW68o3QX0QZeXzwa/LZVgQNzmlwePrQ+a4AQu3H
 DdQwaWvzUHUxMNtLIuCDSjTX3R6EEJRxefFeOLgiS+SPMjtl/+RXeerpyDyFQH
X-Google-Smtp-Source: AGHT+IFpUkst2fNT9EQqzXZHv5xZN5u42HaSmHB3DNgt1wi7rBR6HoJGNQrPk1QSMMIF6KtJ+D5DLw==
X-Received: by 2002:a05:600c:4f53:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4792af333edmr16649815e9.22.1764763397540; 
 Wed, 03 Dec 2025 04:03:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3022sm39533059f8f.4.2025.12.03.04.03.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Dec 2025 04:03:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.2 v2] osdep: Undefine FSCALE definition to fix Solaris
 builds
Date: Wed,  3 Dec 2025 13:03:15 +0100
Message-ID: <20251203120315.62889-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Solaris defines FSCALE in <sys/param.h>:

  301 /*
  302  * Scale factor for scaled integers used to count
  303  * %cpu time and load averages.
  304  */
  305 #define FSHIFT  8               /* bits to right of fixed binary point */
  306 #define FSCALE  (1<<FSHIFT)

When emulating the SVE FSCALE instruction, we defines the same name
in decodetree format in target/arm/tcg/sve.decode:

  1129:FSCALE          01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm

This leads to a definition clash:

  In file included from ../target/arm/tcg/translate-sve.c:21:
  ../target/arm/tcg/translate.h:875:17: error: pasting "trans_" and "(" does not give a valid preprocessing token
    875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
        |                 ^~~~~~
  ../target/arm/tcg/translate-sve.c:4205:5: note: in expansion of macro 'TRANS_FEAT'
   4205 |     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
        |     ^~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        | ^~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4249:12: error: expected declaration specifiers or '...' before numeric constant
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        |            ^~~~~~
  ../target/arm/tcg/translate.h:875:25: note: in definition of macro 'TRANS_FEAT'
    875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
        |                         ^~~~
  ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        | ^~~~~~~~~~
  ../target/arm/tcg/translate.h:875:47: error: pasting "arg_" and "(" does not give a valid preprocessing token
    875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
        |                                               ^~~~
  ../target/arm/tcg/translate-sve.c:4205:5: note: in expansion of macro 'TRANS_FEAT'
   4205 |     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
        |     ^~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        | ^~~~~~~~~~
  In file included from ../target/arm/tcg/translate-sve.c:100:
  libqemu-aarch64-softmmu.a.p/decode-sve.c.inc:1227:13: warning: 'trans_FSCALE' used but never defined
   1227 | static bool trans_FSCALE(DisasContext *ctx, arg_FSCALE *a);
        |             ^~~~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4249:30: warning: 'sve_fscalbn_zpzz_fns' defined but not used [-Wunused-const-variable=]
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        |                              ^~~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4201:42: note: in definition of macro 'DO_ZPZZ_FP'
   4201 |     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
        |                                          ^~~~

As a kludge, undefine it globally in <qemu/osdep.h>.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/osdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cf8d7cf7e61..3cb45a14678 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -141,6 +141,12 @@ QEMU_EXTERN_C int daemon(int, int);
 #undef ELF_DATA
 #undef ELF_ARCH
 
+/*
+ * Avoid conflict with Solaris FSCALE definition from <sys/param.h> header,
+ * but we might as well do this unconditionally.
+ */
+#undef FSCALE
+
 #ifdef CONFIG_IOVEC
 #include <sys/uio.h>
 #endif
-- 
2.51.0


