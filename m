Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE43C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbR4-00026H-C5; Thu, 28 Aug 2025 08:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbR1-00025M-DQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:55 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQz-00078e-Rx
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-771fa65b0e1so470117b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382932; x=1756987732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1p9ZZX2L4dPqSAnciIvd5Ttg4kPY8+u2dEvBtnDYjk=;
 b=r/R14EADdYHgEsbJXilUD3DxCmVf00dX3zPnfrMlwb1Qa9tIKVx+G5Pij0L0ysKSvX
 yJ7Ys7OuInJJhsBo1nuhi1qO8seGXehERsNTrNPu2S4WtUPnpke0V7CRPwMZG+uUZVWQ
 FLGyDFvr9d7GM/EtNku7FgxHVMEh3dZbvUe0TPAOfoMb70xs2eM57LIo592nC5NqzWbA
 tjfxWqj5lNgohc3G6gNhIxRbZPlVBI2qZFEuAj5H4qTJ6gHW5vz8H2TUvhqtSKuyHHDW
 tF5IpFscHIxmaPS0W8K3v6CgLu1y3p2im0BrFMhu8X00bEzgw3dQjbYS3SrDYd0gPVU0
 R/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382932; x=1756987732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1p9ZZX2L4dPqSAnciIvd5Ttg4kPY8+u2dEvBtnDYjk=;
 b=S1ysb9ExjfDSWThUtBsepywGoXvdmSD7aksyZU1Syes1iiY3Pjy+ofEZGu1gbI0IpX
 kWYKqtn7TThrD3hmjlQOcYXGk6n0jTN24Fyv+jEu3Ojxx3XP4OqISzSA17PArGNAZ8cb
 l+PtZhLLjln6GWoYaxulqM4BVRU5S7xjjOHKRgIRSATDK2VAvoEYUiBkZ+SJtTck+zZs
 ISUf1Jf9xoHJ9NQymyTCZj9apFy/4Lr7d2zLOm69nCoR+PwFxlNh2BmMKi2Dyo9RNlg3
 gnQlSTLWnsYDX2Pyz88mI3Fbelh7Hu9f5fEdHnpQr0zWMyhIoczQ3hJLeeovkzHZF668
 EM1g==
X-Gm-Message-State: AOJu0YwwJpszlnZm5Fe0GxPpld8eUOchGeSbyfzXg2+V1e0LzAyHWtql
 tVskioze/OeG/pqmPWSh0rjMV7X70GwSUUKd1DyYzbk4FEHHafjXFVIWx83P3hwyayfEkPounpL
 nh36QzJI=
X-Gm-Gg: ASbGncug6QAGVcbN8bjDDYBJaTbjVPaDvSY4P03WVuXStew0oQOCb5Iq6S6mK27zveE
 4Yok6ToAfVSvdN2Y6J9l/vVJTgiXa0liH7Bm3n4u5uqbMTgezucOOw4iLUfVSjtyQxmR6pkbF0n
 N3wenl8mdaPHpNFKxFK13/ZZ7HTLFd7DuilvhtGjIr4hgO5PbM4ruZERZpNBFdrLOSRBMGCt0ic
 Lp/mquWbb0FeJF0nd99lSZ5nv8yd1i+Jp5r+QZt0YFEXGTNXwlEjgihSqjZrZiT9utWUyFZ9Ngh
 t8tKqqnJG+Oy8H9v8PhSleBott+p6K4gUok19h4g+6nbL7PukdHPElIf7Gb/JnFP9Hit4ViLeTL
 n4DCG4PxKBI0WHJN6IcqQ7Oeu1w==
X-Google-Smtp-Source: AGHT+IHFFHjx+C55KJuRdYBIHtFG5cyaA9gpC4S9p02Sv4UjfZmxOyEKd1X7Fk5Si2aShu67XSiDlA==
X-Received: by 2002:a05:6a20:3d12:b0:243:7cff:6251 with SMTP id
 adf61e73a8af0-2437cff65ccmr19817741637.26.1756382932365; 
 Thu, 28 Aug 2025 05:08:52 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:08:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 04/87] linux-user/aarch64: Convert target_elf_gregset_t to
 a struct
Date: Thu, 28 Aug 2025 22:07:13 +1000
Message-ID: <20250828120836.195358-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0180f6063f..da57c6c2ce 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -384,18 +384,17 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS64
 
 #define ELF_NREG    34
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUARMState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(env->xregs[i]);
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(env->xregs[i]);
     }
-    (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(pstate_read((CPUARMState *)env));
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


