Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D5AC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDYh-0001mA-83; Thu, 05 Jun 2025 12:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDYZ-0001iH-95
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:35:07 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDYX-00021B-9m
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:35:07 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60768f080d8so122982a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749141303; x=1749746103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVzzb/76JOFY7jHX5yCZIpFfAYYIv9oWrL8sx1vZiVw=;
 b=O33EUgDuNxSyJljJhqFroVIFQpgKLQ5P4yHGe4Ltd6M9Qg0W3cawU5qZfSS0FxkcbH
 /680NtJ2V83OEcxqfNQ1rp6fAJToCNkKF+wU5gT802Lq81ybOE6wqgaowWzvwqEBGtQc
 ymub6ubXYpaV2QDWJPQEyJX8SnXj2Ae3AJj/YrPaKvcg5O5E0wRCWpsPw162jmM/Yrcj
 R8PGuf8dgCiOBc8T73cmFSedJ3nqrsLSL7GC2hitANdG54lW+ddkHixXQc4kyZaVafrs
 F9N+KSsSuUp9RGOA+yGZ8rILW7mAzaRxTxCBrSSVBykqcnvTaKaBVcQCoIcD3j/GZ0kq
 pqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749141303; x=1749746103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVzzb/76JOFY7jHX5yCZIpFfAYYIv9oWrL8sx1vZiVw=;
 b=KQeY4idsv5nIFyxv/9PIBiyakZE6HZ9ynlvXy4IJZndZ1dagGDTTuo61AXpkGGaM71
 57wsTlwwehwmcri8JM8KaiQoh9jPH+t/pFKLPciE8kuomRFhIT+sA5+NFVHpS92o/lCG
 u49i5AqHYMS30Ilf7TGepVno5jP1HieZM5bHhP9F2d0FeaG7+KCu2AJo0rbtI94Gh7qm
 +8IcprfPjtflHAE3JftTTbK4qCUE2NX8OdBJVyo4TN57MeHXlMvc0ucl3zmmhm35PuC/
 vV1OIvM36fzE5EzaAXuk3q6tuvkQxQpx1OB+FVLc/f8NBzCKUDEVbVfbhCp2skgsSaoi
 /k/Q==
X-Gm-Message-State: AOJu0YzTJtKG34DcYq5+EuFQQ55iksyMflljLGt+6Z+OP2jov3rT7bJ0
 4aVoS155rwfVLBB4sHK7RhWqraWx78s7Ydb73FRR9MpPZ7zXKsem6ycXgYOR5z0QGDAH4L7YgmN
 PrMR+OAQ=
X-Gm-Gg: ASbGnct92R5VLFmd8eVtw7memvAf7Lz9+68an8a1xJWgONnQIMluriYsNXUkEm+ny5D
 s5L5ZesbFsatIeaiDNTubWaHn0xkOW1vdagmkl5UN2A6MZUdzPltVM1ZUe8KQ0VMk2PVof+eDTV
 6GCDq4l9T9JlOioKx3576b8VtgMU3/18lJLpJ288nTEm4ZEFNOaSSXbbh6VsWybbtktXrLO/r/R
 jYyT5qod2LWpslHZhQ+hAv6NdHq04KVkqz2BGc54wJwogKQHr5aTsUudEb6oPqQtiTAKYXwwF+6
 ZqavBw8tn/O/G0FOCKinopouLbalSz1LppV37EAK5n66+OJsjiQJ
X-Google-Smtp-Source: AGHT+IHIqhLdsBeU6p42YdSWaeQrc/RKmjkBpwQIRbz+o+GY7YKi9Zo2Sf4MAqv7/SvGK14AFpDj/g==
X-Received: by 2002:a05:6402:5248:b0:5fa:fcda:bf57 with SMTP id
 4fb4d7f45d1cf-606ea3b6b89mr7300232a12.17.1749141302761; 
 Thu, 05 Jun 2025 09:35:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60730b1ec8fsm859243a12.43.2025.06.05.09.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:35:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EF49E5F834;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/17] gdbstub: update aarch64-core.xml
Date: Thu,  5 Jun 2025 17:26:50 +0100
Message-ID: <20250605162651.2614401-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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
Message-ID: <20250603110204.838117-18-alex.bennee@linaro.org>

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


