Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9998C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaAa-0004Tj-Mf; Thu, 13 Feb 2025 09:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAX-0004TD-BG
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:22 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAV-0006mv-Ru
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:21 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43964e79314so3835975e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456778; x=1740061578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8mXjz7rvuk+LBsnPgKyClvuahjJz9F8yaCoKy1+ZSo=;
 b=yLejCSlHQaBpgU9C2USoPo3kyJeNWJTuA+3Le78vMoWehv1Ea+vGisfONoNgNdI/th
 PIyBt8D0NO8E8eSM7iSY7YRQdg5HdfzPF3Ux4/iGuwb6wJ3VaM5hhyt2oxbmDFLHmcVP
 Y8zk+R8f1tWEuECtm28pV7jItwrQw8crw43VJtyye3n4OmNxS8qbKXJl5tjjMn1SBL2p
 98r5ii4maoPaxfukI4epfWgtLA5yg+Vzyx3vDc0/BTO25PMjz5ahnuRJStRUHfZtB6HK
 SF7ZIi4etITv2vToNcEovwWxged7Uonhi2AzzCURgTOrG6vxbIt8ufEqOsUmo+t5GSKx
 dhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456778; x=1740061578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8mXjz7rvuk+LBsnPgKyClvuahjJz9F8yaCoKy1+ZSo=;
 b=ngyNJo2SM37HqC7QjcLNI2OMprG1DMrSDg8DtFajODzY+O3HmokQGGAaDGCNu4pKBb
 4v5AgrrOTXHHGazP7VpNhNZWGvJoGJ+zY6AvnEKTrwCnc/+w3Nn2bKxWFbeKdn8mIfIT
 vZvd9KNhp4nmoLvg//1BzEoecjE5k5VsuK5mgYtNy4hzOGiTZ7TPKDOZSYYXcm6sIWMP
 k2SVk4kfPBScKC8IY82+dQrgKbWpcFjs3/ELwX1MKh3LS8tpNztLufCuIDIxPlJuCwlg
 rkR/jhC/NtNyuG++B0Q4uM8HzqVL9AUgT/XJgovJ5WTB8EgJUrrndZ3hTpyZDK7Sx4xI
 U3ZA==
X-Gm-Message-State: AOJu0YwEovOTJEkChspcuI7ewj7z/8ll/8NLG3ukzQnXdgfRoQ2eVILK
 YKBuKGBeSA7h66WbmC+9hjBMnWnxymW+IZD1bgD8zuVbWWwKO5f436g2GWdF8xyOnk7san5oGPS
 0
X-Gm-Gg: ASbGncsrM6z6JLYz/ZLsPRkPZXx/skxbwc7VcBBxtscLXjjzjPU8b4CrHMYXaRdipLf
 Tatke0LvVS3QdfG0qwr/gI+TFKq17YYHIaYGRcqikd0PZMnElmtQKjr+EA5afU2C+LlnDzB/shK
 Xp9I/gg57crYRXDmU/PnIEVXgu3I4uwg84wkx3EhvTXAn5IKseZ9J/j14TbPSLpvczY3t3FVonh
 DvFDRVr6x6SvJueEe/Fu0lZxJE4vOf2ZdNFk4XUkbccx1J9gXkJqf7QmZ/6zKsLP4Ykv/d6R9Wq
 SVf/S267PwrAa/+IooVjbw==
X-Google-Smtp-Source: AGHT+IFw4wDYn3Nt2+mwdZhlZreMx+YapVr2egMC/bW18Puh4w0kpyXcSKqTxlYi+BolmQ9jiCLe7g==
X-Received: by 2002:a05:6000:154c:b0:38f:2111:f5ac with SMTP id
 ffacd0b85a97d-38f2111fcbfmr4947584f8f.31.1739456778198; 
 Thu, 13 Feb 2025 06:26:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4335sm2093604f8f.15.2025.02.13.06.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:26:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 1/4] target/i386: Detect flush-to-zero after rounding
Date: Thu, 13 Feb 2025 14:26:10 +0000
Message-ID: <20250213142613.151308-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213142613.151308-1-peter.maydell@linaro.org>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The Intel SDM section 10.2.3.3 on the MXCSR.FTZ bit says that we
flush outputs to zero when we detect underflow, which is after
rounding.  Set the detect_ftz flag accordingly.

This allows us to enable the test in fma.c which checks this
behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 8 ++++----
 tests/tcg/x86_64/fma.c       | 5 -----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f112c6c6737..87fbc149d84 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -189,13 +189,13 @@ void cpu_init_fp_statuses(CPUX86State *env)
     set_float_default_nan_pattern(0b11000000, &env->mmx_status);
     set_float_default_nan_pattern(0b11000000, &env->sse_status);
     /*
-     * TODO: x86 does flush-to-zero detection after rounding (the SDM
+     * x86 does flush-to-zero detection after rounding (the SDM
      * section 10.2.3.3 on the FTZ bit of MXCSR says that we flush
      * when we detect underflow, which x86 does after rounding).
      */
-    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
-    set_float_ftz_detection(float_ftz_before_rounding, &env->mmx_status);
-    set_float_ftz_detection(float_ftz_before_rounding, &env->sse_status);
+    set_float_ftz_detection(float_ftz_after_rounding, &env->fp_status);
+    set_float_ftz_detection(float_ftz_after_rounding, &env->mmx_status);
+    set_float_ftz_detection(float_ftz_after_rounding, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
index 09c622ebc00..46f863005ed 100644
--- a/tests/tcg/x86_64/fma.c
+++ b/tests/tcg/x86_64/fma.c
@@ -79,14 +79,9 @@ static testdata tests[] = {
     /*
      * Flushing of denormal outputs to zero should also happen after
      * rounding, so setting FTZ should not affect the result or the flags.
-     * QEMU currently does not emulate this correctly because we do the
-     * flush-to-zero check before rounding, so we incorrectly produce a
-     * zero result and set Underflow as well as Precision.
      */
-#ifdef ENABLE_FAILING_TESTS
     { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
       0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
-#endif
 };
 
 int main(void)
-- 
2.43.0


