Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA660C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5H-0003pv-O6; Fri, 17 Jan 2025 13:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5D-0003kI-RJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:39 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr58-00004w-NU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:39 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166360285dso49851225ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138513; x=1737743313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OmaCO2bufcDc4uzKJ+mlpKa3QcKVund6mv3MhkLwck=;
 b=Yy4TVRywzbFuyeYccvZjqe6JSWNq/1HsI3Vwyi/WeZ8DpKdZeW8tY4r1R/juuG9g49
 j4EzLm+kxJasdu3Kq3XZvS5hNZYJSd1EjwKFj1OAJ3vO+qryxhvSHyR9KUzlWYqS4RMX
 jgNiHEgRMGwEBSTYuaoSqKxU9FXyrvw5PqUxpfMG3KhAo2+xk11KVELaiM2K+wefprn0
 HVq1aQBKPmIf5skidhmf6PRZ7U4xFQwv+dMkGHJggOwdxQLHooKBqpWZgMVNjU0GmoGe
 WB1lsQwAJj9fIpILZT0vpxRWWUgBq5PM8B0s6YMplwCTbsPtM2WdXq+C+EzI5dsqALYc
 YGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138513; x=1737743313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OmaCO2bufcDc4uzKJ+mlpKa3QcKVund6mv3MhkLwck=;
 b=tboOCuXpB/XM7oJv2fPv7O1aaszjsNJL0ROTpSGJrzZeI43LACufZmyrXhkS0epBpr
 4QGiSFY8O1nnuoWCQFLxBCKatfHjkruBi8t46Y0l9C54FkgOst5yI1wg9N/kpj0Cvpgc
 DagiBfy/NVrDvit9rTB1IWzv6xDE2kUjeyCWmjBRB7MYIgBFIKA9mvvDDatWA2t8fNJp
 mOOUm4vKPrkUfxfSPsdxDU0vyw6oPsb1xW1ThGe+LPKPieFSX6s4Pd9K2sx9WBTVmlp4
 XWjVjMMRyj5ywMH6+b9yTT1l3Q8m4oeCsDEQ6zmco22TKXY/VF5xHmgCfAPes9Dnpf/A
 zdVw==
X-Gm-Message-State: AOJu0YwFXIcoGI1rYN0aMjzStWDwM4YScggn942TMJrcEey1wewp7dvx
 hte3rrG+Sxq6L1Pg+C1oalgTb96AbmyXSXN4PL9CSmcsmBhSV15FFWnYy71Q/gZX+OR4qvZYmya
 j
X-Gm-Gg: ASbGnctUeM8OyO9jqiJncV5fI8IffelYhMC7WHVAs1zFuXw2BZEkczPS2HLGjvf4kyy
 tRuSkl7ONWtKaIpRxCwxw1en2Lu+JQzu1dvC5Bwlv9OV7ACIs+nK6dXeO/DppsjNmGM7+7rk9QZ
 41T723bc/ocUqEBv3XEjC6soRxfaAPm7FI9uL0/0b+s1nw0b2q6W553YDLItETy65O8rwRK1wcS
 QZ/als7FL/kmpOqLCNtINuvt4I+oB0u2EVxxsAQTsq4VrsFwxAy3nwHH/Kyx//33hGhBDW2sjMJ
 hMw3h+TaAL6cFyo=
X-Google-Smtp-Source: AGHT+IHE+0h5bqvuewwHidO3HxPF0ThyzF0xqA/na5A3N+gHswbF9EFGXb6PsyuXxuZuj1uqTYABGQ==
X-Received: by 2002:a17:90a:da8e:b0:2f2:3efd:96da with SMTP id
 98e67ed59e1d1-2f782d38a48mr5620633a91.24.1737138512849; 
 Fri, 17 Jan 2025 10:28:32 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:28:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/68] tcg: Add TCG_OPF_NOT_PRESENT to opcodes without inputs
 or outputs
Date: Fri, 17 Jan 2025 10:24:28 -0800
Message-ID: <20250117182456.2077110-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The br, mb, goto_tb and exit_tb opcodes do not have
register operands, only constants, flags, or labels.
Remove the special case in opcode_args_ct by including
TCG_OPF_NOT_PRESENT in the flags for these opcodes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h | 8 ++++----
 tcg/tcg.c             | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 14aff6e7f9..724e7a9de8 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -33,7 +33,7 @@ DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 /* variable number of parameters */
 DEF(call, 0, 0, 3, TCG_OPF_CALL_CLOBBER | TCG_OPF_NOT_PRESENT)
 
-DEF(br, 0, 0, 1, TCG_OPF_BB_END)
+DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
 #define IMPL(X) (__builtin_constant_p(X) && (X) <= 0 ? TCG_OPF_NOT_PRESENT : 0)
 #if TCG_TARGET_REG_BITS == 32
@@ -42,7 +42,7 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END)
 # define IMPL64  TCG_OPF_64BIT
 #endif
 
-DEF(mb, 0, 0, 1, 0)
+DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
@@ -193,8 +193,8 @@ DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
 /* There are tcg_ctx->insn_start_words here, not just one. */
 DEF(insn_start, 0, 0, DATA64_ARGS, TCG_OPF_NOT_PRESENT)
 
-DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
-DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
+DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
+DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b9119a1ec7..e9ecdc5eeb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3371,9 +3371,6 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     assert(tcg_op_supported(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op)));
 #endif
 
-    if (def->nb_iargs + def->nb_oargs == 0) {
-        return NULL;
-    }
     if (def->flags & TCG_OPF_NOT_PRESENT) {
         return empty_cts;
     }
-- 
2.43.0


