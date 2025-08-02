Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BE9C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLO9-00034B-9X; Sat, 02 Aug 2025 19:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLO3-0002fE-MD
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:36 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLO2-0001ky-10
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:35 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-61997c8e2a1so388290eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176293; x=1754781093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VKntQcixz63yFkwnTw1RDc2VhvvMyz/VZ3kBWpA/ESY=;
 b=tiaGU2w43UyDJjXUrtSPzAu6+bG7q6UnBUSRepf9LWX1gCY4G1v1DoKlHlqcyIKYbi
 v6CEFvblhZi6K69S11zAtQ5bSwpLMb7w50gt2+mhq5NKjkwwsl2Y4kOMaCiBvnbq2jIh
 1bbKVIJxw9nfy9xidRdDZx2OPj/pQqALUVCxOjUL2Pt0JBxtnMDwA7/8mTVnwnFOu3l/
 8gLzGP+hD83ZlK/oqxjOLvRtcV5XnaeugDXnHsbUMimQAnKMBHTW8ACM34Dh+O7ciexR
 BseNlnA1ZpyreRpvVGMtFXClq4gGMIDGRHngGR2hlcIYQvpgmNygpIhMx5KBheUy8ZPq
 PYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176293; x=1754781093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKntQcixz63yFkwnTw1RDc2VhvvMyz/VZ3kBWpA/ESY=;
 b=GBt72Dc+w6XlRdN45TU14xLFkYxQm5Rfj1+IrF/jK27UaJuHzdeRysynRKKHkjVdMb
 hdxt+g4mBhXs3aWtINGhFYW0OVD2LnmLR5DYV0a8KkioztePWcHF5N3yfq6cOXpbh/eT
 7AXfqO3CUSy4M0lJO2p5ifmp76DUTyMIRxEQdVeEzL4kPZxOUoYC7qvI5uCWl7r0jxxT
 5fkQFtck9nRMihuWixfehroawiTK7h7pqY8RaXCNe89DLyhtXQOfpjOUJfF01WN6+tLw
 9teT+lodaD3/FtqM7yzWFqi3c20Ztd4zOgeQglSYA6C8aMI+vLi51w/ILAbKSkfWLDvh
 hTZA==
X-Gm-Message-State: AOJu0YyWSMdFsqmHvmlqV3WKsbcBPyneQHVhN+yNhPEDBxhrf7UmVI23
 Iki3HFhah199goNDA1oxdyu+zAadsPiOtlf7XPbMlBQuiokTv8oYfWpM+02fXCuQ4g9+c/67HnG
 u7J4Z9QY=
X-Gm-Gg: ASbGncunsAOMqy/YxFHakQ3qEOUgocyxH5Mo77tHyKYSAXKVPsXspmxOdKVy7Ji4cst
 IAZcqNecYPTXno69LuE7+QlTTrNHIhZYWSdegDRsP9mhfkjurRvqFj0SotstF9rvDM007FBNGw+
 giT1YbrToA9ublPxnoAKVglx0u6JsbAgeApwvg6Vm0Y+XOoQGcv6dLPAciGpkS2SeQeS432xAWf
 eMfGc5MFZjHmHPMsRVP7tDBC109hNT9KYWAmauxmm6grdG8CSlQk61QG1gVc84Ok2V0WxD+rfUT
 mRuCP4iWBNjxCb8lNbewZoxTImG1I7oBhcAA1oBtB6glRr9YP3t4nNwJEQmZSlLlUwUInRN7jua
 oI4BM8BpnE45gtk5h48kzDTLjTSr5QB8YJxa/9ujfFgGD02NtkkBP
X-Google-Smtp-Source: AGHT+IEbgYaaPzjVCyofJvavnWW+5OfnPOzoEwTxTc8zXqkBmI0xiGsLMBB49248n5b2KLC/HVVcQg==
X-Received: by 2002:a05:6820:4810:b0:619:932b:3dab with SMTP id
 006d021491bc7-619932b3f75mr1684237eaf.2.1754176292503; 
 Sat, 02 Aug 2025 16:11:32 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 56/95] linux-user: Move elf_core_copy_regs to
 microblaze/elfload.c
Date: Sun,  3 Aug 2025 09:04:20 +1000
Message-ID: <20250802230459.412251-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

Move elf_core_copy_regs to elfload.c.
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_elf.h |  2 ++
 linux-user/elfload.c               | 19 -------------------
 linux-user/microblaze/elfload.c    | 17 +++++++++++++++++
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index bfe2997fd2..2d83fdaf6d 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef MICROBLAZE_TARGET_ELF_H
 #define MICROBLAZE_TARGET_ELF_H
 
+#define ELF_NREG                38
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e5833ec3b4..161118d855 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -408,25 +408,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_NREG 38
-
-/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-void elf_core_copy_regs(target_ulong *regs, const CPUMBState *env)
-{
-    int i, pos = 0;
-
-    for (i = 0; i < 32; i++) {
-        regs[pos++] = tswapl(env->regs[i]);
-    }
-
-    regs[pos++] = tswapl(env->pc);
-    regs[pos++] = tswapl(mb_cpu_read_msr(env));
-    regs[pos++] = 0;
-    regs[pos++] = tswapl(env->ear);
-    regs[pos++] = 0;
-    regs[pos++] = tswapl(env->esr);
-}
-
 #endif /* TARGET_MICROBLAZE */
 
 #ifdef TARGET_OPENRISC
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
index b92442dfeb..8a17ffa561 100644
--- a/linux-user/microblaze/elfload.c
+++ b/linux-user/microblaze/elfload.c
@@ -9,3 +9,20 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "any";
 }
+
+/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
+void elf_core_copy_regs(target_ulong *regs, const CPUMBState *env)
+{
+    int i, pos = 0;
+
+    for (i = 0; i < 32; i++) {
+        regs[pos++] = tswapl(env->regs[i]);
+    }
+
+    regs[pos++] = tswapl(env->pc);
+    regs[pos++] = tswapl(mb_cpu_read_msr(env));
+    regs[pos++] = 0;
+    regs[pos++] = tswapl(env->ear);
+    regs[pos++] = 0;
+    regs[pos++] = tswapl(env->esr);
+}
-- 
2.43.0


