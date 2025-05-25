Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F263C54ED0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoU-00027k-Ag; Sun, 25 May 2025 12:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo4-0001lW-QG
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo2-00036F-2T
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so14907075e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188952; x=1748793752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCPAc4kQVEvGGRVvJbn/l1McxSb2MHV9t9YV3lujsKc=;
 b=Kk4mihk2YJmxVI6Bl9YBJonFDWCMAMU++XE0EJPDK40BOfT0Jh8upIXSHlRn+7f1As
 fL4OoJDHJ/sedqFT0MNZ923CN1SIRpXtmuYC9PYMu+eM/5+up5SYL3F2tM3EerQtjfwk
 zXn0AoVhbYSyuKy6/OgcC/UMtFfoXvmSBmPJUCKCvkFqvam/Ja8fidHDVUMsw49v3QMe
 6M0kXcSLujguN4ssaiZKhncko9+lvu5sYiAQ+hl+gACud9L2gAflvf2THFA6A36G9sfd
 Zlq6icTGXOPBJ1q7/QdzAxiSGBkiX5jdm2mQZFCu8vE1qI5XHlLObH7f6rCNBaXcRgel
 2NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188952; x=1748793752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCPAc4kQVEvGGRVvJbn/l1McxSb2MHV9t9YV3lujsKc=;
 b=qm0dN3V6RqVZCoRuHjdNCKXM3CUTmZBw1s5l/RA8h3UljeJuCRoDyJpADZvO29mxfS
 dSZ2a7AEmqhx5qxvmhfdbanvreaS41qLy6HrTygfQQpYybIUnBnDm7vpsHAvh0a6iAhl
 f7ejqH6jfp5XtM3A0AQWXuzDxNHi31EVIA2MAAbcPBPuaCl9Yiq9nuNTXRQ7vaABhsJw
 QHdZ1nDdOXPHvFeZb9E8smNY+wrkgr1C4xHJWQy4UtjeNl6Jso1tRqT8af019T82C9N2
 wsgHYoI5ZMnPKckJLvmGL4ddq7ibdERy1kLtgG2I+jFrZTWHdlGQF7jHHhRK+OojChyS
 wYxA==
X-Gm-Message-State: AOJu0Yy4rTDepgkY1M+9YZCSHEOhraEPp0x+jVuBmLCu9mFXR71061g8
 3FMSox8tPpfKWdP1g1W8ikPXwKatCLm0RT6VdFmg79xl7+AVPu+FtYfretisqs715XAindp+seS
 vy3wSqGQ=
X-Gm-Gg: ASbGncttWu7SqIBiLZD+enhMHDbXgXE/lxNQVxJVvrLtvyRMZ2N7AXMBk8rqw098kqL
 HML+i4CDlZ80SmK+gp8Ezl5JHBhNco71JzOlRXNBVnagTyE55w5OkZN+Wn8uGlkxQd0MlfMhJk4
 dneRyOhYCvrC8AYO7MTACasLVANgcPGmX8nzlsY9vau0b6WJowx9PZ1DCqn8r7uS65vZ8l6K7YP
 Rpf07ux3plQUL8Tgoa8Em0H8ZgpLQuzn0wPPOoDzbI9g2kEOIHbSjC2bC5ZGzuzZ0PUHusa/7jQ
 nyjW+goVRMOjAMq+gPnsnQ+IKaUSuptpsT/DDWMpbg//wSdvdo84AjAc
X-Google-Smtp-Source: AGHT+IHsVaHxUHqGZy1/OlGJLqonUzQCqULeSxD0ZwafBUgNl+ixyCA6QyANHhpYysLAhSNeiIwIKw==
X-Received: by 2002:a05:600c:8518:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-44c91cd5123mr59877515e9.14.1748188952331; 
 Sun, 25 May 2025 09:02:32 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 05/10] target/microblaze: Use uint64_t for CPUMBState.ear
Date: Sun, 25 May 2025 17:02:15 +0100
Message-ID: <20250525160220.222154-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Use an explicit 64-bit type for EAR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 2 +-
 target/microblaze/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 6ad8643f2e..3ce28b302f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -248,7 +248,7 @@ struct CPUArchState {
     uint32_t pc;
     uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
     uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
-    target_ulong ear;
+    uint64_t ear;
     uint32_t esr;
     uint32_t fsr;
     uint32_t btr;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3d9756391e..b1fc9e5624 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1857,7 +1857,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 
     qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
-                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
+                 "ear=0x%" PRIx64 " slr=0x%x shr=0x%x\n",
                  env->esr, env->fsr, env->btr, env->edr,
                  env->ear, env->slr, env->shr);
 
-- 
2.43.0


