Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF9EC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbR1-00025A-Aw; Thu, 28 Aug 2025 08:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQw-00021z-UJ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:51 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQv-00077L-5U
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:50 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-32326e202e0so785485a91.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382928; x=1756987728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ckoa7Q5fRbN89GH2lVEP8QY0piD/Udg3SNC690VSxXY=;
 b=R5xXhwbQWB6hjTlWpiaBr0XNXSO6vXtJsxudH3LeObA1PKqPRKyYpeMYTPAZl6Dgxh
 2h8JsV3Bm2diMKW7VgZQu3EE6Zfhg3ylrkJdZAIGH+tqU/RYUkwC/gHvP/1HpMk4YvQL
 PBZLAcU6OhXwLCGMLZbLXJ5aSCQTufSTihAQYt+37d83c9eRITv9nw25Su7J/lQKL+0i
 QUDXkecfeGsy+0Q8TA/Yj7dlT8r0S+r82kYWSuD03qnuRwSWT6g5A7ScTGQfrW3cq+co
 aZbFOA+f41oK8cpKLR0I9kRNW/VJVD8SkOcJMz2aAiv5/r21xehA6q7RZnYz+zp66nNc
 x42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382928; x=1756987728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ckoa7Q5fRbN89GH2lVEP8QY0piD/Udg3SNC690VSxXY=;
 b=b9is5fORSQXPvngx3hi0TKI/c1mYAjrA1Rm0I6tRT2Mas/ZJReZyW5v2sJY4AUWgD1
 dxARVP68JiYPBZ6aBGroRatxOfqLJ4H8Od6YstyzuxtUsrrFtZjkUc4aaVkAaDu5iNXu
 +xXA3iq6dblMtoioC/QDk2xXFMwO3KsxuxcPVNZKj6viEpSowNhVWmQ901XDOQvRsHCs
 GN7vhbWBF2zN00IfCxPmyZRM2I4dQ56Ow87UWHdlLiVNLpB/O2hIp2tUUwt6cW9b8Te+
 otyL5BnjTBljCR6190cZifssTslHEWym9/S0JS6SF3jBS6WBBkmDkAjaWRbjmiTTGIVf
 muVg==
X-Gm-Message-State: AOJu0YwaW9y646lR1BwUrCiFTjkrcxnr4fVF9zF+/JSosY6+f95Zsi7b
 DZGN2zrVKE3f4qoJPc6ygOetWzx/WWBuRsHpHYjGK4G6eZHFzQeUB82Y6PjeYyv2GErOMJpXNhM
 MuZZFpuQ=
X-Gm-Gg: ASbGncvDVuZh8ocFiQ6WP7HxWxxRFYVV8qot4FEWLVvqd5C1u57BffQk1wwCCHg98aa
 ZfbUQ72Q+rQmVBtnfMTxJ6tmgfWtPZ9zwHIhcsB5tQ2lN8LInhUon85iQKnsuEHGMjo0al8tyxY
 baBE6bpi+Gkpj0gXoLMTihz+P/Z7u2fNu/VSohKr9qNNJ58UPk/Q1Kqbp9TGXYcBwQzt2iqSB87
 DnxFRNxLCIaCL4jsRYfHESXsQbjm/Qht4v1I4D2cMRnn2QpT7Wsr/g4VblzznxNeId9TK+wq+qt
 mWAR7WZfcAxDY2SOt+v2wnKFnbcDwubV0iA2Rg+XtqDAG2ySrub3GppdJKjgU/LUDN56EMauOMk
 RBxmBju1DTeAnUJQK0J8yIfIWpkr3JE5WLTtOnZfR5LT21yY=
X-Google-Smtp-Source: AGHT+IEkjeUv4U6m3vHercS3wQLx83aU+J0oB+4FthlKrzutKRXGZrORYTEW7xvnojSc5zEjTZjSsA==
X-Received: by 2002:a17:90b:5863:b0:327:ba78:e96e with SMTP id
 98e67ed59e1d1-327ba78eb9dmr1362554a91.13.1756382927625; 
 Thu, 28 Aug 2025 05:08:47 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:08:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 02/87] linux-user/i386: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:11 +1000
Message-ID: <20250828120836.195358-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ba205c5a19..e8a7f040ed 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -233,7 +233,9 @@ static bool init_guest_commpage(void)
 #define EXSTACK_DEFAULT true
 
 #define ELF_NREG    17
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /*
  * Note that ELF_NREG should be 19 as there should be place for
@@ -242,25 +244,25 @@ typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
-    (*regs)[0] = tswapreg(env->regs[R_EBX]);
-    (*regs)[1] = tswapreg(env->regs[R_ECX]);
-    (*regs)[2] = tswapreg(env->regs[R_EDX]);
-    (*regs)[3] = tswapreg(env->regs[R_ESI]);
-    (*regs)[4] = tswapreg(env->regs[R_EDI]);
-    (*regs)[5] = tswapreg(env->regs[R_EBP]);
-    (*regs)[6] = tswapreg(env->regs[R_EAX]);
-    (*regs)[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    (*regs)[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    (*regs)[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[12] = tswapreg(env->eip);
-    (*regs)[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    (*regs)[14] = tswapreg(env->eflags);
-    (*regs)[15] = tswapreg(env->regs[R_ESP]);
-    (*regs)[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    r->regs[0] = tswapreg(env->regs[R_EBX]);
+    r->regs[1] = tswapreg(env->regs[R_ECX]);
+    r->regs[2] = tswapreg(env->regs[R_EDX]);
+    r->regs[3] = tswapreg(env->regs[R_ESI]);
+    r->regs[4] = tswapreg(env->regs[R_EDI]);
+    r->regs[5] = tswapreg(env->regs[R_EBP]);
+    r->regs[6] = tswapreg(env->regs[R_EAX]);
+    r->regs[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    r->regs[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    r->regs[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    r->regs[12] = tswapreg(env->eip);
+    r->regs[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    r->regs[14] = tswapreg(env->eflags);
+    r->regs[15] = tswapreg(env->regs[R_ESP]);
+    r->regs[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
 }
 
 /*
-- 
2.43.0


