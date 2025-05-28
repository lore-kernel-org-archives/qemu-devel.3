Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AE0C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKByB-0002Cg-PS; Wed, 28 May 2025 04:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwO-0008NC-BZ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwE-0005KR-M8
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so54819115e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420091; x=1749024891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FicFVtTidumCbshSOZECWTGWhp6SCdWIg1qF5oag2Hw=;
 b=ve/uq9FYet/ZZT8+FO5I+5nVtWMonENdakJsbP0cOqchfnRnJz1cBeFUoRPZ7FhDaA
 3lJaid4VJ/1X8SAm5QZN+2QWEvKfIbBffCb5kv70Nj8fsrw93Qav1yIZZYyItSO8vwpX
 oCiLGg4gplOOXJUUt5AEWslQMCW2eyo5ABbMspfP1Mi514HePNAB4ivUWWpXPlLWXCFA
 XomfUZ6AMHu/xFLAjLmGcujVJ3y9234N6wyREyo2g17i1GjY2sFi2ImjWwIHarXTMsFs
 3mp1j2FPiq6LsxvpQWo4frpR7I/WQ5fUXgXZAUkCjW8Sd6qP56Or+D9xTPTS/qlD2zJU
 4orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420091; x=1749024891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FicFVtTidumCbshSOZECWTGWhp6SCdWIg1qF5oag2Hw=;
 b=sal5yfjOJ0lm3bcbYAledj1m+r8ks7Lj/hdH2H3oV8Um2R+nEcHRqH+xs27MNjZMEM
 8/u3jtunuWjFRFLXms5lUNdT3Vk3S/3fZybEV5y8xiiewZtM2SPKpXCtWKW9XZpAY41Q
 D+eJYZebYb8PAugfbzHtc+f/M9rrpXm69wHZ1+Dnhb0RTA/79J5/tUONwgnqozZY/9DA
 tIcftRwi/WXEzqPWkgE+6bC3oUqkBKkm3rgzVfcE/IghEv+R0GogInDLLMN1+ruufp4k
 Ld4iBAigwEnD1Gi+HWXy79CTpkRkGh62fprJLq4WmzA12oEh88/VZXd6JZhlvJEfTO1k
 IuUQ==
X-Gm-Message-State: AOJu0YzAaZ5nff6Bky4Nkatjuy2zgATRjjeLjCuyEsBGXaqTnto26wgF
 qZtPBZ6b+J6kLHWhmRF3IZV3Kjp7qehKtDacTGkYPENiRhiYLG+DuGenlu+BigVRFP2XPsM/odI
 UFT9qXChe+g==
X-Gm-Gg: ASbGnctjMwEeDtTM13H0mh33bF7p6Yv5C1JE3lbXZecKbrgOx/p5cmGaqx1+Tid/NFm
 YJMgl1n72Px+QBARMTP5VsWdqERndt75Dla5Ms6g7av+2BDeVk4TRDx20yB95WjGSRTbSAZJ9E2
 lxDXXFacnNlOrDKGGjaWGSvysJvmMPSUqLEOHV22EOC1RWoJlyhrovYhSA+eJQRGzFGR4OgwO4q
 AnyCtHW90aOXZ7/396Rcyqh00D3t1qYVW1O2BpEzNatQIhu6JWiNt7pP0/Iiz2evpLQrh7PuVdG
 tzNAtCjYrW08AT3VP21UNHnMCX9kh49f1GnRJxVp1RNl4xmrvwivDARn
X-Google-Smtp-Source: AGHT+IHo5ewz5hLTGfzugL9r70kwsnfcWNtMLb9irQYw4DAdLDRrINJ9IkThtHFUFM985gibBpJHgA==
X-Received: by 2002:a05:600c:a46:b0:442:f4a3:9338 with SMTP id
 5b1f17b1804b1-44c92d351ebmr120968745e9.21.1748420090917; 
 Wed, 28 May 2025 01:14:50 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/28] accel/tcg: Assert TCGCPUOps.pointer_wrap is set
Date: Wed, 28 May 2025 09:14:10 +0100
Message-ID: <20250528081410.157251-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

All targets now provide the function, so we can
make the call unconditional.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 1 +
 accel/tcg/cputlb.c   | 7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index cc5f362305..713bdb2056 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1039,6 +1039,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
+        assert(tcg_ops->pointer_wrap);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
         assert(tcg_ops->get_tb_cpu_state);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a734859396..87e14bde4f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1773,11 +1773,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         l->page[1].size = l->page[0].size - size0;
         l->page[0].size = size0;
 
-        if (cpu->cc->tcg_ops->pointer_wrap) {
-            l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
-                                                             l->page[1].addr,
-                                                             addr);
-        }
+        l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
+                                                         l->page[1].addr, addr);
 
         /*
          * Lookup both pages, recognizing exceptions from either.  If the
-- 
2.43.0


