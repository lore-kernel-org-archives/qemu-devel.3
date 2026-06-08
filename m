Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC02CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWT2i-0001ZJ-SZ; Mon, 08 Jun 2026 02:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wWT2b-0001Yj-5v
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:00:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wWT2Z-00069p-6e
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:00:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so33769735e9.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 23:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780898448; x=1781503248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Zg+Lomq9yqJDZYeumnbSidQrTfF5LG1+7Gunfz62zPs=;
 b=ZNGpsok6xQoETKqGwpItUu1lAAc/ABPy3KvorrmyiGF+fHxrqoRBZ2vJnnYFVfJfap
 qlta60bxuz9SLvaiugWuyptnudzOrWHJfyfSlCBzaLVgniWyh4aiz1pRuPXz3PiwEsWS
 r5bHnFaU1jfjUjPNLk7L1Cn7eLNRMCz/TKlv3zspQKysAj8TXi+JCC8OYTSboSsxoa7j
 GfqxVUHw3SMl7AwkzSNk4CGzykDK7dcz+ieaDeNv0xCLjYVVcgONsfrjPDVryxxLX+pj
 BAwQNEodBLIqrYwGJSXsq4rY2hxLqnyRtPQxyQI3p+wSgm9IqYFeaDALyA7yNzYqq9f+
 z2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780898448; x=1781503248;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zg+Lomq9yqJDZYeumnbSidQrTfF5LG1+7Gunfz62zPs=;
 b=tOi1hNQcPEsHAy0mUkGSM9J61aoNW2b2JylVg2bdZv4H8TE1jK/Az14Bw5PE68j3X8
 lWmzBCgxRilGfp8rbAeSJiV4yVIvXf00gKas1oSxVvHaxG8HhAtZdADjmZC8+G/XCszP
 aIZpNkZpZR9COEpaR+dAfijFy4giTjXVZlugZXBCv7+3ODqTnK/RZ2IITJAUnT0FdDkP
 Cqb7Ge112RLtsgTPGtBjPru87ZoixrBiM7ZvsCRrGfewnKom7711izR401faUP3+NNVN
 j1nZJenoXPoRHxoSOvj/4uotk4RvO1Cw3/FwFVBvo4dHoghMTco7HZCyNIS867giisIB
 YVVw==
X-Gm-Message-State: AOJu0Yw1EDu8sxH5dLIT99RSkoAilnB/PJ5skofCH/IUwrPQmcezjGUr
 KUFebnZAPM1nUf4Cc4hCmbp0yuNWV3j6zFNrtAApEmjzvQrPt8nfhIrCWhgkosftDnBUPZ0GlPl
 9hpD8cl0=
X-Gm-Gg: Acq92OFeBX39jah2y9LQ0+vpj3Ol13UFLUil5YiqyA0Mc6bxdGSoufq8HoUGtCO+ylE
 aGfOgAheHwuLyWn3Yo6deSslVPDPF2z2bH0CxIb+kFzeaZF5KyCx3aGf2OBEZnUCHJ8MeCLXD63
 xWBK85NWAJp/2i14smMJUrSePVdHnVK83wf6yD4kKAcHlzKp7M3HUlN/AaNTE+8G9fWOAAarqWY
 W2SZ+2d/4pDwwSeb6vikDvQKYKvYhX8q0R/FQFmBL+1lE7sQ4bDFZc5DYEUOdrOCTgdGvZqZS9I
 vXnB7rOVylhvkqawtM4dhTtkEmV6R/b1WRIHCVGDbp5EbqTtsBJrMyUCl21q2bsIsqfUs4RU3U1
 vWa0ijMXGJdFpjDJSIUPNOxS0TNeDw6f3QxM1XkkHIyq2zcNFIozSaUEONTlNpdnrRCdf5tN8zi
 hX5I0S5TKP9pV5yHXAjcZlqomFdRUOgBIPC9Jm2B1Cy8pIhYr1xizd+YquuFtxF3ozXZOvOphYk
 G3icXUnsS0sSfB/2VqtTk6sr1t8KoMerebWu47LxNtuH/C+PCmDlsyeLPkcyjYf
X-Received: by 2002:a05:600c:870f:b0:490:44eb:c1e7 with SMTP id
 5b1f17b1804b1-490c2624a03mr225255725e9.30.1780898448335; 
 Sun, 07 Jun 2026 23:00:48 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3e59f5sm387459695e9.14.2026.06.07.23.00.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2026 23:00:47 -0700 (PDT)
Date: Mon, 08 Jun 2026 08:58:54 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 01/25] plugins: bump version
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-2-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgau1a.ktx4pl5etvkk@linaro.org>
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
>Next commits will be breaking changes, so bump min version and version
>accordingly.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> include/plugins/qemu-plugin.h | 6 +++++-
> plugins/plugin.h              | 2 +-
> 2 files changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 4eb1d2cd85c..435a14f5a00 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -80,11 +80,15 @@ typedef uint64_t qemu_plugin_id_t;
>  * - added disconinuity callback API (for interrupts, exceptions, host calls)
>  * - added syscall filter callback API, which allows skipping syscalls and
>  *   setting custom syscall return values
>+ *
>+ * version 7:
>+ * - add userdata to all plugin callbacks, allowing maintenance of state
>+ *   externally, and easing interfacing with other languages.

You could alternatively add only "version 7" line and add the 
"changelog" lines in the patches that introduce them, but doesn't make a 
big difference.

>  */
> 
> extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
> 
>-#define QEMU_PLUGIN_VERSION 6
>+#define QEMU_PLUGIN_VERSION 7
> 
> /**
>  * struct qemu_info_t - system information for plugins
>diff --git a/plugins/plugin.h b/plugins/plugin.h
>index 6fbc443b96c..9179da43851 100644
>--- a/plugins/plugin.h
>+++ b/plugins/plugin.h
>@@ -16,7 +16,7 @@
> #include "qemu/queue.h"
> #include "qemu/qht.h"
> 
>-#define QEMU_PLUGIN_MIN_VERSION 2
>+#define QEMU_PLUGIN_MIN_VERSION 7
> 
> /* global state */
> struct qemu_plugin_state {
>-- 
>2.43.0
>
>

