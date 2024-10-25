Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2BFD0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L41-0004D7-Lk; Fri, 25 Oct 2024 10:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3u-00046L-Sz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3o-0007oF-4K
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso20598895e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865582; x=1730470382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixfMug0zlUN7NkGJexyOs+kqoUuLgEjdmFA8bPjqRvc=;
 b=JpVzLQtjMem9QPEwwD3MqYVycr9HYRhFThvWx+Fuefmmu+UxPRnIq6zwTlOlu3H/Iv
 fBCDTcG81/1h6pDE/nDvb/09WFZZ2PSYXpnL4M7XwwLWbIcGqFv3mbLquuKNMhCRcs7/
 42yvrZDUe41Oj+GeGD9r1a0xSaEwCCmagyWe9Ehd6OBWVfLh/RVWKsYFwN+0/6Jaz+ui
 Kn2hwdJEDqwG/eBUOFeJjWKTdjbbYYsuOOGObRM/ra4NzwgTMDWKE5B2t9/G+Y2u5Vm7
 qAgB9TJR6u3Rj5xi260sfhv3TegnrEDJWQgLN7gTyBvYN2gyX1TXZUNAUCx2n1x85zrF
 rwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865582; x=1730470382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixfMug0zlUN7NkGJexyOs+kqoUuLgEjdmFA8bPjqRvc=;
 b=Im2cc6sBuEq4lo+LahpVlvlA8wFP/OnWUT571MpJFGfhvAaRFhELdCv8l9z2fg2fzu
 t9sgWBHe0osflxmoPWPWBD0TKMQjuKUqavCk00tzkf8LohTac9z3/Cs4s03YYdhhW2Ec
 V/uogw1Vq1KhYbDyoDexZyHMQI+xZLdzngEjNSqng8VZAfKMF+mgyQ0w5TrQSc6oVSht
 HsQA9lWiXV7bCZMBVRF6fcE3nFy/JZbQnmMJgyJw/dt5pZL5DnBlCEvmaWIoQw4t7kSf
 lfE/uRHK9EOfThbesmipws3ek3Q9LOtdh+zquCpGcAGTo4GmYeNyq4jGlmJJlanBNbVk
 9tZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9408XmkUjNQDR6O4Jdu6DCAVuivO5lk/F8oqJyKpnOQeNg/AGy3c03PcC6isiOq4MFmJO9ijPjiKs@nongnu.org
X-Gm-Message-State: AOJu0YwtcC6qAxZOBCWdAJcsYyJ0hTcqsKAMDdbQNscx9bTLqb32jXhR
 P0yjJRORYu1jwyk9Aj24KjkyMBLbp66QKqsOX9NnKfsDd+ZU9DLUZEHzGmr46Kiy6dbMEcHLSlv
 g
X-Google-Smtp-Source: AGHT+IH3YD/fch70M+E+aGPD2bCRvSqrnkBVacyWnI/TVm2I6n1Jd2xUh54yaxSRPHXLPNbPgNr4Kg==
X-Received: by 2002:a05:600c:34d4:b0:431:5533:8f0b with SMTP id
 5b1f17b1804b1-43184246647mr93646725e9.32.1729865582530; 
 Fri, 25 Oct 2024 07:13:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 07/21] target/s390x: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:40 +0100
Message-Id: <20241025141254.2141506-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Set the 2-NaN propagation rule explicitly in env->fpu_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/s390x/cpu.c             | 1 +
 fpu/softfloat-specialize.c.inc | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4e41a3dff59..514c70f3010 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -205,6 +205,7 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
         /* tininess for underflow is detected before rounding */
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
+        set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fpu_status);
        /* fall through */
     case RESET_TYPE_S390_CPU_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 4e51cf8d083..a0c740e544d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -403,10 +403,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
-    || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
+    || defined(TARGET_S390X)
         g_assert_not_reached();
-#elif defined(TARGET_S390X)
-        rule = float_2nan_prop_s_ab;
 #elif defined(TARGET_PPC) || defined(TARGET_M68K)
         /*
          * PowerPC propagation rules:
-- 
2.34.1


