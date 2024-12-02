Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121F9D78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6WV-0006Ls-UG; Mon, 02 Dec 2024 08:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gu-0002jW-2r
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:30 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003Th-Gl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:27 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so948997f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145287; x=1733750087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mc9TdQ5B4JVTfGpbGlyL+6fSC7bsW93adDUcKdH34tw=;
 b=UnO6jmJa5KVxEjgL7NCcul8zA1vvh40JnoJ/vOvACxuZMJiCLtg9bwBmcoD/NsKupw
 F660wV2ualRAQps7a9zvCle07DUecmqgXjiiBUgS6p0ShWMGPqCvstyQ05W6qElw0jNc
 OetmvtppnUc2h8+z8zC1FrreudVVIPTo0LsurLpNUPjnjbSc9qt+m4ei3zr7ducP1gq7
 3JyplxcgcFAf7QxqlTOTyfEnooM28mbFEOQYwKCD2Zy0OHRjAGtIQZWsybIhJ0rXqDyd
 3Z9yoccZ9C8UuMwGfMtOs0ugGFq3eQrW5gg/1gxoaTcnI1eGOcoWh9nY6rtnA6XFePc6
 eJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145287; x=1733750087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mc9TdQ5B4JVTfGpbGlyL+6fSC7bsW93adDUcKdH34tw=;
 b=qyUGqwvViAT9GLl7tS4lZGsfqzqT+YY3R//c+Kwai6y+SclUHjBLYAggt8tC7HsNlf
 4HCX294wfVkBKnnOlQ6fGuq5LHuidJSrWzrPYHPsHiqYGPEDvQvv3CBW7TOzwciYeyvb
 FnEIZlYdZ7ES2o1RBVVr1drerSh1kaR0WrkXIZQWcc+JYvF4FqU+r9iDMX1pQlMa+z/0
 A+gbE872oeeZ4Pv860EllmOodIJCZ+GM/vIGuRRSa/TLAYd7ChZhkHZ3Ll0iR78qte0S
 MJQ/n5Bvy3lEHa6NwdOJ8GyASLuvigQh/SjnqE6n0fNCXijlcTyBVCO1V918HDsSs5VH
 ZRJQ==
X-Gm-Message-State: AOJu0YzCMMLlRn4NY2S4qmOd85kgg1wOLwCSwcoEKeKTBKCNBqHRYiSI
 7GnX+Vb2bhSNDEpZGrieCHA1L4o1uUD4/xWal6IVd33tQmNwAD2X4AKy15jtZa1+XJqePHU17Yx
 O
X-Gm-Gg: ASbGncu8WehT4WdtSJ9tSsCblzJTtox6Bo9HXg6qiMNutWTRZQYy+w7/GitXmT0aK7L
 ipbMdrMbU/1SiRdQ8fPC7bZYP0Qs3oKexcrUXfK2UgGF+3F6BH/5xs1BQyfwDTCNWTusxGA5ZBY
 1moxPpdb/aYaHMRzUUhP6O7RBCD0eucs7Mw49dFk1z7vqOIQr+Vf71r8lCXQEZWI/YQKAGzO0/l
 lW1Q5gFr30rjQOgtkaOZwqSQe1eipvi6IZgF8gPu7LQDZ0DZ+M+K0E=
X-Google-Smtp-Source: AGHT+IE7TZ9HLEylyGxlNLd8UOKgZcyVAZG/YDCLYYUz45z1whmCbtIPbHtQM9QMqlWtZ+JyMGgcIQ==
X-Received: by 2002:a5d:64c7:0:b0:385:f7e5:de88 with SMTP id
 ffacd0b85a97d-385f7e5dfe3mr1852046f8f.3.1733145286878; 
 Mon, 02 Dec 2024 05:14:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:46 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 41/54] target/loongarch: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:34 +0000
Message-Id: <20241202131347.498124-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Set the default NaN pattern explicitly for loongarch.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/loongarch/tcg/fpu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index aea5e0fe5e6..a83acf64b08 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -38,6 +38,8 @@ void restore_fp_status(CPULoongArchState *env)
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, &env->fp_status);
+    /* Default NaN: sign bit clear, msb frac bit set */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
-- 
2.34.1


