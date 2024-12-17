Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768E2E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3X-0008Eg-K1; Mon, 16 Dec 2024 20:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3W-0008EK-CK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:22 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3U-0004wk-NH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:22 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so3626402a91.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397639; x=1735002439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHLhWvJzE9yDVjpN1hr16j3rbknmxcBsd3hvunSMfeU=;
 b=vSRHyDF79BOA/Gm9L54V2toLii+Jzg9uJiX8PcrovvQswTU/fXaBWm+TTr95eiFYWb
 8tSpCRB77pDjCEcU7UpG5PvUPI6ZwMgv7VgnTQZ7LhdRwK8jeeBHrz3sdTsUXfKRe/o6
 d/ZnEYVNjM45+XwjnbMRF1yJ4Kur72gHgkCe5NiADVZmsDbff5qUMixJU6k6vKcTyEuz
 bLI4QuG1itQAyd4VMAoscsPbfksvOb4T8SfRBrtwf/wGR5l5EO2Wsg0/hKAsQkKSoCg8
 0pwKmyDts0H3OEwfziBw5FP4zY3teBEIlk+dsOBrlAsQEbp6hMP4rvTWmu1HvCtGFYkW
 zF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397639; x=1735002439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHLhWvJzE9yDVjpN1hr16j3rbknmxcBsd3hvunSMfeU=;
 b=wg5bVTnifFh7eQAePH+VoCX35l+x1S3AbbdOG7K62SwbhbGWS3g4ryjya2rgCqyhZp
 VheXB98Im07oj6qy1qJ3lqvBNzXltM2oB9t1GoM0p9OyWDeGmq2wVmkTYzpUilx58Abc
 Al0IL+k7uM3x7Vd0fi4AvBJ3FdCSNvtOwfAhSk/BuP19nCvrg8U5sYeAYjumnX3rSPPj
 EnCdndytbh6Y1XeCLd1qu0xUIQqcRbupENTDgdiseXmwYzoszyEeMF2uB80p0WsV+XP4
 wpXOINEO0mhvNTzrYK0y5zIeoxVKYOCE84PrVWg34w3plduB8OmY27mfotHB9GyY/Lnu
 Ob6Q==
X-Gm-Message-State: AOJu0YxlEtoKu7QHsK0U5HJuBsv6bBl8JWRCZp/DNPTUnMSSs5AVCHLA
 eO43xp091tCYiG0YlskpmPOg8aGPAT5K/0nJDSeG1Kre7Pbz0G1xl3CKOG8fm8GT3DIQuX1weHy
 W6tE=
X-Gm-Gg: ASbGncs5RX+jY5VYKGm/+0Isxem3cp2obeLVunQC5krp7ADtQEstIjLPrwd1WdxKio3
 Et6s1PkfZ8jgOEiACT0KrrEHlsqFO1vkxo+lQgFBHGiyQ+e+OYDhNwPGAetkQDC7FQwETAzCa8j
 ZLpIZj/5Zb2rF2mJCZ0tYjA2bzEk6iZe/UNUBKa5nT92QwXGDKWtcU0MQ0RW0t5FoxI4+Idze5L
 vFkfGmGzHUlMMi0wktooVoVWS5a8T77CF0+surpI9zm2zaNM5VgeIx2c4KZMWo6rE/agqjTAyi4
 J+CoAUYeekLTPHU=
X-Google-Smtp-Source: AGHT+IHza6cg6eyKEENmsA6Iq+520XWEenY5dUIP7iHqsZ84vBE6hXHET+dhMEV+nkX8NGXH8TJxbQ==
X-Received: by 2002:a17:90b:2b45:b0:2ee:d7d3:3008 with SMTP id
 98e67ed59e1d1-2f28fb63badmr26648042a91.12.1734397639024; 
 Mon, 16 Dec 2024 17:07:19 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 01/13] plugins: change signature of qemu_plugin_insn_haddr
Date: Mon, 16 Dec 2024 17:06:55 -0800
Message-Id: <20241217010707.2557258-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

It makes more sense to return the same type than qemu_plugin_insn_vaddr.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h |  2 +-
 plugins/api.c              | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 0fba36ae028..1fbcff6e1d2 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -537,7 +537,7 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
  * Returns: hardware (physical) target address of instruction
  */
 QEMU_PLUGIN_API
-void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
+uint64_t qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
 
 /**
  * typedef qemu_plugin_meminfo_t - opaque memory transaction handle
diff --git a/plugins/api.c b/plugins/api.c
index 24ea64e2de5..17b3a65e773 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -283,13 +283,13 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
     return insn->vaddr;
 }
 
-void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
+uint64_t qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 {
     const DisasContextBase *db = tcg_ctx->plugin_db;
     vaddr page0_last = db->pc_first | ~TARGET_PAGE_MASK;
 
     if (db->fake_insn) {
-        return NULL;
+        return 0;
     }
 
     /*
@@ -300,14 +300,14 @@ void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
      */
     if (insn->vaddr <= page0_last) {
         if (db->host_addr[0] == NULL) {
-            return NULL;
+            return 0;
         }
-        return db->host_addr[0] + insn->vaddr - db->pc_first;
+        return (uintptr_t) (db->host_addr[0] + insn->vaddr - db->pc_first);
     } else {
         if (db->host_addr[1] == NULL) {
-            return NULL;
+            return 0;
         }
-        return db->host_addr[1] + insn->vaddr - (page0_last + 1);
+        return (uintptr_t) (db->host_addr[1] + insn->vaddr - (page0_last + 1));
     }
 }
 
-- 
2.39.5


