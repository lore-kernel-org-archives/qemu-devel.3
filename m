Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14667C3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvZf-0004n6-5b; Mon, 22 Jul 2024 12:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZY-0004cY-LW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZW-0007dw-0X
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:36 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd69e44596so19208445ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664451; x=1722269251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1ZIker/Na8GmtNzPBdUPRkmdrALyxwwToEGtVfZGu8=;
 b=ooyFylc/qaquLHgSfvm+j2hTCjcPza5Jmm9RNweq0LTlfGoS3nsecYNoDVaEp63h9Y
 RputhuP9kYCCt4EODZCQo/7P3oNDx/9Mjcutg9+yl7R7LRURHgHan/BmPnx5B+Ynn/T+
 HplyAR84yy6+CYiHEIWASou9cUv/GVJrso9j/N8cD9pQK+u2cG2HQw8Y+B1cW+m6Ac4r
 II+VcT5zSdInXt0j2SgV2xCd87csIRPVLj/JG/3sna1Ho1Ihe1cEqJ0gSTYVwk3HTBmT
 XJU/rt+jwNNwX9+8+eQnKpfYh4yt3Y/ISBYoisCE5AkgxIEtL9Tp6MKTzlRHzRpmbUqQ
 8wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664451; x=1722269251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1ZIker/Na8GmtNzPBdUPRkmdrALyxwwToEGtVfZGu8=;
 b=lzc5cMaSXa9XFq+xR6tz1npgz0lVArIqJcSdOMDiVG8+wtyDpjWkXOKFbSafArUr+3
 yZA82yPGldBcLgjxTLJcGT9JnGRFf+VHqdbzmwY3r9599TCfhXvM1au1rIzGdppl7gAT
 bB4eZFkPJY1XcUWQXwdaqWnOVSG31TXzuPpetgacC+l9n+A4K6xUCEzUVKOFItKwyt8W
 uoiKRPrfp0UpYKXg8mw/NFycuC+yx18PDKCbaQllqmBpQIHe5pQaXQTOJFuSJfWivb2g
 t6ZYXgsY1K+MVJqkDhOgoavrSsP11r3uisJTQAINIOAe32ANF/TLp2mv59APVOwzPnTM
 scTQ==
X-Gm-Message-State: AOJu0Yx+UJjnsjy30vyppisf9vacSsjJs7GDC2mk20kOquJV9mM9SQm4
 1cwx4BeqrpaRakI8pbOgbl5EXlbiFdls+j4svTZIobb4SPDwOlWVIzV0H5txAMz42p/bUiM7wMO
 J
X-Google-Smtp-Source: AGHT+IE9yvGdPnxbjV8DbKhMPkuDp90ILAo/+TuVSJz2JYtUr/vfUD5A7J5F/4A6i7dgrHYs+5bDAg==
X-Received: by 2002:a17:902:e746:b0:1fd:6f24:efad with SMTP id
 d9443c01a7336-1fd6f24f2e6mr154949855ad.26.1721664450656; 
 Mon, 22 Jul 2024 09:07:30 -0700 (PDT)
Received: from amd.. ([2804:7f0:b402:9243:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f2ac8eesm56533165ad.118.2024.07.22.09.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 09:07:30 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 2/4] gdbstub: Add support for MTE in system mode
Date: Mon, 22 Jul 2024 16:07:07 +0000
Message-Id: <20240722160709.1677430-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722160709.1677430-1-gustavo.romero@linaro.org>
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
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

This commit makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/gdbstub64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index d59272fdbb..fd5a9d0609 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -426,6 +426,7 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
 
     return 1;
 }
+#endif /* CONFIG_USER_ONLY */
 
 static void handle_q_memtag(GArray *params, void *user_ctx)
 {
@@ -596,12 +597,10 @@ static GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
         .need_cpu_context = true
     },
 };
-#endif /* CONFIG_USER_ONLY */
 
 void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
                                        GArray *qtable, GArray *stable)
 {
-#ifdef CONFIG_USER_ONLY
     /* MTE */
     if (cpu_isar_feature(aa64_mte, cpu)) {
         g_string_append(qsupported, ";memory-tagging+");
@@ -611,5 +610,4 @@ void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
 
         g_array_append_val(stable, cmd_handler_table[QMemTags]);
     }
-#endif
 }
-- 
2.34.1


