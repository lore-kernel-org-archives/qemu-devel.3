Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D243C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR3u-0008NY-TZ; Thu, 18 Jul 2024 09:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3l-0007tW-4g
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3h-0004So-J9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266fd39527so2759875e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308831; x=1721913631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wNvxFR8UOIk9oR5FQocJEptc0zyJlU6CCgtVFEcW6V0=;
 b=CY3gEDc2u2gGFXgCgKCBko4guwrKfxqbuguDPNj67Q1B6rHSAhK/OWEmEgRce2jt3F
 D+nlias1FoViifEQBs+txtRLrG/pEhBZqGIPYVJ6PFRYTuaN4akbNTY6+gQ3BhAFidAA
 aHlRSG+GzcSSgFrkTy/7jDPvfYORUbhKoJJDSvNwrDR16hemmNOSjtvmEZZ/cGEj59d0
 OVlVQZ3eD7UsjF6vhWFuFoNxeR4TUENSss+Rje38grGf/zzdho9vNG8p9JHM3ea3O300
 hMjkyzHt+CMqEU06Umq3B0auKclhgxBBW+D///wYMSUnni/9QLoUvfUc/XZl1FG5Pusk
 +mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308831; x=1721913631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNvxFR8UOIk9oR5FQocJEptc0zyJlU6CCgtVFEcW6V0=;
 b=ZH2ODQLTXF925/v4QDe7Ck+CZMS1c7LyowfCogS5dpQnA2MV1BfmzCSmXZgPf/YV05
 Nxfif/o3r9nRLgIHhJ/hXxZv/dlkY5CIhA9meC8SOklaegxsm0eyubQc0NIiE1rXbqvA
 hrkdVIq2Q60qaDIqBZctjyvfjxqgZbAtCoGtYlXMOEO9ILeoOtAzAkspnhaykk+kqXLO
 ztVM9dIna+6EkGlvG2RkiCU8QfAq+fDLHMsJXhktFmnKT2XsK0Atcxvy7RM8sbVsh1LY
 0DSrde9YiVa5VemFqU2w8Q6fXQcO3iNhOWtfu1P5vyJKlRQMfCcyTi/YIA9cvEyY0VdQ
 hpPA==
X-Gm-Message-State: AOJu0YzjwUrTKlHUYlPELXgbs0pXoAKJaCzRDMVtSZrKtfQ3RQQZ07qe
 j3gB2xVYyh1JiOpBEHybQ789a1PFlQGMArKiO1LVMFWFJJl2JaiIqNChP2Lbsj6qojXA1SSHzJ7
 m
X-Google-Smtp-Source: AGHT+IF1xFutbpCa7uWIYfL4mMj3x/OouopRK7O0feOcm1g4amWNNgBixXbfyMQZV6c6klDrnYJxsQ==
X-Received: by 2002:a05:600c:4588:b0:426:6861:a1ab with SMTP id
 5b1f17b1804b1-427c2d10a58mr33497605e9.39.1721308831103; 
 Thu, 18 Jul 2024 06:20:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/26] target/arm: LDAPR should honour SCTLR_ELx.nAA
Date: Thu, 18 Jul 2024 14:20:04 +0100
Message-Id: <20240718132028.697927-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In commit c1a1f80518d360b when we added the FEAT_LSE2 relaxations to
the alignment requirements for atomic and ordered loads and stores,
we didn't quite get it right for LDAPR/LDAPRH/LDAPRB with no
immediate offset.  These instructions were handled in the old decoder
as part of disas_ldst_atomic(), but unlike all the other insns that
function decoded (LDADD, LDCLR, etc) these insns are "ordered", not
"atomic", so they should be using check_ordered_align() rather than
check_atomic_align().  Commit c1a1f80518d360b used
check_atomic_align() regardless for everything in
disas_ldst_atomic().  We then carried that incorrect check over in
the decodetree conversion, where LDAPR/LDAPRH/LDAPRB are now handled
by trans_LDAPR().

The effect is that when FEAT_LSE2 is implemented, these instructions
don't honour the SCTLR_ELx.nAA bit and will generate alignment
faults when they should not.

(The LDAPR insns with an immediate offset were in disas_ldst_ldapr_stlr()
and then in trans_LDAPR_i() and trans_STLR_i(), and have always used
the correct check_ordered_align().)

Use check_ordered_align() in trans_LDAPR().

Cc: qemu-stable@nongnu.org
Fixes: c1a1f80518d360b ("target/arm: Relax ordered/atomic alignment checks for LSE2")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240709134504.3500007-3-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 559a6cd799d..148be2826ec 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3543,7 +3543,7 @@ static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
     if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
-    mop = check_atomic_align(s, a->rn, a->sz);
+    mop = check_ordered_align(s, a->rn, 0, false, a->sz);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn), false,
                                 a->rn != 31, mop);
     /*
-- 
2.34.1


