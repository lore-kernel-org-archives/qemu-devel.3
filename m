Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A0DC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cph-0002wu-1S; Sun, 28 Apr 2024 18:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpI-0001AY-DI
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:55 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpE-0005kV-ON
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:51 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d858501412so49509581fa.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342606; x=1714947406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKYG6Le200XvNAWzyHkVzuEjCu+nWrYe1aCCZD9ag2M=;
 b=m7Qsuf+08TAattbkToLBo+0zrvdAtTmS2kB4Ec5hR5H4Q6XM40msQuqDJ+UFILXKzI
 ajyvCumOTkNt3yudzmUgF7EzOFiImTXTXMBjBJ/ln4FzX+eqXU0IezbiBQ5LGw6c/Y+B
 sG0Fya7gBS9+XukDP48KMQrQ7ClJu7O/e5HpRFfqcv6GtvvMRzv8L/iqSLTbqwKEUTqh
 Zc1yFXxnhBGThZPbW8oXC6m1j2kOqTUZIJGD0Me22y42lbMdMHjyb5Ru+2SfyhkBAdf1
 pJQRm4BI/9MNbnK7zGe5DErvivMKSovuzdJ6EzO1UOJmLsa68gpGSo8lSgXXRLiBZtSx
 huUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342606; x=1714947406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKYG6Le200XvNAWzyHkVzuEjCu+nWrYe1aCCZD9ag2M=;
 b=tJuk39V7q2rR4IqToY2MvjPZwpCnn3cL7AzcfkOiDfhewUrSarsFPgvQp09NqrBChN
 RM0OgGh5RWHoH8WbmuGy63w/OJuszdB48B2E/gSwlQzIqDvVgjljIAK3YhXdlQ++Tc8q
 6zeTSZX0p0Dm7d7JG3ULyKYQZvYAL0JfC4Oi4D6EHL4bZShPUCeozilvrngerC4S0Y7s
 VPcXcyyDDvIPtx+NhBAtBMnwUwmQAsA9Oam867+dQLe77YH4uMf202/CSm5JhDYxtnHL
 4pKAM/WxJoie670ZEn8aWDvOaJfElTJr+hT7/pMJ0vXG/t/Rc4H2zJrAQmipNtWRyfnU
 xh+w==
X-Gm-Message-State: AOJu0YySt44M8h8ulJm9eoFgBHw8qtMdHcvKUjAqyHLfrV4pEq8f2xQH
 6xE9Pha0UrBJw8WHkXC/VBlFO5FLmfM7blUm9Bx0coQGpwwmy46spTtjWdhjPkTFYrkT9UhlIl8
 c
X-Google-Smtp-Source: AGHT+IEkNjvB5Nm7vP6w7u50IVsA2AWVJaL+sB/9AllHGnhNCa6PMU9bge/04Y+R0noieOmJmq8bhQ==
X-Received: by 2002:a05:651c:550:b0:2df:c0b8:2dd6 with SMTP id
 q16-20020a05651c055000b002dfc0b82dd6mr3365860ljp.21.1714342606395; 
 Sun, 28 Apr 2024 15:16:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a50ee04000000b005727ea3026asm719486eds.6.2024.04.28.15.16.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 21/24] accel/tcg: Remove NULL check in tcg_flush_jmp_cache()
Date: Mon, 29 Apr 2024 00:14:47 +0200
Message-ID: <20240428221450.26460-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

I /think/ this check added in commit 4e4fa6c12d ("accel/tcg:
Complete cpu initialization before registration") is now
unnecessary, but I don't have the WASM reproducer mentioned
in:
https://lore.kernel.org/qemu-devel/20221027141856.w5umjgklawgu7pqv@heavy/
to confirm. Ilya, do you mind testing? If so, we could
squash this with the previous patch.

Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translate-all.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ca1e193633..9b02f21b23 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -652,14 +652,8 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
  */
 void tcg_flush_jmp_cache(CPUState *cpu)
 {
-    CPUJumpCache *jc;
+    CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
 
-    /* During early initialization, the cache may not yet be allocated. */
-    if (unlikely(cpu->accel == NULL)) {
-        return;
-    }
-
-    jc = &cpu->accel->tb_jmp_cache;
     for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
         qatomic_set(&jc->array[i].tb, NULL);
     }
-- 
2.41.0


