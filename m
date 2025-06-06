Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C3C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWLH-0005M8-R4; Fri, 06 Jun 2025 08:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJF-0003jx-Ax
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJC-00060h-Ev
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyIpbhdOi8uKuobeqFQ0SyC2g54IbnY9g+PvajejF10=;
 b=N2HElMrVS5ieGU1kCd3Pc4CRAAHPcWzqvXk4IWVFc+KsL5FxyfJ5cdJ92rsoW+1nfK/5LE
 fUBde688UODXvDVD5jySnkfG8TbYs+CkqIMHOQAJ/fK513tGe9KzcDstF2kRayP8llE4/c
 QVHtj/DaT5IEdDSiTW4yC4CT5fWH/uQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-nLeCYytqNBi-mSEcZKGdGA-1; Fri, 06 Jun 2025 08:36:27 -0400
X-MC-Unique: nLeCYytqNBi-mSEcZKGdGA-1
X-Mimecast-MFC-AGG-ID: nLeCYytqNBi-mSEcZKGdGA_1749213386
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso857882f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213386; x=1749818186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyIpbhdOi8uKuobeqFQ0SyC2g54IbnY9g+PvajejF10=;
 b=IRZSHb1Il/dNhAu97qYJ5A5/h1iI4sCqE77KCObQvQVDA8nmfZSUY+EMryu/UMIep1
 XfnAc1OtZ/A68UR2dgY7JsYfX/fAaemuWJ/Q5JmevRBPJNv4ncaQfjS6C6Jt5jpWKOT0
 O3KyXbdzIA/FXMsorcoLOnwjj8Wl6shvLEwJB7lQDtRIqBfcAlMBHSrekr81xSES0fZr
 aEAQVZGwiXN454/q53oFP5SUsYSSSKxResXLJxurvpgsrho4VZzVesZaOXqIzOQ9eJuh
 MFC8kiSY8NTZOwXH65+ICM1WHbssdGinXgOor33V6LqkvZGs1F32HT7NAnB2BJaPXTkk
 t4pQ==
X-Gm-Message-State: AOJu0Yyd1jPhoUr+e3lb51IkEJ/axFTI+2gHSxrYIJo47/Rjh1yrrj57
 XoK8mwEjejjjbUDb/3jyIbyr1D735IBRSNtwkNeoUxLIH96sdXc9/Mm3kmipcs4ZYzfIUeHX6i8
 5DCUdxA3caSmJ1Ishcn9S7dG3FA4D4Q0AQo9692Fy6diYMOJ6oudFcXuMRCD22kb46Pe+SucyvO
 LzvmhP2J+bQu8XOf4BuPmCOA5fsdK1f38x/miw3L5t
X-Gm-Gg: ASbGncsoVSVKMJiVvj7Lc1X6GfgBJHFPjhilcu2xXsvIH7jfVutseUKkgUphmI3Oeb8
 N6szmlyAA5wZ1JMcU1EoDJXRDuO1d1Q2YOsNaiNO2EEEjdXCxKz+vhZcWBXgyTiZwC0lLkyN+5L
 gfI0jth3dW4bsLqpn6JfkJqjbOxl8v4VIStDD70rHzRe+6oyFwP98oCTQ3nx7b0D/ZO3KJpvZc3
 8JkDxGeYxV4ukjw1i9iOQCZCrvtYj0hm0/nkyIWpVSxplWADj2t0OOy8aRLFz1LGIbMl47+AE4G
 oOLoid1PLTzqgQ==
X-Received: by 2002:a05:6000:24c7:b0:3a4:eb80:762d with SMTP id
 ffacd0b85a97d-3a531ced4d6mr2688897f8f.56.1749213385680; 
 Fri, 06 Jun 2025 05:36:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjKSWHwsLztWavBGBqjF5996qH2rHn6DOuj45BCS3rTP383DLnhHp5pEbqz7iRZWesnR8G3Q==
X-Received: by 2002:a05:6000:24c7:b0:3a4:eb80:762d with SMTP id
 ffacd0b85a97d-3a531ced4d6mr2688876f8f.56.1749213385201; 
 Fri, 06 Jun 2025 05:36:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e05636dsm20342895e9.4.2025.06.06.05.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 28/31] target/i386: Detect flush-to-zero after rounding
Date: Fri,  6 Jun 2025 14:34:42 +0200
Message-ID: <20250606123447.538131-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The Intel SDM section 10.2.3.3 on the MXCSR.FTZ bit says that we
flush outputs to zero when we detect underflow, which is after
rounding.  Set the detect_ftz flag accordingly.

This allows us to enable the test in fma.c which checks this
behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250519145114.2786534-2-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 8 ++++----
 tests/tcg/x86_64/fma.c       | 5 -----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 1cbadb14533..9ea67ea76c8 100644
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
2.49.0


