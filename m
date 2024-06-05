Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E4BC27C6D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydn-0001of-IX; Wed, 05 Jun 2024 17:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydl-0001mw-2z
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydj-0003sG-Ak
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso210366b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624670; x=1718229470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJzmi38q+GE96I1FHP0E4aXEZS/NWY1bJp2mUSc+6HE=;
 b=fJ6IfiFzNTDz40pd2IYMLQG3JVH18NkcV3tkkbKt4g3+AwBq/oT1lZo4DOWpYLS5zm
 aw0zDVJDXrbNOPSMtmWWaPOQdyhLgdTm7y/1p/bu5tGdjI4ElLVeUHh3zXM5IWen5gF9
 XCRIpkoK/4s+2SBIlZoRsbuaSa+0r9CpuFoQbdcAGr6PaunD9QJGl35ND/MQvABMeGB7
 JAmSw1r8aHnaKoqqcOBOws1D9CXEhBDa2pbDkJHdZxXQ1kiLNGf4VS79fOKLOVzkVUEP
 fNx15Uy3S04NkV3R6Ibnvlu4zVVT5nl7QkxNnaCx93YFnZmf3v8yBNPirdVcbGSc60gS
 gI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624670; x=1718229470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJzmi38q+GE96I1FHP0E4aXEZS/NWY1bJp2mUSc+6HE=;
 b=iowHanm1/8CaPaAIph92dfH+irobNSgytJp/NLgSyinV00yUo+Dco+gSN6WELojWWK
 4SPOHt1S31FOHu1ra7t8zfirZoYqzxPQ23zWKnc9LgTvkslX97/b4DIFvcGol/v/2DN9
 FlavJ+LuSQk4VSyC7dI04ZL09DCb+x2PqLSB11fdNK0w7YdihUOQPMm8AAsrQhMDlzVn
 albfdlFmLD6tL7nj4Eo+xDl2D2FnrRylTkHePs5TprFk8jFF+Uf/Kmj52aNTbUxyphKU
 Uspr05MHJ2n7ViCTy77HwvLKsHfuDW8BmPrXg4Zk02L4i9IbWd9rgjdLMegNqrDK9B8a
 YAug==
X-Gm-Message-State: AOJu0YxkCBNW36/capWsrRzAqWMb8g6rL8ZJbUF0Yzph3Xqv5tesg8ht
 LF4xUwDw9lPf/laUIwByviR93pi1Pb486L1xZ8gcQwWtSVTp/cl2P/NPhLhIqFLOvHN1qyPsSm6
 s
X-Google-Smtp-Source: AGHT+IESP/KWYAEx0xhbeFgL0FPCDyMqM409hRmg5QRG1n+7pcbaB3RiQ2RkzkZpbr8O9X0ECinfzQ==
X-Received: by 2002:a05:6a21:6d96:b0:1ad:a8d:dc6d with SMTP id
 adf61e73a8af0-1b2b6e2d23emr4542636637.8.1717624669903; 
 Wed, 05 Jun 2024 14:57:49 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 09/10] target/s390x: Assert masking of psw.addr in
 cpu_get_tb_cpu_state
Date: Wed,  5 Jun 2024 14:57:38 -0700
Message-Id: <20240605215739.4758-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

When changing modes via SAM, we raise a specification exception if the
new PC is out of range.  The masking in s390x_tr_init_disas_context
was too late to be correct, but may be removed.  Add a debugging
assert in cpu_get_tb_cpu_state.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c           | 6 ++++++
 target/s390x/tcg/translate.c | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 2bbeaca36e..c786767bd1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -358,6 +358,12 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
         flags |= FLAG_MASK_VECTOR;
     }
     *pflags = flags;
+
+    if (!(flags & FLAG_MASK_32)) {
+        tcg_debug_assert(*pc <= 0x00ffffff);
+    } else if (!(flags & FLAG_MASK_64)) {
+        tcg_debug_assert(*pc <= 0x7fffffff);
+    }
 }
 
 static const TCGCPUOps s390_tcg_ops = {
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 3014cbea4f..0ee14484d0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6409,11 +6409,7 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    /* 31-bit mode */
-    if (!(dc->base.tb->flags & FLAG_MASK_64)) {
-        dc->base.pc_first &= 0x7fffffff;
-        dc->base.pc_next = dc->base.pc_first;
-    }
+    /* Note cpu_get_tb_cpu_state asserts PC is masked for the mode. */
 
     dc->cc_op = CC_OP_DYNAMIC;
     dc->ex_value = dc->base.tb->cs_base;
-- 
2.34.1


