Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A093D690FC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc1E-0004Ax-EZ; Thu, 28 Nov 2024 05:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzu-0002A8-SM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:49 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzi-0000gE-5a
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:40 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43494a20379so5975305e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790612; x=1733395412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gk3Ta1kp4SadfMQYiQE9XBmUhbOJYxUOTQDRYm9Ciy8=;
 b=T9hnbPgJ56KqqUqex55Bj9RTfsNTWrFZfvyCe8tzzP5WS1Cw1Mz4zaimVGq+uTP9Hd
 oOCe1NcZZgN8HVVpKBwmZnSvx0DvFuQcZn5uuDTbzTSOP1iKxdZRway+0yIhHeyymxVr
 1bgcAyilNQgmRg+5e3p8HsNQxJ1mk21FL2fze6ugLFVh4cqk9QtTEb7gmLujCyH8Ve0Q
 ARaxR0IRsAL1ySl+HCO+IHqJOAxPlzAzRwb93dnwnpSVs9Yc8qc3Cz1DrVURb0M+qp0A
 kp3v4FeV4p75fVTnUqp78own/ur9JBoyB1SeOvBRG+n7/6lr/VdDOMGJrELcbrwDxEUU
 ZTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790612; x=1733395412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gk3Ta1kp4SadfMQYiQE9XBmUhbOJYxUOTQDRYm9Ciy8=;
 b=KyQugxgacDO2jTlNkkg5e+ACuig8t6CQOzoVMFXkkxYqsp8JtPhJF24N4X8km9oWAQ
 1dfJzAI0zDFBnEAJaI5YpdXYZW4IvgjbQlIedNVSC6HeBN9mXti0NVGYHOH4HdXFJvm9
 epPhKvFUo4cczT4sKTP3Ijn1GIkgw5JpPrA2bk51Ypr2He4QLXq28wqWm7xSKwsR3+WI
 ju0xAhZ/JCQeey5txvcKPLd03fwuVnbjFyJGDkL/b/Jhf+/edkjpPdguRxnQX+FQ6fUA
 YPVHu8JiurUIfZhp4e9mT7dgG3uFPL4tKvGRXg10m2qtXEBSNgGPsuORpEEVhhIhhQUQ
 qSRQ==
X-Gm-Message-State: AOJu0Yx2A8rOOaE49q/kLFzar2FgJpCElXkfaSy2s8m7jB7LnNkEmj+u
 FJ92tnsu+1KZXe+2OY2eWYmorn7fk6osXLTxtOVMdnsyNR3UfQsjEHE5PbWVECdfkDvnSll2PaE
 B
X-Gm-Gg: ASbGncsP+u9W75CosNblBzlDsh5hvVPViY6sqfEWH8z8gTbOQUihvuu37vVqF9FEnNO
 xtyodkx0pqh+e8PGXpch+r8WSZcCkalstCn5rHY7v9mC+nGd3A6EGfFjfBxtrVvB6NaT0INFhdt
 iLhDgnXYspx3cIAfjc5Q+CM3Csm6E2Bh0jkDPb2Pr3k6W3PbW7lunO3ljmXVLcympRb08+xDjeK
 NhdPkgkcdIKmNSHBnrWdtVz7Cc0oHKdRstbCgf3MR1PagHsUgF+S98=
X-Google-Smtp-Source: AGHT+IHf21opook/IKPYpyUU/oWLnaC969kFG9ZVqJdEGuQQfFX8DSROTP8X+3Z/bd3pBl5u/uc4aw==
X-Received: by 2002:a05:6000:2cc:b0:382:498a:9cec with SMTP id
 ffacd0b85a97d-385c6ebb90cmr5852564f8f.13.1732790612660; 
 Thu, 28 Nov 2024 02:43:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:32 -0800 (PST)
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
Subject: [PATCH for-10.0 19/25] target/s390x: Set Float3NaNPropRule explicitly
Date: Thu, 28 Nov 2024 10:43:04 +0000
Message-Id: <20241128104310.3452934-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
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

Set the Float3NaNPropRule explicitly for s390x, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/s390x/cpu.c             | 1 +
 fpu/softfloat-specialize.c.inc | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d5941b5b9df..e74055bad79 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -206,6 +206,7 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
         set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fpu_status);
+        set_float_3nan_prop_rule(float_3nan_prop_s_abc, &env->fpu_status);
         set_float_infzeronan_rule(float_infzeronan_dnan_always,
                                   &env->fpu_status);
        /* fall through */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index d89ef62b38a..31b23ddb9bb 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -508,8 +508,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_S390X)
-        rule = float_3nan_prop_s_abc;
 #elif defined(TARGET_SPARC)
         rule = float_3nan_prop_s_cba;
 #elif defined(TARGET_XTENSA)
-- 
2.34.1


