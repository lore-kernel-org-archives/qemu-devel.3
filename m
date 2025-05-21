Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1341FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmf5-0004fC-RW; Wed, 21 May 2025 12:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmf0-0004dv-AT
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:51:20 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmeu-0007KT-GN
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:51:17 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so1124835866b.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747846269; x=1748451069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhBb26SjuKAOlwKxBTTGkr+A9vckx7GIaP4zLYV5QOo=;
 b=wm4PC9DhbpSbIYXYfbv4vkZqiyQi9b2Qm+MN29qQ4DWnhYB1AJtWwJXP7VgDWueGrB
 AckAAxQxRUJ5h2t7i1A0KMFspEltPzJQmlcsY6go6PxMr4Y5LFCRHzLYCQhm/y18G/OA
 I2aOVdZc2E61uOzW6jIG+MdrY2bktAwHSlnJ//KDVqhXBAEMK39ksv0jC3OspD3hVkPB
 qfuX8zOACFGmlws1O6phbayLGIIFLG4I4n9SPuxijVzvs7/JmnwHfx7Ovvv5f7cQE1hB
 /hgv42bKhJydtqnjCd1GIqei7P8doRk+zwXJn0plXdEoBDH3kUpbDGcINz52uWX1Xubc
 GLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747846269; x=1748451069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhBb26SjuKAOlwKxBTTGkr+A9vckx7GIaP4zLYV5QOo=;
 b=TjzNQzu1nw7GquDG0Ph04iawF8HtIXxI7ZiXlxkOG31D+4N7xh9NbddMQPmGK1sVDQ
 EigLZayxp2IRAvOV/YB3JSZ4VWtzQlcjFjuxkZNDpmi9+eR591m5Igq2xzMdmWlv+Fud
 afzoI9GLdH/IT9HezvY8rq7Eb9YWkGCTPfaDB1XBfsOf6DtZKEQjAoI0+F7byRGk8yZB
 W2w5zrj+qxTiR7zvhQ82UCtvYJ4a5jCd/Uxn4mhBAVmvZV5U/s8oSbJJpaLuV8A4L0bL
 s4qItDo4r62ECOx3C34nV6EJb1HjdNWX20JTz8lqxJFWcdykcasW6/l8OsJOA6ie2ZMp
 VzpQ==
X-Gm-Message-State: AOJu0Yxqscz0bFiXPvxcv554FvGtft8DjM/w1iahdIK1daS1H0A61HaY
 6SRXSIXnknSKaurcN/2qXb7azK93OlDlYOSXwS6wCfgP4Pkc3ZeosJL1PXUaVZfWjAo=
X-Gm-Gg: ASbGncuO8QPOtntwiL2lPQ0BMOQuwEDlj/lYRxEoG49gr7aWzbpbXjRu56yhRs0YFLa
 yeeYKbcZSE9krHJCIFRueqM0xZoJz1Cgq1uCKKFN2Qtvbzc4yRHnRlN4GmfpeOqK0zMi2oz6jFt
 7fYXS+NgRBXnIVdnAgQmkQo8lRRc63TtZI9I1J0Uc4767MfyH09L61K0YRBTIVhSO7Sbe6mWX3D
 /Q6uor4aGcNULL1OUMQfOgUhZPykKqFcm4FM1evL1b+am8T8Nd/VQkrau5xLM47pgt0cq33SU0N
 RMDNXMzpqJtMkhYX4hNiCBWkFkncW28JrmzUpczMN7pYKv1nXMOJ
X-Google-Smtp-Source: AGHT+IFqMXggdwg6miQbNWxygd0DzgK/Hso5gUxeet7AkB9NsxTnzdCLrDSu05uBLPdd0GxxIppJfg==
X-Received: by 2002:a17:907:7b86:b0:ad5:b09:115f with SMTP id
 a640c23a62f3a-ad536bca50dmr2020799366b.29.1747846269406; 
 Wed, 21 May 2025 09:51:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d498b4bsm940451766b.148.2025.05.21.09.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:51:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA1615F8AD;
 Wed, 21 May 2025 17:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v3 20/20] gdbstub: update aarch64-core.xml
Date: Wed, 21 May 2025 17:42:50 +0100
Message-Id: <20250521164250.135776-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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
2.39.5


