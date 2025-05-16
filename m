Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29053C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 12:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFu6L-0008VQ-Qd; Fri, 16 May 2025 08:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1uFu68-0008Uf-I3
 for qemu-devel@nongnu.org; Fri, 16 May 2025 08:23:37 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1uFu64-0005wQ-JF
 for qemu-devel@nongnu.org; Fri, 16 May 2025 08:23:32 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so1804029a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747398205; x=1748003005;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zFGmEPgUuAxw3aWTUk4BZA6z6uqVN1EffF2YNTuRFgI=;
 b=Jx02Nzg/wuvfMd0DONs7t56GVouPmY3HEO+i0KFlmVQyA9vdkpdWPqaBnTxfXDRpvn
 jfrlMn/41KNNMOrVumY+tIjeJtiltlgaXbReOzJJxSTm+1V13k5mBwVGo/k00R/Xd/ek
 HYJLJ2wxHS34b5TCnvfqyriMQW78nLdJ/OpYRxJQRHTGZhkJR92UOYa52UDzdfK6eLYs
 vzbcqDPMBHNRifplnlYVpgLrWkw4qgeSCyXGhdGxTjoGc1Bzn8gELqZEHw5sZBQUjt2V
 Zv3ne5fHupNycfuhMrqbLPyknKHkFDUiBA/1ExlWpsUhJXDqgALNxx/YDhksX3VLMk1m
 zBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747398205; x=1748003005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFGmEPgUuAxw3aWTUk4BZA6z6uqVN1EffF2YNTuRFgI=;
 b=NYHdJ7dIOZYSdNsno/VFeBhXAsJ3nmms6RRtB3JS+oxGLM+6motL8Gi6Cjyxb3j3sp
 pV27KjB+1Cb6l+iQxu8C/2AHQA7x6HbM1TYJiGfJJYIiR7gN6wV7IvRw/Ja1/Xizobu3
 AXT8yOpT44dlaEh/xF6PxnMbl6YJqPc0/dw4FVdp1+63DE+5EW1iaQBozmJTVkGEYCQ9
 FAFVVAQnkk7EqcHD3xeuwXFr1KtDGTC46gDIyfMw/9UobSFwyAl7URqGW70rgQA+3Z9G
 Tzi4n+VcsxxG9PsyNy1Ltj7+W2AaM50HZUbVVqviUfsARoOKCsNfirDP+OfYZdFUvkrb
 U9RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZyyexjTCgwaA66IZyUYf80Ew+CvSfWYNAMkoYMhCBJWChsKIolDLs5jfbFHObh3H/nQS+Z7Wxp9MV@nongnu.org
X-Gm-Message-State: AOJu0Yz3iP07FiMXbvBw1WistQfrziyhVj2ZEbji5k0opP3PvMjUU0M7
 dQXxeDKTKR6KMpOXwWsC7X8Iu+AFXbaLZaftO0wDw5JnUrSxMbyx1ZR+npdvUftqVs4dTX1uoM7
 SFJkH
X-Gm-Gg: ASbGnctAx9jgjvbUsB78UeCXQmP3GfkBOkwi1es6b2yNCgVu2gEbGVl+nQ9F5sxrTfb
 ULILs1CJy8wDowa+Wfn8Vo6YVRsWxdEtjwh30c13J/Q4LR2n39hmXreoZN2q4FtUWXBlBXKWL33
 cwl/yrtrbYnxhb+PORdM5fr4YKb9JVg5BYLnrS2LXc3SnIVW/PPeVnfYYgsyyi/Eoe+cTQ6T4mz
 wzlNRwErs1TPj/QT+wQkoTP6yVrJITG1bo/b6FIy8Y5DWPs+KW63RX12UcMROPn5n9oZRm6naPw
 MVlaXHedlMi03R6fsYc8VUG5evOWwCVagR8xbP2gSLjBHzpM+WuD
X-Google-Smtp-Source: AGHT+IGSbrZ5yIrXU0mkUdq3nsZG4JClGnXAB1Egwm6uCsvSwnZIVpVwkSL5qUPQmHFhgDITcPaWFw==
X-Received: by 2002:a17:90b:2d83:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-30e7d585bb2mr4170268a91.21.1747398204987; 
 Fri, 16 May 2025 05:23:24 -0700 (PDT)
Received: from alexghiti.ba.rivosinc.com ([2001:41d0:306:1be8::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e33401872sm5198799a91.6.2025.05.16.05.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 05:23:24 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RFC] target: riscv: Fix satp mode initialization based on
 profile
Date: Fri, 16 May 2025 12:23:19 +0000
Message-Id: <20250516122319.4100121-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alexghiti@rivosinc.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The satp mode is set using the svXX properties, but that actually
restricts the satp mode to the minimum required by the profile and
prevents the use of higher satp modes.

Fix this by not setting any svXX property and allow all satp mode to be
supported.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5aef9eef36..ca2d2950eb 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1232,9 +1232,6 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 #ifndef CONFIG_USER_ONLY
     if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
         object_property_set_bool(obj, "mmu", true, NULL);
-        const char *satp_prop = satp_mode_str(profile->satp_mode,
-                                              riscv_cpu_is_32bit(cpu));
-        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
     }
 #endif
 
-- 
2.34.1


