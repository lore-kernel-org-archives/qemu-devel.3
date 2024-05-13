Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2978C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QRB-0006Lj-7E; Mon, 13 May 2024 03:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPX-0002zA-FJ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPS-0001QJ-Og
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42011507a57so9658565e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586464; x=1716191264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8/1fo4XxPxuANS4fw7f9IOfFNtGCwACN8n5KfI7MiY=;
 b=ZLnZ4lTS6WPgJzNZ04u8Okzcerm99/WU+3DtuV+fxy/BBGTArVdAN2x9zy5gIYnQBg
 Av6tB8W4Ca/n7f92SLqLYvJGRoCQ+jfIBkahCEdGGKovR55KzflU/1HVKHPO+chGrd/h
 UQsd02wsFCXAK0yGctUGccJ62kzbZrpTyJH4lqjzhGbriJpfnof1Qkg21bQwuQ7X70gA
 LE2TYx0ueQpb4Ldc835lh8HP5Zky92m4MdQ73Nb0opsn9I/Zv/maoGhb8SNOj6W2s+Lv
 2eaaH3YsdTJLk0WpsCngOq9dk7vwH9m7dexBmWzYNQLQ7kxcvcY0jrAer1/7vZVpZQs7
 y33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586464; x=1716191264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8/1fo4XxPxuANS4fw7f9IOfFNtGCwACN8n5KfI7MiY=;
 b=lvQYAkQ59PQqs7CbOVMXkA4zVVavKSi67XbotnNFcDXnLS9igOpetiIUSt1y6Qq1by
 tqUgh6ba/hFGb67i7WVrseydjkg+PS7rlALXJOqhW/r8SWO4sKNwRPJuIJ2bES6jv0o8
 G4zR6KV4eQFDTUHK3rQIT9zgQymJNZ3ZWYZ099hiUXSLRP07+yGn39kS30o0iM8mAwlv
 BylF6ylGF2yZLutA5dnM++qo+OCV+x7eVok+QBaf0FjPc34/TGZTnjsn9sPfYzri8dJ2
 X4uxIxL69+zaSmnk7cHIs6307BzjnfVWbgi/2XP2dMM4nF+lecGa69YWDioZK3WfmZo4
 FzYQ==
X-Gm-Message-State: AOJu0YzY6QPheld/QbVdYFJQWovERIHyjhdcF3kHzhrUiWN9gjQ6bsOs
 2QCV35Q44RiosCMleaPgFyPklE98XrdUXPcYG84NYVC434H3kRgWFloeB0mOj18AamuvqsZsNxr
 1K9M=
X-Google-Smtp-Source: AGHT+IEhseMmHyfHtOgN0lOBClYyPXYRIjh1i7uZPys6LpxqhsGtiHQEuoCOtMP7arc9XIzHMO8zqA==
X-Received: by 2002:a05:600c:1d1c:b0:420:98d:e101 with SMTP id
 5b1f17b1804b1-420098de3c7mr49278315e9.15.1715586464420; 
 Mon, 13 May 2024 00:47:44 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 35/45] target/hppa: Split PSW X and B into their own field
Date: Mon, 13 May 2024 09:47:07 +0200
Message-Id: <20240513074717.130949-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Generally, both of these bits are cleared at the end of each
instruction.  By separating these, we will be able to clear
both with a single insn, instead of 2 or 3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h    | 3 ++-
 target/hppa/helper.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 1232a4cef2..f247ad56d7 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -208,7 +208,8 @@ typedef struct CPUArchState {
     uint64_t fr[32];
     uint64_t sr[8];          /* stored shifted into place for gva */
 
-    target_ulong psw;        /* All psw bits except the following:  */
+    uint32_t psw;            /* All psw bits except the following:  */
+    uint32_t psw_xb;         /* X and B, in their normal positions */
     target_ulong psw_n;      /* boolean */
     target_long psw_v;       /* in most significant bit */
 
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 7d22c248fb..b79ddd8184 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -54,7 +54,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
 
     psw |= env->psw_n * PSW_N;
     psw |= (env->psw_v < 0) * PSW_V;
-    psw |= env->psw;
+    psw |= env->psw | env->psw_xb;
 
     return psw;
 }
@@ -76,8 +76,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     }
     psw &= ~reserved;
 
-    env->psw = psw & (uint32_t)~(PSW_N | PSW_V | PSW_CB);
-
+    env->psw = psw & (uint32_t)~(PSW_B | PSW_N | PSW_V | PSW_X | PSW_CB);
+    env->psw_xb = psw & (PSW_X | PSW_B);
     env->psw_n = (psw / PSW_N) & 1;
     env->psw_v = -((psw / PSW_V) & 1);
 
-- 
2.34.1


