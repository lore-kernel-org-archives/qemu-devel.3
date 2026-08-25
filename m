Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A842FC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyij-0002VC-MD; Tue, 25 Aug 2026 17:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyyif-0002Q7-NL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:30:09 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyyib-0003Mn-NQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:30:08 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so494154a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787693404; x=1788298204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d9vZmtDzK9BaCqOMKO6CDu9rwbtI575ats31dCsjvHc=;
 b=mWdFgD+WEu3a1bKrFBet41IYdt87ooZo7OfEPoaQlXGUxZgqO3Wk9R6Us3hlpGpU7H
 9m9ohmzPhT72pmz1H3DiD4U5uT1Jol/Bpq6S9D2AuPMVylr1mXNx0ld3hj1o/fWloN4z
 /b/Niqxz06/wY5LDiRRDrG3BlHFmmzOszWP1qDijJKqLg1ZhyF0uXbziHgDwB1Gsualz
 Wxj7cgmFgcOueWt06DL3M8aV3sQj2d4mKYG2G5GxTm3YdYc0C3DmMHsI+aMfnEODed96
 Tg1xmpUzuUzXujjh5YCihOebO3LTUKvKE3v5C59cPYOzXEF9KxEKrelUswdHynGre8NY
 piNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693404; x=1788298204;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d9vZmtDzK9BaCqOMKO6CDu9rwbtI575ats31dCsjvHc=;
 b=n5FzJPNja/DaIMOrv8BeZtJFWCZGtawdMlhaQBWM0gddzX4qOfSFh+rZnmFNpo6i0p
 ivkmDlx2REaejQbZhWx1Z+XCPF04uLVsT84a07uJ5qSEwxIcRXoFhN8+6nEBd9GhVqfs
 D7CEOolbO3gY2BfEa0cIhxNKr7df1Mgif6WNyySF/BHhbJwebB3MZq30n2jGidbDW2PS
 lAQe7YCC8ElN8PcZ2dqNZca9tH6zaNaae28nEQcYDUlsgMvczpW7ZeKamdpcD8OJJ7PI
 1LqTXkC0PcBd8v9GVWjRBGABQS6+9Dx81t/kmoxNkOjMe1sfybiJOyLyucHwZ/RW/V4q
 SQvA==
X-Gm-Message-State: AFuF++lcdwn2apXeHNb6Ol7vzILcGSzOUzpu79NhywS+ZYNd/5s6NH9D
 jL99l1R/nqc/WjTQ0IRo32mE3BRJuMnNZ6vEMqCoN/tJCyd2WkgvIEgFY7ND5QUKA5F7JeDvESM
 FNmMY
X-Gm-Gg: AR+sD12ZP1H8PvgKaeIwMSP2MCszmdwcBSbmSyhIeabZn4yvnM9YFi3tKqLm7dQsKZT
 tOGho2T2fxKByAFKK3IvTjg/9ml6P+DhG/N+K9G4r0GpAjodYSin0x8uPIGb2rFgPXWcpKHAf7p
 9/bqQYgXUqedU4EKJGtZPKJ5rmFcfLqNXTJB45tYJYGDInHxn/cR2zTtbOefi7767oc9SQCLewm
 pIXROr7vlw6dAv/So2xcFic4IwYkN76h53x5FZpyWxifarRj8/Xeb5M+JT/dSylu2WjLeR6nRbS
 nbwQl956xSoeAwta0NtvJ69yD/+CFIfZ/sXi9/1KN8Ysvd/tc/Jh5TSqMj+A0aPtVJZRgaP3grU
 jGbfEvFEVc/2mskiG82HBrZHkxc18x+P4RrRlOFFKjTSZqnEoQSWpeqrZk0v81A8ywYkBGYc+uq
 G1qi3Nd+sFamaGM6UVFX5ECiZ0muQHCgjc/KUamZoKpSQPO7uMnLuVWiHHPc7XwyOwKBy8NW5dE
 s4AgOr4v7ZlnmtPhg==
X-Received: by 2002:a17:90a:c10f:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-3966d373968mr4606446a91.7.1787693403513; 
 Tue, 25 Aug 2026 14:30:03 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396689fa52csm1207163a91.12.2026.08.25.14.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:30:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 3/4] target/arm: Use -cpu max-v8 with aarch64=off
Date: Tue, 25 Aug 2026 14:29:59 -0700
Message-ID: <20260825213000.221822-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825213000.221822-1-richard.henderson@linaro.org>
References: <20260825213000.221822-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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


