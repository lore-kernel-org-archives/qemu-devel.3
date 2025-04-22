Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AC4C369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F36-0008Er-Sw; Tue, 22 Apr 2025 10:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2p-0007Yi-N7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2j-0005FF-Fl
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso3183961f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333764; x=1745938564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NpcWHK1tlI/Y7pSlo9+T4pe4lo1ktQrN6NqYGtQ1SE=;
 b=xe6EId/U88FHHqAwl22Mw5dptGUH1jKYEZj5F/mhvtSso1CAqZbx5dZSWqxvq+v+PI
 Nww7+nre+fOyTbLJVxZuyeTBB3Xw01s6WVf8nelS0vfqarX/YGOiN541Ro299RCxVpSf
 gtHbhFSqeDAqWEHFITQlzZOT6SvHiWnxc32ORp0yxe4ygK6GeZBKZyadG0CjCaCxlyVc
 5AnhPq8TAbDz/+6mzz6Y+MZv2Zdca3ZG/rPhJX1XN/hHBCyehtfaxtYd9dLEIm/n6Ulv
 z0YGMq01C/IBaDx+YO4lI5WEdjP3nb+BMPGCgQYwktXiIG0cORiAM4JtcoN1vibAYaE3
 Fhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333764; x=1745938564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NpcWHK1tlI/Y7pSlo9+T4pe4lo1ktQrN6NqYGtQ1SE=;
 b=HB4oI5xTDKoZNlJaeEMcBA53d1O2Jf6KufEiFXQO4FI31+tx0pEnVbXvqkjw8qlusx
 KUWgVjKfE8BEfoxCDtnpfVCu9OYjSR/wS23NfkbMqnWUk1/QGmRBtILbIppopLgfwipl
 whimnnFK7XvHcdg2UX5PTg5x4FuU9QiZMOAqQMvfRiVqIdjoh670L5+XhjhFatetNjkg
 A5Lh0I8BsL/Auw9X3WnNKqjeAvoyrZkNf3LCbuXE31jeW6UmnzZBebi+/9ZPpUUv9Rq6
 MoJup140FTF77PumgrOsDQJ02hs67NR5ULH/vO+Cr2fVewoAy8nP5WsGBL0x+KQPa7MH
 oUcA==
X-Gm-Message-State: AOJu0Ywii4kLKfVpk8QHQTUBoenGijPlcGr0bruVAMglnjyjr8XQGqzN
 nZfFp/33C9Ix8iC6u9uUzUAhD3ALRNYlupou2vP0sHnJZncjMPVbGrdKvyuLXguhtNBByCX59yU
 b
X-Gm-Gg: ASbGnct/4UGTdxSbKTRIYHPJ4+v4istu/lDTe/ECA5nU35H0sEqiTgxZE56Cv0bBDF/
 PTa6hJSx6bjPL3k8wq63YoO2wqYN+oC10IsMpon9nz4GylQzBxvInrqbIgDhSxCQt84KD5UbubV
 KzQmjFJM80wmi5gPaN77eeZvXxljKjjAOhhhrH/tn9oxkVgqdZm6YjnJ9EslgCPcR9ep6IssgBF
 zvfK88mA09GvLvcshHXHET+vrrA9dknMfgjQF0oUDgIpDgFqj0l99Q+xOMN4YFRMiT2KkrXHttF
 Zqlo1V6UvaixQP62Stvfs2YpldTPAk8puXo9/UahIAB60M+5kdYmlcTU23dohgqpFVQ0F3wSLej
 lo0ju+U4fv+DsgkY=
X-Google-Smtp-Source: AGHT+IG9TcdlYGubsjEAYNMPzFZ1aCc3hfG277X1loBFk/cpGwotCSMFpnvcrn02gI3mVtvzrJp+yw==
X-Received: by 2002:a5d:64ac:0:b0:391:3207:2e68 with SMTP id
 ffacd0b85a97d-39ef8ba561dmr12801501f8f.9.1745333764633; 
 Tue, 22 Apr 2025 07:56:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5ccd38sm174691505e9.28.2025.04.22.07.56.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:56:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 13/19] hw/arm/virt: Check accelerator availability at
 runtime
Date: Tue, 22 Apr 2025 16:54:55 +0200
Message-ID: <20250422145502.70770-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Replace compile-time check on CONFIG_{ACCEL} by
runtime check on {accel}_enabled() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c6ae7cc1705..d7197958f7c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3134,7 +3134,7 @@ static GSList *virt_get_valid_cpu_types(const MachineState *ms)
 {
     GSList *vct = NULL;
 
-#ifdef CONFIG_TCG
+    if (tcg_enabled()) {
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
 #ifdef TARGET_AARCH64
@@ -3148,13 +3148,13 @@ static GSList *virt_get_valid_cpu_types(const MachineState *ms)
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
 #endif /* TARGET_AARCH64 */
-#endif /* CONFIG_TCG */
+    }
 #ifdef TARGET_AARCH64
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+        if (kvm_enabled() || hvf_enabled()) {
             vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
-#endif /* CONFIG_KVM || CONFIG_HVF */
+        }
 #endif /* TARGET_AARCH64 */
     vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
 
-- 
2.47.1


