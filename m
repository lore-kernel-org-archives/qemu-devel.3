Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430B9C5321E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 14:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siEbx-0002gY-Tg; Sun, 25 Aug 2024 10:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1siEbv-0002Z4-V2
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:52:56 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1siEbu-0005vM-C8
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:52:55 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so2212597a12.1
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724597572; x=1725202372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LA4jeEZSXIyNF/wBhldtI2p7w4RNntmuoAerN03i6Nk=;
 b=toJfdckTZl6sGd76DeZygEuSvr8KO0NtJ0JNwlmSVhKBXYmlYdmj9BEy4bifimtET4
 4X+RRSuz+/spgQ/w7g9si7bC/Xn5d9vE3k2/Otr+cFhGvSqertZofw9EF4KwUIy2AZbv
 nqUuOd/ebaTO3enOPXHPtqI34LPcp199VHrodGVWgIO2W9DCnplLPxgNjVWbLKXXmhUM
 zLLbALOi0vkdYyEfzA5Vu22pifnEwNhm+cYVLM8YJ0iZLltF5+gI2Uze3PmeuLDv6Bvg
 4F+nt6a6MntxovGGoep7pNiwsefVCMI9ejs0zZ+v11GkOBgOKeCfi1OoMWqSCH980zpE
 +Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724597572; x=1725202372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LA4jeEZSXIyNF/wBhldtI2p7w4RNntmuoAerN03i6Nk=;
 b=GOiYK9OEKu9c6JT3o4ojEDIWi3Doqpyj7kJMPlpI3ezAxBO4/KsLhwf4xbmHujBGNG
 DzBm2nciAgvUM+2DC5cGm9gwgTaWepD/1sBzqq+Qh84YJ0gbbs8OzfHAUg+uG2JwElP6
 9xo1usA4fANRRjJeNkE7J9vupG2IE5T8OEV8GS8s7iswLxp76NUTec3n9e4t/H/689xv
 1NwDeuz2Ym5ds8y9nKAoSP1TASW0LC4IuUmdfzlq9AAfM2zyP9Bs0uFwi7YKoF6r7hOx
 yT9BRaxnP1riQhn/iZTHJs+0k4O9rgfJDLd2A1Eq+beI98Go0nDJADJsbKljbNJAaQAf
 juyA==
X-Gm-Message-State: AOJu0YyaVNLWnEx9vRTGlxdVHl+pD/SqiHvulzi0oMvIW59SqZwaUVto
 t+G7PHcdl6Zsani/7kRD9cVqX/gT4xh56JP+1scXlta1y+m724Mi39HygkX+/oPBlO7bOMbttkN
 /ZMk=
X-Google-Smtp-Source: AGHT+IG+DCM1p1l82i/3HzP6uSb9V7wCCmTY5X2EQSEGpi8enkSF8+Jg251Ij6nWN3zC+/fzbQVbOQ==
X-Received: by 2002:a17:903:22cd:b0:202:d86:f7e6 with SMTP id
 d9443c01a7336-2039e53a078mr92747995ad.54.1724597572165; 
 Sun, 25 Aug 2024 07:52:52 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:bb79:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0e164b8sm24698805ad.236.2024.08.25.07.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 07:52:51 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 2/4] gdbstub: Add support for MTE in system mode
Date: Sun, 25 Aug 2024 14:52:06 +0000
Message-Id: <20240825145208.46774-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825145208.46774-1-gustavo.romero@linaro.org>
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x530.google.com
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

This commit makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 85a19c14c7..9462d3f560 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -430,6 +430,7 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 #endif
 }
+#endif /* CONFIG_USER_ONLY */
 
 static void handle_q_memtag(GArray *params, void *user_ctx)
 {
@@ -600,12 +601,10 @@ static const GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
         .need_cpu_context = true
     },
 };
-#endif /* CONFIG_USER_ONLY */
 
 void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
                                        GPtrArray *qtable, GPtrArray *stable)
 {
-#ifdef CONFIG_USER_ONLY
     /* MTE */
     if (cpu_isar_feature(aa64_mte, cpu)) {
         g_string_append(qsupported, ";memory-tagging+");
@@ -614,5 +613,4 @@ void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
         g_ptr_array_add(qtable, (gpointer) &cmd_handler_table[qIsAddressTagged]);
         g_ptr_array_add(stable, (gpointer) &cmd_handler_table[QMemTags]);
     }
-#endif
 }
-- 
2.34.1


