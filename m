Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4902CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYcn-0002XS-6M; Thu, 11 Jun 2026 02:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYcl-0002X5-J9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:10:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYcj-0001Ls-UN
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:10:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso58526115e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781158240; x=1781763040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cMM27LJvP4daElGz0dSOuPffP5CA7tU4Qd1Qy3evlTk=;
 b=SAGr+l1TzMhJsDkXzRwfravTwsQNS9QTwy5I3GYwIU9AUv1jCXydti2zqCspEMj/0p
 uKogmf8OrGiQTSqZxzrZIzqC25bUZK0JjWrDl4Mbq+12BlyeOwOLrixxe/b0tSO1Y1J1
 X4U8aqLneL+Tw4JOee4addVumVsXTkKls0aQ3Z4tKSs3Vt6X8EntYWyUNnyGt2UULZka
 /2X8dCF3zzur/wQKgbyX2JqMBrMYJNxJjCIQkRhOJi0qXoeegwv+sQ5a/HPXqyS0J3R5
 o0fF5MOybcWoKPhhCALjuTaRRyvMvFZ3ANGuCjPmrHhF4b9SOXg7wdtueyi5jqk6lDpl
 FUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781158240; x=1781763040;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cMM27LJvP4daElGz0dSOuPffP5CA7tU4Qd1Qy3evlTk=;
 b=mfriJnp7LV2JCh0N3d2hfeyu1JMOLuMl9e8q7ZH90Pckp1Nzx0pWpZqQEJ2m6T3elK
 NdgGYRjsDG7/EFgXpiWPxaJ96Y1r0i6O3KkG1TAJPfNrJdCCgO3zzGRcZFb0qOlMwUGq
 IAfYfqQrMUOy5pVRbILQ71ipkVV7fDvvqJ2bBMIXzpf1e91LyqzBrdS5g24ev3lKhfL0
 zmiOOQn3fVfAK1jO9PxcqCA+Nd6JmF+S9Mu7sLqvW7k0Vl+bIrU4p1doDlm7PnKVBjC5
 eyqu5Ki/R9WpRysqw+ClzbPkNC2Qb1zBmc8p9R8CFa6EcUcFgH6OO0Gh8ORp3AK/DFbg
 Le2w==
X-Gm-Message-State: AOJu0YzkrC42M+7aEZ3FhJfZ8zgdfKIBGKu6HnGqPTrkGJdcfdJd3PN5
 y1dzWT26o4yPU2gSGvkMMSdutRFLyMokiGuMiKcmd7g3FnIoM0mR0cTttv4fDxucCBCY0ip7Jnf
 nuIICNTY=
X-Gm-Gg: Acq92OHijnuIfNGLH0RWCNjESm6qtbeylqrDrjouyfiQdLoNt647DgZxyMJXJb1at3Q
 sO3gthVQHXH2oL0Lon1FrpgLGiqqjRi7gjgoKbrXJ4HJXZjoU9W1DxEml02irPaIIFZqSLh1FdO
 f3oDZZasNChHgozbYy+EVw+RFNgcu5xmwP0WQaTpVakbz3XW6kudwsQPZlIFGkVTsn8Wwb8yuRY
 pZYbu4ZidgWc6uWKTdHt72EIDD8X6gLmfV/LazrCgPl4YpDVEw3j/UduIVoK/qbgkqKmC4/tK9A
 YydOlbJGEIrJUSnVhY/VLy5vEnHb+AEXyaJPk90FxT+66cPdVx6ln1N+5sf0LbRDJpprm/FMfGZ
 mh649PPBUJVC4Qa7K8/8RTqVuL/afH4UKIgGUUQMdx7HxQdtLGhAoOiRVp6STYVpDbLFsoNsRsK
 IDFFbApsNc53EoaxK4HeBCNgszxeanQg6thbYl/fuA/X0iEbHp6L2ex2J8Mo/6gxajUlshkWw4r
 w78Oxt9cyZQtTmB3kkGU+Z4tS1UU1e2iq27f/ReR7gM2ky6MO2HusTFTd/c4g==
X-Received: by 2002:a05:600c:3ba4:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490e55df6d1mr14760765e9.11.1781158240363; 
 Wed, 10 Jun 2026 23:10:40 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcad5sm86088733f8f.5.2026.06.10.23.10.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:10:40 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:10:15 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 21/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_ret_cb_t
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-22-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-22-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggehr.3c4mygss4okxc@linaro.org>
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
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> include/plugins/qemu-plugin.h | 4 +---
> plugins/core.c                | 2 +-
> tests/tcg/plugins/syscall.c   | 2 +-
> 3 files changed, 3 insertions(+), 5 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 33d6f8e0b7d..4f0c73c7b33 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -879,14 +879,12 @@ typedef bool
> /**
>  * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
>  * function type
>- * @id: plugin id
>  * @vcpu_index: the executing vCPU
>  * @num: the syscall number
>  * @ret: the syscall return value
>  */
> typedef void
>-(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id,
>-                                     unsigned int vcpu_index,
>+(*qemu_plugin_vcpu_syscall_ret_cb_t)(unsigned int vcpu_index,
>                                      int64_t num, int64_t ret);
> 
> /**
>diff --git a/plugins/core.c b/plugins/core.c
>index fe292a098da..887267f8174 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -557,7 +557,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
>         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
> 
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>-        func(cb->ctx->id, cpu->cpu_index, num, ret);
>+        func(cpu->cpu_index, num, ret);
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>     }
> }
>diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>index 410fe617804..1bc737824ce 100644
>--- a/tests/tcg/plugins/syscall.c
>+++ b/tests/tcg/plugins/syscall.c
>@@ -151,7 +151,7 @@ static void vcpu_syscall(unsigned int vcpu_index,
>     }
> }
> 
>-static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
>+static void vcpu_syscall_ret(unsigned int vcpu_idx,
>                              int64_t num, int64_t ret)
> {
>     if (statistics) {
>-- 
>2.43.0
>
>

