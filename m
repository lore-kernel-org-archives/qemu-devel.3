Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06585C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQnw-0002OI-Fs; Wed, 26 Jun 2024 07:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnj-00029U-ON
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:26:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnd-0001oh-Tz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:26:58 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so22600575ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719401211; x=1720006011;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QAAVV7bCGQjjP9Q56ktaETe+k2VzCQnfXSp/MUaPUxk=;
 b=rkp26W3xwffjM+NE6mkU65xj/xczqVZd0+PaGWcQzdP0bBx1BQFPCIBwPUonPI5HVE
 5nyL5jtp5bjjvoc0zHbapOLHI0/ENN/gpEkpAWGJRIlzmUs/9UD0jVjBMTvFC+aznAeo
 hsp1v8sY0MeTAQyjydVFO67YZ0E6482o4clSgKscj9/igd0uk9PnXBFEEPy1WhUsm17a
 Zm3PqqnbTXNoCoYc6Ew7sJ3cfTQBxnxiJ0FEI/mmZsCxDTPIQnPdCVnGbR3EgdZ2YgCH
 lJF6PNOkB/417UJssmS/E0Dk0sMU1gejjAP1XUv32sOhhi++JKtP6C5yOyiZD+GIooWr
 mwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719401211; x=1720006011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QAAVV7bCGQjjP9Q56ktaETe+k2VzCQnfXSp/MUaPUxk=;
 b=b4oMt0utbgplBjnkzJY8u1UmnThUTTyAnVzT4ijRYWi/AVdYCHz1Ftj0Wf9NQfxb5y
 JJjLFIHy4DM2JBFbtxkD5YCg44NYzTCkzUUNj2qHpUhUVkjxYRsGJ1QqaXr7rGRYIB0I
 CKwJErySB5Y/kSYMm3ski+gQ4gCJxkORwbjRqMvjglCoqdr8s2uCKKVm+1K5jHme1Cdr
 4Qhh2pVPapuCyslVCAAzpSWQwJRZw+twwwUR1Nyd6Z4sC1I/5BJFlmHircPmcqITT5lZ
 mHxJsAHkbJjAIDdnCO2y3eRcwaewXfZ/+is+zASXYRvBQjPG1NUGA0h2Ig5WQgzohiCV
 VC4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMz1dtlFrs7luU3Q39RsJL7oseKRAs3h2Txhw6/qU6MwmyAT5GWdBwm/CuJk6VFPTatEWFXpH/rTrGRIXNbR5Z1rSYclg=
X-Gm-Message-State: AOJu0YzeJWeqXYQ0xlwqQovulRqT70Q7TxcRZfIrmCp79vGWglBN1TXd
 qeAML2YBGj1D59AM7A3L5tJoorTCSeHFhm68pn2uVuPcrKQtql199k3BZYvuTUQ=
X-Google-Smtp-Source: AGHT+IEf/MsNpyPHDuCwiYD9K5fnACZTHnuU/JPSsGxOllRjMQiz2O5juclK1ilJWK+MJeZErTRcGg==
X-Received: by 2002:a17:902:e851:b0:1fa:cbf:c8b9 with SMTP id
 d9443c01a7336-1fa158f79b2mr137648795ad.38.1719401211264; 
 Wed, 26 Jun 2024 04:26:51 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f9eb323636sm96936345ad.102.2024.06.26.04.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:26:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:26:23 +0900
Subject: [PATCH 2/6] tests/tcg/aarch64: Fix test architecture specification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-tcg-v1-2-0bad656307d8@daynix.com>
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
In-Reply-To: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

sme-smopa-2.c requires sme-i16i64 but the compiler option used not to
specify it. Instead, the extension was specified with the inline
assembly, resulting in mixing assembly code targeting sme-i1664 and C
code that does not target sme-i1664.

clang version 18.1.6 does not support such mixing so properly specify
the extension with the compiler option instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/aarch64/sme-smopa-2.c   |  2 +-
 tests/tcg/aarch64/Makefile.target | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/aarch64/sme-smopa-2.c b/tests/tcg/aarch64/sme-smopa-2.c
index c9f48c3bfca2..2c9707065992 100644
--- a/tests/tcg/aarch64/sme-smopa-2.c
+++ b/tests/tcg/aarch64/sme-smopa-2.c
@@ -14,7 +14,7 @@ int main()
     long svl;
 
     /* Validate that we have a wide enough vector for 4 elements. */
-    asm(".arch armv8-r+sme-i64\n\trdsvl %0, #1" : "=r"(svl));
+    asm("rdsvl %0, #1" : "=r"(svl));
     if (svl < 32) {
         return 0;
     }
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9af7..f53a1d615c21 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -27,7 +27,8 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME); \
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme-i16i64, CROSS_AS_HAS_ARMV9_SME_I1664)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
@@ -68,7 +69,14 @@ endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
+AARCH64_TESTS += sme-outprod1 sme-smopa-1
+sme-%: CFLAGS += -march=armv9-a+sme
+endif
+
+# SME I16I64 Tests
+ifneq ($(CROSS_AS_HAS_ARMV9_SME_I1664),)
+AARCH64_TESTS += sme-smopa-2
+sme-smopa-2: CFLAGS += -march=armv9-a+sme-i16i64+sme
 endif
 
 # System Registers Tests

-- 
2.45.2


