Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A695C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUady-0006Vs-2y; Mon, 29 Jan 2024 18:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadp-0006BN-8r
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:13 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadn-0008S0-Ju
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:12 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3be3753e002so805653b6e.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569330; x=1707174130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYcGKO9y7L+9nQKGBMKS98rrLGXyxY/fBFTDvtgcJC4=;
 b=Rxl/VITV8Y/bXMaO62TtB9n2lta5ynEBH8WEs0TzcrqJtqdo83mATO85xHH1JjC7LQ
 CXGDanNmnf1irhZdTXK+OR8tp7xcv9Ny1eXLyQePBUf3dRE9gzviL0EdQk0CJOSwU3v+
 bBxylUcPKATNwpQSa0FlH6XzVhEP/UOO9Cb7DzjPmkb59HU1cAjE/gMgHnOGO3wekCH1
 uWu+/i4slzpVeFWS2qCK67C7ghmBiJWgINBO5KGzvf9nsOQxeJz1U6O520ighJWhWtyP
 gW4RkgDEVrgoOzHfdmSCCaCVU4OXoE/TFmhNKF1GV8oBoNQ0mnXep0fw+Wh84KIM+CCf
 2w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569330; x=1707174130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYcGKO9y7L+9nQKGBMKS98rrLGXyxY/fBFTDvtgcJC4=;
 b=TRHrExM1hwxkZ1Uwdija4sxm9I6kGM3dhrSSLoesX9V7PqRNJ+CyEr9aB4SPsqgN6l
 1mIKwpDGqgtKwIIy1eqP5+ay5dSEKcS8E1poyrQC9XpwFAlNXLuV9rCRW3V/QlgBUHAT
 QE+ZENSYdCWsRfaiEtACM3sE56378FfwibDATjbY2uDDT3PaOh9chmWAyNgyzyJANW5T
 FPx+Z4UrDXbkh1h3HMrvr1LJQfgtWcS0uo4zCyNyKWfDPMrgCSemqMG6P5Ot3jkifWYK
 xuMduXj05kqQTT+XbXpfoYPWGvqby6LKROrZQzr3SKyrLQ+k6NCO90CMYFXYQEwo7RB6
 oJUQ==
X-Gm-Message-State: AOJu0YwYBZBpcqp2xyd31WWiZSF9184rib8OirGjld2swhx2dzRWs1+v
 GPkVuzNHnSQE3pXZwSZv2TJ4jCGnmlUVJ5E/5KI9vysWwmapOtelTHKye60c6B6GFWKKiL2SRe1
 SDbA=
X-Google-Smtp-Source: AGHT+IHO2vMWUCKwP+CKOFpiif7GKnI8W80zMD7g5F6kLh7XuphMOC2pV466UmncBTR9QKOAJaMCzg==
X-Received: by 2002:a05:6808:144e:b0:3be:c63:adb7 with SMTP id
 x14-20020a056808144e00b003be0c63adb7mr5908986oiv.38.1706569330243; 
 Mon, 29 Jan 2024 15:02:10 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/31] accel/tcg: Make use of qemu_target_page_mask() in perf.c
Date: Tue, 30 Jan 2024 09:01:06 +1000
Message-Id: <20240129230121.8091-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Stop using TARGET_PAGE_MASK in order to make perf.c more
target-agnostic.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231212003837.64090-2-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240125054631.78867-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index cd1aa99a7e..ba75c1bbe4 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "elf.h"
+#include "exec/target_page.h"
 #include "exec/exec-all.h"
 #include "qemu/timer.h"
 #include "tcg/tcg.h"
@@ -335,7 +336,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         /* FIXME: This replicates the restore_state_to_opc() logic. */
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
-            q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
+            q[insn].address |= (guest_pc & qemu_target_page_mask());
         } else {
 #if defined(TARGET_I386)
             q[insn].address -= tb->cs_base;
-- 
2.34.1


