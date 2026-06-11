Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF4ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY6s-0002xZ-7E; Thu, 11 Jun 2026 01:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY6p-0002gH-PP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:37:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY6n-0004Mm-T1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:37:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so5172450f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781156260; x=1781761060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YDirniw9xEcb2v1PJ9rrVhb4aUrI5SnvtmokibV5G0c=;
 b=c7MhPNW6VYSmzH4J/IIVo94Owt7etm4UtG1twXyGYb+nuWo/ESqvZgiCy7adD6ZcmK
 ul3h9BtoeiC7AI8vPvOOxc3ZoxMlgV/h39MTnGeplJjigluGwcprRbE6tqMfoV2onzlz
 v+r7UTtrrqzP0/PR9qbhv8kVV0r1VEoD13taBnweyMQjgbQjlk3GAtNvGCUGLgB1Gnr3
 3eOT8Ig0c3Hkdp/kPphhjof3jQ1m6/GzIqrKj093xOQQkrvilLylRWhM/LBd1Jh+J2Ag
 bJnHgeSPIt8r7ExQUqui4WmzCUICvCevomAZvXC8xzwnp52AN9vaMydmHv65qys2krTc
 g7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156260; x=1781761060;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDirniw9xEcb2v1PJ9rrVhb4aUrI5SnvtmokibV5G0c=;
 b=Ybk3jy75tYaAKFnOJaK84tUIhreArGF1N1h6hOlMsmFLc3inXTfdUH5t0tCtKgIutB
 9kFOvwUU3tS6S8XTrexV4nHHZfJ4ipkbzKOADLgXmmiSuLDcndiyMC8/32xVAxcenoUJ
 6xAtIRajboA3msg2Fl9YnrnVlNnGTzzdRTK7n1YQ1szXhXSU3JUOBQSsLoCXa7V+Zqud
 5/JEW0M4dTPWzd/50mxVN0m69KxTmXHprG2nf42JDo0hNADm97hSiH+hGmqY7TBdwOhR
 DllpumTJFtfbmmyG7RcqWVRXJjEE1Ocb7uO03fJ+iWKSYqSj4OD+vcp6iaKCa5sYRBfk
 0xrw==
X-Gm-Message-State: AOJu0YyuB+NpaIzzkRCkKmg8v5KAW9LS+0nCG7edkCLfn7V7FV4+JYlh
 /3XL+9yJxCHqM0Gir6OQi4cTcE8XzbIiRHyyhfyfL6IgKEWfvMDU37fFclIuIf6VguXNbntUQ4W
 YKfrSL00=
X-Gm-Gg: Acq92OEKKFJ2jBkQkpEMs2jwgfmpgLlCqQYcnY7BMhYk/e0Ue17CsrrD4oLlwbeXQtu
 itWl1eR18e9X4XzbfUn2dOXmJuaPzbCUHsDivHtaGn+H8ITndurXLxt4btxCwTwmgRBU2V5fMwH
 NaL/thrjHQnalTqAuUpnEBD3vqnY1HbJMXeOCacZH93vAWd5cz3s0FhRNzL19nW9oCtLVjvzZb1
 rljfJlWbHteouHC6PGLHqJPt//3lOiX97xITELxFmL4KSkmOVruf1qfxXgFGW9IvKsjxWzcX/1f
 qOFGU/4ituub2M2nTOPwzDdq+cgQBvaJz6JJiMMDJGWYwpkgguR5IPbQIp3xL/G24haTlrw3Sv9
 572tTluYubw5ZCkmsxGKEsnWpHg9gN3kiS7M44Q/lu2qVBIFUeVNDkv0q3WYjbmemULa9+8TB51
 LRSIqq3XMN7H87/N7gazojUeVzLtZoXZ7L3Euq39Vjis0RA3yHENAguh1HV29zeeaZr0f6BamIo
 FUXsy3q3WvbyEgpJ+VRgfeFGkhhvnX6rTFqXJUuydfe+VDU0TceWlH3GZgnqg==
X-Received: by 2002:a05:6000:26d0:b0:460:3234:77d3 with SMTP id
 ffacd0b85a97d-460677e96dcmr1625688f8f.41.1781156260220; 
 Wed, 10 Jun 2026 22:37:40 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fb24sm83557171f8f.34.2026.06.10.22.37.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:37:39 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:36:47 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 14/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_discon_cb_t
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-15-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-15-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggcyr.3s68li8gme6zn@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

> contrib/plugins/traps.c       | 2 +-
> include/plugins/qemu-plugin.h | 4 +---
> plugins/core.c                | 2 +-
> tests/tcg/plugins/discons.c   | 2 +-
> 4 files changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
>index 4d59aa3c09d..b6df4455d63 100644
>--- a/contrib/plugins/traps.c
>+++ b/contrib/plugins/traps.c
>@@ -23,7 +23,7 @@ typedef struct {
> 
> static struct qemu_plugin_scoreboard *traps;
> 
>-static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
>+static void vcpu_discon(unsigned int vcpu_index,
>                         enum qemu_plugin_discon_type type, uint64_t from_pc,
>                         uint64_t to_pc, void *userdata)
> {
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 03e7b2b1fb8..60d27d8d9c1 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -180,7 +180,6 @@ enum qemu_plugin_discon_type {
> 
> /**
>  * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
>- * @id: plugin ID
>  * @vcpu_index: the current vcpu context
>  * @type: the type of discontinuity
>  * @from_pc: the source of the discontinuity, e.g. the PC before the
>@@ -196,8 +195,7 @@ enum qemu_plugin_discon_type {
>  * observable via general instruction exec callbacks. The same may be the case
>  * for some host calls such as hypervisor call "exceptions".
>  */
>-typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
>-                                             unsigned int vcpu_index,
>+typedef void (*qemu_plugin_vcpu_discon_cb_t)(unsigned int vcpu_index,
>                                              enum qemu_plugin_discon_type type,
>                                              uint64_t from_pc, uint64_t to_pc,
>                                              void *userdata);
>diff --git a/plugins/core.c b/plugins/core.c
>index 54ab3bdbedc..3c3212aedda 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -122,7 +122,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
>         /* iterate safely; plugins might uninstall themselves at any time */
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>             qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
>-            func(cb->ctx->id, cpu->cpu_index, type, from, to, cb->udata);
>+            func(cpu->cpu_index, type, from, to, cb->udata);
>         }
>     }
>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
>index 22114830fdc..5ab645705e3 100644
>--- a/tests/tcg/plugins/discons.c
>+++ b/tests/tcg/plugins/discons.c
>@@ -96,7 +96,7 @@ static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
>     g_free(report);
> }
> 
>-static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
>+static void vcpu_discon(unsigned int vcpu_index,
>                         enum qemu_plugin_discon_type type, uint64_t from_pc,
>                         uint64_t to_pc, void *userdata)
> {
>-- 
>2.43.0
>
>

