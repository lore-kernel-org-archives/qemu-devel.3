Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663CDE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbo-0007UJ-EZ; Thu, 02 Jan 2025 13:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbE-0006yD-Uo
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb8-000581-WC
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:10 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21670dce0a7so76204735ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841224; x=1736446024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GJ4xuN0abiG39iI8sM5F7gym2I2X5iLUcBaPTLDfKac=;
 b=PDtVGQBObJ/zMcEsR3aRFKcZNvF+NsZqrLy0J335pn8dtgQN0XuVeinmM3khW4zCzF
 sL5R8RG+iJqkhACCDqWvyUtrGBeGvUAc5GBrXp8gP4Xe0lzaJrmUke65MGoLXs5R3g0H
 29uuSbCusysxabn5qjAvsn48FzUq3i8gQgnVx9LZdtKcplE5hT0DYRQ7iQfR1e3I/t1h
 Kd7JzS1MLhNEDX8Lm5i98ByApMYTPQexdssrjyUajRrHUfRQ+FtnPWtj9JXwyOUc9Ltd
 TrMDi0UwlNXUWnuEri/C48T7xNQIoUZ7myWMVFdaVPf27ckuL8ZTFBI+yoJa5Nzy/aXl
 clIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841224; x=1736446024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJ4xuN0abiG39iI8sM5F7gym2I2X5iLUcBaPTLDfKac=;
 b=V4LQiT8XJfC1pl9tg7/0OZLweaF8yo+0IaYTelou1H8QUW2pc7Rrl4Y9c29OgIuIyc
 YgGQDZhmn/FOI3hZ3EWNyaKczlgIYtuBPcJELnX+NEDU97P7WAMUCRPekcLfz1s8PjsX
 N+DdBihZhlB/2Nmy/hmSQHVJgcuUO8eNpBxVuWw5enba2TDBKc/D9Kb6j3PSwBkQqIMs
 bIpSmp/lHyJWGMkCNVXQ2BdTvJegLyidDfuMr0rCRAZFriKcPqHDDZTPhXllgCJWBd3c
 D4ofRTHDmxA4bUsC45rE2YBhRuWXMC9Kq7tUW6kf1HUJEkzEZcq4nEuV6AIFv2PUjlbE
 Hghg==
X-Gm-Message-State: AOJu0Yz78YTmPbnPB+4MsnAR3syo4L1pD57r0o4V5QJ8qGr6IY/APS7G
 C4Gl2vB8U3bH71mpviJjPdcAl6orFTAJGXIAV5gRAcK1RhvWV2SsKTZTr//4vi0IbR9ccSKAX+s
 +
X-Gm-Gg: ASbGncsgwRZBbQLrCdqFDJ52f4HVWCRxqrrP7ehpVXJfmdIArcufhOvCezjGLfRSdw3
 1u7x0Pzr3zCpwzck7coNZv87edlcubYRPW3ry+riLYvrWqfr8IT4UT+bnrKt3InNKQ3a6koDJ0p
 JNDbHMuDANHii1xrBcMdvt3H6rNwNGS8Zq1qFW4cjXaPAT6ZTlaA/0KShK/DpUGTPFCGPQQGBJ7
 P9JCFXTpQSTzQaD+kLdoUweBCaAolaavPLcSfSj96DLTnqucIlA0kgdXukyYQ==
X-Google-Smtp-Source: AGHT+IHAau0xcWbkgVStyzuWDGRkzfcEeqaRR9Rn94nRnsty07FgZoeQkpid9yRlvhgLE1ycBtYcZg==
X-Received: by 2002:a05:6a21:9103:b0:1e0:de01:4407 with SMTP id
 adf61e73a8af0-1e5e08431a6mr73496843637.37.1735841223739; 
 Thu, 02 Jan 2025 10:07:03 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/73] target/tricore: Use tcg_op_supported
Date: Thu,  2 Jan 2025 10:05:50 -0800
Message-ID: <20250102180654.1420056-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Do not reference TCG_TARGET_HAS_* directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 0ef3743f3e..6e6edeadfa 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3980,7 +3980,7 @@ static void decode_bit_andacc(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_and_tl);
         break;
     case OPC2_32_BIT_AND_NOR_T:
-        if (TCG_TARGET_HAS_andc_i32) {
+        if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_andc_tl);
         } else {
@@ -4113,7 +4113,7 @@ static void decode_bit_orand(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_or_tl);
         break;
     case OPC2_32_BIT_OR_NOR_T:
-        if (TCG_TARGET_HAS_orc_i32) {
+        if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_orc_tl);
         } else {
-- 
2.43.0


