Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF657D690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc1D-00046U-Sr; Thu, 28 Nov 2024 05:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzf-00025n-UU
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzZ-0000Wx-NM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so6049135e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790604; x=1733395404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZVybYeuTrOgtrqao8PQeLVJYcnLhthP9z/tircoyS0=;
 b=znbQ/eo/lGQaWy3KjAaxMBQITD52czgQrWjKNMpDVPPUdH7cuN+UiE40mMdwl08atH
 NUZi1HJScs0var6b/9NDqwQ1VODwTSqIwSrohocysjxupERSm0j2MKHqMKCL/1HsntSq
 YUK3NzHP4VQWosla6RnMZwg54NgI+V3l4cR+iGp4P8I/nzhGzLFIoX6XCxtuJMAycagv
 eUph0xm10V41P2MZgHMJaVvzPX6CDqYMjDNwvGD86yn0huEJYEyIopfai33UO66TluzE
 iQGYN46BReBchn4x5/kOUTntta2giD4tKcAlC7QNmBoi/9iGTjSLrvP6piFOPSe5dApJ
 QARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790604; x=1733395404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZVybYeuTrOgtrqao8PQeLVJYcnLhthP9z/tircoyS0=;
 b=dvfK4M3QUeEUzhW+08hRmbSMpEGZrUGYpxZpMvK7Sbkd7IUUmvcjFq3PTj4D1jdbxd
 63GeiuLzzMXZ66OJSv/BY0NmKMqqhH9dTNmn8Hz3RnIM2Vkiv3f6bTZPdejMyijDkKiX
 fndTKr9TVi3PM1oaMiOT7X2OOiDy3rbqiXJS9xlFpZB30d2OEJmvIRl70v7hHLYp7P6b
 /jjL8/AGkJYZ0h9xJn2Rt6cY7W3vXOSxzFF9itjwlGs3DdLFAfoLutwrErtF5YqcHkW2
 AsRuJi+cIDaLQgA0kh+4PWMz1arE2VbuqSSW943MMIAFLmwgtFJTM7VKE97uM1OEtBOc
 JlDA==
X-Gm-Message-State: AOJu0Yy+U709OFDN7qin8vw0mY2tjqLjo2vZ2qiWE8w++GwBWOwmZTxw
 7pynjm9Ol8U4LNAMKnrJoOoTf0CFIkHc9G+Bl3Nl1fajVA7vxH20rJYcYOS8T2K1igqoipzwJ16
 6
X-Gm-Gg: ASbGncuZLsw0ZFA3vFrUrtRkWruO1qo3PII3n3ECQlSS/NvwwJkH1uVGn0hGAjZoWb0
 wsXaSdhNop4COD6Qw6LVn5YZoDGF0okDqiq4wn+CC/DzSYzg9ft5n9m5J3LgGxjc0tcYeX6v/W2
 A7vzs+gYqhvehIJQyzjbsC+mKZOQ1RWgRoB6DyALlQOG8ibAt1XygNdF6CKJXKWsHwTTzZly9cv
 A1cgjVBqQte6ksD9edbATWhhjhNmfsfkpNvvA0NM9ICSByOvwOZ61Q=
X-Google-Smtp-Source: AGHT+IGCTKRozhkWgjwMEGkUuizRTcex3BoClUrzEHGN3q3D3nUN2r90Xtnbg5I926y0Oe4UhmEuAQ==
X-Received: by 2002:a05:6000:4819:b0:382:464e:1ab4 with SMTP id
 ffacd0b85a97d-385c6eb850bmr6283508f8f.3.1732790603802; 
 Thu, 28 Nov 2024 02:43:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:23 -0800 (PST)
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
Subject: [PATCH for-10.0 12/25] target/loongarch: Set FloatInfZeroNaNRule
 explicitly
Date: Thu, 28 Nov 2024 10:42:57 +0000
Message-Id: <20241128104310.3452934-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Set the FloatInfZeroNaNRule explicitly for the loongarch target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/loongarch/tcg/fpu_helper.c | 5 +++++
 fpu/softfloat-specialize.c.inc    | 7 +------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index 21bc3b04a96..6a2c4b5b1db 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -32,6 +32,11 @@ void restore_fp_status(CPULoongArchState *env)
                             &env->fp_status);
     set_flush_to_zero(0, &env->fp_status);
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
+    /*
+     * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
+     * case sets InvalidOp and returns the input value 'c'
+     */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ad4f7096d09..05dec2fcb4c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,12 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_HPPA) || \
-    defined(TARGET_LOONGARCH)
-        /*
-         * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
-         * case sets InvalidOp and returns the input value 'c'
-         */
+#if defined(TARGET_HPPA)
         rule = float_infzeronan_dnan_never;
 #endif
     }
-- 
2.34.1


