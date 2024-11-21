Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACD4D7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAfx-0004xo-2L; Thu, 21 Nov 2024 12:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdv-0000lk-Hs
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:07:00 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdW-0001gG-Ku
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:59 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53da6801c6dso936017e87.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208793; x=1732813593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgZL1p3wxKFTGq7aZgLMn4pj7CkquD2VdyBofPgLEys=;
 b=OoU360Gxyfnnj/wnNujwHrc8YcyOmIW0QObGKzHupWDSo8vInb4GQCsTquzCDQwV1A
 7w1y8qbGe3sfwzgNbVDU/ooJ6pD06Im5xXhWJb1KA5nWEyaxIfkiHTsR+bhXTrtWFXrX
 tSGCeOTZPXYj91syUutrs1peTMqXo49K3FtQr0IfJOyt4kvjUo0bWGzM4BMxrqk8NTKB
 xjIxRdzOTepygSimhh+S+EN/l9MZJRpcO0GLNNtmW+9j6ZNl0g84HNCXIUsCyuMg11FR
 1heKbyUTwCkxNfJZqLeyEs223ALr2Tg/EwTrKiSDDApoMZjyL4vwPpTjmTgjhWn7iYNL
 BFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208793; x=1732813593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgZL1p3wxKFTGq7aZgLMn4pj7CkquD2VdyBofPgLEys=;
 b=qt97LWfK0cGwAivD0U7bsuWgB9YfeNDgYSp1sjHEzcJZxLhHIktyUmZpCQ61dJI1GB
 icjYGS0+k5VZ8D5+ogtTkHjeS017U+Wp+3SJvuN2cMV5d1CmZTtoHNiuN3Z4LPpdm08T
 9QHDv9hzJ3Zow+iU/FIvpNYJk7o83d2zLlqx14l3TP8kxXxfBRJWlZSFfe8j1tJfeMFV
 nsPh0swBoXtMdPzxDogBURh1yuhMS1IFu7RWexiEXqCzqn2bUHzaFNgdYD7R6UZoLK0O
 Zh0pqCNUC1ZxAVu+nlmjAWbvilMwP7M5tYiaDDBheZuaIq10RGkqaMPjAfloko1WcoL7
 fq6g==
X-Gm-Message-State: AOJu0YzVuUw4Al6N06Pt7Qo6hZa8Bly+//aMQcf1pjnVRlnZxwGSIc/d
 J0XIBRGjJWpFGJxqoQ4gaoMcd8ZRx8S3Bp/+ierGAMklC9xAdHy9a9wMJl4spxg=
X-Gm-Gg: ASbGncvyH2sLzG+G/Z+HnSh2pZaz34ha2P+KaorXqsMEqTTJ8fl4Rq3J9HPyj5sovdI
 dsiROysTuoj5v2oBkoaxhj8fm3bO/1qkPkwmPKou7Dm3MnuOn7NHdUyVz2v2UpIhRUGy4/0Hq9t
 Kejo0zTxXuXd0XOBdTqimjgV6baQbxX3BnJhJ+Fw6BMbox7b8zZUN3J98uPQkNpkv1u3DpPXlzx
 ib0vs4adxwPCX4+0Yinn3LT/LQ732eoUiDQrBRXzGEpKNsb
X-Google-Smtp-Source: AGHT+IETfgPdY6o96NTpOjJUFb1p4rkJqV5zzgwNRvWB+34h0tqC48BBhw8Nuk4I/K/N+VJlhA/4FA==
X-Received: by 2002:a05:6512:2215:b0:536:53f0:2f8e with SMTP id
 2adb3069b0e04-53dc136791cmr3971935e87.37.1732208792448; 
 Thu, 21 Nov 2024 09:06:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d170esm61613865e9.3.2024.11.21.09.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C9DEA5F77B;
 Thu, 21 Nov 2024 16:58:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 37/39] plugins: eradicate qemu-plugins.symbols static file
Date: Thu, 21 Nov 2024 16:58:04 +0000
Message-Id: <20241121165806.476008-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241112212622.3590693-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/qemu-plugins.symbols | 59 ------------------------------------
 1 file changed, 59 deletions(-)
 delete mode 100644 plugins/qemu-plugins.symbols

diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
deleted file mode 100644
index 032661f9ea..0000000000
--- a/plugins/qemu-plugins.symbols
+++ /dev/null
@@ -1,59 +0,0 @@
-{
-  qemu_plugin_bool_parse;
-  qemu_plugin_end_code;
-  qemu_plugin_entry_code;
-  qemu_plugin_get_hwaddr;
-  qemu_plugin_get_registers;
-  qemu_plugin_hwaddr_device_name;
-  qemu_plugin_hwaddr_is_io;
-  qemu_plugin_hwaddr_phys_addr;
-  qemu_plugin_insn_data;
-  qemu_plugin_insn_disas;
-  qemu_plugin_insn_haddr;
-  qemu_plugin_insn_size;
-  qemu_plugin_insn_symbol;
-  qemu_plugin_insn_vaddr;
-  qemu_plugin_mem_get_value;
-  qemu_plugin_mem_is_big_endian;
-  qemu_plugin_mem_is_sign_extended;
-  qemu_plugin_mem_is_store;
-  qemu_plugin_mem_size_shift;
-  qemu_plugin_num_vcpus;
-  qemu_plugin_outs;
-  qemu_plugin_path_to_binary;
-  qemu_plugin_read_memory_vaddr;
-  qemu_plugin_read_register;
-  qemu_plugin_register_atexit_cb;
-  qemu_plugin_register_flush_cb;
-  qemu_plugin_register_vcpu_exit_cb;
-  qemu_plugin_register_vcpu_idle_cb;
-  qemu_plugin_register_vcpu_init_cb;
-  qemu_plugin_register_vcpu_insn_exec_cb;
-  qemu_plugin_register_vcpu_insn_exec_cond_cb;
-  qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
-  qemu_plugin_register_vcpu_mem_cb;
-  qemu_plugin_register_vcpu_mem_inline_per_vcpu;
-  qemu_plugin_register_vcpu_resume_cb;
-  qemu_plugin_register_vcpu_syscall_cb;
-  qemu_plugin_register_vcpu_syscall_ret_cb;
-  qemu_plugin_register_vcpu_tb_exec_cb;
-  qemu_plugin_register_vcpu_tb_exec_cond_cb;
-  qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
-  qemu_plugin_register_vcpu_tb_trans_cb;
-  qemu_plugin_request_time_control;
-  qemu_plugin_reset;
-  qemu_plugin_scoreboard_free;
-  qemu_plugin_scoreboard_find;
-  qemu_plugin_scoreboard_new;
-  qemu_plugin_start_code;
-  qemu_plugin_tb_get_insn;
-  qemu_plugin_tb_n_insns;
-  qemu_plugin_tb_vaddr;
-  qemu_plugin_u64_add;
-  qemu_plugin_u64_get;
-  qemu_plugin_u64_set;
-  qemu_plugin_u64_sum;
-  qemu_plugin_uninstall;
-  qemu_plugin_update_ns;
-  qemu_plugin_vcpu_for_each;
-};
-- 
2.39.5


