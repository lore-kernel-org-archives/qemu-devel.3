Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04A3D690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0g-0003Ao-LV; Thu, 28 Nov 2024 05:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzu-0002BZ-SO
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:49 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzf-0000eS-Hz
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:39 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53df7f6a133so318150e87.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790608; x=1733395408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4JtTEJWuqktTR0K+Db+JfgEPXYfhnr/W1wwAJOuIfc=;
 b=vTrQdMwMQlyCy4CfLnN+OY6HJ5KqnUs3wS5HuxGhdxARs3AtinxKIHgIKl/DCkOJhV
 5+JAjaljN4v4yiGx3Suyj8HoKVB2PflR73jygF5gj7whsIhdw9LgtimuL0DIazsbk47v
 f9j8EV4Et4+g/rPp3SfR8wShMJjX4WSk5GR8mgu6X/aOE0rOSZaAUedRgaj++uId0cui
 ruGrwRLdnmwDshNOEGWffhqtkxZLo+7Nyus/YenHrRfEZ2CuKrYBbp07IudJnmdniTty
 LlIl3BugBGQxdUIAOexZePwdEFdDsiQf53OArZUw0h0lCIuwGxVl4pYdjRzICjGGCLXr
 EW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790608; x=1733395408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4JtTEJWuqktTR0K+Db+JfgEPXYfhnr/W1wwAJOuIfc=;
 b=eehbSZk3blp9Uvh5MJS/8IYCd6ncIMhtlZaRIJ695BDccWxia0VxHH9iX/FXZM/WG/
 YVPGsdRWYbgy8r3zcHlpGxwr7avQ1QzguLgxb1cIZge8EZdar2SloMshS+eV2NT/Vets
 J7JAKH1iL7rkqa2OGvRN77VlKokri5JkGT7QCijDAc0HbLsQBYKszP6fAYDUdp8VTYF3
 /ADB3raKCyCe416U/mkBAVYN8GnwkL629sPfCU6+6u4UKQP4RaMLzHoIw5ATmtUN/QrQ
 NoSqc0jq1vXV/BVNOsiuKYHgydpLZo9AfO4eO9jtuAWW/qgef1fzTGhozt0neZ4NUJXJ
 Er3g==
X-Gm-Message-State: AOJu0YwFcufII80izOHQVL2+JYLAM6F/u/mavKJtoUuzauCYnFa6h1B2
 Vlrq5D+8Y2wObhsk5anXMbgcDsAeGXPq8Q818theggXYd9QYqKiNhRt7khXqJJVh3thH/afVd6L
 +
X-Gm-Gg: ASbGnctJ2wAwNPxb8xgqZR9kPG8Pwx/zVdQZ/FLtid2qPsMDcfCIJUe8YC9D8a2Vrtl
 O9FUKlhKAenkdrwyFxqyakLVs2h3PB+azw2my6h5/F1/37CVp9nscZ/i6bnXnKX5xnSOTlLN9Xy
 dDXCld/K4saBGh50QdG9j8FQqHOidwLIl0c03f+3W6SA4vVtoNN/eQAIy6OZbzVDmJCectx1gGi
 rcFNtHkoC6PjIxmHibaZxxJsiBufQlImMh6/ANORd+a1Gio8zBeIC4=
X-Google-Smtp-Source: AGHT+IFznEpI3626Zge6MstJ38Rvz+FlulNzVErYAdeWNT7kyvFMFVQK7nEiiNlSohoHqRH1nB9MVw==
X-Received: by 2002:a05:6512:1115:b0:53d:ecce:361f with SMTP id
 2adb3069b0e04-53df00d9e74mr3968213e87.30.1732790608301; 
 Thu, 28 Nov 2024 02:43:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:27 -0800 (PST)
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
Subject: [PATCH for-10.0 17/25] target/loongarch: Set Float3NaNPropRule
 explicitly
Date: Thu, 28 Nov 2024 10:43:02 +0000
Message-Id: <20241128104310.3452934-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

Set the Float3NaNPropRule explicitly for loongarch, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/loongarch/tcg/fpu_helper.c | 1 +
 fpu/softfloat-specialize.c.inc    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index 6a2c4b5b1db..37a48599366 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -37,6 +37,7 @@ void restore_fp_status(CPULoongArchState *env)
      * case sets InvalidOp and returns the input value 'c'
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 9b5243c9529..32edb493776 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -508,8 +508,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_LOONGARCH64)
-        rule = float_3nan_prop_s_cab;
 #elif defined(TARGET_PPC)
         /*
          * If fRA is a NaN return it; otherwise if fRB is a NaN return it;
-- 
2.34.1


