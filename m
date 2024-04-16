Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880FEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa5O-0008Em-4f; Tue, 16 Apr 2024 00:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5L-00085B-J6
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:19 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5J-0007AM-Qe
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:19 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e4f341330fso32496925ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240376; x=1713845176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZaZlRSWcRP8TIIFtrlkzqwhRaKDjzyacbuo5KubVSI=;
 b=TS9yRPrupgnRGUxLgkS1MrwrA1KW3h7M937fpIRazfr5rJq/03hJKWyKs/7NKqB+OW
 XMAzqduRZWuO1BOfBvG3eGy6pZIU+4N7rRG/MRQmW6/WOvroTcGWfJRavSc0ZZD39bKa
 JQ7kXEdAB8nzTc618g4aNo42qYecF75DzPwvGZquzWXQ5Tfb3++sK5dU4VqPXV+vqDgi
 GpEEb+mNDs796AafXKkb7Zs3GjPvAn9iIFpxEdNtEc0HUUPtrQuhvmewVXOQA6nwDerG
 PB9KGdxA7QOnPDJgNKUaQ/cqjwDLCea5+ez7sefKNL2S31H7FmVEBTTewg8URf9ldnqO
 xJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240376; x=1713845176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZaZlRSWcRP8TIIFtrlkzqwhRaKDjzyacbuo5KubVSI=;
 b=LcDuJUXIXlDGCtsCBEc2sYq81DN2DEm0FaWD2cz3hVSQa8QYZpXcLl8hFzIJKn+bqv
 utZ6zCvCMPGmhewNLsRqkql2zv0UtqIr2+EyudHKkEKCP21hV41lOK7cDFpYVxJCH053
 ANfJorONozA1tR9+sHTOXqUuvvZ3jlvSsQKHvmSSJXRCLK/Jv14oF4lO0ZlBUgYovfBD
 KJ8EoWhrqavLLrbT+PrrAWc//jcDpxTy+pfAoaVTPpfZP84djVYkCnJEjOOQwXqTPfKA
 39J6tTsXngl025Mke+8vR0jM2+HMIHTjatQFxoSGM7Mel9BiSXsHB8y3of3MouM636ER
 pnJw==
X-Gm-Message-State: AOJu0Yze3dHi1Ra1vrgSpiMSO4GUvPIisApym7tGoL0TqLPm+sUZYwYm
 njzWx3y/xu8ElG7wXnzzDLIRqISHlooQXhxSiOvhH+F38EFOK9s+yllqaxDIgr1CZmIIDQ/N3ki
 c
X-Google-Smtp-Source: AGHT+IHxo/yoMjlAGOh3rZc9RZCBljavtyEkWgil3E2pGuVvktyPi8ylV4fViLbmZ+ap6M6c7gDitQ==
X-Received: by 2002:a17:902:eacd:b0:1e2:23b9:eb24 with SMTP id
 p13-20020a170902eacd00b001e223b9eb24mr9864530pld.33.1713240376408; 
 Mon, 15 Apr 2024 21:06:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170902f68100b001e3e244e5c0sm8694439plg.78.2024.04.15.21.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 6/7] target/i386: Introduce cpu_compute_eflags_ccop
Date: Mon, 15 Apr 2024 21:06:08 -0700
Message-Id: <20240416040609.1313605-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org>
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

This is a generalization of cpu_compute_eflags, with a dynamic
value of cc_op, and is thus tcg specific.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h           |  2 ++
 target/i386/tcg/cc_helper.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6b05738079..285f26d99d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2379,6 +2379,8 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
 
 uint32_t cpu_cc_compute_all(CPUX86State *env1);
 
+uint32_t cpu_compute_eflags_ccop(CPUX86State *env, CCOp op);
+
 static inline uint32_t cpu_compute_eflags(CPUX86State *env)
 {
     uint32_t eflags = env->eflags;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index f76e9cb8cf..8203682ca8 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -225,6 +225,16 @@ uint32_t cpu_cc_compute_all(CPUX86State *env)
     return helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, CC_OP);
 }
 
+uint32_t cpu_compute_eflags_ccop(CPUX86State *env, CCOp op)
+{
+    uint32_t eflags;
+
+    eflags = helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, op);
+    eflags |= env->df & DF_MASK;
+    eflags |= env->eflags & ~(VM_MASK | RF_MASK);
+    return eflags;
+}
+
 target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
                                  target_ulong src2, int op)
 {
-- 
2.34.1


