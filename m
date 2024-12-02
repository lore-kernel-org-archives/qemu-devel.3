Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE9FD78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6UL-0000BJ-7l; Mon, 02 Dec 2024 08:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Go-0002gS-Cd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:27 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GX-0003HE-Tl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:20 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e96a285eso879507f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145266; x=1733750066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVdc4tZyi1UviPeSEA9C0j58Iz1J5UUJq0KN40I4wsc=;
 b=yzxLQQFh5ZAoRMP+QJ1WOdNdShuHCb63ny70ztlOgIjkhnHbpt47gTWKmDHWFPP54w
 rYwDp9wBFzmhg2X8aWu5t/jJ1Q4TjGHiA+cLha7itEs2NqY/7BmUKsjqRXQ5dJlCDF4a
 ZYFDKm61j4hDotovagmPQ9PwUNoJE1Nsm5m8QzDzw6bAG5ONtUfIH96Nxthj1Cr/Ojyj
 3N7kjGZvOnuc6ARRCUzUis2xpH6H9rN4pctboLCM+kGgARwoGdACUhToegNo/Mh8s2cl
 ViOy2sg95X/8nRsWWbr17iKfhpT2BUTUKWwGXwE4t0ECJDxLk0w68lg7f5WnM/qOSHVI
 /sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145266; x=1733750066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVdc4tZyi1UviPeSEA9C0j58Iz1J5UUJq0KN40I4wsc=;
 b=R3H/YO7i6+sZA922g7fDuWHc7UWIYNVZNKDNeeD1hdcsl9jjZKkFu67rh8rw64nl6a
 tz3i0+YKEbVYIwOSegIS7X4mNix1fIzN7wO7hAfBxJDe1vDsjcidcz7NrRtTBUImh1Xp
 NYtSM3vpdzF91dYYb72KeZ9t6BApFtcKiNZy3kfYZepXKhkRRaa/5tWET/h/jQeqZFHp
 Cn6azXMFP48aQP+U/L04m347qCMjwifC5oEIwIdgkTk0u0/ES+USnxemaEPhcENMSYqt
 D58aNhHTMrIxTjK/yRWomgs769FrYU5OGEtt5epBSMHAF4OT/icasU1u+9vGkvIRqeId
 IVww==
X-Gm-Message-State: AOJu0YzED4BdwYRJKUrCVBXjvus+uVJP/5PEsq1clwfEKXuTxODvlAm8
 4OkbfoEbtye/1oXBRdtot9nT3f7YXeU8z6ByyCgs6cMkYvgJ0iq6feG+KT+YCiC8/ySPNrLbAkw
 /
X-Gm-Gg: ASbGncusMfjX8bgWtBEtZKxEHbyg5ifDrrmzUw0MrPfiTqVEb64Aw1a0ZzrNu4L1yjW
 qpRUX9TE27GjhjbQ6lP/+ScbwjSJ7BC8WAh3PeDr2Mtcw8bjCxeS3bdGqYTqM3sBt/C+syfI9bU
 TVf1wXnJHK9Rgwzbt/e+RLB9bz8cJi8LZgeRKXklPsrlHI1qIeynQ/dHmwLtOnFrLTWbmQ+zZ2A
 Pl/wRuWAHxnQTPT7nIn3BiI7SjrDnJMwqVKMLA2/5k2+sSqT/mrxK4=
X-Google-Smtp-Source: AGHT+IFX1etwkjarTt46ZlKph01y4djx8VmdliUA9Wg/W51R9iVpkNjJ7oK3rgJgCn5gIz9g28Kmog==
X-Received: by 2002:a05:6000:1566:b0:382:4f70:10cf with SMTP id
 ffacd0b85a97d-385c6ebba5cmr20127579f8f.20.1733145265729; 
 Mon, 02 Dec 2024 05:14:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:25 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 20/54] target/s390x: Set Float3NaNPropRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:13 +0000
Message-Id: <20241202131347.498124-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Set the Float3NaNPropRule explicitly for s390x, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 173b9eadb57..8a36280df1a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -511,8 +511,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
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


