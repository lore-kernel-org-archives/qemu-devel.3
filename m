Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81FBCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NFy-0001Mh-4O; Wed, 08 Oct 2025 02:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NFN-0000tN-40
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:02:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NFJ-0000dh-02
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso6196635f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759903310; x=1760508110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Tv8yKkV1/Y6RhtpweElH9Zo9nKkr2eedVoUp7okr8A=;
 b=P7JNx1rdSElkE4rsmcnbv1V/C9J/JE3bNfcbcmwOOFhsiZ5Md/9HNM3xML8kDEfd5Q
 Mila78ahymaGvsyf8SWp0CetqfqB24B8oK6kgi1su2jLCB7kIYQRj5rO4OXOHLhw83I7
 g1qizRNRWrCa0VcB4RCz58EwhY2U2Rtsd7RlLhVLvlrffbyb0PlO3jg5+qrHmwEHu8D2
 83SUpySn6PVdUQ40NdE5HpCzqv45EPn6miGnMaPw/BIfjva/OUCyYmyHTRz9nR6175r2
 nqaps/3shV18TwWUOfJiIUp0OS4JirmjjcJ+t8a4HSVLgQk/LbCUNo4Qht/8aSzTIdDT
 AE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759903310; x=1760508110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Tv8yKkV1/Y6RhtpweElH9Zo9nKkr2eedVoUp7okr8A=;
 b=WeUPbk2U+lyvRxdcF7i6cibbOcgWH/6Zau+UJJQ0b18+3G4IKaXuF0WVHXVDJJpdYH
 QGNNl5RNyqIv6HZnYkVpxaLEZMZVCinhedagxY5BFM53rdz4CyFpLu4U0stZjlHVKywi
 cGrx+9z6WSSA0ng5U5yyqKGcbUMDVlaIqZ0ghcKDR5lmDXZ8rXNaa/s/KeQjpdCsJOy9
 IxV8jj0TxFyVlt9UH0rtHzocfiwmKrP4/XS/HJZDDk7h0PWD0mQlHJElL1uTfriqOI9e
 0OnwFb0LedMkm9MwRRZdFY+e1pCq/OzUwWzoatLiD0mYRNy6ZvcmtaRXDBM9ixXzjbca
 ThIg==
X-Gm-Message-State: AOJu0YzrTEn3ICCVGr3JnAGw5iq1K9I3IPHvFkS2oGVHfAhqcijXOUU+
 JUemsXnIJuHT3I9ZRaxNZO+RWx7YTFbVjEsS9iedjvWZ5ReMhrbzxtzDsZjbGkilPfucXbkuChZ
 F3o7MZ3gLDw==
X-Gm-Gg: ASbGncsmbKw/4JbBxjbVyDaEfl7x2foRJ6CsQJGTvMupxiRdIhN/N8OQR0G+HASHMwI
 23thqbkCFCYKHPEX6UriKILjGZ/JfA+s8Srjp33x7TyPgWGJHU9Q76dDavyDLwdhfQFy5uF7mYA
 0JExKOOZVpSfO7EinqDmltV2iaAAXk012vjM5bdnwRFhtROVWbD/ydrNYVAD/0ok8lQMBcXEsV2
 XFfMmFMosnnI1H4VcGy8R+1IZapOUzWN3Wxe0GHRweffqpbl5+kTzkuw5iw/MJKnmlOppW6fn6s
 uqRO+BG92JobsFjbXskr8582k6qsz+OuR36aqP4+thvQG42Wm2xidJxUHR4o25ACWP/i0Mu7KsE
 cdAGC3eAlbczpeCYkCJFayxwVDetop5Gx8Dda7dOpMsUyQx8g4JkrJfBJxPgsMIc21pTkz3AUwG
 IwxXO9uoQz4Gww33p0SQqj5Yv8XWqyTX4sJxE=
X-Google-Smtp-Source: AGHT+IHeRZl7K78VhOBfBI9cIv+APysV588NvbDoFY9CTV6xdwmSSvJiPYs/vCYgrPQdyrIInFvfOQ==
X-Received: by 2002:a05:6000:200d:b0:400:818:bae9 with SMTP id
 ffacd0b85a97d-4266e7d91femr1010059f8f.32.1759903310442; 
 Tue, 07 Oct 2025 23:01:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm28101225f8f.34.2025.10.07.23.01.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:01:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] target/microblaze: Remove target_ulong use in
 helper_stackprot()
Date: Wed,  8 Oct 2025 08:01:28 +0200
Message-ID: <20251008060129.87579-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008060129.87579-1-philmd@linaro.org>
References: <20251008060129.87579-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Since commit 36a9529e60e ("target/microblaze: Simplify
compute_ldst_addr_type{a,b}"), helper_stackprot() takes
a TCGv_i32 argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/helper.h    | 2 +-
 target/microblaze/op_helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index ef4fad9b91e..01eba592b26 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
 DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index b8365b3b1d2..df93c4229d6 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -365,13 +365,13 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
     return 0;
 }
 
-void helper_stackprot(CPUMBState *env, target_ulong addr)
+void helper_stackprot(CPUMBState *env, uint32_t addr)
 {
     if (addr < env->slr || addr > env->shr) {
         CPUState *cs = env_cpu(env);
 
         qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
-                      TARGET_FMT_lx " %x %x\n",
+                                   "0x%x 0x%x 0x%x\n",
                       addr, env->slr, env->shr);
 
         env->ear = addr;
-- 
2.51.0


