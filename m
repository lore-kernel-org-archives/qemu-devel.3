Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F73C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW2j-0007DW-Jv; Mon, 10 Feb 2025 10:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2f-0007CQ-6f
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2d-0004gY-DH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:48 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so8810535e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202585; x=1739807385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IGNfUIMYIOgUqQfFd3Qg3rwrH8g27uWdTaX61sS+BTY=;
 b=QtJNYVppSuhvE5NwxTHWXrmguUi0voFKwcaymZpBKbiGxSXUvgIUuIRt3pIjdb7IBD
 j3mkTNWxlhvFkx0R9bLFQZqNtlR3cv3JbHRVvsB+z2b7b5QoauHGYYDKJmYCmt/aeb27
 xXKZcMR7THtdjN51A7zk0Kz5t1tijC9UA3A5+qtQrLIxHNoizbRiunD2H9e9IvuDojrP
 4FnefA/hisojeQohlb2GgwkhqB/W9/G/ZpRNKQ0EAwzdJOjlVltGWsKGZr16YA+4eZr7
 QIfQ89MF4g2A5kf1mZTzmWaHYrlbhryrs0SsFzirnDheoFGgpZdum5voFbFPEDwKzigF
 /agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202585; x=1739807385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGNfUIMYIOgUqQfFd3Qg3rwrH8g27uWdTaX61sS+BTY=;
 b=VZblSZ7uhucprS5BR7ebVKgxlof9KfzSnxjs/l2/4CT0OYcm8IH6I9dp2kwZ2qxgBp
 vJ2sVZef//WvhFQ2oxQnd3tnr9tZagAp7AyCCVjHTYzJXUqYToasbSSt72SB5ERiWLJP
 qDSF/DRDZB6FdXPoIUpu9kBqM4LdbKinY0/lQ3q7tRuX8ug5gcnJTrnANa5U9mENUmZn
 kIsX18SZpK2mV5qxlvj6nHiEwfuNrxDX8B7+PLMQEX5kO7l9kE2E/OTbfsyRnytbDQS8
 0Gx4aqmRwIZ5Rml0AqhzANCs1cg58F9rX9j/s680bFJx4E+ieXygwCVR5sRlqCaBSxTC
 +zgg==
X-Gm-Message-State: AOJu0Yw2PW4S7JD0dd14WrvnTgY3oiIGFEL9hAh0qSzhGqf63z1SG1+y
 mHhMSb/IqMHR8ZT8OqTaiH9Kq1ctSEcoyaSHfVWVQyBFIvg5h0lsxImCegvm2sYBwXWJh8WQlpQ
 m
X-Gm-Gg: ASbGnct0hiXTGHOdYa9bEEMb2mpDB4v+oNdYkKK/GvyKxCUpqshQRz3Q0cPpwKxaFF5
 EJvB/SQvuNvo5mmznMPsy+Sbu1iO2+EDkNpszDuBUJftD1WE4Y2NsqAPZuwI1HhlqfImRnn6PLy
 jg1G/H+ZkalWwtwyPSOk3RZdriCSlkJocO/p+4Z56kQYbYiZlgOqOPx3EgN+/ntgRXKODyPVI//
 4Ak4/Y8/hiTvsuhD1T2+4yYpj8lZRlFL4t4JBSyYY0RKcYVw7co5sg6grqVlc6Lexefh6yT+0WK
 QnlqkqT3m6sI7c9H+ANt
X-Google-Smtp-Source: AGHT+IHUsn6GMekTJIOXaDDhjEL5JuxNgS7vpTar5NcRRnmrg4gb0Cs9OvI/HSK6WqLGZgbyzgxBpA==
X-Received: by 2002:a05:600c:1e1f:b0:439:4293:c581 with SMTP id
 5b1f17b1804b1-4394293c8bemr43427105e9.19.1739202585606; 
 Mon, 10 Feb 2025 07:49:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] target/arm: deprecate the pxa2xx CPUs and iwMMXt
 emulation
Date: Mon, 10 Feb 2025 15:49:31 +0000
Message-Id: <20250210154942.3634878-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The pxa2xx CPUs are now only useful with user-mode emulation, because
we dropped all the machine types that used them in 9.2.  (Technically
you could alse use "-cpu pxa270" with a board model like versatilepb
which doesn't sanity-check the CPU type, but that has never been a
supported config.)

To use them (or iwMMXt emulation) with QEMU user-mode you would need
to explicitly select them with the -cpu option or the QEMU_CPU
environment variable.  A google search finds no examples of anybody
doing this in the last decade; I don't believe the GCC folks are
using QEMU to test their iwMMXt codegen either.  In fact, GCC is in
the process of dropping support for iwMMXT entirely.

The iwMMXt emulation is thousands of lines of code in QEMU, and
is now the only bit of Arm insn decode which doesn't use decodetree.
We have no way to test or validate changes to it. This code is
just dead weight that is almost certainly not being used by anybody.
Mark it as deprecated.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250127112715.2936555-2-peter.maydell@linaro.org
---
 docs/about/deprecated.rst | 21 +++++++++++++++++++++
 target/arm/cpu.h          |  1 +
 target/arm/cpu.c          |  3 +++
 target/arm/tcg/cpu32.c    | 36 ++++++++++++++++++++++++------------
 4 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962a..29de49351d1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -204,6 +204,27 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
+linux-user mode CPUs
+--------------------
+
+iwMMXt emulation and the ``pxa`` CPUs (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``pxa`` CPU family (``pxa250``, ``pxa255``, ``pxa260``,
+``pxa261``, ``pxa262``, ``pxa270-a0``, ``pxa270-a1``, ``pxa270``,
+``pxa270-b0``, ``pxa270-b1``, ``pxa270-c0``, ``pxa270-c5``) are no
+longer used in system emulation, because all the machine types which
+used these CPUs were removed in the QEMU 9.2 release. These CPUs can
+now only be used in linux-user mode, and to do that you would have to
+explicitly select one of these CPUs with the ``-cpu`` command line
+option or the ``QEMU_CPU`` environment variable.
+
+We don't believe that anybody is using the iwMMXt emulation, and we do
+not have any tests to validate it or any real hardware or similar
+known-good implementation to test against. GCC is in the process of
+dropping their support for iwMMXt codegen. These CPU types are
+therefore deprecated in QEMU, and will be removed in a future release.
+
 System emulator CPUs
 --------------------
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2213c277348..c2d2d99b462 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1118,6 +1118,7 @@ struct ArchCPU {
 
 typedef struct ARMCPUInfo {
     const char *name;
+    const char *deprecation_note;
     void (*initfn)(Object *obj);
     void (*class_init)(ObjectClass *oc, void *data);
 } ARMCPUInfo;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a83b9ee34f..32dc7c1e692 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2758,6 +2758,9 @@ static void cpu_register_class_init(ObjectClass *oc, void *data)
 
     acc->info = data;
     cc->gdb_core_xml_file = "arm-core.xml";
+    if (acc->info->deprecation_note) {
+        cc->deprecation_note = acc->info->deprecation_note;
+    }
 }
 
 void arm_cpu_register(const ARMCPUInfo *info)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2ad21825255..0f1c5bc87e8 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -1026,19 +1026,31 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "ti925t",      .initfn = ti925t_initfn },
     { .name = "sa1100",      .initfn = sa1100_initfn },
     { .name = "sa1110",      .initfn = sa1110_initfn },
-    { .name = "pxa250",      .initfn = pxa250_initfn },
-    { .name = "pxa255",      .initfn = pxa255_initfn },
-    { .name = "pxa260",      .initfn = pxa260_initfn },
-    { .name = "pxa261",      .initfn = pxa261_initfn },
-    { .name = "pxa262",      .initfn = pxa262_initfn },
+    { .name = "pxa250",      .initfn = pxa250_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa255",      .initfn = pxa255_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa260",      .initfn = pxa260_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa261",      .initfn = pxa261_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa262",      .initfn = pxa262_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
     /* "pxa270" is an alias for "pxa270-a0" */
-    { .name = "pxa270",      .initfn = pxa270a0_initfn },
-    { .name = "pxa270-a0",   .initfn = pxa270a0_initfn },
-    { .name = "pxa270-a1",   .initfn = pxa270a1_initfn },
-    { .name = "pxa270-b0",   .initfn = pxa270b0_initfn },
-    { .name = "pxa270-b1",   .initfn = pxa270b1_initfn },
-    { .name = "pxa270-c0",   .initfn = pxa270c0_initfn },
-    { .name = "pxa270-c5",   .initfn = pxa270c5_initfn },
+    { .name = "pxa270",      .initfn = pxa270a0_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-a0",   .initfn = pxa270a0_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-a1",   .initfn = pxa270a1_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-b0",   .initfn = pxa270b0_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-b1",   .initfn = pxa270b1_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-c0",   .initfn = pxa270c0_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-c5",   .initfn = pxa270c5_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
 #ifndef TARGET_AARCH64
     { .name = "max",         .initfn = arm_max_initfn },
 #endif
-- 
2.34.1


