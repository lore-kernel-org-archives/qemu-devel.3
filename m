Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A12D0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L4R-0004nQ-BG; Fri, 25 Oct 2024 10:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L4A-0004PJ-KO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3z-0007vH-34
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so21294035e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865594; x=1730470394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D17Ee6pVmUO+XC5zV2qFLSsZ3L5n+f/7oR7L3Btz1qY=;
 b=cAK75Km+rTrSaHVpzm5LZt73g11cAWk0qPgRPeZN58LFEMdFV2iBKNVT5IwzgLWqD0
 s67H6KcSyLqO6Gp445X+v4aRQY8NMlaeuF1yhkNqQJqtM01f06VkCbUuSQxxVHYYbVv0
 pFFyAPGWwv3GtxgafnApGvaD9iGWNVz6jsb6c07Ry2RuO62bAAWU5cLbJ4xwdiLvIc6J
 lPm2nlbJflFosP7oUUZikzhy3Tu1r/R4JoTjyKzRkMrUhkSfbDFijR8JQ4QXzD28U+uZ
 axOZNiQkHyLEAB0sK5yyWX1I9H8B5ZZQtqiw00ReaBzrLcZ0gBdhFJprxauYAjrhVCXd
 1O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865594; x=1730470394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D17Ee6pVmUO+XC5zV2qFLSsZ3L5n+f/7oR7L3Btz1qY=;
 b=E4RX1SJbpeKJke0HEjBntB7KTPGVLbbsELTnC+Hn/5K10N2Fvjb1Xluua8auLQR+b8
 XdvUvzxokdNKtkqHPfbkvf9gWuBQGSPvrWmhNYKMya/BlyuNoEnGS2R2HiE5AU9hbiPh
 Lsa1h7I1+XsOY8xunAel44hqDJnzmDuwDuyUFGaIzcJ9R27E0cQ64AudpguvwY9jeGAU
 ONv4y2uAwcDU0Mb/CMsuKV8OxOVlM02CNqRVyJc0leJrCYifdolsQa0D6A6ypRCn4Bxw
 z5JBImFq7JrW6GuMweQrT+iq+EpApr7XLkLIfAw+6iskAsTtJ7/IC5ApiE0eb7dvA3S9
 qY3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9vwAS7KymATEnbDbI5ih616xX1mrNkklBIBRlflJ6OzhwWmpvU+TKPdEtZ6vaCZwSbllcj3fGvg1l@nongnu.org
X-Gm-Message-State: AOJu0Yzc2fQKohB3TFloZ94KF0PKtaaq+uqg0WxezByRDBsA9SaI1CYk
 QmWkKG6AssXdM82KXRSwG+BT3t+Uipz87ZhVCpd32KIMxR+sFQO0MHIKWK8sLjE=
X-Google-Smtp-Source: AGHT+IE6SunM3yD3t4t30wBjNrnIVLm0v13hiEc1NlGpoPN0dqsnmdSTJwzAz0kK7OG5Le9C/0ne6w==
X-Received: by 2002:a05:600c:1d98:b0:430:5356:ac92 with SMTP id
 5b1f17b1804b1-4318c6e8ad6mr49585085e9.7.1729865593604; 
 Fri, 25 Oct 2024 07:13:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:13 -0700 (PDT)
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
Subject: [PATCH 20/21] target/rx: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:53 +0100
Message-Id: <20241025141254.2141506-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
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

Set the NaN propagation rule explicitly for the float_status word
used in the rx target.

This not the architecturally correct behaviour, but since this is a
no-behaviour-change patch, we leave a TODO note to that effect.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/rx/cpu.c                | 7 +++++++
 fpu/softfloat-specialize.c.inc | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 36d2a6f1890..65a74ce720f 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -93,6 +93,13 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     env->fpsw = 0;
     set_flush_to_zero(1, &env->fp_status);
     set_flush_inputs_to_zero(1, &env->fp_status);
+    /*
+     * TODO: this is not the correct NaN propagation rule for this
+     * architecture. The "RX Family User's Manual: Software" table 1.6
+     * defines the propagation rules as "prefer SNaN over QNaN;
+     * then prefer dest over source", which is float_2nan_prop_s_ab.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
 }
 
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ee5c73cad46..254bbd67168 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -407,7 +407,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
     || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
     || defined(TARGET_I386) || defined(TARGET_ALPHA) \
-    || defined(TARGET_MICROBLAZE) || defined(TARGET_OPENRISC)
+    || defined(TARGET_MICROBLAZE) || defined(TARGET_OPENRISC) \
+    || defined(TARGET_RX)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


