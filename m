Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928C4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5l-0005xV-Kq; Wed, 24 Apr 2024 19:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5j-0005vx-4d
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:55 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5h-0003bM-NI
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:54 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5f7a42bf0adso313631a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001512; x=1714606312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bxp3OWyJKaOKfrMeAe4PH0dSXcFDE//yn/aSHHr1IuQ=;
 b=lQQ59a17K3yTU7GmpQcoczfsqlrUP5c0vbLzlb45iCfrmAUXSXG81W1RcqddnHwvCV
 cmfJDhuMjVQsH0EkkCr8xVCGps996FJecoz1hVLqMwR/seNNV9NET5uPMKQRBZ1zVwqC
 w51eNQ27cF5kvtMQqtqjtr+2seYQtZIgzX1Eum5zmNeFoD0VCbyG3IAoISo9f1XhJrKu
 4GqdSdMGSDsX1F5k6btgyEB3cEbIxVf6rw0l5K4oDJ7Vt8+6AUbnFF3VJsJhUw+CJxzu
 O/Q173sDJvLNJBlY9D9KR7hliYfuWUY3iHkN+RiIH2yne3IZ3bJ1jVQCqKxLJh/uP5k0
 uVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001512; x=1714606312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bxp3OWyJKaOKfrMeAe4PH0dSXcFDE//yn/aSHHr1IuQ=;
 b=YzVQeYTYGbleIUm52dIubBVlVJXgcvAobC8AK7J9w7QVbNiH0HbGsx3+0I9aDOZ0Wm
 uRTrsz8ONEwOPgwdb2zem28xcQF+swCQvSzhXzvJIKuFdE0PsvB0/UYIrufo+5kuNi4x
 EGj/FxkHWnyle4x8Qw1zXqn20yuqti+v6K86y7/dpT0qVB6D8N78H8nVDLlt1BYoxENl
 LBHYWO7/iZPkNDt+LLjd+TdBjBKLATMDDugwPq5hP8jp40+Ub5tAU72k6scZNrTD6IwZ
 Kq7Vc9HW/PeAVMwPCe9uJ8NtL3OxTaZdrye/rs3cHoUwS+YOaOn94GJszxdPDPE7LRgU
 w8/Q==
X-Gm-Message-State: AOJu0YyvGSwPB6ph1RC8ZEYSXkUPEmdlI8iPoyawbqswM/hsJAudCg0v
 RSa/y3EVoTR+lVvcLrcc93XYHvUohlO5ibl3XQSbCNGXifH3d9Gdx04woE71+kKnSKFoRL5aAqZ
 A
X-Google-Smtp-Source: AGHT+IHkQiDIxAX/3hncOoLnxjYtJxj6apu3FZvZW+H5tOKXm3wRFehtFb4jErIpoCYiIBZfVNX0PQ==
X-Received: by 2002:a17:90a:4b4c:b0:2ae:c098:7d79 with SMTP id
 o12-20020a17090a4b4c00b002aec0987d79mr3729264pjl.21.1714001512385; 
 Wed, 24 Apr 2024 16:31:52 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/33] target/s390x: Disassemble EXECUTEd instructions
Date: Wed, 24 Apr 2024 16:31:20 -0700
Message-Id: <20240424233131.988727-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 95d4d6ebc3..bac033c63c 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6525,8 +6525,9 @@ static bool s390x_tr_disas_log(const DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     if (unlikely(dc->ex_value)) {
-        /* ??? Unfortunately target_disas can't use host memory.  */
-        fprintf(logfile, "IN: EXECUTE %016" PRIx64, dc->ex_value);
+        /* The ex_value has been recorded with translator_fake_ld. */
+        fprintf(logfile, "IN: EXECUTE\n");
+        target_disas(logfile, cs, &dc->base);
         return true;
     }
     return false;
-- 
2.34.1


