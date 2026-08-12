Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D22CC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFov-0003fu-J2; Wed, 12 Aug 2026 16:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFop-0003ck-3j
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:59 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFon-0002H4-FU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:58 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso59462a12.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786567496; x=1787172296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=92Z59h4EjWpGyEMEUV984CWvR3PXtWrfjl/HvHT0LOw=;
 b=VjmTfj1oOIEq//rIrQme8RLIpcJGdIT+I6DV4ZBJ3TsBCIW4QeEGP+oF8ZecUm0pDx
 bnhoOZ0Op05peGm+WiaP/R4ri31yPCyOQ2E984u5cgxv5KcS85C0IQmn0fyjGDFfNUyQ
 jfZ/Q50jdOLRsM/yLarglTvDkd+aY/kXcq+JbPt7uTTRNPnTH2o27xabIuajdkkSs5ir
 S6s3S/ZyFJhrkmUtxozthKTVW8EwEhJkcU6TdkltMMx3kvSydDmwD0/hAK1LdbfRtXFq
 UnhFj809nRXbUNY2XVVVyVx3Xmu1qGZXHxUGJg6YBjcGy0/z7WlZh532lRhLkhNdrubl
 jILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567496; x=1787172296;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=92Z59h4EjWpGyEMEUV984CWvR3PXtWrfjl/HvHT0LOw=;
 b=GemFn8Dpy0J3Af4MSe3WTsBisFxg6ewGzGFY568VXmJtbQqWqkBOHr3bQB9gC5uZqX
 VNOepVAWDQ+fxoBf4BhoKSmfO033YHG+MwyuVqlSQ8jSBzFSqPeGwF8bTz10OhL9/ORK
 romkLAfT3IWvvjoSb8eN13dosJrlo9Jyi4W7jg4T8ojCk5BzKQD7n/8yFxFWol98ZGX4
 EsMmWnTwJ4I7Gcgc5vUeZGuQhgO2Oy6GWCgiEZGKyBkN6q42nf8DJUBiIFezJd37Au/D
 W7HN3czGhK4ZWMjJOm0WtUYmYu9BwdZfR+ygrnnZOXhJnowpLrfWeVguo2wRy/2yTzWk
 OLDQ==
X-Gm-Message-State: AOJu0YyFRlOfGVniSWavUg++375iiPEK6Rr85DG1DxzkCalSdMRDz2Bd
 vlV73qqRBB8+/bzyrl3y7O3rFqGpxIpjEoNU3yfzeJJsOWJLAwwBOTgGlVow1XdKaGXy3dOuDC/
 lyibo
X-Gm-Gg: AR+sD11yqgmKI/8qnydqnEDXIRLHqOt153MnVJw6ciJZIObAjCAeUGdcZOfMh2R9Mq8
 hhfwEk/Mkl5Xi+RCGzu/5BTgNMD+KLBiykeOIjsDUv+e2RI1J9P0JV1cfztbHgiWoAEDKK+KFVg
 CI20v9n8XQ+a73OEQrmKujzRp2/9r6b+LurL7+CAY3do0XDEiNZ2nVwqxrfrdErSvroQy40ZoGf
 qTOInOsZRHhWygr5Rbwnb8nx7vMOuGGMj8SkyVzKX82CX8pIzSUccUGykP6TvYNYWvqbDZZgzMU
 bZ20wKygcruOgTdrmsjNv8kUdA1kBCZo6nB6A5m137F+kcZPBs7mDeNzxt3xI+GRSwHg6sdkTME
 LjrBHZarDiSlmlHD6z3hnDBvWeQhxN5JZm3FzoPr1IR0sX9IY2ysL5irrEa2+dX7TGyjvPlLjTP
 xRXFTGBo6npQsT3UKXtz6y7BBtz6Dc9bPwVj5moGaJnHJovNVuJE0yLuCjXXFttf1fJ6NkT7c1m
 YcRFHmhzN17fvvxJ8DPvrn8Dp4MaaQ=
X-Received: by 2002:a05:6a00:f06:b0:848:3dae:66e2 with SMTP id
 d2e1a72fcca58-84fc7159e61mr596882b3a.26.1786567495964; 
 Wed, 12 Aug 2026 13:44:55 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc4787325sm125308b3a.23.2026.08.12.13.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:44:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 08/10] target/arm: Use -cpu max-v8 with aarch64=off
Date: Wed, 12 Aug 2026 13:44:33 -0700
Message-ID: <20260812204435.295067-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204435.295067-1-richard.henderson@linaro.org>
References: <20260812204435.295067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index cb4d01fd46..7348fb8d28 100644
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
index 13d8b73b0d..73c9a4109c 100755
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
2.43.0


