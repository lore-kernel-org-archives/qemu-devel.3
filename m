Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9F9C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJz-00064M-IU; Sat, 02 Aug 2025 19:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJv-0005nT-SN
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:20 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJu-0001EC-Ct
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:19 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-61594007beeso374622eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176037; x=1754780837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qgx7jPh2mv/gIUiwJWtq6P9AJ4NMIrU+C1ZhQ4Ea56Q=;
 b=fPQc6V/AB4FeVipmt0m3NmppeNiB/w+yBdv3DJieNjectOKs301MFix/HBMKnNOvLZ
 6zVRKJdk8hvgF+NDZAdGoF14ZtNFyhTjCdhyXVVKlwrdB3r9WlIAwae52UVonVHdvrRn
 jpZkXgM0XcjtpGIxDTFRxSZy2gZG3Lf1VdH1eDPRl/9q9WIoWlwQvPA7xWkAtxQElupV
 A98J3cizbWVz30DfAR6BEufobO1+PX35cFi61/mq43GwyGZCVdlOQPQh+x7zdAkdmzJv
 YEoWk/8y/8KDabpAZuUromy4eCo58pAcmeXQ+lfXIe/U42xi5EZZclKOvx8aB8i+MNtm
 u9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176037; x=1754780837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qgx7jPh2mv/gIUiwJWtq6P9AJ4NMIrU+C1ZhQ4Ea56Q=;
 b=l4O+Qsc31imF6VE3tlpe/vu4R6FTxVFO2F0RRsTFTh+sxz54+EmjOyQwTpm9SfjVV/
 4NMMu2LdFwgt8LEt/oSo3racHpSkkqk/h5jZPWAvUuq8GYGTLAhQgPu3PEXLQmW0O71v
 jwLvIQl6xYKZr43i+mEkpWVNRrPyqQCeMOtMqQSVdWbRtoWGqCgyIXWUE5V+lEch6yy0
 C8QuNBdaiIsOaDyV4Pko+kl4lb/tvrWXCBl2OqmqbHW98amja+5BVNXCqfoU9UryLNfZ
 3Bl5vHLQcz3lpDWSQrc0ler77l+yrMAh+OiPKwF3AYb0XHB9HuD/r1K0/BlMJXRcoL7d
 +S3w==
X-Gm-Message-State: AOJu0YzFE+Ahkc9heb4BtO/5iHyFncfGU70DduKq9rP0piD9utTazRj5
 nJfyZXAdraJOzFmYryf1oW0xACgEPMAid2ssaFqSEVLHTpC4EYJog8LiJLEgc7XZOZBv2mqIxMo
 muWeOgyU=
X-Gm-Gg: ASbGncvWLdwlXHE0GpsSQFfE7Qj6HmcoxP+H1XtLRMKX27+35tO0hsDXV7LI6I38RIu
 mFtxVjiNWTXtGCXOhHPEFYYmUs+YX+iL6D7koBJifyoBXPcvd+uBSnBXxQoU/O1cFMmuib1FLI5
 HyBH9Nj5MkqHmIlAdJRCvlXe/yvgSXlj7G55+G+G7F95n4fRCgFjR+b7gC9ZTcybii9ymqWa8D/
 duGW1ggfm1EqPDA4MWQd2dPdj6fWDM6vK6Df/sGW9V6N3HcVBW0pDHig9ssuOKhlgkI/07IvpXQ
 sJHda79OaDJQLt0zF9zn6N35R5I1dAg3yxe6MXIA0hozUzDOrC7A2QTmThAvjl72C0siGKckKgK
 TEO4/45Me1FkRotJopVpgchIaE0Uu3wdYcQCvGwxQS+00UN5Ek/Ma
X-Google-Smtp-Source: AGHT+IHveN0lanE9FsvChr28ITj7hf/mGPvEeV68mlxIGH0Bj0u7yPCW3Ep6qGJGFb4Rpma9WaYWqw==
X-Received: by 2002:a05:6820:3093:b0:619:a34b:3e32 with SMTP id
 006d021491bc7-619a34b4375mr799113eaf.0.1754176037049; 
 Sat, 02 Aug 2025 16:07:17 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:07:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 36/95] linux-user/sh4: Create init_main_thread
Date: Sun,  3 Aug 2025 09:04:00 +1000
Message-ID: <20250802230459.412251-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c      |  8 +-------
 linux-user/sh4/cpu_loop.c | 10 ++++------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 03c9539774..8604308a31 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -701,13 +701,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /* Check other registers XXXXX */
-    regs->pc = infop->entry;
-    regs->regs[15] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index ee9eff3428..259ea1cc8b 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -81,12 +81,10 @@ void cpu_loop(CPUSH4State *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for(i = 0; i < 16; i++) {
-        env->gregs[i] = regs->regs[i];
-    }
-    env->pc = regs->pc;
+    env->pc = info->entry;
+    env->gregs[15] = info->start_stack;
 }
-- 
2.43.0


