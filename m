Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C029FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO83-0000qn-Nf; Wed, 25 Feb 2026 18:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7U-0007rz-G1
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:42 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7Q-0002ti-Kj
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:39 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso3579535e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061395; x=1772666195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=26zC78SKDPxlTtKGIo+zSeJhMUMWWNcnFID6DiCcLnc=;
 b=iMTlfQO7OEje3kYTJeQAbiL8XhCNrVgYwltM71b1bJteaY4w6lrGBDre4uD9dJ9JtD
 bbfJ9vO21ZGn0NrcG0svK7S33YS/xdtdO0VIAkNx++qCDTkZji/HcKU3N2YiiARJENkx
 pYbjVpWjurrm/7R7aODQCO+XzjprY2WGfhNyJz/tfDFAbq3RuKr6636fFjiIqKYwopHk
 UibNvNgM5BXanHep0G/1NEuoRE101hRQ+3U5wuE54trSmkY+3yv26rcwovhAtJLapn8R
 T+dbvIzJPw/w0e9GsEavO5BsS2UQFcOeAIXv/0FjjAF170HggvFpDNK2LjjA+XzcbPhC
 ZEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061395; x=1772666195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=26zC78SKDPxlTtKGIo+zSeJhMUMWWNcnFID6DiCcLnc=;
 b=o38RLLJxUkLylxLdgL3urIdP31Pob74LCIl8KVT0NZpSa+dLK0syzmAqeCi3weN573
 iM32hpgPdNqvwbzxZnd3fETAXK1aLnZjEC32gdzpJME3/S/uvOD1E876eMgbdbMvnVHD
 Jjj4JFUnstXcGifuQwqfgTkeKVBzFh3534+Xe7Yy/j6O5mHgVPb9oJVvmERtUrmhiJPP
 a4mp1OzCtWBy9NL82MqVzyALjNd/APZ7XxtACPEvO0EwUEcadDTSM3YzF23pA/phA1HF
 Iy8fkc4r8Q/kf1JPZsSIdk4e+cbPwpvidmllJ7Hdp1gfQGw2Yihp7WEgpwlNjCaMbA4X
 Bg8Q==
X-Gm-Message-State: AOJu0YwuE6NlZ12GO0B/kInhvaK0IrS5CUYrAQXPyUAz+acI3e5WvwFv
 WndaB7c3tWiKGAQo6OTsT4tOxSwM/FmmzI4hRHJzUnyuSdDi3Sq2/Ua3rYI83HPeugJV3Me+5i9
 xK+cYNpk=
X-Gm-Gg: ATEYQzwysUMx1zELkJzayUkqje7VSvXkW1ddWlrY3plWPAvKWoe1yRLmLwkiklCwCPT
 EFbMXsU4A69Q342oWvGdtA0dmQfsNmle3B24rURTfbi3HcBtshO6IqQfWZlf/hykB4SWW/cYjGE
 l+o7PtVGaQ4wf2KQ2fB4vsCu2nGCLIr0jL01kHT5KGkY1q1WmJCrK+umpnrOY4Wtnwnu9v9y1nw
 S/gx8D5m+hpT+jAMD/5qU8BeRaemdFmjZ4V+wHlHyeDZEJhYLvar7NWrbHj7vQyYM4IOaq8SJkh
 OzRD5TE1BWV+RwAx7EitrUm0iv3tsEiXrlEeyivJeKw/wi4jae/ZbIUm5bkiQjV7HZJ2v5Zgb59
 Q2FG9yravmRwA4bs0z0u2k9602A3NgWFMwP1S37OpwsEgQ3l8z4Sb3e8snkj6MBVnifQ/gya+UQ
 uaZJ9y7xR8znT+359geUgVdpfI05nziLqLgVPaZ0CCEvrpn43CoSoYosSVlbpjrqott20IB5MX
X-Received: by 2002:a05:600c:4e0f:b0:483:badb:6191 with SMTP id
 5b1f17b1804b1-483c3db0103mr1554505e9.8.1772061394590; 
 Wed, 25 Feb 2026 15:16:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b89c99sm3498125e9.15.2026.02.25.15.16.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:16:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/70] target/sparc: Restore 'gdb-xml/sparc64-cpu.xml'
Date: Thu, 26 Feb 2026 00:13:21 +0100
Message-ID: <20260225231411.96482-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-14-philmd@linaro.org>
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


