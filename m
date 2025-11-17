Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA28CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 01:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKoF4-0002ui-G7; Sun, 16 Nov 2025 20:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEh-0002Zm-Hu
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:56 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEf-0005zQ-Ko
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:55 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4eda6a8cc12so37262051cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 17:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763343652; x=1763948452; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4G0LUaHVjRLipt18uVGmD/7yEmHNUriC3cGKHgX8iT0=;
 b=jG4b8QkxVp4Gdc7uitjraMTFwmxujOL0JVchxwMCwXgnSfi7DZ+ZxnE1fqg3uAzklu
 gg2GBErxcXoxT5PcQKrfYdaYz9dviVEOi23ynxMXLRJv5AaVuIOLEcHvmnmcACBIVd+i
 l6ZZa8ui9FMojKtTnC48dMlT4atbN5g/3PyRzEbG/3AX0J/PH5e6aK0djkfLB1LELxUP
 2yyBk26gqmsqz/9aR/JXqwgsntTDNPjsbs7hCe4+bgkOiNt8wevcau1Z8wJ6Bn/pmUjV
 RFOF7/EqRo3L10MXd/PduY3syJVVjuvKoF6koWiatuIbRaTIpfF6V8y5aT8OtQEwY41j
 ngIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763343652; x=1763948452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4G0LUaHVjRLipt18uVGmD/7yEmHNUriC3cGKHgX8iT0=;
 b=Cga0GHsUPhUsscPq7I+dcp97aHL4iWjcKnY1s8KQbdNR+NFA+elYk+5W/ghw7h/7Vg
 dvbUxgZM3sxMwV5g3MfMTFw+ilrdJ6+F/RNTP3j4yYTO//ug/ZFD5rogz/SAW1aoW+Ia
 2V4ESPDv4hATs2IXfcyBPCOBrOMTyUgJMhQXbD+z/nd853JE86DoPtRWnBhkIOGkE/Sp
 M/w64yGY2WtXi2hLoFJKMy7C7jdxohQx024Vdcnyt+OwtFRkvYv6F2tMpluRgQ0vvmwf
 jlXZ3ZE+VCxFrwRdQrilnkmjbcJIDd+Zk0H/q70IHUmCAtK778q2J5C9jjFhEJSud4ox
 K3jw==
X-Gm-Message-State: AOJu0YzRPHnejOQkxaexRtU+qEeSf09mHwD0CIFI7A42Zs0jnjJzkqRU
 9bsqJsu7wjv4EOp1nx0B8HiumP0/B7fmnYU8lBA+Zx55xkS1HQ9xh0ls
X-Gm-Gg: ASbGncvhdVnz8FCzLL3aTl0c72IJNGuVZS/MRbSHrPNvvIfI3OZTulZfV1+cz50TOjh
 kFOEUdzTOHanQeQ05Pzz0j0f2dOpNQKToS4jqW5gcDS49uUm4ns0vhmG0lea3JSxeqSLmo/zh5b
 tSg5tcaGRPNHrr4GaBsPnSXkWwaFsmwR5eCL/gbNLHaYhml5xEmhS1Aso3/B6T7sLeYZZVyoRJ5
 GMz9ejgHxdEHGdhQMH3QZ5fEX1IPl8pVQjkJJFJNActEqxkQQDSygmx2NQZxDk9MTfJC/xWoo/5
 Sxl+MtYdkBHSTqleNc43lOvj88+2WKYcLuiz+60TnQP7FGaQZ/LoxdcqakojkW9Tt8p3iWjWz4F
 u4ruj9JCf2moX3KSAdzx2ayOmlztlYMpePOquNvgAGf7X0ulcHX7ZnjoJbBz4r/hEqNepygGYF7
 JyIFHAWFXn
X-Google-Smtp-Source: AGHT+IEtVyCep6Mxs/pJAFeoEQW+By8B2+7r8wHWr4oThGjrQkNImUy7b2TTLk9kKCb2KMZuqJkogg==
X-Received: by 2002:a05:622a:4ce:b0:4ed:b94c:774a with SMTP id
 d75a77b69052e-4edf2064a00mr136332161cf.5.1763343652290; 
 Sun, 16 Nov 2025 17:40:52 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm18246551cf.30.2025.11.16.17.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 17:40:51 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Sun, 16 Nov 2025 20:40:27 -0500
Subject: [PATCH RFC v2 10/10] docs: added MTE4 features to docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-feat-mte4-v2-10-9a7122b7fa76@gmail.com>
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
In-Reply-To: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763343639; l=2269;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=X2CU2v1Bo36028vyprRyJIHd8Jk2/fTfa9Qlc4iG/4k=;
 b=2FWy2rFsTYqumUPYykh1h9GWoYoap1o72p+FA+3QduQl5XW0oJkBvGCG8A+hMHt6TQT56K15Z
 BS8OraP3z54DDziBzvbEBx64fOaup1nNomA5wSyhMNw67YB1KwNiu29
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x82c.google.com
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

The implemented MTE4 features are now present in
docs/system/arm/emulation.rst

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 docs/system/arm/emulation.rst | 4 ++++
 target/arm/tcg/cpu64.c        | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 31a5878a8f..62b66b2227 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -106,6 +106,10 @@ the following architecture extensions:
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
+- FEAT_MTE_TAGGED_FAR (Full address reporting of Tag Check Fault)
+- FEAT_MTE_STORE_ONLY (Store-only tag checking)
+- FEAT_MTE_CANONICAL_TAGS (Canonical tag checking)
+- FEAT_MTE_NO_ADDRESS_TAGS (Address tagging disabled)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ca9557f4cf..7d003706a0 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1282,13 +1282,13 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     t = FIELD_DP64(t, ID_AA64PFR1,
-            MTEX, 0);   /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
+            MTEX, 1);   /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
-    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 0);    /* FEAT_MTE_TAGGED_FAR */
-    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 0);   /* FEAT_MTE_STORE_ONLY */
-    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 0);    /* FEAT_MTE_PERM */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1);   /* FEAT_MTE_STORE_ONLY */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);    /* FEAT_MTE_PERM */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);

-- 
2.51.2


