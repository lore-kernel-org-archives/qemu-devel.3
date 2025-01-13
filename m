Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959FCE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8e4-0006Jj-BW; Sun, 12 Jan 2025 19:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8ds-00060O-V5
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:23 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dr-0000rt-Ay
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso3173574f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729356; x=1737334156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNFKP/FDejDxWOyb4w8GKSLrDtPHIPMWbfLURxKHRFg=;
 b=Qa2ObTTnlJycU055II4LzsGjuAlPDo+gI/+MDdlhlp004VAHWlKAt7XmLrRnQwhi5D
 zawdXj3hZf43q2Ru2JVFd0DSdRRFF18grYfW13qOchQnInoyugfFo/So/9NQjqyyX4ys
 5L7BjIxapur+9V7HQ1NdAMRY0JmGaCUHneIcTB1I5UdvQV+0ZK8gcUySZOpnzmT4Ebrq
 B9Filn3hqaG/Dzrti1OOOR09tpk8hnwoiIRUPYT1VovGEiZCFk6yINQW3oPZLuH/oRXi
 eRgL1LQ6apgnJxzRVb4D07/6hOhE7Dvcm8KogeBQVb59eLmVLttGrhgncHp3Pgk3OmUF
 1goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729356; x=1737334156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNFKP/FDejDxWOyb4w8GKSLrDtPHIPMWbfLURxKHRFg=;
 b=vuwUlG49W7whDthSWytfL2UulfXji4BonmbCh+qiX/8t0qGxV6SoISpNmVanTqLxVT
 GZQ5VFlM9ZOdD93hAlXW42VjcSdLAeUe38X1URnciwQbzjOSXlojkK5hYZdCRcqA8nXI
 IhPqD66IV61++Jsux6mrvzR5a1sKMj5oTZXnXuivd6i3a7zGJV8RwZ8U84OKJ8AmXj/n
 zz2xcXzqKVm2taB53ttNpYLDfn3ERPeSuZg+yKvXL5OaQt/c78lk6jrLapC5TTzBN1/t
 kTsSVrMa+2bO4xXPTr/36sxs6tLIK3gy7weWs9ZUMJuEc+NoYCwyxNKQOHve98Sbi7i8
 3F1A==
X-Gm-Message-State: AOJu0YxMTM7zbO0IWXn+NGpZ//MPVMsmoF767/HF1X2B6GusVzB56zk8
 zm/6xhai4ADVcv8Z2ZegjFSNc1FoWPHCVLk8oJEzcBXpx3Iy1oqDJy1sj0dT5XVzdjueC5wiluA
 Qe+E=
X-Gm-Gg: ASbGncubAhyGY9HAR6kSdpjAGWJ+d4rIe2lKtGxSQ8wlrurykWUFiBNtIMlgEBcbrLX
 4gSgOUZuvZqsafZQNBiw1vc7/6xkfr94nHIe+CXq7Qvb0Tjuzho3O/t69C4OShXszHtehf7YfND
 YnbUXp05qdG7HgqIB/NlCTgyFN6Xwv+yaGD1Z5PLetGNDSR/nNcUHCvbwvVF7gmvUr/qmH6B0di
 SFuPQTezhrQJ70/668igoWydcGDYcilOcRYuia4hTstDqbIp5cxzdi6MviD5kZ15I76zz5skvVv
 sLjfCQv/ij3+/RDSrfE5oGu4HRTE3fQ=
X-Google-Smtp-Source: AGHT+IHRPidUYOUuGm1tQ09mjI7APa5th/GsTBOxUkLn8solDvsg+dElVnAulMo3mmXHCGmfskRl5Q==
X-Received: by 2002:a05:6000:186e:b0:385:dc45:ea22 with SMTP id
 ffacd0b85a97d-38a87338d84mr20575885f8f.39.1736729356559; 
 Sun, 12 Jan 2025 16:49:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b82a4sm10918902f8f.72.2025.01.12.16.49.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 15/23] hw/mips/bootloader: Propagate CPU to
 bl_gen_write_ulong()
Date: Mon, 13 Jan 2025 01:47:40 +0100
Message-ID: <20250113004748.41658-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
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

Propagate the target agnostic CPU pointer to the publicly
declared bl_gen_write_ulong() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h |  3 ++-
 hw/mips/bootloader.c         | 13 +++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index 6b58eafb8bc..a7f174e16bc 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -20,7 +20,8 @@ void bl_gen_jump_kernel(const MIPSCPU *cpu, void **ptr,
                         bool set_a2, target_ulong a2,
                         bool set_a3, target_ulong a3,
                         target_ulong kernel_addr);
-void bl_gen_write_ulong(void **ptr, target_ulong addr, target_ulong val);
+void bl_gen_write_ulong(const MIPSCPU *cpu, void **ptr,
+                        target_ulong addr, target_ulong val);
 void bl_gen_write_u32(void **ptr, target_ulong addr, uint32_t val);
 void bl_gen_write_u64(void **ptr, target_ulong addr, uint64_t val);
 
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 9804051ab2d..c4fd85b9f42 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -283,14 +283,15 @@ void bl_gen_jump_kernel(const MIPSCPU *cpu, void **p,
     bl_gen_jump_to(cpu, p, kernel_addr);
 }
 
-void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
+void bl_gen_write_ulong(const MIPSCPU *cpu, void **p,
+                        target_ulong addr, target_ulong val)
 {
-    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, val);
-    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_K1, addr);
-    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
-        bl_gen_sd(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
+    bl_gen_load_ulong(&cpu->env, p, BL_REG_K0, val);
+    bl_gen_load_ulong(&cpu->env, p, BL_REG_K1, addr);
+    if (bootcpu_supports_isa(&cpu->env, ISA_MIPS3)) {
+        bl_gen_sd(&cpu->env, p, BL_REG_K0, BL_REG_K1, 0x0);
     } else {
-        bl_gen_sw(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
+        bl_gen_sw(&cpu->env, p, BL_REG_K0, BL_REG_K1, 0x0);
     }
 }
 
-- 
2.47.1


