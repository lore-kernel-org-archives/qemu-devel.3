Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399521061B0A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7EIt-0005eB-Jh; Mon, 30 Mar 2026 11:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7EIp-0005ds-IJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:13:19 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7EIk-0002ED-DQ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:13:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso37906055e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774883591; x=1775488391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s2wYGWZyiLSf+BhQWVn+YKYXyYsHikf5YHf0S051JMI=;
 b=YUz3LdjhFG3QPoqGQL3nrVutBiZ/tTD8c0y8FQD70YC8i0d0XHyPrVEqYAHqidHx8l
 dhE5XRkoGzVkTv+pbOEnvsdIlaXL/s4evAAeTNC40EV1EYLrnpBYdEphV50+q0dW/m9P
 /zX4lE3Gzfr6xHtOKIf2d3YEm57KRSexbVytXXq2f2nKRw/dm2k1/z01DMZW7y6CwoUE
 ECBMKN12LI+53zaj3o8waV985Wy+yJNK+kgRebDBHR2ipGElxJ0lUCAvevmOB8RxeeLW
 cp86PNU6RPV7JHE2yStHlR+zQUBN41zC9R6vw6FhOi0uuKqigL1dZ3aUAbwPLnfU6IyV
 mMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774883591; x=1775488391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2wYGWZyiLSf+BhQWVn+YKYXyYsHikf5YHf0S051JMI=;
 b=AxvVhI5g2vljytKc32liqnZ6OisGb97kjYe0ezp6Il5l7O5jfity3q1eG5FjBOG0Zj
 mSmKk0Aht3dMHZQrRPBv3S503T/iIyjGhNodeTgPsFmvuMk1YvRQgFv1+AcEE4mmEeED
 z/oiUy2L5CmuXyamcqm5v9bjcvJOWWAKmQj2Gd+YXL/fgkRymAIiO+h6VZT/hfFGEuT0
 5g+Cx6hTzB2ztOgiZ7odAz9XiBTk0zxYc1lVyP9UheVJK6SmjOeEU7dMhoZXGYCy+Co2
 RYef8N324Vnbn2rK9vNFi+y0fusyuJYFdz+lUPooj49HW+T+AAsTm7PqQwarBsYzgQqZ
 KEZg==
X-Gm-Message-State: AOJu0Yxt9jB/KW75QzMI1sl551uD7GuOz++hShQyf+pvC7qX92PScZ9Q
 c3ndWonXTL2nguoNkvEoVIKH9T8L4Xi3RsvCSN+Z1+OjRXljl7CNOHhVGUniK+VmLp6AuUh3AJX
 086VkhfA=
X-Gm-Gg: ATEYQzw0JVUZH+TA+Yj+H3/1NsewPVC8EieXBJw1SZh7MQ2mXTexxYu6uzQu8/SawvT
 u8ZKw1c4M/OqWp0OPEYCDzQyR5wuQkkCqEZAneaEY3uqLHQiZTrGDKrf2h8Fit4r9xhls4OTBo2
 3QA6gaj+DxBw/U+hhY0XSZZTQUTFfZVCaI8WbNz01iSiRNRtxuagmu3yw9naZ8otTXBmhjKx4mm
 8MzTKKM4PBESHvZWGyaciQ8RRr0f8o6nOVxf4IfO89d/StkHXVb5YWn3CwEFtWe5My6oWpkZEUc
 bduknEL8Uqpwd5uxxIkUzigs+vuV85gR76m5XtrSrIrVfTwEBfFUOTIifAmixmPq4L/KFD6y1Bj
 rem0zFPfwld7fd2JG48kYrGl8CNnW5JZ0eF8Uq12wjYRQ/BuDdpaCLr7z+MhVaLGeRq6/FpO8Wj
 YDNc2IybAB0oKKNg3hoBF7xfU2jmLS/8TP2UHJW/G4enOl0bSW/9kr4TAfRU670MedWATdsxR4g
 akOTu8yllRzDj4PNlAXSRYMXLqYbxw=
X-Received: by 2002:a05:600c:1d15:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-48727edf4f5mr212057845e9.26.1774883591424; 
 Mon, 30 Mar 2026 08:13:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d40741sm300065015e9.13.2026.03.30.08.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 08:13:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] target/i386/cpu.c: Correct minor grammar error in warning
Date: Mon, 30 Mar 2026 16:13:09 +0100
Message-ID: <20260330151309.1786787-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Fix a minor error in the grammar of the warning messages
produced if both MPX and APX are enabled:

$ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]

Fixes: 91bc4d81078a ("i386/cpu: Add APX EGPRs into xsave area")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
As a side note, it seems a bit harsh to turn off *both*
the conflicting features if they're both set, rather than
removing only the older one.
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d02f6f0653..3b0a7c7363 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9628,9 +9628,9 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX) &&
         (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF)) {
         mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_MPX,
-            "this feature is conflict with APX");
+            "this feature conflicts with APX");
         mark_unavailable_features(cpu, FEAT_7_1_EDX, CPUID_7_1_EDX_APXF,
-            "this feature is conflict with MPX");
+            "this feature conflicts with MPX");
     }
 
     x86_cpu_enable_xsave_components(cpu);
-- 
2.43.0


