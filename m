Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CFECCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL2T-0001kH-CP; Mon, 27 Oct 2025 07:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL2H-0001Us-BK
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:05:13 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1a-0005e2-H7
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:05:13 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso7789675a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563033; x=1762167833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbvPrANYvJj3gNO97dH7gcz+uNRb8G5R8cbjz6SvgpA=;
 b=wRK/WRiWjNekM6KHFoSK3HItdhVpi7y5gpnTlQtaCvnOrB1wvKXxM/tgQSm98aWeM/
 VIsUCpZP3fe72O7AD+ZCWnXj73EwvDXWUN7tcdKAPBNSFY+ohEL06Zujqa2grjK+PkCv
 giS4BqgbzUMxgcNa8fef0nS1rwzf2GrHk4WXw+Ry3A1Nz67AkAVWTsYclrX8yQPy9FxA
 lN22VQM27woLbeNyYSqdzyMC31Bsh9Bh+4JtbvTsEB9syufUvQsk9WavYP3Vwb/AK/Gu
 HeukaiVfmO3Y3LGSsx4t1Y5bHMxj/u8X6Ct70KprzvG/jonbgpWc9cUPSpGrj0q3uywa
 Kr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563033; x=1762167833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbvPrANYvJj3gNO97dH7gcz+uNRb8G5R8cbjz6SvgpA=;
 b=HVXtZeoIQKzOgkokgyRUW7wSLiKIZXVWvRoZ3kDaA1XDkDsetTzJeK1En504ly78wX
 38vwt+X40It9WWjcOGQEg8l6kwDUJ48M3dtxEJMqF14+GYPoMkr6TUa1Czn+JOiVu+fR
 fQqmKUeQ3QOxcAaCitTCUbInQpj/0cvitC1dFm/5F6PjVF4/EMnv6oDvAACC+dk2Nk6K
 wodxMHI75Qkl3VC/PR61O6GEoB72kdf69e6pNHZdjsBlwSeV2Q/bKmMXQrDj8GlyMV7X
 TyrZuCHG18WVyzi1rvrbnPu6wihhc+tIIfd7hw+YeTJQYlE2L/QH0+VMtXNOyNp+UZi9
 tCbA==
X-Gm-Message-State: AOJu0Yxlv+rFXUjTjnHa0ZRTuMmW1DZJJmrcrxZEqDLk/8QAWRVFe5oE
 9tZG/Ct4yCANFAlQ05WWbo+jNJdLlKw8eT4gqG4URIrDxqkNXhCvuvKdnCiqs40V6fo=
X-Gm-Gg: ASbGncvfYPdaEYQzEbZi1YdmBE1bcpk4usTCuQQpAaEKAnTlsZSTNGcswDSz15OO1V1
 fLJymYkp7j2nxkwG5B+7oabIVJXk0gnFhxCFE8N2aeDzPlYD4i+d8nfgM+947n7gGjVr0tIvUZM
 eOjt83iAMDwYCcI8mdytYaOnqyU4gO1fx9j6S0HticpZHc3GTtJHJKrhkSM6Z8RAPGEzDro5TXh
 hk45jmgnqz3OLGp+CFORWkiAFipbBL6vzxZRu5hPG4/HqiiY0lsvFln4qAAWv7ZR48AllaXbZ0g
 MJnNWgPFDwQChTglfBdONvYAnb4loYIEbJo7uk8CY0gl2Qx4x0i7FbTS9Mh72AiEI8ig9DhLJvz
 tSmXWVXzYtZP8EftEcdRl2MnNN3WzgKJ5h5V3dZjRxwQQdW8HF0QEWF7bzG92omPf3AsSK5mQA7
 iW
X-Google-Smtp-Source: AGHT+IEgl+c4dRH+StKwomTRbDfEq8j/zmTZSSPAaJlwzgoFWODFr2XsptD7H1CqAq3BBX3xhzNDKw==
X-Received: by 2002:a05:6402:27d1:b0:639:f54d:9274 with SMTP id
 4fb4d7f45d1cf-63e60003a6dmr9269873a12.2.1761563032820; 
 Mon, 27 Oct 2025 04:03:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efd0bc5sm6013871a12.32.2025.10.27.04.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 277AE609B7;
 Mon, 27 Oct 2025 11:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 11/35] target/alpha: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:18 +0000
Message-ID: <20251027110344.2289945-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Alpha targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/alpha/helper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 096eac34458..a9af52a928f 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
+#include "qemu/plugin.h"
 
 
 #define CONVERT_BIT(X, SRC, DST) \
@@ -328,6 +329,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 {
     CPUAlphaState *env = cpu_env(cs);
     int i = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
@@ -431,6 +433,17 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
     /* Switch to PALmode.  */
     env->flags |= ENV_FLAG_PAL_MODE;
+
+    switch (i) {
+    case EXCP_SMP_INTERRUPT:
+    case EXCP_CLK_INTERRUPT:
+    case EXCP_DEV_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
 }
 
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.47.3


