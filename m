Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651CCC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0528-0002kN-4Y; Fri, 28 Aug 2026 18:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0526-0002jA-PZ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0525-0002Hp-30
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:46 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ceab75934dso16266695ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956003; x=1788560803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d9vZmtDzK9BaCqOMKO6CDu9rwbtI575ats31dCsjvHc=;
 b=l0XQNT+u2IN0BmRwE2qWZp+h5utV91Gk2S5aOfbpkR1OlYGpkeayqEkHVwuvZ7iUkK
 2MzZrHlulqGDm6cnRltzt/DC++IA3W6lr/BjxQrwjAafr/2C98/JLDvPiVBRRI3Tdqcb
 JuaVQ3EI/nGJIaKUkIap5Kh1QTNLVAQNGqPj/lLo2iI5cDIOSxRlgynNZWXdxZ920alG
 k8y2LjrCAafyeRhpAFsqmt6L9/jUHCpowcHJg7BfWNnsXkWG3j7hfMkDoY1w1QsGyGqq
 3NDrnu/9ybI9TDtXWT7HHuhS9Lzym+foXVTTWmh2nG3bKnsNpNHrDfdEhV5XKO73nhDT
 XyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956003; x=1788560803;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d9vZmtDzK9BaCqOMKO6CDu9rwbtI575ats31dCsjvHc=;
 b=Q1Q+ZjMd3h+/XwonWuFen5q+DiB37ltoBcnxOciCSy39P2pk0W50CQzkjfjcPCY5Xl
 uWFqbIM7CgygswxSxUIrwkbPEcPYki9yKdMGZjS78NdnVv4xbf44FG7OHxzNnPZ3EJFP
 otZC+kXqlJ4uaMNLOHXPdOUeddEVYSHMAPTMa6cpAoY6VejV4S4ntWoYawbE0skvHpSE
 2AsrQMyJemwHE0lmrdlmlDWnyOe9ofur+TaqjxkzZJ15ypvx2M/fnZq9ZLwp//ocsP25
 O+6FjZfStUAHBl5nNCyod/80TETKWOzl0vLVs+WXOZi8TwfTmtHIxXx6MYcBu+aqFJ7A
 mNcQ==
X-Gm-Message-State: AFuF++k+kPYRVH9gyXsz5y2OyrHDCOIBDz9btQmWxoTXAjK2aOro0m9p
 jkdMG6BCWThLA6jYNvLNxdgeSHwVaU8VUgN0Ta1ujcHEObfvpp0fIXcNsfnkbHvDT6GMwnQOer6
 SuD7aO/c=
X-Gm-Gg: AYBFou3XjBufpC9Y8Lc09e366NHudmG8hKyPILZDhifI1C6rIZD05cicThdfbQSdlZD
 ZHy6yNFojuseXrtEBp66KGjueqGwKiumlRFz/iq9VO/2dN+IHENmD9+5DpL0XbxzdTpUBj+jVId
 zjiM9lwsYQNm1sRW+q/a7p4ly7pg7j2rSur7zWruX5YvGvSoeLQ0hHlI+6DM/4IEPByJUTJTozO
 IwWtqYkp8b13BF6JtrtYLuddw4zVqt1FMNOJClEf/F2OIIumupWa9RGtlVq3J03EpJ+g+HbCrD1
 2cAwSO4+oJzwpoCTMJuNJtZv5Vgdx7DeiGT+1wEUUcfRnqYHS6WinDE4PrsARL9vwGq2IsUmNsQ
 kCWFCoDWs9o8uMIOC39e5cJIMRR2W3G3eV+ycwtltlsV/uf8JqE6Uv6ob62M44XrWRGlUWgiKYl
 AUxoXGPkkPHmRx62vhY73H2GMoFMzHO6iwJtsKZgAmT4z+GLrBM84r099T3PCs9LpiDGr6uDbfN
 aXQ1nRqR0JxMG7evY0H
X-Received: by 2002:a17:903:4511:b0:2d6:ede8:51c5 with SMTP id
 d9443c01a7336-2d74dc83cd5mr150243015ad.6.1787956003552; 
 Fri, 28 Aug 2026 15:26:43 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 03/13] target/arm: Use -cpu max-v8 with aarch64=off
Date: Fri, 28 Aug 2026 15:26:29 -0700
Message-ID: <20260828222639.1432046-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Armv9 does not support privileged aarch32 execution, so
aarch64 cannot be disabled.  These tests must use Armv8.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qtest/arm-cpu-features.c                    | 4 ++--
 tests/functional/aarch64/test_virt_aarch64_off.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index cb4d01fd46a..7348fb8d28b 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -493,8 +493,8 @@ static void test_query_cpu_model_expansion(const void *data)
         sve_tests_default(qts, "max");
         pauth_tests_default(qts, "max");
 
-        /* TCG allows us to turn off AArch64 on the 'max' CPU type */
-        assert_set_feature(qts, "max", "aarch64", false);
+        /* TCG allows us to turn off AArch64 on the 'max-v8' CPU type */
+        assert_set_feature(qts, "max-v8", "aarch64", false);
     }
 
     qtest_quit(qts);
diff --git a/tests/functional/aarch64/test_virt_aarch64_off.py b/tests/functional/aarch64/test_virt_aarch64_off.py
index 13d8b73b0d7..73c9a4109c0 100755
--- a/tests/functional/aarch64/test_virt_aarch64_off.py
+++ b/tests/functional/aarch64/test_virt_aarch64_off.py
@@ -18,9 +18,9 @@ class ArmVirtMachine(LinuxKernelTest):
     def test_arm_virt(self):
         self.set_machine('virt')
         # KVM aarch64=off requires a host CPU that supports it, so
-        # restrict the test to TCG only
+        # restrict the test to TCG ARMv8.
         self.require_accelerator('tcg')
-        self.vm.add_args('-cpu', 'max,aarch64=off')
+        self.vm.add_args('-cpu', 'max-v8,aarch64=off')
 
         kernel_path = self.ASSET_KERNEL.fetch()
 
-- 
2.53.0


