Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B83CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXom-0005WM-3N; Thu, 11 Jun 2026 01:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXXok-0005WE-6T
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:19:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXXoh-0002N6-Ou
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:19:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso58243485e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781155136; x=1781759936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UjaEOmmu8CBpPMtGyHhLaTICPf4Q+9ZLsBTAL1eCyqw=;
 b=dO6agKFSHg7XOqSA6plg2QKjNKgetqDATeB11brAUJIeskeAlNq66BcUJKAfh3TU3m
 FqyfbBwQP+hH+ep/AXPvflyWWc0RnEAf9eYllf3m32lS8aOFnpX928QmCEsR8eQDu7iZ
 //F++4gSYsr84x5LyKcAc9owmv3x2SYQlh4BmSW75rQJt8+O5jRYGVqvLU1iqinLQ7ox
 e0226EsaXbn2DRCtCNHkKe8QtWpfzKGV0DdOcHBot9poFzW5/hP3VQfbJnkiI6LnZqrx
 MWp9DV7Yz/hlroTC/AaaVRladv7stEOS+6Z16HWsXe5o59XSvNr+WAYbMMev2Rf8MWeq
 0c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155136; x=1781759936;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UjaEOmmu8CBpPMtGyHhLaTICPf4Q+9ZLsBTAL1eCyqw=;
 b=rS1Y4gArdBZ6O2xC9J11oVfwMTZyDe+6IcCtp7nNT5RNP7sygG9ejn7EMxVyNMlq97
 xLPjJZhq6V5QiWOJp3cUO8awtgRtg+6v8obhob3jkQNUpCV3P0I4P01Fc7+r/gB1h8Zk
 4HMhtSTaN5JhDmhSmyMbCQH02Ci9NzaGJCoM2jtFpb7KJvDCmWseLiFTMdZHsOXwEGNt
 QDlifMzoQ3ynAs085qua71tL3yTjutH/GGiEiZ/RkGP8dpKkexWvgGAKG8UQypseahXO
 D4h/N0UuZI6gCkVSFrxr+kfRUZVzOWcoSlgX1xUVBYBTB38BqAC1bExcm5PgNKLpQKyb
 ODcg==
X-Gm-Message-State: AOJu0YzZRRgZZmJDxLyfe79jBQtNJGWD1oeDWgvIOAO9M8x7iKkB2aun
 dNXeJCiuGWnNoF3a82um1SKvlTJOW/FGATwcC3Jdf0gCPamjytqyauhaU6YcrD/7voe0PoPFANd
 lLk1BhAY=
X-Gm-Gg: Acq92OGRKUjw0Jg31M7T5JQZmRhCKnHaXeESTkKcAKrKlhv+8RB09TV/lj8Rc6rrtkr
 hIH0bUYDePngJMRiWuGpwC+Ey9FF6TQUzNOMihzRO6ErBRvpkKCEzeMb1KBiEEwfFjOgYVuWLL9
 D1jZP9PmR0jSPkFxxY/jipeSwfU4XW+FFPst5lp/ceJh2713/CEzVp/BpSK3423HfIaTg596jYn
 eR4nvpC/zMLz4v0d/kZ/+6e19aMRA77xVzokKUTvzPZ6l24gyeraEKT62dspCpQ2xvBbrw2ERLh
 bab81+Ns2Qx1BGt7owfMb05MmDE9komxfVVaNUHfANVdr0moYzIx4pEvL3Z1mLsQEeWK4q3KwO3
 tyPes6aSGRvFwdcKH88CILu7Q68SjOm1fmB01HkLIQLr7q5R1yivPTDFFYWTbPDHkpfe3oS7/h2
 zrY/RJsZVf89ANe3bv4KS46ZHoyP3lOWOA1X4q4+9L013tfKD84vMsasRzqRls5wyiK94cxcZXJ
 VGIB7s29lNzUIsiMpLDfwbOTtOgaQ1nwa63PiLjNrq1+vuu5UsHDErQyGOy1w==
X-Received: by 2002:a5d:64e6:0:b0:460:3233:6700 with SMTP id
 ffacd0b85a97d-460677c2deamr1530620f8f.43.1781155135746; 
 Wed, 10 Jun 2026 22:18:55 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm79588357f8f.1.2026.06.10.22.18.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:18:55 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:17:51 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 06/25] plugins: remove qemu_plugin_id_t from
 qemu_plugin_vcpu_simple_cb_t
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-7-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-7-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggc3h.5bomptf5np25@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
>Not used in all our plugins.
>Future commits will remove qemu_plugin_vcpu_simple_cb_t completely, and
>replace it with qemu_plugin_vcpu_udata_cb_t, so id information can be
>passed using userdata if needed.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> contrib/plugins/bbv.c         | 2 +-
> contrib/plugins/execlog.c     | 2 +-
> contrib/plugins/ips.c         | 4 ++--
> contrib/plugins/uftrace.c     | 2 +-
> include/plugins/qemu-plugin.h | 4 +---
> plugins/core.c                | 6 ++----
> tests/tcg/plugins/bb.c        | 2 +-
> tests/tcg/plugins/insn.c      | 2 +-
> tests/tcg/plugins/registers.c | 2 +-
> 9 files changed, 11 insertions(+), 15 deletions(-)
>
>diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>index f2b1b258a90..72cc896a0a6 100644
>--- a/contrib/plugins/bbv.c
>+++ b/contrib/plugins/bbv.c
>@@ -60,7 +60,7 @@ static qemu_plugin_u64 bb_count_u64(Bb *bb)
>     return qemu_plugin_scoreboard_u64(bb->count);
> }
> 
>-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>+static void vcpu_init(unsigned int vcpu_index)
> {
>     g_autofree gchar *vcpu_filename = NULL;
>     Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>index d347ac25b6f..398aa4a1f3f 100644
>--- a/contrib/plugins/execlog.c
>+++ b/contrib/plugins/execlog.c
>@@ -382,7 +382,7 @@ static GPtrArray *registers_init(int vcpu_index)
>  * As we could have multiple threads trying to do this we need to
>  * serialise the expansion under a lock.
>  */
>-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>+static void vcpu_init(unsigned int vcpu_index)
> {
>     CPU *c;
> 
>diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>index 7614ae1eafd..32fd86c87ac 100644
>--- a/contrib/plugins/ips.c
>+++ b/contrib/plugins/ips.c
>@@ -89,7 +89,7 @@ static void update_system_time(vCPUTime *vcpu)
>     g_mutex_unlock(&global_state_lock);
> }
> 
>-static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
>+static void vcpu_init(unsigned int cpu_index)
> {
>     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
>     vcpu->total_insn = 0;
>@@ -97,7 +97,7 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
>     vcpu->last_quantum_time = now_ns();
> }
> 
>-static void vcpu_exit(qemu_plugin_id_t id, unsigned int cpu_index)
>+static void vcpu_exit(unsigned int cpu_index)
> {
>     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
>     update_system_time(vcpu);
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index a071a34ea75..438cebf2831 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -874,7 +874,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>     }
> }
> 
>-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>+static void vcpu_init(unsigned int vcpu_index)
> {
>     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>     cpu->ops = arch_ops;
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index d7d972103cb..8aaf404504b 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -149,11 +149,9 @@ typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
> 
> /**
>  * typedef qemu_plugin_vcpu_simple_cb_t - vcpu callback
>- * @id: the unique qemu_plugin_id_t
>  * @vcpu_index: the current vcpu context
>  */
>-typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
>-                                             unsigned int vcpu_index);
>+typedef void (*qemu_plugin_vcpu_simple_cb_t)(unsigned int vcpu_index);
> 
> /**
>  * typedef qemu_plugin_vcpu_udata_cb_t - vcpu callback
>diff --git a/plugins/core.c b/plugins/core.c
>index b0532e8d0de..217d6608c1d 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -96,8 +96,7 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
>         /* iterate safely; plugins might uninstall themselves at any time */
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>             qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
>-
>-            func(cb->ctx->id, cpu->cpu_index);
>+            func(cpu->cpu_index);
>         }
>         break;
>     default:
>@@ -306,8 +305,7 @@ static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
> {
>     struct plugin_for_each_args *args = udata;
>     int cpu_index = *(int *)k;
>-
>-    args->cb(args->ctx->id, cpu_index);
>+    args->cb(cpu_index);
> }
> 
> void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
>index 8a854408aaa..f29b466dab2 100644
>--- a/tests/tcg/plugins/bb.c
>+++ b/tests/tcg/plugins/bb.c
>@@ -56,7 +56,7 @@ static void plugin_exit(void *p)
>     qemu_plugin_scoreboard_free(counts);
> }
> 
>-static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
>+static void vcpu_idle(unsigned int cpu_index)
> {
>     CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
>     g_autoptr(GString) report = g_string_new("");
>diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
>index 12421054f67..80f7cbb2967 100644
>--- a/tests/tcg/plugins/insn.c
>+++ b/tests/tcg/plugins/insn.c
>@@ -84,7 +84,7 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
> /*
>  * Initialise a new vcpu with reading the register list
>  */
>-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>+static void vcpu_init(unsigned int vcpu_index)
> {
>     g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
>     g_autoptr(GByteArray) reg_value = g_byte_array_new();
>diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
>index 6d627c70371..94776d887fe 100644
>--- a/tests/tcg/plugins/registers.c
>+++ b/tests/tcg/plugins/registers.c
>@@ -21,7 +21,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>  * registers that cannot be written to, which would fail the test.
>  * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
>  */
>-static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
>+static void vcpu_init_cb(unsigned int vcpu_index)
> {
>     g_autoptr(GArray) regs = qemu_plugin_get_registers();
>     g_assert(regs != NULL);
>-- 
>2.43.0
>
>

