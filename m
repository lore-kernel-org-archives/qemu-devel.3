Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE66CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWT6e-0002Ej-Ty; Mon, 08 Jun 2026 02:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wWT6d-0002EH-D8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:05:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wWT6a-0007Ly-M0
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:05:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4905529b933so41118095e9.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780898698; x=1781503498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y3QC0zYy2Q0LasJjnjI28fso9GUgoO+O6/rdskylkYk=;
 b=g/7Hin1mNvD5uRNrhuayHid/vGlMq/OuX3Tb65ax3LoCAMFAFdKNTg4jvrgdX22CeS
 0QCsYpRV2IbyF2PuqXFVhMLLoC0bRddh7utU8+bkEBkwU5wYB8EcF5Wjg6nhpW8F6fqO
 h6IS1cVHzpRplr3tHAQhPIDsTizqDSOth2cPMmQzbVEfy6EMref7jzBuqqlmq3m7c3Ij
 z0dxKMGGRThJaElLQbadtv5EChIX16eBNczbdmEYSLgAmXFsf6NEDfKvYwZKLTkHL3/w
 LQAYPa54PhPR+L5G4v5+5pG09NKAtaE6ugvfsKi0E2VVy3BU4CvfP8wl92tYMnIQQpWe
 /mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780898698; x=1781503498;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3QC0zYy2Q0LasJjnjI28fso9GUgoO+O6/rdskylkYk=;
 b=qlc35w1ESrCaE8O5E1gT63F3cwM04LuZd7WjnUpqVpCUCg3rfNWPE9uJJ8lH70Od4y
 fK38z+29gaiNjDV2Ywb3YaE4UYmmC9LhE+SS/vR/+7Wn0fVXiRt1rAomzT7QPmbW6voz
 5e4f0Yua4vWxbo2zRcxbkwiQLySmT/HPB6m+Iv4DMB0EcF5gdoBND5FWlyKI/76eMVmm
 2L4dHxWh+rodaE4wVe8f0ZUXbuheTSXo2TtnVQtiFGLDzJEtZWnfLz9pQ3iJgejjjWfh
 TsoaES7LyiUaFs/TjQ5kjLav/I7zpFSMQRWKIsut81lDddY7R0tZDH+GxOMgacoQxk6+
 tGxw==
X-Gm-Message-State: AOJu0Yz948lRKaLPhMWV5Ga8KD+aNKqTRLK0/tPvP6gTklAVYUBm3NEj
 TXGgwUxG+MZXUrUmUhAU2tab6sijajaHBvvoGP/tab1Nkcc8AjG5sRQSTg0hxQ6WKVLztuHCnDi
 KfjeLCWY=
X-Gm-Gg: Acq92OF0Dz96r8OW14XXfWLDUPbUoIHxn/HOc9UVtGzibYRi14BRiMAz8i8ilZmIIA9
 3K1UF+K/Md93tzp6AF/v+rHyLhmLT1tLnKvkE1OCXqsTeuUPg3kyGORyXdwitqLyTX+Wnym0RRl
 BsGDpLBsvCsMYDTMlghYQPq3AnfiFi0aq1U8wfqfsNgTcE2/1N0TQTckNb1EHbYRM4zzbJJDPuJ
 opjaNPEgVFH4TapWlusM6qxi9QxMKWbdSHiJXJ5OqBxUhF0EtQDjVGApwFb2jgCdF22H83/N5it
 qffK2ADICXOVkGEJS8+uQXpU9m+iq6M6nveVPQPoZpq0pz3sTcjRGie4ONeYIrERkAnwLI6ijvW
 bjxdP0c512Nf9rdgID2FW5FwQUnsqfSN37LXvIIlfZL3VJ0+H0x6kLOqdxjFwNM9oEdRBKGpDgZ
 v0Fn/vKYqfT0GXM8eKDaAoFkamqTwFjVgB2LO9EKLhpv02jLTtmQyViENZwScOvbXqCYirNAnvI
 O76Yr2nxJLkKvQHpQFC7mX05egkBVfD7RZcOQ4o+z5xxDOgMyAxXAo5la5gKJMB
X-Received: by 2002:a05:600c:8285:b0:490:abef:dae6 with SMTP id
 5b1f17b1804b1-490c25b09bcmr241948785e9.19.1780898698227; 
 Sun, 07 Jun 2026 23:04:58 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d2d11asm301201045e9.1.2026.06.07.23.04.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2026 23:04:57 -0700 (PDT)
Date: Mon, 08 Jun 2026 09:01:06 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 02/25] plugins: add userdata for qemu_plugin_{uninstall,
 reset}
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-3-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-3-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgau87.2zyzu7optwbli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 03 Jun 2026 23:51, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>We do both at the same time because they internally use the same
>implementation.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

LGTM,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> contrib/plugins/lockstep.c    | 10 +++++-----
> include/plugins/qemu-plugin.h |  8 ++++++--
> plugins/api.c                 | 10 ++++++----
> plugins/loader.c              | 13 ++++++++-----
> plugins/plugin.h              |  3 ++-
> tests/tcg/plugins/reset.c     |  8 ++++----
> 6 files changed, 31 insertions(+), 21 deletions(-)
>
>diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
>index 62981d4e098..36b003ead2d 100644
>--- a/contrib/plugins/lockstep.c
>+++ b/contrib/plugins/lockstep.c
>@@ -77,7 +77,7 @@ static char *path_to_unlink;
> 
> static bool verbose;
> 
>-static void plugin_cleanup(qemu_plugin_id_t id)
>+static void plugin_cleanup(qemu_plugin_id_t id, void *userdata)
> {
>     /* Free our block data */
>     g_slist_free_full(blocks, &g_free);
>@@ -98,7 +98,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>     g_string_append_printf(out, "Executed ~%ld instructions\n", insn_count);
>     qemu_plugin_outs(out->str);
> 
>-    plugin_cleanup(id);
>+    plugin_cleanup(id, NULL);
> }
> 
> /*
>@@ -189,7 +189,7 @@ static void report_divergance(ExecState *us, ExecState *them)
>         }
>         qemu_plugin_outs(out->str);
>         qemu_plugin_outs("giving up\n");
>-        qemu_plugin_uninstall(our_id, plugin_cleanup);
>+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
>     }
> }
> 
>@@ -212,7 +212,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>         qemu_plugin_outs(bytes < 0 ?
>                          "problem writing to socket" :
>                          "wrote less than expected to socket");
>-        qemu_plugin_uninstall(our_id, plugin_cleanup);
>+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
>         return;
>     }
> 
>@@ -225,7 +225,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>         qemu_plugin_outs(bytes < 0 ?
>                          "problem reading from socket" :
>                          "read less than expected");
>-        qemu_plugin_uninstall(our_id, plugin_cleanup);
>+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
>         return;
>     }
> 
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 435a14f5a00..11213c2ca3f 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -221,6 +221,7 @@ typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
>  * qemu_plugin_uninstall() - Uninstall a plugin
>  * @id: this plugin's opaque ID
>  * @cb: callback to be called once the plugin has been removed
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * Do NOT assume that the plugin has been uninstalled once this function
>  * returns. Plugins are uninstalled asynchronously, and therefore the given
>@@ -229,12 +230,14 @@ typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
>  * Note: Calling this function from qemu_plugin_install() is a bug.
>  */
> QEMU_PLUGIN_API
>-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
>+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>+                           void *userdata);
> 
> /**
>  * qemu_plugin_reset() - Reset a plugin
>  * @id: this plugin's opaque ID
>  * @cb: callback to be called once the plugin has been reset
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * Unregisters all callbacks for the plugin given by @id.
>  *
>@@ -243,7 +246,8 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
>  * callbacks until @cb is called.
>  */
> QEMU_PLUGIN_API
>-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
>+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>+                       void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
>diff --git a/plugins/api.c b/plugins/api.c
>index 2d5fe9327f7..91c9a24a6b2 100644
>--- a/plugins/api.c
>+++ b/plugins/api.c
>@@ -51,14 +51,16 @@
> 
> /* Uninstall and Reset handlers */
> 
>-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
>+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>+                           void *userdata)
> {
>-    plugin_reset_uninstall(id, cb, false);
>+    plugin_reset_uninstall(id, cb, userdata, false);
> }
> 
>-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
>+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>+                       void *userdata)
> {
>-    plugin_reset_uninstall(id, cb, true);
>+    plugin_reset_uninstall(id, cb, userdata, true);
> }
> 
> /*
>diff --git a/plugins/loader.c b/plugins/loader.c
>index 0dbe7bea263..0d587c344c4 100644
>--- a/plugins/loader.c
>+++ b/plugins/loader.c
>@@ -253,7 +253,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info, E
>          * call a full uninstall if the plugin did not yet call it.
>          */
>         if (!ctx->uninstalling) {
>-            plugin_reset_uninstall(ctx->id, NULL, false);
>+            plugin_reset_uninstall(ctx->id, NULL, NULL, false);
>         }
>     }
> 
>@@ -314,7 +314,8 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
> 
> struct qemu_plugin_reset_data {
>     struct qemu_plugin_ctx *ctx;
>-    qemu_plugin_simple_cb_t cb;
>+    qemu_plugin_udata_cb_t cb;
>+    void *userdata;
>     bool reset;
> };
> 
>@@ -338,7 +339,7 @@ static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
>     if (data->reset) {
>         g_assert(ctx->resetting);
>         if (data->cb) {
>-            data->cb(ctx->id);
>+            data->cb(ctx->id, data->userdata);
>         }
>         ctx->resetting = false;
>         g_free(data);
>@@ -357,7 +358,7 @@ static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
>     g_assert(success);
>     QTAILQ_REMOVE(&plugin.ctxs, ctx, entry);
>     if (data->cb) {
>-        data->cb(ctx->id);
>+        data->cb(ctx->id, data->userdata);
>     }
>     if (!g_module_close(ctx->handle)) {
>         warn_report("%s: %s", __func__, g_module_error());
>@@ -383,7 +384,8 @@ static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
> }
> 
> void plugin_reset_uninstall(qemu_plugin_id_t id,
>-                            qemu_plugin_simple_cb_t cb,
>+                            qemu_plugin_udata_cb_t cb,
>+                            void *userdata,
>                             bool reset)
> {
>     struct qemu_plugin_reset_data *data;
>@@ -401,6 +403,7 @@ void plugin_reset_uninstall(qemu_plugin_id_t id,
>     data = g_new(struct qemu_plugin_reset_data, 1);
>     data->ctx = ctx;
>     data->cb = cb;
>+    data->userdata = userdata;
>     data->reset = reset;
>     /*
>      * Only flush the code cache if the vCPUs have been created. If so,
>diff --git a/plugins/plugin.h b/plugins/plugin.h
>index 9179da43851..c901016b8c1 100644
>--- a/plugins/plugin.h
>+++ b/plugins/plugin.h
>@@ -76,7 +76,8 @@ void plugin_register_inline_op_on_entry(GArray **arr,
>                                         uint64_t imm);
> 
> void plugin_reset_uninstall(qemu_plugin_id_t id,
>-                            qemu_plugin_simple_cb_t cb,
>+                            qemu_plugin_udata_cb_t cb,
>+                            void *userdata,
>                             bool reset);
> 
> void plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
>diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
>index 1be8be2a4b2..6ea675b8095 100644
>--- a/tests/tcg/plugins/reset.c
>+++ b/tests/tcg/plugins/reset.c
>@@ -14,7 +14,7 @@ static qemu_plugin_id_t plugin_id;
> static bool was_reset;
> static bool was_uninstalled;
> 
>-static void after_uninstall(qemu_plugin_id_t id)
>+static void after_uninstall(qemu_plugin_id_t id, void *userdata)
> {
>     g_assert(was_reset && !was_uninstalled);
>     qemu_plugin_outs("uninstall done\n");
>@@ -24,7 +24,7 @@ static void after_uninstall(qemu_plugin_id_t id)
> static void tb_exec_after_reset(unsigned int vcpu_index, void *userdata)
> {
>     g_assert(was_reset && !was_uninstalled);
>-    qemu_plugin_uninstall(plugin_id, after_uninstall);
>+    qemu_plugin_uninstall(plugin_id, after_uninstall, NULL);
> }
> 
> static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>@@ -34,7 +34,7 @@ static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>                                          QEMU_PLUGIN_CB_NO_REGS, NULL);
> }
> 
>-static void after_reset(qemu_plugin_id_t id)
>+static void after_reset(qemu_plugin_id_t id, void *userdata)
> {
>     g_assert(!was_reset && !was_uninstalled);
>     qemu_plugin_outs("reset done\n");
>@@ -45,7 +45,7 @@ static void after_reset(qemu_plugin_id_t id)
> static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
> {
>     g_assert(!was_reset && !was_uninstalled);
>-    qemu_plugin_reset(plugin_id, after_reset);
>+    qemu_plugin_reset(plugin_id, after_reset, NULL);
> }
> 
> static void tb_trans_before_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>-- 
>2.43.0
>
>

