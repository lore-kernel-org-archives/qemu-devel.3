Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039ECD1CA15
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ATX-0002bg-VW; Mon, 04 Nov 2024 22:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1t8ATW-0002bI-Mk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:43:26 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1t8ATV-00010A-8r
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:43:26 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a6bf539cabso9139155ab.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 19:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730778204; x=1731383004;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85Mpl5vChgiCfZpQSnWPYrEeOfjpu0W0D/cphYsgEtE=;
 b=RC1LNlnEy65ZwJF5ks7bVFH0TMutXhfH5dJ28pv19CcL4a1izHPO5gpH2ybSQBdj8v
 RYCNDwbeENZSLuRyBIuCqzrb+ulSQabYh5+IHS7gG+mpjHsvnuwZIRaKasZbS/krKhGj
 BrcKOLicyDg29v68oE5h/2jDEfhUzxSi4zARs64UE71OotMbcV88kkMychJsFkUO2p8L
 cqhXAog4oEUD4Z4chjIR0UMFkYnrTqZFe5KZSP9o7i08NQ3sIXzTY73u0+POJFFdOmas
 w6g5V7011/kJqY90gU+KXhJYac3TFzedqvQNWPHEyxx0rBl4O3mWIGgB3wB5IyIaewtj
 LDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730778204; x=1731383004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85Mpl5vChgiCfZpQSnWPYrEeOfjpu0W0D/cphYsgEtE=;
 b=K1gDwOGsDq+BoWOyhX+I876fC3jQr2OXN75QVol98SdfO57jj+6DxofZzNkCR0c+Qt
 sZwsKCRo3UjDnYVBzBtKspaSo034nm8ZjdSTNXbZUx71dDBM0+un52kE0V0tDzLP+E5q
 y2Cx9aaZnxgP/jFZQT1dftgu/q5gXF8OnTsv/1WRVX5Ac5jln7RHBrwO13Ct5kvNya6t
 Eiia8NBKo+sITD1PzjcNjiwqIlTjCiKPiF6tt7hv84o5z8R9CJ1GNiIaxKP0zpCDQRxe
 gOrcC8QssHaBHbvJ8MRx22K2zovHp/AVa3bFJfUCK+0eaHev6ufFQ7Yaq+PNtAo6wJQA
 kugA==
X-Gm-Message-State: AOJu0YyQ1eUYFYbdH9//OTpLmLkgJ/b60cK3YBOwCoNiwYCF49u/WzgO
 pZv8q4ZHVwaE3V1O/vDatg62Ye/UnD6v+gutzTQL+xrFtqLXF1sj4f6benYv61H3Vxv/9/9voKB
 wFzLuqA==
X-Google-Smtp-Source: AGHT+IGLEv1S6KBPJDUvQ2bEhJlknm2hKBR91N/2En/MYuUg6fGK5Ci30K+P8j/S009XEXj+N5URzQ==
X-Received: by 2002:a05:6e02:1c07:b0:3a6:cac0:1299 with SMTP id
 e9e14a558f8ab-3a6cac01324mr63912075ab.14.1730778203892; 
 Mon, 04 Nov 2024 19:43:23 -0800 (PST)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6bddcdcd8sm17162665ab.37.2024.11.04.19.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 19:43:22 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/3] bsd-user/main: Allow setting tb-size
Date: Mon,  4 Nov 2024 20:40:38 -0700
Message-ID: <20241105034039.31143-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105034039.31143-1-imp@bsdimp.com>
References: <20241105034039.31143-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::130;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

While qemu-system can set tb-size using -accel tcg,tb-size=n, there
is no similar knob for qemu-bsd-user. Add one in a way similar to how
one-insn-per-tb is already handled.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index cc980e6f401..7c230b0c7a5 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -60,6 +60,7 @@ uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
 static bool opt_one_insn_per_tb;
+static unsigned long opt_tb_size;
 uintptr_t guest_base;
 bool have_guest_base;
 /*
@@ -169,6 +170,7 @@ static void usage(void)
            "                  (use '-d help' for a list of log items)\n"
            "-D logfile        write logs to 'logfile' (default stderr)\n"
            "-one-insn-per-tb  run with one guest instruction per emulated TB\n"
+           "-tb-size size     TCG translation block cache size\n"
            "-strace           log system calls\n"
            "-trace            [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
            "                  specify tracing options\n"
@@ -387,6 +389,11 @@ int main(int argc, char **argv)
             seed_optarg = optarg;
         } else if (!strcmp(r, "one-insn-per-tb")) {
             opt_one_insn_per_tb = true;
+        } else if (!strcmp(r, "tb-size")) {
+            r = argv[optind++];
+            if (qemu_strtoul(r, NULL, 0, &opt_tb_size)) {
+                usage();
+            }
         } else if (!strcmp(r, "strace")) {
             do_strace = 1;
         } else if (!strcmp(r, "trace")) {
@@ -452,6 +459,8 @@ int main(int argc, char **argv)
         accel_init_interfaces(ac);
         object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
                                  opt_one_insn_per_tb, &error_abort);
+        object_property_set_int(OBJECT(accel), "tb-size",
+                                opt_tb_size, &error_abort);
         ac->init_machine(NULL);
     }
 
-- 
2.46.1


