Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CEED0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L4J-0004XO-O8; Fri, 25 Oct 2024 10:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L49-0004OH-24
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3x-0007uK-Gd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso21476885e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865592; x=1730470392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMvryF9qkcHmjr/I6qQdi1be4a3BwpUnonGBJuEa1aE=;
 b=ODYsXzs2oGzg1KOhMmCailOU5vkt1bPS2TGEQXiA+TdVtyXlO5EegJGbAnpW+KMxuh
 Rili1Yv+mQm5aWsp72XSTnuAioIh3+zcqwP0aXwjDFRbtvOzOH0zjpvB9L7bvDs7WpXN
 AUfj8e7oM2JUZSA7vdrvmG5T9c0V8tPOVXv0Xey67A6eATfqM/tsw0Y3zxv7cTlFxalF
 mii0bzftcopxGirixt2HnIWYTTjFyCc11TtBi6m8p97oZvYgCjDPLGmXPswaoqHG5Ddj
 91h2C9BsEhg7/x89ABiIfwUXd+V8I/nvpIGWeNYfFyVETbNRNcN45yCkfF3pmNAU08JH
 G53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865592; x=1730470392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMvryF9qkcHmjr/I6qQdi1be4a3BwpUnonGBJuEa1aE=;
 b=vKWL7CPJ4wL7exh5LfXNDlw8fGiPLCdzcem568EAsGAdN2IjBXlXoRxkUpoVoPLnMm
 NWHnKOfmeB6ZFzR3l6B+iuhk6yOAya7RabvdXd7DoTpwITQb0D6kiOwGfzRSq2hT/TgS
 mFG0nclpTyyJLXeAwYoARL/54pQe964NDjrFN0KxKMlYoGz0CFh2IOvJjJgctSStpAZn
 7ZozidvmZsb/Mh8QmgdMVkzwANP8i/SO1pB2PGCzd1s7Mxqjg21y8CGu9X+CwcfWYvH7
 bOwTgejWIflce0MeBcOgn4blSbpEgcMA2R/fhVuyL92qNIfWOsBEGyFLUgL8t0vWoKoP
 vFEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpcpcq/E8ZQqTCiGvBkzref6jLugofI34lmZkUF/R7YivpRbHzqL6dw8qJNs/YHKEZGSbjUoAByf+@nongnu.org
X-Gm-Message-State: AOJu0YyQxGNeQwS3zg9alFRrKLEa3iHqHwh4UDFMGmfjZtJZE5QA8Vmn
 pVJHRwj7PnEyCJBL6pd8/FqEBkRGRo1FnTLa86iIoev6pXAbn8gVLvGlC/GV37I=
X-Google-Smtp-Source: AGHT+IHxNq6/vkQ2TaPaeuuAkFK4+FFHuybPNerZNA0H29NUQ0TotXUp+CFWvnyAmdoq+Iu4Dr5CZg==
X-Received: by 2002:a05:600c:19c6:b0:431:4fa0:2e0b with SMTP id
 5b1f17b1804b1-4318c754b24mr47132065e9.28.1729865591969; 
 Fri, 25 Oct 2024 07:13:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:11 -0700 (PDT)
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
Subject: [PATCH 18/21] target/microblaze: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:51 +0100
Message-Id: <20241025141254.2141506-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Set the NaN propagation rule explicitly for the float_status word
used in the microblaze target.

This is probably not the architecturally correct behaviour,
but since this is a no-behaviour-change patch, we leave a
TODO note to that effect.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/microblaze/cpu.c        | 5 +++++
 fpu/softfloat-specialize.c.inc | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6329a774331..14286deead9 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -202,6 +202,11 @@ static void mb_cpu_reset_hold(Object *obj, ResetType type)
     env->pc = cpu->cfg.base_vectors;
 
     set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
+    /*
+     * TODO: this is probably not the correct NaN propagation rule for
+     * this architecture.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
 
 #if defined(CONFIG_USER_ONLY)
     /* start in user mode with interrupts enabled.  */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index a5c3e2b8de5..40cbb1ab73b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -406,7 +406,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
     || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
-    || defined(TARGET_I386) || defined(TARGET_ALPHA)
+    || defined(TARGET_I386) || defined(TARGET_ALPHA) \
+    || defined(TARGET_MICROBLAZE)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


