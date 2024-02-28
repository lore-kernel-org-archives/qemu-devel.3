Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94E6C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeT-0004nA-Lq; Wed, 28 Feb 2024 07:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeO-0004dm-Bl
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:04 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeI-00034h-AZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:04 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d28387db09so45489231fa.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121776; x=1709726576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pC0CILfvkT1LAPjD+cy5PSMJ+8YOfVMAkY3CpGh5+Vk=;
 b=EzsGqqv/OZUmEcdlXjmGNBRONrKIG5AxkP+ZT5wtEROzkND9WnNCuWEMaiYVzpzzsN
 C7jqBulZ+swpfDZLNtEIJPSY0qLXn5+3OzN2Jo/sQI6DM6fYXCwbbfJHREdAXtqyHwpF
 O7HdyNrr1x/q3xDc07HMU/Hd0Ith4UfYGGb/Ft/j7kDdBoDzlqODsO0EkwZu13qVkUPM
 a9jnVslufT/OYIRJNdUeufBAdp87dEwDJlWyqsiVx3iHr3hzO9Vz/OeMmKcOzxLQATNN
 pJnAoal0tqcuK6PfsoXTwz4EL/Ww7IFa3FNO/GQHi7L4ns6OP4pB/rTQhMEyh7374o7w
 8P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121776; x=1709726576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pC0CILfvkT1LAPjD+cy5PSMJ+8YOfVMAkY3CpGh5+Vk=;
 b=GbxaEl/+tDDIOxK7Pj7vky/0HekHkWTu6YTFIaec+/IRj5mfdP0tIkMvLJiVcUOKZs
 YuOYbV5m+oUF6bb/DcE8cT0cSJJWYyAEQ0SDZcFhAA+enqNR9GDv718CJ5RPaLZH0I+U
 PDJCECLeI6zhw9y7H07bMHfRZID9nA9zReXCuDOO/tVj97i92AMRYlrHy/OFWloNuRVv
 /VnEa5Gthx1bbiLkYKWjoGdnIy8XiuUPjHY3L4fGJmBsboBDLHVCPYhRuHLuClYUGlPr
 /0Gag2SXL2D8286SvqZNYlYGkMBeRKgDUpHnWSIQ7pvh+UghCMmcx9xCXR/0WAsPfqaF
 HM+w==
X-Gm-Message-State: AOJu0Yxw9DXsuzvSfDNUnVpWTknZrZDcBI/WkDurF3SAYuTG6nMVMlZE
 E7D6RWvqQhNi70saiqMMCiEk//Mrl+52GwwLTJ5GSOiYCWE65dTS2I8vALtisR4=
X-Google-Smtp-Source: AGHT+IHCBKihnQavink9cJUSVWNc3sVpt/jxZHShqNLLHcyyWdb2SHGoXbwxwb+WbV/WK+dJSM6Z+w==
X-Received: by 2002:a2e:6a06:0:b0:2d1:1ef3:3c84 with SMTP id
 f6-20020a2e6a06000000b002d11ef33c84mr7438014ljc.28.1709121776728; 
 Wed, 28 Feb 2024 04:02:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 az8-20020adfe188000000b0033d7dd27d97sm14421391wrb.45.2024.02.28.04.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E2165F92F;
 Wed, 28 Feb 2024 11:57:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 28/29] docs/devel: document some plugin assumptions
Date: Wed, 28 Feb 2024 11:57:00 +0000
Message-Id: <20240228115701.1416107-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

While we attempt to hide implementation details from the plugin we
shouldn't be totally obtuse. Let the user know what they can and can't
expect with the various instrumentation options.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-29-alex.bennee@linaro.org>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 535a74684c5..9cc09d8c3da 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -112,6 +112,55 @@ details are opaque to plugins. The plugin is able to query select
 details of instructions and system configuration only through the
 exported *qemu_plugin* functions.
 
+However the following assumptions can be made:
+
+Translation Blocks
+++++++++++++++++++
+
+All code will go through a translation phase although not all
+translations will be necessarily be executed. You need to instrument
+actual executions to track what is happening.
+
+It is quite normal to see the same address translated multiple times.
+If you want to track the code in system emulation you should examine
+the underlying physical address (``qemu_plugin_insn_haddr``) to take
+into account the effects of virtual memory although if the system does
+paging this will change too.
+
+Not all instructions in a block will always execute so if its
+important to track individual instruction execution you need to
+instrument them directly. However asynchronous interrupts will not
+change control flow mid-block.
+
+Instructions
+++++++++++++
+
+Instruction instrumentation runs before the instruction executes. You
+can be can be sure the instruction will be dispatched, but you can't
+be sure it will complete. Generally this will be because of a
+synchronous exception (e.g. SIGILL) triggered by the instruction
+attempting to execute. If you want to be sure you will need to
+instrument the next instruction as well. See the ``execlog.c`` plugin
+for examples of how to track this and finalise details after execution.
+
+Memory Accesses
++++++++++++++++
+
+Memory callbacks are called after a successful load or store.
+Unsuccessful operations (i.e. faults) will not be visible to memory
+instrumentation although the execution side effects can be observed
+(e.g. entering a exception handler).
+
+System Idle and Resume States
++++++++++++++++++++++++++++++
+
+The ``qemu_plugin_register_vcpu_idle_cb`` and
+``qemu_plugin_register_vcpu_resume_cb`` functions can be used to track
+when CPUs go into and return from sleep states when waiting for
+external I/O. Be aware though that these may occur less frequently
+than in real HW due to the inefficiencies of emulation giving less
+chance for the CPU to idle.
+
 Internals
 ---------
 
-- 
2.39.2


