Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40FAD78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Y4-0008HM-Br; Mon, 02 Dec 2024 08:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gz-0002yY-Ky
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:33 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003W3-NX
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a742481aso34106115e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145292; x=1733750092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxLOQbRoeGb10eLB+8NmOgmz26mWmDSAJp80nLJIeco=;
 b=l6ueompuCBChCqBxAH3yWgH31aO1Mu/HV1nV2PenVBkqFGLJg3jDxzvaRGQslwEa+Z
 KvI16I+WE63PQ6ltk24TE1r1haxnZBSuu08wmBjfrYOND7AFFG4M32Jw8TJg7y+yja6/
 BdYMNHUL08Ny6bGME3xa05nt+tZq/MjBy4RcP8h0eIV6VRF9TCcfdc7roo1NclS0rbvc
 L1LhrwXYSb6DjEYkvKVfhjdcW6agoYx5EEMz4LqgscR7eQsClQEhPRjbU1gPvC5Zvx0b
 KxLCV8PxbfWHCYpY98m8tjqOqF+xzxsrffroBNdFYNkr/lv4MYz00dDRHFzF0fua6aor
 p3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145292; x=1733750092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxLOQbRoeGb10eLB+8NmOgmz26mWmDSAJp80nLJIeco=;
 b=lDHCqO2Yj79Ce4aDmmPnwUaDW74c6bvffrTxQdOq5Z7G0/QtkrwiSif6mMKqJ9XF0m
 GmL6UvY9r0lWKqBArqjSrD8bz3I6KDtqMSLksiEERaC27YbrjHiUmrzrL3s9F2YcuVme
 mTR8jMWggMWeSAmh3/Dd9tvbHaNyOX55vYmeK+oQQSjXxbzq9yJy3cHN78bC69biYYuW
 d/KMOYPeqvjV/14a4rOXGc/ZMXfFKNeP+RQt+htf89d1h7+vfLUB/XU58ZoD9VS+xt5z
 vJSWwQe1CL0QV5QL9hZj8bul08/qvhuYsUd1345mq6u2oJ2yVFhJ7rzS7xfzQbR2SexU
 j9lw==
X-Gm-Message-State: AOJu0YzW3hR68EZPS5knhnmZyPJyEfJzWF+Vs9oPxH33AfAcb08JsPxv
 Cu8kuoAtyfWbI2HKZjKzFyy4r7u7vWcizLmQmYHbpVFpj+NQE/LrTGLoO6sQpTfrHHsLI+mYyC8
 0
X-Gm-Gg: ASbGncugNo0wsJw/JB+THZdANw6CytTKMN5PCvKoT+8xBn3eKKv048hwtQBPE4wh2aN
 L77f3cbfUmmp/FY9Oo2tfvVYe+VcQOBHL5wsAIYxaowpsMb0w4bsJpgGHAd8ze4mgw4OJpqonhI
 VJ5gNA76eWTBndR2QeAgOoHY1S3prAv1aeI/NXhpOJq4tbGOJWbWmUQxpOCSNZrVVO0GGRd6MIZ
 BT1WGY6B6+J6GmXzTyI5ZmlXSOOf7yu7KQ0UwfHTBGhhb9Z7uJSLr0=
X-Google-Smtp-Source: AGHT+IFqGyUblDWhtWty5ZHlDTNTNN7T512u2FwInp5HYuDUlb8l4DtOyrrXP9g08yiDPar3bIjIAw==
X-Received: by 2002:a05:6000:154c:b0:382:5aae:87c7 with SMTP id
 ffacd0b85a97d-385c6ec0b2emr18715172f8f.31.1733145291760; 
 Mon, 02 Dec 2024 05:14:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:51 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 45/54] target/ppc: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:38 +0000
Message-Id: <20241202131347.498124-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Set the default NaN pattern explicitly for ppc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/ppc/cpu_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index eb9d7b13701..1253dbf622c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7286,6 +7286,10 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->vec_status);
 
+    /* Default NaN: sign bit clear, set frac msb */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
+    set_float_default_nan_pattern(0b01000000, &env->vec_status);
+
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
 
-- 
2.34.1


