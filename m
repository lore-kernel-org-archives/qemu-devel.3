Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F95AC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSyk-0005Yh-IK; Tue, 19 Mar 2024 02:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSye-0005Lb-Bo
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyb-0005ea-Lx
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41461c256c4so5250185e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829772; x=1711434572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaSTDZWCvnDQFHGWaMWeelLWgiRSqaaIXlBIS7H4n9A=;
 b=heLJNLTVIkvO4B3F7/mDF8jdEk0hazqFz3rTaMhKKxf4SlX4XCC/i/JoSaDCKwOJyA
 LDQzE0LJJExZeFNVxHNxXmqvBowtQA+L3h5dTKC0y3Nsc3DysqIOQa9CmVAXNywhXSMo
 yPhUGoSp7HPtB3HGYS8cpDUx0gYIoc3AcvJZmGYa77zP5FSr1WQR7r4O6JnTVin87CQM
 COuq51VESAm8PaA8VPKltrbprNDGJy4O60xtvW0yf1ZPGhjjI1apYT2frYjygdVIEWCy
 uo68xaIRryvBL6WxCWDA3aqPlSALSrZ/lxUMNuX/wN4fK1ScnAZ4z5F1APiZYdj2tHzM
 Ii0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829772; x=1711434572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaSTDZWCvnDQFHGWaMWeelLWgiRSqaaIXlBIS7H4n9A=;
 b=TCpa8E9YhVk2fIlZ8FpNJ087GtciaJQMmqHFHGGxb2I7XgEJ3Jr1yM8wztbCmh6eIG
 FboPQT1m1pFuiVZ2H7miIlu9loCpu+uU41/ayf4en6+oD8sqTCMDh4r8zFOME90l+LJQ
 LXzhuZgdIt+JFh1juHmxdFa4YJi/hgcg+loqb1uaRnPOCF1BZfLsVxK8acZ0XpUaqoS1
 q7SGN4gotxY5oo4OcBR3iUwmnu6vpEmsdN9Jns0hjkCRKv3D3ZFpuWN6sd2OU3DKemS8
 zCls2sbBvEI5lHQ0xIKU7dt0e5OuJGR76/P3GQScz5zgpRPKefusWwWqXPrYk5nnXiyW
 qrhQ==
X-Gm-Message-State: AOJu0YxJD2R3gsIXmu4IWMxjQ5Ny71EuQAZc/pyR7+7DATMvuY1zWQ8p
 0RyCzNhvYA8jVoWQw+F5B+9RwgTcv2O9gmqIHoAZgIrj+TM2DfauAYcOGGEp333392dQlfBQ6mj
 7
X-Google-Smtp-Source: AGHT+IHjYWZSLPC41rGSe/+3IByzDksAKUwsz+iLZr3iscOG8H5/z+G8wbNHPGjXWH1a4YJjaV4YWQ==
X-Received: by 2002:adf:e392:0:b0:33d:746b:f360 with SMTP id
 e18-20020adfe392000000b0033d746bf360mr939268wrm.51.1710829771832; 
 Mon, 18 Mar 2024 23:29:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 bw28-20020a0560001f9c00b003418364032asm1933168wrb.112.2024.03.18.23.29.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:29:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 6/8] target/microblaze: Rename helper.c -> sys_helper.c
Date: Tue, 19 Mar 2024 07:28:53 +0100
Message-ID: <20240319062855.8025-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
References: <20240319062855.8025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

helper.c only contains system emulation helpers,
rename it as sys_helper.c.
Adapt meson and remove pointless #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/{helper.c => sys_helper.c} | 5 +----
 target/microblaze/meson.build                | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)
 rename target/microblaze/{helper.c => sys_helper.c} (99%)

diff --git a/target/microblaze/helper.c b/target/microblaze/sys_helper.c
similarity index 99%
rename from target/microblaze/helper.c
rename to target/microblaze/sys_helper.c
index 3f410fc7b5..5180500354 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/sys_helper.c
@@ -1,5 +1,5 @@
 /*
- *  MicroBlaze helper routines.
+ *  MicroBlaze system helper routines.
  *
  *  Copyright (c) 2009 Edgar E. Iglesias <edgar.iglesias@gmail.com>
  *  Copyright (c) 2009-2012 PetaLogix Qld Pty Ltd.
@@ -24,7 +24,6 @@
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 
-#ifndef CONFIG_USER_ONLY
 static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
                                     MMUAccessType access_type)
 {
@@ -266,8 +265,6 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-#endif /* !CONFIG_USER_ONLY */
-
 void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                 MMUAccessType access_type,
                                 int mmu_idx, uintptr_t retaddr)
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 3ed4fbb67a..013ea542be 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -5,7 +5,6 @@ microblaze_ss.add(gen)
 microblaze_ss.add(files(
   'cpu.c',
   'gdbstub.c',
-  'helper.c',
   'op_helper.c',
   'translate.c',
 ))
@@ -14,6 +13,7 @@ microblaze_system_ss = ss.source_set()
 microblaze_system_ss.add(files(
   'mmu.c',
   'machine.c',
+  'sys_helper.c',
 ))
 
 target_arch += {'microblaze': microblaze_ss}
-- 
2.41.0


