Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B57C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBy7-00023U-Q6; Wed, 28 May 2025 04:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvn-0007wj-E3
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvk-0005Fx-Df
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso32661645e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420071; x=1749024871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24Z9qZttVNWxMs/+PWywvUHFCg2sjBAovcSVb5esy8U=;
 b=R36klxvD2FkOwrAc0N6f0F53E8zPZqSwkw4CeVIoQF37Cz0zbMFMpm3GwsQt0kJ6AW
 NCR7auWyKsXo3ulbYSZm61ySBdnYvAJLRNj1HlBKm1P9yJ0wQJlRMZLxOrH5qr48S1Q5
 DYW+6wtgq94OxlfBsq9HSssbin4Vr8HX/EkvE6WFaANF8gcqVeZe2nUrA+wzoRiCgF/e
 Ypai9vwl+6Bdm0cWcOG6adVvsle8swkSeVl4i9Y5H1okSd45/qu3AhRs4OwxQXsqJAEj
 u4bOUNgUiELlrKYr23LxGxOUurFuzpKilhfZhzQxN4aprPuYDbhAYxw81/3ZT6KiFEBt
 cRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420071; x=1749024871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24Z9qZttVNWxMs/+PWywvUHFCg2sjBAovcSVb5esy8U=;
 b=bXrGq/BgHONhRgw8t/nA2CFpHShCkCjhN6F88Mrd1y0qi/h4wQoLiyx4V7lPF8pdXi
 UV+rlG/MMWFkicor2iq8Fl+nqK+sx1LbIjbJIgOJQnVQBvRproY8n+g/3JDjS5tDExVB
 UVgLZNVd/Ull2JYeq31Gz12gl4QqkDPTCsknX7AVEukLOUQQ38aEOGNwnpwrwB1ltDv7
 OvHAdrMPkoRKYKZceROc1kCG0HXhLfkscFZCnc7AoQ1wSzZCc0ZEjuVoSExeaIA5Fu80
 8foA3UYzE9V2ogouWULrhQCE9Qa5Vfl2wax12PafN4eQrIeJHOhbqSqGwT0faZqSY98e
 LDgg==
X-Gm-Message-State: AOJu0Yz3fgxRsKiOMcVmbBE/2Ed26BVGlTBGztw362O3GvZVHCGmxgY9
 Qi6oRYkc1+hA+K9qMFQL7anyYXpnUoGmfVFwUlwd/+yxsSFDWApwrGHWCXrIdxnwg529L9LE+MC
 aF3tMOb/1uw==
X-Gm-Gg: ASbGncsezQDy5on3ZhTpamwJB3fkJRSHGK9bTypfdAJhTAmxPUP12QgugTaC9yz5sPs
 IgZAtNfAUIllc0wIMzYRna8PDwPo3NfVYnllZfs7NpvlEYvYErwQ/nLPkeC4DaBML5MTjxCaTP1
 HN/4UjWPiacVNxmLO3nEqwIa88Sjt6l0K0VUyNzviW9oOWV8g0ELw2jADG6V//kK8X2WgvkFV1F
 EFVwrhFBbBK24dHLzIwk/vZ4oUFK2CWjmO/+7XqpRIlM6pKOLC8pFPPL/y4OL7i+UBakMEalw/7
 LpdyaIvkm4T5z3szUwfGUXK9hecg8S+CZOcy2HpJUBQVSxU9u1NLIAkd/syVTs+gq5M=
X-Google-Smtp-Source: AGHT+IHfSL94IlArbaXryosStBTGtaQkIY1D+QQsOcGEVMTtuKmrA+SfD6EplGL9A8vh3pKtuh+2xA==
X-Received: by 2002:a05:600c:1d15:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-450725458d3mr8625225e9.7.1748420070554; 
 Wed, 28 May 2025 01:14:30 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 13/28] target/microblaze: Simplify compute_ldst_addr_type{a,b}
Date: Wed, 28 May 2025 09:13:55 +0100
Message-ID: <20250528081410.157251-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Require TCGv_i32 and TCGv be identical, so drop
the extensions.  Return constants when possible
instead of a mov into a temporary.  Return register
inputs unchanged when possible.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 047d97e2c5..5098a1db4d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -606,19 +606,18 @@ DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
 static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 {
-    TCGv ret = tcg_temp_new();
+    TCGv ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
     if (ra && rb) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_add_i32(tmp, cpu_R[ra], cpu_R[rb]);
-        tcg_gen_extu_i32_tl(ret, tmp);
+        ret = tcg_temp_new_i32();
+        tcg_gen_add_i32(ret, cpu_R[ra], cpu_R[rb]);
     } else if (ra) {
-        tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
+        ret = cpu_R[ra];
     } else if (rb) {
-        tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
+        ret = cpu_R[rb];
     } else {
-        tcg_gen_movi_tl(ret, 0);
+        ret = tcg_constant_i32(0);
     }
 
     if ((ra == 1 || rb == 1) && dc->cfg->stackprot) {
@@ -629,15 +628,16 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 
 static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 {
-    TCGv ret = tcg_temp_new();
+    TCGv ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
-    if (ra) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_addi_i32(tmp, cpu_R[ra], imm);
-        tcg_gen_extu_i32_tl(ret, tmp);
+    if (ra && imm) {
+        ret = tcg_temp_new_i32();
+        tcg_gen_addi_i32(ret, cpu_R[ra], imm);
+    } else if (ra) {
+        ret = cpu_R[ra];
     } else {
-        tcg_gen_movi_tl(ret, (uint32_t)imm);
+        ret = tcg_constant_i32(imm);
     }
 
     if (ra == 1 && dc->cfg->stackprot) {
-- 
2.43.0


