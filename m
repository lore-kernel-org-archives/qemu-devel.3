Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B551C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57b-00076X-1h; Mon, 05 May 2025 19:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57K-0006aR-2t
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57I-0003hf-0m
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224191d92e4so57099745ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487254; x=1747092054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCBMR6tP31v0B0NBZf6LKRmnPLfJofFf8No/ewC08TY=;
 b=YS5Fhtxcsg+sFpRUyYETLWN9/Al/caPPNsB9Nue6FQH+GRDUNhxKClQZDWC+C4h574
 m7iCJB5uAJ+qqD15FD/NIzPzEX4OfdvXEbKqw3qCrYSFdEuGBujxznr7Ant8WivIQqfv
 Bx5YMDHycsfKay1EarqiDduORvPKFJn0BqTKsI3GaEMlFQxUA7eOH7iOYEIzuPfE4ogm
 n/DJAUkl8THWTnLoj5U/CS1LH/KpqGEqRFyCtaQHWe8KqNvVAiMZ6zv+eC5wG4orN99K
 ZOil1N8O7Ehe/1ArW67uDVWzN9XE0mNrS2FEKUiDltw5IohdptAdZ0H4SSI7ryPsdEj5
 MKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487254; x=1747092054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCBMR6tP31v0B0NBZf6LKRmnPLfJofFf8No/ewC08TY=;
 b=mVPBzWyhhg2uhmC/AZfG+QtaAt1zUV4iNdu1E7cEx0LFMVT3/yTgvhyKSO6b2J7tTJ
 Ap6lW8EuFsFHcCyvX2BcaMZqb4WCvL6D8SLXMYDkZzMLy/VLQmx2schakI71fQSgvqOj
 LzNZbgcVZlKGw/8O1Yxn5e/BjWSmnRaEz+ov2VPGsbzJrnWgDdLN5assJozP0HyhcmjE
 Gm8kVPYlNNjyIYcc5aYGg7uHeK0pgg8lokuFrMmdfEnnXVM8h5lYzY2XzLdQ3JfU0t3/
 k2oUCZ+NvoherRxN9go2KAyN8uPvETKGbtAjiBxXlq81eJTPMlsXGAlpKG+KkDV4GTrM
 P9ug==
X-Gm-Message-State: AOJu0Yx8GmRUGQ7FcFS4+Cd1/NcsJtefITK/Ujf4weRnRKcFDaysPfyd
 KhVz7trI3rMRKWU+kb5DUgT1Uj1BjDiX8WtYDkB5hBU+cFdVHEdRRZfQHvDnyJ6HpU4wbp/xPHj
 2+Ek=
X-Gm-Gg: ASbGncvY1dxS2UaGqdq+t0qvLvbVWtuNeDuwMrwAp/TPCCGxDtVhi2LYtfgg8eRCygG
 xvxX0c3uwMZzltA8qJQgEeaU+A4WEaGrbyMmeEJvVuCB9HYeDB9PqZG6r8jVnyCDMfKLjrNHLo+
 +U8QZAxBcSFL830rTNZXvWE+u3V87X2ZrVg9xx6YP4+CqYN2AWbAMWcjNQC5sEW0+0ZY7FuGg0P
 FVSzS+xTRca0veNyr7U/cMLJz+63FoFZl4iWqJDLHd2+pxTgbwoeipNurBp+f+b2dab5+byuiCN
 ZCH32y5kazJVawdxrvSZHNtH1UlFPY6SXNnBRvvj
X-Google-Smtp-Source: AGHT+IEEWCUQlzVgGthYff6k9Jr792b5t/XjUuobOuK1wX1EdUQjPmf7ipfIT8E8WlUj0rABldNgmg==
X-Received: by 2002:a17:903:291:b0:225:ac99:ae08 with SMTP id
 d9443c01a7336-22e328b6d64mr17397715ad.5.1746487254221; 
 Mon, 05 May 2025 16:20:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 38/50] target/arm/machine: move cpu_post_load kvm bits to
 kvm_arm_cpu_post_load function
Date: Mon,  5 May 2025 16:20:03 -0700
Message-ID: <20250505232015.130990-39-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h |  4 +++-
 target/arm/kvm.c     | 13 ++++++++++++-
 target/arm/machine.c |  8 +-------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index d156c790b66..00fc82db711 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -83,8 +83,10 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu);
  * @cpu: ARMCPU
  *
  * Called from cpu_post_load() to update KVM CPU state from the cpreg list.
+ *
+ * Returns: true on success, or false if write_list_to_kvmstate failed.
  */
-void kvm_arm_cpu_post_load(ARMCPU *cpu);
+bool kvm_arm_cpu_post_load(ARMCPU *cpu);
 
 /**
  * kvm_arm_reset_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8f68aa10298..8132f2345c5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -977,13 +977,24 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
     }
 }
 
-void kvm_arm_cpu_post_load(ARMCPU *cpu)
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
 {
+    if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
+        return false;
+    }
+    /* Note that it's OK for the TCG side not to know about
+     * every register in the list; KVM is authoritative if
+     * we're using it.
+     */
+    write_list_to_cpustate(cpu);
+
     /* KVM virtual time adjustment */
     if (cpu->kvm_adjvtime) {
         cpu->kvm_vtime = *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_CNT);
         cpu->kvm_vtime_dirty = true;
     }
+
+    return true;
 }
 
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 868246a98c0..e442d485241 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -976,15 +976,9 @@ static int cpu_post_load(void *opaque, int version_id)
     }
 
     if (kvm_enabled()) {
-        if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
+        if (!kvm_arm_cpu_post_load(cpu)) {
             return -1;
         }
-        /* Note that it's OK for the TCG side not to know about
-         * every register in the list; KVM is authoritative if
-         * we're using it.
-         */
-        write_list_to_cpustate(cpu);
-        kvm_arm_cpu_post_load(cpu);
     } else {
         if (!write_list_to_cpustate(cpu)) {
             return -1;
-- 
2.47.2


