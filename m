Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEC5CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 00:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWkK9-0005in-Mi; Mon, 08 Jun 2026 20:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWkK8-0005iP-9D
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 20:28:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWkK5-0003ed-IH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 20:28:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c0c2c7d45eso44499105ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780964884; x=1781569684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vUWzLhoNQN6qDYBOEFREVa00KlqDNxwqxrSzVXWzJg8=;
 b=c33PHnHVOZOWkt14KipMhPaSnYpWLp2UxtGEAFLa6OfqLp4U9rXVb7mmdzGcHvK7Mp
 CDB9T4LCBs5JHzNtUsStg9HyvOQYrjRKSE4sG0XRF9+hWca3FZD13sTwkz06mGS7eykU
 BZDFf4yGiufoq8xw5X4TGSspbVLctH9u8T/sO/LnzGg9iquR7omACqdO0210kwmANika
 hHgFY8hdqfzDO7Z0jJ1pLHXLRcytBzGzkHBgzlU923bp1zRZ9seSp/cbRdVBu2yY86Ef
 Z/QtvTSuDWcdUu7LQHCBZFRu9iLqLuYU1/LszoGOTIay8AMI40r4I7MUoAkxxHh/F8NA
 AQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780964884; x=1781569684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUWzLhoNQN6qDYBOEFREVa00KlqDNxwqxrSzVXWzJg8=;
 b=hQr/2FdNewJT8RW+93sA5yMjYrEkz9RDaVDo9wbS9qU/6Hc3is8nuW0NuM3F/pu5Yg
 CQevuELuOEgq9kBt24MIuJDCn9cSlGiFamT29NLio+USRHN/QaH7qEemaA6Qi/HOTIpY
 1UjtW5yItCpFawl0hRU2XuU5i0Ny/AuvDx+cl9sRl53YBNikSYuSZEc684B36rZvQtdl
 zZV6IN96iSdf90I74kUIifS56kztzJ1L1U75mS84jsFpNm6vx5Mev69PmIvIrFc0sc0N
 HZASihPg0k4tna9N/Ol23l3aYigvK+ggTqYyG8QP2NOJ8p+ywVbsl0Xc040JManAwOuW
 FfJQ==
X-Gm-Message-State: AOJu0YxTGFtmHNXFJqS4b26YIiOsq6IZFVfZu8WPvBSD4LmfVMRCVhY7
 smUYluhvucRL7oZ7zwtqFyspGxnwBcYwAWRmSZE31h5Wjt8DmO6bwBdGGQjqEWHukxm7y8ue5yJ
 JQqaWyHo=
X-Gm-Gg: Acq92OEOJb/1om1luuHtDGhNwuuJFY7Cqs0BX7y3jnJFcHYeC49tGtdbRsqPaXBAndY
 mqJPKkH/w/+Ff1rVPmlLmKAwKnsSBKpzk31VAUX4fr4AgwdIJV/JUaALDOS0dhDFSfqtk8RtwOh
 /LAgjW/F7B7u1YxNtxHUy6pKi4fTaUTuH1sMrQygsGQEE/MoghajVeIJDAXeBdGeEIPKwK+msQh
 hjlGPYHMB9zWn8wbf1G5qn/7ZCTA4m4Suj5RFUapebt5umovK57BsDijn3WB+RzL4BHXLjmwINd
 KShKJEhLhMjJCc9CDVykKtk2RON4nzyTfu/ddOXQ6YgSRusiiOT4UxG6h3nwincjeTGNKA7jeoU
 RDcijklPDifMNYvswgm2WXhwUC8aVrSHWzsUBmCF3WxxSAeluH4y9e3oKoKFQEwXfQqu5aJL7Dr
 L/6xTHOI9HDSnKqdvp8/q458BvnMR8Gty621G6YFU=
X-Received: by 2002:a17:903:3805:b0:2c1:98b7:ecf3 with SMTP id
 d9443c01a7336-2c1e849577emr179401765ad.23.1780964883762; 
 Mon, 08 Jun 2026 17:28:03 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6d389sm188729435ad.16.2026.06.08.17.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 17:28:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH] target/i386: Update cc_op for SAHF
Date: Mon,  8 Jun 2026 17:28:02 -0700
Message-ID: <20260609002802.729485-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Removing the call to gen_compute_eflags meant we no longer
updated cc_op after computing EFLAGS.

Cc: qemu-stable@nongnu.org
Fixes: da7649c6aeef ("target/i386/tcg: do not compute all flags for SAHF")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3537
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ce636b6c56..59948fe64d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3768,10 +3768,13 @@ static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
         return gen_illegal_opcode(s);
     }
     tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
-    gen_neg_setcc(s, JCC_O << 1, cpu_cc_src);
-    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
+    gen_neg_setcc(s, JCC_O << 1, s->T1);
+    tcg_gen_andi_tl(s->T1, s->T1, CC_O);
     tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
-    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
+    tcg_gen_or_tl(s->T0, s->T0, s->T1);
+
+    decode->cc_src = s->T0;
+    decode->cc_op = CC_OP_EFLAGS;
 }
 
 static void gen_SALC(DisasContext *s, X86DecodedInsn *decode)
-- 
2.43.0


