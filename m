Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF31BC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdTM-0001Dj-E9; Fri, 04 Jul 2025 06:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTJ-0000x6-6G
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTG-00070D-Ka
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so663433f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624200; x=1752229000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hfrsLuv7BgUOaclFfgVSuiyNtp0y1WW2rDAJ5uN4uD0=;
 b=bIcKFzRYRXQZOEENW7SyytLh45EtYPAxcIQOBENsVHZNyCP4UTgs+mthb4NZIrmGRo
 HoyQhw8BkC3jWztwDH+LxNPMPkqGV/mUlEd7c5Z36XBHbT4j5YLPyVLvIKi3Yq7oZvgf
 1pi4AwsNrYkX3MaX9sfjEtbLRoSounQPy4NKhSw8uHvo3FGPj06S0XiTv/KgSHZeQKtT
 Gy11tjUmRLxza8P9KVrFIghf05jgttZzEi8On7r7jOdCc6BmrkpnzjO65U17aimSj88g
 OAnFqhgug23KMUx4zkaRF2+vmaC7x6kv6dr16YTnlooXinqvuq0UBGM0NvxC1WfONSE7
 3f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624200; x=1752229000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfrsLuv7BgUOaclFfgVSuiyNtp0y1WW2rDAJ5uN4uD0=;
 b=tBSI7S1YP7+RUYzTyj1AxKHb5YDqtrCQBk9m3XKf6FcCNq5zJPqTmZ84fq4x0vkAJt
 1SebPxtByxnsVyZQyiOJxichBw8YQKPOOXa8B17xAK/NTTNs1jU7LN4P8YZDi4r+6bHz
 fEzgUrHLTouPRdBV7vj1crnX0e1xg0Lz3pDGhPsIoQm09CjZjVEBKUIsX5IrsjZR+YV0
 h6YaYO3FH6HgbVEbaAdRhL8Phr5hSBQlVgooTYVd3pa3AF3SFVhLZFbnb+bgkKP/1p2T
 PweC9KDOrvDcegeR0MH9lt3Ekwjm9SP7nrfHx+sZXnCgp9TxE7KHB6ZCwkJMloka0HL9
 Ghpw==
X-Gm-Message-State: AOJu0YwDCiq/Yac/LLryZ5cUJgr95sY0aAKg3jTomvNmzSGfK/U72OJ8
 LjSS+j6iF8GyxBgikRxgVrj+TBMLuUhwI9u+kDLzITF8H2XMkwIs7vX90EMTU+w1iyzI3x4Ctb5
 KTEPqE5o=
X-Gm-Gg: ASbGncvda+RQu8E0pX3OY9YjE/b4VjpqkExVHzWUu4+StXS1IfDbNlY2SVBiqjF+R4f
 UeqLRifiHR+H1USFV1q1h5H7niguqHzcjWfD43juDvDu0PMmHbW1/AWI97CMJbusuARsAxJEmlv
 j68qsylA42IZXbWuFBGpUUd99/jDGRHD/ctdz7SwusYEJKgLicrC4kdmCQ0wPVrl0F2X7k/YFTc
 qoRnfhFQXubP5jON4J6VyxUxflPj9hUICZwI01KRuZPZ2qyWsGozsoLKIl+3FCMV259mkJOWJq2
 6520yl0SrhNBGnbktcv+9NuwrA2ddctoMv5cbaLQcd4Ty/q/XHJRZqgUd9EM/Krs/mxhR6vji3X
 TSugRngMzVrvkLo7egZ5LQje18AhMybjoGybv
X-Google-Smtp-Source: AGHT+IFhjjD1fJ3Mmkf5v4Aic82arylXmH7pkAVhhA0rhGdmccvT4OG6wHYBqU/Ki6VMQzgqm9XJQg==
X-Received: by 2002:adf:fc8f:0:b0:3b3:a0f6:e8d0 with SMTP id
 ffacd0b85a97d-3b49661a129mr1453315f8f.54.1751624200412; 
 Fri, 04 Jul 2025 03:16:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96731sm2115383f8f.55.2025.07.04.03.16.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/31] accel: Directly pass AccelState argument to
 AccelClass::has_memory()
Date: Fri,  4 Jul 2025 12:14:28 +0200
Message-ID: <20250704101433.8813-28-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250703173248.44995-34-philmd@linaro.org>
---
 include/qemu/accel.h | 2 +-
 accel/kvm/kvm-all.c  | 4 ++--
 system/memory.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index b9a9b3593d8..f327a71282c 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -46,7 +46,7 @@ typedef struct AccelClass {
 
     /* system related hooks */
     void (*setup_post)(MachineState *ms, AccelState *accel);
-    bool (*has_memory)(MachineState *ms, AddressSpace *as,
+    bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 007f82a50de..6f6f9ef69ba 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3786,10 +3786,10 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
     return r;
 }
 
-static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
+static bool kvm_accel_has_memory(AccelState *accel, AddressSpace *as,
                                  hwaddr start_addr, hwaddr size)
 {
-    KVMState *kvm = KVM_STATE(ms->accelerator);
+    KVMState *kvm = KVM_STATE(accel);
     int i;
 
     for (i = 0; i < kvm->nr_as; ++i) {
diff --git a/system/memory.c b/system/memory.c
index 76b44b8220f..e8d9b15b28f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3501,7 +3501,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         if (fvi->ac) {
             for (i = 0; i < fv_address_spaces->len; ++i) {
                 as = g_array_index(fv_address_spaces, AddressSpace*, i);
-                if (fvi->ac->has_memory(current_machine, as,
+                if (fvi->ac->has_memory(current_machine->accelerator, as,
                                         int128_get64(range->addr.start),
                                         MR_SIZE(range->addr.size) + 1)) {
                     qemu_printf(" %s", fvi->ac->name);
-- 
2.49.0


