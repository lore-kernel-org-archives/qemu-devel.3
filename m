Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC7FCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sNx-0001A2-LO; Thu, 09 Oct 2025 11:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNw-000194-2Q
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNo-00014a-KV
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso7687515e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760022999; x=1760627799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXpfWCsPykTPKB2nupBHT7ETUnf9BD64zIAPtQrpjtk=;
 b=nkAYczvvb96pEPmasPIMHqXlnKsZzIsEnkvdazbh8XeWWNi20M8qRpJWaZnKDZ1uhM
 2REDbLYBtIPWiX7QXcrjFsBSnkw6QVGnlXW7nqweSVpnOgTLvXqDNHnfbt9JzZn/gNQa
 rlH5SLPaQBUJ7KheN4wqZtdY9SSlKlKwCDFNfNl8XvZIVP4zKvPXnbXQdYv4qszBx474
 zbBKbiz4NUAFBLg0byCcvJet61wnnOuOX8NIHvaC2Mx+4zFPdjxdPZRdcwWUuKL/8K0e
 mEBtQM0TqR9uA2uljS2NXWUiJ22kTkKhBnKzsfKYUszkVtpFCIHpyGcOdODxCbzK3EcF
 5qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022999; x=1760627799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXpfWCsPykTPKB2nupBHT7ETUnf9BD64zIAPtQrpjtk=;
 b=fhcdyGKJTmrCxz6O6bXyncvdO7Ug8ABL07jIGKAF+NdWNShnUsZBnp0ig1BRt3335Z
 j6oFMy8wjvVMYujH2fZofddsLCDvluJOEl4s1t3MfnqrsfLzb4NnIIf1qT1jMnlLaRHO
 tt8JLjNyfnRmsOYQc5Ig4arZwAbCQ4+J7Ow+THShZAexS9PYg4P2F4tWkFpT0m51+t/g
 VBVuUsdf9/31HLbVnnUhI4r69pr1QYwvZUtn1AoFmwDm9Kb3qM3rv7vUsgfnqejKZuUm
 eKSIHTbuyhT7XAbHuMkEdO2ihxuDXLJuBngxVF3hjMQZ3MldoN9I7MfuxK3Rhc7qZRph
 e+cw==
X-Gm-Message-State: AOJu0YxQ4cq7Hf6S3WHf+WjBXcLstwLJcfQ4B7lK9J1lbTAB8EQLNKH5
 WrvU68dFbK27QmyA6tLakRa1ylBe4aLG+nqXcUmB0J7BeaBNLVi84Tl10eJadSE6NlmsplexIz+
 iVG6NAY9gTg==
X-Gm-Gg: ASbGncuZuhWoUYi11zrWw1in5AxFTbyk+Nk/9jUBwj97ISLOlbel1csurbiGZBflAjh
 GnTUTP7v8ntZBgHGizPH18POA8XHVtjI2rVMG0ifMwvwWtvUgi9hY+7Vi6XUc2Tf6siVrPHNOLv
 n/jmLXFOLFYQjO2KIyD5R+Yovtr4/2a6WQY88waYfYF6MqLrTmSu/SOtz21s4leZ9PChf1Q8rdo
 Z5i7F0kG/6xRhnnF5ghXIAl5rBL18de0NlrehHJSUIZcwsdTGqLerb3/D9LEUteNbXWrpRdkpxx
 CZh6MfmOfJQ6m6yxH8W0M/8I/lKUlGWuR0LXUBS3HYlaBksIqmkiLW7aQ8lT0Ew49RCYtQu1Udk
 +23rGjd6A4N/t5czFnR53mGuY0OyuypPyXVRjXL7c+qxhbE8jXI0h8UQtCbQmbam1wYL0R+n4Qj
 ciSCETkDKkj+DrVH2VcEWwP91mjzs+oXQuNho=
X-Google-Smtp-Source: AGHT+IGUYOHin6ycXo/vFt5qur0htRIox+2ejE14rcc2OEZEvKi0PyMC/UIJ1hRKSdy90PeJCOGIzw==
X-Received: by 2002:a05:600c:4e01:b0:46e:6a6a:5cec with SMTP id
 5b1f17b1804b1-46fa9a8e5e9mr55389185e9.2.1760022999116; 
 Thu, 09 Oct 2025 08:16:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489ad27sm1775425e9.15.2025.10.09.08.16.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] target/rx: Factor mo_endian() helper out
Date: Thu,  9 Oct 2025 17:16:05 +0200
Message-ID: <20251009151607.26278-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index ae9382e0756..01a065f937a 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -72,6 +72,11 @@ static TCGv_i64 cpu_acc;
 
 #define cpu_sp cpu_regs[0]
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return MO_TE;
+}
+
 /* decoder helper */
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
                                   int i, int n)
@@ -163,19 +168,19 @@ static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
 /* generic load wrapper */
 static inline void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | mo_endian(ctx));
 }
 
 /* unsigned load wrapper */
 static inline void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_TE);
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* generic store wrapper */
 static inline void rx_gen_st(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
+    tcg_gen_qemu_st_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* [ri, rb] */
@@ -226,7 +231,7 @@ static inline TCGv rx_load_source(DisasContext *ctx, TCGv mem,
     if (ld < 3) {
         mop = mi_to_mop(mi);
         addr = rx_index_addr(ctx, mem, ld, mop & MO_SIZE, rs);
-        tcg_gen_qemu_ld_i32(mem, addr, 0, mop | MO_TE);
+        tcg_gen_qemu_ld_i32(mem, addr, 0, mop | mo_endian(ctx));
         return mem;
     } else {
         return cpu_regs[rs];
-- 
2.51.0


