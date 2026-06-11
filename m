Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D90CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2Y-00019y-8w; Thu, 11 Jun 2026 01:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY2V-0000uA-NJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY2T-0002bC-RM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so60669855e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781155992; x=1781760792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UTomzcQYyDcSf6r5p/brk+6+tJAztvHHV8asoukVCnk=;
 b=znOjVk+l5XT5W8pDu0xxzU4kmXgAwBXnDl6oQF8e4iKKr/Tzs5JFQdV/eDHxcEo+8Q
 sNn5CnJilVj9KyvkDub0aRUGBS2cMA1lwfeNL2oyE3DoC32qnA+L+Lh4inc/PUCYKQgY
 gIvAHkly39h2THeO8j4qUC0C3RcrEHdLnS2ISEmmiZPmAKWlTovoVTud49Hq/SVpIkDK
 G8JGHkCgYD/s2Czk6JtKC0B48Mh8hfORisCDkJXN0XywG5d1ceFEZvUUQogGfG9bDuoj
 kfmqr62oI+c4lUT1yvHwZOxgKNv5rStv/OuM2dhOWPlljghqE9+LwAgRF5p7OwScITT+
 rG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155992; x=1781760792;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTomzcQYyDcSf6r5p/brk+6+tJAztvHHV8asoukVCnk=;
 b=IxVyFDheJU083TF7N114TJiilESTpBPeT0aC4by3YunqsFC+/K41SJFBJt4FQBcqxK
 OSnfXD9JGWo2Y+l8NU0LTdY+KcKG18GszSkO4Hfqs5hXdKeT6JkmtBJBFSq3kis8lV49
 2j4m9efLQ/bNnnAQYIfo3KHtJT0NLgsxoNsxci7cR2OLLk0T6avp0ht6AIFBdReHIvGs
 Cb5+hPvN54BuWfFqZKc/RssNlVBaBD5k1Tv6JAmpL0T2bBVQYBrTuwHO1t4PNlZERfNd
 vGa16hhV2x50VU00gXWjneWIhNrAvRhKjXeEs1dqG2xV016s7s3TFdZ8YWZUb0BzKV+o
 ViTA==
X-Gm-Message-State: AOJu0Yz8rijAU8PSN3gdiLA+6g8THZQp4pXFwzMTBu5btKX1pYPhGegU
 P7EudM9jSy7eXfTAHN2c7gArwdEN8NFY3wXtlx4XP7ZS9Wj9DK1QF4CusN4KHCs6r7WFIZGgt54
 3Zorgm0w=
X-Gm-Gg: Acq92OHtj61JlP9ZFP0ne+0htelTWPngQ6E7EwnSYphfBWg7Ddgb0DUzkmG90JDakX5
 +TAxpG04CzmdNinYO5MSFCM4XXnlZE1I07GFe1Lpn/mVsI2lV4jo56m0CjLbQB1JbpOqVJWyAr8
 zLHuUbCsJQZ5EvfvkRAz24Aw35EKUo7hk/3Em3D45yix4Dh2M4y51PZwfyzqZh+FMsj1YNWgMXu
 zMIAhviEjfhWm3+QY0VMTaKbkdE8zMTxZA+5q9U90fcAJ+EkVxQKpquxWV1VaBAbWXkEV6EFwSV
 0QGkzjVqLqYam1iAWhExi4ozWpQ3UiBMPyF7yX8WVgZB1eeYXz87RVq/KBnkm9kdQIJE5XkVXob
 XrIdUz59P5uctrjiD1UXagccyKUavL72+jfzbI10upOCWrkgS83O0TfVx1IqamEaudYGEE++Ufu
 KqpUr5Gs1pU8329d+rou2Z+w6hGuLWW9M0RTkbUHu18+kKNYsAQfHyFiwK5KqhKqsUDIwNCIX3R
 lQqsMhWUrIhMYzMUnfHM/6VVzreEHTyOswEALyq9y7uSI3yGCwRidxmpJG7zKS02aMVKUDW
X-Received: by 2002:a05:600c:a39b:b0:490:ccf2:6dca with SMTP id
 5b1f17b1804b1-490e561048bmr5640155e9.20.1781155991999; 
 Wed, 10 Jun 2026 22:33:11 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e5314dedsm20808945e9.9.2026.06.10.22.33.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:33:11 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:32:30 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 09/25] plugins: add userdata to
 qemu_plugin_register_vcpu_idle_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-10-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-10-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggcra.2d2iw2yderw14@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

> include/plugins/qemu-plugin.h | 4 +++-
> plugins/core.c                | 9 +++++----
> tests/tcg/plugins/bb.c        | 4 ++--
> 3 files changed, 10 insertions(+), 7 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index d4f8a99027e..75d2a69a3bd 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -272,12 +272,14 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
>  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
>  * @id: plugin ID
>  * @cb: callback function
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * The @cb function is called every time a vCPU idles.
>  */
> QEMU_PLUGIN_API
> void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>-                                       qemu_plugin_vcpu_simple_cb_t cb);
>+                                       qemu_plugin_vcpu_udata_cb_t cb,
>+                                       void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
>diff --git a/plugins/core.c b/plugins/core.c
>index 15fb548f68c..111ceeea285 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
>     struct qemu_plugin_cb *cb, *next;
> 
>     switch (ev) {
>-    case QEMU_PLUGIN_EV_VCPU_IDLE:
>     case QEMU_PLUGIN_EV_VCPU_RESUME:
>         /* iterate safely; plugins might uninstall themselves at any time */
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>@@ -114,6 +113,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
> 
>     switch (ev) {
>     case QEMU_PLUGIN_EV_VCPU_INIT:
>+    case QEMU_PLUGIN_EV_VCPU_IDLE:
>     case QEMU_PLUGIN_EV_VCPU_EXIT:
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
>@@ -626,7 +626,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
>     /* idle and resume cb may be called before init, ignore in this case */
>     if (cpu->cpu_index < plugin.num_vcpus) {
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>-        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
>+        plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>     }
> }
>@@ -659,9 +659,10 @@ void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
> }
> 
> void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>-                                       qemu_plugin_vcpu_simple_cb_t cb)
>+                                       qemu_plugin_vcpu_udata_cb_t cb,
>+                                       void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb, userdata);
> }
> 
> void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
>index f29b466dab2..ba605246eb0 100644
>--- a/tests/tcg/plugins/bb.c
>+++ b/tests/tcg/plugins/bb.c
>@@ -56,7 +56,7 @@ static void plugin_exit(void *p)
>     qemu_plugin_scoreboard_free(counts);
> }
> 
>-static void vcpu_idle(unsigned int cpu_index)
>+static void vcpu_idle(unsigned int cpu_index, void *userdata)
> {
>     CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
>     g_autoptr(GString) report = g_string_new("");
>@@ -124,7 +124,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>         counts, CPUCount, insn_count);
> 
>     if (idle_report) {
>-        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
>+        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle, NULL);
>     }
> 
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>-- 
>2.43.0
>
>

