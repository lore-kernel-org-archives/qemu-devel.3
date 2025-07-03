Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D10FC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNr8-0001II-4m; Thu, 03 Jul 2025 13:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqv-00015z-Kc
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqp-0001qy-B5
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso9296065e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564157; x=1752168957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kY7uW5JX/anEAPOjEFSJRgZ/Z18sVaGkA4phFJT/u8=;
 b=v1lZdTMycv7UDXjNjS4zRl0gGuOzVbS2GyJD+D6cyGlj1dLBG7HC3ViHI8olTsI9ky
 f6qOTze3yOXlIAvGeOv1Jw+uefjxpND3hJ3sKJd//NYb2/PB9OyQykwkii4sIqYuq0TS
 o5VqiL4tBIAjuuDa/kC3e2oaES1PQ7tlxzzGX8lUYLsuwXdZAgDgz8lVQU3Rmff0HzKq
 LkGyrMEEBrGQQd2vzTMmrVQqfgspbayoehNEwYYFvQsdr9fNhM1d9JZqX1lk3jbR/JO8
 QABDzTkcdvD9Blj5xN6vorULfZUc/1ocES+u+TJGqHkGl4CM8PmBEkEzgQlt++p1JUc0
 LEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564157; x=1752168957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kY7uW5JX/anEAPOjEFSJRgZ/Z18sVaGkA4phFJT/u8=;
 b=br1XPTmWjS6E+hC6Kk1wxB6rb9fuvHOePKU3cGPJGdU7O2dzGNSV0n58QO0TtuPnP4
 xd/rG8nuj2RIZho4AVR7WubxeqAk2BT/yH+19/DE9fqSQ82iTM104g2+8C+WqJZUe9JG
 73wPhkfyqPDhzaq4WSUGpPVmvCaY27DL2zpGu42HWv9/Y3y0yPcjXlfyC0wEliIwx3ys
 O6uzWbEa0hcLqIbYN+72THGCB+/52Aa2OmWOqmhRJ05jl1553d4a+ZrxtWH8hUw3NgaD
 G/yzmo7nAlrfQT2rvRWLs1BXfoxHHxFBeiB8EF3i4kuEY7dG4exp+ohFM644egEtpw2Z
 YMWA==
X-Gm-Message-State: AOJu0YxiBVMDoHJCIIHZQZY03fqdhqdqw5HXoY6DKz7Q+kAFYazTtDVY
 qDorMRxzkFxPQ/pFJ0FGZayxmCmXla3BmsuODbyVHQu6BvZwK3Bl+A+triZv3Yj8yPFMq5UvRmG
 Fi9Sp+UY=
X-Gm-Gg: ASbGncujWAH/KbBrcpv3nKTp9O0PqTEk3BspMuwL+1zS7cwCIfmgvPxSeiMpurR2fDU
 Guufi66Oo924k1HZpXAgxQBCA9EmTZIakX6anmzcWznCfrW4gAZIaGzMde5Z/94bLtbN3nfFqML
 1+BUpKjrNJq6zsQewEw7JYldJKCG01UsMssTedf8IBpJjmBISoPByEipmEeoJCBh/Fiy3ifB0jD
 iow6O/t8jS+RWxWVOVXVhPejwuRKW/+lWPMYhLUv5Kwbi+4kO+8SdoTywtvHGPsuIEQOniZNBMr
 rj9sLpDT5bDT4h3ea/yO5lb/FZMp+qvYLViqQuV5OfF/JKQYplzRfm/5RpxrTaNB3VpfIPoeoVK
 MUjLlRnaPiS36moGXRcv2lD1W6pYC/Xrjug0K
X-Google-Smtp-Source: AGHT+IEJthAlUnsrPZh7yceFyiLjMsbF3fhEwKPu5c0UU1+XM3fol5UMo8Y8THxiFaE4vLlTRN08ow==
X-Received: by 2002:a05:6000:42c2:b0:3a6:daff:9e5 with SMTP id
 ffacd0b85a97d-3b492c3d957mr48154f8f.7.1751564157347; 
 Thu, 03 Jul 2025 10:35:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bead7csm31899885e9.39.2025.07.03.10.35.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v6 34/39] accel/kvm: Directly pass KVMState argument to
 do_kvm_create_vm()
Date: Thu,  3 Jul 2025 19:32:40 +0200
Message-ID: <20250703173248.44995-35-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0cd9b2f29ab..f1c3d4d27c7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2470,13 +2470,10 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
-static int do_kvm_create_vm(MachineState *ms, int type)
+static int do_kvm_create_vm(KVMState *s, int type)
 {
-    KVMState *s;
     int ret;
 
-    s = KVM_STATE(ms->accelerator);
-
     do {
         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
     } while (ret == -EINTR);
@@ -2646,7 +2643,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         goto err;
     }
 
-    ret = do_kvm_create_vm(ms, type);
+    ret = do_kvm_create_vm(s, type);
     if (ret < 0) {
         goto err;
     }
-- 
2.49.0


