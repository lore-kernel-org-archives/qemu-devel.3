Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51711C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXbP-0002Z3-18; Mon, 12 May 2025 14:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX9-0002ea-Pg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX7-0000Cf-9N
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso45085755ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073144; x=1747677944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNwQBodHKU/YNnzJ0OLvvAjHAnJFIjZ/+9H8rnLNev8=;
 b=mivkbDM03jPBS9tx8s86KCaxsS9a2RISJXzpocThwpBE5piAqp4vQOymABQBTo3FWi
 pgLEwgraQDGVW5/Zhi4LsFQYN7VhS7ljFwP5cS5stFkdm/NOpP/hor+dgWRC93OgwLaL
 4aYT8Yw7zpRqM8jzSpsG0vNIZenjVNHEplcP7TMf6AF53ggV+zXTK7ABeSRNq9NCEE9W
 lKJMuUic72LKQq/oFy180DmdjHy8ICTjQ+tBN/L3nsRk/WS1saU3YA3wXR79JU9pzsiK
 eO6dIyh+k8wAjhtUzJCtCdDS5jUmySk1oKewqAqcI01AGSp6cdoXdEaxi8+64eEZSCYq
 Qm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073144; x=1747677944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNwQBodHKU/YNnzJ0OLvvAjHAnJFIjZ/+9H8rnLNev8=;
 b=ifoyBUV3CjDIY/noOKwFalEC1sBwAlPDzMbCagMx+K2ErSy7QTX97V6y4Uloe3kFoK
 7nHv+FLvPHQTY2mtD5oNFK3Ajo990KUi7FGspRSpGFGiCq3+4KxhH5M6M46cqwcYyZBZ
 zPF8BiJTrnmtNI89iclfbrU0cCNsS+s/91YHNmD4+eWYfLCyc5YEyLXuXs7hvTsExPZZ
 jsoM7njkqBQrrOCcJaInSqf4Zo+VwbUZA5Q3X33hkZflKIth7COVtlqH7K3U3Jh1/32y
 SnBxAI7iiWLdSOyuWnjJpJ24SberZ2L1K+fc30tCxhWtB6wheHblGkjL7KXZmfkLjdk/
 B8xg==
X-Gm-Message-State: AOJu0YyEpJ6gME25gjDZ7GK0hYJRRvi6v3tAo2dK+lyHv5gSFlREXVJt
 MoinOoDhgyuI5iC7V+aEt7khIoulxbuhJP3xxldU9roYcGJV6kvh0II08T9f+63O/OuVlqAYE3p
 W
X-Gm-Gg: ASbGncvWnmqQmjvO1o1cjjAiRuuVJOTqrQQ3eAzZjQDwFsaku5XgkSZGEPp5MkFjUyT
 5ENJTr1uSGAnKYFVI+gVBLTVT2L/ePynAVhpqojpUV5l2ThMjHLJbi9DxiFzHtj3P7lVkJlmz1Y
 6DMH/bkw1g+X5MfbQDRrHTDVGDddn0mu/5unpdNH/h407/Vs7FfkuZV2XX+cxrdU44E2HRi4zuH
 fiFLyaDqYKg1pno06zIZnY8aZS5kypoSQ3+/VAcYzHlbDj2RB4B478NW6GROreIn8qD1NG3lBS3
 S3D8oIFf9oZT0Cc8ulIWfUNyiJMlj61vNJUSr3VBEfFQmjMs4ZRrHWmDKJJaIg==
X-Google-Smtp-Source: AGHT+IHsdPyvkI06Br8pyqXwcLuHQL+6O0ZNsb9aqM/OXtXPB4NrBUBCNdmarJacg2dltIYJwQG2/A==
X-Received: by 2002:a17:902:e5cf:b0:223:5e54:c521 with SMTP id
 d9443c01a7336-22fc894f1f8mr197858765ad.0.1747073143901; 
 Mon, 12 May 2025 11:05:43 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 36/48] target/arm/machine: move cpu_post_load kvm bits to
 kvm_arm_cpu_post_load function
Date: Mon, 12 May 2025 11:04:50 -0700
Message-ID: <20250512180502.2395029-37-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h |  4 +++-
 target/arm/kvm.c     | 13 ++++++++++++-
 target/arm/machine.c |  8 +-------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b638e09a687..c4178d1327c 100644
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
index b6c39ca61fa..a08a269ad61 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -938,13 +938,24 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
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


