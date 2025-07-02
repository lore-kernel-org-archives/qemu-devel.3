Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71F7C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hE-00078x-NZ; Wed, 02 Jul 2025 15:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gG-0006SR-Lx
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gD-00039w-LT
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4530921461aso48390015e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482775; x=1752087575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToXpM4w8/5sKNrHHneMedU0DiOt+AW+hpLalmA9y/oQ=;
 b=tjFp8drcARWj2lIFPJ0bs/s8xVAaDplLTZOaLs+au4qm/5+eAxaT2sbn32H+nelFnH
 qvNGZ9G1JBtP62Y7oxclJB/WqVY1EbKxP3SEfwsAqKt34WcZ3I2NNJ+w4b3Wrbu5PX+k
 gWifZVX0Xxx7ivcNxD25M3HXa+qMSz/2Grttl2OJNXTlFyDeUc1rxy5NEZBbDgGeI9UH
 IJCZWEG4T9xn4xBZ4XEmZxg+fm+ygrKD3BDAFZqlZ4Z56tOUNTkpu6hqG6oHYSwWtun2
 Xl6JP9hTcH2ttlR1QBu14HiolETeVZpKoxgsSd/gSbF4QC+ZFiFIPMjgWwnpUGLFXBXZ
 R4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482775; x=1752087575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToXpM4w8/5sKNrHHneMedU0DiOt+AW+hpLalmA9y/oQ=;
 b=HYcNIFnJxFmdh+dHhowGPh9fPVvzFibVF4ehZh42V2dw2BweYexqw9yTBER+/0MuSk
 t2OsqTFmz2SYHupcx1AmhesME4M/VkoE8tMtTv4oa0o4rXn+G02i66LhVb/HpSQ92tSS
 MA/zoSE3XOBbqUqrFckQi4jRd4kYS05hnIEpAM1VhD5EHluX2+yYZgx2yL/YAaHEbn8j
 1GnoNDo2BPRc2t1TQQZOndfdDrKvk8WUjcFG41EAmDou3yF09VtjJaFxBx35Ddp2vLvS
 PDCV6277E0v+uT198M2pA9ZrWoxwyq2n0OBfDskHqhf8h4Yv9DiQsnQhrGoUaEZKFN8f
 w9dg==
X-Gm-Message-State: AOJu0Yw1jhkJ0N+bLkvDNycCZt2d/4/4mfAWESxkMTwokB3fBIsKy6Jq
 X8XcLRHJywJtvG7a62jDPOUhPFDosxYgW4sjKdkIJ8ojYIKwxy1XZ/0J6l5WgsyievQOlpJ2xNo
 xjO7u
X-Gm-Gg: ASbGncvLj7er5s5SxvxFS+gjAKHaw/KoDsy5h27oPmMJcRnwrqhxUAb+8BGwvi1XQDo
 qXACvABb19Ka5Y8eLK3H6C+XyG+84FgCT/V6NKcq+LQViKIefAv9BiDIm6+XWy8N1wwysUHc8RR
 WpRwKaT+FPivevOFQnIo6+zwmIabbOHv7/503TGIw2zHk3RVsdZac1nkmtr3VrsnpcgUtHc3XTd
 krAN1tOM38OXF9NldgcIMkCqo6WuuwI7vM/bOjM4unOo+OZ7gJibv1i5e0t68oPzHa0NQ3yLwqB
 G6H1lUFOPOPKzp9E4HIr/PAnH+RHBRINpu5LgXZl5TQVLlp82W/vlmWcoZTh9f2edRBKObuyQWI
 BKwpNR9k2A51mQjtJDSzvfTAS+EVflZfsb4yF
X-Google-Smtp-Source: AGHT+IGcleU2BExmeSNnNe4Qm+rWZsFT+Q42YV2sHKFD3Xq/CUYyqJEGaMrFdnzKpIfE8+vOW0prLg==
X-Received: by 2002:a05:600c:c87:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-454a373b1aemr38174275e9.32.1751482775247; 
 Wed, 02 Jul 2025 11:59:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99b6f94sm5555695e9.32.2025.07.02.11.59.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v4 51/65] accel/kvm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Wed,  2 Jul 2025 20:53:13 +0200
Message-ID: <20250702185332.43650-52-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 99f61044da5..841024148e1 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -63,16 +63,6 @@ static void *kvm_vcpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void kvm_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, kvm_vcpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
 {
     return !kvm_halt_in_kernel();
@@ -89,7 +79,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = kvm_start_vcpu_thread;
+    ops->cpu_thread_routine = kvm_vcpu_thread_fn;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
-- 
2.49.0


