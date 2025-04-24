Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9840C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krI-0003BM-SX; Wed, 23 Apr 2025 20:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqM-0000zH-CP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kpx-0004gO-4o
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:10 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736a72220edso415134b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455988; x=1746060788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6nKQxahRgvoQ25bOMs68Tp8XymmfstjwW7LOMn9si4=;
 b=Q4LTzMptcTMC8eChhS3SzBqdJ2WnGLOy1Ht7Ipc/1PdXbcnUxzt1f/WBdxUyCEv4WU
 nMF5HsGu+xOh98PPG5VUeNrFB7omAROPtcgVq8dxiBB+iB2PgBimXwyY9jpHopUz9ub0
 fUMtRGuoblAfkAKQKy42ElVJ0ZL/VpaL5njqwEeba1j8qFjbjQWLRLco1Zhs2pgg8051
 Leb2/m9Y6Od78Is/L70ary4ev3gJYXtx4QzgPLUPM/kl4HB7DtaZGt8d3XX0Br/ilUus
 jWWirqGI+b0A/CRcmmPGXJtiOXa60de33zhTkPbYYz0X7LyGTLDy+PlhhHZtlIMGD4G7
 BryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455988; x=1746060788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6nKQxahRgvoQ25bOMs68Tp8XymmfstjwW7LOMn9si4=;
 b=lPaq933OO47Nf3wuNPtA9Cd5pVgbiRiVXDQ56mIIzFCyffaG9AvHklu0tEMKjwS3/4
 g41Mkn0j4GrYLk5Q19DVCulplO0z0j3pi/UnMzburevhYPUG+3uL+74SJxrJ4vM9LMuV
 IAtd2lhyVnyNGku3OmmkHZLOvNyPtgqyzPa8EUfGLZldB5aio3LtuuNrG4cXHG0Xr1lj
 UvaqYDxlzSWWU1KkW3JrhETRYSWgzqgUS3WWirT+8DKjHw2UguW0moLcZgME9gkLsxQA
 Z224+nRFNtsBB8+9ilfYP54BFl2s1V9wld7CdUA5miyQtkX0l2h3yecyzOUkQcRRXHCL
 NT3g==
X-Gm-Message-State: AOJu0Yz6CMO9Dz/bBLUUgsNMteE92mOqya/266nNQz14ZiZo6XkzkuqQ
 Sl2zAkLDxfaVu+hPHU3nGXtLqLsg8IyShSvr2UE6LsSnXQ6KWzd0K73gXZUqsD4ZXItKzAZ7npy
 D
X-Gm-Gg: ASbGncuVE2ItmpIYByE+dZaEQappNFUARGj6rT8vVDZv8gToP8VWqB/dc+arQOnAET7
 BiePyEa50Lyc5XJs9XNYdavGxGY9Sl9lAG3BEGxTbEmtKsr1AdhcJIwDrnhovddgiFOXwyhBjxa
 r3NPnvkXGEYt4ZZqf6mSVMXr+hcHRHEQil5q8GvjPuOHtpIc4KxPHjbQtdA2+N+StwZw+H1p4ne
 e3HNpcx1fq2RPtpr23oaV+PkOeSZPt3LKe/QqcXGfRdsPQ2lzpHeiP8yxpNjPe6AFuU+pCDwIHR
 Ei1xeW7Ri+JXgQP9eZrHahiLqTvUOiZa5SlGG6JtgesCUOyMHBzUvLxeRbUrSrWrFArIREMkRf0
 =
X-Google-Smtp-Source: AGHT+IG8piHOtP9b8wbzNTy13Lc68DZaMD6ViCjpKUY8yOjrMa+jXPAFnlfxjFW31SqdMb8+SlSH0g==
X-Received: by 2002:a05:6a00:843:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-73e2463558cmr955239b3a.14.1745455987824; 
 Wed, 23 Apr 2025 17:53:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 044/148] target/mips: Restrict semihosting tests to system mode
Date: Wed, 23 Apr 2025 17:47:49 -0700
Message-ID: <20250424004934.598783-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

We do not set CONFIG_SEMIHOSTING in
configs/targets/mips*-linux-user.mak.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b207106dd7..47df563e12 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -32,8 +32,10 @@
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
-#include "semihosting/semihost.h"
 #include "fpu_helper.h"
+#ifndef CONFIG_USER_ONLY
+#include "semihosting/semihost.h"
+#endif
 
 const char regnames[32][3] = {
     "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
@@ -415,12 +417,11 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     restore_pamask(env);
     cs->exception_index = EXCP_NONE;
 
+#ifndef CONFIG_USER_ONLY
     if (semihosting_get_argc()) {
         /* UHI interface can be used to obtain argc and argv */
         env->active_tc.gpr[4] = -1;
     }
-
-#ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_mips_reset_vcpu(cpu);
     }
-- 
2.43.0


