Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E585CD128A
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 05:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsykI-0002q6-OA; Sat, 06 Apr 2024 01:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykG-0002pY-Rz
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykF-0006I4-A5
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ecd957f949so2683446b3a.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 22:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712381857; x=1712986657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcrZGxEnfZgrLqlhciK4hABUGUNHIg16hIoNjeHOda0=;
 b=U3EGEHfvNDT7eFspbsn90ONUSk29KRfcTAPYh5jfE/v1k6mgFSNqiKoCR2AsOOeZid
 5LjaBlQsPOrgfFUfAEzJcIVa+g8OKPJyE0yWH1Nf30WUBR3oIOvRhIMz+gnrMrr186Gn
 uBKXQxLKnPn57rQYu9y71v7TsNc4KPtnv9GFZ4K+B/m08W6eJhKdodGu7G/kdFZV1pqV
 PEXWuAXzh2L7ZynaJmgSTzQsiAlnDyf4hr82QC4KrdEioTUUuSrp763BryTK373VMlmM
 9sLQ7tYKqALWmtBtGjAgQp0XoDv9dGod3XaLHFyZf4UDOhEwBiU91pItA2yqSzMsLC0M
 acog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712381857; x=1712986657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcrZGxEnfZgrLqlhciK4hABUGUNHIg16hIoNjeHOda0=;
 b=GlYg46P1zjYAUx4QxjsX/dtSIaSkXduPqgd8UV1t1YG9cOT/Mfjzxy83aNSeoRlPP0
 vg/T+9pEWTc6j6HYiEKZiR17jbCyFsYnQ/JdrL/Uuv7DJ4gTrNvlUPibiOTtO7xquLsd
 Z9M97HaZdkEa17xrdQjmsPnXplMgZIYWR1d4X179Cb2VpjaDH8vZ9EWXvNGxEb4FlBNG
 ql0B2WyHNOBgR8KISH3j0dZR38chft+edmbovYjRwkXkcULjDTsFunHd2knN/kckF+i6
 5Mr6Bj0tfBy6kIRWq0UXSJLHicZ0ZLcm1ANgX2jn33dMouhHL8uy91xgwr4ZVL8CV3u6
 fEtQ==
X-Gm-Message-State: AOJu0YzClfgOmb8K8qoqtbTl/4CQg2wtu36CkKBnkmvTyOAm28h+kqxd
 /Jr5AtrD7k0X7pSINZA1pS+PxS9V+p5qedjeo1P8BGdGPtD7k1F3+WYJRr28SmjEKyfkHWKSzGJ
 M
X-Google-Smtp-Source: AGHT+IGb9xtHYEpC8CnsVCqkvL5yaPk3nOZlWmBsZ3LQ3y0KFlF1WOQ6DOy0wGqxncnKbtfNcadbGQ==
X-Received: by 2002:a05:6a20:6d94:b0:1a3:d60c:4889 with SMTP id
 gl20-20020a056a206d9400b001a3d60c4889mr2909796pzb.56.1712381857428; 
 Fri, 05 Apr 2024 22:37:37 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001dc05535632sm2589378plh.170.2024.04.05.22.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 22:37:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zack@buhman.org, peter.maydell@linaro.org, ysato@users.sourceforge.jp,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/4] target/sh4: mac.w: memory accesses are 16-bit words
Date: Fri,  5 Apr 2024 19:37:29 -1000
Message-Id: <20240406053732.191398-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406053732.191398-1-richard.henderson@linaro.org>
References: <20240406053732.191398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

From: Zack Buhman <zack@buhman.org>

Before this change, executing a code sequence such as:

           mova   tblm,r0
           mov    r0,r1
           mova   tbln,r0
           clrs
           clrmac
           mac.w  @r0+,@r1+
           mac.w  @r0+,@r1+

           .align 4
  tblm:    .word  0x1234
           .word  0x5678
  tbln:    .word  0x9abc
           .word  0xdefg

Does not result in correct behavior:

Expected behavior:
  first macw : macl = 0x1234 * 0x9abc + 0x0
               mach = 0x0

  second macw: macl = 0x5678 * 0xdefg + 0xb00a630
               mach = 0x0

Observed behavior (qemu-sh4eb, prior to this commit):

  first macw : macl = 0x5678 * 0xdefg + 0x0
               mach = 0x0

  second macw: (unaligned longword memory access, SIGBUS)

Various SH-4 ISA manuals also confirm that `mac.w` is a 16-bit word memory
access, not a 32-bit longword memory access.

Signed-off-by: Zack Buhman <zack@buhman.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240402093756.27466-1-zack@buhman.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index a9b1bc7524..6643c14dde 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -816,10 +816,10 @@ static void _decode_opc(DisasContext * ctx)
             TCGv arg0, arg1;
             arg0 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
-                                MO_TESL | MO_ALIGN);
+                                MO_TESW | MO_ALIGN);
             arg1 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
-                                MO_TESL | MO_ALIGN);
+                                MO_TESW | MO_ALIGN);
             gen_helper_macw(tcg_env, arg0, arg1);
             tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
             tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
-- 
2.34.1


