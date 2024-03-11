Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB4DC54E67
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjgBa-0005ED-6Z; Mon, 11 Mar 2024 09:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjgBL-0005A4-UN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:59:11 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjgBK-0003bx-A2
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:59:11 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so3687329a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710165548; x=1710770348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=N/UVGD2pM/qw2DyZc0j9TsrB5jZ19HEEkkuHJyadQbRDY9mleM6EVK2s3od73gY83H
 NkDyKGQndNKb3DtxhNAjm1vntcfy+DOMqHawm5W7MklHTym+3oReY9UK7lY0rY6+iM1j
 DotRO+U66WWeKTsXoAREnH1pfAvxaVTzudZ9KU9dPdJdMEhAIXBO/JjESD1k2PiTNA50
 bP1YjwZ+J0y1V6Myy1v0x+kqOvbE+2Cu9o/sJOS0BfqzBPyHhU2a64f+QuWwcNxGyxz5
 eQUPEr5zhYiXqd4Jk+G4bxyoOVD4gal3+7bsYbAvzMumjS1IB+hip4t8LFyHkiqHRFCL
 zX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710165548; x=1710770348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=KXpxm8jUiM3Md485jf75XJUm/70BJ8tdkAjLa5G6gLr5XNHzQ9SDPsBXPezMz7LOe5
 agQmMtECLoEqdlGwBEFBwM17hQ2u0Nxg6v44mybdrfnor4QF6rbd0EL87+yFvMLArZqm
 7s0GCB1mTQAGbAERJJcHAqxbDsdsAaFIEDyAFaq6eMgHdMleNv/d8LVVjAUPf5u3Rar/
 tOojPn+GMZTnuADscgw0757NxbMnntMJ1f/vaQUF/YRDObWYKuKt1VBCvyxfMRmbashu
 7xMoKn62Q49Z8yKaxr3VEzWH2iKxsBijyIeAo7Bzl9llWM8iFTmfCd0uQrNjya65e2Gs
 TP2g==
X-Gm-Message-State: AOJu0Yyc+kDCQBe9vxVxVOalybaxZI8Fem865Wr8N+aN2sTttYdIrbBI
 cJnZEUpRkv0nyWAy++APGGOqpzEXU/ScrRzpItYv0UTRI7M9f4uoNayIc2kNqUx8TAYJG80FERl
 p
X-Google-Smtp-Source: AGHT+IETVT0UDqgwO63GGjCDlmdvM/j34+YEwKBmBsqum4mn0CF6PTKEIn09KvB0ZUym4bti1O4rYg==
X-Received: by 2002:a17:90a:9483:b0:29b:b9ef:7345 with SMTP id
 s3-20020a17090a948300b0029bb9ef7345mr4832350pjo.26.1710165547934; 
 Mon, 11 Mar 2024 06:59:07 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 nm3-20020a17090b19c300b0029c12fa64b9sm1324920pjb.4.2024.03.11.06.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 06:59:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v11 1/7] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Mon, 11 Mar 2024 10:58:49 -0300
Message-ID: <20240311135855.225578-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240311135855.225578-1-dbarboza@ventanamicro.com>
References: <20240311135855.225578-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe56c007d5..ca79571ae2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4781,6 +4781,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.43.2


