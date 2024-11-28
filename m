Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AAAD690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbza-00021S-47; Thu, 28 Nov 2024 05:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzY-0001zR-DX
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzS-0000Si-Vj
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so5874685e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790597; x=1733395397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tTkIIhrcxBZurdxQEsXyUswGgpnjQ7q8C2Djt24mE4=;
 b=r9xj4aTE4ShualRlnld2+iMsZzYiXm2LI8n0CBjxgSoOzLaMS2jcyYMQPRu6rngEa2
 dAwR+LeYK7/6PwmdIBuNvutUS1KlCuuzdodyeFww33hKJf4P8fN4dW5EH0q+PBWXlDLj
 d3VSYbeXyRuF4DlzEwWqVz9Bp2vsfvBTc012EqK01f2iay24ayWUt/Og/ViZdeQiaWq9
 +bnWk3U4Uv9W/95ufPXR7GlIdj5z+zJVdrwtUpATDLSkptVBo3h+ritqLEOGpmipAQ8O
 Txs8DDvF1VKwFORbszyk69r94SjCKkSGllUVaJ7mhqVykVd21PYeKauqcJp/iYH5NiI0
 0ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790597; x=1733395397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tTkIIhrcxBZurdxQEsXyUswGgpnjQ7q8C2Djt24mE4=;
 b=Y2YZ0NOSwWGiYCSGSwe+SSnjm1XMjbaqfnDBZjmFG30v+yzIZssIcnBvJ+8uiUu0wV
 TcbHc1awbdeMSumaivczgI9rx99DHWjGwwR8JOX17BmZ4TQVHRgD0Mge2mtAaYKw2zUY
 4Rf21aIVW1wxp8cENgSbEYunbZ0ANae4JvKduR9QTvIrRcr870qPFZalnCuXrf1ULBew
 2MusaRTp/0VxUwFdYDBYZ53RR8EhatNwwQx5GB6lcNFat0Y/1++4fIY+hMuouyQAfA8o
 2IPPgpGPaqsdLIQpqmEXMlJHMNXwjC4zssD0d8Vm9BvsDjzNI/e/x9BsHgeSSPfdV8VB
 QcIw==
X-Gm-Message-State: AOJu0YxqPS9zo+r2KclTFbuIs8x4kLNggfWLAo+YJCTNN7ttujjYj/Iv
 Pv8y22u27MBqhBHV4hKfzy4sfcdOWOksQtSvEj5CEH540GiXyd8UzpHglnC02dosIH5s8Y5+SkN
 +
X-Gm-Gg: ASbGncvcXQR4goIlCIN92l986Vwc377byLySDxjSPNsJA2DNULGAmn5lnJGMCL9ofq5
 zqp1FtWqvRqvyUiLFuo6zfTFy05P6EKWzocQgVNPKJgMH35xawY16ezpVJch5Jw0v7pwI1up/EJ
 z+ZYtsSJU13va9wzk96591jobI1FY7Iy0rpDHE9EeXZ35W8r5sytN+K5UCbZRE5qU/qd3LGn8GG
 9Ta1D6DGlOQrPtKdsbH0dnRAs5So4rjcBANKcc9SYHvueK0BQgykzU=
X-Google-Smtp-Source: AGHT+IG5lSeN2KFb6Yig+OEBeyIMwuYEw2rT4BgFuZynv+ZIVjSU7aBGEarxaDG3Yeq6RQ+0eWBgGw==
X-Received: by 2002:a05:6000:2b0f:b0:382:4a75:57f4 with SMTP id
 ffacd0b85a97d-385c6ef38bdmr3968690f8f.56.1732790597461; 
 Thu, 28 Nov 2024 02:43:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:17 -0800 (PST)
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
Subject: [PATCH for-10.0 05/25] target/arm: Set FloatInfZeroNaNRule explicitly
Date: Thu, 28 Nov 2024 10:42:50 +0000
Message-Id: <20241128104310.3452934-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Set the FloatInfZeroNaNRule explicitly for the Arm target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c               | 3 +++
 fpu/softfloat-specialize.c.inc | 8 +-------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b954..ead39793985 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -173,11 +173,14 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  *  * tininess-before-rounding
  *  * 2-input NaN propagation prefers SNaN over QNaN, and then
  *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
+ *    and the input NaN if it is signalling
  */
 static void arm_set_default_fp_behaviours(float_status *s)
 {
     set_float_detect_tininess(float_tininess_before_rounding, s);
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
 }
 
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index f5b422e07b5..b3ffa54f368 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,13 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_ARM)
-        /*
-         * For ARM, the (inf,zero,qnan) case returns the default NaN,
-         * but (inf,zero,snan) returns the input NaN.
-         */
-        rule = float_infzeronan_dnan_if_qnan;
-#elif defined(TARGET_MIPS)
+#if defined(TARGET_MIPS)
         if (snan_bit_is_one(status)) {
             /*
              * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
-- 
2.34.1


