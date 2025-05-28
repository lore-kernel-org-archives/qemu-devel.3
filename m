Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C59DC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBvn-0007wi-36; Wed, 28 May 2025 04:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBve-0007uv-RG
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvd-0005EQ-6w
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso32660765e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420064; x=1749024864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWNX8xy0mGbcSTM3tGtx8Ng/18Xa59vYBmUiZhUdSFI=;
 b=ZJFqeeBtj7X8G9jasAn7ZmZnU+u7OrpPgIR1Y5d8cgbKyOa7CfSNkdMVEohHepVaqf
 Y2Dl0wh1f6gwiWZ6ax1nOrqdCbbxMQDEAzm/CBXc3Rl4RVg8c2gC6FSOUKE79NE+u7jy
 HqYGILnGLYe6D/bs4tH6EcI4pL6Oz2kPOJwHsfqRgcPEbO3LkKk4K6L9TKBI8N2YyWg4
 a+0xOTB8SJrtY4h+nWLv+V4muDCpuqsMOCUK5+DbtXs2CvgqvgOYZabFwN4MJ3UG3s1s
 NhLjz41aimmzxPQuJ98zbHP8apVQti3BKF1lWVkrCloGkvTpKVa+7zKCgLxcUyqxu89E
 eQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420064; x=1749024864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWNX8xy0mGbcSTM3tGtx8Ng/18Xa59vYBmUiZhUdSFI=;
 b=MUzTXM19lZPThcL7hVQeMvodm3oYU4gEti5PxSaD6+PdIuJKbvKC+BFKo3SB9XzdCB
 UBLQjoiX8dIRyBENjV0W9AZRJuVLlfkvEe1x/BUvxZNvIBJgs4wQKUsNCU5ntdSnUcOv
 b9rl+xFcu1X+/2TVr67Lz9QP3zqcn/WK476l1XIdKUsxQ6pEAZ1HKm3TY6IYXSMLkMEZ
 L6gDWPdEcnrafK33tKDf63LxLV5GOLxFEv10aVBX+xK55Od0mXWvpTVD2yRnPFLBNo3a
 /OKTXny2g8rOYpZnKZfkPtq6vN3SRbauq80HqgvGjc8Zql7MmpszsdjB8aX/TuVjQZ3/
 hdbw==
X-Gm-Message-State: AOJu0Yxy3aGO6ConKl1EDh1QtLaCXu5E9PuTvcMfo7PrDCzCHkUJrEfm
 PvdtttGJqVTP/o+z1RNr4Z80/egEFZU2WV61pV/RSViz1avGJWpgdQV4sbuoh2fxCRvwv+6dCgK
 VSzrZKeTWTw==
X-Gm-Gg: ASbGncs/f5LNBIZnhapkD1WmIzbc3pW14IIX6LvNm2g4L8tDrT+h+w61xvkCj/FWbLc
 453CVtqKnYVwEOlohu5dMX7/XIWTEavOx/A48gAwKuvVe0Iaysx7oXYNL8VSwRyP+ifO59IO9q3
 8Q6w09it4eysYFkBcCSEgesM/BR17dZZbwex+rzIeBlXJMj35wSdFzKz9hWcMYPcjQJzTxkHM2S
 wUr6OCodjaulUzu8oyWOPLPm8o8Pc7s/jO/gz75uyWkBDZSQwry5GcTyBDYC1+o71H4YR1v5Ax8
 KPyqyHNrEvNGGXEsQvS88KwmoDbZySOGoYjOMbCyBOjGvr6FXSL/ziuS
X-Google-Smtp-Source: AGHT+IEYUJjmseZUH09ielv3gUheIQhkTe4tmKOVetLDmpkMWvW98MSwQ6Zu0iPyGRtG8psO9/wagw==
X-Received: by 2002:a05:600c:34cb:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-450725539f8mr13285255e9.10.1748420063637; 
 Wed, 28 May 2025 01:14:23 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 08/28] target/microblaze: Use uint64_t for CPUMBState.ear
Date: Wed, 28 May 2025 09:13:50 +0100
Message-ID: <20250528081410.157251-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 2 +-
 target/microblaze/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 6ad8643f2e..3ce28b302f 100644
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
index 3d9756391e..b1fc9e5624 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1857,7 +1857,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 
     qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
-                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
+                 "ear=0x%" PRIx64 " slr=0x%x shr=0x%x\n",
                  env->esr, env->fsr, env->btr, env->edr,
                  env->ear, env->slr, env->shr);
 
-- 
2.43.0


