Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9404CC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RB8-00042p-5R; Fri, 25 Apr 2025 18:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7X-0004lj-Kk
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:08 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7U-0001Jl-Az
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:07 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b0b2ce7cc81so2727694a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618522; x=1746223322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7nC3nfEhv5L/CRxmPDCckluTJos988uHgTPNDdL33M=;
 b=W3yHLs7m4zpLYGYPvPLFxKRp+NHnRnYNylw6QpzOqstFgon2OajWtFAkyg9GlbWuFp
 AP4B80A3LKQqGmklY42W5X2Kt+Z4/yxcHPdxnoqy3MRD7ekSFHl2bbguwUkU3hln1A3W
 LdtlZVkl42AYMuAmqpgehYDxXbDokuhEV3kDz9zrW1K7/aW3pytxzZGzcU9MiiStQBj+
 /Fuhc7VBPlC8RIft8ul9PDgpkHpDQqO7CIGbyVBSPbG/KVOPJCzThySy7DfZs1GrlRcf
 uzp8cM05bUNfoeh2atsntHqJOi2/butSMsE3C1zDqTvcHPLB5nHJ2w/TzC+Ph7y/y5wP
 DTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618522; x=1746223322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7nC3nfEhv5L/CRxmPDCckluTJos988uHgTPNDdL33M=;
 b=VHadqut1GL1RPVOdxS/MBfH1JGwVLRoMXA/Cv8dmUMAnyfObFab8FDhGFYvRORlM5s
 zRg0sLQYIjli6JJ0nFc/uQDT4BF/fa54XVbuGSkA6bWrV4RfW8CgEgfYaGrAoHFAlqvj
 Bcis+l7pvyGCcXa0qKr8bbG0V0JhMSAjvzF7m9PflxJ+av8IY1bOdjA75OVXMZ8wYogL
 keVOy/4HD7h6KPxsCOaASh4QcQb98v45lVQzql/R3OObm8n7bHFO3B3ehFI9YJOgHzhG
 SnpvzEb78KskrHXddMy0lu483stHwZJ8ekUQoewS91UwNYPyQG9Wml4Aq+10RsixIi0j
 j69w==
X-Gm-Message-State: AOJu0YwXDZfdZvHQYIQZ79Ij9j6IUfk2aBHJ82voNls2TuYTpSwBr0/w
 UAwpQIEtLhxr8/iDXq8rJ5eKKif0GEX/rF9aKqK/XOGyIZcrYyxTdH5ry0BxNGAGuDwQBuj4F97
 1
X-Gm-Gg: ASbGncuLZt+yJ761i6GiOVnhWu1igM0EHOR9FtgHkUwnnXmKmbBry1VR9zQ774u8Cn3
 h1uvCBhBAYuh+XTINjNgC2XgmyNw5JF6+lNDiFNQfK/FfTWmikLhEOziz8/bcBXRn/u9EZ6y8lY
 KPSraXd+PVauIGvchzsqSkIw+RJJ71Qpm4THI0lRCa1loJZR5C5zB/213K3Vkh4K5il4ab0gTxC
 8TPwY/1RPkYDSOQnOQOlWCBOzf7AoaI1Br/TUTxIOHkfZ5jhVh3MGtBZfjieDfQol2gF55kCKaw
 BAjuA7HtI+NKVEyJdpF7c3K6cQpiN4bs9fScDnq64z2XrjNCxD++lxqKR6cZpMxX8egn5HMV69y
 vU4jNcAsToQ==
X-Google-Smtp-Source: AGHT+IGWe9t8z3vW0wBYwfbyMZw/rfMc89RSUgQb7kPEIvG7pgzXBHyYlqppuQJdYfz33oLR0A57/g==
X-Received: by 2002:a17:90b:384d:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-309f7ec4441mr5138947a91.32.1745618522084; 
 Fri, 25 Apr 2025 15:02:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 087/159] tcg/arm: Expand arguments to tcg_out_cmp2
Date: Fri, 25 Apr 2025 14:53:41 -0700
Message-ID: <20250425215454.886111-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Pass explicit arguments instead of arrays.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3d864c1c1e..cebd783285 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1254,17 +1254,9 @@ static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
     }
 }
 
-static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
-                            const int *const_args)
+static TCGCond tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                            TCGArg bl, bool const_bl, TCGArg bh, bool const_bh)
 {
-    TCGReg al = args[0];
-    TCGReg ah = args[1];
-    TCGArg bl = args[2];
-    TCGArg bh = args[3];
-    TCGCond cond = args[4];
-    int const_bl = const_args[2];
-    int const_bh = const_args[3];
-
     switch (cond) {
     case TCG_COND_EQ:
     case TCG_COND_NE:
@@ -2344,11 +2336,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_brcond2_i32:
-        c = tcg_out_cmp2(s, args, const_args);
+        c = tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
+                         args[3], const_args[3]);
         tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[5]));
         break;
     case INDEX_op_setcond2_i32:
-        c = tcg_out_cmp2(s, args + 1, const_args + 1);
+        c = tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
+                         args[4], const_args[4]);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c], ARITH_MOV, args[0], 0, 1);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
                         ARITH_MOV, args[0], 0, 0);
-- 
2.43.0


