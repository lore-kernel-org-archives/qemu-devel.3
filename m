Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA45FD78322
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Uf-0002Ac-Mn; Mon, 02 Dec 2024 08:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gq-0002ht-6X
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003NV-4z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385dfb168cbso1805752f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145278; x=1733750078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9P3Zyg8EWDd8Ipp5Pjnvse0G07D293rwdAJ1WyzXl4=;
 b=K3Uar6D9jDn935gVUS/K3XuqOaAeoIE9Y08KA8se4kghYofFPzypz9slIGW/2US56A
 ZrpK7Bc06XUuVWPlIOm6cyU609T90o2vM1aofBHBDbYovnokHZ+5wR3fpTdxr3Oqb2oz
 XM0CEignuPdU/54AZuIA/OEfg8FsNYngNh7hmDmLalUJiCQWAqe4JHx9xNNQoAsTE9jp
 P6yfzk8gp9ZxQ0WKj9DYCWxZlFcjaiaz1a/rwxTx86jjA2y6d/EACPXuSlXZz5Gv5pf3
 /uZITmIizSGKkapFvFEsSpmuotbGjyO8O8302nWVqhJ24sRbmMdCSdHY66sCQNA1KjBj
 f6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145278; x=1733750078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9P3Zyg8EWDd8Ipp5Pjnvse0G07D293rwdAJ1WyzXl4=;
 b=G3k4+LE4O84JIj18LHCVDQO13fZ2p04dpDryjkIYRTQaI5R5xAAOYLbbK5Ltd43u7O
 gbWXw3EO7bsjPFH790UA33DiO0xVXFoLcQUX+8A3AkmHgaFQTNGnC3cVd2OooYN1/CFv
 8qmPzLGZLPOq/aepIGu+aO4yWu+SpXCPri48zrGQvcjgcS8P6jPheSAa0krY6Tk9sWNw
 QIfVBxYgEJ5zla1s6f08JS8+BDZK6KvarwxmQu/4R+UtjoGWFc42GO07W4j14drxT52V
 rtVex2hAKVz/HX+ftJFc2ouriMkZyLijOy3OdNbCbPLb7xAzetGAUyjKnOR18bEQfoCl
 +QJA==
X-Gm-Message-State: AOJu0YzCZJ/1Ti1ROUapG8VqtjDEGdWabgiamZ3hg/n4RJuW19K6Spsx
 tAxrAESH9TrPGN3BGviSRhEr5hN7GVaLyAPEDz6nEHTHIFh8/eDa3QTAOKohbKhkJ62OhcnkpF7
 n
X-Gm-Gg: ASbGncuhr+YknIozkoe1UKauNvieSeb+c287oTDCQTjmFGNylqE1EKNO839urbwRpK1
 zS+eT+1nkm1xb4Q5K/c9qI1FG82ZBWZFJNYBklD/HqIGYH0bnC104X/zrzR9XL96mkzNAO5hRG2
 j4WkKvIZkzdrrIBFf/ipxgk8e9Vyg20XqS2JhgwoGtc+n2+uz8dhFSrKjElQTH+ABa0Cglpl6/w
 53oseBm5Xe4AeZ35E1x4xmq9zPq0ESRlUJe9QDI1q8aTVJDXY05GjA=
X-Google-Smtp-Source: AGHT+IFL61A+tairJzPOItayh6olQ1F+IieedrTB8+3a6uLQVDTHerrpGpRDJzdWMxXPxCl7i8SUAA==
X-Received: by 2002:a05:6000:2d04:b0:385:e30a:394b with SMTP id
 ffacd0b85a97d-385e30a3bdcmr6032714f8f.16.1733145277754; 
 Mon, 02 Dec 2024 05:14:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:37 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 31/54] target/m68k: Init local float_status from
 env fp_status in gdb get/set reg
Date: Mon,  2 Dec 2024 13:13:24 +0000
Message-Id: <20241202131347.498124-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

In cf_fpu_gdb_get_reg() and cf_fpu_gdb_set_reg() we do the conversion
from float64 to floatx80 using a scratch float_status, because we
don't want the conversion to affect the CPU's floating point exception
status. Currently we use a zero-initialized float_status. This will
get steadily more awkward as we add config knobs to float_status
that the target must initialize. Avoid having to add any of that
configuration here by instead initializing our local float_status
from the env->fp_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bfc6ae97c0..beefeb7069c 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -36,7 +36,8 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
     CPUM68KState *env = &cpu->env;
 
     if (n < 8) {
-        float_status s = {};
+        /* Use scratch float_status so any exceptions don't change CPU state */
+        float_status s = env->fp_status;
         return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
@@ -56,7 +57,8 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     CPUM68KState *env = &cpu->env;
 
     if (n < 8) {
-        float_status s = {};
+        /* Use scratch float_status so any exceptions don't change CPU state */
+        float_status s = env->fp_status;
         env->fregs[n].d = float64_to_floatx80(ldq_be_p(mem_buf), &s);
         return 8;
     }
-- 
2.34.1


