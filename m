Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2026D5C0F0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RAH-0005wV-4o; Fri, 08 Nov 2024 10:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9w-0005Vv-QC
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:32 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9v-0005gQ-9j
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:28 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so1638159f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080663; x=1731685463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DIqtFDNKbWcFtV6kDPh5+cEk8GapRiCMoHMQdui5B4=;
 b=ITVL3nriTHO851mw8m2fAmwiEoAoda4MRgweOJZFPsNOfvukPF46Q/xSjCRZcBprI9
 BRl/o52GodZHZ0sK4Gad/D9W9NrCWwPMzVDMk2j9FFUdOQ5BIWQ25cTXAAznC8iBnOb3
 69RLApZtzggzYP1lh6zTDVA/VuWWdALjKvLYrmIpJswNaJIOnAjwR5Zw9Au9TlvZ9E7q
 0jcvFOFMP+0yoNUgvR1T0eh3u4s6JVrsiEz4JYaWNEMAcyc/7kDQrK9S5xt9VmEh521u
 5hbhP77PAdjOfx16nG6pYIash4tmqV+r1MLL0Rby8+coTqnA2BtnRexRsaUxXnJ+KX3O
 q8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080663; x=1731685463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DIqtFDNKbWcFtV6kDPh5+cEk8GapRiCMoHMQdui5B4=;
 b=sCJXUSfie94y24tZz9qzitCsEIDiw55gQEhKgfnIgvLLLSfcmNr0s+uvTDC3/LJkOt
 4W+fWKyQetVZ39H/PUY2Ts+Fx7zpJ0KOY+2xGQDSl2pIySfh+C2O9UlQkgpaq+fvtFHE
 Rz5lwlmyrE2pDROMFtk5iV45dHz7lyrXZ0OnRtMNxZCTixfm//cHuIku5BYY7nn3Nt2E
 5Roksk4zsZrN5f/gp80bv3UpUJS2ne2Pn+hK7cFT4bZ38ntBHn3eK2HBssahJP+C3Pdr
 dPXibknv9pZolV8UK+IA19zF8YjnGR59r8u2meXTVvJMftPZtPt4gMFBmupPhJyxTORb
 vpPg==
X-Gm-Message-State: AOJu0YwPdQDUMt9n79zKi2yNFuZNIiHPzU4H0PLCN0P/mdoZi3mhJY7f
 oWn5BWXHLdcGfeGf9tBhyDOtZsK+YqK8IdyIxuF/5Jxl1xE8J2Yo9SyFRjskQBIfpYV4wnroMB4
 L
X-Google-Smtp-Source: AGHT+IFgNesVP40l7LqZ1xWwLsD/RAc1Po+frIp6yGVAdcK0bHYgbPLEKeSGMLS/xWwGBC9up5iS9g==
X-Received: by 2002:a05:6000:21c8:b0:37d:5129:f45e with SMTP id
 ffacd0b85a97d-381f1721434mr2475433f8f.20.1731080663530; 
 Fri, 08 Nov 2024 07:44:23 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c0d33sm75414505e9.27.2024.11.08.07.44.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:44:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/17] target/microblaze: Introduce mo_endian() helper
Date: Fri,  8 Nov 2024 15:43:13 +0000
Message-ID: <20241108154317.12129-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 86f3c19618..0b466db694 100644
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


