Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5006CC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1QB-0001AK-TD; Thu, 09 Jul 2026 22:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QA-00018D-Rc
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Q9-0008TL-7G
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:58 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cad4170e8eso4582085ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652216; x=1784257016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7WHo0ZT4Hzak/+NmGEUnkhMQpSmfi2+ElEJsjIUY6XE=;
 b=NcHASxhuoihKNp81KrRU7w9B1FOBsWI/HXDshiZGcXMCQ+NYIjp9SyePrEHIjkNsSw
 C21GdKOdMkpOS1murGpB4PNfUYGTEr0tTxt5ChZPMMkv5LINppupo4UxiGrEkiqgzFLj
 /bTeud6jYFKVFwWi2zecXRuKzg8MYaJbv9QbdGJ4fQ8s/qHehrmokzuUcrN2lTGZxX9e
 O7q3/HKs8arYqqfi0mznjk//TuL2w2m/eBjMFI9Ev7YDwT/Ntx5oJqh+B4T/z1I89c7P
 eQmF+VY54xOpauNxnMrsFyjbr/wIl8L8DkJx/ey1wW6xddGSeou8vh1bE2mGgCG1yAHv
 2FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652216; x=1784257016;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7WHo0ZT4Hzak/+NmGEUnkhMQpSmfi2+ElEJsjIUY6XE=;
 b=PemqVOT7Hk3Lss9W+2HcNsx+GkEBZ2LI7UVwsXsL+TZxWZjqk2k0wtFsCdKPukStNu
 nAxTwOkmrXvxxXB/A7Lyx+13VL7y8VOMP4hdOgxsktpjT3Jt+gCio05r//KjEbj0QJsR
 5kLnHCQuB0D8vMyBq5L5CKQR2PRdbbuBTNS8hqSgjOWWvC6D2Gt3QlDL0NeiA+MtrtDQ
 /plnusojz6c8eQicwNoGc6qzhzEwvDpfq6fIKJiWoSjUcs2EU7r/DuQRI/K1abatA0cX
 gh7mE6LuBDWpCL4S57EGQUG0zEO1YAgub+jSoct8PSonNsMV9pxHw6GSNDEB/nGH7rvK
 1hIw==
X-Gm-Message-State: AOJu0YxwkZmJCpcz68JDqgEL1X2j3+9tZhKxmUoDtStXtPy9DoHh4jt/
 Wk+kRgUhFTEDDsaC89FEmYjqZd5XphIsQiJCUJhAgVLk8bQxvHCy3uNUQxkhzA==
X-Gm-Gg: AfdE7cmQvo61GgfuGc+rdZ4Dvdai5Phk2fXYVEiW4SYdmolyYyV7DYEut4mf067tjDM
 OuZ+PdUwzLLo80CrSG4JHD7gyKyfYFiUVhiXVJqfJMPtL7YqEduQdSkXfXlDXhJjPvXQcqg/Bxs
 PhvzL+/z7lX36KXHCaMNFvU0z1cgA4GRu9ycpTdBZVNJB+4k7HAjdX6PaASUyLhWrlMgfQL/s/i
 0O+bk8axDhgFco6N/nq3uKKxk1M5t5Q1U3hWycvCWrt6J45PiGQPa0Z4grVEZGsaGvbYvloy2VP
 d4bg7uZinbzIjrL1cRjpQPkzXrXaPA3BltVV1t4OECxxcvB8QM68DVyXu9Cw11NbtGNHoJKL7uY
 Nmj82OmaRjGuiqMp86FBEXo0Zbmqvi+sX5ebNCtDxoeZvh8Wsm2Rci2gAshYGqG5dTa8Um/YqFJ
 H2y9tQ7hyhC3KAiR26e2gUWMz28fv4Rio=
X-Received: by 2002:a05:6300:2293:b0:3c0:9c18:d5a0 with SMTP id
 adf61e73a8af0-3c0bd1a5afdmr10892470637.61.1783652215658; 
 Thu, 09 Jul 2026 19:56:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 24/40] hw/riscv/riscv_hart.c isolate tcg only bits
Date: Fri, 10 Jul 2026 12:55:09 +1000
Message-ID: <20260710025525.1704417-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

riscv_cpu_register_csr_qtest_callback(), vcsr_call() and
csr_qtest_callback() are all TCG only and are not available in
--disable-tcg builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260703180538.3346781-19-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv_hart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index d1c7188369..747754be61 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -61,7 +61,7 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
@@ -151,8 +151,10 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
-#ifndef CONFIG_USER_ONLY
-    riscv_cpu_register_csr_qtest_callback();
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+    if (qtest_enabled()) {
+        riscv_cpu_register_csr_qtest_callback();
+    }
 #endif
 
     for (n = 0; n < s->num_harts; n++) {
-- 
2.54.0


