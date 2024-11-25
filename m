Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C36D59D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfF8-00052W-Vo; Mon, 25 Nov 2024 14:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF6-000514-L0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:32 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF1-0004lJ-Oi
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:32 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43494a20379so17709955e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564766; x=1733169566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUUGPkOeOTTu2+NC5FrYwYu1VqmCribZfZ+rxUCPPlM=;
 b=AYELKALOpB+vT8qq4kgt2mXmKO/TBS3e7WBJ574fISxgduEip4MNXiSp7RhIqmfx5a
 1+ZeQv+oL62ej32AXuYDKl+Pd/IveMf+VQa2A2d9mMXOHX0Ra85y4Pe3xq/DSZmd9iJU
 0h2joaq/9LgWS4cDDgQI5+RJsgS+ZgqMArG4A1pkBzO4kNsUp9GFbYZZ+gTfBvknwugY
 0uYXVA1uLxdFsPwsYH9NtIjcMCk+fyBhNdjx/r9Pq+QvT+JHHl2FfrmHswqTToYOIZn5
 Bx3YCtzj95c6l0v17k8db7GgQcpt3TufOVv9tvEUN0dOm6ZlWCQRoYtZpFTDSRm0SrK9
 ix6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564766; x=1733169566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AUUGPkOeOTTu2+NC5FrYwYu1VqmCribZfZ+rxUCPPlM=;
 b=Vt/eX3FTFianrmlylkSDGK7Sbdffn2TFYxfS1HCJXTDOYDpR5tnyOxR+v0XcmVN/rC
 ZfEqTP7ZhBXgKicgcks+Av4Uf/v/b6gGy7QwjaYREfM7VFL/LtDayGQJlJ3TGay4VbLA
 mc4YEXbDo8hgkzLTH4J6ZiJOJ0WC4ZUJSzrouBVXhKSitoGXcZ5KO2bbrA6ywC8SBnBU
 +B3yyigRxLG8fnKn6mxhc8XgWxIgYpaZL6CTyKV+ulnHwxvEYIRKphh7ZZSIxhdQHMjC
 zefgtmLTKnMkl2MgQqpcofF+LBmFG4Ex4c8t2MgerTePkYybhKPLaCDnjEzDSmT7fksu
 qB/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2xFUKc8d2GQGpKZuHvShKXzwp3SZrNn0Hnscr7FcKcpfa2/4wbeax8iSig4xevT7M8x49M0KjjrY0@nongnu.org
X-Gm-Message-State: AOJu0YzDDmovlOtQcNhxulE+V5UKfU9+yU7BvS0VYPYLOr1cqbR1Gc/c
 GFvkPsm6aUmm857c7RDG3pKadNXM9g7g4RnN30TS0zPWBhwuS+mu8HkuzoypWaM=
X-Gm-Gg: ASbGncuEFUunXt1E8aCJoa6CeLEWOJFNQPH+gfghzN8sgPOqPVWwtmExVej22+wL04t
 c6SNP5hssMJRJfpj/s9020v/VfCFMaOb6zRdK1XV5RyR2YDaqvybKnwMNpgxebJ2ZCo6YJrIXxU
 rGajgNnDKpor4nHI3PvjiUKtad2AOo+mqCyo+j8UConHvrlGVYm7wYoK2zZz8yg1eYa0+3dfWn/
 Mi7PlhGpCfEniFI2Ebr6eFwfZQNjd+xvOswtdO9ZVD+zL4VBrH2L+CKYkRtCQC4NDbz
X-Google-Smtp-Source: AGHT+IEKfTHdZFW+oj4dYHwYt+075eZ/vDoe3cPOa5Tj6NfVEo8CowgGjm+2FvHfVf6gMGEwUzHcFw==
X-Received: by 2002:a05:600c:3b25:b0:430:5760:2fe with SMTP id
 5b1f17b1804b1-433ce4c2218mr111110665e9.22.1732564766349; 
 Mon, 25 Nov 2024 11:59:26 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:26 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 03/26] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Date: Mon, 25 Nov 2024 19:56:02 +0000
Message-ID: <20241125195626.856992-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x336.google.com
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

Returning an error to kvm_init() is fatal anyway, no need to continue
the initialization.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/kvm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bdf4abeb6..95bcecf804 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -563,7 +563,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret = 0;
+    int ret;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -585,7 +585,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
                      "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
-        ret = -EINVAL;
+        return -EINVAL;
     }
 
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
@@ -607,13 +607,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             warn_report("Eager Page Split support not available");
         } else if (!(s->kvm_eager_split_size & sizes)) {
             error_report("Eager Page Split requested chunk size not valid");
-            ret = -EINVAL;
+            return -EINVAL;
         } else {
             ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
                                     s->kvm_eager_split_size);
             if (ret < 0) {
                 error_report("Enabling of Eager Page Split failed: %s",
                              strerror(-ret));
+                return ret;
             }
         }
     }
@@ -626,7 +627,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return ret;
+    return 0;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.47.0


