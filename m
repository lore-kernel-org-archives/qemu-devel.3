Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF6CCD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY51-00061R-9r; Thu, 11 Jun 2026 01:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY4x-0005ys-DZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:35:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY4v-0003ve-SE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:35:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso58323945e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781156144; x=1781760944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5ElWbzjVypWlrVh6LESjAfeS/jK0VOYQlZiZxzyV218=;
 b=L1DmWH7KaiY4AMHDklYvuEbcclAC2GWTzkY7xaw3Js7gWPyGvwZeITIx3kXohXjkLg
 ebT911PPEBvyuHrNu4os5JSm/Gk2a0POtEFuw7I3J4wL8q9jd6L1RgbBqh4oGBu+U+py
 1QP8/ewHJSPwI3rCSsAaRLnyBZMsQUKaGp01fPTcgruVsEV5CN74xlwCCoW3/QnYu7o8
 leDsDRw6ZanNSN5dcvJgYu6x3+jLFGLJJAWurdXoXqaNs4Ao7b/MXY00b5XkAISIS219
 Wxeo8bITHsjEoZQ4lrhK8mgME7uG63Jn1Pnew4weSiftjHzCKcN7754uyRWR2shdqyOa
 cqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156144; x=1781760944;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ElWbzjVypWlrVh6LESjAfeS/jK0VOYQlZiZxzyV218=;
 b=OITYPLzZZOgST8yibPL27TESqE2PvkCIKkxcE2UAhfzQrcCjBP9bYFxd8G8GjrrFII
 h6nG0/+n7BeReYjkcO8J8e5dKpe3wG6St69erMAt8fDZcYJg5Cx/nnW/1u4ofHJUhEIp
 /iXJOrUI4zPBLQ7hjTFaLc/l13RGSyYSD8ZaF332/a4g6bAQ+1OPpwh/jtF51dKOwaGC
 AAQ04WAOV3b0FitHk8a49PpczdD48dZYyrjObWqir8DXW8Hjw/W08x3k03yHfPWw/qtp
 ZHWZ+cskuoSIwIPvmQGGDfdpTroZ0d2Qi19Qgy9GDEWtwHhehJsDEQ6Ae59rkJSMVBvS
 4qSw==
X-Gm-Message-State: AOJu0Ywrw5ZJUnkS2RtvSGEKZyjrlY6KipCbzl5CaQgYRY7h+wbWuPBx
 K2UFRr8zC+O5VeVtDXnbo1i4Rq2RufQ+A4/LQIxZvPFwvrTMp49ptC1d+ImDf7july49XAjLv6H
 BC1Ze5tI=
X-Gm-Gg: Acq92OGwHdThSu+dySPe6GUD0weLv8PPW1p4/o89eaTHjC2SzFwcOc9uUJ0B5d7UJHE
 sRUWLqqF+uVygnsYwun11MY2vz2FN3cg9teoqi3GYjPhyZvZVdZqtsRXiTOZvTtQqwExGXtqOTt
 6ndqA+JlciB/rbpQ+5XLs9JVXF8dHUwnOXeG6ocod8tKtGDqAW9YAcJJJQwX9jyCpwg4cry8pu3
 vpIliteJJOqZY1I9nUeECck29CO+liRoMmTIm17nxtQkMIEDs+acN/yQxLQavt/fWqMFQg7a21C
 E4v1N9ujq8CviiEdsEPFVLVyIGdJa8nna4GVER+rgNYWkJbtW7ptzGswA0arc7uvl0SohbA+yrr
 E+JHt42wTKPqBJn9YgEYMuA9hpnFjaT2SbokI8mWU8A/HfvpGvve8EAia2ERWi8b43m3BRW023W
 nklEbNRLsd+jcNuXCWr40XJP/t+4hssDsbw2/d3qgRLCfA8vM5tEB2jThZRSv1paUrAR9mx6bJ2
 cW6ON0yg7UMt4LhRc2gujAyJBFjfU5h2N79FIKNg35t0G6DVelS4czAbMTP3w==
X-Received: by 2002:a05:600c:354d:b0:490:469c:556b with SMTP id
 5b1f17b1804b1-490e55e22admr14427955e9.12.1781156143339; 
 Wed, 10 Jun 2026 22:35:43 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm83782938f8f.17.2026.06.10.22.35.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:35:43 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:35:12 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 12/25] plugins: remove type qemu_plugin_vcpu_simple_cb_t
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-13-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-13-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggcvi.31bc9hufvgnt4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

> include/plugins/qemu-plugin.h | 6 ------
> include/qemu/plugin.h         | 1 -
> 2 files changed, 7 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 320644a2f0a..cf937c60ee7 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -147,12 +147,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>  */
> typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
> 
>-/**
>- * typedef qemu_plugin_vcpu_simple_cb_t - vcpu callback
>- * @vcpu_index: the current vcpu context
>- */
>-typedef void (*qemu_plugin_vcpu_simple_cb_t)(unsigned int vcpu_index);
>-
> /**
>  * typedef qemu_plugin_vcpu_udata_cb_t - vcpu callback
>  * @vcpu_index: the current vcpu context
>diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>index dac08cdc60c..9356ee836ac 100644
>--- a/include/qemu/plugin.h
>+++ b/include/qemu/plugin.h
>@@ -56,7 +56,6 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
> 
> union qemu_plugin_cb_sig {
>     qemu_plugin_udata_cb_t               udata;
>-    qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
>     qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
>     qemu_plugin_vcpu_discon_cb_t         vcpu_discon;
>     qemu_plugin_vcpu_tb_trans_cb_t       vcpu_tb_trans;
>-- 
>2.43.0
>
>

