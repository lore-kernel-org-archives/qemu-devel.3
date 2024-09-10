Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BF1ECE58D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X0-0007jX-Pg; Tue, 10 Sep 2024 10:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wx-0007UH-A8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:43 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Ws-0006UB-OO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:43 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a80eab3945eso535983166b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977257; x=1726582057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSOOKTU4/ntvh1NQhQ1KOTaJwtvBojTKzDVk3v/UKCo=;
 b=RoGl4P+dlREizikCWeXw5BgoFVw3qhiumZ+le+OHwkUS0J7XDufSPnLsiab8zriiCf
 f7+USNYn+4YQlCfq5LmHWOZGdj1fua60GpQqoOkEN8ysoORHd9MW+9IRj7bERoCLAn5W
 7sJSBBCcrsO27O4+qalN2VxAdXNYDJOLbqT+ul38h/ZgM2PMcfO8ub+qaPwf1YNu9po0
 j+ccBByHA3zL/OQi9eRoZbgEB/kaQaauE8LDsu9rCMAbobZEfBYrxHnoCuGG0sjVeeaC
 f0B3hOSAVVKahG7EMg53672A3xpeQwsG9RQCMHU4jbRCbN9WLwSWVJRdndXbiq6ufDdO
 lTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977257; x=1726582057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSOOKTU4/ntvh1NQhQ1KOTaJwtvBojTKzDVk3v/UKCo=;
 b=iuRSHlYgi8TkpUhereM4lS7zjlaL6PQQZ8dO7RCW4u080G60L9cioBq9o9NPRkX3ZH
 gULrYJvfnuL8lQ3N7QkQGFVA9kacQpoyOLjZX9YE6J039SVpUH+V88zofae+q7XPzyLt
 /Dr6LDkTF9Xpv9GRQ6Qzuxn1x3n4vJPVIeZwS/2hwZ/CyEkRmJ8sU2tWnBETHASZ1tkz
 ddq8Pb3Xr5Uax2sWkaKUEZYAhkxgYWyYC8YqGqhRhKLb4osXSD4lnZ+dkKU8V7ubUhHZ
 icBjkFBSRmpT/AL4hDsVXvAcp/trN8LeS1w7I+F67YG93ZjVKQod8l48XstEUhc5BOQ7
 qfFg==
X-Gm-Message-State: AOJu0YxKIl+G1tVibZiYCN+wM/9HlNJqx8CCYvmMJmSbKoHwvsMgHk0N
 rmMybVinWLUgzDTnJHAJQCLbMBmURMRcfYLfS40V9J7aXwB2mP2L0Tknbn0uaYs=
X-Google-Smtp-Source: AGHT+IEUZn53fDk87zWHtEpTttuo9yKxzi0SdkBIBe7jGlHX0fBIZI/tQQcrUCLzy4+5JDJpceSSlg==
X-Received: by 2002:a17:907:3da4:b0:a8d:6073:2c13 with SMTP id
 a640c23a62f3a-a8ffab8f2d5mr80695566b.33.1725977257023; 
 Tue, 10 Sep 2024 07:07:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d547e5sm487267866b.201.2024.09.10.07.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 38F8B5FA08;
 Tue, 10 Sep 2024 15:07:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 06/26] gdbstub: Add support for MTE in system mode
Date: Tue, 10 Sep 2024 15:07:13 +0100
Message-Id: <20240910140733.4007719-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

This commit makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/620
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240906143316.657436-3-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.39.2


