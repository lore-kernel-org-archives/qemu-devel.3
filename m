Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EA3E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjX-00065G-NZ; Fri, 20 Dec 2024 11:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjG-0005MC-4E
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:55 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjD-0008Jq-Nj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:53 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1473407f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711590; x=1735316390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq4GFNy0GqV3TnhfGRyyK+hCfXYhz7stFIIfE9+GECI=;
 b=zxUGSm/xxAVjxXrAZ9JVi63zis6v4LCUl+u0u2w7r5PpRmEZSivvmw0uGobd0Jssqw
 jcthRXfd6iNzqi7LlcX2Zyut8RGmnOhYgJDRuorNJ4BmVMvynflinbaofuLsTLv/Kzhm
 1D7e0VROPGch0UVOywXp15vMNrpqJhS187Ifm+UxaAUb21fniyqMutz4DNjwONqOvAbk
 YPyOP+bE732b+wSsGDCUKaZcw5LhdC4HN0Z5TERY2jie5mX2cHQwV8/wIinxZLgNInBw
 ENlT9qZW7r0mGaF2N//I5WBIJs3Hn+DLIMgzgWEkk60hBJoeQFDtD751JBlWkuTjKzm7
 Nlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711590; x=1735316390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yq4GFNy0GqV3TnhfGRyyK+hCfXYhz7stFIIfE9+GECI=;
 b=mFuVcOyzwc4FE113nwhgcLTsNbf3mQsllntz3dOUPljE8MK8qQMc1DZe/B77tly3OK
 9WS1erAb1NePdU/RBXvh+iLKGMudsyyPpFwMHr8Vfk5ow/h3jYT0nmL+GPQXlcdYFv+I
 osh5MOaWqOe3XrqTJmfxtqfbMgNvhG7oGvDGzjDQ9x+n68m52nH92xt3Q0Si7pjmPKDA
 5EPjTJh+3vEcO1lxqG1Xs96ZBkdOQGAae7IPeBU+UXQrb86Tx7xzALIGKR8Zw1Eo5VmZ
 e5Vi4Aj5IaM2LiFUC9VoZEUhqA4UcXPk5HvaLSRFf3uPZ9TJ5om2vuBMXYVwMW0jvq3f
 vY5w==
X-Gm-Message-State: AOJu0YzMravulAVMiReOGPiXe3mnpE0IWViqY3oBTVVzO64ejEarLcmX
 BHqUiA52hYa+8cQCAkyAFVgQKFmaS8UOecxZlJYQxpaNMgtcqOPr73Ri8g9qVz3bglyyvw70uov
 A
X-Gm-Gg: ASbGncvDW8ITvWDWp8jzIn4uQeKKyYs3O80pJmOqq1u2uM1wIil/zWf6zsCVJ1aAdih
 pGLwLHQfZykbiyvwgjYpL6zHaOCrIr1MQRaInLiRBW8B+5Jdd6QVTls1pFy5Fqqf/5xlNACpi9M
 mK1ABeG8lb4EzhTXz1RQ7KOV9v1Ds99T3Dk3NcXqvyxDzNc6sGgyn2TMZSWrsnvkzPLbtI2opdN
 TOyDvm+xk0H8WQS58ofUrPELO+SAuAuZTVEfZgozdmOEx8YqRNxRvG4k7l0ypJSb04GLC0U5YI=
X-Google-Smtp-Source: AGHT+IFV1AmvNc6MpF8zbwtRZDHDePOK2hthbTiF2u39xaukzZqsGQZdDVv0vIWcUO08qXKnxRcZdg==
X-Received: by 2002:a5d:6da1:0:b0:386:3afc:14a7 with SMTP id
 ffacd0b85a97d-38a1a1fdae4mr7189797f8f.7.1734711589972; 
 Fri, 20 Dec 2024 08:19:49 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0145csm83868365e9.15.2024.12.20.08.19.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 52/59] target/xtensa: Remove tswap() calls in semihosting
 simcall() helper
Date: Fri, 20 Dec 2024 17:15:43 +0100
Message-ID: <20241220161551.89317-53-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
different endianness can run concurrently, replace the pair
of cpu_memory_rw_debug() + tswap() calls by put/get_user_u32()
ones, which still do the same under the hood, but simplify the
code maintenance (having less sites to do endianness code
conversion).

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <6e1e69d8-a9f3-4a30-83c8-84c5647578d5@linaro.org>
---
 target/xtensa/xtensa-semi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index fa21b7e11fc..2ded8e5634e 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -30,6 +30,7 @@
 #include "chardev/char-fe.h"
 #include "exec/helper-proto.h"
 #include "semihosting/semihost.h"
+#include "semihosting/uaccess.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
@@ -323,15 +324,12 @@ void HELPER(simcall)(CPUXtensaState *env)
             uint32_t fd = regs[3];
             uint32_t rq = regs[4];
             uint32_t target_tv = regs[5];
-            uint32_t target_tvv[2];
 
             struct timeval tv = {0};
 
             if (target_tv) {
-                cpu_memory_rw_debug(cs, target_tv,
-                        (uint8_t *)target_tvv, sizeof(target_tvv), 0);
-                tv.tv_sec = (int32_t)tswap32(target_tvv[0]);
-                tv.tv_usec = (int32_t)tswap32(target_tvv[1]);
+                get_user_u32(tv.tv_sec, target_tv);
+                get_user_u32(tv.tv_sec, target_tv + 4);
             }
             if (fd < 3 && sim_console) {
                 if ((fd == 1 || fd == 2) && rq == SELECT_ONE_WRITE) {
@@ -387,11 +385,8 @@ void HELPER(simcall)(CPUXtensaState *env)
                 const char *str = semihosting_get_arg(i);
                 int str_size = strlen(str) + 1;
 
-                argptr = tswap32(regs[3] + str_offset);
-
-                cpu_memory_rw_debug(cs,
-                                    regs[3] + i * sizeof(uint32_t),
-                                    (uint8_t *)&argptr, sizeof(argptr), 1);
+                put_user_u32(regs[3] + str_offset,
+                             regs[3] + i * sizeof(uint32_t));
                 cpu_memory_rw_debug(cs,
                                     regs[3] + str_offset,
                                     (uint8_t *)str, str_size, 1);
-- 
2.47.1


