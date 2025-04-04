Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EC1C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pds-0000l4-P9; Fri, 04 Apr 2025 18:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pda-0000go-Ih
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdW-0007yX-LN
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso16345105e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806140; x=1744410940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aHt9/+1RoqryMMLez5mxrSk/pFneV/cWior93LSBnc=;
 b=AzT2wzdkO3qmlEvkELkkuN4+Kumj6cWg8vPgCyPIX7Io6k3AdqzuuVFSeMHwj1hQPe
 yVu4sQ7E2Le4twErr3CmCvabzKMcuh8l/I1L8Xz3CGLUCnwRWeD4BWqGKXstNMsY3eaM
 lsJ/es98ZuQkUQwcStlLNhHi+Cfj8Rr/ksE9czUngnvfPwlFr+f47cz3xVj1YaXCMxEp
 f7p+B+RUzPpwarE+oZsG9hIzbcJ8KK2ssDEI7ukspzeI+KA6a5xBJALeJguius3aVNY1
 WxXI77B1hrADh1BDb0Mzu284CgWwEPTyeavYWsLaeofKaxcy/x1jUoE6R+SXowo5GmTD
 Dkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806140; x=1744410940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aHt9/+1RoqryMMLez5mxrSk/pFneV/cWior93LSBnc=;
 b=Dk2lr3Gi863/kaNx810tVH0ltII5ABXQPgSV3aXtfaJ/qShHhxiyf+2GKco8kzYJmB
 +lHw6QFqGCAN/2HznD461Zj+Oe/LfBrFH0lE/e/NUfNpBCsDzN9D8az8hOLsXoPRTNv9
 QW+B2ktmgBocHt22Oi0v+s1t4mXb6rbC6L4x8SzJt1RMajxahuAc6OQo89F5LeXf/lzH
 IptEYu0awNMg7rklFDtcQcQ5EgZOv2OONm7A7h5iS0DoHy+LFHrkR3Uo6/vP/TsBKeo+
 1ZMZNRskREzFRM/Zboe6pMcL2QAJ4Rs+2/5w7bRji48p3dUpaquiifNGDta+nodvRpGd
 Qwhg==
X-Gm-Message-State: AOJu0YwnGZLL2N+fIj/eDiqNVDRNik3BU1JTrve6KPaodCfrMfvL/zpA
 6uogSGP+XfbH0qgCz08/DyCs3igv1OuhQWjXeZrVpXoVy7hD0eDBEPy4B63S+rAv5FicIJwDwDz
 n
X-Gm-Gg: ASbGncuNsxCm2Z3D0F1aM3YyUwfuM48VU1gC1Wkgh3hg6PFNjnoMy34nffx9n2iAWuO
 JjjtRqKCom3Lr/5gUK4YUEp1HnAq1BHLFdzQjrnREb7j8czylC0y1fyyP5vHvYQtQBr4ARtnkRm
 ppCpFc2RJqWE1zFjGE+bN5jp0O3cRQgYMNkN79qTF2M+ZCjPF1CF+rQoACDrAjN+GaJp2WmbumH
 KmU3z+JHysrek/KwFolYZxtCMEVDWqGNJrsYH01+d2xl13KE0X4/YgXtepfJOSGMoiTsV4BpGv5
 ibKp12iIlUuUd7zSgKvH82YqUfBkBFnOEchL6BxaZdEC7DNLLYNpy13QCOtDy8X7xDzK8WgARGb
 yQCYY01rDTkj20FdU94Ziartl
X-Google-Smtp-Source: AGHT+IGY5N3blidZWq1yLJ/x7LLJTJQ8O9dacZzGNjQpzlIco5pH3CCHtEorFuricFu0h1ERBe/M9Q==
X-Received: by 2002:a05:600c:3b07:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-43ecf9fec44mr37994195e9.21.1743806139405; 
 Fri, 04 Apr 2025 15:35:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16313edsm60101395e9.6.2025.04.04.15.35.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:35:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 3/9] target/arm: Remove use of TARGET_AARCH64 in
 arm_cpu_initfn()
Date: Sat,  5 Apr 2025 00:35:15 +0200
Message-ID: <20250404223521.38781-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Introduce the QOM arm_cpu_is_64bit() helper, which checks
whether a vCPU parent class is TYPE_AARCH64_CPU. Use it in
arm_cpu_initfn() to remove a TARGET_AARCH64 definition use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 95afa9b72f1..ef95f31f249 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1471,6 +1471,13 @@ uint64_t arm_cpu_mp_affinity(ARMCPU *cpu)
     return cpu->mp_affinity;
 }
 
+#ifdef CONFIG_USER_ONLY
+static bool arm_cpu_is_64bit(ARMCPU *cpu)
+{
+    return !!object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
+}
+#endif
+
 static void arm_cpu_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1482,16 +1489,16 @@ static void arm_cpu_initfn(Object *obj)
     QLIST_INIT(&cpu->el_change_hooks);
 
 #ifdef CONFIG_USER_ONLY
-# ifdef TARGET_AARCH64
-    /*
-     * The linux kernel defaults to 512-bit for SVE, and 256-bit for SME.
-     * These values were chosen to fit within the default signal frame.
-     * See documentation for /proc/sys/abi/{sve,sme}_default_vector_length,
-     * and our corresponding cpu property.
-     */
-    cpu->sve_default_vq = 4;
-    cpu->sme_default_vq = 2;
-# endif
+    if (arm_cpu_is_64bit(cpu)) {
+        /*
+         * The linux kernel defaults to 512-bit for SVE, and 256-bit for SME.
+         * These values were chosen to fit within the default signal frame.
+         * See documentation for /proc/sys/abi/{sve,sme}_default_vector_length,
+         * and our corresponding cpu property.
+         */
+        cpu->sve_default_vq = 4;
+        cpu->sme_default_vq = 2;
+    }
 #else
     /* Our inbound IRQ and FIQ lines */
     if (kvm_enabled()) {
-- 
2.47.1


