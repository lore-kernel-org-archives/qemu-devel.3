Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725E3CDDE6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uZm-000191-D5; Thu, 24 Oct 2024 05:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZi-00017r-CI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:16 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZg-0003n7-Bp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:14 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso90920866b.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763771; x=1730368571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqKopH4arkGRC9gLv/9n1TSlUFMfVszFCtTC30nfocI=;
 b=qPmNTHk6Vf1NQF/0IrPsiO0cxkWAL5cfiDpsxN7FUoI6dXBfC8IBVrPoxOW7GTwhM/
 0yVgHG0UfX150JbNE0iecquUKG6p+YHDa7tYmiKF2KkxKTY/Pq9bIcIQb7JvNyXEaXL3
 EpLSosioYQNEFC8rsvwZyTTSVNZbqqKr6eH8lzkvA2lIPMBURjGBDsnPL0EYAPLd53xt
 Gaula5Gs1/POqlzWfT/sk8fH9inWiUBgfWdtiuzCAesGWT60zOvIg8HCRmhULfrFifCW
 ayFaw4azalapR7Gj4XRUWep5r53amyH72UdfLMFDSVqCWy6ZTQh5AJvmsaqWmpip6qPa
 knvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763771; x=1730368571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqKopH4arkGRC9gLv/9n1TSlUFMfVszFCtTC30nfocI=;
 b=Iiq2VeNQuL8NlyCTiq73zSDOkkXyiDGA9WIofTRssbMlalQM54/YCvjJTPHfQDrYTl
 8rMZJMd+sd3q1zcBZpVcZsi270IehVSg0ENIN21ZyKMvR0c91MHPU1EkZA27f37OS20M
 DmyFo0Lf8f0fLJwe9I4g2IpXTtoZIqWCBFGkZPxVEUWXxTde/Hha2i9wQg0K1JREofbJ
 w6OHd8GeCK/YOT53xCUkeTooucQXBCo7UV+YQ+/uXR/Z+GZwSx/BoYJDFmbYmd4F9pkN
 DxYJUhpN/Fy3FaMmII7JUOazN3CUE+tr5sYg7b57DGvJCcTo3mXCQh33Y5WyGQOh/tut
 YScg==
X-Gm-Message-State: AOJu0Yzhpo0L0ivE4/A7QwwkLSR/UEZKWEgVtsLmCYbNcActdIGETpZ8
 isNI6QrwzgxejZWReAr120RrTEFfGr8fGjrzq5Ci+JJamftWi6xe2JN/tLnRkZc=
X-Google-Smtp-Source: AGHT+IH3L57uMPNEc5ciPkQ6Z6wKF8jvnpf0tCdMWPVSnLqDnskZjGBVZMguPh/NVov8hdxYdjsAeQ==
X-Received: by 2002:a17:907:97cb:b0:a9a:1792:f24 with SMTP id
 a640c23a62f3a-a9ad27317d7mr119974866b.24.1729763770701; 
 Thu, 24 Oct 2024 02:56:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912ee061sm593766466b.63.2024.10.24.02.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B71765F942;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: [PULL 08/17] accel/tcg: add tracepoints for cpu_loop_exit_atomic
Date: Thu, 24 Oct 2024 10:55:54 +0100
Message-Id: <20241024095603.1813285-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

We try to avoid using cpu_loop_exit_atomic as it brings in an all-core
sync point. However on some cpu/kernel/benchmark combinations it is
starting to show up in the performance profile. To make it easier to
see whats going on add tracepoints for the slow path so we can see
what is triggering the wait.

It seems for a modern CPU it can be quite a bit, for example:

./qemu-system-aarch64 \
           -machine type=virt,virtualization=on,pflash0=rom,pflash1=efivars,gic-version=max \
           -smp 4 \
           -accel tcg \
           -device virtio-net-pci,netdev=unet \
           -device virtio-scsi-pci \
           -device scsi-hd,drive=hd \
           -netdev user,id=unet,hostfwd=tcp::2222-:22 \
           -blockdev driver=raw,node-name=hd,file.driver=host_device,file.filename=/dev/zen-ssd2/trixie-arm64,discard=unmap \
           -serial mon:stdio \
           -blockdev node-name=rom,driver=file,filename=(pwd)/pc-bios/edk2-aarch64-code.fd,read-only=true \
           -blockdev node-name=efivars,driver=file,filename=$HOME/images/qemu-arm64-efivars \
           -m 8192 \
           -object memory-backend-memfd,id=mem,size=8G,share=on \
           -kernel /home/alex/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image -append "root=/dev/sda2 console=ttyAMA0 systemd.unit=benchmark-stress-ng.service" \
           -display none -d trace:load_atom\*_fallback,trace:store_atom\*_fallback

With:

  -cpu neoverse-v1,pauth-impdef=on => 2203343

With:

  -cpu cortex-a76 => 0

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-9-alex.bennee@linaro.org>

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 51b2c16dbe..aa8af52cc3 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -29,7 +29,7 @@
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "qemu/atomic128.h"
-#include "trace/trace-root.h"
+#include "trace.h"
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 134da3c1da..c735add261 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -168,6 +168,7 @@ static uint64_t load_atomic8_or_exit(CPUState *cpu, uintptr_t ra, void *pv)
 #endif
 
     /* Ultimate fallback: re-execute in serial context. */
+    trace_load_atom8_or_exit_fallback(ra);
     cpu_loop_exit_atomic(cpu, ra);
 }
 
@@ -212,6 +213,7 @@ static Int128 load_atomic16_or_exit(CPUState *cpu, uintptr_t ra, void *pv)
     }
 
     /* Ultimate fallback: re-execute in serial context. */
+    trace_load_atom16_or_exit_fallback(ra);
     cpu_loop_exit_atomic(cpu, ra);
 }
 
@@ -519,6 +521,7 @@ static uint64_t load_atom_8(CPUState *cpu, uintptr_t ra,
         if (HAVE_al8) {
             return load_atom_extract_al8x2(pv);
         }
+        trace_load_atom8_fallback(memop, ra);
         cpu_loop_exit_atomic(cpu, ra);
     default:
         g_assert_not_reached();
@@ -563,6 +566,7 @@ static Int128 load_atom_16(CPUState *cpu, uintptr_t ra,
         break;
     case MO_64:
         if (!HAVE_al8) {
+            trace_load_atom16_fallback(memop, ra);
             cpu_loop_exit_atomic(cpu, ra);
         }
         a = load_atomic8(pv);
@@ -570,6 +574,7 @@ static Int128 load_atom_16(CPUState *cpu, uintptr_t ra,
         break;
     case -MO_64:
         if (!HAVE_al8) {
+            trace_load_atom16_fallback(memop, ra);
             cpu_loop_exit_atomic(cpu, ra);
         }
         a = load_atom_extract_al8x2(pv);
@@ -897,6 +902,7 @@ static void store_atom_2(CPUState *cpu, uintptr_t ra,
         g_assert_not_reached();
     }
 
+    trace_store_atom2_fallback(memop, ra);
     cpu_loop_exit_atomic(cpu, ra);
 }
 
@@ -961,6 +967,7 @@ static void store_atom_4(CPUState *cpu, uintptr_t ra,
                 return;
             }
         }
+        trace_store_atom4_fallback(memop, ra);
         cpu_loop_exit_atomic(cpu, ra);
     default:
         g_assert_not_reached();
@@ -1029,6 +1036,7 @@ static void store_atom_8(CPUState *cpu, uintptr_t ra,
     default:
         g_assert_not_reached();
     }
+    trace_store_atom8_fallback(memop, ra);
     cpu_loop_exit_atomic(cpu, ra);
 }
 
@@ -1107,5 +1115,6 @@ static void store_atom_16(CPUState *cpu, uintptr_t ra,
     default:
         g_assert_not_reached();
     }
+    trace_store_atom16_fallback(memop, ra);
     cpu_loop_exit_atomic(cpu, ra);
 }
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 4e9b450520..14f638810c 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -12,3 +12,15 @@ memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, const void *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
+
+# ldst_atomicity
+load_atom2_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+load_atom4_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+load_atom8_or_exit_fallback(uintptr_t ra) "ra:0x%"PRIxPTR""
+load_atom8_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+load_atom16_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+load_atom16_or_exit_fallback(uintptr_t ra) "ra:0x%"PRIxPTR""
+store_atom2_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+store_atom4_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+store_atom8_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+store_atom16_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
-- 
2.39.5


