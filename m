Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07798C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONL-00017n-H7; Tue, 01 Sep 2026 09:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONJ-00016z-Nc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:05 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONI-0007Dg-20
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:05 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so197289666b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268682; x=1788873482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WMrQzEuCYPK+ENvy0053RhOA/tDuA3lAYdzC9luLSvU=;
 b=WGU+e8MsCL7zT+m1zn/kGNblcEhcWY5dgKrkzUmSkkE8hRsUQem++izTsfIDwY2emV
 K/2bX7gCHsSAwOyhD1ycN3FB2c0XZuB3Yc5I9ixUs2YnP4/DrYq7VDOyY7zgh8hJY84L
 CqlKzq0vjLvYK1nFyGDPMsyjODawXodXUhB/bt1Nd8qcOk2LlSd2+hRYFmHaNbu1YroV
 4dZ52Q5Ndqh9Dl29sz60ivJEOd3eI/Ybv19dNdFbFMrXsCuCvL5mfu5mRbrDcdJ9iQeI
 AL4+oB6zHMhv9RMIM5KX0CzNQu2asSPTThNKWZ0tahxceiPh6d6TU/cj0fa2lzMymgmH
 VDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268682; x=1788873482;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WMrQzEuCYPK+ENvy0053RhOA/tDuA3lAYdzC9luLSvU=;
 b=n9pWbmlaRkBcDolVXHmculJktkJFMTHnpEMtYix8/anRQblUCKfocz+bueDejWahpK
 ByMoMDbhdt2JjIZFPHbUM7AJI6ZhSLeXu6RpZGBVhGOw96S04hPUCNuyuGpf6Nf9twCV
 /pKfBI/67at0FSLoiBNO+3Cdz0RJJttvCMovZZxo44xYL1tJCqCdZaxykiVJCnSDfnC9
 9Ey81TX0DM4UnInETgx5CItzkYoJcgZXhp2gm7zWNNiVlKPlUrTMW1eNrnHXKTrGz11A
 TTrhyt4fXN2q5uO/bYIptaMSMTjDKk2pWK+dlEmyq+Ss48y9ITujOhBfdtiewE16iLNP
 a8QQ==
X-Gm-Message-State: AFuF++m6cZwGg54DoSH06KU7YJu0myco61Or9LOZOsC0InAf5Pb74Qs1
 E/Cmt9cyo0Qw1dI/gUN3p7Ic83i+l6/w+ZIzpSfuXV/NtyqsCOh7hqM40FzLNZRofEdXc4xzkmG
 WotfbBfI=
X-Gm-Gg: AR+sD129KXru77PNVplyQa8yXbYh29wGVUd3REATtpplOSCaex+mC79qMgdHnwG/kuY
 NvWKSJv7y6qoM5+xZgVvwitOkcDmNVkLOQTzW4Jjnzqnqa0S/7hxH7S5pQDm3VUs8zUhfOrE8nv
 Zsd0opyHLR1xMOCOGzUPhqtmydwOW4swhdmXAnTP8QUw2pWnAs2S2l3hhZUe4XmYsIi9d/oMp7n
 jbcS8fdSWoZyOuWaSVMtRSnCGOnOpE5Sk12ajMwUsukgBnMyZoCOu5FOlLKE/U7LWHI6SAasVPC
 R0tOVxB9G/Y+hHGmbaqsWg0TerxGZTs5LChKV43jpteZLCqjvbK5Vj5T68N2qBb9+tBSbL6Op8Z
 U/34S6L8IGPzcxBIf34J6oWo3FGa0N5msVyXb/rgGisp7tm90YKVvwPh0Vkkam3njIuitN0YhMm
 cRLNUwjJVBwbYy7lvbf1SZV8iA+yhwCjNDYbDg6mEJnfB9IAARAA7m8+jpOwa82psZVHnavpOgw
 F3NsykQ+1vXaWwShg5icSJLRGPPPPgaOyNcLc7GbIE4beqg31iZBtzzL9y0byRlTPvP5g==
X-Received: by 2002:a17:907:c8c6:b0:c21:5cd6:3e49 with SMTP id
 a640c23a62f3a-c25b91fa262mr412858866b.9.1788268680441; 
 Tue, 01 Sep 2026 06:18:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/58] target/arm: Use -cpu max-v8 with aarch64=off
Date: Tue,  1 Sep 2026 14:17:00 +0100
Message-ID: <20260901131732.2263947-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Armv9 does not support privileged aarch32 execution, so
aarch64 cannot be disabled.  These tests must use Armv8.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260827041557.775080-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_virt_aarch64_off.py | 4 ++--
 tests/qtest/arm-cpu-features.c                    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.43.0


