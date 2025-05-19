Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76882C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 11:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGyFo-0008Ao-PH; Mon, 19 May 2025 07:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uGyFn-00087h-0n
 for qemu-devel@nongnu.org; Mon, 19 May 2025 07:01:55 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uGyFk-0002wf-Lh
 for qemu-devel@nongnu.org; Mon, 19 May 2025 07:01:54 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso789928066b.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747652510; x=1748257310; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tpN28OkOCVXRNSzbom7i6GbzinL88qb7I4fIWa3P234=;
 b=IXzAEdeak5Oh73k6sfLSgEW0+5QwVQYdLIKzWs7pr/9AWUpEcbHGX4O+o4gMUuH8i3
 XzJRbJdYYMnO1WHWMmthqw/LLGO84z7RUBJTVLnlm5BdN6pEN0OfooTQ2/B4fEcTZYEm
 Gj3HtIAoiqTm09n9Uhj0Q1v3hXHmngXEmCeOyIngCiWZr3lyyP53+w/RXHi2lpMxrD7b
 lbRc6HWZ0D88/ZlZv9pjd8/IBCEc3ZNJvcHppcin177+y8Ou4MnAZMhp0caeJTqbiNiT
 gv/lI/7s7kTR3Moxc72H0N+c81WrSIWsLhPG4hq7UTZuWr7Pc3WfFUpS+Fi9GkT1Alb5
 yw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747652510; x=1748257310;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tpN28OkOCVXRNSzbom7i6GbzinL88qb7I4fIWa3P234=;
 b=MluaPxvFyidCCPWlg3I8N+xCifHwSD/EQl+tupiC/DPyz5ioqLVwiiC7wFte+5+Umn
 WQth5/TiTtXoWJ9gwXtNOpW1FtT7dKgimDYJxxejT43TJ1KHGbsvXpNlIGeKR9IAbjYH
 nqu3Io0d81Gu6lSJGr+NgRLuP8HvxH9EdpLm8QCUGMdUr597cKT4rc8GpAoA2OuyCbaB
 d/8UbBcdSi7AeJ3zkKc39O9bN11qCCisE8ne7h3Tu6QFDP05BU0vWfXAuRXNABsgY3qF
 TllQPCi7SiwnyWUfQ6E71v2xTUoUL62dYE7k6WkjoBfVYoXYsXfY4IriIEASUo3cs2En
 NQrA==
X-Gm-Message-State: AOJu0YwVRFhkg5zcPPDZ5lHzZml+MqBqzt7X3k2x1TPM/pO1eWDYWgVC
 cTdwwhE8lmv9l5TtOss+WVIPqSsiCzcD/x6g+axxETgIR/r7NVOB0J0PUVsKjhaNfL0=
X-Gm-Gg: ASbGncvEAwWBPNAD3KIwZj5o107hyYjLEUvelJpl5IibfKdCZuhDiTNPAX1bSJBOixP
 uklu+C+VxfjjpKn5nGssGjGnPYT1J1752zL17HHrxstAUrzkHmcDARpCTukMDWMjMSUc8cXlyeH
 JVG+NmJR8UO0bh0QT7x1foao3ENgMwVwLmwOVxpzx50qyz1Dbcx3Q1wY3424Nza0bwbcDz7dAbj
 7smqedxRmMK1MRIuF0CzSThqBkqcZ0HjZZoegL6jqNzt5S0UjUcNZTccq+jVIlHZ2E93IzUyUre
 qQhiVRjMgzBPafrhh70++AcIu0mpA6WU1NtAO+vsw42RFpxasAqx0ycGgd8FisTr+fnSqlsYjSn
 UFKGcl5g=
X-Google-Smtp-Source: AGHT+IFULFO6CDVChnrfrnxkPb8SDEP1onCkXOa+72kE++FqOTlHnX37947bwuQOAiDHtRJSpDE8kA==
X-Received: by 2002:a17:906:fe0c:b0:ad2:4bae:3272 with SMTP id
 a640c23a62f3a-ad52d5df5f1mr932117066b.55.1747652510324; 
 Mon, 19 May 2025 04:01:50 -0700 (PDT)
Received: from [127.0.1.1] (adsl-97.37.6.3.tellas.gr. [37.6.3.97])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ca5basm566939766b.161.2025.05.19.04.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 04:01:49 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 19 May 2025 14:01:47 +0300
Subject: [PATCH] gdbstub: update aarch64-core.xml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250519-gdbstub-aarch64-pstate-xml-v1-1-b4dbe87fe7c6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJoPK2gC/x3MwQqDMAwA0F+RnA20nW50vyIe0jbTwOak6UZB/
 PeVHd/lHaCchRXu3QGZv6Ly3hps30FcaVsYJTWDM240o/W4pKDlE5Aox/U64K6FCmN9PTF5Eyh
 eBn+zDlqwZ35I/efTfJ4/Jy5gC2wAAAA=
X-Change-ID: 20250519-gdbstub-aarch64-pstate-xml-d90bac349712
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3825;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=1gxGdstIxFgyF959OG5RgW0glWjqcin0b37WKJAAD4k=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9LdytkdllkUzZhb1hnSk42ZmN4VXEybHRsQXRICjMyZWE3U2ZBeUtMdVZZc2pB
 TUtKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUNzUG5RQUt
 DUkIzS2Nkd2YzNEowRlJHRC9zRjZydkhIRHU3YUl2SXU2anVKWmlTekUzNXllTndmUFpjU3FkZQ
 pZR1VvV0lSaFNXbXBNYzJ0STJmMS9PbC9aUjBtb0JtMW5qYmFzZUtCRXM1eWkvODFHTkRVYVhsc
 jA1SUZLM004ClE4cExhL3FTaW0yVDZ5ejkyODFMMElGYy9jMWNqdFp2bmZCUWl6QXNuL1hCM3px
 ODh2cE1rZ1NBeVFoZ2tvRVMKUUNWc0IxWFhzTjE4WlFFbEFSdjd6ek1WZG1NaDhEdktvSHd0dm9
 EVTZWTGRCbWZBcFJ6RTN5SGl4N1JRMVo0Ugp5YkVnWlo1ek9wMmZMVDBLTmpOZXFRN3hiZGp1T0
 c0UzltaUtUNC9JTlBteEFqUGNNdnRZR0JVanAvWnQzR3ZqCkNkdTUxTjNPb1Bvcm1hMWhrL3JvR
 1dTaVl4bm43NzErMEVJWlZYWWZiTlVpTDFiN3owNnBFa2pHTkdUOHZUK04KdmhWVUl0azZwR3Ev
 WThCY1hQZ093aHYrSXExWmNQK2NKRVZVUnBLZk9kU3RBOXFNVmU5R2NISXl3bVo3YnBTTwo3ekF
 WTFhaTmVpL2V1SGpwM05PWnlmTUo2aFNpZWgyZFBPandNY3F1L1NER3BiOVpQdjFQTUZ6ZnhUTk
 15NXVUCmkwR1M5OXNuZ1FhNThpTDM4L04rWEc2QU1sTHkvZ1l6WXlreUpvbDRpbXFVUURMVHFIV
 jl3MGZVMEV2dWwzdkQKUERGK0Q4QVdjWThaODNiSy9HUFdMMm9aOG9kOHhUZnVNaCtZajBUTkxL
 RDVuV01xVmtmVmxCdDFwcHpZcU8rQgpmLzlzNVgxaDhLNGNiZDFvNUlrbG1kU1Z0d1ZudXAvOGx
 nYzRhb0R5OER1dEd5K2FHS0hjTml6VHhnUm1Ock90Ck5jNDRpZz09Cj1ERmRiCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

https://sourceware.org/git/?p=binutils-gdb.git;a=tree;h=9f4dc0b137c86f6ff2098cb1ab69442c69d6023d

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 gdb-xml/aarch64-core.xml | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/gdb-xml/aarch64-core.xml b/gdb-xml/aarch64-core.xml
index e1e9dc3f91370111eae36380449cddabc31265a4..b8046510b9a085d30463d37b3ecc8d435f5fb7a4 100644
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

---
base-commit: 757a34115e7491744a63dfc3d291fd1de5297ee2
change-id: 20250519-gdbstub-aarch64-pstate-xml-d90bac349712

--
γαῖα πυρί μιχθήτω


