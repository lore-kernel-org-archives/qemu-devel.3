Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC535C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyik-0002WD-QT; Tue, 25 Aug 2026 17:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyyif-0002Q6-NW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:30:09 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyyia-0003Ln-6W
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:30:07 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ca80d708489so215524a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787693403; x=1788298203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5OlP4xmBxJaU39dQm0XttdRoWfw/hb/T/Y+p7JEg/bw=;
 b=lDCHs9tNHfF0VkjO4uDKZLwYBquXIbxl+mB9OF2G38GZWTwmBfu2mZaf0/5ez+p9+o
 /ytGDMQVFifZSwRjfrtweFmybTVrUvUbu/HOAGNhQLGVElr7JHd6ZPIfGUTtHDlc0ba/
 Gr2XMK5x38Erds0Ks6RnoccfreFPla6d7qT6HMeTfdoely6O3lJtD1s66aZwysnL3RiC
 ypjo3Dfdi600yPaKKQy9NSdWkvZIEYVE+FQ2bpxJFBrmdk6FZs8n2CTRfpHNdm3mKUKF
 m/3y04bZs/V8ixfRTwut/aUrbpp6TPN49MRVRaRVa45W+EKJggKoYxhKjncrKK2goFt/
 qcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693403; x=1788298203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5OlP4xmBxJaU39dQm0XttdRoWfw/hb/T/Y+p7JEg/bw=;
 b=LkYFz8P6v8yBPM2wOThw0SUDRhoZkxUYQcRWiCwpFkx/1A0Kduynp7obuNW5Ea97WU
 KeqBELRE7Iki1LY57+qvLzb+170YhDxqxhcoNVVow3TWp9fCgOwqg7uKfihoaRLHOC7j
 ehDhF991HSYCxkrqv5831afW0EVgdCI9cHtBSi3f9r8lVzLOmfYRGWV1RaGn5NUMJrbS
 BLBvCtaEXngYOENHEiMHXABQpCHxyoQJhq07Ywj/LVbh9ycO6c1/qqPDJXCBlzFkrOGR
 o4rX9ikF949a02+sGGDfkl+SoCfdSoLj/kMAfRMeOs5cfxZatgFo0DzjnEB1r2rgzsZv
 byMQ==
X-Gm-Message-State: AFuF++l6yAUuFajlc7zD0iMZF5M2VdCkUcxMfc9uRDpC6XI63CTwcF+7
 +0WNb2hSQJCrKzd1qoDRG1OkjhN+su99GaFfNgDGVwkerCf2A+v7gD9BZ4i8BbekjLtvjzVkTtr
 7JXJp
X-Gm-Gg: AR+sD11zbU747FmJgsa2w1nr9AyPC4i8oe0M+LIlCqa79kVWPgMD7TvL5eFp7oXVD6V
 PpkbCLrnO0sG8ChCF8JyXP5FNRRrKZXpKqfy6VsT1TfW/dWlCKXXiIjYEWxPSkXDOSZtiSY5Scw
 OGOn8B4/ES5j1H9CxgXdtj2fOK20lgVB9Tjg4a77mf48Sy4rsII+0wvV/guwjYlTAC4MKxxocN6
 Lgzq/pidIIcGzxCqASkc1vdPiB4Wc/+YXd1lDkYND2sUkN2OMq3PHz/WzwSc3tcpI4NbgaL3jZH
 UIVEJAOhPrQFI7fPBRWcIBt4EEz94utvpM7jo1etWIXEQJUF3x6JHjJcZX5Zrg619DlXcNtounz
 0D6WCb/pr1KlGlWHu3oyg6jUto1pQ/HouWnP/vWZ37LeXH05BjezmrgJU9Q0q5pNtvtAHEG3SdP
 Wyt5Qr3Yn5kuwmOhhlcEhdL1Bvo6BhpY08R6S+JOpvXE+HLfRyiEzE0G0S7bpwf6r1w/U4y1CQP
 AHBO6uwKVbAu7m12w==
X-Received: by 2002:a17:90a:d407:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-3966d8528c7mr2200439a91.7.1787693402688; 
 Tue, 25 Aug 2026 14:30:02 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396689fa52csm1207163a91.12.2026.08.25.14.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:30:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 2/4] target/arm: Introduce cpu types max-v8 and max-v9
Date: Tue, 25 Aug 2026 14:29:58 -0700
Message-ID: <20260825213000.221822-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825213000.221822-1-richard.henderson@linaro.org>
References: <20260825213000.221822-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Introduce the names and allow them with the virt and sbsa-ref
machine types.  So far, the cpu types both exactly match "max".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/sbsa-ref.c      | 2 ++
 hw/arm/virt.c          | 2 ++
 target/arm/tcg/cpu32.c | 4 ++++
 target/arm/tcg/cpu64.c | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 484b90053e8..56d08f605c8 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -913,6 +913,8 @@ static void sbsa_ref_class_init(ObjectClass *oc, const void *data)
         ARM_CPU_TYPE_NAME("neoverse-v1"),
         ARM_CPU_TYPE_NAME("neoverse-n2"),
         ARM_CPU_TYPE_NAME("max"),
+        ARM_CPU_TYPE_NAME("max-v8"),
+        ARM_CPU_TYPE_NAME("max-v9"),
         NULL,
     };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e7a56e37f73..d738b95c726 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4132,6 +4132,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (tcg_enabled()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v8")));
     }
     if (tcg_enabled() && target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
@@ -4143,6 +4144,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v9")));
     }
     if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 8397f26a864..12e70ded9c1 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -744,6 +744,10 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "ti925t",      .initfn = ti925t_initfn },
     { .name = "sa1100",      .initfn = sa1100_initfn },
     { .name = "sa1110",      .initfn = sa1110_initfn },
+#ifndef TARGET_AARCH64
+    /* For aarch64, max-v8 is defined in cpu64.c */
+    { .name = "max-v8",      .initfn = aarch32_max_v8_tcg_initfn },
+#endif
 };
 
 static void arm_tcg_cpu_register_types(void)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b38c61ba623..4f5375deb25 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1488,6 +1488,8 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
     { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
+    { .name = "max-v8",             .initfn = aarch64_max_tcg_initfn },
+    { .name = "max-v9",             .initfn = aarch64_max_tcg_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
-- 
2.53.0


