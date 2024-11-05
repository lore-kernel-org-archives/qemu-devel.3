Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90436D2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JHJ-0007TA-9k; Tue, 05 Nov 2024 08:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JH4-0006c1-9Z
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:07:12 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JH0-0002gL-Ug
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:07:09 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d808ae924so3014871f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730812024; x=1731416824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kbb2EbjAWyPRswDzNr8J6AfAT+vMH4Ts659xVE0GgBY=;
 b=NMS/MpdHv0mL+xXX4MDKMtHhCQD8tUoLFhAHOWTYVdzr25FdS5FjZuabDfzOLGrYTm
 a7bLb1/DQAfa6SN8YoSaJkhjlM2Hqd1XoF6qPaFjTbpVosaNYxnjYZo3b3tbk4ZR0Mrc
 u2sat5CPvv3ypxBGsvgr5PmeGHrHpY9jM/FBnWTC0et/Dp9kxqch+mmicDmAfXbLDa5d
 783kZgl7DNu7FV5g411uE1MB9RK0hh08hjYF8Li1neIxLmroTy491X8bbqAKkpufpkn5
 PhzyZ0UwBuPzNWxkQ9VXcGZJj8+xfA8HhQDzUuIHmsRedQ1PtFOfCuApSPWTGDikV7LV
 Vl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730812024; x=1731416824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kbb2EbjAWyPRswDzNr8J6AfAT+vMH4Ts659xVE0GgBY=;
 b=jfLD7xrBTW+U62hKJtmEDQbudrzl3feTrEVSqoRmGjbt+XZrGe8SrzS+vvOZcZDv7I
 dBc2m1+mzkRNr9fHVH1Nel3gx5Y+6vxLjrx+lcBySbnX0KWlSelhJep3PoGxyQTs8ckz
 bUz6lFFZ+hgJ5HKKXNZpDXzsbNsPJt+swslXBNWwi+StTNr3ofhvU7K4D2ZsXhSw0uIU
 /DimTTNYQ525fxj/5kE4fKid3/TP3RHUJTk2+AhV7MBZZKTmtsMbABjeqE1d97UgIHLK
 00eVhxgPbQ+HPxwMbC51GjKk6tlDcj0dudiVu23zcFKyE4PXIWTWJ5lupZUK0d4cK/Eq
 ielw==
X-Gm-Message-State: AOJu0YxD/sN6a9o5MCdmRqMfbdat0R6TPbLpiMk0hUMw/4JvxFqURjYn
 Ra6juGym4rYoEKf5DL1NveZs6gxTT3IQOSrdQbTBDhO1ALibwZOBHthTLuWX6a9lgeHXIkYQ9z/
 T/mE=
X-Google-Smtp-Source: AGHT+IEWaaWQl+axUGXNmT4+HOHsD3E48uIkfAyL014ycaATTIHJ/QexfC7+mG7HbldOF12G2Wq6zw==
X-Received: by 2002:a5d:5d09:0:b0:381:dff2:cf08 with SMTP id
 ffacd0b85a97d-381dff2cff8mr3069929f8f.2.1730812024322; 
 Tue, 05 Nov 2024 05:07:04 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e073sm16114234f8f.66.2024.11.05.05.07.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:07:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/19] target/microblaze: Introduce mo_endian() helper
Date: Tue,  5 Nov 2024 14:04:27 +0100
Message-ID: <20241105130431.22564-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

mo_endian() returns the target endianness, currently static.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 86f3c196189..0b466db694c 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -707,12 +707,17 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
 }
 #endif
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return MO_TE;
+}
+
 static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
                     int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
 
     /*
      * When doing reverse accesses we need to do two things.
@@ -847,7 +852,8 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
-    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TE | MO_UL);
+    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
+                        mo_endian(dc) | MO_UL);
     tcg_gen_mov_tl(cpu_res_addr, addr);
 
     if (arg->rd) {
@@ -864,7 +870,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
 
     /*
      * When doing reverse accesses we need to do two things.
@@ -1018,7 +1024,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
 
     tcg_gen_atomic_cmpxchg_i32(tval, cpu_res_addr, cpu_res_val,
                                reg_for_write(dc, arg->rd),
-                               dc->mem_index, MO_TE | MO_UL);
+                               dc->mem_index, mo_endian(dc) | MO_UL);
 
     tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_fail);
 
-- 
2.45.2


