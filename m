Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4033EC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dN-0006Eo-8z; Wed, 02 Jul 2025 14:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cj-0005Fo-Pi
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:07 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ce-0002Nx-5K
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso4243705f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482553; x=1752087353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFRxRvBg/Kw+lCEJUMnsPGlqNMegEysmKneUwCu7PxI=;
 b=tq8gtsB0C5TafiJ3gctl0wRoJmHeuZ1zOgn/IRxt2XWKkJLt3bRkujgC5DBYyhctOP
 ahsCn979U13cRjN7Vj94zBkgdQabp5D0wAHa1zgInBWaiv2Mh62UQIzIr16N5rFVwzOG
 ldZOPM05s0AoS6BUZ5VwbfssCTdCRNo8U7oro7evohHUbfdKGOUvsDkhoF6EYWrWMQTP
 1ii1jCv2wcN0gbxYS1TcB5od9NzssIe7lc9IjdsANtR7USq7Bf3AmBMn+xVpz04QAzKD
 uvE2c85rEQ2wy4lKanOC3iOjjuG68KL7NoxvBCmQMsjQSiXULcmMBaPhGef5QGmZbKF/
 ET5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482553; x=1752087353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFRxRvBg/Kw+lCEJUMnsPGlqNMegEysmKneUwCu7PxI=;
 b=ZldSu6vvVqmihYDe9PYHzqwQQkH0gBacvM0ZQH80B/uUH+v0bNiK6MvjDswW7Tm2kJ
 ZgEvW5CLe6ix/I4u8ZS9Qh5o4XigZP5s9xmyNOXsCYwHFCYhoGWWIFc94/CeS6arInMq
 INfUB0GNLqJw+CH1ZBML5/ewXt4Afg3n++qN2icR3Uxs8gbmtRWQbsCStvm+aJQunKJH
 zsQjALDdsTL6p6KW1oZeXyo5ajFHpsSJujuf3aBoBnMBru3W4qwcA3+F+dPqmBZQlN+z
 v+EQ91qLi3tkpCBjGXGfsLldXGrk6HLcfnNgqKMF+MJvSlW7+yP8zfSP4g5MdaT/vOEh
 Ghrg==
X-Gm-Message-State: AOJu0Yxo3j8Ivb5yCePdutzNxzY9Bsl+Pb3vNCAHqHd7kQkgSnqEJ8xm
 IJHPHKVaoP3c6WBfUiCD2pVQ9NJ0MvWUT4HTv/XtkWlAIoLGEl9ERI1GJm7UPoayJXLsO+hKJpy
 X79pE
X-Gm-Gg: ASbGncvM02beFcT0qdkn7N16wC2mfuEJE2LdgvsN3JV9LpyxjmEA/qwsgvvnbOV24hv
 slEmDRWqL80LT/SsacV+WU1FOKnJ9WuT22ZLRe9Nggv4iphY6Yxezi78H/qDY8KA1Y5xGin0JFP
 Sv++GJxb5+LL39NzQ9HcQ3jz/B05aS+NEZouu3+Lchbhb4f7yUg0qlN+PkfncDbEhyFPtKA/Fwe
 BBUIIsSE4UwGVh1gxt2okF4PV+ZHy+oIlN2VduC8ike25UwMucEXNf/PgD+0iTT3UdSiy4Q1x0P
 ygOtpzfUVc8wZCAgAujHY8t0XWh7mZU2b3AucXUxJZbVNTN2J/+8gpRn7iFd/Zoh843tb59b3rZ
 BTYBS0fIeqzdB5l86al3MKXEkdJxFFEfooo4O
X-Google-Smtp-Source: AGHT+IHrloT4u+cJZWD6tymiu7evWdp28t/jPAuM/5/8zN4HIDxmcuGAn+u+VysC6dKODcURgh9+kQ==
X-Received: by 2002:a05:6000:238a:b0:3a4:ee40:715c with SMTP id
 ffacd0b85a97d-3b1fdc21d11mr3371323f8f.14.1751482552643; 
 Wed, 02 Jul 2025 11:55:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa54dsm16458659f8f.23.2025.07.02.11.55.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:55:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 19/65] accel: Move cpu_common_[un]realize() declarations to
 AccelOpsClass
Date: Wed,  2 Jul 2025 20:52:41 +0200
Message-ID: <20250702185332.43650-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

AccelClass is for methods dealing with AccelState.
When dealing with vCPUs, we want AccelOpsClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h       |  2 --
 include/system/accel-ops.h |  2 ++
 accel/accel-common.c       | 10 ++++++----
 accel/tcg/tcg-accel-ops.c  |  3 +++
 accel/tcg/tcg-all.c        |  2 --
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 3c6350d6d63..518c99ab643 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -41,8 +41,6 @@ typedef struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(AccelState *as, MachineState *ms);
-    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
-    void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* system related hooks */
     void (*setup_post)(AccelState *as);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index d854b84a66a..fb199dc78f0 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -34,6 +34,8 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
+    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 1d04610f55e..d1a5f3ca3df 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -102,10 +102,12 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     }
 
     /* generic realization */
-    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
+    if (acc->ops->cpu_common_realize
+        && !acc->ops->cpu_common_realize(cpu, errp)) {
         return false;
     }
-    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+    if (acc->ops->cpu_target_realize
+        && !acc->ops->cpu_target_realize(cpu, errp)) {
         return false;
     }
 
@@ -118,8 +120,8 @@ void accel_cpu_common_unrealize(CPUState *cpu)
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     /* generic unrealization */
-    if (acc->cpu_common_unrealize) {
-        acc->cpu_common_unrealize(cpu);
+    if (acc->ops->cpu_common_unrealize) {
+        acc->ops->cpu_common_unrealize(cpu);
     }
 }
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 07b1ec4ea50..95ff451c148 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -46,6 +46,7 @@
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
+#include "internal-common.h"
 
 /* common functionality among all TCG variants */
 
@@ -212,6 +213,8 @@ static void tcg_accel_ops_init(AccelClass *ac)
         }
     }
 
+    ops->cpu_common_realize = tcg_exec_realizefn;
+    ops->cpu_common_unrealize = tcg_exec_unrealizefn;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 93972bc0919..ae83ca0bd10 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -244,8 +244,6 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
-    ac->cpu_common_realize = tcg_exec_realizefn;
-    ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
     ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
-- 
2.49.0


