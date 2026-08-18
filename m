Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29C2C5DF87
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwND2-0007mY-5N; Tue, 18 Aug 2026 13:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwND0-0007lr-GQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:42 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCy-0004uB-FF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so148623b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072559; x=1787677359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kl4iMyhsy4R3Y60cT67oZr7+SY2GY19fNiwcCtPk6jw=;
 b=e6Ue4vymxZQ/j6hx4BQdjAvDixF+ZwJ1DwuGmLQK3St1dMiIhuNyVjwM4/V8qwYrtw
 5xvLcr2oR8BJgJWUetDJsiMe7oF+ll0gAZwqZXK8g/vHcv8GCd7fhZ9FkxyF7RRn/XrA
 1zW2BE0DPgCUvAfJgUZ8EstaBnGA83z70jp09OWJxYTMw/V2xhDLtWwLbXAl2AmXPOuV
 kjHTRZXU5DSAOWX+uTL+E2I96bqt4K01Q+favO1gH/vnAX7BqNibYmZP62R2FwIdSgWk
 5c7txCyk/fZjZNQRCzBFMR3njQfyB8DuN5Xs+t4jWHy3+b3ufiPqizd3y0w9yECWUfTj
 nYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072559; x=1787677359;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kl4iMyhsy4R3Y60cT67oZr7+SY2GY19fNiwcCtPk6jw=;
 b=LeOJMwCjaB4a4Db579HF3EevxF3tN28+aGlHY3qWXXZXaJ6h7gQjACv/C+LYHFbKO7
 K8tB6AnpWM22u9MK6QLl+Pl5hWYneMEFXWDmRMakqkq82lBNrgd9nvP2T8As2d0s0YZW
 8LbTinizVNzzVAZ3W2/AKUuVvVCXi3KntaB2pIoap/aEjY5hl4hTUJfvgzKqerA4vKIR
 yLFIGhpSFe+VNyY7NkjyBIO2IKDgGAFFyC6RhezL5NHnvhyHaDFKMvKaKpKocfeJtFDf
 n3G/OTZO7UF9pcHawDFF/GM5KOxBdiNiGzpKKIDVch60U1galAOfpnRLwcUM6fMWUAXO
 ubUA==
X-Gm-Message-State: AOJu0YxGfjkmqNWDB1KG4XX4sIhwhsONN8phOMP5EvVtvhpZDfv8rkmt
 0UW3T3JSMEBkSI0GKzJTKqc+IZKhRkU1JIorqStHuZ7oFKpb4S9/eWhX/jXmx6afM/AI7hzDS7a
 KXUR+iSs=
X-Gm-Gg: AR+sD13jSQGso9LYY/d/DLGE3SULGc3Wo0yyWoMXLK0+YVn0RyCXtScaZs5mOX3PUip
 Y1Wvl0hvm3YPJw9HsRf+f4gaq0eo2wm3RdvJHkAgqDsSbgmAz/B3dJfgmPOnwuEAXKy6Bto4r8D
 DdgTOFtM394ThiKRILviGvZabOnqxp6Zsj1o+g79vNH0O2i/6ZBPtrGvKybutAcSmlKNJ3RtYwK
 eF8bTgJvUW91DcSmZNhTnzU+GEX8Zbs4alETVMK6j3AInagnNTzqaBP5dEJn15+ow5fqQJGWFgO
 huizcwHQQUrCAYmmijPpO84+k3910CAT3fPr9Yo8NvMNrDMeKwERQ7wip4J+mJOaO8tmMRELY6f
 ocboIIV/IbWhpsJW0SxUihhKEosIbWfRn4qqL5MDU+6E4fUPG0HonKgwSWCokXsLUQ0fNpUYthe
 +p7Fm111HXAnEt3/PK5Bi3b0FMxRWZVdccdGAoC0U/XUnWXTgRYWfhB6oDQJbmn2vrvgw/U97Fe
 OVsIUSNVW/rrFlslZNl140AwdlvI5y8IMU=
X-Received: by 2002:a05:6a00:ae06:b0:851:c1d2:c48d with SMTP id
 d2e1a72fcca58-851c1d2c8ffmr8823872b3a.8.1787072558729; 
 Tue, 18 Aug 2026 10:02:38 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 36/38] target/s390x: Update capstone disassembly to v6
Date: Tue, 18 Aug 2026 10:01:53 -0700
Message-ID: <20260818170155.1907006-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

In particular, this enables many more vector insns.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 11 +++++++++--
 disas/capstone.c         |  2 +-
 target/s390x/cpu.c       |  4 +++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index a922f7627f..87f8f6181f 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -4,7 +4,6 @@
 #ifdef CONFIG_CAPSTONE
 
 #define CAPSTONE_AARCH64_COMPAT_HEADER
-#define CAPSTONE_SYSTEMZ_COMPAT_HEADER
 #include <capstone.h>
 
 #else
@@ -19,7 +18,6 @@
 #define CS_ARCH_X86     -1
 #define CS_ARCH_PPC     -1
 #define CS_ARCH_SPARC   -1
-#define CS_ARCH_SYSZ    -1
 
 #define CS_MODE_LITTLE_ENDIAN    0
 #define CS_MODE_BIG_ENDIAN       0
@@ -84,6 +82,15 @@
 #define CS_MODE_SH4A             0
 #endif
 
+#if CS_API_MAJOR == 0
+#define CS_ARCH_SYSTEMZ         -1
+#elif CS_API_MAJOR < 6
+#define CS_ARCH_SYSTEMZ          CS_ARCH_SYSZ
+#endif
+#if CS_API_MAJOR < 6
+#define CS_MODE_SYSTEMZ_ARCH14   0
+#endif
+
 #if CS_API_MAJOR < 5
 #define CS_ARCH_TRICORE         -1
 #define CS_MODE_TRICORE_110      0
diff --git a/disas/capstone.c b/disas/capstone.c
index 78062339d0..a5bd91890b 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -95,7 +95,7 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
                   (uintptr_t)&cap_skipdata_riscv);
         break;
 
-    case CS_ARCH_SYSZ:
+    case CS_ARCH_SYSTEMZ:
         cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
                   (uintptr_t)&cap_skipdata_s390x);
         break;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 641ea96c8e..7c725b8a4a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -225,10 +225,12 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
 static void s390_cpu_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
-    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_arch = CS_ARCH_SYSTEMZ;
     info->endian = BFD_ENDIAN_BIG;
     info->cap_insn_unit = 2;
     info->cap_insn_split = 6;
+    /* Disassemble everything, even if the cpu would trap on the insn. */
+    info->cap_mode = CS_MODE_SYSTEMZ_ARCH14;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.43.0


