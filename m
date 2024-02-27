Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3110DC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reypQ-0003Qy-N9; Tue, 27 Feb 2024 09:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypO-0003DW-6S
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypD-0004mv-5b
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412a9a61545so10667755e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045571; x=1709650371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LY87PsqI5CseL6bunSV/a+wwJBYv7wofoTM3s0oA7jk=;
 b=WpE3xPi+wpaqIEdhOzo5JmMHLxtVyQ+fI4mWd0vJVyu4f70mJQeMd06BPOqVss4UT8
 YSmo82IEC/z/jLWQOrebAdtdwu1l0m9mfzYsX5mN+rKvVOncRZAQzgEKnPX/ACcE1eRt
 E/x8YZ7B3dbj8FhorCCVHQLH91+n9H0eChPuDuTUEqYIDN/kojz7eaSoAdF+WPX93T6e
 LCb5IKrnk+EJEk8DpNn2hMvAUGL30oNxsh3pFHe6DzZJ2+dlTQTtA8EPC/n1tefwgiFI
 nuuGG5SOKlAabK5/TNe4avv3aErFWmaHhkcSYzeH6rc3L2z8KsqCEJV9jWGGG5SF7NA7
 MgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045571; x=1709650371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LY87PsqI5CseL6bunSV/a+wwJBYv7wofoTM3s0oA7jk=;
 b=sI5CGYcJX37IcdiYFkOHJVJ9uIpepPidg6FO+i3RfqnbJ1xDKw5nEJhqBs19iphfh+
 lSPaodJs3i2K+VmQIqf+WR4+A8/iEY/dNJ0YPCxol2d6FBJGSo2tBJwCrWaufLAOeFro
 Zz9OdDtTidYa81F3vV5mMlW34qJ/+hvUXn1Z5G9uUyLZLEmTCZGgkX4EE48LhQ1VF7hx
 CuLXozvWawdIqnINwvBwlgj8+Og9yrb/kFmCO04dT5Z8KgnZx+qW1Cit3rqDRMYHZAxF
 rfsOb0N/BZ1gsKjtKkgBcSX+P9KOSCyMHaSzPtTQFHaKGcb3cn2qypb0kJit26A5DvnZ
 4X6Q==
X-Gm-Message-State: AOJu0YwodEIodZ8dfIpHV+iIR0mPNqxmrz4TC5SQeJaO9DbROuKjesL1
 QTHLU2SRWOQg0CsW/5bUb/zdQDa4sYaYFkDewZUSlu/CL46Ifxj/AWa4vA71RsQ=
X-Google-Smtp-Source: AGHT+IHbvfRK+W3sbbX597Xd664p4Zgx2ror9Jp92I+pRQYcvikt8w0hNQFgUIQxsFqNpf4Gton/9g==
X-Received: by 2002:a05:600c:5021:b0:412:a451:d32f with SMTP id
 n33-20020a05600c502100b00412a451d32fmr4857772wmr.20.1709045571014; 
 Tue, 27 Feb 2024 06:52:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 co2-20020a0560000a0200b0033d70dd0e04sm11964404wrb.8.2024.02.27.06.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:52:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B1915F923;
 Tue, 27 Feb 2024 14:43:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 19/29] cpu: call plugin init hook asynchronously
Date: Tue, 27 Feb 2024 14:43:25 +0000
Message-Id: <20240227144335.1196131-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This ensures we run during a cpu_exec, which allows to call start/end
exclusive from this init hook (needed for new scoreboard API introduced
later).

async work is run before any tb is translated/executed, so we can
guarantee plugin init will be called before any other hook.

The previous change made sure that any idle/resume cb call will not be
done before initializing plugin for a given vcpu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240213094009.150349-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/cpu-common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index fe16d0d9df8..68786360ea5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -194,6 +194,11 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
+static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
+{
+    qemu_plugin_vcpu_init_hook(cpu);
+}
+
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
@@ -217,9 +222,9 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
-    /* Plugin initialization must wait until the cpu is fully realized. */
+    /* Plugin initialization must wait until the cpu start executing code */
     if (tcg_enabled()) {
-        qemu_plugin_vcpu_init_hook(cpu);
+        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
     }
 
     /* NOTE: latest generic point where the cpu is fully realized */
-- 
2.39.2


