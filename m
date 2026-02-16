Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E31E83840
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7Sk-0001sn-DB; Mon, 16 Feb 2026 17:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7Sj-0001sd-4Q
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:05 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7Sh-0006Tr-EP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4834826e555so36948075e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282382; x=1771887182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIGCvk/A3zg3qv54SzmMuZKtcmoN9IeYb84vKb2TUio=;
 b=vFhr3VhdcZHxL9PBjbvie+vcLsHz6aXhqp7W7AYIrtDm4mX/89/oFUQf7pDYJWU3jM
 wt26wlU2mWtJdS6gx4B2QzoLmmFf3oPVNDyq0ShMF0+xpfHD3Lnny2yin78fEpDO0+/A
 GGbADuyBrOv0oopYefArnaiP261g8+AZLTwmKdMWqtgJRpgJqknRWFLJG4n/w4k3saRp
 ycExFYBue5TNAjzybub3uN55D08pSwPv9WICtzPefep0sn4OwEhEjVC+eH2a/inIivrW
 BVBZUhb9DBDIlAqoL9DNkQadkAhwLYk/8EMTEcRBuh8gYkDbqr7ypWqP/jktK53sjXew
 6oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282382; x=1771887182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GIGCvk/A3zg3qv54SzmMuZKtcmoN9IeYb84vKb2TUio=;
 b=W09iKCh3z9VjuascRa2JuKHxB7ujooOb8Fnq0mFVir5rX1b62hYzw9Axaff6YUzeoq
 jBhZOqe6eMGKLczNvBe6rgJA7ihlcaskZ7kIr1jdP2mt/UKS6T6mPZnBypzmI6bL1lv3
 5gc3tohuom4XwKlwvRr6uFX+/M9WPS2IxUYZXLC8mqu/dkybI9+87PsgE5Ha72YMmAir
 O4SV+lDZFgRi0cqMIt6ujAGv4hWucQZUCAbF0+m+FAbM6ZcfOdvwDQppSffgcVZoyyWa
 azizYpCnbwGWASjuq15cd+8x2nKoq+GzhSFSvnLAWVBF/z60qy+iwXq3VSv7kbJzcpF1
 W3hw==
X-Gm-Message-State: AOJu0YxVL4tmcPYFuKccB88XKfqrulC5acw+YKfeUk3hvudXcYgm/RRF
 r47sEZJLgeKLRAb06cWbr9WR/MjeF3Ix+nxEnagr5kgF2XVk5wQWENDFGnlhqTp3B21bpNFHYMe
 gc5ktOU4=
X-Gm-Gg: AZuq6aL+roXZerCV6BDox/2lbIHqCjsi3Hox0yeCc7PAIvannYjcN9/7EPxHlWeq4Kc
 JUqep2K+wBOATcczKPegmFmf18l9B89D0uvJ50X9teuj9os/pCwnQ1pLFXXP9M+yD/8yB2ykbhY
 hfpwxp1iJ9O81z0fCEc6yUPy5srJIKEsAheB4+aT4amMvCOSI0ReH2ksoQqyI6UIVgC8lo3Lp7w
 rYZHfrIxD0ElmH0mkw9Re0K8obilnYoI7DG/I+X04QANOjGSZha4noZFphn3Fb8RH3vmd0llgsU
 LI2RYrx9l9KVkM+6cN1MicGeo2qhZCScbWPC5jba/mnz9rUa4zC8k7WYm3tqnehhrxz7Y5N227M
 I9xxN4970VMFatUNPsDbMNKJ8PC9FGy75/uonu+d2R4jyqoPaPAsZ+dBr59HGFNGRrpXWtmEtEj
 eLlzxq+BaboTzhL9pvlOv5+qPKH8dW9LcwYWng/yRV/Awpnp50H+IieS61De7DSNRJEf1ZqbIK
X-Received: by 2002:a05:600c:6814:b0:483:43da:6c87 with SMTP id
 5b1f17b1804b1-48379c14894mr162485845e9.33.1771282381629; 
 Mon, 16 Feb 2026 14:53:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm517632845e9.7.2026.02.16.14.53.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:53:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 04/11] target/sparc: Restore 'gdb-xml/sparc64-cpu.xml'
Date: Mon, 16 Feb 2026 23:52:20 +0100
Message-ID: <20260216225228.53959-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
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
index 2db34d88b97..08ebbd3640b 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1093,7 +1093,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->disas_set_info = cpu_sparc_disas_set_info;
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-    cc->gdb_core_xml_file = "sparc64-core.xml";
+    cc->gdb_core_xml_file = "sparc64-cpu.xml";
     cc->gdb_num_core_regs = 32;
 #else
     cc->gdb_num_core_regs = 72;
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


