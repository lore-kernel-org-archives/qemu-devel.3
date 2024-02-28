Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD3EC54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeO-0004dG-Eb; Wed, 28 Feb 2024 07:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeJ-0004OJ-QT
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:00 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeI-00034d-4V
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:02:59 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso496892f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121776; x=1709726576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITjmGoGHy7/JLnU20+irN4PvElz9B05xt+jQzipQhG0=;
 b=DB+7yv9LofiFhURPv+uCUBY488uvitCzb5lC8jiFVQIu/4J1e5bzoMr5s/WYIGtYmD
 apwFOixs5BiLZ9NTLK3EjKojQeaDrEaUjPINO1hMUlTqdJUDrL6R8sfnY2oI/orIMlKc
 cy9oijNGfXWhAZMZuj2vg6sCuGJ4kXFDlL/NR3YsmyaDBc97B/jJdBf4SLmGGSfjBFX2
 gxdcTFfTZJ0tfB3sbg/ZAUQb4BKdJ3tQhJTWCAxUtJc1qpfemmoO8oQe1Hf5sGrb4kRf
 Z9JXWdSA38PkTybVPtenchaPuWKmV74+jQzjpQ0kYduKO0OR9Qp0mu2N4++KQdayVGZX
 m7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121776; x=1709726576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITjmGoGHy7/JLnU20+irN4PvElz9B05xt+jQzipQhG0=;
 b=Ujt6/cWixgXJb5ETymw9iqlsHttSormrG/KjsKTUiFKP1HWGMrvlpmTKQkvxNowOsP
 nnrGtQnoJEKPVnqu8cDq5X0VDcPNyJafG+hb1nn7BgoCupd450yQUfkfqgR6X7W/RvRT
 GKY0GkTZBl8F+zmznc7LmZgda3klTdCHry7Yk6Qcw8cn4mbNOfVWfBnJk+OJJ2r3AVTM
 54B1YwgeoiQB/R+YNmgNYLqqrF5iG6f/x0p3gnysEQb/1WD1SyhZbgTZIj0jJzU/x0Pz
 glczlTIBL88ECOVV14c2jPnX0ksHtdFKu048pI2QkrEFiwDrD8bIEKUyYiUoBF7TSaph
 Sd5Q==
X-Gm-Message-State: AOJu0Yx+zyAwaSKhLZy7wTFM3YgaQAYnpfaZP14huh8zdGWZF0xNsFlU
 oz8GrK2VUw76KCB5lNPVnY9rs4d4MTw+a5vHfran6tRBWQECjviLZp/9ucvdxfo=
X-Google-Smtp-Source: AGHT+IGPokVN6K43Ygn8gaQ93BA5b6sifhsEIlYqKG8Ln06zzl/kX11VJYzydgq8VbKPhOxIAx3zdA==
X-Received: by 2002:a05:6000:103:b0:33d:1ece:d618 with SMTP id
 o3-20020a056000010300b0033d1eced618mr2006821wrx.8.1709121776508; 
 Wed, 28 Feb 2024 04:02:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b0033dd56b002asm10205342wrc.73.2024.02.28.04.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9FF3C5F911;
 Wed, 28 Feb 2024 11:57:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 17/29] plugins: fix order of init/idle/resume callback
Date: Wed, 28 Feb 2024 11:56:49 +0000
Message-Id: <20240228115701.1416107-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We found that vcpu_init_hook was called *after* idle callback.
vcpu_init is called from cpu_realize_fn, while idle/resume cb are called
from qemu_wait_io_event (in vcpu thread).

This change ensures we only call idle and resume cb only once a plugin
was init for a given vcpu.

Next change in the series will run vcpu_init asynchronously, which will
make it run *after* resume callback as well. So we fix this now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240213094009.150349-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-18-alex.bennee@linaro.org>

diff --git a/plugins/core.c b/plugins/core.c
index caa66311351..2392bbb8889 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -391,12 +391,17 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+    /* idle and resume cb may be called before init, ignore in this case */
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+    }
 }
 
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+    }
 }
 
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-- 
2.39.2


