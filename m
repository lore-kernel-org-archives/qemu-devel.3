Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BD5CCD18E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DOt-0002Ch-84; Fri, 10 Oct 2025 09:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOm-000294-Lq
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOT-0007np-GR
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so2426655f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103753; x=1760708553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wozWQ4+uKhU2Woke0EiPtGgDjWqN+p+Av15OT51Ys1o=;
 b=CZyK/SYWWIqxN+JiCD0ks+wEAzbLuIBS4tJZTut0Q1ReuEWtDLuwaSTQUTFK/JK1xs
 6VyuLPFwgOqHw8F8JPWTLrOiOQtJMO3AfZLGA4R6tqLd0vTcp0xkA3JYUG8+uP+iqqG5
 hWZgWBQl4QPoqJ7zhA1bERTfkq55OOZiHESccj5nPiknrGbQALDnH8dIX7O8FVJJkUaO
 2a9HvvVGUulf+gPOPOAXqA/mh6Cqmd84S0Rn3dtSUIvRzbk+IhBEsdI+YmDdYp9CUYAX
 mXhvsWAwKKARE3Ja2BhgUh3gMy20ae9kjqM/rWXJKGVwaTQA+3VW9G/R7vETRC9qTG16
 Gb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103753; x=1760708553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wozWQ4+uKhU2Woke0EiPtGgDjWqN+p+Av15OT51Ys1o=;
 b=bqmX7n8N5xbnoOR9VcYVW6rZ8qhtptVQXbUpgfZe8NnOMDUTaNQKub5QeebHKQvDRw
 WNa6z/UYFpKJngw1zNlMc6DeP6MLZcL6WEvBlLtvKzoP2n5lI4TUEGtQTfHzMaU9YQP+
 W3ZUO+2+r+wCu7bPbumrmnG0eslW87lQatuJqTxkfnAXHuqFSSxG0+6d5d4lr1Uzr7n/
 TbjEBO4QzHTa1oDDcdhD37FfCm1ZyHttVY87a04DtElFB5eBHA46o41R5GpEHbqEgGzf
 VAiq9kYFeGgEs+J1lDR/xJ/7vv/YPf549EWjg3Jtj8oGPt10bQl54btSHzKqBBpJhYAB
 hVZw==
X-Gm-Message-State: AOJu0Yx3lZb3Xxqnkcj3oEIo16uzNaHgqAVtJd5mx1lGi/BK0wcfw483
 x7OgaQMWp4aWfwScOR6BCyd6fW5Z8h93BJzlJcH03EU16+DbUpw7kac207EI4he23KpmG25G+VB
 IUnpBTMQb6w==
X-Gm-Gg: ASbGncvIxO2zKTGyD5bnnvp6cVXKhwOJpe9PGepvRFXVZ9fMlL2hHb3Q4cNpeJlYynl
 HgIS5XLoaVWKpSPyw670MKxn8C+3xcj88krcDny3omNL45Uwpc4aCcJuA/lcbaFFxyuGkiTDYso
 CHgIj9kCAMFk/+3K91VvCjnQeqHcRE9ppHWDWK7d2U+3vH1yPin2ov9gCfgkieYAI5U/OGTsWUM
 5ohDRvR6ulDNUvF/2C59EO5S6q/1IWc4/cfFwdBF5CcuV231pG6YInj8l7pL71M7hSBHzzWziQm
 pQu6Hk1/3cDzBHFSwzOfWAY5GZSwS7+d/rPMt95gB9io74liBJbHPpxmbz+iYVQuvKLeYaXw5lz
 +WkrJS2V2p8316OVrHDI80CVMOm5gbs74KHtoiDdXu/kMV/lPEUCKwiMP277RUk/FQby/SA472y
 QFEn5IOGBM53R2QpvxYkmv4Uk9C5a32g==
X-Google-Smtp-Source: AGHT+IErZZEwB4uw1hXoXCFarD7Y+fhbeaRNLRAD8qc0l2ueYPzIctHC9WNhaN8/3Y7GMnt0v+LIkA==
X-Received: by 2002:a05:6000:2505:b0:405:3028:1be2 with SMTP id
 ffacd0b85a97d-42666ac4748mr7297622f8f.11.1760103753514; 
 Fri, 10 Oct 2025 06:42:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce50d70esm4457288f8f.0.2025.10.10.06.42.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:42:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 01/16] linux-user/arm: Checkpatch style cleanups
Date: Fri, 10 Oct 2025 15:42:10 +0200
Message-ID: <20251010134226.72221-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Update style in a pair of methods we are going to modify in
the following commit. No functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/arm/nwfpe/fpa11_cpdt.c | 66 ++++++++++++++++---------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/linux-user/arm/nwfpe/fpa11_cpdt.c b/linux-user/arm/nwfpe/fpa11_cpdt.c
index fee525937c5..6b0317883a7 100644
--- a/linux-user/arm/nwfpe/fpa11_cpdt.c
+++ b/linux-user/arm/nwfpe/fpa11_cpdt.c
@@ -40,18 +40,18 @@ void loadSingle(const unsigned int Fn, target_ulong addr)
 static inline
 void loadDouble(const unsigned int Fn, target_ulong addr)
 {
-   FPA11 *fpa11 = GET_FPA11();
-   unsigned int *p;
-   p = (unsigned int*)&fpa11->fpreg[Fn].fDouble;
-   fpa11->fType[Fn] = typeDouble;
+    FPA11 *fpa11 = GET_FPA11();
+    unsigned int *p;
+    p = (unsigned int *)&fpa11->fpreg[Fn].fDouble;
+    fpa11->fType[Fn] = typeDouble;
 #if HOST_BIG_ENDIAN
-   /* FIXME - handle failure of get_user() */
-   get_user_u32(p[0], addr); /* sign & exponent */
-   get_user_u32(p[1], addr + 4);
+    /* FIXME - handle failure of get_user() */
+    get_user_u32(p[0], addr);       /* sign & exponent */
+    get_user_u32(p[1], addr + 4);
 #else
-   /* FIXME - handle failure of get_user() */
-   get_user_u32(p[0], addr + 4);
-   get_user_u32(p[1], addr); /* sign & exponent */
+    /* FIXME - handle failure of get_user() */
+    get_user_u32(p[0], addr + 4);
+    get_user_u32(p[1], addr);       /* sign & exponent */
 #endif
 }
 
@@ -108,16 +108,18 @@ void storeSingle(const unsigned int Fn, target_ulong addr)
 {
    FPA11 *fpa11 = GET_FPA11();
    float32 val;
-   register unsigned int *p = (unsigned int*)&val;
+   register unsigned int *p = (unsigned int *)&val;
 
    switch (fpa11->fType[Fn])
    {
       case typeDouble:
-         val = float64_to_float32(fpa11->fpreg[Fn].fDouble, &fpa11->fp_status);
+         val = float64_to_float32(fpa11->fpreg[Fn].fDouble,
+                                  &fpa11->fp_status);
       break;
 
       case typeExtended:
-         val = floatx80_to_float32(fpa11->fpreg[Fn].fExtended, &fpa11->fp_status);
+         val = floatx80_to_float32(fpa11->fpreg[Fn].fExtended,
+                                   &fpa11->fp_status);
       break;
 
       default: val = fpa11->fpreg[Fn].fSingle;
@@ -130,29 +132,31 @@ void storeSingle(const unsigned int Fn, target_ulong addr)
 static inline
 void storeDouble(const unsigned int Fn, target_ulong addr)
 {
-   FPA11 *fpa11 = GET_FPA11();
-   float64 val;
-   register unsigned int *p = (unsigned int*)&val;
+    FPA11 *fpa11 = GET_FPA11();
+    float64 val;
+    register unsigned int *p = (unsigned int *)&val;
 
-   switch (fpa11->fType[Fn])
-   {
-      case typeSingle:
-         val = float32_to_float64(fpa11->fpreg[Fn].fSingle, &fpa11->fp_status);
-      break;
+    switch (fpa11->fType[Fn]) {
+    case typeSingle:
+        val = float32_to_float64(fpa11->fpreg[Fn].fSingle,
+                                 &fpa11->fp_status);
+        break;
 
-      case typeExtended:
-         val = floatx80_to_float64(fpa11->fpreg[Fn].fExtended, &fpa11->fp_status);
-      break;
+    case typeExtended:
+        val = floatx80_to_float64(fpa11->fpreg[Fn].fExtended,
+                                  &fpa11->fp_status);
+        break;
 
-      default: val = fpa11->fpreg[Fn].fDouble;
-   }
-   /* FIXME - handle put_user() failures */
+    default:
+        val = fpa11->fpreg[Fn].fDouble;
+    }
+    /* FIXME - handle put_user() failures */
 #if HOST_BIG_ENDIAN
-   put_user_u32(p[0], addr);	/* msw */
-   put_user_u32(p[1], addr + 4);	/* lsw */
+    put_user_u32(p[0], addr);           /* msw */
+    put_user_u32(p[1], addr + 4);       /* lsw */
 #else
-   put_user_u32(p[1], addr);	/* msw */
-   put_user_u32(p[0], addr + 4);	/* lsw */
+    put_user_u32(p[1], addr);           /* msw */
+    put_user_u32(p[0], addr + 4);       /* lsw */
 #endif
 }
 
-- 
2.51.0


