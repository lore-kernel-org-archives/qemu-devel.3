Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDC6D597A7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAyPQ-0003iE-U2; Tue, 12 Nov 2024 16:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyPJ-0003hI-GH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:26:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyPH-0004TK-To
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:26:41 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d447de11dso4573506f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 13:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731446798; x=1732051598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6PRNouRIX8nn07oym8VUYNLwY1A8W1UJP1nr46hRjQ=;
 b=i+zc2c+P05S/FY69IxARJAXm+NaZ39ML0zi0+RIwyTHnezTyOAa5r3biliSYnmSMZV
 Ih0io6DF84wm+A+99+egp2D9hGdYPiDOIEK8t8JBC0sEnr0CW/sNBbgGn4gq3zOKqwIq
 fAQVyVTEWCWSktn7psBwed1XWXBX17SJ/LuKmC2nt34Qg8sQPpfB4m7bb4KKr2HVnA1A
 6GL6w66IMkuJQx5NTA0MXtrL4k+8+bO9up29FMh52xooUdLI9psnHxSBE5SbVnSnRELq
 n5Wjr1UKBpPOSlyNRPs8DGhDTn1tgRw6CeTRuHaLMy7GvJe5B2IEbBn2Se7o4ynXEvCa
 v1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731446798; x=1732051598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6PRNouRIX8nn07oym8VUYNLwY1A8W1UJP1nr46hRjQ=;
 b=ATsrYYTtYyns+No61zXq+QznNL/1f3wvVKMkGtguYVF2fXvabfY6pAuJ4AAzZ+rvN3
 GLjZLa/epQYAdpqxQeeCnsIKAWXXJHq4op6dTnkGaXDd+dy9FqqoEbv9RpSRCwynhEnj
 r8fbCsTEvTPaR564shCMfeMCFHufU8c5Hz0TjPdL5lEbcdmbrxD2bix0MxXVDuwzPb25
 bh2N0P6Y40BGySyerWCYx8RJUku8qMuccC5EA6WwpNrjeYjS+2IdOgMtJLV4vM/v1u0U
 PNgfVoexhY/ZbwjyYfPrAyBAjJC7cXsgIw8hdKNcRaIlalrhmDaEeFDQIegXxPmPmjpj
 jIuQ==
X-Gm-Message-State: AOJu0YwHeUqUbp4tp4zsioMzi0pmsNi0JR1/op/EZldVFtZkKvekHWc6
 J5LZyFolSs0zjAGk7m1U1wku+ljAhoawgFXQtDKMPI1mij2crMEKJmFjBWCHLpva5i82SGH5qdw
 p83zw8g==
X-Google-Smtp-Source: AGHT+IGz5K5BN/oQ6EgL7be61r6JWiGEb6+cc/PIGiL2DbkzP9Lyt9t2aO8qdm/R2t17owW8cm8Sgg==
X-Received: by 2002:a05:6000:1566:b0:37d:5173:7a54 with SMTP id
 ffacd0b85a97d-3820df8cc0dmr431056f8f.52.1731446798393; 
 Tue, 12 Nov 2024 13:26:38 -0800 (PST)
Received: from linaro.. ([193.32.126.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ec202sm16613515f8f.83.2024.11.12.13.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 13:26:38 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 3/3] plugins: eradicate qemu-plugins.symbols static file
Date: Tue, 12 Nov 2024 13:26:22 -0800
Message-Id: <20241112212622.3590693-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
References: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/qemu-plugins.symbols | 59 ------------------------------------
 1 file changed, 59 deletions(-)
 delete mode 100644 plugins/qemu-plugins.symbols

diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
deleted file mode 100644
index 032661f9ea7..00000000000
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


