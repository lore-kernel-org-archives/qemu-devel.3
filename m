Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A515CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYay-0001ed-9v; Thu, 11 Jun 2026 02:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYav-0001e3-89
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:08:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYat-0000IT-6e
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:08:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so64540055e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781158125; x=1781762925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FIr2yMuOOMQWppG8XucJQKnlIaSkIpqdZulk4cYkXKM=;
 b=vKMK06gWnSJC0Mb+ns00EPmrlLDL3lM7snfxo6N+sA98lyMISC/u9+ZrI/njhBZjmM
 kOz6VFHszrSMcXWXTjQ66vUEdg1LVGHsRZgAR9erox8p5TrJqRu9ztiMCroxeyZAKQp6
 R5y/D52z8wwM69DkB7dyu3l1GpEpmMDJRJfxUDHwrx+YHWDzSDaDeREsti01NLSWd+66
 IGdD2OpuRqkbSkB54Kr8KEX0FMShhkZuhQYEnzdayqiXkuQs961LVAODawtuc9dLK4Uf
 xcvgcl/BQuroXboaVztZXnQ/hLGFfEqrZqeKPxaNIHYLzGnsDcjjC7W9LNyLD/MrjbII
 FmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781158125; x=1781762925;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FIr2yMuOOMQWppG8XucJQKnlIaSkIpqdZulk4cYkXKM=;
 b=F1OrQuyODHIw9m9X+3K6sscI+DZwKGLzvUVkcf/5/EtmoyzacC3zEbgDFFQsDppzrr
 aVj3udcV+f72U7y8aeHuuIHpKGapfl7hgcwkbAxNkqXzzp1YWuzhlH5KrlDHGpGPjbwL
 Zuy888U9UqpjtVedkVFcMEhljkNGTNCvkF26L1rRf7WKHmRSOIX/V/JWjPKcidzBgOws
 5EjaoBm8Q+llmDjoV3nZV9GbQSbc4wmO1L7f8HEt2Rcj6LcmhAH2yMpjUKknNfrl/4rl
 d0eWyW0KI+mBddysY34YHSCMN9gykeF+F/4EtjZ2Bpbc6LhIqp0FoQBAtjcujaITivyn
 cqgg==
X-Gm-Message-State: AOJu0YwPIK5vwaRnPE/OQ0l5hHwVilXcd2H8KaCGFq7z9U3Ibl7ATFgg
 elIKaBc/SGc84Mj+IiBqhRp3Den6gWoeT054F3LIvL8T4uG4vdLBs2MspMON4zX/kZFL54MN5zA
 qiYOp62Y=
X-Gm-Gg: Acq92OFPyt+aOpxUqgz3QCO3FkzItLTwIS839CSSzByvn+aROpNrespfKmUAW21h2Lq
 2ScLTgM4pOILkmLl/5qjFvY7v3mVSDQHXfUKIF7ubeb0QaELD2EwJb16TMlWPqlGheosM5kriDv
 BrimfQyMGzGxDDCugZsfoHrmWNufxMIiF82QebbBZkTt0LqZ7aZeQue6+jOBHua7dJVNeUPjCZF
 1YAQ26LYGiiJxIQpg4crrhdbU6tpcKDAPy/Fa2olFvJU/J1HGjZSsdsMGMhbZ6DSxFcVgO/sTbC
 HGPY4Ybj6LLVXika+iE9XAwWn72oAQEZ99GXgRP2J7I7Vfi7gDIsWMCx3g202orVA4dVU1QOb0Q
 8NqkUaw4s39U6mcTxQF6xEfnvTNVPUerzJNlaXhnfxU7cRYf6vibRwOK5fhK3hG0cVPr9OmJz+d
 t9LqnEy2JHnHXoGm3jOG+7MbKrp8sMuh/a0WDzeBtHjlb5c9odutMThTvEEkwgdsn/vbNvoIBaD
 rtifsMQmmC/LSZVQfRbuIHIqKKhyMgxe/53jPUNURBKYPIMDdK5JkEk0TVWxw==
X-Received: by 2002:a05:600c:8b5c:b0:490:8fd1:72a with SMTP id
 5b1f17b1804b1-490e55b8667mr14895345e9.3.1781158125358; 
 Wed, 10 Jun 2026 23:08:45 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e422e321sm17080575e9.0.2026.06.10.23.08.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:08:44 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:08:20 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 22/25] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_ret_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-23-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-23-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggeej.15z2n7kiq1np3@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

> include/plugins/qemu-plugin.h | 8 ++++++--
> plugins/api.c                 | 5 +++--
> plugins/core.c                | 2 +-
> tests/tcg/plugins/syscall.c   | 5 +++--
> 4 files changed, 13 insertions(+), 7 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 4f0c73c7b33..50a39e51d46 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -882,10 +882,12 @@ typedef bool
>  * @vcpu_index: the executing vCPU
>  * @num: the syscall number
>  * @ret: the syscall return value
>+ * @userdata: user data for callback
>  */
> typedef void
> (*qemu_plugin_vcpu_syscall_ret_cb_t)(unsigned int vcpu_index,
>-                                     int64_t num, int64_t ret);
>+                                     int64_t num, int64_t ret,
>+                                     void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
>@@ -925,6 +927,7 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>  * callback
>  * @id: plugin id
>  * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t
>+ * @userdata: user data for callback
>  *
>  * This registers a callback for every syscall executed by the guest. The @cb
>  * function is executed upon return from the host syscall before execution is
>@@ -933,7 +936,8 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
> QEMU_PLUGIN_API
> void
> qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>-                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
>+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb,
>+                                         void *userdata);
> 
> /**
>  * qemu_plugin_insn_disas() - return disassembly string for instruction
>diff --git a/plugins/api.c b/plugins/api.c
>index f2176be5304..0038da6d706 100644
>--- a/plugins/api.c
>+++ b/plugins/api.c
>@@ -210,9 +210,10 @@ void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
> 
> void
> qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>-                                         qemu_plugin_vcpu_syscall_ret_cb_t cb)
>+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb,
>+                                         void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb, userdata);
> }
> 
> void
>diff --git a/plugins/core.c b/plugins/core.c
>index 887267f8174..7a58fb537c9 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -557,7 +557,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
>         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
> 
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>-        func(cpu->cpu_index, num, ret);
>+        func(cpu->cpu_index, num, ret, cb->udata);
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>     }
> }
>diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>index 1bc737824ce..a28d1087840 100644
>--- a/tests/tcg/plugins/syscall.c
>+++ b/tests/tcg/plugins/syscall.c
>@@ -152,7 +152,8 @@ static void vcpu_syscall(unsigned int vcpu_index,
> }
> 
> static void vcpu_syscall_ret(unsigned int vcpu_idx,
>-                             int64_t num, int64_t ret)
>+                             int64_t num, int64_t ret,
>+                             void *userdata)
> {
>     if (statistics) {
>         SyscallStats *entry;
>@@ -273,7 +274,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     }
> 
>     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
>-    qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
>+    qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret, NULL);
>     qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
>-- 
>2.43.0
>
>

