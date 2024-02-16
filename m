Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EB9C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rawOG-0006Sq-JA; Fri, 16 Feb 2024 06:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rawOE-0006RS-9k
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:28:22 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rawOB-0005pp-8n
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:28:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1db51e55023so12239055ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708082896; x=1708687696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pILAc4QGfEWQVoqeGm6TwPW8gXNmDL3KNUvGgdYo3Y=;
 b=FpnUkGKf2DJkY+1eK9gurS5bw2ifmeY4Wh2Cppnhcc4hpZx+Q28a2jhd/6qE25whEH
 UlxN7R+XW37vIsHfGhyPeC4L8XwJHRuhqSTJu19/jcU1PshinK+VWwycKL+TJWYU1mzF
 ldBJMaYwo5d6I1/ILv4ELzTtxWsVkU8n+/qYSnmsckieQ7FnYkUUvK6o+uSX/h8qV9Di
 2F2K+r7ipXjAhvbG03rjCby3Xd/C7XNAYxUeHsNpMvcq0SfaJsQ5iTA0pvGHZEDsayd7
 pm7MiEj89vh44NfajYCyFGEkiPKIX0hXoLiPoZxamUZTUgq3sAzEfmk1T6BOjRjAyvL5
 G0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708082896; x=1708687696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1pILAc4QGfEWQVoqeGm6TwPW8gXNmDL3KNUvGgdYo3Y=;
 b=R/Qj3q5gIaGBZO/ZBGj0dnHY28wzT2cQ82qL9icRZspcNkZG9oqDQ60b9cUv6iOx4M
 4jveOrm8vSeoZyrv6N9F9LbxMDIRoCAKbV3+CFD+0/2u94wEJRerlO43llcQ2IoYvwEh
 qSbRBDD2u1UVHlBCsJo9MZsYyXg26IWM8lJ8EhKJlOyh9+bL9k99ThO7ZNNx0yI2IwYX
 Zr1jn37HfBmekOUfKtjczvdNEQZt7jiPb4+vcxx2hUQkRDzWwi2XD4BwNL6qf6UnvEGW
 6XGImtDRx8gvqoON61WlisEe5nhtyWtogEUXOej2aJ0i8PhTi4j0/+e2qpJcurgDbhSP
 f6fQ==
X-Gm-Message-State: AOJu0YxYhifqrkUvbdfZMHL1MfJlAlHn/RJUWWs8g8Y6MKkyysLU3ANZ
 3AEHtnAcDIm1BXR8EUXBCw5YAiSZG+SZtZOmIgg2HrJ3Zkif7JKjofFBfzAUgrSCFqpTcOEAIJ2
 b
X-Google-Smtp-Source: AGHT+IFUOdi96sWmIdFQJxadU+Qz8USlZNxaF4IIWOGNOXWCP5VIHmHpn+jvtbvyxF7C0ewPdxM3hA==
X-Received: by 2002:a17:902:d4c8:b0:1d9:dfa1:e4ee with SMTP id
 o8-20020a170902d4c800b001d9dfa1e4eemr6055960plg.25.1708082896568; 
 Fri, 16 Feb 2024 03:28:16 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 z10-20020a1709028f8a00b001db7709b322sm2774053plo.298.2024.02.16.03.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 03:28:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/3] trans_rvv.c.inc: write CSRs must call mark_vs_dirty() too
Date: Fri, 16 Feb 2024 08:28:04 -0300
Message-ID: <20240216112806.997948-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216112806.997948-1-dbarboza@ventanamicro.com>
References: <20240216112806.997948-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the Vector spec section 3.2 [1]:

"When mstatus.VS is set to Initial or Clean, executing any instruction
 that changes vector state, including the vector CSRs, will change
 mstatus.VS to Dirty."

ldst_us_trans(), ldst_stride_trans(), ldst_index_trans() and
ldst_whole_trans() will change vector state regardless of being a store
op or not. Stores will set env->vstart to zero after execution (see
vext_ldst_us() in vector_helper.c), and this is vector CSR state change.

[1] https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc#vector-start-index-csr-vstart

Fixes: 8e1ee1fb57 ("target/riscv: rvv-1.0: add translation-time vector context status")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 9e101ab434..044c9c903e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -638,10 +638,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     fn(dest, mask, base, tcg_env, desc);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
-
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -799,10 +796,7 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 
     fn(dest, mask, base, stride, tcg_env, desc);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
-
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -906,10 +900,7 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, base, index, tcg_env, desc);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
-
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -1104,9 +1095,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
 
     fn(dest, base, tcg_env, desc);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
+    mark_vs_dirty(s);
     gen_set_label(over);
 
     return true;
-- 
2.43.0


