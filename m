Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9406C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kva-0005L0-QM; Tue, 29 Apr 2025 09:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kuj-00056o-UK
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kue-0005fJ-02
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so50311135e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745932928; x=1746537728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mr1QFeW43XnVmNc1okA19chi54m5Uhrocgufe8XGZeE=;
 b=Fimfy1hZCqj9dBy+pnD2LXz+giyQ9NXAKMy6tAyh4DsLYAKRfwirGFyoHDRv4b/wPB
 IJ1xHveMe3WFvfDJb7JlgbuBDMy3QF7MZTNj9MIUux7tJ+dQO8cvF9oCBaYH9yrFGX7s
 UFILSyfbT+c9Xoa8Edk/u17Ar304sACafKuZOUYSwYvTU8VmvGeH8ruMiy54Cfz33GIC
 WA6EfusRYthay8E6JaTSHKys1P+9EJvN2fj0z26AxqcLp7DnWLgkZFQEee7XRDouo+it
 qNVe9+54JWdL3zIt8snBvs+Rao5Lf8YoBSyw/U6kZd3d4nUyLUPgAhhmPd1O+xupaqCo
 AafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932928; x=1746537728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mr1QFeW43XnVmNc1okA19chi54m5Uhrocgufe8XGZeE=;
 b=d3MYoR1RQ3GBjfKLwhYwgiVsvr9l1rZJibQSyG3Ur/pGGhH5WN1QK3PQnBDWRpUl5k
 faV7GL24Sgi8t0jU4vITf1E6raRemNNXUvGUTtormSvT7g81I29gjHu/Zvf1KtneICft
 Jg/OWmFObr52oVwpZufHVNf0eYs9jPzfwNU7CGOqPKVJ60Jm46aNW5Hc7t4DcOjqd0Ke
 HUlVaCdXHfFWozvaUf1kXrFE5phusV8EkUNjJCFA/TciMAhl415Mq3CY2ngevfQoRz2o
 S77P1gSw3KlyMSjvBAdTVBc22DeyPdSIP/E1Few4VBNPhdyi+dKmOc4ozMDaSDuIXO+z
 fe4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9BbqDM960dpI5GkKQMiZuhWH5sxmLPjeIsqLbFqWztXH5rsmpNa2nmwcmcQsTvzhpgwT6xPbwQS+i@nongnu.org
X-Gm-Message-State: AOJu0Yw80+rTqMkAO4IsdUXjzQTJ90uKKHjAjakY0OcMlzYeHUDYX+X6
 Z/9tRg+n3gC32B3BPfDbKdbKUJynRChzG5it89EZQ44TBi0wCdpYmFUuZ/65ueg=
X-Gm-Gg: ASbGncvbNkzrya2f3xVRT4DVwrWyd4vPkcIr6oZzDMHe+k9tJzweSI9lUPufJISU8+N
 Ic48Tp5kVm064rA2Z5eR8hCOq7seAAqYaX9Bc6FRJeapyXqo/u8dk+vuWq7qaDGS8Y8UD5J0+TU
 ysuIBmvpD7sVBVtq/9oDoqgjnxT+B2lYdWfZXf3pY2DLXjERBzLRqanOCZXaZI0ozDB/er+Hi6J
 WnaAU6BE2Qf2/A+YOXhk6PhiN41QYCqdosgKUwOweH2WDbooHOR8VMOuyLwqgdo3nj37hV42S8b
 axBoaGBwBNZg9+As5OG14Y/dB6698BTc3nZxGvrVEY44hGU=
X-Google-Smtp-Source: AGHT+IGoSlHiKAShjcrV1MgStiD56C1mdSvfZ63iAgONLbUgcMMgkkLZ49wM8r6bSlv+p8zPQk57tQ==
X-Received: by 2002:a05:6000:2a1:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-3a08a516363mr2851581f8f.8.1745932928518; 
 Tue, 29 Apr 2025 06:22:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm13729371f8f.27.2025.04.29.06.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:22:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 6/7] target/arm/kvm: don't check TYPE_AARCH64_CPU
Date: Tue, 29 Apr 2025 14:21:59 +0100
Message-ID: <20250429132200.605611-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132200.605611-1-peter.maydell@linaro.org>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

We want to merge TYPE_AARCH64_CPU with TYPE_ARM_CPU, so enforcing in
kvm_arch_init_vcpu() that the CPU class is a subclass of
TYPE_AARCH64_CPU will no longer be possible.

It's safe to just remove this test, because any purely-AArch32 CPU
will fail the "kvm_target isn't set" check, because we no longer
support the old AArch32-host KVM setup and so CPUs like the Cortex-A7
no longer set cpu->kvm_target. Only the 'host', 'max', and the
odd special cases 'cortex-a53' and 'cortex-a57' set kvm_target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 97de8c7e939..6b2c788e0fa 100644
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


