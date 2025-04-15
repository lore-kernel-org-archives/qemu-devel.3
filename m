Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93866C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mGa-0001Rn-C0; Tue, 15 Apr 2025 15:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m9I-0005Xd-PR
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:49 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m80-0005xg-0u
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:33 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e8fb83e137so44435666d6.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745961; x=1745350761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l107O4frPXf7npC/NfnXs9QCdXTaqtWm/ZvOPbpalB8=;
 b=W16d7Z/xvv0b+KfTS8di0RmEDaiNt7TkcBZzYGHnTcxqqcl/5HJfPLai0KCjYMniKz
 to6n1oafag8Zeb5dXv1OxDohV7jC/ls3Al/p4rVzdPhVydQQIdWhtaF7jyEtPUkvTi7R
 s3G8oNytgn9stQVVGI0CGAnQf3+tZrpUD+Dxhqb8Y9GjpODCft7adrXneFh2EBfGGnX/
 68oCuoHccKQa9+Br53Df+t2c+8I8Tt+n95NhjA7RkND3aEF1HpcCnk4lw9gXb5n3M3EV
 SMthcSLvl2Q8YcCfKYuR/UKy9cLk61M6HrvazXfQqvng0GIsJzYy643urF2Va1i9TUQe
 tKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745961; x=1745350761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l107O4frPXf7npC/NfnXs9QCdXTaqtWm/ZvOPbpalB8=;
 b=AEm6F/rlMrTBqJ32+h32OWihCXHi5UYm/MCLrvgcpXhPpzyInGJhNotK5F6vHDWz40
 dwNbCLuN+N+dKveSTkjrpWcdoFzcE3LZPvGjjT5t60QgcsQoQ/qy2x4WsbssjLVPtAif
 QVKS/BG7oje6Tqe3w5e33ojpZi9074s0RVtXt5P04M7Jov2/DGUzkWfHqLQeRzH5k8Zg
 TXBfq66B/smbLWuuULWoxASpM+xdJFPwsQ98FFE5eZ4FHgyPasVxVGeguL1nwdjaiACZ
 pdcVuHe8C1hjx1LT1qxXkjlK8CfONPZju05wo7CeSmqEka+TCKqEoNLpgk2T+VWNsviD
 zfxQ==
X-Gm-Message-State: AOJu0YxrHUj7RI4ItI8b7CQGg4YPScfwmo+WG/aB/Vz1PIG8/HD1LYEQ
 AbFJ8/ZFv3ogqcgqp/rWvUoNB/ZAui8otJwoOq5RPklXtJ5i1HxANuJ//f7xkVrby14nx8cx6xi
 W
X-Gm-Gg: ASbGncsaMXZeufl+pfJLpFDO6701Lg6MsIiKYXaSDRNf+8E+8Sk/9KVuhaeJVfDSYtt
 en15hez5hIzg0kqpPL0iw180SGSzzZBjBvAOwZrnytGx4Qspk5boMCf926TfJPFL7C/SkSyX+/c
 VFuaREYcsnW75SWDusNikWpL3D0m7jG+j0/S6W0tSnlV5WgemEEjdwFlMtAAja53e8w7GBQbGNd
 xkI5pQC9Xcgah0ClUctUHYkQfxnkcDuivBpX+lMHsC3NeD245nZf5tjjBE9Fds3vbFACetSvbm+
 KcYpckv1Iq6A/dtG4ES8h46d7vHtEI3J0BlHQijZO2h1lF040L9wKRAlqqNkWGVvUtJ1XhuMu8c
 =
X-Google-Smtp-Source: AGHT+IHCZ4JcO8ahpsH947gPO4QN73L3ygkjZJB/3Il1+7Vg+78Isl9Tt01Vwua1EW3tOjHJAunTlw==
X-Received: by 2002:a17:903:41c3:b0:227:e74a:a057 with SMTP id
 d9443c01a7336-22c31ab0f8emr5536005ad.44.1744745575782; 
 Tue, 15 Apr 2025 12:32:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 119/163] tcg/i386: Honor carry_live in tcg_out_movi
Date: Tue, 15 Apr 2025 12:24:30 -0700
Message-ID: <20250415192515.232910-120-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf29.google.com
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

Do not clobber flags if they're live.  Required in order
to perform register allocation on add/sub carry opcodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 04e31cae12..8e0ccbc722 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1092,7 +1092,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type,
 {
     tcg_target_long diff;
 
-    if (arg == 0) {
+    if (arg == 0 && !s->carry_live) {
         tgen_arithr(s, ARITH_XOR, ret, ret);
         return;
     }
-- 
2.43.0


