Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95F6D116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 16:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP1YH-0007gw-JV; Fri, 28 Nov 2025 11:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP1YG-0007gW-DZ
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 11:42:32 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP1YE-0005MI-R7
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 11:42:32 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so14314845e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764348149; x=1764952949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=esgdSOmxvxoM6dFXZTRW1Fb4sqxSg/3cnp175TBjiD8=;
 b=dLZETDzgG9XvTQ1etq0X+NS7S2qfdPo5ABWFDV49ghP3ehoRs3zkwy/Ypfv48cIq92
 wq0zdsWhEfM60GOfpq2slWu4JvwRyihFg24uJkOc0ntzZeRJIlqmnU9mN3onVV9b1d+y
 XO9yJMLJCjPdIq5Qp47vpI3aRn0yhLL+m0DIWXcXnejLJM+Sj3sFbA2Gntbg1nCwJiMl
 VOx5qR6fA5y7+pFtqB81n6XCyteVie2WDsQdLL4wh/omLVv69ZMi1YMY2xGGVQbzD1zM
 lg2p9OT9KFLn7uGHgUzSK3mSawdP6U6rU672/IjZtam6HUNnB2X1LYUOmJhAucy5FdeY
 H4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764348149; x=1764952949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esgdSOmxvxoM6dFXZTRW1Fb4sqxSg/3cnp175TBjiD8=;
 b=hdtSROJrLYtEiFWZyvu3+LfXdqKJq7iXqoMAvy1yJs3Bf/9dFJP1bZxKTQYXHTUQNl
 ipgws9G9S0iSNk6/P90aexJ6lngq19PQPpv8SueDEjgfrRwU74ztKlJepnVcbYiY1k9X
 2QMhuiWc8OPrKT+Ev/bTMI9G0zgvRGANaNd3Espt5M4Esl2qRTl/lzu9JvMilpuuTzmJ
 W22N0NRLaNhFlH1rE7YYuoEqgDkDyjOCaJ9U9WYl3baMBJwhVbbv/mZg1Kn7OpenRgzG
 54BUPnMNpl4yA0jT2ri69qTwuUskrTHMBlsKwM/bPr4qxb9NUYpMkVpj7a7Vq5iLIz6o
 jSjA==
X-Gm-Message-State: AOJu0Yz1J8JtGcnXYt/y9CR96SCG7NMctf9/2btVH+u3AU5EkMLqz5m3
 bDEsKXTmddPEbuTmGENdPfJOoUAorZG+ydsi41ZVhnSXy+xIgmBgHrpK5nVptBch6vM=
X-Gm-Gg: ASbGnctRYbl0xMBv4YYEg8R1xrRIavFB/GsA7R7IiH7NipewYyid9NucgU2jZ8NAJgc
 w94fNUKZg+Ba2evO5hpQGzUOFIaSTnzz2j8gDiFsDN5e6yuN1FI3Rm3Uz68xLls8q71vf2hH8f9
 89FzaIKv39LqQap1utHn3/JbavdwSH0o7OuRWQFBKEvSwV2YDvCJQbBjidYz0ZUxxzXEtvqnyXq
 +bnjlLq/+FB2MpEYBLQavLgmA4wHoxUOBK7dxT9n1o+y8Sw9mm/wmUiA5I/QvBqfGvPd7XF/YpJ
 9WXCFM6ClPxLFoTYhfX3JeMxEmYKYs9jnXjK14Q4jwOzKJtOZUznHS+qs8uBN86T6/BP8mrGiye
 JziNiVgWxci+wYYqdkXVH8E/oZoFVYTlYm65NpBdQ7vgJBvaYkfcfbzxMWrw4zxLSCdtQ7tgTjv
 FFAGUqqXZZyPg=
X-Google-Smtp-Source: AGHT+IEIRXc44TucdaQii+/LCpxkvsB/eubzHEMMQc/AGNMfUGOLwdCudwAmHuxjnAaJDGIiYNxMWw==
X-Received: by 2002:a05:600c:1547:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-47904adff1cmr171430935e9.13.1764348148820; 
 Fri, 28 Nov 2025 08:42:28 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add4b46sm168944515e9.4.2025.11.28.08.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:42:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 514795F7F6;
 Fri, 28 Nov 2025 16:42:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <neither@nut.email>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH] plugins/core: allow reading of registers during discon
 events
Date: Fri, 28 Nov 2025 16:42:20 +0000
Message-ID: <20251128164220.3985408-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

We have protections that prevent callbacks that didn't declare
themselves as wanting to access registers. However for discontinuities
the system state is fully rectified so they should always be able to
read the register values.

a1688bc86ce (plugins: add hooks for new discontinuity related callbacks)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Julian Ganz <neither@nut.email>
---
 plugins/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index 8f8bc7219c2..b4b783008f7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -119,6 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     struct qemu_plugin_cb *cb, *next;
     uint64_t to = cpu->cc->get_pc(cpu);
 
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
     if (cpu->cpu_index < plugin.num_vcpus) {
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -127,6 +128,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
             func(cb->ctx->id, cpu->cpu_index, type, from, to);
         }
     }
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 }
 
 /*
-- 
2.47.3


