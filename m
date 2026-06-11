Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F3ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY1m-0007nX-K6; Thu, 11 Jun 2026 01:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY1j-0007hr-W9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:32:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY1h-0002D1-QO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:32:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so61329765e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781155944; x=1781760744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Sg9Y3c6wZCkDZ8AjvNXMoSeq5Ad7PmbnN6bfTjrIWlg=;
 b=GB4Z2kMzW/O//UkW2Mfqq+lc0EgCq40E1GI78Gm5X17t5kI/wfwgDZERShjqr8boLr
 OrA5TK/BIhoY404OyhQphr2EW0Sx8zo71vP4yp4tQI42XA/f2flP7AhW/bfTAfFd7oNv
 laKDQsrBedDz/r4426k6GCAE96bJI/ZeyDhbpL+dL105stvOesSxUs62cpZF1S155HXp
 vNHF9fK77j86ig/d9ZJSmKCX+H7oxo+crxQUqgHjPHoXaTcdK6OZ3VH6yz6dxLsRgqkD
 QC8P/LxltD2h5hmTf1ec7B0q+SOH5blAemMlr2M6HtjE/O8t01uvqIB+j+u41zNjBqLU
 f6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155944; x=1781760744;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sg9Y3c6wZCkDZ8AjvNXMoSeq5Ad7PmbnN6bfTjrIWlg=;
 b=fLF8+yYAz2R9htsjNFnVbVhfL5FOGo4goFpbbrUpIv+p48Qp8r8Fq6AMEZskTA6QJl
 buwNA4kaQ27cMZXyLrXQ0x/4zXP+u7G1qmD4S29AqprPitVdp+18pyi+DOm0elDiYlrN
 Oq8q7jRiX1w+mG7Is66QJYzT7qRqz2yGIkiSDiAWWL9kA1i1oizn7EXFSlRs9PnY2GNK
 rNGyOKh0v2oRttsMBbyTKqHe3eo3YL1i/4Yrju5iKG0itSM8nxUC8X3tZT6ho3Y+QWHB
 Nkyl8xVkRYG+uvEjn2JQcUfV454H37tA/15QyNODUIyLu+h1Q+Pve4n/zBfR/u/2fLXe
 4iOQ==
X-Gm-Message-State: AOJu0YweEJUTFx+ITfGhSNERKXmpvNdOeag6Abb0hyWzWeHG0/Dp/ozd
 fbMNjjeeCEBSsIfXU4Mtb3EUx/URNLQb3CHMI70bslDjF2SGW+BQH+U5Vyf1dovsVMdE8QFSCQ+
 G4iQfCDY=
X-Gm-Gg: Acq92OEqK6Sjf674YJwKyDLUGrFaiKRDMr2Em0mB53E0n6djWtHTLjAGa5U4XLtES3z
 Is/wYdQ/k6pfMEe+lyFVO6om4CLgUD49SrPITEByvCoAqYPoVjXnTIbjQtmLXs3XU1NSLNHL8My
 qADGMobxbVmNYqyto6Kk2zEvQl3vYwLzVGbQvqzNQZCBrTpRlqDJrIyrm9H52TIZCLujH1+GHSR
 qPZbiZyVosoMspJDVbMnHD8Y4/eSgmPLY+0QCcotRPC9icBziZsHhnvFalILCB2n3tIl7DoDJmg
 8QklTOvHOeuB/BSYin7uAQoAUql1Ao3vX6wyx0ntHnBsD8J06SZU6mN9z+RVbYZvL4FX2AoS7os
 V2hUOPNf8x26GN/3ytPDdj1hlSbVXDasc1qWEi2qa9kOuwynnZuLxpp1cOnD6YEX/IzCAm6lhEb
 uCC/iCOnR76mOEjA8eOOukHcHl5kFvtGBsMdsUl2mscFv/M9lNLyS0JYQsdHoSgoR8pnkDWjV0O
 qWQgGiDmrXi5WwNmBVr+4SwMjLYjRVjJ+HP7lCoWe5eI2B4vg5M9LfvhwwMyA==
X-Received: by 2002:a05:600c:3112:b0:490:9d1b:f07f with SMTP id
 5b1f17b1804b1-490e55cf3eemr11174185e9.12.1781155943796; 
 Wed, 10 Jun 2026 22:32:23 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e5314e37sm18335345e9.10.2026.06.10.22.32.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:32:23 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:31:36 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 08/25] plugins: add userdata to
 qemu_plugin_register_vcpu_exit_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-9-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-9-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggcpy.38ytqzhd5bqsk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

> contrib/plugins/ips.c         | 4 ++--
> include/plugins/qemu-plugin.h | 4 +++-
> plugins/api.c                 | 5 +++--
> plugins/core.c                | 4 ++--
> 4 files changed, 10 insertions(+), 7 deletions(-)
>
>diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>index 1290a624489..2c110906731 100644
>--- a/contrib/plugins/ips.c
>+++ b/contrib/plugins/ips.c
>@@ -97,7 +97,7 @@ static void vcpu_init(unsigned int cpu_index, void *userdata)
>     vcpu->last_quantum_time = now_ns();
> }
> 
>-static void vcpu_exit(unsigned int cpu_index)
>+static void vcpu_exit(unsigned int cpu_index, void *userdata)
> {
>     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
>     update_system_time(vcpu);
>@@ -208,7 +208,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>-    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
>+    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>     return 0;
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index bb4569a2291..d4f8a99027e 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -257,6 +257,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
>  * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
>  * @id: plugin ID
>  * @cb: callback function
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * The @cb function is called every time a vCPU exits.
>  *
>@@ -264,7 +265,8 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
>  */
> QEMU_PLUGIN_API
> void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
>-                                       qemu_plugin_vcpu_simple_cb_t cb);
>+                                       qemu_plugin_vcpu_udata_cb_t cb,
>+                                       void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
>diff --git a/plugins/api.c b/plugins/api.c
>index 68b564bb9c2..849790fe13b 100644
>--- a/plugins/api.c
>+++ b/plugins/api.c
>@@ -78,9 +78,10 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
> }
> 
> void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
>-                                       qemu_plugin_vcpu_simple_cb_t cb)
>+                                       qemu_plugin_vcpu_udata_cb_t cb,
>+                                       void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb, userdata);
> }
> 
> static bool tb_is_mem_only(void)
>diff --git a/plugins/core.c b/plugins/core.c
>index 1d5692b3f41..15fb548f68c 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
>     struct qemu_plugin_cb *cb, *next;
> 
>     switch (ev) {
>-    case QEMU_PLUGIN_EV_VCPU_EXIT:
>     case QEMU_PLUGIN_EV_VCPU_IDLE:
>     case QEMU_PLUGIN_EV_VCPU_RESUME:
>         /* iterate safely; plugins might uninstall themselves at any time */
>@@ -115,6 +114,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
> 
>     switch (ev) {
>     case QEMU_PLUGIN_EV_VCPU_INIT:
>+    case QEMU_PLUGIN_EV_VCPU_EXIT:
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
>             func(cpu->cpu_index, cb->udata);
>@@ -306,7 +306,7 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
>     bool success;
> 
>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
>+    plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
> 
>     assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
>-- 
>2.43.0
>
>

