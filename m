Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D659CC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRXI-00078L-Dg; Thu, 27 Aug 2026 00:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXF-00077M-LS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:17 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXE-0006SV-1q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2208877a91.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787804174; x=1788408974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d9vZmtDzK9BaCqOMKO6CDu9rwbtI575ats31dCsjvHc=;
 b=JH1LXxyn7KunOxEQtBNxluF6pXW+0QSrRixXPchOFnfPVb4o5/1hZTbSXRlPAKuXf6
 ymJ3YXnRoxF49GBzONc7YAet+bNuSAmRz2GVHzMC+ZIia/1rDCw2gFjaxhKqrbn+dNjp
 1MCITE3JC/AzSbodl9XH1hXnRzA7YftH7+GFFeJBAdgIXT4GBVe+qp7IGUzR3/GJAY5t
 CBFjqzgssjdRrcen3GZntjbnLTjwtNjr+5C+3PQ83Z4YRc+2ouS9WYzQ5XRrAefteB0O
 vHzP7QVt0TFiHKRsnfTm69v5wv8EhNAyw6p1rTVi0sHNW6gLIV6LhpENb9gnxhXnMCZ7
 u2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787804174; x=1788408974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d9vZmtDzK9BaCqOMKO6CDu9rwbtI575ats31dCsjvHc=;
 b=UBxKfELmk3CpztZvlMOHSXdIFBaLM7KSQBZOBPRo6rfwP9c7tyPPh36l6TgxzEagnw
 tMC7/7o9MRe0iNpuK7RzoU0c6ua0AK6HPoqfllpW0o8gx4r2vs2vqULzyiFmM240rmDZ
 EHqtiGLk8HG67DpeOJhBO878xNbSf9Zdj5JxQ3gsc/kAkqxAKydPmF+GeJTX45b9+1i6
 UtgrJps4aHPFR0sM4aY8XtMmcji0J7lKjpsH1ZhFoUOLYMivKCNliCBuBAHXjugKKpaQ
 weMSJQTMPn+dJRrYRFUQugNBtwPvzgb31wOlW1MKre0Rywutj1BKhRmUyyayrAMPpa0F
 PXeg==
X-Gm-Message-State: AFuF++kO+EqW4tjWYaU1UP94LTfoXOgoxpKce0y4ikt9BeLBOuIh6/UL
 +mVcbvMl/0v49zJ16UEvlYDu+5aeTKFgFNqP0YLCJvJyg6PsLz0vUCFau9XzEw28Wm5g88iEVX4
 3xfor
X-Gm-Gg: AR+sD13XBssn76CtmospvBxbTERsuo3akPvjvZoir9HwK+t7TMYKmb+rXtWdCtJcqAx
 D65jDn/6ZtsjSFIdEdh53tj+6o/1MVJJv2FHW15p90SIAMlOG8C5j2lwh8W1BIW7aVYLJsp4FZP
 XICLCg47ftBX0iDaw9699Bp5u/TTIBmeEvfpwmW1Ec0LlgpM70r8wB2nD+CA8DgcVMCysdiDB1Q
 3lFZW7qY6MW+RQOjNg+k4mP4bwK7sryZvkRDmgrUkbQi+4tcoaeU54z4s8Jgs7RYZkAI31Fogom
 Y/jkUtOnZGbqKlF92AYXpRsotCs8o4dlUN0jhgRN0LXlVPTVUlq8D2p4kXNRlEuRyc+suZzVlW8
 bvm+WNe66gwa6IQxSbz2O5aZ/s8q0i2YNO9WARCLUpN9jCyiLTn88oPs1HhrVs3jZ65ryAF9gxU
 QyAm9PJm6Zd03BOIFNSs9dqEAPYoYSmO80bj+27UdTS8fdYa0amxtrcWoqkKjwtsiISpDr253KR
 NTaTvSClIbxDU/XC5E=
X-Received: by 2002:a17:90b:180d:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-3966d8e0f37mr23232769a91.15.1787804174487; 
 Wed, 26 Aug 2026 21:16:14 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d81682sm969597a91.7.2026.08.26.21.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:16:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com
Subject: [PATCH v4 5/6] target/arm: Use -cpu max-v8 with aarch64=off
Date: Wed, 26 Aug 2026 21:15:56 -0700
Message-ID: <20260827041557.775080-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827041557.775080-1-richard.henderson@linaro.org>
References: <20260827041557.775080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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


