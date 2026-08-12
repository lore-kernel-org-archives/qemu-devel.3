Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC40C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFov-0003ft-Jy; Wed, 12 Aug 2026 16:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoo-0003cQ-NR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:58 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFom-0002Gq-L4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:58 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-848643382fcso1430371b3a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786567495; x=1787172295; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ntj5Lj8a29J+b6NyiWqPDRme31w18TYsD1CXA/qiy8c=;
 b=pN3CdeaPokPCqQsaPEaUGFYx7hpvJj4Zo7lBqfWtCIv9rQAk/hBRZZlIy/mUKc3ALj
 3Q69ErgjwROqumcJbJt/ELNKYGN3LI+NckDC9tl9b3JwQOPQm+LFDMkn9/G8Rlt+lMmD
 AyRkP+2mhhZ9mYSrEPHRYU9X1YFsLmmsmDCf/v2QieeyLV37g+2oQGdKRi+6vSJ98iY7
 hGqJ+qUYSlpmF52wUb3NguS8XCRPINagf76OZxub1cJj+k54LY7dddOAI4it1ZEC/Egu
 RIghVs9vY94VRBWNosEDGfmKQ1grNiZ5op+PNw1y2r122+7b9BX/eXg+L7nJP5vqrsfY
 wLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567495; x=1787172295;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ntj5Lj8a29J+b6NyiWqPDRme31w18TYsD1CXA/qiy8c=;
 b=gH+GI75HoMrB0naCQJ+PvzDPKK+xBkn5G7kZdsrQFHf8EFNK+IEFpW9uR3awClDlKo
 rITm+J7hIRAJViPX/kgIDuaNg/9T/XEY+9OoKoeb2+AZaznN75xiMOFZxcn56V/8vfWz
 UT+zy8jiGrCxh4NvaDZUFMNhqzU3LrDxc3pKaV/tuFB6V1VRHWsXtGPsaZUbTWWZAdIm
 FWTpUjdygBafvc8owYrLq1HLMrZ7EVe/NHsxV+phD7ESU641o7ZFN22AAs8fK+ygq3d3
 12Vpj5cENtBTkV43vfe+loBVKk4ucPjxXPLYK+WX/QvlsiFh1rzmGYUJIrcuSvwFcRuu
 0/Ug==
X-Gm-Message-State: AOJu0YzR0TF7TdyEFnsZRluo+veyaGC6fBCGnmabzui594iLgCa74F1z
 JyMPEN0It5RwWs27275OQvLgPJ+By7luobi+dJe2BCEQn6WR1rQqyCe9tm2ju8A+Ijo1+StH1Ed
 PO744
X-Gm-Gg: AR+sD10/mHC5QFmocjTyDKMyym2XMojh8dPNd3STkWC0gf6M+FghH5Rz0/48G5JcFI4
 6wvhV7tdETx8ZUXQRA+tDWyFNaPEFkKESLAA3aBvj7RG2GjO9BidLp0YjivnosxAydFE1MIEx3o
 +3za/kPoir6c4pc+gjOaJzg1LS0pAa+B5OCdrG4UkAS1klCxXrCxOsr1a14iJszLD2Mt2hPGFPP
 eBKZ8fNt4dazAPsrhG2+8kS3K+dDJiDzXovH8VyGz0poN0piUWmteEnlT4DALzU3H2Mi+crVwx8
 g41e+3N+k8fMWE7aeYy1EIxPP+SKX6gCz6gziQJ3bjGoPYZHcr6LQg+OmsPyLWTz6fquU54EKe/
 XxEc7k8Cdf3qygZ7CBUvIKSwFQJ4a8DnupMrxK/256f8PY0BjHz1T1p7tSUbmX2X2374R3AIScO
 QK9av2NfcrJu7qtH+Hje1/8QaFT9fRRUIAGoqfKYOtVBO91lQRDSGJyoqHpThbf1eRrTz116I6q
 lQSPlzdAmCAsxVuR5iL
X-Received: by 2002:a05:6a00:1da5:b0:842:708f:39be with SMTP id
 d2e1a72fcca58-84fc744db5emr588175b3a.5.1786567495228; 
 Wed, 12 Aug 2026 13:44:55 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc4787325sm125308b3a.23.2026.08.12.13.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:44:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 07/10] target/arm: Introduce cpu types max-v8 and max-v9
Date: Wed, 12 Aug 2026 13:44:32 -0700
Message-ID: <20260812204435.295067-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204435.295067-1-richard.henderson@linaro.org>
References: <20260812204435.295067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/sbsa-ref.c      | 2 ++
 hw/arm/virt.c          | 2 ++
 target/arm/tcg/cpu64.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 484b90053e..56d08f605c 100644
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
index 219597cabd..34cab9017c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4143,6 +4143,8 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v8")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v9")));
     }
     if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5649b853a7..967cde787e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1463,6 +1463,8 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
     { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
+    { .name = "max-v8",             .initfn = aarch64_max_tcg_initfn },
+    { .name = "max-v9",             .initfn = aarch64_max_tcg_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
-- 
2.43.0


