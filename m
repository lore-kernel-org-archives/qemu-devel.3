Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B3AC5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws18O-0006oj-0j; Thu, 06 Aug 2026 12:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18H-0006mg-NS
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18G-0000JZ-92
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2caced6038eso15413635ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786034386; x=1786639186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3JOD9P96ewq1kt9dQtTWRUzN+g3g91eOzCcajcg6XGs=;
 b=AlClteMBnRsqW97jPXE/APdjGeBaT+2es/GrrPxw1n7B7OlV35Ayp2YowMcBZn8XDo
 uVT4qryTqqkkwYI3KIvCaCGwsXNZdNFXKtBr7f24LS7o4a7LP82WYm0EeJ22jR2mCrAp
 kVBtieMAEREIa5qaQNdCX7IDpLGqvmUsBUe5JHMuzAB/8fQLAFg6iPwAUKeWTZd1Aad2
 /BLKBmxZjzMMvWIKQOwHZm/m6zAgBX96l4hkpyOqmN2MAMc2ouwt90p2NVGBL33Qj6I0
 AgjIw1wqMUKh2GyIx6EjEYZVPgM7rw926gBbIMduEZRK1tJHFv4YGJCHUP+c42de38z3
 8dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034386; x=1786639186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3JOD9P96ewq1kt9dQtTWRUzN+g3g91eOzCcajcg6XGs=;
 b=Ok+GbHOcwmYo7QDY5ri7CwFLHrSvYsH/VoHNdwO1KRUeGYZNCnVYMDpWkdNCHUSqAq
 gnXJWVt0b5YxaOrPenQTHLvLZBsjrdbebz2xjKhb3vk5bGffQ9yp/74lfpLis69fxAbz
 tkKka05FYGb1t7zv44GkdyBJ78DTnALPdjqr2Z2qJms9oiXMFmjKB1McURYJKH37ZIg6
 bE4c4dbOP2yR48w53fuhvwHzkEbB3P3RgrfnvYCMdhNo0g/vXeSayfP58GbEsw9lLRMe
 dFGTa912JSacxR+ROciONLQTWrlhjSWQevTn+haWLj1wNfbyH5R75ATh+kWEAtFdsx4Z
 qs3g==
X-Gm-Message-State: AOJu0YwceWHDvwIXgtpEFmUbF4EOutmlZGx7ExwNqC9k5VsvESUmkTQN
 GC6CpYvj7glR8FKtvMhCrtAzQFO8KuvAS7M4cDyhCG59VA4YKejf2nNW1EFkHKwqDTTYbXXzDDE
 +F9W2
X-Gm-Gg: AR+sD11nv10mFkH4FwfNPRFJFp532f9XAmWIzIRKhsdVm19PU7ZgdDjU8Uwgv0KXilf
 Mw8PCFK5fcfwoujsmYFfG0pN5xpjEXRWs62Q3/XNbgM82I1lowGLf5lXrDNIisNxbuIRJXwilJ6
 pt+ZIzvQf3mupJFwkX6KjXWujIRld8mjNGBONth7Nn8jyk2khsnl/CadNIkIhGlEIQCOiAUDQ4Y
 a1mu9zEuc/I04McdOWe+pisFGrmSitqfI0Yuj7HN7FHs1bWxRGaS6OKaC9+ajTgDm4PF3E3TjOm
 ogzijr1thwfYW9E1jRXqVca//x0UBXQz/C2iIXbBekQHPKpXmnmft6l9ym0I7HU6Tg/qrtCp0WE
 qyQVk5mjalo03wbThYL+UIHgydcy5e4LOFdW0BvUgbvFFIfrKE9QPm1wCpHoV7y+LUgc/0Iim5/
 J1QjopdYimktCNsZTRbgNsA5rR9zKeut1O7dUcqAVxFMl5dyw/GA9dumINOsHsubOMAXkA+2FEG
 2SHY68s1SfBSR9FcQqR9Ep/ppUaUYI=
X-Received: by 2002:a17:903:1aac:b0:2c9:d277:2cdb with SMTP id
 d9443c01a7336-2d0f7094842mr34239875ad.9.1786034385805; 
 Thu, 06 Aug 2026 09:39:45 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4ec8c7sm34280735ad.80.2026.08.06.09.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:39:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 6/7] target/arm: Use -cpu max-v8 with aarch64=off
Date: Thu,  6 Aug 2026 09:39:38 -0700
Message-ID: <20260806163939.328201-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806163939.328201-1-richard.henderson@linaro.org>
References: <20260806163939.328201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


