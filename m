Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14415C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbI-00054J-5X; Mon, 24 Aug 2026 01:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZi-0002wr-Ob
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZh-0002RM-5E
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cc891373e0so33519025ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550624; x=1788155424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQDgWJg7DF9eHEdRBw/5L4zK1k6fMkTJXubxOKeqz3Y=;
 b=dPF6C9qd2XUX+ujYkDLSvwfp7TowFiHXlm2rLAxA80GUjX3WgBmDw6Wvb4CH+dtR4p
 5Z2HnYGu7Af3JSPfNQ0BkJ3k+f88y0eLpE8Lwc1HjJU6nlsDzw2Ds+WV0Npyoj6vB33R
 vEjK6RPP0JK0WRHpzIsDbNjI43YyD8XgrUcfvynAkTGfbE0hfbg6XKoshKxXonzG/fQ9
 OrxHkAIhjY0kOZ2u/Kl13/CMYsn6YJ7c7A6s4QVIITFWhUhXCwgwjajg1lBXB9TOnn34
 H57WSMpU9+5Afo2Ax5r0PgUutvQODLaj9qtH+tc5f2+1W64YCPJOXCv15QmrrO7ykquY
 /kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550624; x=1788155424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fQDgWJg7DF9eHEdRBw/5L4zK1k6fMkTJXubxOKeqz3Y=;
 b=TF5KVtPdFhqq7mF+Ci9Vrg0zu04zAWLj85CyyP5OyrW7k/MeqeHiPUZVLyoCtPMxFC
 rEBJrcCgbK32RQmpeGoJAq+tU2iWsa5wYCCmBjS71zZLJnUgkkno/Mc9vQ+Diepyn+qv
 UiqUvtrpz+oLBAU/kziAjMk07lnwEikzdcWCiM1wBBROR8cSliUdJf4gZnebHz5GVD2y
 g1M17kjpn1U8QA8oE4T+C0m7GAE5MX3xdmfwmRTbiCO/Li53JjnH6d6n+dDXD6DXfIIy
 cYkgL0ZeQzhcI4OAXZ3XOEwRP1RSNxNffmmzuU/9Ikrov59gy/VzYfNhbPhwSmjaV5HM
 WwkQ==
X-Gm-Message-State: AFuF++k2wA7Tc1R8eMNRjRoEV2+CS5sNc70fTPmUorGm/n19LLON8Y46
 tu+frqU+9jEt0jTV0d43OuRIBy1DjmqGFfY4LCfdtalBUipXOWGsjUtUaCG9Ng==
X-Gm-Gg: AR+sD12JVAIwcCbFOqhLAZVjcpOekYMae1aPZv3lMDSl7VUaYNGJuXGWvi7uV1AaE6H
 IBwMIDPXDI0Pn6pgHg/VXCtL+RURby/1eKDRkDxxKyOk3NpMe2AvqIegc4CFCW+9n91stxXiP/J
 sQ54ncC0fSDWvj/kSJpf5wT2tFjitkwh/KYlyQ/unKuYeq2DWNXROMMr4YMYMMdZJl8WyH4ADZn
 Cj4VB1NC7YIfjzkEWj4h/HZcaV1ut68E38l0FB0r0BEbAOiT61ZZ6k3iITDrWDA4oGHq2jXfBBR
 ZfEGs824stMA4siFurCAbDHA7sjGrfmM3dpWA7AHmN3JC/ZyxZ1Jum0Z1ZekM06Vl+qGRbpctFW
 XvVF8lIJlmwCmRdu98muqVyKOiAGnePAjXO9+SwdfoHN0S1PcvdMiWPr95yz1/C1WLjOS6/rn5T
 3TBIdsvZuufNIkK1p7yJ3rYTGxK0nEle2MNuVMRltpt48z2OmUhO7J0kGj6WRufoCMXj8YKJb1Q
 I9Axg==
X-Received: by 2002:a17:90b:5485:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-395df6080e0mr30917753a91.12.1787550623869; 
 Sun, 23 Aug 2026 22:50:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 40/96] disas/riscv: Pass rv_opcode_data pointer to
 format_inst
Date: Mon, 24 Aug 2026 15:47:10 +1000
Message-ID: <20260824054806.2790041-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-8-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 0be2f07612..70ea41f125 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5111,17 +5111,16 @@ static size_t inst_length(rv_inst inst)
 
 /* format instruction */
 
-static GString *format_inst(size_t tab, rv_decode *dec)
+static GString *format_inst(size_t tab, rv_decode *dec,
+                            const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
     GString *buf = g_string_sized_new(64);
-    const char *fmt;
+    const char *fmt = op->format;
 
-    fmt = opcode_data[dec->op].format;
     while (*fmt) {
         switch (*fmt) {
         case 'O':
-            g_string_append(buf, opcode_data[dec->op].name);
+            g_string_append(buf, op->name);
             break;
         case '(':
         case ',':
@@ -5466,7 +5465,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_decompress(&dec, isa, op);
     op = decode_inst_lift_pseudo(&dec, op);
-    return format_inst(24, &dec);
+    return format_inst(24, &dec, op);
 }
 
 #define INST_FMT_2 "%04x              "
-- 
2.54.0


