Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0861CC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKMJ-00032x-0f; Wed, 12 Feb 2025 16:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKM9-0002xm-Cy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKM6-0000UR-Ic
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:15 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-439307d83f0so1068215e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739395992; x=1740000792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRab0hDnaS4AewVF3P4hSBJEHzwC6g1AT44Nvwa7bNQ=;
 b=ph0VreMv5ab9owix5zqnUwPY3FJqYzYwkrLl6sjsSCg40lm8zBgmUndQ8PSpYapnII
 t8PZNwynaSbSGUifdWoCydfabG9CGcLXcMa1/OhGt6oirRZvdQVOxJjAppOVcpTDVgit
 PMmL66WZegLCa+h+lJVhY7Hsj9bBiUTn5QUgeoxkcPPlM9LsiNHkSYRKhYv5AkTgB3t9
 A+rS9eKSKU8/vJVsMOf5+5C8M+/AiP64J4p58ty2JtHNtd2iumlSg0ENL8gzf9MwEEbc
 pKeU2/YV1MrngWeGzunPNF27fh6i14S2qzx4HSKS3zwdu8N6rnalMt4MrPtueWNcqEX7
 rDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739395992; x=1740000792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRab0hDnaS4AewVF3P4hSBJEHzwC6g1AT44Nvwa7bNQ=;
 b=Wn7Kn/ddNKY53TG2rAD/5lL1g2oS2bv2LRQEW/2qVkXW6R/7aTE6jRKVkimFQD6f9m
 Ba1MxfSaOcmBYQT5RPUXEkmZJRN9nxvYYN8CN6xst31qgzAEZ3D7Gk3uv+xEd/I7In1/
 9BQGX5gYrGjXLUOL9HZ7A/+jJ8i3D8XVDPc1qDslskvRly4sophifZjl9jgjPBenMlCc
 8Y2M13oILC2FgUUsW6glwdoDiySa2koCeDh5ks1dzyj6NIWxQIY8pxVtFWPrOAPEr481
 GbAaxMnV9SyayaXPD7a350QsaMJFouE1Ep6Ebhp8vxvdEmi8plkkn4mpLC4wAab5P8j5
 oEIg==
X-Gm-Message-State: AOJu0YwDcqnFA4ZQyrWjTVi7glYe/AgyZBFWD3HEq6b/xjUvRyHlGqNK
 Im4D5dAuhiIVsMTXA+GfAILWl8gAns+FYbhC9tBhPK7Uq7/nEZDBZU+ygyN2R2pCxvYyRr8e7AK
 pjSQ=
X-Gm-Gg: ASbGncvzXJm8ocYL+t/MIt3YpOSbD9tOTIfM/HYY0QuMg5t8TnNTnmrMUGQ1AtkZNYs
 YVvL38Hnf/8RJY1RPq5rXg52Fu9DAomlMYjzYXTsaZ826OGuERCSYSBC69JeP0hnlKrOIxhi6/3
 Wm9HkZpsjNL2Hf/uAg5rmfcPgFTcFbPncjKgL5WKeHh1yvfPO4shmbRwwgkcR6PLzjw2M+URTtu
 2DUkBa7+9rgI1pCBknl0sbfIF/Vt40COwa2OdilAHU7zYxCBpTEipriXKN1yaS2cbHTA75Xl2bU
 K7VDGJcyHrbVGKP7Qta4ws/xvx3msGUrugOQhldqrsFaKYfX8brl7yArmmaUeSvO5g==
X-Google-Smtp-Source: AGHT+IFPUqhXXf6J4nkRU0xHl898AweZfyqSrFwJnIiuYISnNZc28bwM9XNkKOlfXR+vY4r76nmZ1g==
X-Received: by 2002:a05:600c:1d88:b0:439:574c:bf77 with SMTP id
 5b1f17b1804b1-439601799b2mr10236315e9.8.1739395991839; 
 Wed, 12 Feb 2025 13:33:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04ee2fsm30764105e9.4.2025.02.12.13.33.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/19] target/sparc: Constify SPARCCPUClass::cpu_def
Date: Wed, 12 Feb 2025 22:32:34 +0100
Message-ID: <20250212213249.45574-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index dda811503b5..462bcb6c0e6 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -574,7 +574,7 @@ struct SPARCCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    sparc_def_t *cpu_def;
+    const sparc_def_t *cpu_def;
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


