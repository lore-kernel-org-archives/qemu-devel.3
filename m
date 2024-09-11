Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE383EE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH82-0000yj-9M; Wed, 11 Sep 2024 02:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7x-0000fu-NL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:57 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7t-0004Pg-9q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:55 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5356bb5522bso8260637e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037211; x=1726642011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLs1gUYVWKM0j1iUsQtfNi5LsHTLadgSNPZsoYPZNTA=;
 b=a/Nknb+IeLAmAFOo/n22X70SuopQJlAThz8MfrM6cLCQo0IbOFXvoxhy5BgXsfDWBy
 pDxzZsA8Mf511R3ZauMA1t6oa0dIP6eOc1TNCpMn8amrjqG9VJXLO274lIcfzpBNlTU1
 CT3zuz+Wc0jXpdWjrjslPUefVdQS6q81Rwean102gK0cvEPbrQNd5LO2igaB3XxW7crO
 p2sPpqUKAfE+3AR9TQnS/JFZwJLyRMIrc7Qz8vjgXNAY2AAfsT4mCLbXOkwMuM0gna3r
 xTt1vabkDHBVfPBmEPuxfKfOrAPU73SRxJnCBP6Fv8P5QOfdPEP1R3Klsb/BNFD5b2qN
 1Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037211; x=1726642011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLs1gUYVWKM0j1iUsQtfNi5LsHTLadgSNPZsoYPZNTA=;
 b=feUW9qWepvEbNFfaSBe5NVDTQhcdhSpKvvdWVOA5myC7Vcv24cmUWHGFhRq/qvC5cR
 /7p1Anqp2lTr+jmr7tLwrhrnRzOIKqBQm9nyAe2cuKxd2zje2qWrK9+xVLYIJdVlVesT
 5XwRF71X+/tjvTwi+ndLdL/E3edxUSxPCIjs3uL3bar3IgENW8HiSdN1wdnHFW8j8ZJZ
 0T161D0/R6OUEEo5vTGlPZ1RslQ7PhdCO0L3LIDHqUz7jpDRo8Y+q1uf7qaEBYbm5gNU
 4g2fnxGErRuVgZb2C8LoDWeyssK8+N3i4M1wzsyNj774ULUUV7ADQ/EM3w9X7c8C0CMy
 L2BA==
X-Gm-Message-State: AOJu0Yzd/7G8XBXUjiWrByTijKNwu1IzjRpPlj/P9/9J8JvlpZPST9m/
 VPs/c0duYaXtsoy0vPAUPOC4XhopfT3ojpcNJs4MPcM1GNJ6k8vK9H3rkUtOJYk=
X-Google-Smtp-Source: AGHT+IHuRriIQeEU8V7Ac5KuyA8l6xuuEUpn+tEJ6/t7ZSOzeAUGNVtiDlEX6WmMJ9Nz4IPIm0T2HQ==
X-Received: by 2002:a05:6512:b03:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-53658814414mr11023859e87.57.1726037211300; 
 Tue, 10 Sep 2024 23:46:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46824sm5059241a12.23.2024.09.10.23.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ABBF85FA14;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 07/10] gdbstub: Add support for MTE in system mode
Date: Wed, 11 Sep 2024 07:46:42 +0100
Message-Id: <20240911064645.357592-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
References: <20240911064645.357592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

This commit makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/620
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240906143316.657436-3-gustavo.romero@linaro.org>
[AJB: add #ifdef CONFIG_TCG guards]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-8-alex.bennee@linaro.org>

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 85a19c14c7..1a4dbec567 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -430,7 +430,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 #endif
 }
+#endif /* CONFIG_USER_ONLY */
 
+#ifdef CONFIG_TCG
 static void handle_q_memtag(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
@@ -600,13 +602,13 @@ static const GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
         .need_cpu_context = true
     },
 };
-#endif /* CONFIG_USER_ONLY */
+#endif /* CONFIG_TCG */
 
 void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
                                        GPtrArray *qtable, GPtrArray *stable)
 {
-#ifdef CONFIG_USER_ONLY
     /* MTE */
+#ifdef CONFIG_TCG
     if (cpu_isar_feature(aa64_mte, cpu)) {
         g_string_append(qsupported, ";memory-tagging+");
 
-- 
2.39.2


