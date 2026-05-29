Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AFBCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3FX-0001dJ-WE; Fri, 29 May 2026 15:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3FC-0001EV-Nz
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:51:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3F9-00059H-1U
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:51:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso74470095e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084301; x=1780689101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnMiDonv1YO14rMlbhW2kVzk+7R9nLq/lyljZBG8qv0=;
 b=TJseCz0/dbwKmJWYGurhwcJj9Jw6QFbgL1bMibMWsagFEh2j866WlsFc1cJ8ZwPycS
 M9PARSwQ/NF3Vu4N8XBZBpn52L4aAhfL4PyI4dRRQ++o/9YXM+LnctVrK9mH9M8K/Xq3
 vR8cDpntIwF3vrAKoiKd4euVsGfwrDWvj+jhDpJ8XdjSAH7TlQ0r55LMS26YaZJazp9R
 iFtjuJxqjvXQc+OgBQEeFIeiiT2/QY9vzdjEwZm34WxOaoRqzm2lTc2gx5oT88A9n8qE
 jEdXRX4eeOSolMNjD81hgxX7XjidN3wvym/vJCeQFpPxvwqwcDVRMQc+32faHLVsCE7T
 l1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084301; x=1780689101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WnMiDonv1YO14rMlbhW2kVzk+7R9nLq/lyljZBG8qv0=;
 b=YHAmDlLVuaZHX4O+6UGg6Ow+vQgzi9t1ighnGKkUiPV0jiSOn9Dy9T57Wyo0cbo0h1
 n1LwWm6A51zclRgo5h3aCN7V63RsR6KSxbMp6nwSJAqJvud3Hxj4oO4cWGhyiX02LPTp
 tfEAqIEAuMg9J0ymv0QyIoLOOmDH5N389Gor5CuC4es+Y3V0nrvbw7i10kqPEfK3bD2q
 lKxNozGW7viXANq/ApuIH+iai1uJrUv0nhnbN5MOejNHyQBven/XnekbyhryeWO9Zqig
 N+7n8FuePyjzgnBSszuKDJnARjNULwA4k0PqCbq3K86bniHbTY6MLkLeo5yoZnopi2s+
 KyaQ==
X-Gm-Message-State: AOJu0Yxp4Oo0ThpFTBDNg+3gY7oifn6VGWQ94QtqiHiebR1H5DJKjIlT
 LVeoc3b9bBB5MrY0UswZjhHI+NtW787Wwkex/FT98JLTOra7Pal5yF04gLt4pbfSrqPxU51p/fi
 837ZiuoOtpg==
X-Gm-Gg: Acq92OHLLeQS53FIH4r+Vs0ZUJhRfK/7/CL07ayl6zrhlBhK9SkAI4zp/0q/26d2b8S
 hTzI0eY11qkDoGg7vL4llP5VtvzAsAbOs/MdoIPzC5S4N26Ceab0+mVVZUwU1pS4MiuVIMhrAya
 kn51BWdxuQC3XrAAU4e4GGUcvKGlxsIEYaI4sYw+PSlZCsWlfADix4KnuYnS5/5Dx3TBKm97iEj
 uvNIv6BzJoC0P7CH8PbBmOVrx3ksURBaC3O7m5HuXEiGRxk0ATRPESEmlQKHN9n9zhBB0QDFULA
 oz+OgGHdbCu4kW5KGKfM70iTEelcQiWIM6hSzsk+3hne63pYJ97MYIlfG2sM5ad41irDPW7jSTC
 NTsgbkTlLG7RFXHyT2XlNTVjnx8T3HUg7KyIwl1YY1VCyBTyw/cdb7rV3D6nFUR9ebIWauFXhg3
 GJ75Zic63YXA+9n6vAm2p7hKXjhZsmfaW37kHUBKq7DBJpBmMwfaYDPkL+TZ1oE57gHA==
X-Received: by 2002:a05:600d:848a:b0:490:58ef:cea7 with SMTP id
 5b1f17b1804b1-490a293dcefmr12453125e9.22.1780084301545; 
 Fri, 29 May 2026 12:51:41 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c12359bsm25514985e9.4.2026.05.29.12.51.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:51:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/17] accel/tcg: Convert X86 AccelCPUClass ->
 TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 21:49:36 +0200
Message-ID: <20260529194940.97143-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Register AccelCPUClass::cpu_target_realize as x86_tcg_ops::cpu_realize.
X86's ACCEL_CPU_NAME("tcg") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/tcg/tcg-cpu.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 04bb9787575..2a61de7f610 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "helper-tcg.h"
 #include "qemu/accel.h"
-#include "accel/accel-cpu-target.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ops.h"
@@ -180,6 +179,7 @@ const TCGCPUOps x86_tcg_ops = {
     .record_sigsegv = x86_cpu_record_sigsegv,
     .record_sigbus = x86_cpu_record_sigbus,
 #else
+    .cpu_realize = tcg_cpu_realizefn,
     .tlb_fill = x86_cpu_tlb_fill,
     .pointer_wrap = x86_pointer_wrap,
     .do_interrupt = x86_cpu_do_interrupt,
@@ -232,24 +232,3 @@ static void x86_tcg_cpu_instance_init(CPUState *cs)
 
     x86_tcg_cpu_xsave_init();
 }
-
-static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-#ifndef CONFIG_USER_ONLY
-    acc->cpu_target_realize = tcg_cpu_realizefn;
-#endif /* CONFIG_USER_ONLY */
-}
-static const TypeInfo x86_tcg_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("tcg"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = x86_tcg_cpu_accel_class_init,
-    .abstract = true,
-};
-static void x86_tcg_cpu_accel_register_types(void)
-{
-    type_register_static(&x86_tcg_cpu_accel_type_info);
-}
-type_init(x86_tcg_cpu_accel_register_types);
-- 
2.53.0


