Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2B2C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P1U-0005xc-1t; Thu, 17 Apr 2025 09:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0j-0005dL-Ni
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0h-0007wd-7s
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso3611295e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895429; x=1745500229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCjGM8gwQ/EmIYgFRxP35ULYOynfX81xOLUnM2jN7fw=;
 b=s573tsHamaVdsCET+qrHl9ao9vGH3uEMRD/Nlp1mdlnbjr8dPl5O2vj5+oLty6oCCx
 YLHYM1flD0HhaDNmVTKYt7uuxCSd5MUqzR3f6XpLvM5RP64IhvHkmctSdm+1l28W2A2Q
 +v6Y8GMbkXW2aX0bwYoh24dPz9Ix6XVJ/y2FKQ1vqgQ+7C5C+o+qFXS0Ah20TV8mUW5K
 apCQYFgzTOEWBkd81JxG+5TpcO+Y9PqQ20SCMXo096hzvP0gUQCDTbH3LeIzbYfMfi8z
 X+xhceN/61jrpbw10IhTE5RXr3lD8IZ56oC1M5Znw47Z+8Z3itMoWuwzOLshS/xm7Npv
 V/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895429; x=1745500229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCjGM8gwQ/EmIYgFRxP35ULYOynfX81xOLUnM2jN7fw=;
 b=dPbFavMIPJCuzVUx/yqGeGmnqepQZXU8DOPv9tXq4xDMYq+YFK360zEvwb5zRjNgLO
 BmBq5oIgm7FsZwNRQrMZ8xht4rdUPRHeALrfSKj9gI3icwrp8xuYpHoRH+fUDMd27Vsq
 6WJlALAfbx3ZWyxVAxkuVDiC/NWZ3eMnIZTS6uu6hktcBs6d20cRvR3SeYukhBmnWYEL
 ZJLxJzuedqmj4WJVEQiPdUSyAJl4lyQojPxdc2Uc8DxDeiI2tIF39gd0Ux3XeWJH7vb+
 DO13TvbnyH3ySNt9mwPV8Th/Gs7k/BmGVskNTSSdv6CGDGmZLCjo4gEVUCjvvs1k+m9h
 vlHg==
X-Gm-Message-State: AOJu0Yyh/mhDlT3VFHpBoSi9C9D3IahhdNwI3zVmFlk7H4BOtcZr3hEm
 9X2jkTlHzVgV5tKl83fYBHl5me+/JjcG6utVc/D931v3T0sA/1Wo3zMt5ptGnTAIEjdAtkjFdT5
 c
X-Gm-Gg: ASbGnct9o3m2q5MYDs8uv4kqzruZjg+v7lSN4RGx0gGeBwhqnxtZNEqUbai9qgXnoqf
 Sz30hxdXEKH8aphcqSxdhiY5vFdHFffLzyTosZBvU0fvVN5j6ydebe8gXCBQ3lw9sxB1QZxziSW
 FXpuROaob1h59i3FYV1qhTq7mNN0IOyDHJuzfdOSQxqNbO+2eugMcJ9rGlMVwKQWiOvJkMIBIqk
 vUou+mbDMMuDNHxfdzWPB1lmemC77pSei9TkZ/3lto6XeYzW2z/ZFMBs5IU+RMwi6jv+Qx2oqvW
 Pz46mCxmBDlTj/Zo4iRfjOQyJBaw77WDqN1CnphtWiqhxG7xZuRKCnQVMcJ+tIUvFkbHmLrf0+q
 0lsm/kYveKOjJ5vk=
X-Google-Smtp-Source: AGHT+IE290OeOl6Fu8sSkGbhms3Sogoc1NuKbIsaBRa73hdX95qte9ONh3P+5pOo6XDVY35IQ85Flw==
X-Received: by 2002:a05:600c:5107:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-4405d6aaeb9mr46089045e9.22.1744895429160; 
 Thu, 17 Apr 2025 06:10:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf4457a6sm20402214f8f.98.2025.04.17.06.10.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] target/xtensa: Evaluate TARGET_BIG_ENDIAN at compile time
Date: Thu, 17 Apr 2025 15:10:01 +0200
Message-ID: <20250417131004.47205-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
time via #ifdef'ry, do it in C at compile time

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 5ebd4a512c9..2af83c07c2e 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1395,11 +1395,11 @@ static void translate_bbi(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-#if TARGET_BIG_ENDIAN
-    tcg_gen_andi_i32(tmp, arg[0].in, 0x80000000u >> arg[1].imm);
-#else
-    tcg_gen_andi_i32(tmp, arg[0].in, 0x00000001u << arg[1].imm);
-#endif
+    if (TARGET_BIG_ENDIAN) {
+        tcg_gen_andi_i32(tmp, arg[0].in, 0x80000000u >> arg[1].imm);
+    } else {
+        tcg_gen_andi_i32(tmp, arg[0].in, 0x00000001u << arg[1].imm);
+    }
     gen_brcondi(dc, par[0], tmp, 0, arg[2].imm);
 }
 
-- 
2.47.1


