Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB42C54756
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3q-0001AA-Nq; Mon, 19 May 2025 00:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroM-0007ao-1N
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroK-0004JV-7n
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-231ecd4f2a5so18044905ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627746; x=1748232546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hd86zRGeQ+HNxBDexFTf6eP4HL08/wwze9zOl4z9vq0=;
 b=GCaIygWFzoiqQ9h9gaiVe6Zf6/GiXf2WJMKpI3dxfAbDbs5ecL+pf+11LGbzY6IcbG
 Q2cbMej51SwsdH8p7/MiPKA5qzHXk6iLgiyBOqi3uy03t7VfseY4Qts7JZjbmDkqg/au
 Ag8hwq0EdVlhNX4cXxXVG1citRBvFYZ4C9qAZwiL8I/cLPU/5946An+L4O0jvnL/ieB8
 T0SvvGvIgnFswXDRPp38iWUJ8/hCiSRdEBw6oOoks0liLKEgFvHlc6RQWkmlWbk/wptp
 kcsoH3bfjh2LvYmNdwnIzyMjr5uvAjE34QfJka1v8pGp7il6FyPg3CUNF0TzwxxJmAyz
 HBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627746; x=1748232546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hd86zRGeQ+HNxBDexFTf6eP4HL08/wwze9zOl4z9vq0=;
 b=S6F+BSPt1H8DYF3IxHox3miygkN5dzn2TPwktnPmmy+bCx0+ml2BmxL4w64IqNvGUG
 YsyLRBPuch3/qfXFl4Zb94i9Yan9Th7RY61C+HEWQ6HoLSJFmcvGripeR5OC0Jw7beWV
 9snF8wEQ8n4AyI7gU80kpxjjc9ybWF8jrY1R/ge2C1tVpcT0SWdjBNfkr8UHZIAIU14W
 djfAw6x7USCd1lrzX7vBhEMxMfNQjvjMGYiMJ6OkrX5WMFkr/11gPvNdntWvDsg0Pxe4
 E6xnLOhT4yj1Z3rAJLzZnpoi+tkqqQYF2B8CSotpUf7GtktROBS7CwBILS5mrJWBxki1
 QbjA==
X-Gm-Message-State: AOJu0YxJPruBfzzH2oayIzxEhg7XDVYdQywwNUF2LgBqVgulFGTTVYUK
 9CslOCtl8KCgo9H0Xq4qV/yfyCNLsI9JWvaAU+G5Xg0WvX3yjqsR2prLscS1uQ==
X-Gm-Gg: ASbGncuFJ1jheQhYgsATsyHhf0GhgeMgDA8YpiLmJs/e1T87C8SPYNPIOY/0naS1Z49
 y3Lx/JzzltjUQjzA1sJssxeHVPwaGL2tpX1Fp20cJCsNs/edVIZdj9krycEI6cUNtYbcpTJsc28
 hv9csDGQW2JbeWjNyJxORvYZN9JHItz2LFuRen+UoORLPJCrSp8DG7HPo2cQB5sILpRgnL70sL9
 1B50WlmMOqnSKdYl3FgsLXBllEqkK8ZWWzjRitIphlSSl7RiZYAauFCCyIowmB38Sdjf5SmYEti
 M3ApR+//A0PLRWqHttWtnHXDj7hPkZY/x1KsUHmEKBbThYnoxc/qRrhYvkSRxqZPcpFuOR5BXsn
 tbWhS2kFnUPTEjCmJEpxYySzqTM5Ij/gyvIy1UGRJ4IukP/uPvmjN1f4a
X-Google-Smtp-Source: AGHT+IExn6Zo8hkccVopuf488SsS8qbN/nnY6jci+Js8vzAP4fktO+nQq6wxVSzc/3WCWHrJWXmuLQ==
X-Received: by 2002:a17:902:ec89:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-231de370eb9mr154482585ad.34.1747627746512; 
 Sun, 18 May 2025 21:09:06 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/56] target/riscv: Move insn_len to internals.h
Date: Mon, 19 May 2025 14:05:34 +1000
Message-ID: <20250519040555.3797167-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250425152311.804338-7-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 5 +++++
 target/riscv/translate.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 213aff31d8..4570bd50be 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -201,4 +201,9 @@ static inline target_ulong adjust_addr_virt(CPURISCVState *env,
     return adjust_addr_body(env, addr, true);
 }
 
+static inline int insn_len(uint16_t first_word)
+{
+    return (first_word & 3) == 3 ? 4 : 2;
+}
+
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 85128f997b..0d4f7d601c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1209,11 +1209,6 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 /* The specification allows for longer insns, but not supported by qemu. */
 #define MAX_INSN_LEN  4
 
-static inline int insn_len(uint16_t first_word)
-{
-    return (first_word & 3) == 3 ? 4 : 2;
-}
-
 const RISCVDecoder decoder_table[] = {
     { always_true_p, decode_insn32 },
     { has_xthead_p, decode_xthead},
-- 
2.49.0


