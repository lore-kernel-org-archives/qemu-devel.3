Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A5EE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHzj-00069P-8E; Tue, 03 Feb 2026 10:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzb-0005We-IK
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzY-0002M8-Jp
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so55060805e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131212; x=1770736012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W9A/okJ7C9PIOD8AAAtJFAFWfHxVqk7++w51LEZY/d8=;
 b=sg9rMKavd0KFY82FGroAZeUZTvfh2loVUnvG5THIYytEp2xQan56Y2ibdO80m5pO8d
 xzmXLd1t9UXoJEMzg0XHuouWYP9b8zktZ+0B3qxjN/T5cTARePbZVk+WOLrgldfISVkN
 8NSNst0i6tKbktTEXrJ1HvRev6K/2K1lvG5ItSLcxqKnpDfHT0PsqYhqbeiuQ9BWffQf
 DBqyuyj7ubQkO3+3JJ+qebxE8tBzNgVCzKnhEr+T7UKHI154qiqz57nNBNBPzVKHUKkr
 qhm/meo+41OlR1bCtrH5FUDYAQm2CSetfHQ6uLtzoTDjJCb/HfZnZn81v58GjRUbAfZi
 KUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131212; x=1770736012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W9A/okJ7C9PIOD8AAAtJFAFWfHxVqk7++w51LEZY/d8=;
 b=YyccGbXgZRIgt8pcT7vVm+b7SK283ttPJFYyB4KYcYBzf2dLWOcaLSJCttY66E9XIb
 3bieuyZmZik15iflEVcg2DyHGZEMFnaiUnovc4Gl4hbuUpOST0tPJs2ttzOJSOyCeP51
 NZlTrkW9JDqD2qlNwtM3h8PS9lNHBar/qcxI7+glrHnTDNhl8YIgxHeGTlHKvZX3ZbNe
 y9YkFEa354naZpTbcTWyJtno3jxdp/tU0OnYeMyr9lXwhbZZOkq/p+cSk3ZewouBQjz/
 o7D90s+kEFxOxPCfoPH2NfLSavRIXX5xrW2W9aev/XL2GPm/VleWLziWid9bAEzc0Elh
 UzSw==
X-Gm-Message-State: AOJu0Yy6DBFTRgff4h9EZ9UYbR01BYk87O9AeBr+6JkDmlO+FQ82daJk
 4h0LtrgNqr3TCLZsA4wzaPipDisjpoUSiBgI4gmFs8v6DGLfBP8EM7D2aQW73pFmX+rzJNjUqTv
 OxsjBHa0=
X-Gm-Gg: AZuq6aL/RcN2um/LLqskuCdNbOO6UvoofL6rpo0jAsdy72JycwIIYFbcQPBxghlsMif
 oCLc5ByMQIjqqXMqwJnATzVpzzvv8jRzE0yp+z2LX5pVOKBUIGoYMDzfTB7f8TQXDiLZ0d1bwiC
 xjKzLzji3MMjaDia1SoUddwnyFlW59DeiII1vKCOcmhx1HnvtuBVFw2Q3DkXtjQ9r6KxVd4rBUP
 Fl8pGtM+PRLekLCLnTitBm1a8VrBZF/6Z+o5q5dvjoNUnlB/5/JExsStLF8tRcU8oU3/XRBle9e
 MXXQtOwDzZ8dDQ+NRYmw4ndVyxTTLehgOGInfnR31XwpC1mOFWvoLwXOzWTjeuwZQzYKMRJDB6D
 G/q3keUbJljowXXQbwj3Undxa+gbYfN+X+0q642S29+tFDw18gbQStZVIfCAwtPK77xOoTnLkxD
 u25GWuJ12NdTEFNrVH8xe8ofaAgdolTxh7OuoPjHnCTeRL4jcBc8JD1uzesWIM
X-Received: by 2002:a05:600c:3ba0:b0:47e:e71a:e13a with SMTP id
 5b1f17b1804b1-482db4ee2camr214778725e9.32.1770131211557; 
 Tue, 03 Feb 2026 07:06:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e297119bsm118866255e9.17.2026.02.03.07.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/30] target/alpha: Replace target_ulong -> uint64_t in
 gdb_write_register()
Date: Tue,  3 Feb 2026 16:04:24 +0100
Message-ID: <20260203150436.71907-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On Alpha, the target_ulong type expands to uint64_t.
Besides, ldq_be_p() returns a uint64_t type, and all
field / values accessed are uint64_t, see target/alpha/cpu.h:

  200 typedef struct CPUArchState {
  201     uint64_t ir[31];
  202     float64 fir[31];
  203     uint64_t pc;
  204     uint64_t unique;
  ...
  443 void cpu_alpha_store_fpcr (CPUAlphaState *env, uint64_t val);
  445 void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val);

Use uint64_t instead of target_ulong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202234550.34156-4-philmd@linaro.org>
---
 target/alpha/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 1a7e2dd9202..a7110e8d1eb 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -59,7 +59,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong tmp = ldq_le_p(mem_buf);
+    uint64_t tmp = ldq_le_p(mem_buf);
     CPU_DoubleU d;
 
     switch (n) {
-- 
2.52.0


