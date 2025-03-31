Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5926C36014
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzHTq-0001LC-Hm; Mon, 31 Mar 2025 11:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzHTI-00019i-9Y; Mon, 31 Mar 2025 11:54:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzHTG-0005II-JC; Mon, 31 Mar 2025 11:54:44 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-225477548e1so82097865ad.0; 
 Mon, 31 Mar 2025 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743436480; x=1744041280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2wJNuH1xvXGk6SXFgIvKU6voGjgibA+BiurgRrjWX4=;
 b=NYcDULHoegxOPCLTnHh7fUDSLuz4jql4hqLe5uf+8xVU6lDiE3lfJbFCQ+PzN/SFrs
 /wV3BzGCeOaXK3kFQ+OdGZDfTbnjZLqBF1kzvJk1SHWDm14M8MBYUFHjRKUCzHpheydG
 BbY8rbghI5rTND+k8V5H+pa2l8/jmvwjLOmABejeoqbxQb1OJYMQyXNGSPCWz9V5qqau
 JFFpa6y9qIUUvwWE+lkRxXsRVotNzBd6EySTYzhucVzaxnLPIKUo0szOXe9bDxHi7TPw
 9QgsFqBG0J2+ZWFlrb8HKIgakc61gYu0Ozii9DJXJOOM8QqHwU0r90JCXte8ArLyJXhM
 rgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743436480; x=1744041280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2wJNuH1xvXGk6SXFgIvKU6voGjgibA+BiurgRrjWX4=;
 b=QLJCL9ANyUdo9E0LNYC1O90WYxEA0zjdZkg0iGn7RV2Im22cZGvR1Bd8S8gacRKdXl
 ZlXk9lC0iUB76zEq1bBIi+iuvtuoAeI5yyZXqpaAvA4FDZyn7yObaCA05qXcygU/nTiE
 RO+83Jl3x27bLxhnw6sDVZWlobIjnWQ3vvUmyfwm6V/espgnzpji0nImtzm7uaZuPmYZ
 Son87Qz7vabojoXfDUGEx3gRolnaYW4jhSGekpDdLc9I2dwIKCPIPYGS9XPWE2scPrpK
 +bpAhLY59DARNvQ1xd5lv/UBKWfpIq6w3IUBK6cUrSl2dgZWQM+D9y4SsNSP7ioXyweX
 zkMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmxfhfb5umAzT3mIDqXWvCKnHBwM1Xh8hDaJRh7sZOnr7sH6jZ/okSiG51QoX7w+XJQg6nWVT5E+r9@nongnu.org
X-Gm-Message-State: AOJu0Yzw8iFkiJz53tnmShC9PN2AFSET96ihZCZBo5lOO8fml/2L8pla
 c1T8g1NzCNi+8nxaqE+Bv9gK8v1DvtwTyyFs/cbWVBMcGQFeFJF+MJXXJw==
X-Gm-Gg: ASbGnct70qxwFABwc3gkZSYgwkkxEJExGha8zGC67GJUtnn9X29mZwLH1KUkAQk5b36
 2nTvA5XH44eda/PKXJvVjZ99Jtqb6n16Xfg+QT/wMOzziFWUNlLQuF1s3C1zZo1LIYXp5Y4rvo3
 TAfhmjtpRvNieMaAieBoUPd3ct621aBxLy3DnQ5EasrDovEm4Vi2uWkUlnAHbXrTqqK2iq1CNNs
 70JeoqDoHfNVh/7LM1vXTKUv/gZvS8crgyX0SxlXuzfqD37SMtl0I/AhP/co1TShC7bAMjrJZ5k
 5vLjkQcpiv9ukXsvXshAWWlQhxk0VI56VM05qlqs88/4DcQXtNqpRr7ahlmE
X-Google-Smtp-Source: AGHT+IFPwjmdtsDi+Hhcd9WYDfHCxdeq8qqYiXZQO4HGYtHXFirK6H+drc41cFzl33p0qUbeXQBNEQ==
X-Received: by 2002:a17:902:d489:b0:224:256e:5e4e with SMTP id
 d9443c01a7336-2292f961168mr134784455ad.16.1743436479899; 
 Mon, 31 Mar 2025 08:54:39 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eec6fbdsm70742045ad.16.2025.03.31.08.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:54:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 3/3] target/ppc: Allow goto-tb on fixed real mode
 translations
Date: Tue,  1 Apr 2025 01:54:23 +1000
Message-ID: <20250331155423.619451-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331155423.619451-1-npiggin@gmail.com>
References: <20250331155423.619451-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixed translations (mapping and protections unchanged) do not have
to restrict TB chaining to within a target page.

Hypervisor-real mode is a fixed translation.

TODO: Supervisor-real mode in spapr should also be a fixed translation.
---
 target/ppc/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5e610bf29a5..4b4440c8a16 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -183,6 +183,7 @@ struct DisasContext {
     bool sf_mode;
     bool has_cfar;
     bool has_bhrb;
+    bool ifetch_fixed_xlate;
 #endif
     bool fpu_enabled;
     bool altivec_enabled;
@@ -3656,6 +3657,18 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
     if (unlikely(ctx->singlestep_enabled)) {
         return false;
     }
+
+#if defined(TARGET_PPC64)
+    /* XXX: make translator_use_goto_tb take a 'fixed map' bool */
+    /* Suppress goto_tb if requested. */
+    if (ctx->ifetch_fixed_xlate) {
+        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_TB) {
+            return false;
+        }
+        return true;
+    }
+#endif
+
     return translator_use_goto_tb(&ctx->base, dest);
 }
 
@@ -6545,6 +6558,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->sf_mode = (hflags >> HFLAGS_64) & 1;
     ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
     ctx->has_bhrb = !!(env->flags & POWERPC_FLAG_BHRB);
+    ctx->ifetch_fixed_xlate = ((hflags >> HFLAGS_IMMU_IDX) & 7) == 3;
 #endif
     ctx->lazy_tlb_flush = env->mmu_model == POWERPC_MMU_32B
         || env->mmu_model & POWERPC_MMU_64;
@@ -6627,6 +6641,12 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         gen_invalid(ctx);
     }
 
+#if defined(TARGET_PPC64)
+    if (ctx->ifetch_fixed_xlate) {
+        return;
+    }
+#endif
+
     /* End the TB when crossing a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT && !(pc & ~TARGET_PAGE_MASK)) {
         ctx->base.is_jmp = DISAS_TOO_MANY;
-- 
2.47.1


