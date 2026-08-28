Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D631C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0528-0002lB-RO; Fri, 28 Aug 2026 18:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0526-0002if-AQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0524-0002Hc-E6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso11422335ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956003; x=1788560803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5OlP4xmBxJaU39dQm0XttdRoWfw/hb/T/Y+p7JEg/bw=;
 b=OcJRwkITvO+JIvBYo4VsaMYvyjUcQQpJkuDKzUyCdD+un737ufW6gVu6oEKbYvFa2d
 flDEl6PLvvJj8pq8O2vPZtT2nH0uOCTst8n3JiySuwOvIRnNEpcExoWYI8OjRdk5/kKU
 0tTNH4+yToGDlLtcnaUe16nXBwGHijIFFbAL5s+qh3JTuvcFERXqLOvNL4V8TaZlzqeM
 jClmjxqyUycvoOuf9aMH7PaTVn3+Szs/jUsPQGEMoTWanxRDUM22XfaJFjuaY0lIlA0v
 fZCDAve//IFmxriEHsc12yc68rXSNubXRt1XgvUoU1vnunpCBpeSydDzuHtAC9qV1AyE
 X59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956003; x=1788560803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5OlP4xmBxJaU39dQm0XttdRoWfw/hb/T/Y+p7JEg/bw=;
 b=a8kW6Mq0GcE9UKwUxuO1AxTINSq8YZonZaGVNbSn55FTj4d1vlHi5HvaOut+yf39DB
 5oOWtKYqHjKAU5DquYyQiYkYRKZpyonEz0tZhcvSQctKL/KBS3tdekyN1hiPoKDHZliZ
 DA01NzIwv+1jqIbM6b1hiDcqoGliF5tNut4n7IimD2luQn3Ijz9KULiwRtrUAApydbdU
 Wz0S09HZ9qzXNv6FPD7eCliqDoAQoJH3ufweItSafljf1PDJpElKQtLz7VZp+widtECe
 Eaqtbne7ZvwRwunnF0+UzznhVWK3mQys2+d3syyR9edhKLa4LMhfE1V0THM7hwnh6WN2
 JJig==
X-Gm-Message-State: AFuF++kHuROBPB8TVJHt4YeDvSXPh0PeMT5cAk4j8MJS/7CsIZ0dnW0m
 mwlLx2PuWY3X+5EiT9wR5A0UxT/Gyo5+u6a58rTBSCATDYxlDHu43f5mEBK8TyHBkt/evRjSnry
 g7RKFv2A=
X-Gm-Gg: AYBFou3Guq7Awpm+Em/oPWGoU+MBM6/onw+DCsjkSxA0Be218eBc6QHBLQ+cqx29oNT
 kLwc+qBwUZQ/RI2HARQ0sLRdF2ExBR6sR1wLUNPYk7Gw5hdIDsZuwjJX6/IV0lIbHT9XQLhHkhd
 5SICMj+Z7z97hi5exLyqkdRQunKSUIvbGRi+5QfztjkieoOcsVIOsRs9yQuFwqgwV5c8So1qAIA
 ueEFSjBHsJOqxW7cltUHfmQS8DuQ/GbaidboYTga9c6t1lo64Rt194E2LeabugQqekskmYmrUZr
 lq055hrVBxOlum5AJv8q5UGgRnNdWXoKV9Lf8b2UDagMv0i/7C3Ho07PZ45fhX+XGTjuX2q3lm0
 9SZltv0WtwcYpcRDcU0vlCBeP1KH5DTMfKREED7R+obPWX1NBCinGhL5iKafykwNI0Z+7C3ctNi
 oyv6K3dwXRbSh0WE2RjdfiNLazRkYUaCy/DStfSbamqnF5CqlqwPLbBU0b8eePAG4PgUX9Y2Zeq
 m3gRMCTv/sFLvWGqRHi5Q==
X-Received: by 2002:a17:903:f8d:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2d74dbea25bmr205709005ad.1.1787956002792; 
 Fri, 28 Aug 2026 15:26:42 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/13] target/arm: Introduce cpu types max-v8 and max-v9
Date: Fri, 28 Aug 2026 15:26:28 -0700
Message-ID: <20260828222639.1432046-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


