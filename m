Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55509C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUahz-0001LV-7b; Mon, 29 Jan 2024 18:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUae6-0006sG-Ku
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:35 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUae5-0008WF-27
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:30 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bd5c4cffefso3816524b6e.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569348; x=1707174148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfMhTQxwxgwjYRWhH0P+ZcfoxncjyISGzQ2K+4rTjEw=;
 b=kfRdOoz+g2RIk+p6AuS/Cwv2hzBb50eRc64tuheJ0uSUFIaHl/IPFwO7PgbnifufvJ
 6Ks7N3rR9wptrNObZG7DGWOymX+AUsc9D7RGo/lXQ9La9FL7GFQU/aXYG1/5/d7Zt/cY
 /47cR0vMK1nzSujpDs4QWL/4fZjIIyeUCV3hNpY/tT1BWiisSb0+1VYwfQnTMyYvZLRR
 7f3NuzdOtv7A92i2z53pIkFUqr/x0uMhyWqjhbWG3DKUamXI1rIQTl+Et695fkziULx0
 xRnP/I9+IJyBzJ7CN+uc3B0jXChS7TGQMC+4TQATg2okd2ezH7sbL1QiWzoCeHgZ71fR
 BX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569348; x=1707174148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfMhTQxwxgwjYRWhH0P+ZcfoxncjyISGzQ2K+4rTjEw=;
 b=dtSWOOgJ0KGJ2tu+cQhPlu+bbns1xyzYVU5FbKnPvNwfxxdRWqG/ab2NCDMa1s43Az
 a3LK2utjMLLobhjvOdV+4Oh4ClHXjULaEKIEtd91C02vFfDDGDxtpGnlmKCVo8NaUE7a
 b+h35b6qPhzNfZj1AnzO7bdEQreDanISogGREsIa2I30p+JCpgH6E/bT5rY2fxqLEuyG
 1vQFJFBpE77TJQOdoUXQS8s3DozpXXMjvEcr8DZA9ktaVVOT4CKTn4baA7Y4i6h6u5Sw
 SKB5E+R7AgcuZ1DxTrp3K7FIHCoomaTaJi3l6hifMuZIEa/Cl20pSZPKRoEX+jIpBfy5
 DxtA==
X-Gm-Message-State: AOJu0YxTsL9vA4r0WHIbu+QxZgVq+8rzduHymEgoxhuinYnJhIvZ2JMV
 mTHdb/av7Fnvp1QaQkB05tu9G9J6l6RtHphjFqhy3tfFAEWHa/FAHuDwWXf5ewS1rJYoauX5pN3
 9FqY=
X-Google-Smtp-Source: AGHT+IHrXV+SHsLevEC6WcoFT/qLsMXpYjKdUrQVtcclDvbpYFKjaAqncxYGUNdhbtbLLHrRPJIJZw==
X-Received: by 2002:a05:6358:524b:b0:176:91b9:831 with SMTP id
 c11-20020a056358524b00b0017691b90831mr4710648rwa.63.1706569347855; 
 Mon, 29 Jan 2024 15:02:27 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 23/31] accel/tcg: Un-inline icount_exit_request() for clarity
Date: Tue, 30 Jan 2024 09:01:13 +1000
Message-Id: <20240129230121.8091-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Convert packed logic to dumb icount_exit_request() helper.
No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240124101639.30056-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 950dad63cb..f2535a2991 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -777,6 +777,17 @@ static inline bool need_replay_interrupt(int interrupt_request)
 }
 #endif /* !CONFIG_USER_ONLY */
 
+static inline bool icount_exit_request(CPUState *cpu)
+{
+    if (!icount_enabled()) {
+        return false;
+    }
+    if (cpu->cflags_next_tb != -1 && !(cpu->cflags_next_tb & CF_USE_ICOUNT)) {
+        return false;
+    }
+    return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
+}
+
 static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
@@ -882,10 +893,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     }
 
     /* Finally, check if we need to exit to the main loop.  */
-    if (unlikely(qatomic_read(&cpu->exit_request))
-        || (icount_enabled()
-            && (cpu->cflags_next_tb == -1 || cpu->cflags_next_tb & CF_USE_ICOUNT)
-            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0)) {
+    if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
         qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
-- 
2.34.1


