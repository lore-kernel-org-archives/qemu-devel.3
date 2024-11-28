Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF106D690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0k-0003TP-3E; Thu, 28 Nov 2024 05:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzf-00023e-Kz
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:31 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzY-0000WQ-JV
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:29 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3825c05cc90so323125f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790603; x=1733395403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek+hZskUnfXDQCh1OptQZbXmCqnBmww89XjzyzcdKGw=;
 b=PJFES68e+hKIX0WOB/SIQaC/3sL4ImVqkL4BtBCVltz/9ksinmtlHXoiXVBDo4VdDB
 EDhERaSN4vMZulVye+OL/uJIB3h6bIgOaDEbTtVO4LI5hyNMSm0eg5KGlbbSyBSLC5DY
 maec1NEdzRMVYfBcWQ0BzjlsjJXg5yoD8VHelEEGET1+sfQk9gP+FZsY8cFfBC5IVM/7
 xv1xUYWmjur5RpjYQtt3Wpe59Tf8aFHNpJ+6b96lpwkyw+CJpC2UgMZOnnNIwbfqLHzE
 ItRaMXCN5puFeuPx2Ow2ZVLfXx3U5GiDDT21pSclfT/C4kWLXPM23leHVFrvDeTLkTXd
 QY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790603; x=1733395403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ek+hZskUnfXDQCh1OptQZbXmCqnBmww89XjzyzcdKGw=;
 b=Am3HRfwA3LtAGr6gDkRSNc+Un5iYTpiDsFHOSYX7C7z1HbqKW+gBgbjwcaO1MXc4Ax
 UsYLKOY8WgmPH/sXLK+WEdmL9bEZXAM/iUWhJ+dAnGb1xsBwwqp7r2YPyysI703aXMO6
 JwdYg7iU+1VgoQQwnh7psOIqaEixi72V3oyIGHR3k1lOKAkIvNId9Gs1zs44iY2IoqM3
 TYQWA3v5gyAc/6v2Mk8rHoZ+NKBUDUrnwpmoS1jZ11+zoQDd57Ygp/g6RqJw7RDsh3ZD
 KPLy+TD9AaLnnOXmOByDyu7JDmTnAezXHz8yeznFWagxIfCxXYGt5lwYN8EOqwObKaDL
 SX9g==
X-Gm-Message-State: AOJu0Yz0Cs4gUpCc0qX89bNodXCq/e3dEOx7Csm0uXqUStg0sqtS9qcf
 JzDL0EBk90gN0VcIOdW1IHx8oJIsYjAC5vrmrPDMjiWmXHOmRHV0PvuPuzQ/SAPZOx2GY6jLHvp
 +
X-Gm-Gg: ASbGncvA5xpsk3zYp2Jgeg9MsMl9Rg6HzNSE/0S5q+TGNVcnc0dUpXuGDYjF31RpZ72
 3/RDTWa2IA9m77szFL6ca8YdjUdWfXRtC4qZDac0jSKxrEQuYXVUMdK2unMzi0/VF6HBihl41/Q
 cUnP1eHMX19TR4ZBfg4ke5AfZ6pwRZWav/h4pZMCOZXWa/GcAtOZTfmVx2R9AuiYTwqhxF2Mam3
 pxsN6rxcmQKNyoZWOrASyy3rk58/zLD7i4GUVxMJg44+MtDsq2kR4M=
X-Google-Smtp-Source: AGHT+IEWAjOXb832xAkLwjb7/2TdWl3Q97ZUPXna3sU1PdKXSkDkT7jvbqX0c3gLPnpl2nRfuHRrow==
X-Received: by 2002:a05:6000:1846:b0:382:4d6e:9f3f with SMTP id
 ffacd0b85a97d-385c6ec0b9dmr5403598f8f.34.1732790602935; 
 Thu, 28 Nov 2024 02:43:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 11/25] target/x86: Set FloatInfZeroNaNRule explicitly
Date: Thu, 28 Nov 2024 10:42:56 +0000
Message-Id: <20241128104310.3452934-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Set the FloatInfZeroNaNRule explicitly for the x86 target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/tcg/fpu_helper.c   | 7 +++++++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 53b49bb2977..e9de084a96d 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -173,6 +173,13 @@ void cpu_init_fp_statuses(CPUX86State *env)
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->mmx_status);
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->sse_status);
+    /*
+     * Only SSE has multiply-add instructions.
+     * TODO: this might be wrong, as we never implemented any x86-specific
+     * handling for the NaN case for multiply-add. This needs to be checked
+     * against the manual.
+     */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 3062d19402d..ad4f7096d09 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -490,7 +490,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
          * Temporarily fall back to ifdef ladder
          */
 #if defined(TARGET_HPPA) || \
-    defined(TARGET_I386) || defined(TARGET_LOONGARCH)
+    defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
          * case sets InvalidOp and returns the input value 'c'
-- 
2.34.1


