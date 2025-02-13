Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFB1C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaAd-0004VT-8m; Thu, 13 Feb 2025 09:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAb-0004Tt-3S
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:25 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAY-0006nY-H9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:24 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38dc73cc5acso579493f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456781; x=1740061581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNJ8WW6iY498MqH2CWe2uCFtkY9p00Gknfy30JxtKWU=;
 b=CFQqL22MW+eLBK0NVu5nJrGGu83FypvraJWI99GModpJdt3hAKG/b++qd2laXNw3iv
 R85eCGSItBX+oART7h3KPEjeeRtbZfmfv0ZyWxb1b5CT00Dwqg7mRo58Qxu6OZAy+1NH
 Yq/UWpGICsgaJH0Ce19Snc3ne/y3Ovotp1hM0g+6KUfRSkue6BUWmXV7TtZWV+Yc2seG
 4kc9vrvleMDwmFj/cf6fw4mOvtFQc5szOqniAtlDikw3cWEkcX+gmBn6sJN1PcHwGsGM
 l9N7kci4b54lKJuJA9KUyH6pAr1spH5SgBok6KrQSPYIDqQkQsb661cNMLRyD61x3NpX
 R7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456781; x=1740061581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNJ8WW6iY498MqH2CWe2uCFtkY9p00Gknfy30JxtKWU=;
 b=MrSJ9eRViDGnIX9FMj3dpAGGfV/7ZWteEmA65JWL2oms0SX5e4i53Sqx1Q2gzYYkXJ
 ZEwMr40uI/S6L4CoKxG5BIjay7Fm7ZNXmZXg1D1uSua8a4o/2pl42NJvqxMdFsfBCSQW
 QosQ/Z2IUOUZUsHpbhxZ3OaBBtYOzOGOiC/yoJBAbB8INem3KVekCoi/6htVJEY+QQ4Z
 lN2jRzDchlNgIGErzcBQJ5voYwwztX03ZNh0YoLBlhRNmnjX3R3nv5sO3HeBEMiShumO
 v+/XssgT48sTG1eyAg3Wvb2bPIcQi7fFPFD0fraje1FGaunYjkO5hoKDmIvwcZkKJJGa
 uyqA==
X-Gm-Message-State: AOJu0Yz3Ln8i9oSGohK7HB3R2gx9dmPwtLT9jVmij2z6OxNumTVLEjLn
 jE+aDEHhcz/trvMAgZvoP3mE1bgVD/9MsMtVapS6sjJ4rvB/+4wgWL7mpSGvY08jKgumJXBr/dT
 H
X-Gm-Gg: ASbGncs+0Zv+DadBhUAuVFumbwZjFBwl3ETX8F3IUelRnwcvquqKU468s6oD8OxBXOD
 bm5NlqDkXn8QaYb6B3RC+av4KUJQEt9paJXUwobZK5t48qgm4ZsTCr6QbKPam71JqX979heRt4P
 UG9GUldKi0HwvmiNODomUAWYb4QaEtAmO0ykF+7zZ+GzdPdhJwyIPc8i1XIG/1b6UyW3jDYZQcN
 FHRznGFEhSxi/EF/3dxk+lz2a4hzFDADeA6xp4PGGbAW2y52pZp3+a8p8V2HUlcpBdTzmO+yUAm
 b4IWJIOn2Q5k1VC5Iv8B6g==
X-Google-Smtp-Source: AGHT+IH915u9B0n0Sud1+HijY8SheKohjFo7CfuiaFuQV4L9Mlv4wAEeCvH2btWZlPsDZFuC/9Jw/g==
X-Received: by 2002:a5d:6603:0:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-38f24f06c50mr3087956f8f.1.1739456780880; 
 Thu, 13 Feb 2025 06:26:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4335sm2093604f8f.15.2025.02.13.06.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:26:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 3/4] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
Date: Thu, 13 Feb 2025 14:26:12 +0000
Message-ID: <20250213142613.151308-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213142613.151308-1-peter.maydell@linaro.org>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

The x86 DE bit in the FPU and MXCSR status is supposed to be set
when an input denormal is consumed. We didn't previously report
this from softfloat, so the x86 code either simply didn't set
the DE bit or else incorrectly wired it up to denormal_flushed,
depending on which register you looked at.

Now we have input_denormal_used we can wire up these DE bits
with the semantics they are supposed to have.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index cd965a1f582..66febbacee1 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -215,7 +215,7 @@ static void merge_exception_flags(CPUX86State *env, int old_flags)
                        (new_flags & float_flag_overflow ? FPUS_OE : 0) |
                        (new_flags & float_flag_underflow ? FPUS_UE : 0) |
                        (new_flags & float_flag_inexact ? FPUS_PE : 0) |
-                       (new_flags & float_flag_input_denormal_flushed ? FPUS_DE : 0)));
+                       (new_flags & float_flag_input_denormal_used ? FPUS_DE : 0)));
 }
 
 static inline floatx80 helper_fdiv(CPUX86State *env, floatx80 a, floatx80 b)
@@ -3251,6 +3251,7 @@ void update_mxcsr_status(CPUX86State *env)
 
     /* Set exception flags.  */
     set_float_exception_flags((mxcsr & FPUS_IE ? float_flag_invalid : 0) |
+                              (mxcsr & FPUS_DE ? float_flag_input_denormal_used : 0) |
                               (mxcsr & FPUS_ZE ? float_flag_divbyzero : 0) |
                               (mxcsr & FPUS_OE ? float_flag_overflow : 0) |
                               (mxcsr & FPUS_UE ? float_flag_underflow : 0) |
@@ -3267,14 +3268,8 @@ void update_mxcsr_status(CPUX86State *env)
 void update_mxcsr_from_sse_status(CPUX86State *env)
 {
     int flags = get_float_exception_flags(&env->sse_status);
-    /*
-     * The MXCSR denormal flag has opposite semantics to
-     * float_flag_input_denormal_flushed (the softfloat code sets that flag
-     * only when flushing input denormals to zero, but SSE sets it
-     * only when not flushing them to zero), so is not converted
-     * here.
-     */
     env->mxcsr |= ((flags & float_flag_invalid ? FPUS_IE : 0) |
+                   (flags & float_flag_input_denormal_used ? FPUS_DE : 0) |
                    (flags & float_flag_divbyzero ? FPUS_ZE : 0) |
                    (flags & float_flag_overflow ? FPUS_OE : 0) |
                    (flags & float_flag_underflow ? FPUS_UE : 0) |
-- 
2.43.0


