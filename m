Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BFBC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8J-00026n-Po; Mon, 08 Apr 2024 13:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8H-00025w-Qa
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8B-0003ik-PM
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:13 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ecd957f949so4618682b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598605; x=1713203405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQO0EY4mDLrrFT+vnkTsVcf/DHsLrdpuFvrCYXf00/g=;
 b=HN0D9VzUmMVQcQOYbHuNjNG/bFxuORjwHnygQjUJ3myFsjkIwszVHyVnD8vg+jckQA
 VdQMIayJ1bOUrn+X39BSaU3Rm873ulUsynaZsn9TaajJZnjG0fekc0cBt8YH1TynzLjZ
 tKsxYS1+bUYgUm4qS3BGIU93gU5qj52Dq0ENfvsPtwDoF5zAparRdiPznoP+Rvb+jt7+
 TM8KvqNaYPee0M9d3HZ9x3o8Cfr/7X5oJ8veK/ZW4TIzomO7WCla1Lb6dpI64kFmi8hQ
 YLhgebaH6wV+pG/pUnk7TBsSdaEq9cZwouJFLpzNyBPCwB5LyssY1raE7AEQtzqoNMAe
 B8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598605; x=1713203405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQO0EY4mDLrrFT+vnkTsVcf/DHsLrdpuFvrCYXf00/g=;
 b=S5+HKCr9cHw+VNRtqRVO40t0RtmBeUuzx6G7a30A2WPzNxkvykU0+Esldc92AdalI/
 LiW0leXt2xurYTotbEQNMWTEP56Mj78qJ6S8BPh9n9mqgnzGNW5T2YljzpsS7hdMTwIr
 DVksHcTJJSV4iPYVEQivSlhW/8G0XtxC5h234cOH0TxkxCW8uShtWC3VcJYcvXCaDodz
 wyke3JJ6waZk/45NiRsCFjksOxXoyNurUVGiUPQom1l2fIOtCY0dnXXnDFlYDdO4unFU
 /AoK2DjrKJMaMsdVfycLo7scDb0UHoN7t0OYsc6APhrLTlVMAFY7lScmlgTXvt9enjqG
 aYkA==
X-Gm-Message-State: AOJu0YyKe6uAya2n5k6COftfPFt4/ImSBgVhoiPIFT7L2liHpSKZi2TP
 dGBfiHQXARM9dJJXJHUgIH7go4OwLxNZUse/jJSmZRJ3csy0gSP4L9N+cHIvE0lQ8P/13R8pED5
 e
X-Google-Smtp-Source: AGHT+IHfsfJg+R60ov7NAi/pS4PQV9laboLIsz5FujWWpC8bOqqq5JzUIaK8Uy2avyKGaT3P+HALCg==
X-Received: by 2002:a17:90a:c24d:b0:2a2:ba1e:92fd with SMTP id
 d13-20020a17090ac24d00b002a2ba1e92fdmr7555019pjx.45.1712598605516; 
 Mon, 08 Apr 2024 10:50:05 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 23/35] target/i386: Preserve DisasContextBase.insn_start across
 rewind
Date: Mon,  8 Apr 2024 07:49:17 -1000
Message-Id: <20240408174929.862917-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

When aborting translation of the current insn, restore the
previous value of insn_start.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 07f642dc9e..76a42c679c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -139,6 +139,7 @@ typedef struct DisasContext {
     TCGv_i64 tmp1_i64;
 
     sigjmp_buf jmpbuf;
+    TCGOp *prev_insn_start;
     TCGOp *prev_insn_end;
 } DisasContext;
 
@@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         /* END TODO */
         s->base.num_insns--;
         tcg_remove_ops_after(s->prev_insn_end);
+        s->base.insn_start = s->prev_insn_start;
         s->base.is_jmp = DISAS_TOO_MANY;
         return false;
     default:
@@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong pc_arg = dc->base.pc_next;
 
+    dc->prev_insn_start = dc->base.insn_start;
     dc->prev_insn_end = tcg_last_op();
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
-- 
2.34.1


