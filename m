Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAA5C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTdd-0002Me-9U; Tue, 05 Mar 2024 07:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTci-0001Yn-Qi
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:22 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcZ-0001C8-2S
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:20 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d24a727f78so68310941fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640608; x=1710245408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AT7cxGTPpcWYG5sWFRMol9k8JFzimRlPNRIRTYHRNg=;
 b=PSXDaX0HveSCBlvqTy56KKU4A+Ckn5NB8GfSmvbBC3+r/M31oRox+YCZRozqzORLb2
 ix037KNkIUeJfhvWiPoeuVqmLnxttjxtjhsxuihPFk6cAFIN+Cc02D8qV6g43gNTAAyg
 u34Vd9LoLOPzzjci2LXlqu4U59U4FmPgvzRH/wXIS9hgXgMPD5iK8lKF5KBPHpzBirDe
 yU9iSSgCmuUA1ncu6hEBVdauHt5I2+Z0IwWP+p/6vZDqC7DhW/zuzSCh5Mjbvn1HR+sb
 osX2TFWfPS39K6Z33yot2zLg0jm2O4FuAJDhAigAi2+ev4JWDoIXTWl/v9IZ92kF5PrJ
 zYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640608; x=1710245408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AT7cxGTPpcWYG5sWFRMol9k8JFzimRlPNRIRTYHRNg=;
 b=CRYELGmZB0Zn3ap+O9t9bNd6EuAvayLhoXkIoD2EzBkkwLd0jlFjyTT1Su/MmF2ABs
 Yqxu+p90wFU11zekswxGYReW6QdQUdv3DDGwXZYTZnAgVaquHg0U3TRijCHlO6uo55z3
 E7VIzBnlZ/OVKBbX4OXANetF6G/yF1JZpVqVFarnrMknrOL1Yggq981h4IoAwHDxFy6/
 6iYyLKjEGNaNKVYWCUxlgkcW+dr6Ves3n8O0C/5+/1RSw1S6PW97bE1m9TrBaHCtoasx
 LljsGNC7CuEXwptoKZ8U+G9UaBcQQZWzUDP+rb0LQ7K0AN6cP7xvWVZ2xczD2FadyGGC
 QSPg==
X-Gm-Message-State: AOJu0YxLybRb9DYqg8obgJx8fFIBNAxiPlmtUPRC2+oOxm3sJWUbVcOZ
 /mE9a2LCcw/SnChOVVKJOzaKR2fpQSE+8N4z20FCWUsCy1YXoH70zdZq+YfAEFxiQGUp2hy1WWW
 M
X-Google-Smtp-Source: AGHT+IF7OjgwwH0OGzJT5fr931L4iISERtzu8u1PLjCYvKPLQj6s0B2xjag31JWn8x1LwJ0EhfAgkg==
X-Received: by 2002:a05:651c:150:b0:2d3:56df:ea4b with SMTP id
 c16-20020a05651c015000b002d356dfea4bmr1388334ljd.41.1709640608205; 
 Tue, 05 Mar 2024 04:10:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n37-20020a05600c3ba500b00412e58be350sm5058056wms.1.2024.03.05.04.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92CA65F94F;
 Tue,  5 Mar 2024 12:10:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 02/29] gdbstub: Support disablement in a multi-threaded process
Date: Tue,  5 Mar 2024 12:09:38 +0000
Message-Id: <20240305121005.3528075-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming follow-fork-mode child support will require disabling
gdbstub in the parent process, which may have multiple threads (which
are represented as CPUs).

Loop over all CPUs in order to remove breakpoints and disable
single-step. Move the respective code into a separate function.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-2-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/user.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 14918d1a217..3ce20b7bbfc 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -356,16 +356,27 @@ int gdbserver_start(const char *port_or_path)
     return -1;
 }
 
+static void disable_gdbstub(CPUState *thread_cpu)
+{
+    CPUState *cpu;
+
+    close(gdbserver_user_state.fd);
+    gdbserver_user_state.fd = -1;
+    CPU_FOREACH(cpu) {
+        cpu_breakpoint_remove_all(cpu, BP_GDB);
+        /* no cpu_watchpoint_remove_all for user-mode */
+        cpu_single_step(cpu, 0);
+    }
+    tb_flush(thread_cpu);
+}
+
 /* Disable gdb stub for child processes.  */
 void gdbserver_fork(CPUState *cpu)
 {
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
-    close(gdbserver_user_state.fd);
-    gdbserver_user_state.fd = -1;
-    cpu_breakpoint_remove_all(cpu, BP_GDB);
-    /* no cpu_watchpoint_remove_all for user-mode */
+    disable_gdbstub(cpu);
 }
 
 /*
-- 
2.39.2


