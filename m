Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE47D7831A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6N7-0001EH-U9; Mon, 02 Dec 2024 08:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GR-0002GZ-Gs
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:02 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GL-0003Dx-8Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:57 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e35912f1so1677682f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145253; x=1733750053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILG1Z/M6B7uFxp4kFKW2IzoAsh4FqMmE+eh75zkfLko=;
 b=FiXc4x5z/Y1gUN7BTHEfUMujr2ZtzX2wsRwQP4c8zbey3baT+nLLHw1j5cRFho01/E
 k2yD+BqfIQZMpDzr+yrH1WjxxBjOy0NxyDHwkDI+C56AeNIrKFkvA2JYiZ+7vOHm0sue
 9YwcN+i9GHsjAK352RQPye9oqvDNnvLTKCiG8TfOOyyAUj/nSdA3Z9kyhCfeQI5bDWBw
 I3l3RU09XqJO2l4l6wPmOm/fSkQgg7izORiRWheJXWp9sP+B+iFzx6XyJ13JndRV2zIp
 OcHjjz+DrDZSfx1xwTMn/3Z+5vkLam+8kH2wdiIW2DCh0TifKIvHMNV2tLFaPPm6Tnlv
 IHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145253; x=1733750053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILG1Z/M6B7uFxp4kFKW2IzoAsh4FqMmE+eh75zkfLko=;
 b=FiUtEbwTKL3eVDcntttkCW+X9tgqDalkI14TBTP1Hditosc9SnUk1q4mn4FAW4T8oi
 vyEMPQSNRPhR0HVgICWLX7Vczch/VHB9nozquuf9Cx4Be86XBWfDFsis2pBtR8d5J62R
 0DqkbOh4wg6MtA/PbV6gMp544qjGTU9euIMumoGkZ7+nTxycQQWIbg+LX09nKixetuF7
 3GYJpl9ubzii1PLlKaSZRN82XyXaSI6uhNs6pkur7QXGdYomcKWAG2m+UhH3G2HS3HUW
 qtqKzrcCoIZoFXOAEpuXs6irDjeSxr++zJcmXUyV1JvdHUAeUo/MS8OnsHF2AOW54r/L
 sy3g==
X-Gm-Message-State: AOJu0YzwPV7NJjyAPj1wWlBEhsatQ8x5aKxEgIC4/Mc9pSJas30B0bgW
 QZ8EV57MsT4bO2j4+GHPxKwlyE1P3QL3Dc7j7d6pv7qvuH0bjVCUSunJM4krYjy47BwPMCQzJ8+
 C
X-Gm-Gg: ASbGnct2rkwGp4aOMGMePDYs/nqSlW3pE7oQ2eTO838b6WZjhk74kPjwCzXoH65kSkf
 4J9oN5FQFVmEfC1vaIkMPoBf8WZcun3U4X49GHk1pwIeZlaVFZhmefZ+27Gy9NndX0T70hvHlC5
 8Ji1fR3PPoGj4o0hnxaXXPZ7cqR2k9fVf/cQCq7vihXsiOAEy/SjdcSJurZJDqznsaVnm4DK9/5
 I+i+SzeRvq7GKETUsyGIMt21gVsm+jwL/1PZn1JncaMl8upiv07nec=
X-Google-Smtp-Source: AGHT+IH/BdBMZ0YZ5BZUq73sumipnQV70zAwYH3ayAVJ8S0pggKoSjQKPZjHAdmDnCF8uJZAVTJuLQ==
X-Received: by 2002:a05:6000:4026:b0:385:f16d:48b4 with SMTP id
 ffacd0b85a97d-385f16d4f88mr3719008f8f.40.1733145253603; 
 Mon, 02 Dec 2024 05:14:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:13 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 14/54] softfloat: Pass have_snan to pickNaNMulAdd
Date: Mon,  2 Dec 2024 13:13:07 +0000
Message-Id: <20241202131347.498124-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The new implementation of pickNaNMulAdd() will find it convenient
to know whether at least one of the three arguments to the muladd
was a signaling NaN. We already calculate that in the caller,
so pass it in as a new bool have_snan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc      | 5 +++--
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index aac1f9cd28c..655b7d9da51 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -67,8 +67,9 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
 {
     int which;
     bool infzero = (ab_mask == float_cmask_infzero);
+    bool have_snan = (abc_mask & float_cmask_snan);
 
-    if (unlikely(abc_mask & float_cmask_snan)) {
+    if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
@@ -80,7 +81,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     if (s->default_nan_mode) {
         which = 3;
     } else {
-        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
+        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, have_snan, s);
     }
 
     if (which == 3) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 3e4ec938b25..a769c71f545 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -473,7 +473,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 | Return values : 0 : a; 1 : b; 2 : c; 3 : default-NaN
 *----------------------------------------------------------------------------*/
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
-                         bool infzero, float_status *status)
+                         bool infzero, bool have_snan, float_status *status)
 {
     /*
      * We guarantee not to require the target to tell us how to
-- 
2.34.1


