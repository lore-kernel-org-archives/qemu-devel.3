Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AA1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBSW-0000q2-Qw; Mon, 17 Mar 2025 10:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSF-0000es-FW
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSB-0001Ck-6l
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso15639525e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742221709; x=1742826509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w7WKqYLy7NEpjkefHXnJSfu6zGOyWq7eC8uKJPQR8rk=;
 b=PezYq2v3+2uzC+l3+J7jMyxj4kb/fdEgmf75MIuQ+e11TMJVtOQ4QUdjQ1tC3tvRxY
 aXNN+mtLgqqviVhfsLt+yyiozLTTSeFojRPLKXtjHEX6nVAQmpT0rW0QzXLqB9Tyxs4q
 PYqgU+AjJaMBUwiLn2pW8ub6gzIh2Bv4xx2l1I4JCPrzYXvHxZChOKcIT/gVilBc7CMz
 ntFOuYbKgUfH8giBunbYoMLfmoG3Klz32dufecUk75JgK0koi5f/1QqMQKzOJK8KB3fw
 uJXH+zeZUb7xSKmUbmJFuDK9nWGGFunugDtPBiEGgqyduinBX1aSJX8qzq7mOHJhGIck
 wOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221709; x=1742826509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7WKqYLy7NEpjkefHXnJSfu6zGOyWq7eC8uKJPQR8rk=;
 b=bl/sb3Sao9nOi87UliPDvPIqYlf/kdtc8XSTC7OR785Fo/tbJvcEcAFt1Bm4CtdBl1
 tOu8wgJA0pxzStiFX1tHILn9R/V5q7m+rmTBhCcENcG4ML5p546n3+PomdCDky4e8aXd
 x9RvGLXXjtOuPurhy70PoOwhr1+l4xc5BXu3cjFvlDU/4KcSAgrcClZXzeR5ehINtFiR
 KujoON1gGeivHD/AyVk3jb8/+jXrTmg5WYO4D+9i461opk2w1fyQ8ex42mkl2H88iV5D
 EPaZhFAdgf+8xdEqPiLay7s9/LpWLRv0qj9IhIMTKudvX/hM92VjrqhFI1ta08Wp8fcv
 Rtog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF2hHDOYRt3bq7ECGeBRsb5zli1bhHe6ImwT5DpJ1iw/GyziXx9RtqoHib5AXAMFS9TQzClJcikjMC@nongnu.org
X-Gm-Message-State: AOJu0Yzee9YKNGmFm87RyxjQv0ozAG1rH/Ck7225RlLunej/GfiXvutQ
 rC/hbemO58rRWr8zxs5pMfeKUK51qAyNqSWliPWgGgqX5WxKzV7KJns+n3qkhtU=
X-Gm-Gg: ASbGncsyLJQSezeA5K+y3e5315cts6oGe5FvRXh97pP2jb9GtvmWy16+NcIHFYhcVte
 Zg6V8uUwiF22tciRLcvT9qitcrgRJd383BIw6KYSSLAnWXCXLUIW4w+DZ+4Y0kouOPCwHtM4a4H
 4uwyX6korqEoyzKt1h2jpaj0U5h+XJiK2svTQenY7H9VnHpjeHck/ifkN6HN5fySWhzbnE75QWf
 4BsAK6ZZ7V7N6ONcHKShBd6nfjrrbs18/3KgjDWyOJ07JliBejSV9rHDA4YfC/YuhwtfSCO/80U
 5o8Lj6MNbu3CvIiOpmMHPnohRNLcbeUN4W1Iiyjl/RHY7PjOWbk=
X-Google-Smtp-Source: AGHT+IGteN4Bi1WBu6nBwMrKa4VYjQSO/0ELq2zu/dSlQ2PFYdag+Z9iJ4ZF/MX8mO5OUpYbpVWV/w==
X-Received: by 2002:a05:600c:3c9e:b0:43d:ea:51d2 with SMTP id
 5b1f17b1804b1-43d1ecc380dmr145325795e9.14.1742221709423; 
 Mon, 17 Mar 2025 07:28:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60ad4sm107914985e9.29.2025.03.17.07.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:28:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-10.1 8/9] target/arm/kvm: don't check TYPE_AARCH64_CPU
Date: Mon, 17 Mar 2025 14:28:18 +0000
Message-ID: <20250317142819.900029-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

We want to merge TYPE_AARCH64_CPU with TYPE_ARM_CPU, so enforcing in
kvm_arch_init_vcpu() that the CPU class is a subclass of
TYPE_AARCH64_CPU will no longer be possible.

It's safe to just remove this test, because any purely-AArch32 CPU
will fail the "kvm_target isn't set" check, because we no longer
support the old AArch32-host KVM setup and so CPUs like the Cortex-A7
no longer set cpu->kvm_target. Only the 'host', 'max', and the
odd special cases 'cortex-a53' and 'cortex-a57' set kvm_target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb234..7418eb57537 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1882,8 +1882,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     CPUARMState *env = &cpu->env;
     uint64_t psciver;
 
-    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE ||
-        !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
         error_report("KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
-- 
2.43.0


