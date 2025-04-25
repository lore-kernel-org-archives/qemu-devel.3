Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05E8C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ktj-0001jH-HZ; Fri, 25 Apr 2025 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8Kte-0001fR-WF
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:23 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8Ktb-0002ps-0c
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:22 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so1597901a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594597; x=1746199397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwV8Ejbv3c17F+/2R9Q76cf7TrkhsGo+NtylDvgP+1E=;
 b=y4T1WAKaY5FQDggR/Yg3D5BwRLn+HBbnlLQcgjwlQz4/nyheUxjpV5HyzBHEVFZS/r
 HAyfLmbj56xnGl2uiZXll3kpRlvACjHIAoXhSQf4D4H49AzUF1Rp+v59FoRuH6l13am5
 r579Vg2roKaYyTkpzNJIaou5Rl83hux8E7ntFAU2Wz37g6etc5jDPlslJ4HHIf9lELvi
 11ybf7555lsAC+0bf5Ojnqm1LnIpttVp379pE4nUOXbVRVNSVLPFeMhDVQvFfKsOijpe
 xJSGHXQY3CzzhBCkiV3fe1qyqG53QMj1eRqTwolun5d3nDaxVw5K78VCD//cIJI6IerK
 50pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594597; x=1746199397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwV8Ejbv3c17F+/2R9Q76cf7TrkhsGo+NtylDvgP+1E=;
 b=AK6LSOR33NoMJVxiD4+DBDljzVG8W+zude16G5stvJIvOlpQPIy+DJQoovimVWtvFk
 TOvXv+GmzsmNwIC5ObD0MlYcv5Ipj52sM53BBZcr8WVPXIANLON5McTRHGxnYGv+IXki
 VrxkoeUuhuShZFMt0Gwr6CW3brE71mR10qoVZxdjVbANoyBkKn3A5mOdwbGVdqpqViDs
 6ykPJWh7aYZlqvsB7/RlGtNhgWMyW6WUaYLrKUlLKoYMM5j3blt/420zYqOQHCZGB8ge
 PKG5Ims+CTK3ojrIK2lJbs7fPlYglZc4hrw2CcwWBSLzVoNorfzOZZ6wO3HFb9/2HCqg
 OhqQ==
X-Gm-Message-State: AOJu0YwcEP1JwU5P0bS77OuU0jEjwNmU081X88n9P5dOme5lN9qTLwcU
 pH4RggT2KEts7vSOZQI3BkNHESIaU0qLGAbOE11elMgXh8zm/j1wUw9MZs32o0RxrhU8elMkDd3
 q
X-Gm-Gg: ASbGnctFqApKPDKmf1HkYDj3mKWz55nfhIeNSEnCqyNR6ZrSVRERF1i/9fX16qQuccN
 rmA0JjgUCXY8mJMOakKCrJ6C1eJQ6H9oTnfQkpPK0XKQL63EjnNDpj4gXhfVurf47TR6DPxk/VL
 9g/r58w38HpuB0AY2C8ie1aq0+TW5SXet48POzsvftddnVnpK73n4f84DYu4XZQaAIuaCtCrbQ5
 nHAMoclIG8qraJcSq1SNJWTDTEYVt43yS5ALmUpDLX0AY1zI+W3Nht/R9MhggCv1N33Jq7LStNA
 +fPuU4r3F4ZVKllXyQ4Ow3yX9XFTctVqdqNzwuLrdgYpTJADYNlJueGO+p4Eoxoe5sPM17S76y4
 =
X-Google-Smtp-Source: AGHT+IE1ljSVGBswwJliWXa0YG8VO7kjEowpQi1dd/OABKviFszBcA03rv2tTtrGNrpOb53un5yt3w==
X-Received: by 2002:a05:6a21:3401:b0:203:9660:9e4a with SMTP id
 adf61e73a8af0-2045b9fa3f7mr3856001637.41.1745594597634; 
 Fri, 25 Apr 2025 08:23:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3390466b3a.106.2025.04.25.08.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 08:23:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
Subject: [PATCH 6/7] target/riscv: Move insn_len to internals.h
Date: Fri, 25 Apr 2025 08:23:10 -0700
Message-ID: <20250425152311.804338-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425152311.804338-1-richard.henderson@linaro.org>
References: <20250425152311.804338-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index cef61b5b29..9836ab8c20 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1210,11 +1210,6 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
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
2.43.0


