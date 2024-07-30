Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF08C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLT-00049h-0Y; Tue, 30 Jul 2024 05:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLP-0003vB-GL
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLN-0000dZ-Ou
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36887ca3da2so1923382f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332432; x=1722937232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y9IjY/fhNilZFR1VTqsWrhWqxlwIIF2aeXKAohFdZZ8=;
 b=DWnwCkv3JRpt7N6/dYTLrTsCzywUp3qSCHFszcJ+Qvcaf6KNGZE7cil66PUL4dwB3w
 mGaztCpnqfhCdv90swb0PAJtcvCu8DLPa6+Y4lQGvU5hKeJSyShSsruGss5QsJQ0knIv
 5edUihVWhtlgJ31Vyh1iPH+Pp4SWUvp+A3wDhQPfOUgKnp/CidMEY0HmmvV3i4sBVsio
 IIjsB8uSWv/3trp9Jggm3bBu8oA7zNPSVmGjOekdQTeRIZqMI1le2Cv/ljykVWbK2Mnb
 egRgiyTMDpjK+CyQReGIL4A1c3HUJGlgJDc8kNlrUj9fCwNFxewzY1N04ynMb83RcnmF
 abJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332432; x=1722937232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9IjY/fhNilZFR1VTqsWrhWqxlwIIF2aeXKAohFdZZ8=;
 b=aCUQG/xyinJcDP/YZxqXZwyykh1x3BDdUCE0zhippBE0umfMPr2mE2TyjayVfyhhkm
 w1Ig0kh3VFh4e5wLvxQSQcYqkfEHd9qqecorM2lXGbhVCo8T7pm8LJIG1pD8NzBjrUkn
 Ui9vn/vBnL2nUvQ13q6mN/Tv7UpWto3VuFj8N9MdzwXI6kI9oypu7Jp96g8pypOfjlp2
 /M0ggtpCci9InXkgzHQDXQYM8veaqA9Lf3wsU4yzwvWkkc1m3x4ti5HXdB9VG4ClM2yO
 VjjDCsmjIf1l0rY/eW6592O3GBjUK9txlEHlphtA93jjqO3s6zsqSpN79YScf1zY+GL0
 9F1A==
X-Gm-Message-State: AOJu0Yysx+n5yqb82T6a6hla/bhFh+gG+uW69g2asybWf0CLo78p7cEU
 /iNa+z7bcB3CQ3wZR3EWHIp5lpxx/D1P7MrIQrkhX2g8ntVufB8x/1wF/waDOiIEcxxAxaOj8lp
 c
X-Google-Smtp-Source: AGHT+IEfRmKpL1iptkOfHV8ZKKO7OSHt4+cBUuTeiVC/ds4f8Yv39g9b6NdRnG2fnhkcxlJjdbrFoQ==
X-Received: by 2002:a5d:6ac8:0:b0:35f:d70:6193 with SMTP id
 ffacd0b85a97d-36b5d08b2b8mr6428959f8f.41.1722332432253; 
 Tue, 30 Jul 2024 02:40:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/21] target/i386: Remove dead assignment to ss in
 do_interrupt64()
Date: Tue, 30 Jul 2024 10:40:18 +0100
Message-Id: <20240730094020.2758637-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Coverity points out that in do_interrupt64() in the "to inner
privilege" codepath we set "ss = 0", but because we also set
"new_stack = 1" there, later in the function we will always override
that value of ss with "ss = 0 | dpl".

Remove the unnecessary initialization of ss, which allows us to
reduce the scope of the variable to only where it is used.  Borrow a
comment from helper_lcall_protected() that explains what "0 | dpl"
means here.

Resolves: Coverity CID 1527395
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723162525.1585743-1-peter.maydell@linaro.org
---
 target/i386/tcg/seg_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index aac092a356b..bab552cd535 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -926,7 +926,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     target_ulong ptr;
     int type, dpl, selector, cpl, ist;
     int has_error_code, new_stack;
-    uint32_t e1, e2, e3, ss, eflags;
+    uint32_t e1, e2, e3, eflags;
     target_ulong old_eip, offset;
     bool set_rf;
     StackAccess sa;
@@ -1007,7 +1007,6 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
         /* to inner privilege */
         new_stack = 1;
         sa.sp = get_rsp_from_tss(env, ist != 0 ? ist + 3 : dpl);
-        ss = 0;
     } else {
         /* to same privilege */
         if (env->eflags & VM_MASK) {
@@ -1040,7 +1039,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     env->eflags &= ~(TF_MASK | VM_MASK | RF_MASK | NT_MASK);
 
     if (new_stack) {
-        ss = 0 | dpl;
+        uint32_t ss = 0 | dpl; /* SS = NULL selector with RPL = new CPL */
         cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, dpl << DESC_DPL_SHIFT);
     }
     env->regs[R_ESP] = sa.sp;
-- 
2.34.1


