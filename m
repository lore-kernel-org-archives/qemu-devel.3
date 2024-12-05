Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6A2E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLDO-0007JT-V8; Thu, 05 Dec 2024 18:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJLDI-0007J6-P9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:24:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJLDH-0002Lg-7r
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:24:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434aabd688fso10144115e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 15:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733441089; x=1734045889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWYSs/XaajbkBmJgNxXc7L7hi1mF2tY7+Tqqie/8xoU=;
 b=OlnkeQr+xi4PTKmayEKbWoHM1xkvTqW1PhPtiS/NAZuXCbDbcaHYuPW4+vHVmukwCz
 JnXcSmeu6MjTn8T2DCRs2cQsmJZibtxXqSebcJax5YNmWqvtUCQGyH1t+sjde9Ycakbe
 lP2AWkoC4i0U/0a3Avaza/g6UgLKY0w/TiWUQP4F55ObD2uDxahKJLffmKhmQMFVOCz5
 V4r2kPtsognMv1D0orYllZSN9dTol1VwgiBknN06uvQ6f6zpfKhV4L0KbJJAVHx2JNHr
 +C0sG0RDCsd9KToO10Og0SqJLNLbmsWhbFMSlsH25qyr/J0uQV+nIGtn+wIMBklFyGaD
 ZpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733441089; x=1734045889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWYSs/XaajbkBmJgNxXc7L7hi1mF2tY7+Tqqie/8xoU=;
 b=Rmw6pb80+HDffyCCTUA46ovOCfS2KADOF12Dl8XeJMjLcGU7JTQP4hOByuz5wXt81f
 AbALOGQcI04GdCKfFpPOlLPl7ZYpfezrtw46Wr8YS/vMA8un1oCwNWrqH2JHYxDTD51O
 HcKDs/XqkiOjH+gGkQyJCowWP4oN6J+eB+MjzKGh0Lomx2Qqss+1s2NzbaL1LEA7usVW
 nsj7WRkkkCBAqmp64Xb3a0/UI767IBA1FLgobWrLrpBv4LJITqzwB/9T32+qndQHZJMU
 /O630fZ/tsnbkrnbDd8uyK+aBik4IGJGsHhJrEroRT6AlTyBgxBFMfVm0tHXrrG0mIY4
 kMPw==
X-Gm-Message-State: AOJu0YyxKUFwP/wytjm5U51qXpz85lQVsDiSjRhrJ5YzI8Y+KyNouZTF
 XhNzPzrPoBWEcKhwUU4VF81/ibUtvpvxZUuMC+YY7ESO8j215iZ0Tz2R0MGFmHpkKMXKrelMtJ+
 R
X-Gm-Gg: ASbGncv/l0Q9Zm4r+JCIgIHSvcENz+c+Xwy+Ppxgx/o6G8lDcoG3RFrQUasjo5qOaBe
 5CucpQjNsbUAq382WgyhRDQDBOoVJOkcrNPtl5Ixk/NKcjLYAAcEf/T68/VsBw9IFp7x0tcgl0a
 scDy2CB4lYzZ9iNY0R/p4+R+ObdnBuSCPAyc66kAnZzfHOKx779IkRn3soHaPt7ULbU72uVhSf7
 5Uh6Qora9mtEWoTpvIMZd/J7OGH9mPAbfKL8GWf8EwgIx2v+Pc1r/+l8lASTvbPjYe1uN5UqY3j
 B0tDt8YFVyfRWY+97GhbHBUz
X-Google-Smtp-Source: AGHT+IHmmZkqACBXjmZnxY5i4r6RiUqo7dXqrZNyzLWEtm+ttvy9BgMsAkBnCauLYfbsv7VuTI7sFg==
X-Received: by 2002:a05:600c:a46:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-434ddeb5573mr8302945e9.12.1733441089513; 
 Thu, 05 Dec 2024 15:24:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861fd46cb2sm3118604f8f.62.2024.12.05.15.24.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Dec 2024 15:24:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/xtensa: Remove tswap() calls in semihosting
 simcall() helper
Date: Fri,  6 Dec 2024 00:24:37 +0100
Message-ID: <20241205232437.85235-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205232437.85235-1-philmd@linaro.org>
References: <20241205232437.85235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

In preparation of heterogeneous emulation where cores with
different endianness can run concurrently, we need to remove
the tswap() calls -- which use a fixed per-binary endianness.

Get the endianness of the CPU accessed using the libisa
xtensa_isa_is_big_endian() call and replace the tswap() calls
by bswap() ones when necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/xtensa-semi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index fa21b7e11fc..21d23e39de5 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -328,10 +328,17 @@ void HELPER(simcall)(CPUXtensaState *env)
             struct timeval tv = {0};
 
             if (target_tv) {
+                bool cpu_big_endian = xtensa_isa_is_big_endian(env->config->isa);
+                bool swap_needed = HOST_BIG_ENDIAN != cpu_big_endian;
+
                 cpu_memory_rw_debug(cs, target_tv,
                         (uint8_t *)target_tvv, sizeof(target_tvv), 0);
-                tv.tv_sec = (int32_t)tswap32(target_tvv[0]);
-                tv.tv_usec = (int32_t)tswap32(target_tvv[1]);
+                if (swap_needed) {
+                    bswap32s(&target_tvv[0]);
+                    bswap32s(&target_tvv[1]);
+                }
+                tv.tv_sec = (int32_t)target_tvv[0];
+                tv.tv_usec = (int32_t)target_tvv[1];
             }
             if (fd < 3 && sim_console) {
                 if ((fd == 1 || fd == 2) && rq == SELECT_ONE_WRITE) {
@@ -381,6 +388,8 @@ void HELPER(simcall)(CPUXtensaState *env)
             int argc = semihosting_get_argc();
             int str_offset = (argc + 1) * sizeof(uint32_t);
             int i;
+            bool cpu_big_endian = xtensa_isa_is_big_endian(env->config->isa);
+            bool swap_needed = HOST_BIG_ENDIAN != cpu_big_endian;
             uint32_t argptr;
 
             for (i = 0; i < argc; ++i) {
@@ -388,6 +397,9 @@ void HELPER(simcall)(CPUXtensaState *env)
                 int str_size = strlen(str) + 1;
 
                 argptr = tswap32(regs[3] + str_offset);
+                if (swap_needed) {
+                    bswap32s(&argptr);
+                }
 
                 cpu_memory_rw_debug(cs,
                                     regs[3] + i * sizeof(uint32_t),
-- 
2.45.2


