Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE2CD58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFayz-00073u-P7; Mon, 25 Nov 2024 10:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayp-000703-8Y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaym-0002Yt-6K
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so4514255e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548379; x=1733153179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwRDTRQGY0zbI0152zlPGQl3hD2A8MDzl25gnWUNB94=;
 b=UMzoZpOcnNotx2/O5Ov+Ss0nX9qOMVTQh3RKDUe8spydFKYsG4B0K6Uox4jNsFicSi
 k6MQ6eSG2HZRUiSl56zSm15FxhUDN3fHwBdO4GrFO0V8DtpvF93e0d2roboiRP380krM
 t3bIxnKyvk6JgdNJLGl4zV5z8RNzUsFs8L27dgVKF1vPlN0xX8mzM1y0vIrqZnLNtPlQ
 2uIx/82LbMTPDPRqzNOuPeVwsfRg946pf6V6HxMWKBYLv/m9HGoT/nOIWoDSW5lzDzAz
 qzjnTv06jVSKLTfq3f7aofZW05CBncWHhGTNVcXkeOa9DQTWD1LIXUYXu2/Zp+41iPRG
 jsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548379; x=1733153179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwRDTRQGY0zbI0152zlPGQl3hD2A8MDzl25gnWUNB94=;
 b=mWdtCOcLsLyEjFBRfLEi9sy26YAGwmsdQsRhICNL2u+gptjA/Jf2V2o8EgnJ0aJvT+
 9h/kkQa4djAVQf1fM8XdFVIDME87ctSqRoIUxrWif1+1Zn5oEmrdPfNX5qhCLG9PG/F7
 n6dLWwsc24QmvyvfnL6uSBCrJLbGn6PuWxVFghgcHchWdRmdtuXVC/tsXJHhzSBPQNEC
 GXltdWdF5K0CaTqMAUMHWkrb7uPpY26E83+TePb5ImKUmcrHogm4HA4evtm0pNHLZPr6
 QS3uGFKkzl3vpqkpshK/9vrSCmdqQ8ua94gKwUfHSN5Gsph1VaPHAeAnDhSNtD12MwEA
 v5MA==
X-Gm-Message-State: AOJu0YwFZRdOtq6SBRNzQbG8Uy1JCfH+aW9LBzWKWxm6CUTg9bXs4ELA
 E+ersRYtND4+BALFlHLnjYaRXQs2nw9ARisoUDFqLzKLhN5LNcAkL95kieccd2U=
X-Gm-Gg: ASbGncunEpQdgTAHCnmacgq/e4VeAlVkxoh9i5lHLt6caAiS16Rcg6cTZi7eqlru58p
 6iR57kYqtINJmSdjkt3qQjhwy0sVFjSizwyazxIMRP4QFN+AJKwtcHmxcAjZESUu0ZLMvdwSdkb
 lMRQt4z7bSApnp/e+WN7N8IdpHmSnYi3Ha/+S/9mpDpafVbRjweIUO7iObBcjJWD8X4SOwXOMBA
 mKwvjyBjXFDAjM1UHcwFwQjaNkiWRMmrSzH83rC1YkwqtDL
X-Google-Smtp-Source: AGHT+IEcdPf3GD8xS8mve7R6P5d3eZCdHEwpFk0puZ8HKU9BDupOwlH6/NcsHguKeVI5lSAtI3snuw==
X-Received: by 2002:a05:600c:348b:b0:42c:c003:edd1 with SMTP id
 5b1f17b1804b1-433ce41ce4emr136359265e9.10.1732548379357; 
 Mon, 25 Nov 2024 07:26:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43498a31432sm75044365e9.28.2024.11.25.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DEB4C62A14;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 23/28] plugins: eradicate qemu-plugins.symbols static file
Date: Mon, 25 Nov 2024 15:21:00 +0000
Message-Id: <20241125152105.2100395-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241112212622.3590693-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-38-alex.bennee@linaro.org>

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


