Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD3AC5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 19:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMBHh-0004Nr-DG; Mon, 02 Jun 2025 15:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHZ-0004L6-KR
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:17 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHY-0004rv-37
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-745fe311741so5385041b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748894234; x=1749499034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=G6jZFLph4ULt+oiG5U/WyNbFOGgUBrmp9AKctRS8sMVfUMkrCbN0+/H1bmbdF94CFV
 SKuHR6sMbhd5UuQWuuEvQipr0pi51JDQKbbMyL44Yt91jvxXpncRkXs6W2RcUzDaDDzl
 3e72iNJ/1l2IfpBTTfHbAE+5LEKolVrPrZW0gYh85c9lVIpi7N7eC+eUq2fNpGN2Y7mb
 Cqwb8rTB9pf+Aou0NpBOZPIwvTOO/g7dKy0xCwjMlLMBkJZW/wUsS52R0pruvY0eCfgr
 1XZayewM7+i7eLE/f2UlIHsshG4JZhK//HKkLv6taHt4bQiTv3N9dRY9XxBNsAXhf5Xs
 I8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748894234; x=1749499034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=husAXKBPUFBpxRsR3Q+jYuzw2/iEHAD924OrArqfS+7C3MycBBWfbpWJhWuQIyBSBG
 85g/JLtJjYd4ZbfygIym/r3pYw5+0UXVLVeNlvFj3NjM/nXkvANfXFlNEjoYsSFJkmd8
 +BF4IDsd2A2xRmfsiXJMvv0za5B6a/qlgqPasb8c138Hd59g73Kx95gumBRw1Pw7y+Cw
 Iow6NdU6Ma1DSSn2EAUDWHPwdlVdmHWS+ubQSZjiLOOea2XkzxUqll+fAYCEBqYBrQ6D
 P90hfF7/DOE1rvS+h0lBi5ws1TtobadiYL0LeOOuwVdZXT52V8LY9y0y9ERXwDeyTP7N
 GHUA==
X-Gm-Message-State: AOJu0YxubzBflQZpuJm9Qu6C8dfJj21P0oQBJQqhD9L+9CyAa+0iACwl
 7cjq83teztfWK3FLRtR4+BjOsDu3xsommETdEjJdN9bU3aSiuXJmPg+YCC+Bleiq6rE=
X-Gm-Gg: ASbGncumoOABwfk4VKyzA2nBiE/7bEOZqkbcM3p8PjLbQIpGawcGMyvCHcycC2IpDsG
 mj83OHI71ki0kApYZp8njexwE/i0xTltc+hDTUD7v73c4QhmdUbVgMeEJmlFaJ2aWEFUtHbBT89
 VZ5Eyk83d/AFapDyxUoY07vpF6KdArdyhwZtub6tIaGGQkzdddbVeGb+uKAazimdTkkcATGJroS
 l9fRkmulfS4rWfos2DSaU6KZTFV8n6EgkYWEINyfV4VtlS99s1R/Mv3r1E04i7DnA22yAFtMu3i
 pWJpzQ1KHKSNdRjwbvyMjcQvOjv/cupC503Xv2q4Lyt9be3yvVA=
X-Google-Smtp-Source: AGHT+IHtSXVs0JMwcfePpEbT3btMIvybKvDB0rU/r+MCntU49weDv8tytAu2fZpSzh6VquBTSxaJAQ==
X-Received: by 2002:a05:6a20:3944:b0:203:bb65:995a with SMTP id
 adf61e73a8af0-21ad9799507mr23134054637.30.1748894234209; 
 Mon, 02 Jun 2025 12:57:14 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab820sm8244575b3a.60.2025.06.02.12.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:57:13 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 8/9] plugins: Remove use of qemu_plugin_read_register where
 it is not permitted
Date: Mon,  2 Jun 2025 12:57:05 -0700
Message-ID: <20250602195706.1043662-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602195706.1043662-1-rowanbhart@gmail.com>
References: <20250602195706.1043662-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch is required to make the insn plugin work after adding
enforcement of QEMU_PLUGIN_CB_ flags in calls to read or write
registers. Previously, these flags were not enforced and the API could
be called from anywhere, but this was not intended as described by the
documentation. Now, the flags are enforced and qemu_plugin_read_register
can no longer be called from a vcpu_init callback because it does not
request the QEMU_PLUGIN_CB_ flag (nor does it have a mechanism to do
so).

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 tests/tcg/plugins/insn.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..265d3ebe9e 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -81,25 +81,6 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
     return record;
 }
 
-/*
- * Initialise a new vcpu with reading the register list
- */
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
-{
-    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
-    g_autoptr(GByteArray) reg_value = g_byte_array_new();
-
-    if (reg_list) {
-        for (int i = 0; i < reg_list->len; i++) {
-            qemu_plugin_reg_descriptor *rd = &g_array_index(
-                reg_list, qemu_plugin_reg_descriptor, i);
-            int count = qemu_plugin_read_register(rd->handle, reg_value);
-            g_assert(count > 0);
-        }
-    }
-}
-
-
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(insn_count, cpu_index, 1);
@@ -295,8 +276,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     insn_count = qemu_plugin_scoreboard_u64(
         qemu_plugin_scoreboard_new(sizeof(uint64_t)));
 
-    /* Register init, translation block and exit callbacks */
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    /* Register translation block and exit callbacks */
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.49.0


