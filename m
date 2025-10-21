Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19205CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJb5-00023L-LK; Tue, 21 Oct 2025 17:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJb3-00022q-Qy
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:08:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJb2-0003Ur-2H
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:08:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4710683a644so2665205e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080922; x=1761685722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hifM9suh5wepCIBGkBJ4va7j8JgZZOPIRU8jpQmVeDQ=;
 b=owm2cmiWPGJcB8tuF/eiKaLiHnmV+SW4/GkmeEHpQU4odaXaQwa2x12hk6OA7cHNYP
 TZv9fNeYDCr3n/+ZyJFwLkIRhE92WlO54zXO0yIpsZrXPReOjfx7UQHgmcdLJC2T3ofH
 UBi3LXl/DvXMu5r8kOPT5+SRQUXh8qAw/9TjyM1dzu/eum4UKLEbPSh0uytiBD/KI6Nj
 kyTWlGHqkmov2Gl4sCU4It7tJEn6T11R8ZfDEb+9vuz/Kq3oR15YYK5rpNlVuN1f2GmR
 dmkkCuEVMjfOHrLbe3RV0A4M8E02MI4pAfL7L99MYag/iA7YZ7rc+pEKfW43jWxu6zkV
 EwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080922; x=1761685722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hifM9suh5wepCIBGkBJ4va7j8JgZZOPIRU8jpQmVeDQ=;
 b=kuY4jQ8O8JE0xjwGREleKG6eIYhbDzztl8pzIKAkXwYf2WYJHdJLc9weGgfbEQx3dX
 4kzR1LBeGRfrApDBbcKTsKFdwhlgo9sAQdlFDZe4WTjJ9sOmUeiUwHt2gjE+6dbpLxCC
 cRs9PN0I129C5L2qZp2icYRmRrtmyG03EaMzenZyxsa2cGmK9G6HfZ7NjvbwZojejEP5
 uvwq1edKNxqqclpS51aacIoPEDrr4nLRQgw4F0Qwo3NchqnlMI03ZFfWLAXAM6Pwp4zc
 +NQBEkgytrZV4Fy4zTbruGa5ONVg8JB44AfrKJi/RPdhZQzIDLyv8OqVEPlYnADnhdt8
 PqhQ==
X-Gm-Message-State: AOJu0YybfXZKi1yfhsD8oYHy+29O2HdFb5pRzQgP41Px6STa2Hsyad9G
 AugVIf4xj8Y/96sKDSJboDPbGeq0uwIEWeChwWq7hhJ58l5Vd0Fe75kA6i9FCPsKklwFPaPiYZW
 6coHMvg4=
X-Gm-Gg: ASbGnct9A04WDbph++cS0bKpNuFqXaGQulfeDQJNPhooy3UdEvD6UmbbagB7CPZ0NRs
 BrcSj7bMJSUQBMsVPKqCRMr7RdnHfOi2S/cSBsC9RezI6/K/PUFBORwGhq8EXJy0/EsCgikTnWU
 9tRQ/QeLfwiieOHMITnq8gB+Usl50X2hJTMuN44bANhn9ceNum6fTcklq0E2Jz86O2xgcI7HPG9
 JrsktoEvxOJ/bA6bKdg8xCxKO50ZCrQsx4Hxq+zZZ/g2z43fP4VVcWzBpRi5Z8WaeP9GoMbz7gz
 UanYyiwHYRlHnhry8yMs5C9rnD3u8uCK6bUfJYFrjg8l7c5NqSbhkSUHRhdXf/oinJCWJl9xCp5
 gcc0DvbAj+7q/rZ0nZTgcwUVhYqAdHVHGsis7eGAzv1jFfavnZoTJjew6ZU2tas+xq6lui6TLsT
 g/OxPIkoUaNOC8g7rDnpje7byqTL1CcgdGhYtoYbRX/g+OUMFUNo03qI+2bkJV
X-Google-Smtp-Source: AGHT+IHiJ6gWSGX9dxB/4cDK0LmvxzVKRxL5MLdw1hZtM1m+eAyyLArDp7nhGaHfJq3UlOaiQYYrBA==
X-Received: by 2002:a05:600c:859b:b0:46f:b42e:e362 with SMTP id
 5b1f17b1804b1-475c3eecf03mr6775975e9.19.1761080921732; 
 Tue, 21 Oct 2025 14:08:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c429e82dsm10452275e9.11.2025.10.21.14.08.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:08:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Luc Michel <luc.michel@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 08/19] hw/arm/virt: Check accelerator availability at
 runtime
Date: Tue, 21 Oct 2025 23:08:39 +0200
Message-ID: <20251021210840.60112-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

It is not possible to call accelerator runtime helpers
when QOM types are registered, because they depend on
the parsing of the '-accel FOO' command line option,
which happens after main().

Now than get_valid_cpu_types() is called after
accelerator initializations, it is safe to call the
accelerator helpers:

  main
   + configure_accelerators
   + qmp_x_exit_preconfig
     + qemu_init_board
       + machine_run_board_init
         + is_cpu_type_supported

Replace compile-time check on CONFIG_{ACCEL} by
runtime check on {accel}_enabled() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e19da6fd901..d3809754460 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3260,7 +3260,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
 {
     GPtrArray *vct = g_ptr_array_new_with_free_func(g_free);
 
-#ifdef CONFIG_TCG
+    if (tcg_enabled()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
 #ifdef TARGET_AARCH64
@@ -3274,13 +3274,13 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
 #endif /* TARGET_AARCH64 */
-#endif /* CONFIG_TCG */
+    }
 #ifdef TARGET_AARCH64
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+        if (kvm_enabled() || hvf_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
-#endif /* CONFIG_KVM || CONFIG_HVF */
+        }
 #endif /* TARGET_AARCH64 */
     g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
 
-- 
2.51.0


