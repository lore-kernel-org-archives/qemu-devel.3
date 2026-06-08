Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69623CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWT8x-00030s-29; Mon, 08 Jun 2026 02:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wWT8u-00030V-SP
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:07:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wWT8t-0008PH-4r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:07:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so2708594f8f.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 23:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780898841; x=1781503641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dsgbdfFjPbe011NWB9cO4vf3IPDklVF9xzaBpWQJE4M=;
 b=VvjP9y/dwEeRm7FYMCKd/L3a6B7qr/hOK5VXOwYmIOKJSRQ86Nd5ms8er8KECbZPmu
 n+cvhpozbcPF6XxSkkSt9nCyNF6Os+preZkAQOUv4gwk9oyc44Wq9DZljk3AGOENhgof
 K2HeCTlFIHG792IQj29ELlmhi+cOl9zj365/rQRDtWPbSgpRy55xkKP1tG1OetyS1AJs
 9+Ge2+2pEP5rraPaxj9+4QVkydqR8VDbIQe9zo5DRN271AA0RYDDT3VKb0c/KPewUlBJ
 D+j5XGtuGUx5xFjcbWqH1TpCFPg4o01Z0IWE6fepRjG43DOX63jQHWVB6UvxqE/CqZ9v
 mCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780898841; x=1781503641;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dsgbdfFjPbe011NWB9cO4vf3IPDklVF9xzaBpWQJE4M=;
 b=FJoRQjJZeLVsXHhTssuNZ989nNDEz3W4seXWPMsu+n+/Mw1s1eyCtTV6rWQ3jDxKdS
 cZPPB4hY3qv05tPNWGjnJRMR63QkkvqXdT8vQ7ZXQLqqZ9I8XfCBC1ovo2v62OCgJFNz
 RDvYinzxbDVQ2aN582sAoepNXawFNDJkrA/sZYL6crstlHXnyFqmY0VarEwoA9rsaJdk
 UuC9Wks3WCBcLoI3aiEEWf4s6eVVOCp+8wXq/uAFb7gSIs2Wxzmqz4u6iuQkCF/vlLY+
 UAWmVyHi+Tn1VmEUWik5VhVZQ1zzGhcl3JWza87BMTPjII/6Q+v0wrzpccrDegz1Ixkh
 sTMQ==
X-Gm-Message-State: AOJu0YwFSUwXCruzpyKPiOqB7Wq5UL0XNet/lKhPzjkPhMbhD0IQOupM
 69f8MxCD099c+sU95cozPydrtb4nEB+9SPtxBgJV3/TybkpEzp77ObaoKGwaXZnm6GItcHwa4x3
 9rkPjN7c=
X-Gm-Gg: Acq92OE6IUkVJUQGaxeuTIwMP+8EFHEQ0giYdiC6b9P0+vuI0PdF+K440TQBkHTjSEU
 Q0ZkENDyPm0QCqzDLoBKqgQku6fsPnfcQruWKI/WOV5HTk1Rn6jhAc/RLJ546UtjruiI/55/Vwd
 xqfnDFI8j8EAqD2ZLHxbZuLyYtht28bj0ZQdXAkYY2R5YbzxKPhgV/k7GUL2PSaNsJyaHA0d9ay
 ukFLPIfOmzKtcToQx8WsF7mAdDmcz0OmtEGanNj2qwH5WZKBRa1qLb+P1kLv1pASQj1MEbW3lbw
 laO6frdqUZWb1iE6ALm3pZldNkb35f92jR1orMoCQPyMunDEYE6gHCdisnTlD2YI/9uQ5fSSpW9
 AsXPsXSR1xPYGCHZp8YwQO8d1v59E0DGGsvdB4bvKh0SYz/ZTlyeWXAvA7eLXzPxfkL0XB2nHHc
 IKPKkVXk/p0GmxEBFU5FaXNhsm6U3vonQyq0p+9V+LcXGkJdHWp+cECrvXilA97orYoLV4PMHJp
 /B/5xBekRp2HzzJCnEunX0ke4vqqWNJ7R09+dVcm7GkqTHg5crw1vY20dJh2hyh
X-Received: by 2002:a05:6000:468d:b0:446:db72:e8ec with SMTP id
 ffacd0b85a97d-46030643609mr14447776f8f.23.1780898841209; 
 Sun, 07 Jun 2026 23:07:21 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ec711sm48096508f8f.12.2026.06.07.23.07.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2026 23:07:20 -0700 (PDT)
Date: Mon, 08 Jun 2026 09:05:56 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 03/25] plugins: add userdata to
 qemu_plugin_register_flush_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-4-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-4-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgauc7.24hdp08hyg3kv@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> include/plugins/qemu-plugin.h |  4 +++-
> plugins/core.c                | 31 +++++--------------------------
> 2 files changed, 8 insertions(+), 27 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 11213c2ca3f..499441bde23 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -973,6 +973,7 @@ void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>  * qemu_plugin_register_flush_cb() - register code cache flush callback
>  * @id: plugin ID
>  * @cb: callback
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time the code cache is flushed.
>  * The callback can be used to free resources associated with existing
>@@ -981,7 +982,8 @@ void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>  */
> QEMU_PLUGIN_API
> void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>-                                   qemu_plugin_simple_cb_t cb);
>+                                   qemu_plugin_udata_cb_t cb,
>+                                   void *userdata);
> 
> /**
>  * qemu_plugin_register_atexit_cb() - register exit callback
>diff --git a/plugins/core.c b/plugins/core.c
>index 2324bbffa3d..21a3c5b15cf 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -131,29 +131,6 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
> }
> 
>-/*
>- * Disable CFI checks.
>- * The callback function has been loaded from an external library so we do not
>- * have type information
>- */
>-QEMU_DISABLE_CFI
>-static void plugin_cb__simple(enum qemu_plugin_event ev)
>-{
>-    struct qemu_plugin_cb *cb, *next;
>-
>-    switch (ev) {
>-    case QEMU_PLUGIN_EV_FLUSH:
>-        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>-            qemu_plugin_simple_cb_t func = cb->f.simple;
>-
>-            func(cb->ctx->id);
>-        }
>-        break;
>-    default:
>-        g_assert_not_reached();
>-    }
>-}
>-
> /*
>  * Disable CFI checks.
>  * The callback function has been loaded from an external library so we do not
>@@ -166,6 +143,7 @@ static void plugin_cb__udata(enum qemu_plugin_event ev)
> 
>     switch (ev) {
>     case QEMU_PLUGIN_EV_ATEXIT:
>+    case QEMU_PLUGIN_EV_FLUSH:
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>             qemu_plugin_udata_cb_t func = cb->f.udata;
> 
>@@ -690,9 +668,10 @@ void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
> }
> 
> void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>-                                   qemu_plugin_simple_cb_t cb)
>+                                   qemu_plugin_udata_cb_t cb,
>+                                   void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_FLUSH, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_FLUSH, cb, userdata);
> }
> 
> static bool free_dyn_cb_arr(void *p, uint32_t h, void *userp)
>@@ -706,7 +685,7 @@ void qemu_plugin_flush_cb(void)
>     qht_iter_remove(&plugin.dyn_cb_arr_ht, free_dyn_cb_arr, NULL);
>     qht_reset(&plugin.dyn_cb_arr_ht);
> 
>-    plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
>+    plugin_cb__udata(QEMU_PLUGIN_EV_FLUSH);
> }
> 
> void exec_inline_op(enum plugin_dyn_cb_type type,
>-- 
>2.43.0
>
>

