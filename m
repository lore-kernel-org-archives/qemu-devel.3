Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53F5CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkN-00024I-5y; Sat, 30 Aug 2025 11:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c5-0004x8-Ap
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:29 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c3-0003zG-1a
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:29 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b4c53892a56so2197078a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506625; x=1757111425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZDPXdfsmxBIOUaB++qruH/yHWhEuoUSA6jOwZM9P+A=;
 b=ETp6MoalgxdIJvFyjOPo9SHlM8KzKDYD3SA+uxQ5NCGvJ0/ZZ102EFNxSYT/jRWTTe
 SQ78WyBl6yPhXmq9hTaeDqAQLeZfN1HNZDyNZzX9nujENJkwkRGHWWyPQiSeSvSwRA3Y
 vtNYXsCW6PVt0dZ07eNRAQF8nAOZMH3+7khzPEQRn01AGGQZSQT0cVGS0seILa5VntXN
 DAtWs2SQcin3xiHJB8ebTtieHCJ3loSOvmS4+jgGCveQW0TlO/DsMVgFH4nzHvZJzsTh
 jdw+Y4WGk2B8AaJBagMcfTuOc5sWNbkt9u4T/NGh5mL3OXXd0E/DONOm5b3BW3cM5smy
 WqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506625; x=1757111425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZDPXdfsmxBIOUaB++qruH/yHWhEuoUSA6jOwZM9P+A=;
 b=vbbQXwrRZItbsGBBL96MnaBPVwaoL53cn7H2DI1VoHB9aDodIXDebt+pBx8mgyRRVI
 bWQMzNjaiQdAN7kf9Lo6ODBbU3N+icyG9YAf2Nwm2FqhTKdgRlKxKMGa1O5p1YCGb0WV
 T7FXKxDU+dbMvdUfPqIjuTyYvh+oIvghQih7RHhSsYUgTqFKTePKqwi88YmUduHsOGd8
 WfwVgpvsZrIPyfCE7PkPNG3KqhMCstAVYtYdq9ajfTbMCZYI/wkdvdEII/Nrsd5pH+cX
 rS343yhE8rQ6xn2Zjw6lR4YFzYtLWTpktBIwBpTFKPjE70u4J2kdkf4lO5HdPCCBX+/y
 WzwQ==
X-Gm-Message-State: AOJu0YzNFjuMwUP+30/+vuA+jBv8S2mhJJQO4AsLXEezp/5CTOM7Bdkn
 uP913+MUob0t7qNaUe1iZth46+0JhtsTBqzHHdHu3wK+DlEi/dnw0PJ5WnDATkUKacf8PSt09iF
 h3TGOtWs=
X-Gm-Gg: ASbGncv2d7DaFRGnOD1TopGNTsw5NfSN0njAQizv3IO3WLWrWdylQAvIEmzwswmrhEr
 gs2HjcoPltrp4qeOuGnZXMqpnnihqEUb6Qf5B/nyEyB/+y0tfgngM4ZBurZRc51N5v62hJCvikH
 2wTBxFcjFzK9XkeP5bXBOpubif23xdxHQRmLVIK02niw1l7CUGlKlMNYYZ1M+LwMWeVOhYfuMwT
 tX1Ia0+1SgxF20VGCONJUlBk2dXNCo1XzwgWQcw7edQ0Gml+He7baqaPPAYU8ojHQMuLs26ELFu
 ziZBRkQ1ZUn3XwVjhhxeJVpL25XwuhMhi35mmdlcFpenKcD6XIkhczMSiTi+KkJss1QP2MyPhk6
 3H5V3fN6qGCi5v7st736sjBXYxRkljwv3u0ZN5FvCOA+oVlc1tCLQkhoNpe3gC662vtImMt+zVQ
 ==
X-Google-Smtp-Source: AGHT+IEED1U3Dbk26jwOcheD3Xah11zb1ZhstKva4PGt2+GzTsTuyDSlcobBR6ROrWx8r9yK5Kw6Ow==
X-Received: by 2002:a05:6a20:2449:b0:243:a21c:3730 with SMTP id
 adf61e73a8af0-243d6f036c7mr301398637.31.1756506625214; 
 Fri, 29 Aug 2025 15:30:25 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 71/91] linux-user: Move elf parameters to ppc/target_elf.h
Date: Sat, 30 Aug 2025 08:24:07 +1000
Message-ID: <20250829222427.289668-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_elf.h | 43 ++++++++++++++++++++++++++++++
 linux-user/elfload.c        | 53 -------------------------------------
 2 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 2a61cd2896..9a47f18fb8 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -10,6 +10,17 @@
 
 #include "target_ptrace.h"
 
+#define ELF_MACHINE             PPC_ELF_MACHINE
+
+#ifdef TARGET_PPC64
+# define elf_check_arch(x)      ((x) == EM_PPC64)
+# define ELF_CLASS              ELFCLASS64
+#else
+# define ELF_CLASS              ELFCLASS32
+# define EXSTACK_DEFAULT        true
+#endif
+#define ELF_ARCH                EM_PPC
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_CORE_DUMP      1
@@ -26,4 +37,36 @@ typedef struct target_elf_gregset_t {
     };
 } target_elf_gregset_t;
 
+#ifndef TARGET_PPC64
+# define VDSO_HEADER  "vdso-32.c.inc"
+#elif TARGET_BIG_ENDIAN
+# define VDSO_HEADER  "vdso-64.c.inc"
+#else
+# define VDSO_HEADER  "vdso-64le.c.inc"
+#endif
+
+/*
+ * The requirements here are:
+ * - keep the final alignment of sp (sp & 0xf)
+ * - make sure the 32-bit value at the first 16 byte aligned position of
+ *   AUXV is greater than 16 for glibc compatibility.
+ *   AT_IGNOREPPC is used for that.
+ * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
+ *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
+ */
+#define DLINFO_ARCH_ITEMS       5
+#define ARCH_DLINFO                                     \
+    do {                                                \
+        PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
+        /*                                              \
+         * Handle glibc compatibility: these magic entries must \
+         * be at the lowest addresses in the final auxv.        \
+         */                                             \
+        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
+        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
+        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
+    } while (0)
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ccdd87aa12..526c90e2c1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,59 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_PPC
-
-#define ELF_MACHINE    PPC_ELF_MACHINE
-
-#if defined(TARGET_PPC64)
-
-#define elf_check_arch(x) ( (x) == EM_PPC64 )
-
-#define ELF_CLASS       ELFCLASS64
-
-#else
-
-#define ELF_CLASS       ELFCLASS32
-#define EXSTACK_DEFAULT true
-
-#endif
-
-#define ELF_ARCH        EM_PPC
-
-/*
- * The requirements here are:
- * - keep the final alignment of sp (sp & 0xf)
- * - make sure the 32-bit value at the first 16 byte aligned position of
- *   AUXV is greater than 16 for glibc compatibility.
- *   AT_IGNOREPPC is used for that.
- * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
- *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
- */
-#define DLINFO_ARCH_ITEMS       5
-#define ARCH_DLINFO                                     \
-    do {                                                \
-        PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
-        /*                                              \
-         * Handle glibc compatibility: these magic entries must \
-         * be at the lowest addresses in the final auxv.        \
-         */                                             \
-        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
-        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
-        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
-        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
-        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
-    } while (0)
-
-#ifndef TARGET_PPC64
-# define VDSO_HEADER  "vdso-32.c.inc"
-#elif TARGET_BIG_ENDIAN
-# define VDSO_HEADER  "vdso-64.c.inc"
-#else
-# define VDSO_HEADER  "vdso-64le.c.inc"
-#endif
-
-#endif
-
 #ifdef TARGET_LOONGARCH64
 
 #define ELF_CLASS   ELFCLASS64
-- 
2.43.0


