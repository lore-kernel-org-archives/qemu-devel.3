Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69715C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy4B-0007Yw-Ga; Tue, 13 Aug 2024 16:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy41-0006hd-V4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3Y-0006Je-Fs
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3685a5e7d3cso3639570f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580625; x=1724185425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5zKsXaXwrEo4pGBpcSfU84L/65BuquefdOBBeKcqhg=;
 b=cPVvYHJafNG4aZYnutbCAah1kyFesnq+5VNbyTNqI9+4zBDHyDb+t93UUtiE6KltBI
 9c7GUQUTaUzcsu5i/XsltPEMgMhVCFbI8GCPK/2x9sk425z49NQ6OB2EOGNFCPL+d7q6
 JnioTUeERV6+sL1WCfj+Iqv1c2QO3QIyaLWGXddvrrJOuSkmOzt4zLspMmOH46/lYHVj
 rzWbqpuax1My7/8zPZo6CKeAYv/ZKEjQRTrasjhzbEMu0et8UOpNE0D0lBhBcHTXpjwr
 k8zjuJZN8v6BtaEAGMC+mT36Do/X4SP7mOeMOoO1us/hbiIOgBzjfh9z4FKs+RKS9WEN
 cXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580625; x=1724185425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5zKsXaXwrEo4pGBpcSfU84L/65BuquefdOBBeKcqhg=;
 b=PPLNY8dAgRQsiCXHeJKP9QPq7WLzsykqP2BGopuFputj1AtNOzfL7BMC8oJ38FGxyQ
 rhgJid5b4i1K21EDd+CFSS/7gFK0pqm9JPuyQLOwLP2vIM3wA/SLuxxsGP9O4wNQX1+J
 TN1rZgLXvkKsKQifDS69RWKDbpOzxYgzp7rUNYVGPqfBNxL+OXkGVDLMHwMmHuLMAyBX
 tEW1TAKPoLcP0lh9Upna7ulo/4iYANMDqFy+eZgQDE3wDUPSuZxaN/bi2uwjc/XvDN6r
 dzHcp11Ui2siCRMoo4Yhn33YPCSzDUHxVRsesSW8HFijNlAyLBBICRI6xHXSy3ls/goR
 OfKg==
X-Gm-Message-State: AOJu0Ywpf7dlEsRagrz5AriZ9bcHBNNSOrTM/d3dQrWJtOvz4HTUTNDd
 ZuP1L1TIxpHHYJcs+Zn2I6lPTyoEZWlTb0ZiOuE2yeom3tVI4r2TSlC7AoKUYTc=
X-Google-Smtp-Source: AGHT+IGArDWsoEcwOvzn8dC0t4xiaFUC9edLbCVkwWxOqo9exwED/2QoMwGKBxVP8u16sG+Z1jDXRg==
X-Received: by 2002:a5d:4985:0:b0:367:9769:35b0 with SMTP id
 ffacd0b85a97d-37177756b87mr471286f8f.4.1723580625112; 
 Tue, 13 Aug 2024 13:23:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c36ba5csm11299186f8f.2.2024.08.13.13.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7859860773;
 Tue, 13 Aug 2024 21:23:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 21/21] plugins: fix race condition with scoreboards
Date: Tue, 13 Aug 2024 21:23:29 +0100
Message-Id: <20240813202329.1237572-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

A deadlock can be created if a new vcpu (a) triggers a scoreboard
reallocation, and another vcpu (b) wants to create a new scoreboard at
the same time.

In this case, (a) holds the plugin lock, and starts an exclusive
section, waiting for (b). But at the same time, (b) is waiting for
plugin lock.

The solution is to drop the lock before entering the exclusive section.

This bug can be easily reproduced by creating a callback for any tb
exec, that allocates a new scoreboard. In this case, as soon as we reach
more than 16 vcpus, the deadlock occurs.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2344
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240812220748.95167-2-pierrick.bouvier@linaro.org>
[AJB: tweak var position to meet coding style]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/core.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index 12c67b4b4e..2897453cac 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -214,30 +214,49 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void)
 
 static void plugin_grow_scoreboards__locked(CPUState *cpu)
 {
-    if (cpu->cpu_index < plugin.scoreboard_alloc_size) {
+    size_t scoreboard_size = plugin.scoreboard_alloc_size;
+    bool need_realloc = false;
+
+    if (cpu->cpu_index < scoreboard_size) {
         return;
     }
 
-    bool need_realloc = FALSE;
-    while (cpu->cpu_index >= plugin.scoreboard_alloc_size) {
-        plugin.scoreboard_alloc_size *= 2;
-        need_realloc = TRUE;
+    while (cpu->cpu_index >= scoreboard_size) {
+        scoreboard_size *= 2;
+        need_realloc = true;
     }
 
+    if (!need_realloc) {
+        return;
+    }
 
-    if (!need_realloc || QLIST_EMPTY(&plugin.scoreboards)) {
-        /* nothing to do, we just updated sizes for future scoreboards */
+    if (QLIST_EMPTY(&plugin.scoreboards)) {
+        /* just update size for future scoreboards */
+        plugin.scoreboard_alloc_size = scoreboard_size;
         return;
     }
 
+    /*
+     * A scoreboard creation/deletion might be in progress. If a new vcpu is
+     * initialized at the same time, we are safe, as the new
+     * plugin.scoreboard_alloc_size was not yet written.
+     */
+    qemu_rec_mutex_unlock(&plugin.lock);
+
     /* cpus must be stopped, as tb might still use an existing scoreboard. */
     start_exclusive();
-    struct qemu_plugin_scoreboard *score;
-    QLIST_FOREACH(score, &plugin.scoreboards, entry) {
-        g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+    /* re-acquire lock */
+    qemu_rec_mutex_lock(&plugin.lock);
+    /* in case another vcpu is created between unlock and exclusive section. */
+    if (scoreboard_size > plugin.scoreboard_alloc_size) {
+        struct qemu_plugin_scoreboard *score;
+        QLIST_FOREACH(score, &plugin.scoreboards, entry) {
+            g_array_set_size(score->data, scoreboard_size);
+        }
+        plugin.scoreboard_alloc_size = scoreboard_size;
+        /* force all tb to be flushed, as scoreboard pointers were changed. */
+        tb_flush(cpu);
     }
-    /* force all tb to be flushed, as scoreboard pointers were changed. */
-    tb_flush(cpu);
     end_exclusive();
 }
 
-- 
2.39.2


