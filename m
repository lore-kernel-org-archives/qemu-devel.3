Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C92EC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpSh-0004Gi-4a; Mon, 07 Jul 2025 13:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpN1-0005xL-7C
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:11:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpMy-0003du-QF
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:11:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453749af004so16684885e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908266; x=1752513066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5gveKaTQGbAOFhr1P2VwAZhRZKOx4EdeZA5gTT2oDQ=;
 b=jGOVA9mW9NDkr7SAROGiJ68YKS8cf5TTWye4yTdbT4HpR+e/MGHG7zdLgDTwZd/DRd
 5U5LOZ55bhY1ICm06lC46CJpq9VbG/0yM/3VUwcn4O0W90nQAAF9fAK0wRIrS5OWGn9Q
 IoPHak5v2GMLyyKWbm7Affc75m7q3hWJ+/rFt5/GwplBi6BWS8Igzmn5XONDBjvCsau8
 qMPV4nerWzPGlEC8V0rd1ButEDdhNIizHwRKZ41nKOSTzsic3SzMcN722UNjruDWv68O
 3rogmyKkbJ/H9LTIOs1BvkxH23gXv0/h69oO+dNXgBweS8t4mU2BB67Qh171/Z8NRNem
 fK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908266; x=1752513066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5gveKaTQGbAOFhr1P2VwAZhRZKOx4EdeZA5gTT2oDQ=;
 b=BAuCqxktNEJ4xleqhCtyW8hDqWwsJfVAdeCmP+lJDFqiTP4wf5Urt5JuN9uq+L9EFp
 2i9V2YFgIBqZdmmo1SeS68YPixrXWxOCBgCqXYddrvwIfLadhpNAGKTuD8f3JEDsoeu9
 1elmY5korFD3ryQntthp3ErQs0y5HiM246fFG15uvU9ROFykOV58MUWApWbSZlLN/uUt
 pwZ0jMsOABJkORiDWk1/vM8i4hHx2drlQvXcCYJToyjFW8aj+oa+7cVpHRzqionMqrvI
 HVGNroa3A1u0XvV694HbEhhvic9yDxLMipBYxjwUYOq+q6sdR25QYx2SyOp6PJeUOWfe
 6cbg==
X-Gm-Message-State: AOJu0Yy1/ybMW6Ni3FwpNzAEDFL0m2slxyJYae7spKMSJNqROh4wH2yQ
 PRgIBSkoMnP6qdSLAA8wjyY1DB0zzqpMrDUeo0NBxxbQD87/B0+3mrUIKrUfM5PHLRbirYlgQC6
 5Zu1xF0U=
X-Gm-Gg: ASbGnctCbreYNBW5TeJ3a8HjjxPBLEX+Us8d89rJsAIMtoW4dOtKoVjiuxqnQBHMam/
 dzWNQOTbCi5td4VVwt/C3NuZQABOmBBN5MlHFgSNidI6FWdmSKByce+rusBTZ9bDR/AYMo+5geR
 eEL+hEjgE+zE0pkqVO450lvqG/I78lLgFnvxpsmvFkZuXmdiZNXTFEUphSHN9ZD/M89nVhwoSgk
 X9ueRovpU9JiCndIlurxcNux440YzsA89dqRtg8/WAaL5k222Ls26Y7ryueHYMHKPvlndI5e6at
 3xa0cnQW7iWFow9yT4R/UtMOwFw4BFXZQU1S+J7WTCxXKm59VB6a7VjH1o49EsVw34PMeTRWYjQ
 ix2UXH2bEqwvpY+84fXZZpx3G8jLxzzw5Lr4w
X-Google-Smtp-Source: AGHT+IEEb/h+UxgV3XqriG0+dkluAf1QoTdj7Yxw4hd2kco9TJ1Bx9m0kZehwLigc9UxJDgaeKM60Q==
X-Received: by 2002:a05:6000:310d:b0:3a8:6260:ea91 with SMTP id
 ffacd0b85a97d-3b49aa7ab3dmr7115912f8f.40.1751908266490; 
 Mon, 07 Jul 2025 10:11:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969409sm148563205e9.4.2025.07.07.10.11.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:11:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/s390x/kvm: Use vaddr in find/insert_hw_breakpoint()
Date: Mon,  7 Jul 2025 19:10:58 +0200
Message-ID: <20250707171059.3064-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707171059.3064-1-philmd@linaro.org>
References: <20250707171059.3064-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Since commit b8a6eb1862a both kvm_arch_insert_hw_breakpoint()
and kvm_arch_remove_hw_breakpoint() use a vaddr type. Use the
same type for the callees.

Fixes: b8a6eb1862a ("sysemu/kvm: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 67d9a1977c0..491cc5f9756 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -889,7 +889,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     return 0;
 }
 
-static struct kvm_hw_breakpoint *find_hw_breakpoint(target_ulong addr,
+static struct kvm_hw_breakpoint *find_hw_breakpoint(vaddr addr,
                                                     int len, int type)
 {
     int n;
@@ -904,7 +904,7 @@ static struct kvm_hw_breakpoint *find_hw_breakpoint(target_ulong addr,
     return NULL;
 }
 
-static int insert_hw_breakpoint(target_ulong addr, int len, int type)
+static int insert_hw_breakpoint(vaddr addr, int len, int type)
 {
     int size;
 
-- 
2.49.0


