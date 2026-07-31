Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABA2C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpakd-0001nV-B8; Thu, 30 Jul 2026 20:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakX-0001l3-ST
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:18 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakU-0001MT-2z
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:17 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso196809a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456313; x=1786061113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sd3samW9J40wMIxnOYVCldYeRZqsZAry6PUjmQXXCDE=;
 b=pCSDqQFmtqU6fh/QEsbzP4HZ8XigweQkBqHPkfubvhSzBnaILK1BGcOM36ZE/NTD0s
 J9B/vyG+TSyzelzQOdgPIj2z7JsKC1rh3pQ8JkZSlEgBpYeJWEQBoy5H7ZhE7PmUZeuY
 fZi4BVYpGalRAnplLZyCBk+ov53Y/wJOreUYs4e0eTITvKh8csLwcx+nUnuRBBLOFfvp
 +J/OMWYXdqe95/Vk5jOu18duPlVllxZq3tPOI/lpWpG9gyN8SOjs41AgN/wj4/ukghcN
 73TOT5qIrOEeEX/ylBcjPoSdFwbMWirbTVQ7ojiHuIlCtAJfnAjxoDf5NE7B/IxW9D0K
 mvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456313; x=1786061113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sd3samW9J40wMIxnOYVCldYeRZqsZAry6PUjmQXXCDE=;
 b=AxhQ6FwbOJfqPqs32IK9HAFaakiqF1d25v+tONa6gDUD1Rq+1b76CpWqZDie9eS/9v
 dH1F4/NKUZ8L8Ip51gGzeWGkUxPr4diVOVrXK/9VB1+mk39XkE5f1cOvgPHp5dQQ9MJJ
 Y1Yt2U1/EzCXrlpm9D76+oAkJcFbziJ8midcNWN7YqAYbhGVi+x4lt4MM2F07FpGcXkh
 VqNZDffYoLSpqlySZpw31rMV+t3+krpIKzFQtxb6GFc6WwShBr29K0NdMFlcguwApGl6
 fvmMzTcD2jz9UkrqlFLheEyLA5Nc8yy4IQ0BZBMKEghhQcrv0tSttiYK4M4FE6ZCNy79
 bHUQ==
X-Gm-Message-State: AOJu0YwXGuJ12EwlDoZqwKUMGknWGKmc3w5rxAqdIoWz/jAfBe3EvlLC
 +la1FFT1Tyjop5XP+YT84nGbNQTfW7CWREJeSDL4nlDhvcTLyDCnBQuxlR5l0yCmfaUk/oFjKSf
 Fx571
X-Gm-Gg: AR+sD123gna/zW+qXNQ+yG64/gj0j+bGQ9Knxm4oK6cur/Chn4cTcvCjJWYGoSk5LRY
 mZkBjkew1woE9VSbtAWsfqTA9Vl87mtozrVg825i58FEkTpLmNIr6fu0UV7RD/H7Udr39krhCFn
 S7HGR8U345sI7ZurCcTYHVtVubJJ+genyF1542zlEOJVJeciOUz3DHUyBMMj+B83p8fAHGVWG0N
 53zZQrgUr66vkJLL9bRuBQF9Z9Q1JNk6sqduszJdfxFQteKQB8aEGpN/qqoWKGoT5ijJqruKnhD
 Bpqj5+JT5c4P4q6g6P8BrZtpaE8/qvknXUsE+H2I2pVVdwEjJ0JKdiLIa+mvZqrPh59kiDChxa2
 sNaFvkH8t0elMw0obSpXlBlBkXfPGJ/BNTuM1rUWyb6AdPNti1f/Ze1M5gdS9rnZEtbTJKUgXpq
 3zf9+GVn45rDvDuThrxwNqfOqnTGZ5r6wT7iXMWBFtuI1aqMwrfcmnnvmxqfyTN3U8PSSd431es
 58UWbvE1cmkY/aB57oc
X-Received: by 2002:a05:6a21:134b:b0:3c3:66c5:68cc with SMTP id
 adf61e73a8af0-3c9006b6c88mr4132191637.21.1785456312610; 
 Thu, 30 Jul 2026 17:05:12 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 09/11] tcg/aarch64: Implement revbit{32,64}
Date: Thu, 30 Jul 2026 17:05:01 -0700
Message-ID: <20260731000503.170446-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index aa2c4e42ed..2622f89880 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2652,12 +2652,28 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static void tgen_revbit32(TCGContext *s, TCGType type,
+                          TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_insn(s, rr_sf, RBIT, TCG_TYPE_I32, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_ext32s(s, a0, a0);
+    }
+}
+
 static const TCGOutOpBswap outop_revbit32 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit32,
 };
 
+static void tgen_revbit64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_insn(s, rr_sf, RBIT, TCG_TYPE_I64, a0, a1);
+}
+
 static const TCGOutOpUnary outop_revbit64 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit64,
 };
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
-- 
2.43.0


