Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9691CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZNzf-000065-QW; Tue, 16 Jun 2026 03:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZNze-00005x-Ji
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 03:13:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZNzc-0003uh-D3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 03:13:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso53003655e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781594030; x=1782198830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bw5TQnCfIoz6vblSniw7/lGO0LTKa3DTzJypV1mgkNY=;
 b=YQ371JzjEBwqe68UCJ3d7N+yvjFxLJ7FnKn8WCdPOhW67ajXhIvJTgSYK11F/cTLK8
 SSFqXyid/Ub4MQ0Dqz+qpKi0F0iuPc7TqKGVh8JiSS4WpWHnUgTG7F/wCtaAxr5zHnmG
 GYNrCV3/zGfaJH1kD5lxLeh9IekAAGjgCg+UihZsQcklfU+dBmVzUtU/0hCndqwI9ZlB
 DQgmCT5cYp9w8q/ODUrpnOPyrS7WV26I6+0qx+zyzYozeXKEikdC98itlQeba94ruNpV
 VToUN/pKFRLxngRKZXbFCe+jbx69MRoKy1CqOToHp8GADmAv9ylExrFF1MVYM75S1Ada
 QTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781594030; x=1782198830;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bw5TQnCfIoz6vblSniw7/lGO0LTKa3DTzJypV1mgkNY=;
 b=K3PT9Oi91WZsbs3JdL7k59muH997TWSVziPRQZ1sEOy+cCj+ZD7d/A7iW3sfmrcghs
 q5GZThdAiwo2SOobLQGJ2oZd3zn/ti71IJk5Co00zWQXPSnYklfMvA/QiF9Evz9yDmEy
 /es5/PdW8SLoCWE7sSYsYWOdx5SeDU2pNV1ISUBtkDu/0LcVt6knQGT9GmLsclq/kPNn
 QbbTL0TOtKr6cFvHiPHdFetOuX8r27oys0v1Kyt0rXRxfK5IoeqkhriOiyeQJrzG38c1
 X+0kvUF6n2dVNeB8QuqZ5zlqHQnnW6J0OFNEjspSOE1E4ktsq/2RgLH/LM3IuQijIqJC
 RL8A==
X-Gm-Message-State: AOJu0YyXzt5iNquNvukcbOnk3+f4qIejHbxQhIrZVnHJNX7DDUS7Tl/0
 cUylIel5D2+ssWhZ11u9pBaNnNa/qHDut40tMxe38iO87hTYDNcgArz0K4RRxDbn+/hIV4m6KSm
 YtjbSY/g=
X-Gm-Gg: Acq92OFhczizwlqLmO0PPVaQtI3OhGElf2eS4KU4GfJJdsCZ5mNTzADF4MxYkmKgMpN
 UfBssLU4DYWKwSENBTiOj9pfuDVC9MwE14sI+3qFh3PqwEvDX/CQcWxjNQ1L52RvFZtiFbYefF7
 2dRB8N2vgjT1U/s0iJGS9V+lqnXBamuOYfhgDt/+zuP9mjpOFS3iVAJkr8ImbqqmV6CXhboK7Ge
 g2wagdFrBgpZmE4UQn3hMgDsEHj6cuy+ctPkIc6w+ZZ0yVo51lafNLZOPYP/gfiq5C6BhFtYc37
 MRY4O0nldW0x1zWrb2ZARTwQmR2ZxeJmQaXdoJduicGH0rVfKgnS+07oFL3Mdf5c0G7I8P6k4bQ
 nEx+4kA2AjwInTbnDp3WtgTNYdrOWb81D7f5+QWIIM5rofqB0hgDRd9sn9F0PaV3DGZY2KrXBEw
 6SIbiLWRgLXEvQZFLXKn6CUAvANZOGP1BKSxRXmRdTVRAG9MI2akiS/Cml661IybjJ4Vk2iD7cg
 cvkLdv+5cymxQby+xaM3Fc15q2OwBka7oQZyRIY1IdoL46UXK18OnwaPjy7NBT+k1WPWPwOOKg2
 JehTvFSX3YnaiHvY+q0VET9dc2cPEQOcJw==
X-Received: by 2002:a05:600c:4e48:b0:490:e60b:6860 with SMTP id
 5b1f17b1804b1-4922005e235mr171362305e9.7.1781594029746; 
 Tue, 16 Jun 2026 00:13:49 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-183.home.otenet.gr. [2.86.135.183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d933esm40780315f8f.33.2026.06.16.00.13.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jun 2026 00:13:49 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:13:23 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v2 23/26] plugins: use consistent parameter documentation
 for userdata
User-Agent: meli/0.8.13
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615193526.2883349-24-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260615193526.2883349-24-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgpqqz.w60i8bund02c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Mon, 15 Jun 2026 22:35, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> include/plugins/qemu-plugin.h | 36 +++++++++++++++++------------------
> 1 file changed, 17 insertions(+), 19 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 50a39e51d46..d8d4b373842 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -142,16 +142,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
> /**
>  * typedef qemu_plugin_udata_cb_t - callback with user data
>- * @userdata: a pointer to some user data supplied when the callback
>- * was registered.
>+ * @userdata: user data for callback
>  */
> typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
> 
> /**
>  * typedef qemu_plugin_vcpu_udata_cb_t - vcpu callback
>  * @vcpu_index: the current vcpu context
>- * @userdata: a pointer to some user data supplied when the callback
>- * was registered.
>+ * @userdata: user data for callback
>  */
> typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
>                                             void *userdata);
>@@ -185,7 +183,7 @@ enum qemu_plugin_discon_type {
>  * @from_pc: the source of the discontinuity, e.g. the PC before the
>  *           transition
>  * @to_pc: the PC pointing to the next instruction to be executed
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * The exact semantics of @from_pc depends on the @type of discontinuity. For
>  * interrupts, @from_pc will point to the next instruction which would have
>@@ -204,7 +202,7 @@ typedef void (*qemu_plugin_vcpu_discon_cb_t)(unsigned int vcpu_index,
>  * qemu_plugin_uninstall() - Uninstall a plugin
>  * @id: this plugin's opaque ID
>  * @cb: callback to be called once the plugin has been removed
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * Do NOT assume that the plugin has been uninstalled once this function
>  * returns. Plugins are uninstalled asynchronously, and therefore the given
>@@ -220,7 +218,7 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>  * qemu_plugin_reset() - Reset a plugin
>  * @id: this plugin's opaque ID
>  * @cb: callback to be called once the plugin has been reset
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * Unregisters all callbacks for the plugin given by @id.
>  *
>@@ -236,7 +234,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
>  * @id: plugin ID
>  * @cb: callback function
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time a vCPU is initialized.
>  *
>@@ -251,7 +249,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
>  * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
>  * @id: plugin ID
>  * @cb: callback function
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time a vCPU exits.
>  *
>@@ -266,7 +264,7 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
>  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
>  * @id: plugin ID
>  * @cb: callback function
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time a vCPU idles.
>  */
>@@ -279,7 +277,7 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
>  * @id: plugin ID
>  * @cb: callback function
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time a vCPU resumes execution.
>  */
>@@ -293,7 +291,7 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>  * @id: plugin ID
>  * @type: types of discontinuities for which to call the callback
>  * @cb: callback function
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time a vCPU receives a discontinuity event
>  * of the specified type(s), after the vCPU was prepared to handle the event.
>@@ -427,7 +425,7 @@ typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb,
>  * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
>  * @id: plugin ID
>  * @cb: callback function
>- * @userdata: any plugin data to pass to the @cb
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time a translation occurs. The @cb
>  * function is passed an opaque qemu_plugin_type which it can query
>@@ -446,7 +444,7 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
>  * @tb: the opaque qemu_plugin_tb handle for the translation
>  * @cb: callback function
>  * @flags: does the plugin read or write the CPU's registers?
>- * @userdata: any plugin data to pass to the @cb?
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time a translated unit executes.
>  */
>@@ -464,7 +462,7 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
>  * @entry: first operand for condition
>  * @imm: second operand for condition
>  * @flags: does the plugin read or write the CPU's registers?
>- * @userdata: any plugin data to pass to the @cb?
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called when a translated unit executes if
>  * entry @cond imm is true.
>@@ -514,7 +512,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>  * @insn: the opaque qemu_plugin_insn handle for an instruction
>  * @cb: callback function
>  * @flags: does the plugin read or write the CPU's registers?
>- * @userdata: any plugin data to pass to the @cb?
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called every time an instruction is executed
>  */
>@@ -532,7 +530,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
>  * @cond: condition to enable callback
>  * @entry: first operand for condition
>  * @imm: second operand for condition
>- * @userdata: any plugin data to pass to the @cb?
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called when an instruction executes if
>  * entry @cond imm is true.
>@@ -748,7 +746,7 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h);
>  * @vcpu_index: the executing vCPU
>  * @info: an opaque handle for further queries about the memory
>  * @vaddr: the virtual address of the transaction
>- * @userdata: any user data attached to the callback
>+ * @userdata: user data for callback
>  */
> typedef void (*qemu_plugin_vcpu_mem_cb_t) (unsigned int vcpu_index,
>                                            qemu_plugin_meminfo_t info,
>@@ -761,7 +759,7 @@ typedef void (*qemu_plugin_vcpu_mem_cb_t) (unsigned int vcpu_index,
>  * @cb: callback of type qemu_plugin_vcpu_mem_cb_t
>  * @flags: (currently unused) callback flags
>  * @rw: monitor reads, writes or both
>- * @userdata: opaque pointer for userdata
>+ * @userdata: user data for callback
>  *
>  * This registers a full callback for every memory access generated by
>  * an instruction. If the instruction doesn't access memory no
>-- 
>2.43.0
>
>

