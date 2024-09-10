Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0846EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4pw-0005pY-5Y; Tue, 10 Sep 2024 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pc-0004pw-5u
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:13 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pZ-0004ak-OI
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:11 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d29b7edc2so474940166b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725989948; x=1726594748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JYCYUJifJOf8IAr8uZJXdISd8++rwC9FrhK6nCyU7M=;
 b=pzDz8okpSnvB5sZALhzWB4nYHRQVcicma5IhzJylcfpfDfuGaDrPtk2rr6dUjTo4pK
 cCU6WufHroT/s6Pch9cLsUN5o2cA78sN1D9CcZOaibRx1+tcaR0lLcZfQ+dlnRUvabpF
 CVNcujBvNemihuc9gf6K6k72CHJvO1la6xqSYigL+YdbEP3deNBGuqIrQeEdhXVLH40z
 AB9EMTyphn6jubOeQ20nnaUMFsRmnSheZmF+ZyZHfMk1I0Ig3vjYg+7WBtUqVRDWlYdP
 l08wxCaP2dI6qBNgD5wz/6oHyo2Figa3nemIiv3uFcpltedm1zfH1Ya3BFXTMjy6AVq4
 4BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989948; x=1726594748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JYCYUJifJOf8IAr8uZJXdISd8++rwC9FrhK6nCyU7M=;
 b=S6BJCSxzNrq4ytYNsm7klRftSnpGQWaIcWiDyRKYylgvyX1ZMXCGFx6CTDGVsf4ugS
 ckjKH824U1+hSL5eAYUqmaZHkiPXqiG01BpkkgWXU5pOfms7zfPQul2k42wg/9hKIzkx
 xlBAZCVnkVv7Pug1OA65vOt1hw/gVji1/29tMTJsattCaBFcFxz4rv2dOt3vznf8vHtg
 lhs1Dk4heM5wa7bMrQr89eW7vTRBi+RXjRNTIqK/WmlVhWsoIx8CCjXoQeJFBYmBuE0r
 T5hSu23yNWI+Q6cDgIuLwSFjAwYSTqMNLVicbgkTBJXa2XkjE5YFJ6PTveemB0ffzTxo
 ZKjw==
X-Gm-Message-State: AOJu0Ywl8Z/1kJiTrHyKojmrTw/NzoXCX0WEf9+n2vrk1fYz1ZKW/4Bg
 5Rrwf0mU16PiXhCKCsdafqvUMTlR4bpkIpkqrUf+Xn8SpUinax2Q2NdKF3rvxn8=
X-Google-Smtp-Source: AGHT+IF01JF6bkpfXUUAD7B8/SqE9++NilsryYre//MgoT1zo4BQkG9c196L9fAV75D2WwY7jhIKCA==
X-Received: by 2002:a17:907:7fa8:b0:a8d:128a:cc49 with SMTP id
 a640c23a62f3a-a8ffadc8c5amr121943666b.52.1725989948025; 
 Tue, 10 Sep 2024 10:39:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2597ac96sm510004966b.73.2024.09.10.10.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:39:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C1475FA0E;
 Tue, 10 Sep 2024 18:39:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 07/10] gdbstub: Add support for MTE in system mode
Date: Tue, 10 Sep 2024 18:38:57 +0100
Message-Id: <20240910173900.4154726-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910173900.4154726-1-alex.bennee@linaro.org>
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

---
v2
  - while we enable system mode it is still TCG only so added guards
  to handle the --disable-tcg case (native KVM and Xen builds)
---
 target/arm/gdbstub64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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


