Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D5AC5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 22:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOOrw-0005Cm-DZ; Sun, 08 Jun 2025 18:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOrj-00058f-Ry
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:48 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOri-00031I-8r
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:47 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af51596da56so2549483a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749423105; x=1750027905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=FKkPNrKJjoakvx2UL4lQYZU8yx4hoSerCb9r/PHN23e+cuO2qlGaRNTwkW0bIPYodG
 PtQ1Fffii0NdoewzJsVHR7Cf3rBxaUIlEjG4VtFwDeyGJAcBaDMLrdV0F6c4K30S96i7
 LWaO8GVLt+3geS77931EV7V5exQ27aPLXEk6lceL0BS2/xBZ1DpTk8MOWZxI1sd2l/ez
 IRzh7giJHTl6iRAt3tS/yaRH9O4rmEOxIYN9pSykfoN4RsGeR5bOHdeDATJXR8PZFabJ
 U1t1RG7EfcA/mZm1HUHuGN68Z2OKe3NciRDo2pMSurPyfJj+S3TUTposkLNtSzDPimOB
 7Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749423105; x=1750027905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=BZCSImneNpLCLENn6JVC+Ot1kDAXrapau5vD5QGklC0WGwhm7tZ/46VYe50gwTJFjW
 gBZG2d0igRgguXhP9vVXrzhrYDg8Oxz0TWo9t23UyCOzTroYDwbsMCeBBWJ1XfQsu15e
 G3ZSmDAo1ERXzaFmoWHuGYu1xkJXc18U1lLOKebI9p9U5/LYsNWM8McEdjbwdT1Z6Rd1
 u6R5DHSBzJ1Srnd4yHXUI/HPqhIImwRgyBK2+cAuJpcsW4meKQaVzQ1eXYIbkWz5zt+S
 cxwTKTcjeZ0RiN8C0ppEKJ9CqShX9NJPE0ta32Sg6cCvYCGRPBDBJDbRzmGZtwus7MmC
 LfBA==
X-Gm-Message-State: AOJu0YwfRWfS52hURyNnmbLs834vmrl2y+Axe7CabchbgV6AGOJTdN61
 eqOs8flp/lzryGe2jW6ZPob0aFmdkV/fKwjHhSwamAvEczNphYuTez8HdtLNVQeYtQE=
X-Gm-Gg: ASbGncsN6EJdQTCsUBplZgM5KIR6WKCzJTKskKew06vjHEb6EiRE47k/+RgaiSyprEv
 k1cHGVssfUcZSLyrMUWUi0lL60V5xess/B0S1IaNKs9oGBhAnUzxbIHacRVQ684IPqM7gWZDgwn
 rrB8ySX3w7EO0Smr259Tx5AWjXR26s34OGOOnI5LUHFdofHo6Jty4GHf9KUce51GbuHW9j0VkRA
 XqUb+gILt/YXdiwl0z9CA0NRlPyEiMwb+FaMF6otOc3exNMqF1et1Z7vMkdwQ+TXPC1omOxdj1O
 SQZ64kor1POdo0ko7wSaM6vKJ8E2/e/cFcQId0DXZIUtMpSoX/zo2EqeEePVcg==
X-Google-Smtp-Source: AGHT+IHvzXvHO+40grYr+NnwvJegJs408G3u//dG6qX8nLTkti6x1WVnsC48WUReXqOQ0+S08/Pp9Q==
X-Received: by 2002:a17:90b:4b46:b0:312:b4a:6342 with SMTP id
 98e67ed59e1d1-3134788faefmr15811422a91.33.1749423104709; 
 Sun, 08 Jun 2025 15:51:44 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b128012sm4395970a91.32.2025.06.08.15.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:51:44 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v8 8/9] plugins: Remove use of qemu_plugin_read_register where
 it is not permitted
Date: Sun,  8 Jun 2025 15:51:35 -0700
Message-ID: <20250608225136.3340370-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608225136.3340370-1-rowanbhart@gmail.com>
References: <20250608225136.3340370-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x533.google.com
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


