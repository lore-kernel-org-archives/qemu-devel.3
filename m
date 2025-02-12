Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66155C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKo3-0006ni-Ak; Wed, 12 Feb 2025 17:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnz-0006lh-Qn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:03 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnx-0004SB-Km
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:03 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fa5af6d743so406044a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397720; x=1740002520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnLIG9+65kO8N7uf5cYzFU4nAct/OHD8P+r60Pdyiuw=;
 b=ubnkjk1pjRU/wAPUMs+b7uc/y8b7NR7VkXZ+7v5hirqGEJd4j1Z7P6qjc/ZtIJfPD8
 r8muhwZ5SaSiyCYbMKbhufYrL4OHFti5CoVEB+6sJm8pDytgt3nzyQRLWez/JagPuxFy
 WkNfbOVkQvDW99FrcxQuM/JC4BsOvWY23qElskjaeVMQiHYJjnkXoLra+LgIs9ZDlH2o
 dNK6k03mpXB9plNprt34G2E0L8+CGTeXLBObbvJrj43JKHCnjm/z7WV7zndcUgY24z7m
 OUW84W+4g+yq0nAwICPqkJ2FLH/JXXZaA9fF+Bd2G5lgZt0c/g43aadUhxKcOebNpZWh
 pvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397720; x=1740002520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnLIG9+65kO8N7uf5cYzFU4nAct/OHD8P+r60Pdyiuw=;
 b=UoBRa7JuQQ24I2BRBUaaFxpHYkHRIWXDPd5Tys9htB4exx6Jny2QEUW2BS7FW0Givq
 e7yiWKDDltAZohwbKUd+GmrAJHDmMc5mLrQ5bI6SIGF6YZT0ExgNuV2dYPIcuDtTsAMQ
 8XgUVVPflHIMjjrADlk77iFOXfN1gQX/xjjXEQhjGOPrKpXmhjB6+P16gyxSJIic6x62
 EIQ5LR4PuVJl/jXpFiiPklEg91J8tHy5BrcVweLGA3IuDC59VDUvGFmxT08P11muYm4d
 gfQQEXu1aQZrqVBuY68iwVWF5wyQkdsC6q1HqN9+lu99p7G6DVVy2pNTGIrkdRmIpHxU
 X3qQ==
X-Gm-Message-State: AOJu0YzQZUnAEeDW1U+MZDLB5i4DozJGXH+GY0sas9o8jSw7AU+Tjr0M
 DKosDkaH5nqyA/8tHcemFyXCSbNlwYkmah1vZGabzgFzL0+K8Ms71MQq/nU8LvjPWN2RBZ3dKR3
 Y
X-Gm-Gg: ASbGncveZldZyoQsXQyFgYo2nkbFZ+bzuYrrgZdgyFSMchqmEb9hRa3ndSBR/qXVoT1
 R6DR1AYoWrUdM9UlOkWluBu06hmQ1bKNKmQCAGXz0VEV2sftXCxcmXgSq8UdITz9zrMwLaCY5In
 bi+ykwsfvldaoDGSvhp3ZFObzIv2t13mIpPdB6d4glj2oFkxkEo1+V9PmHHGkWNYCq7f12wS1EA
 hr7oR0gM9KhbJ+nl9UKLDE3plwx5bwEdwXP/qlgamJu/OqVvVJzuzdZSlBu6s42sgqOCPvC+lTG
 +RcQynTkGkuUsRx7z/uexuoB/NCtBKE9D3S3zXNOMb5ugqo=
X-Google-Smtp-Source: AGHT+IGkQLqgn56W3ecwUB2tz/U3IIBM4YX+NBWuUWMbZpb/VDZorjwfutWAEAxvSYiUpKDOnOPOxw==
X-Received: by 2002:a17:90b:4f85:b0:2f8:4a3f:dd2d with SMTP id
 98e67ed59e1d1-2fc0e6ad581mr1208234a91.15.1739397720003; 
 Wed, 12 Feb 2025 14:02:00 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:01:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 4/9] target/microblaze: Use uint64_t for CPUMBState.ear
Date: Wed, 12 Feb 2025 14:01:50 -0800
Message-ID: <20250212220155.1147144-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Use an explicit 64-bit type for EAR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 2 +-
 target/microblaze/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 45f7f49809..01571d4f86 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -248,7 +248,7 @@ struct CPUArchState {
     uint32_t pc;
     uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
     uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
-    target_ulong ear;
+    uint64_t ear;
     uint32_t esr;
     uint32_t fsr;
     uint32_t btr;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index d5c5e650e0..549013d25e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1842,7 +1842,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 
     qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
-                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
+                 "ear=0x%" PRIx64 " slr=0x%x shr=0x%x\n",
                  env->esr, env->fsr, env->btr, env->edr,
                  env->ear, env->slr, env->shr);
 
-- 
2.43.0


