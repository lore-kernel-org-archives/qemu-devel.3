Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC622CCD199
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95pF-0003tg-2h; Wed, 15 Oct 2025 14:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95p1-0003pV-KV
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:02:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ot-0006Hq-82
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so55725845e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551307; x=1761156107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tU5Jl42ySH9NzEtX9tZDSKOaBw6Gcn2zbwhswZp5WFk=;
 b=goUdVvg3y7eyncT4S0oe/8BpTqgUMpV/4fK4vkdXwxMI9skzx+D2SZaRh+5RBIFHaZ
 o1d6dF/ULB+OSlqFQPSorvHzohgZpRbAIJ+Gb4x1AedBPo2FGvv0VQQLX4hGzF2yyidE
 IcTRACB8E/872FUMevIrve4WAOVwGOOaAFTGrf3peZuR4UHyfC2lhC1EY5Y6bQGUHutf
 /Xtpo/IbaqGzc7Oyhq0+BBFGT2BtQQyoTASKnVD8loCKljtefheYyxRp7DvLLPwb4VHO
 pMwYUU5zgUYDB/achk3SlR7qbXjc0sEcJxxvcUWJbKDLfZF5gfdNm78YEvdIVlIpKItv
 h+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551307; x=1761156107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tU5Jl42ySH9NzEtX9tZDSKOaBw6Gcn2zbwhswZp5WFk=;
 b=mth76h2pEDW8T3TwERGRM9dXzmRSXgRpGZxNJirTGoIXNS6YKuWa9qHP/C6ck6bWeN
 7rfK+6vaDBwcaAUcY2plamR8F0Xc1KqI3LUiIu/4yUP2qC+6guUw/ooUZxy/vOPbtTog
 ykVIj4QUDUL+voUpzlw8AMY/2s6qx8wxKdHq9brmeXgdVUfRrrU9kHcsYA7yM1hQDXc3
 r0ZYRIJi6Kr7V/O6EQ96ro9hixH35ev0e85NmTUni9scWypWwMQV1KvlFp77AofegXAh
 pEAEX+L1VjH8tMLl3CL3XqA3s6VlCxwyHCeC4B8GBlQpIxMx82aqotXgrL4bIktFDdg4
 9urA==
X-Gm-Message-State: AOJu0YzzlBUGiX2cDOc4zJlsSDn0fNAfxDhfhQAoGSFCdjR1EdvJ34Yg
 sS4GsmAd+jNQ1g6INKc6nnIyLtzKB97IXagw1hk6c9hEFxA6OtaNVTuysf0ZGQKOm8adE53S1vI
 46OUu1phSgQ==
X-Gm-Gg: ASbGncugO5QdfnnKGewroVASexpLvY/ig4hQrX9+wBk5BczptBBD/AjTdIYCZEGcC2a
 ZVbTKQVUiaI1srW8fiSu8OE8fktMcuTyOe5PPuUGMTJOzPWbx6c5/r4FAagohebOKSD/wKU9GUc
 9YWSabfuMOhPCdWWWlU6XT47z1bgBFQYUsAgWTo4sbhA++AMTUCjZzoXze58fnVvQ7rL8bJf8By
 2NcAxZ7y1mbjxC73hZmKoJ6sTMgZYNquqAaRKtnfGftcfc/TXiDnYfDd34ojEH+8g8tVzezE293
 z+BbNUjOCyxbZHahTajt5Eoz0sGm2qm9u5qd4H2eCBFO4ru9W5/bjaaFGhr/rWKdA6rqErDTlV4
 uQs0YtYLYr1LliwCpnPImZ98elGsnnZkCKLdvMiDtP13/Ue1vT47baOeSWhRno+zSk6XPh3ySY/
 CIibB4VXRDxiDPPW3a8jtkcEub+W7BY86DOccKaSI0
X-Google-Smtp-Source: AGHT+IG6ReUke3arBgQWUWg1No6mGic5/1XOAGk4Y3b1kFH3GSZeu4IOW96kG1McchUKB69NDMe3eg==
X-Received: by 2002:a05:600c:3d87:b0:46e:50ce:a353 with SMTP id
 5b1f17b1804b1-46fa9aa1c5cmr209572115e9.14.1760551306977; 
 Wed, 15 Oct 2025 11:01:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm31763173f8f.10.2025.10.15.11.01.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 11:01:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/7] target/microblaze: Have do_load/store() take a TCG_i32
 address argument
Date: Wed, 15 Oct 2025 20:01:14 +0200
Message-ID: <20251015180115.97493-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015180115.97493-1-philmd@linaro.org>
References: <20251015180115.97493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

All callers of do_load() and do_store() pass a TCG_i32 address
type, have both functions take a TCG_i32.

Suggested-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 1554b9e67b0..ed53848bad5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -708,7 +708,7 @@ static inline MemOp mo_endian(DisasContext *dc)
     return dc->cfg->endi ? MO_LE : MO_BE;
 }
 
-static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
+static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
                     int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
@@ -726,7 +726,7 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
             mop ^= MO_BSWAP;
         }
         if (size < MO_32) {
-            tcg_gen_xori_tl(addr, addr, 3 - size);
+            tcg_gen_xori_i32(addr, addr, 3 - size);
         }
     }
 
@@ -868,7 +868,7 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     return true;
 }
 
-static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
+static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
                      int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
@@ -886,7 +886,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
             mop ^= MO_BSWAP;
         }
         if (size < MO_32) {
-            tcg_gen_xori_tl(addr, addr, 3 - size);
+            tcg_gen_xori_i32(addr, addr, 3 - size);
         }
     }
 
-- 
2.51.0


