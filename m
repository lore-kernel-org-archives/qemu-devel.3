Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377BBC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPSq-00045m-Ct; Tue, 03 Jun 2025 07:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPT-00087J-3e
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:23 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPN-0002E2-FG
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:22 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so1055706166b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948536; x=1749553336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BM91DYmyhd/whlHWSkAx+XEJzxYMIFdJJZyTAcb4rl4=;
 b=i8PrxLVBzIsWtswU+KvuZ4yy5/XNNxGxmYzeCtIj79ICAPgCVqW3/aJLBkMuvRVb5x
 7DPz1/aH8r7TzJZLo2EGnQWld3WFQmAh5/PVGCB5gaPL75L9xj5VcK6UrOuz4jNX9w9U
 ApmxWVI5wi0ugxveZP9onUkExHnVzK1arn7+yi3P74WCg/sotQ+upjv51HtfStQZT+Al
 uIx6FxSFYm6jwaFden+gakJF9QsWwQkMta+wO2IBc6p4had/2+QVOKrHklDDiPKCtoGu
 gQX/2Qwl2BXrgTj9cEsHQeJFPSm+MGD4NplRNB2rJZ0/T04TL0M8+OYgYsm2N+Go4U57
 hNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948536; x=1749553336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BM91DYmyhd/whlHWSkAx+XEJzxYMIFdJJZyTAcb4rl4=;
 b=BeDd+6QXzGsx3NBF8GKDHMmz42OgNGLIzZ9e25cSblitZvqyG1RkEHER0SCJjD1BWm
 hxwqdSgBbVK/W1pAYhzgGg4C7uSFwMFrFKtU55JXbm2PYV+JazIC5LQ3WqBAQ2ogu/Tq
 K8ww4jbnqZzCC4kfy5KZ6OhHja06ujqmZn1jg4EPRmtfrePF4iP2SbJs8wmFQsFqj4+L
 fUwGJwhyivNzvrHVWRHZ6QTAC8aPQvwgVs9Lh4MJd3Pf5gs5SGYrTsy9tafmwwhdhQMr
 WnvgoE3VzEEF4HIUPdfKGFG+5Z/SLzlPPQQqYVyiAHxTIjoXdYcS/3VUR4142P66ulcQ
 BWqQ==
X-Gm-Message-State: AOJu0YxJdndPkA0reRTUKdsKeal2f6Gnb4jAOLN3ES8Vl+LG6D90HYgz
 WXpvBQQaidYZxAjkxu4Dh1r2GW5ri4fha/5D1/bYbc7d0dX+2u8vskL+xooBIE0q3Dg=
X-Gm-Gg: ASbGncuE9SyI0i3qg+IaKFUkLMys1YviaOYN0aqITq1xeoryCIQR1oGS07IVns88inx
 59GVKxNkk0Nkiw/6IQFN53I3hpUxu1Bbadq8xth+L9owRGyXEr7N43mWO9lFOsqv92TZ7JgZRNS
 a9peagVt68DxhQqpOCj8cnUAfSmA37zRf5bOhswzX3RfxivzKwpuslI4mXRNb1gZPii35/wWzFu
 L/1DWZp/iL7Atj2jkmgwsKjoNAxDP4eSp9e3a+obdnCAg7sYUy5DVr8+BkClE0/PDbaC2E5XFzn
 MTTPXhdtLEjLHkYLM+yyccNIz//mMDT0Z5UwF2h/hDdYc/w3JoDi
X-Google-Smtp-Source: AGHT+IFAQxZ8oG2VB5Fyld7vVeDQ/c0KrPvdW6Zz3s5mpsiY+DUZYO7lhOiBc0cCaZuKRThZf7CRAA==
X-Received: by 2002:a17:907:8694:b0:ad8:5595:ce07 with SMTP id
 a640c23a62f3a-adde66ca1d5mr167272366b.19.1748948535778; 
 Tue, 03 Jun 2025 04:02:15 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5e878152sm938855866b.107.2025.06.03.04.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 795095F9FC;
 Tue, 03 Jun 2025 12:02:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 17/17] gdbstub: update aarch64-core.xml
Date: Tue,  3 Jun 2025 12:02:04 +0100
Message-ID: <20250603110204.838117-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Update aarch64-core.xml to include field definitions for PSTATE, which
in gdb is modelled in the cpsr (current program status register)
pseudo-register, named after the actual cpsr register in armv7.

Defining the fields layout of the register allows easy inspection of for
example, the current exception level (EL):

For example. Before booting a Linux guest, EL=2, but after booting and
Ctrl-C'ing in gdb, we get EL=0:

  (gdb) info registers $cpsr
  cpsr           0x20402009          [ SP EL=2 BTYPE=0 PAN C ]
  (gdb) cont
  Continuing.
  ^C
  Thread 2 received signal SIGINT, Interrupt.
  0x0000ffffaaff286c in ?? ()
  (gdb) info registers $cpsr
  cpsr           0x20001000          [ EL=0 BTYPE=0 SSBS C ]

The aarch64-core.xml has been updated to match exactly the version
retrieved from upstream gdb, retrieved in 2025-05-19 from HEAD commit
9f4dc0b137c86f6ff2098cb1ab69442c69d6023d.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/features/aarch64-core.xml;h=b8046510b9a085d30463d37b3ecc8d435f5fb7a4;hb=HEAD
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20250519-gdbstub-aarch64-pstate-xml-v1-1-b4dbe87fe7c6@linaro.org>
[AJB: expanded upstream link]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdb-xml/aarch64-core.xml | 52 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/gdb-xml/aarch64-core.xml b/gdb-xml/aarch64-core.xml
index e1e9dc3f91..b8046510b9 100644
--- a/gdb-xml/aarch64-core.xml
+++ b/gdb-xml/aarch64-core.xml
@@ -1,5 +1,5 @@
 <?xml version="1.0"?>
-<!-- Copyright (C) 2009-2012 Free Software Foundation, Inc.
+<!-- Copyright (C) 2009-2025 Free Software Foundation, Inc.
      Contributed by ARM Ltd.
 
      Copying and distribution of this file, with or without modification,
@@ -42,5 +42,53 @@
   <reg name="sp" bitsize="64" type="data_ptr"/>
 
   <reg name="pc" bitsize="64" type="code_ptr"/>
-  <reg name="cpsr" bitsize="32"/>
+
+  <flags id="cpsr_flags" size="4">
+    <!-- Stack Pointer.  -->
+    <field name="SP" start="0" end="0"/>
+
+    <!-- Exception Level.  -->
+    <field name="EL" start="2" end="3"/>
+    <!-- Execution state.  -->
+    <field name="nRW" start="4" end="4"/>
+
+    <!-- FIQ interrupt mask.  -->
+    <field name="F" start="6" end="6"/>
+    <!-- IRQ interrupt mask.  -->
+    <field name="I" start="7" end="7"/>
+    <!-- SError interrupt mask.  -->
+    <field name="A" start="8" end="8"/>
+    <!-- Debug exception mask.  -->
+    <field name="D" start="9" end="9"/>
+
+    <!-- ARMv8.5-A: Branch Target Identification BTYPE.  -->
+    <field name="BTYPE" start="10" end="11"/>
+
+    <!-- ARMv8.0-A: Speculative Store Bypass.  -->
+    <field name="SSBS" start="12" end="12"/>
+
+    <!-- Illegal Execution state.  -->
+    <field name="IL" start="20" end="20"/>
+    <!-- Software Step.  -->
+    <field name="SS" start="21" end="21"/>
+    <!-- ARMv8.1-A: Privileged Access Never.  -->
+    <field name="PAN" start="22" end="22"/>
+    <!-- ARMv8.2-A: User Access Override.  -->
+    <field name="UAO" start="23" end="23"/>
+    <!-- ARMv8.4-A: Data Independent Timing.  -->
+    <field name="DIT" start="24" end="24"/>
+    <!-- ARMv8.5-A: Tag Check Override.  -->
+    <field name="TCO" start="25" end="25"/>
+
+    <!-- Overflow Condition flag.  -->
+    <field name="V" start="28" end="28"/>
+    <!-- Carry Condition flag.  -->
+    <field name="C" start="29" end="29"/>
+    <!-- Zero Condition flag.  -->
+    <field name="Z" start="30" end="30"/>
+    <!-- Negative Condition flag.  -->
+    <field name="N" start="31" end="31"/>
+  </flags>
+  <reg name="cpsr" bitsize="32" type="cpsr_flags"/>
+
 </feature>
-- 
2.47.2


