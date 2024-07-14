Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B04FC3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSwhR-0005vc-NK; Sun, 14 Jul 2024 06:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSwhP-0005pS-Rq
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 06:43:23 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSwhO-0001Xz-BX
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 06:43:23 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d94293f12fso1991096b6e.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720953800; x=1721558600;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GUkIzlFT6MkRaKD+PIAfhCidzOldBk8nsObQwuTuyT0=;
 b=krMJ0Fw7TN0I2VnMXdU/QXwgR5BcgyHHSzzX5NCiBOGgOgYqGORAI+qliRsRrEnigQ
 2kLFepnt16pgy+Tor20dZwl6L69kdlCbSHBJyrKvZ28xeJo8SUTP7YtL6rE0uBPhDqWh
 gijaMmoqqgIqhIhdUxvcUuUX++RXIKd5rxzbdUjP4GmJ3ruetc+kKlzjqsA/f36ozKyp
 g/Hx6NDQm2wiTuK/jsXViC+eTSufAGvaEXTbBIN9gnCX920x20A9BGmLtBjXBJfsgsxg
 W1fDDc074VRhq404jylN3P3UxQhy4sI6Qja+EDjl2fpPU1rM2OdURao7w0IQDqxyi2D6
 HeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720953800; x=1721558600;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUkIzlFT6MkRaKD+PIAfhCidzOldBk8nsObQwuTuyT0=;
 b=u8XYhjeAVWDbzksb603joOXC7RqaYsoNFr1eivV4nsPKgbz+bSo55lLb4utBj09+RI
 DdGRZcCwmp6NiNTCy644D0225cWNow4/bUlsRfp6o0uDqNXodWdRuCZjIDCYDsae79OZ
 UkqjL6FLlLSq1TbeuK+jzCXVEaSPvgqu0/3TWTjOXaI/HlIwhtIiz5didmQmPgTiTeTT
 SEUQ0e0ob7Qmxj8dztnpNTQqjk2pFS8XQ6ew6VqLjsEedkcxk7WRoSqJg9MouGTpIso5
 qC5Cj1Igy0l1ds7V8SXya3SwTEFUrXEILoBuBPfc13qb6C3kkzfFDoqfwdx2LeLkLfv5
 mcIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0+Hl++f2WmJVKDB+cM6WhAQTSRN7KtKE4UsVoO9w8FtyXz1fYMmVl3aKpTnyeC/b6atpElr+YuDaJ/PXgmVe3FSMgEbo=
X-Gm-Message-State: AOJu0YwoRVJQr3hUKAKYWWB4GzxOvEfcf2bgQR+iKcxSs3MCvAJDDqM8
 CRxhMibLL28NjVqwqGI4b5w0HU8bxM/QAAcVPE+oWjGEOcV+255yTej3AymoLUU=
X-Google-Smtp-Source: AGHT+IHoY5F752+FozDDYym0USgfw2CSYAPayVOqcR1jVxR8OSSr70v+8YpCyHiILAqxUh/Vg4V+5A==
X-Received: by 2002:a05:6808:238a:b0:3d9:2e2e:1ace with SMTP id
 5614622812f47-3d93c075161mr19558464b6e.42.1720953800516; 
 Sun, 14 Jul 2024 03:43:20 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc3ca12sm22446795ad.219.2024.07.14.03.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 03:43:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 19:43:12 +0900
Subject: [PATCH] target/arm: Free GDB command data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-arm-v1-1-c045bad45e48@daynix.com>
X-B4-Tracking: v=1; b=H4sIAL+rk2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MT3cSiXF0DE1MzM9M0w2Sj1DQloMqCotS0zAqwKdGxtbUAOTGQj1U
 AAAA=
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/gdbstub.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index c3a9b5eb1ed2..03f77362efc1 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -477,11 +477,11 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_feature(CPUState *cs,
 
 void arm_cpu_register_gdb_commands(ARMCPU *cpu)
 {
-    GArray *query_table =
+    g_autoptr(GArray) query_table =
         g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
-    GArray *set_table =
+    g_autoptr(GArray) set_table =
         g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
-    GString *qsupported_features = g_string_new(NULL);
+    g_autoptr(GString) qsupported_features = g_string_new(NULL);
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
     #ifdef TARGET_AARCH64
@@ -495,6 +495,7 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
         gdb_extend_query_table(&g_array_index(query_table,
                                               GdbCmdParseEntry, 0),
                                               query_table->len);
+        g_array_free(g_steal_pointer(&query_table), FALSE);
     }
 
     /* Set arch-specific handlers for 'Q' commands. */
@@ -502,11 +503,13 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
         gdb_extend_set_table(&g_array_index(set_table,
                              GdbCmdParseEntry, 0),
                              set_table->len);
+        g_array_free(g_steal_pointer(&set_table), FALSE);
     }
 
     /* Set arch-specific qSupported feature. */
     if (qsupported_features->len) {
         gdb_extend_qsupported_features(qsupported_features->str);
+        g_string_free(g_steal_pointer(&qsupported_features), FALSE);
     }
 }
 

---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240714-arm-045665f1c2ef

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


