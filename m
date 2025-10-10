Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5360CCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77EB-0001fd-3d; Fri, 10 Oct 2025 03:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77E8-0001es-Vf
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77E5-0007ye-6s
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso9342425e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080058; x=1760684858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoB4mQdJ5q/PSA40CHqGuTxSzS9aCnGI7d52zanhXww=;
 b=eUQ3d5EP1rO5eRceolXHuqejlEcztykek6Kz4vfEc98q4icdCQJurtBay7/bOT0AD/
 EQrf75oPAOABy6KQl0En3fonTgBD1ZRB/80PrW1XD5n5KOnfv6nI9g3K5VVhPfyC4/3/
 dvdPD/yRQlh+OIQhVwGt29qXHD3flk8XeuSMxASHv+G6Y0OXEIzuvspHKcYyz2oNF27d
 9GqqRv/c7myvfF11qdJQUMmEhBf6m5lCvsSHfX1qWJlH2p7Ug5O33gL3V7fbMiD/LBMY
 qVLHYU6Dg6qFYkthCyrSoCg/dOYj6xW7wyAA0VBrY+GEixOx5RxPGQJmjlATgvaPITy1
 x+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080058; x=1760684858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoB4mQdJ5q/PSA40CHqGuTxSzS9aCnGI7d52zanhXww=;
 b=XM1DFDm5o1oWMHKynbtRUKHLN55ROrCLdJCJBSDWhsvcY/ZE0yFJhYd6Hh/2xugoOR
 KLsqhmC63kAzYttdxZ9kE0UMryDMwPmF6+Tp3w9TuNxNNWABHAWcy6aGv3+5sGOiGmN+
 5dqhSxrIIOP3hK8FD7wOgWH55dc8MJG0YLnCCW8pYqJawMWUBKnJE4cbtJidfc6O+Yfc
 3CZ8CYYhSnSBhlMiKjkF7+44KqY6c9VTqyrf4ULx1WP8T3GttW8iBmIOoINDe1r66n2f
 aZy+QgDWh4p7WhsGP01GzFYWO4gDkUXaZS6ZVLyMVcGA9vpOEckLnueT2LyH72GFXI0Y
 BCIw==
X-Gm-Message-State: AOJu0Yzz5JmS6912R7fYUsxhmPLAZwQnX+D5xiSgSB/R82yQogkScczX
 YTpAxIWR4mYgv0AAFOLstjSkXExlhdDO7dbSg+81MWgNLxMwD+LHsJE2XChSiVvYXpBomrIoPPX
 SoW8KAhRDIQ==
X-Gm-Gg: ASbGncsEjl/VxrbkxUL0oWKl6rHkDESYIkgTZP9bccvruUEsF5lkzez/+sALWSg1pxT
 qJiu5xU6Devv27xPkbBWdoqXl0EzOFEQF4hAXghspbHav2qXJ/GAhWcqjmrho/leVtOdZgARAEb
 Z6TU3kTterSMIlcM97ivcan3vhcJ+4Vd3ErY77RMX1MDNAU41IwoRxobOruvI4XhQwr9TxD0raZ
 WokJrNgLLpwZJ1zDezLnqJJivR1mJJmtjXeYrEfI7U+72crFe64iYlqVVCBiLsNvLV42N5EF/nn
 GewNFSL1HBxyF6HaAXNdcvfxecYXSR6jvAfzxojLGifS0iUX5+W1hV7bNVaRGKKnsShILhmEHeH
 tPwpdlwed4VpJg1cko+qlVqc0p40rMqomOonamWedgoreCx6vUCsXEytwEJH+otdvkNhMQPVZxG
 eG6EGa4JZY8PzeRqLcpg+iJkec
X-Google-Smtp-Source: AGHT+IEKplpjkapxwDSu5sJJ4BY5lAmiylI/O3c4tXC5Nas3qskpTbvtu4OTiUUr61vHVPhAxjz3rw==
X-Received: by 2002:a05:600c:1d11:b0:46e:5aca:3d26 with SMTP id
 5b1f17b1804b1-46fa9aef840mr70798275e9.22.1760080057665; 
 Fri, 10 Oct 2025 00:07:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe69sm2741273f8f.32.2025.10.10.00.07.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/13] target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
Date: Fri, 10 Oct 2025 09:06:55 +0200
Message-ID: <20251010070702.51484-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Extract the implicit MO_TE definition in order to replace
it in the next commit.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/openrisc); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 29e6b51a930..52d51313f77 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -622,7 +622,7 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
+    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TE | MO_UL);
     tcg_gen_mov_tl(cpu_lock_addr, ea);
     tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
     return true;
@@ -640,13 +640,13 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 
 static bool trans_l_lwz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TEUL);
+    do_load(dc, a, MO_TE | MO_UL);
     return true;
 }
 
 static bool trans_l_lws(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TESL);
+    do_load(dc, a, MO_TE | MO_SL);
     return true;
 }
 
@@ -664,13 +664,13 @@ static bool trans_l_lbs(DisasContext *dc, arg_load *a)
 
 static bool trans_l_lhz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TEUW);
+    do_load(dc, a, MO_TE | MO_UW);
     return true;
 }
 
 static bool trans_l_lhs(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TESW);
+    do_load(dc, a, MO_TE | MO_SW);
     return true;
 }
 
@@ -688,7 +688,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              cpu_R(dc, a->b), dc->mem_idx, MO_TEUL);
+                              cpu_R(dc, a->b), dc->mem_idx, MO_TE | MO_UL);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
 
     tcg_gen_br(lab_done);
@@ -710,7 +710,7 @@ static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TEUL);
+    do_store(dc, a, MO_TE | MO_UL);
     return true;
 }
 
@@ -722,7 +722,7 @@ static bool trans_l_sb(DisasContext *dc, arg_store *a)
 
 static bool trans_l_sh(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TEUW);
+    do_store(dc, a, MO_TE | MO_UW);
     return true;
 }
 
-- 
2.51.0


