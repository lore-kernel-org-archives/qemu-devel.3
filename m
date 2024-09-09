Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BFBECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniCA-00068u-W9; Mon, 09 Sep 2024 13:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniC5-0005T5-F9
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniC3-000651-4O
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20551eeba95so40962655ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902930; x=1726507730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5P3AbnuXIViFNLZwcR2g2CnCbWPQ0yDuBfVcwQJfUc=;
 b=UNUl7Vug0wAYO/M7rlhT8AfFhrK9m8HyJqnySwKMMayNRtPL/+a4ffmrdPET2aGrBr
 sffa9+Rg1rZUiWZnOBIbW/fETU9Pmgn/Ta/cywo7fDOchLKHT3wBC4uo7pGf/otz4LwG
 8r09wFEx3HwZqyGzf8mN726BZM3EISsQ/8Hd7DBDxx1OBrzspbnb6DUTl6CtJ+4+HJDK
 gHb9ktByfTYrQCK9Unn7duiJDpiC3jyeIJsxaZChLxJ3d8HbEPkVtja+P59+R0K4dBTN
 z/po9C7+tA1HBHCX9noX+tcfJI47Znf1xf+3PiSECFAgI0w93kVTgUBzUKeuqsKyhNu8
 a3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902930; x=1726507730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5P3AbnuXIViFNLZwcR2g2CnCbWPQ0yDuBfVcwQJfUc=;
 b=JmXKrazDXIwEQvKMhKnNMgVtuQAk/ZGua60aTiFk+YuUzN+jTdKffcEhXG2zfNws9f
 gIlJGOdimEhsLVG8YACMUK8C3uH5jdhpQyxXwOLsVSarIxQFHkxC8Kvr9dyh+8P38ZQ8
 hG06entLcFH+eHxmeR6rTD2AG9QvEEFyY6SeBTg/lptbi+HiFD2FXm3UZIWvlGS9gHMq
 pYgSUzzmEThRz5ArjI+KuRoSGcOynXTJAAm3zk7DhYYWE8US/Hh76mPww46JlC3sDKFB
 0OxztkdafAckhs7rRV3iu1panJTBAZlvBnOVDN2bghlfjCbqWglKL0wJb+axqRUqUtkM
 H3pw==
X-Gm-Message-State: AOJu0YwB6Mp/wJ9hOn3wIlOo5jCsGog/OlLX/hjK/EgSWMPESJfcSQ9H
 R3n/YWZ+3NTyzHIu+vCELZkJcksOdChHnYtrssTobsWnjCYIUuwisaBJ/xrOtEXKzqkPppwLLdq
 M
X-Google-Smtp-Source: AGHT+IFNhv4hoOa7YnPvYMKlr3kVT0OMYi31TooDRpM92iqNHDuLfOmNEIdSWsEn5whZDkRRYLo2+w==
X-Received: by 2002:a17:902:cf03:b0:207:2093:99bb with SMTP id
 d9443c01a7336-20720939bc2mr48344855ad.31.1725902929627; 
 Mon, 09 Sep 2024 10:28:49 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 26/26] target/m68k: Implement FPIAR
Date: Mon,  9 Sep 2024 10:28:23 -0700
Message-ID: <20240909172823.649837-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

So far, this is only read-as-written.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h    |  1 +
 target/m68k/cpu.c    | 23 ++++++++++++++++++++++-
 target/m68k/helper.c | 14 ++++++++------
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index a676ae0b34..9d987b42be 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -110,6 +110,7 @@ typedef struct CPUArchState {
     uint32_t fpsr;
     bool fpsr_inex1;  /* live only with an in-flight decimal operand */
     float_status fp_status;
+    uint32_t fpiar;
 
     uint64_t mactmp;
     /*
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index fd6c227820..e36eb3e5d6 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -392,6 +392,23 @@ static const VMStateDescription vmstate_freg = {
     }
 };
 
+static bool fpu_fpiar_needed(void *opaque)
+{
+    M68kCPU *s = opaque;
+    return s->env.fpiar != 0;
+}
+
+static const VMStateDescription vmstate_fpiar = {
+    .name = "cpu/fpu/fpiar",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fpu_fpiar_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.fpiar, M68kCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
@@ -412,7 +429,11 @@ static const VMStateDescription vmstate_fpu = {
         VMSTATE_STRUCT_ARRAY(env.fregs, M68kCPU, 8, 0, vmstate_freg, FPReg),
         VMSTATE_STRUCT(env.fp_result, M68kCPU, 0, vmstate_freg, FPReg),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_fpiar,
+        NULL
+    },
 };
 
 static bool cf_spregs_needed(void *opaque)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 6fc5afd296..dae6542e6d 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -44,8 +44,8 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
         return gdb_get_reg32(mem_buf, env->fpsr);
-    case 10: /* fpiar, not implemented */
-        return gdb_get_reg32(mem_buf, 0);
+    case 10: /* fpiar */
+        return gdb_get_reg32(mem_buf, env->fpiar);
     }
     return 0;
 }
@@ -67,7 +67,8 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     case 9: /* fpstatus */
         env->fpsr = ldl_p(mem_buf);
         return 4;
-    case 10: /* fpiar, not implemented */
+    case 10: /* fpiar */
+        env->fpiar = ldl_p(mem_buf);
         return 4;
     }
     return 0;
@@ -89,8 +90,8 @@ static int m68k_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
         return gdb_get_reg32(mem_buf, env->fpsr);
-    case 10: /* fpiar, not implemented */
-        return gdb_get_reg32(mem_buf, 0);
+    case 10: /* fpiar */
+        return gdb_get_reg32(mem_buf, env->fpiar);
     }
     return 0;
 }
@@ -112,7 +113,8 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     case 9: /* fpstatus */
         env->fpsr = ldl_p(mem_buf);
         return 4;
-    case 10: /* fpiar, not implemented */
+    case 10: /* fpiar */
+        env->fpiar = ldl_p(mem_buf);
         return 4;
     }
     return 0;
-- 
2.43.0


