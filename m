Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A67C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZG-00064y-2T; Mon, 17 Jun 2024 14:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZA-0005Jj-1P
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZ8-00051c-HD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70413de08c7so3360851b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650732; x=1719255532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwdwkyILIZzUSkN36LJeX98rjpRL4TLtxBZLomRK6og=;
 b=PDDj6pE0rkiEo7pGYMZ5b4FGXPsAlF7yMLLKhkfq7Ne/sAciBEnP31yroXf++KpCb6
 tioeG1XpV7V/V9VofbuTuvLOOs6jJ/RNDgjkBxTqKaHrmcK73F65zIFAnrDj5UgnuqCP
 9QIZAqdUFzCqi5/ZXsxbcfOEwojCpubyfF/IA3QWGVLx5poAXwO2PbDs4DUVAmoS3raA
 9aO7nVkx4WFLR+N9czPfd3KpdB6MkEFd5aO4jzAnucZ3sq4ETJt6eJWnoFFMUKhLJPj6
 K7W4ELz6oI9qgfD3J/eIf0yuJuX9saiMeD+4xIONN1dA9s4RKAz7mdwmh8YISeAiY9fm
 5ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650732; x=1719255532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwdwkyILIZzUSkN36LJeX98rjpRL4TLtxBZLomRK6og=;
 b=fVZXHSJ/QprjjBZKsxk1AtyuxfUoZiuykmuE/hiWHCcLizYqv7+c7Dv4r1a9PHXARu
 mB6FxI5f7awrYCRM2oyxrrPFyscKfekyrdeYKB/lbwmZZOhgjfrgg64tiY7XYycX+aZp
 xj3vDXFiSzaTKrXPN/Sf+3uLrT1d0D0pwZqfL1PK6dKihWChu2uFC3FmoS0lM55S573e
 T78chAf6qglfStQFWvdRKuxkmCBRnpKgPQQLdeX2rk9im4klSU1yNfKH6mWTBxGoUBiF
 55+wqmAHu6TCfHjy5JA0kjC5aRjyq879s3tKpkGZKrN3iZtD29haT93FB1hlT7OVI3AI
 mcOA==
X-Gm-Message-State: AOJu0YzO9m2HIlQJuDbfxKShFYNIh9rSenTBWrnvdznPHfEqQT56UHhK
 d4tjboMgP/lNrdZZ6UIudp7cNk7IdUBpylaBsxArTrQ76vK1kKZCpRHARA0sBCo=
X-Google-Smtp-Source: AGHT+IEtvYs0UYPv/dfgTvtwxcG8vJ886jL3Ds++XE554L2q/S9h1t9Fk9GuohNfGWHXaFdaY2T8AA==
X-Received: by 2002:aa7:8f8f:0:b0:704:2152:e4d2 with SMTP id
 d2e1a72fcca58-705d7177310mr9549459b3a.17.1718650732367; 
 Mon, 17 Jun 2024 11:58:52 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:52 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 15/23] Add function to retrieve ARM AArch64 hardware
 capabilities
Date: Tue, 18 Jun 2024 00:27:56 +0530
Message-Id: <20240617185804.25075-16-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Warner Losh <imp@bsdimp.com>

The function initializes default hardware capabilities and
finds additional features using the `GET_FEATURE_ID` macro

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_elf.h | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 41afa5a9da..ed2419408e 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -95,4 +95,42 @@ enum {
 #define GET_FEATURE_ID(feat, hwcap) \
     do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
+static uint32_t get_elf_hwcap(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    uint32_t hwcaps = 0;
+
+    hwcaps |= ARM_HWCAP_A64_FP;
+    hwcaps |= ARM_HWCAP_A64_ASIMD;
+    hwcaps |= ARM_HWCAP_A64_CPUID;
+
+    /* probe for the extra features */
+
+    GET_FEATURE_ID(aa64_aes, ARM_HWCAP_A64_AES);
+    GET_FEATURE_ID(aa64_pmull, ARM_HWCAP_A64_PMULL);
+    GET_FEATURE_ID(aa64_sha1, ARM_HWCAP_A64_SHA1);
+    GET_FEATURE_ID(aa64_sha256, ARM_HWCAP_A64_SHA2);
+    GET_FEATURE_ID(aa64_sha512, ARM_HWCAP_A64_SHA512);
+    GET_FEATURE_ID(aa64_crc32, ARM_HWCAP_A64_CRC32);
+    GET_FEATURE_ID(aa64_sha3, ARM_HWCAP_A64_SHA3);
+    GET_FEATURE_ID(aa64_sm3, ARM_HWCAP_A64_SM3);
+    GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
+    GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
+    GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
+    GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
+    GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
+    GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
+    GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
+    GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
+    GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
+    GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
+    GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
+    GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
+    GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
+    GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+
+    return hwcaps;
+}
+
 #endif /* TARGET_ARCH_ELF_H */
-- 
2.34.1


