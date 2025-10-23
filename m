Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C196CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn3m-0003nE-Pz; Thu, 23 Oct 2025 00:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3i-0003hU-JG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:18 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3g-0001XJ-On
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:18 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-33bbeec2ed7so351808a91.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194173; x=1761798973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEQEOMtu60rG98D2pD2eQ/ov/DkPTh4vzA3I2V26s10=;
 b=CzOssTMdHd7S9MY+In439hxb8iQrBoGCUwbaX78Mra55JE/Ez0T3J24DFYcohCo1im
 7yFTVWgexHB1mFmVWM1QJ8b+gk4Y0v5B7Mjsw9J2oF5UdRuXn+QFCrzB+x6FsGZArINH
 /CgdoiSa0YGgp+IIc9XDlwonGjOil5yWlXi/oO5RV/om0Q5p7BIX/Sh01tIrriYDqK2u
 GGINPzRG8FZiHV/h1od4E5rRg/R1cIBW6kauwZOIljrsxZCyrD1LdIhIeIJDjq5nBkDZ
 KXWknLM+OVDAr9DNORhTLhWRtiE7UhdEe4e6KyfpAxt7NCFwn2C29EUHFxHRC/mSedc7
 yJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194173; x=1761798973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEQEOMtu60rG98D2pD2eQ/ov/DkPTh4vzA3I2V26s10=;
 b=rgJa6S0I51OaEzdCqW4gporYd2XnmQpL37jnGWWh7Jt2HGckbnjosjon9/OI9NqLkh
 EbfdG6CGYQy+P1R/gRP5HFoWI1kxgNLTSolhK+zF1qkCgL7O9p2PvWS+7ee1sxluyI95
 J9kkD0mrrJJHf+xFBaQkhWtuHO58s4JuUP6L65M9cKEQd4mT8W0vGH2mV/y7LlGORMjk
 snWhQbDlkQKzaCXRsnipc3zMbr8OhRkgVYR9POrxwnRV+h1YSj/U4I100OdgNsZlZlNK
 PAuDhyEFNNYThOI0C40zTAzJba1hNM00wtBYS30KsKxeCGnBOzbeQfsv9B+/Oo8ioHLy
 R2ig==
X-Gm-Message-State: AOJu0YwcRL4vydUqXMhKoppG4yblLgj6CLRrI/ywFgN/sEYuqNJpIZtb
 mCSQUwHxeSX7ehLnG7E7syvB7KfYu4Rh64zpED1GLg4A7S+BUN5+peTOJrnyqA==
X-Gm-Gg: ASbGnctD3fMDOwNrgO0eM3z7h+HFU0BLP5qw5S3UhDnKF+3AhBUtHnQs0GEhkYj/b/O
 gwWSaiFWC8y+i7V6RHtAud9j3P+HeZnnzXKrtoFJcvOnMbfCMreMVmFDlHQuVZDPmdGKlKcNIqe
 wNu83CS8I5KVKPH4PP3JcJbZojJ5F1qSNf8p5qj9h5yHNFaSv8K0+GjPC70EuiJC+hxofLF6VVQ
 PzTBmdwuItpbrGDlnovg8KbAaN3gOGIDA104uPEEWIPhVl+VjsaAA0JGcrpbY6BG/ytLBa5Vnib
 BEap2hS0sPeBK8FyJ1dsdqX+PezwkImunWYzItCb7AmSFJ9r+LWkpyTxUW0Lm6FItlWTL9/TzTs
 Hkgvxvk3oQJRESlN3pfKlozV3c8cI90IUbarjh34yXnwVcZQEwjm0qfB/7vwon29YGX46VtI0aI
 +KPEMO/i6eXh1sKOH2/9ACR2llPBnjylA2d7aVtgBbT4t0C1mFVSIgDKhJJp6SJrVxOnZnahckx
 0cw6N6X/LRVM2igIsA=
X-Google-Smtp-Source: AGHT+IGNR8DeDWaQP5mrH1hmvswQkYMRyMzcxep7ezaCZeIzz2HTVAPqNbJ1qsswx7n1TCkBK7c93w==
X-Received: by 2002:a17:903:166e:b0:290:ac36:2ecc with SMTP id
 d9443c01a7336-2946de83f2dmr15782855ad.18.1761194173454; 
 Wed, 22 Oct 2025 21:36:13 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:36:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/37] target/riscv/riscv-qmp-cmds.c: coverity-related fixes
Date: Thu, 23 Oct 2025 14:35:16 +1000
Message-ID: <20251023043520.1777130-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Coverity CID 1641401 reports that, in reg_is_ulong_integer(), we're
dereferencing a NULL pointer in "reg1" when using it in strcasecmp()
call. A similar case is reported with CID 1641393.

In theory that will never happen - it's guaranteed that both "reg1" and
"reg2" is non-NULL because we're retrieving them in compile-time from
static arrays. Coverity doesn't know that though.

To make Coverity happier and add a bit more clarity in the code,
g_assert() each token to make it clear that those 2 values aren't
supposed to be NULL ever. Do that in both reg_is_ulong_integer() and
reg_is_u64_fpu().

We're also taking the opportunity to implement suggestions made by Peter
in [1] in both functions:

- use g_strsplit() instead of strtok();
- use g_ascii_strcasecmp() instead of strcasecmp().

[1] https://lore.kernel.org/qemu-devel/CAFEAcA_y4bwd9GANbXnpTy2mv80Vg_jp+A-VkQS5V6f0+BFRAA@mail.gmail.com/

Coverity: CID 1641393, 1641401
Fixes: e06d209aa6 ("target/riscv: implement MonitorDef HMP API")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251022125643.588947-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/riscv-qmp-cmds.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index c499f9b9a7..d5e9bec0f8 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -273,12 +273,13 @@ static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
     }
 
     for (int i = 0; i < 32; i++) {
-        g_autofree char *reg_name = g_strdup(reg_names[i]);
-        char *reg1 = strtok(reg_name, "/");
-        char *reg2 = strtok(NULL, "/");
+        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
 
-        if (strcasecmp(reg1, name) == 0 ||
-            (reg2 && strcasecmp(reg2, name) == 0)) {
+        g_assert(reg_name[0]);
+        g_assert(reg_name[1]);
+
+        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
+            g_ascii_strcasecmp(reg_name[1], name) == 0) {
             *val = vals[i];
             return true;
         }
@@ -294,12 +295,13 @@ static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
     }
 
     for (int i = 0; i < 32; i++) {
-        g_autofree char *reg_name = g_strdup(riscv_fpr_regnames[i]);
-        char *reg1 = strtok(reg_name, "/");
-        char *reg2 = strtok(NULL, "/");
+        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
+
+        g_assert(reg_name[0]);
+        g_assert(reg_name[1]);
 
-        if (strcasecmp(reg1, name) == 0 ||
-            (reg2 && strcasecmp(reg2, name) == 0)) {
+        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
+            g_ascii_strcasecmp(reg_name[1], name) == 0) {
             *val = env->fpr[i];
             return true;
         }
-- 
2.51.0


