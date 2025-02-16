Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9D5C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS62-0007ay-6k; Sat, 15 Feb 2025 19:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS5z-0007aL-3i
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:15 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS5x-0006F8-BG
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:14 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220c665ef4cso48860015ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664071; x=1740268871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g+RwK6s98JtgiT+jYpVwQhAcmDtv3UP3CqG+jw/cwXc=;
 b=OYHIenYciuAPpO8HP2wHj76+a9JaLoCUanZioT6uEZ6ivpINs+Q5COKbrkEWXK79MZ
 5NLeff4nhsvRXCtHQ3rAmk8+MIWc1nq+/RpCFDjbZ46c7hG2+Q1NjgZDnCgB6vgkPgM8
 d5B0xSfI4Jvu10Ny7l94lRe7tYK8r1xISS/vIDhphRCiy8Xil2kL6Umr2HoMwkY0GS1b
 60dshofwjpD5dn8Kv/ozse5Izlm4Fl5IuQTHWhayFgj8eroBHq1Vy2S9GCjhASKKUQ7f
 6u5+2OsjwFXgOvnyqyA1A4zXk7LxxLsD1CfLKuB0yug4c9gmsrZF0nh+QZQ0WyiPRnhs
 GPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664071; x=1740268871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+RwK6s98JtgiT+jYpVwQhAcmDtv3UP3CqG+jw/cwXc=;
 b=LSCLs83fe71tCFxSNX3cnNe9eaiW9OxD6EeKYmnagiMNahq/D88A2aCxWxeBLnmEeU
 Gmdr0rlwMOoSVZprtx7WZ2Vq6pMDA7853ThQcgMFe7ievHmFO0vH+/Z6xGtFzxrTJDJp
 RJJOAQa9Wjz0LGGSCHV6JMHQHakWXDFj5QVUliJyCaeT/B0Y20zlAC5Y+1Lj3UxQJEF8
 9qRSTVJOPJLsHTvPwmT5hhxEw5SztlCRBx4tnivM2/OApKUZsL3PwKVyUkBLQd2cDkx1
 D4MDSIWYk+8hZ9mwFLiNum5DoYRcqPxplVvCTQn6UxfrqtzAK5wpTceabe8t85b/Us1K
 /h3Q==
X-Gm-Message-State: AOJu0YzsxiX8mrpcBGNpe+bOB5HsSgwOXd1AFQvmQiHYzBTj+Mj0fxEQ
 K/s1oWOlcfAqZGzl54RQscv8Wl9m/Vukbllk1NNVkAXzaG0CrN/FaVV96vv/biY7bIAyMC51iWM
 4
X-Gm-Gg: ASbGncvR/CMxGNtFnrIbWrWDT7iiEXADGwv+0ubaYOYRtz49yItFezDqzsUBLzO1d2d
 8/vmcaPiNZ4cPz9Zo18F+ule84xvH6MrBh2Ae9KpjDem4idg2QOS4yKHU8rG1NdtV8Ecc0VJtxY
 o3VNlRn4cqfcg247hf9xHvryIWAXvf7vEeZmoA7DgWsZSx60qGPNYRZyxkn8VasbZY6zFcoxa0M
 ZTVNPltI1QDn4erm8DJxIkT+6/mDjeg8mQRK4JzJB4n/vLOSbgOfPVJrcvdg79xpqbBZzNhGoxj
 60tFLSJKNq9qdrtpex4czWq5eGyaPifTITn2fTQICVohGoA=
X-Google-Smtp-Source: AGHT+IH1qqy/naefC5SCCG+Dyy5fUcz6MbuU8EE4e23tx/+P4cUWhyKe4PqfD+2bKWbtW+LnBPsvAw==
X-Received: by 2002:a17:902:e5d0:b0:215:89a0:416f with SMTP id
 d9443c01a7336-22104058b35mr56082755ad.30.1739664071398; 
 Sat, 15 Feb 2025 16:01:11 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/24] tcg: Remove last traces of TCG_TARGET_NEED_POOL_LABELS
Date: Sat, 15 Feb 2025 16:00:45 -0800
Message-ID: <20250216000109.2606518-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

These should have been removed with the rest.  There are
a couple of hosts which can emit guest_base into the
constant pool: aarch64, mips64, ppc64, riscv64.

Fixes: a417ef835058 ("tcg: Remove TCG_TARGET_NEED_LDST_LABELS and TCG_TARGET_NEED_POOL_LABELS")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.h | 1 -
 tcg/tcg.c            | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index a9ca493d20..bd03aa1bc4 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -72,6 +72,5 @@ typedef enum {
 } TCGReg;
 
 #define HAVE_TCG_QEMU_TB_EXEC
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif /* TCG_TARGET_H */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 43b6712286..53de13df71 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1598,21 +1598,17 @@ void tcg_prologue_init(void)
     tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
 #endif
 
-#ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
-#endif
 
     qemu_thread_jit_write();
     /* Generate the prologue.  */
     tcg_target_qemu_prologue(s);
 
-#ifdef TCG_TARGET_NEED_POOL_LABELS
     /* Allow the prologue to put e.g. guest_base into a pool entry.  */
     {
         int result = tcg_out_pool_finalize(s);
         tcg_debug_assert(result == 0);
     }
-#endif
 
     prologue_size = tcg_current_code_size(s);
     perf_report_prologue(s->code_gen_ptr, prologue_size);
-- 
2.43.0


