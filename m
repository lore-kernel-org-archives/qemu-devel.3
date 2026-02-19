Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD584E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9as-0002FY-P0; Thu, 19 Feb 2026 14:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ak-0001cy-DK
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:41 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ah-00082n-8p
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:38 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so1253160f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528892; x=1772133692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AxnL6Dcwh80X5aK+BwWZTsOYv+DYNqwj0bbRKWucBU=;
 b=fAEl9fZoD2Mgy6Wp70NG72YQN2OmH09Cs+5UV4+OCUCkqAmpQXItLDTlO9mWyZ1q5Y
 w9aS/MR+uGFlrjbkHoNkS6ckY7yFNmzcxZvJcu2nswXkVquv3z4vnikzqi5PJaV7EGPw
 mrA4FljO7C985X5Kb+VIRexiS9xmksCKPyeHVddurEl/rE3GMz5Kjrt+GqlqWaqkDr+H
 /Ir+ipd4ofv4TrEL/y2pUNHBbu5wkW2Qbwvhqv1tuULaTInLmDmP2XpBrIsbu0fQaeOJ
 g+GDIHvkzOe9dM1VBjd3it0lghIKm+h9KOu5Zm/APsw88hsw3OsgV0g6gwG8tgXyekWa
 JCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528892; x=1772133692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/AxnL6Dcwh80X5aK+BwWZTsOYv+DYNqwj0bbRKWucBU=;
 b=s/2nn3ucM5/y4KJFzHEMR2ZTlkcH0futgZD0K2mRNuZ87CGBkhfHy1y8/3ixlJlFeB
 wC10j6d6JgHvSiOJe/FH1zUspDThnXk3mWy0IPtpguoaKeQ9OT2aoEW3d3x8eaoomBBt
 LvqG8/xcl3r00G5dRhWm8Byfb66ybkLaaTJ324Z7qMZc8MaflcWE1CHyQR7wcosZAJer
 FcunaOcFZ0fQqejN40n9HH9n2h2drgR38AzZjK5cK/04pe2dkfVzHiYtzYzWLEzA4UYc
 yE0tp4o2lOsuLT3n4Xi4u+tmwt5IwBoGYDxtKc4AkYWeA56hdBxBF4wgQMefBrdTK7Gj
 7ESA==
X-Gm-Message-State: AOJu0YyvMr0rbJ7WIyT0f9PV9n4DEw50yzLImNGhkvRGxGp2zngMxHs9
 bNSzdndGCbUMpljSMwVGFU22CPYaxZ+qNuY+GOcwWqtwdnTQVrzXHidlWrEXJP75MtMbiRZ/9bw
 EoPZGXzS6dQ==
X-Gm-Gg: AZuq6aJYfd3Znm4+JVc6IXhEQjPSMHGX5Jx3GTeuury2AHduXbaT+RmnF5/iFkNF6zK
 Jr2M6PP26CT6SpQQvzZAJrchz2G3ADEuEtrwbr68TMzntJZCNu1HEybGwv9FlW3tRigKWXuaLDr
 tWuXabM1QwsHoza+e9/o1MVcMtLL+V4azdoPK8zi8VXJilbiAUgU6NS0ifF96+tAXAp4922Gxyp
 r+TS1G18YUZ1KEQX2waBVvwOWzkGIQZOnxxPWS13nB9cZN6PNHmOS1UiXR0uWWFDNg3+/7ijUFN
 DERAsABUqJiAQDcLnt3tzkwxLKQez9X46tLEM+/hkbT2Pqv19zoYbFz1vTYKVSBsD2M9I6UG83E
 hQ2Ay2mPmxj3eA38VEp+n//ythTuZ4snRmFLNb6BcRTsiE/X562m8x+UsI6kk5SzDURRxn8s8QP
 Tx615Cl8AoYbsGQVMlMT+50nBF/GZX2L1x/ZcGUuyv2X8cy+cT8v0no+ckF8DBU7bkwDEbqJYi
X-Received: by 2002:a5d:5d83:0:b0:436:1e6:e1d6 with SMTP id
 ffacd0b85a97d-4379dba2cccmr37722432f8f.46.1771528892051; 
 Thu, 19 Feb 2026 11:21:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acf5b9sm50383680f8f.34.2026.02.19.11.21.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:21:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 13/50] target/sparc: Restore 'gdb-xml/sparc64-cpu.xml'
Date: Thu, 19 Feb 2026 20:19:15 +0100
Message-ID: <20260219191955.83815-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Restore gdb-xml/sparc64-cpu.xml from mainstream binutils, tag
'binutils-2_46', found in the gdb/features/sparc/folder [*].

[*] https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/sparc;hb=refs/tags/binutils-2_46

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc64-linux-user.mak        | 2 +-
 configs/targets/sparc64-softmmu.mak           | 2 +-
 target/sparc/cpu.c                            | 2 +-
 gdb-xml/{sparc64-core.xml => sparc64-cpu.xml} | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename gdb-xml/{sparc64-core.xml => sparc64-cpu.xml} (95%)

diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index a5f8f8d51a2..81d18fcc85b 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -4,6 +4,6 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-core.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
+TARGET_XML_FILES=gdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index c35b6b1bb8a..602783ef0f6 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-core.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
+TARGET_XML_FILES=gdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index f688f07445c..d82f858efb1 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1093,7 +1093,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->disas_set_info = cpu_sparc_disas_set_info;
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-    cc->gdb_core_xml_file = "sparc64-core.xml";
+    cc->gdb_core_xml_file = "sparc64-cpu.xml";
 #else
     cc->gdb_num_core_regs = 72;
 #endif
diff --git a/gdb-xml/sparc64-core.xml b/gdb-xml/sparc64-cpu.xml
similarity index 95%
rename from gdb-xml/sparc64-core.xml
rename to gdb-xml/sparc64-cpu.xml
index 85b0820a408..a9bfc95ea65 100644
--- a/gdb-xml/sparc64-core.xml
+++ b/gdb-xml/sparc64-cpu.xml
@@ -1,12 +1,12 @@
 <?xml version="1.0"?>
-<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
+<!-- Copyright (C) 2013-2026 Free Software Foundation, Inc.
 
      Copying and distribution of this file, with or without modification,
      are permitted in any medium without royalty provided the copyright
      notice and this notice are preserved.  -->
 
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.sparc.core">
+<feature name="org.gnu.gdb.sparc.cpu">
   <reg name="g0" bitsize="64" type="uint64" regnum="0"/>
   <reg name="g1" bitsize="64" type="uint64" regnum="1"/>
   <reg name="g2" bitsize="64" type="uint64" regnum="2"/>
-- 
2.52.0


