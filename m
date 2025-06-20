Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A62C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk7G-0006dZ-J1; Fri, 20 Jun 2025 18:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbt-000817-2F
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbp-0006dd-4p
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:04 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so1091983f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440776; x=1751045576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nnZlnXRKjQXrkBDjQnf8kGFKGjqvBQ012k4MaDR8GT8=;
 b=lg+4QrrpQ91I6Zty8HawsJMp/ypLhenNaOn3cTvmyUqP7g0HQAVM6tfund5xzitAaV
 Se2q2aAQ8u/L09vztaJLXhn0YkS8LtCpS+Qxr19hKUOD8XoicBfYfaUvExYmYWmyAp7F
 OLvB/aN7MJkujLFNmVzRJk8n6UyByAnMK//Xr9h5yySteiEBromHS5JiwSM9C3G85hs/
 pEmgkWb4ZnBJ60nlTkD9l/J602hnU709GQs2fl/dxp6jIWByzIOmHoXVNicD+Lp3Ix32
 s0Df98SP+BO44/WCTzLGvWvmfLBe9hFmBXDWFJiZ2t5y1ijmwnT/Arizd6oIezbfX674
 76Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440776; x=1751045576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nnZlnXRKjQXrkBDjQnf8kGFKGjqvBQ012k4MaDR8GT8=;
 b=qI6XawDtOd+cyPreu30cSQwKqs/c1G75ifiNkhoLJ7cOa2rbfTHIh5VXl73lExjyne
 szMj9RbNBlGIBDGVUJh6tD2lyrcAGSE+C+1uYPOZLwNWzhWl0c1RjHnZ9DfoQjPDNJPe
 pX8WEmQxCGy31PgC38wjgF0NJwEHVgWNFSKNlcaJhjJ/Sx1pNyDnHGosJCJMXlgYy8xY
 nfxxn6L4jDbQHaDUjRUBMtfspqAds86ul2TzLhBo1LbP69T4FXlhUuaI/JP1EImADnsP
 vwr9aTSv71MlNV/Guk1Xt1+xXggyCgW77RysIFr/JdJcmguCwMpw6k/PLEHOFOyF0LqO
 uR/A==
X-Gm-Message-State: AOJu0YzsXa39kEm/2h1+mZ8HO3UCpg0YJ87fS9pU4OGL01jKSjcW/pAa
 evxx7Xozwq+EMUvE6eZdZH9nK3d4UqMgyoH0Xnyyl73noJBQZ+Xw6kKpzAi8wHnHDExpZZA8x52
 +2+kEPAcbEg==
X-Gm-Gg: ASbGncsMIw0lARTaupIKiHQFvBU6FvSlemv7gjtZWlhMIgyBhCgmQRzAGa8lqTwYwvW
 VQ41mB26CIeSJexAq5pWuc3ElwMa8iU1mI44Y14SYp8KZx39ikO6xJAGbCBt5kPQqi/7H90sixN
 aK8q7hmUq1QJrQquxrp1DKyen8unc4d9pvsuc2T5Cen/1hceZy0+iI1nT81s6/G27YHezBl7NKN
 oklxNYcB7odip7E1khNHrUriW2moDgco/efnd3ELDjokLsnMW02VkI308D3V05LdRkmTh42XyN5
 A9C7Jmn7YdIxo9sZ0lnlvEM/Xlz6Hsd2M0DB0eCRo2U0li5P85iKTISb40IQa4M9ozyYtWYCuTf
 gONmScRuPcrS0BKmaAAxNfjCqYZv2ew9idxsBoJaPqBGYFkZNUDVMaal5
X-Google-Smtp-Source: AGHT+IEgGgGTQSRcp9s9ssjAWl+nH3wErM3Me2fOBsy2cNBRCH6J3NvQjTr+L7988AH/gYlEQZz7wA==
X-Received: by 2002:a05:6000:4284:b0:3a5:2f23:376f with SMTP id
 ffacd0b85a97d-3a6d129de4cmr3512634f8f.13.1750440776403; 
 Fri, 20 Jun 2025 10:32:56 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1188017sm2642772f8f.75.2025.06.20.10.32.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:32:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 35/42] target/arm: Emulate EL2 under TCG
Date: Fri, 20 Jun 2025 19:27:43 +0200
Message-ID: <20250620172751.94231-36-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

When using hardware acceleration and TCG is available,
expose EL2 and EL3 features as available (they will be
emulated).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 200da1c489b..b5c2796f3a1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -738,20 +738,23 @@ static void aarch64_a53_initfn(Object *obj)
 
 static void aarch64_host_initfn(Object *obj)
 {
-#if defined(CONFIG_KVM)
     ARMCPU *cpu = ARM_CPU(obj);
+#if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
         aarch64_add_pauth_properties(obj);
     }
 #elif defined(CONFIG_HVF)
-    ARMCPU *cpu = ARM_CPU(obj);
     hvf_arm_set_cpu_features_from_host(cpu);
     aarch64_add_pauth_properties(obj);
 #else
     g_assert_not_reached();
 #endif
+    if (tcg_enabled()) {
+        set_feature(&cpu->env, ARM_FEATURE_EL2);
+        set_feature(&cpu->env, ARM_FEATURE_EL3);
+    }
 }
 
 static void aarch64_max_initfn(Object *obj)
-- 
2.49.0


