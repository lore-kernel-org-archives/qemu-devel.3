Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA95C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguct-0000dQ-Fw; Tue, 29 Jul 2025 20:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJK-0004sK-Ln
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:47 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJJ-0004ge-2k
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-769a9c3bbc4so1412321b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833883; x=1754438683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bmVBB02WViRDaWegeK7GjXuBg4XFIgnlwIeIpu6pXNg=;
 b=ZC3GBIqDEKFqajLtiYsc86MpjSNXwXA13u1KqGf+Np59NSASzqm7Oc/F7gZ/V7v121
 dGH8QH6Weg3B/isGQnXsc2NV0RLnfTcKvgocqAUp8fNrDmV/TMx4RoYMfarl16U/id7k
 vGx+EgIStKYE3YGL9YBVLaULsb9e4OFaw7l96Gkaxaajs5S+kt6y8cLnHw+2Bd731l8G
 iDhYNZbrPWlDD04KF58RLo6UC6whdiWeY3QQ5oMd+uZnW7dYcmMUVUKXNutqGy5aeay8
 WcgiOAfSLuGVfBBtp5YEuoTtheSctR4iKGIeOunoNisZh3LefYE/rPn1241bR7FkAtRI
 6HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833883; x=1754438683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmVBB02WViRDaWegeK7GjXuBg4XFIgnlwIeIpu6pXNg=;
 b=nPwzIQc72YiU509yQtrOgSmJ31kdj0gz2XxpZU1KrteGuCD1KNzzDGzZrZrzGRCYa9
 mpRZ6RZyTnkelaroIIGJvpm3D39s350xI08Pdnu7HSStC3V1m0lVkOgK1pcLeG/dASRa
 Dr8+URqIC04+bPJTsTFKjZtlTvtXSAqUl6aV0ok5yLxDgcfwC8oHkf8VAu/K+eVQkNxa
 1zWIkC9xmg+l8p3lddl4+iQIwT48QNIQvEnztrCZtcla/MhvsAhKIBk1EbEfQfeCKqA8
 hhFlko69ZPdERpj6XebIPnROSrIbcSg3j9+Hh8846SJDYUz6kIv8tRiNrc3bwnc3a8vl
 LYtA==
X-Gm-Message-State: AOJu0YyHR3RI43Iz+TCb++RGxr4yahaBCwsIhpzscGwIAgjqwlAz2i2t
 QVtHIk7CErEIxznsSUUwLGePZ9B0k2ma9H/8SJ0iHZo3cwkOzaJA//sbH4wlaAWG+IGnaqg4PM7
 +MefH
X-Gm-Gg: ASbGncuiiX4QCofa2+SGdHGh119VVHt0dmXwzubbtlYMA00cJjod82KsHypBlay4ehe
 BxloNFyqdRFA7/jboq0KedwCssSqenEqBhhrCcv8oNnIBJZFiPlVTi7ns7DXhkVvsriyUFep99G
 aweJBSJL53CzEBpOXeGj1EhEVrqV1tdnDz02aHPwa88/QwqePuDUypJIEjJWSqo5kc3EsyDSAdC
 Y+wWJTs1fe0gOxIuwtSngPMMHSm/j9WwGBRWTTPr0frfIU8ZCr/xlPQdF+JEaQH914kXoB62OIb
 7gE3c5TbX4IagLOmKy5ats7u8soZJCZYMTgar+UNa8F7tIrDI8t9mvQMMkvhITLFg/e8exJG55k
 LYtBqUzy0ZjjTl2BKMp4NG+qPhhit3BHL8KCL1ROTEqldqTyRKyaUzP/J8lcV463QEzahrg84Yb
 Qk/EZQKSrOBQ==
X-Google-Smtp-Source: AGHT+IEDnRyANtaHKh8jPNevtAf6a59mF2pXBS8id5HAcuPpgh0biXkmSiMh3o4ABDiRm7S3OkPziw==
X-Received: by 2002:a05:6a20:4309:b0:237:90ae:82de with SMTP id
 adf61e73a8af0-23dc0ecda2emr1775262637.16.1753833882712; 
 Tue, 29 Jul 2025 17:04:42 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 67/89] linux-user: Move elf parameters to
 loongarch64/target_elf.h
Date: Tue, 29 Jul 2025 13:59:40 -1000
Message-ID: <20250730000003.599084-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 linux-user/loongarch64/target_elf.h |  7 +++++++
 linux-user/elfload.c                | 14 --------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 39a08d35d9..e99aa3df4c 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -6,4 +6,11 @@
 #ifndef LOONGARCH_TARGET_ELF_H
 #define LOONGARCH_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_LOONGARCH
+#define EXSTACK_DEFAULT         true
+#define elf_check_arch(x)       ((x) == EM_LOONGARCH)
+#define VDSO_HEADER             "vdso.c.inc"
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index eae3260c9e..49fd098067 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,20 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_LOONGARCH64
-
-#define ELF_CLASS   ELFCLASS64
-#define ELF_ARCH    EM_LOONGARCH
-#define EXSTACK_DEFAULT true
-
-#define elf_check_arch(x) ((x) == EM_LOONGARCH)
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#define USE_ELF_CORE_DUMP
-
-#endif /* TARGET_LOONGARCH64 */
-
 #ifdef TARGET_MIPS
 
 #ifdef TARGET_MIPS64
-- 
2.43.0


