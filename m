Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3CACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmd-00007l-V2; Sat, 30 Aug 2025 11:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fN-0005vU-5W
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:33:53 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fL-0004kn-6Z
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:33:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so2095219b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506830; x=1757111630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ehuepqbbm1Pb/ucVF5IT0BiMjGQDJEiKUXOOtANgHtk=;
 b=WSh2EOgMX8L89JL5UKOPeq9pEKyJ/vlXPcbAsrIGKe93a+LJX09FUpdCbruwEkABu6
 +hRmd+zm2J58WYFgD8hrvM6KVuimuxDv2wz/rn0ORx9Gx5Oq7GDEfEam376OLc7naflZ
 X9K4NxVAipA5514tvP4fuZnzZdbiT8yySCMNohf5uMUZQLgKsgGtY+Mj38IYQfMmmZnJ
 4VYEO/i+8UZQcqVhWMPPGu+0dHcsWXRtvR9A/cMctxKaaTyD5QZFLSxMl9dCmdOA7Bkf
 gstG9ehYwKv1hy8nu0h09XJ6jy7XGPoHot3eowh6WacldLCtXfYJaLe2X0P4byCd7g3s
 V/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506830; x=1757111630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ehuepqbbm1Pb/ucVF5IT0BiMjGQDJEiKUXOOtANgHtk=;
 b=iuR4B8kTAtTwtNc+eulQ2UIvPAJsUFEmRqps4CMdJ78e2H93VsTVjPhlA32MHyeKMj
 RlH6BlpAGxbFhn7T2bNdmHkpDU9rKci/hyG//6QeVSX0xllyDPTHx2wHeWSnKokT8Ols
 M5n03+3Yr8kBPttHowWQqTUhIOYhBBD7DGESHvEB6D4SmtdhP2PYkqMkc7bk6/Ar0+gu
 /s3apt0ST5u1X0gngt96yFtqgSqWnrcW+BGBwREN64RnSVjTcsXUxOktEfvKgzdrHNt+
 H6/Pzb4cR14eBKbMqggCNV7jYFJjus5OX+MT12/KzV/0wRmFVe9GlCd0bdZpKvrWbv0k
 AygQ==
X-Gm-Message-State: AOJu0Yxf/+I9vFRHQH7lsaLi8036Ok1pDUvN3lSF78iq2GybCEdD7N3P
 S8sZATP7nLH5BZwof77Fiopq+7dJmAVYAYtXHeMy0Q07OgN7VLffPBmalOTRR88+i3I1ERnoDHm
 Xe/J7VrA=
X-Gm-Gg: ASbGnctvOfXsGTRKZSeLzqPw63lEqNhTBtTnp+yvPWtFhaGD+H5JyEDpR76/ROeyw+O
 W3ukAE6687sZxOWpygCwnjUNlICc2S5OTe7iKbXzHkNnO5cuTuianaQABa0MmFmH/0hIdAvKEhA
 1IZoegrgfd8oELJVFqzY2M+WBB4Ln/XdC1H/5hXCpIJ2NwF/+EvuxZSziSWh9QtPlvUcBVxXVEJ
 DvZiEL9lEXvD8W/ukK+OX1ouzwxE0cfsfdEcVkTH0AtPF80PCR7wibTTwhTAaWnYikcTj4/D1PI
 gjAVdDfIN2IOZnG604OcpYT1q8ZbggoOzJ/f54+YHMDf5ooeCiBziaWaI1mrPay5VaspldiTftw
 gDfiNu/QXMsObN9AN1qdmSQPEISszE3CDDDITx/5uqlD4dQXcW5HFbh3+JseR
X-Google-Smtp-Source: AGHT+IGnkBb/UdwDIGtDE9/rdtjgkj+MFXrkVyYyI1/dn4U4xOH7U9+C99hEVGdmJMACTJbR4QU2Cg==
X-Received: by 2002:a05:6a00:1495:b0:772:177:d442 with SMTP id
 d2e1a72fcca58-7723e309f7emr306041b3a.20.1756506829714; 
 Fri, 29 Aug 2025 15:33:49 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:33:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 80/91] linux-user: Move elf parameters to riscv/target_elf.h
Date: Sat, 30 Aug 2025 08:24:16 +1000
Message-ID: <20250829222427.289668-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 linux-user/riscv/target_elf.h | 10 ++++++++++
 linux-user/elfload.c          | 14 --------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index 48d9af557b..51b8def1d1 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -8,6 +8,16 @@
 #ifndef RISCV_TARGET_ELF_H
 #define RISCV_TARGET_ELF_H
 
+#define ELF_ARCH                EM_RISCV
+
+#ifdef TARGET_RISCV32
+#define ELF_CLASS               ELFCLASS32
+#define VDSO_HEADER             "vdso-32.c.inc"
+#else
+#define ELF_CLASS               ELFCLASS64
+#define VDSO_HEADER             "vdso-64.c.inc"
+#endif
+
 #define HAVE_ELF_HWCAP          1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 705d726922..6e476d5308 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,20 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_RISCV
-
-#define ELF_ARCH  EM_RISCV
-
-#ifdef TARGET_RISCV32
-#define ELF_CLASS ELFCLASS32
-#define VDSO_HEADER "vdso-32.c.inc"
-#else
-#define ELF_CLASS ELFCLASS64
-#define VDSO_HEADER "vdso-64.c.inc"
-#endif
-
-#endif /* TARGET_RISCV */
-
 #ifdef TARGET_HPPA
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


