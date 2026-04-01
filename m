Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9E1D35154
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w820v-0002K4-Lp; Wed, 01 Apr 2026 16:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w820u-0002CV-Aj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:18:08 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w820r-0001Z1-RP
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:18:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4888244e9f9so1010335e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775074684; x=1775679484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYDlzgPnnjYZuG+tzOHNfiGffF7GaOFfYwOhZf2SBPc=;
 b=ye+cowO3ELlTZRwNLkD4ko6fuWAJMYI5gRTdNcbGmI7YjDBeqnl6x5m6s/YGaJ4aF0
 1KKLImXdt+BwQQeotx7sm1iCilXyNDl5c5BD9Bzi2Zhu55FSfeLkX4LDXPrUS4YWiicW
 oRt/E8s6zQhf0PWFUbrmBZswuwkkVlW2BTQFbye1mYKvJ5jyOmNzuA5QFZpUcnCjXomr
 kvVqdPTH3iIbo+Q6av7zI5H84089A15hPlCSox2ki4OL8iyt9INIrod882zgfwuiqRyK
 gqb5z7tB7mdEHpQDFq/82PfzQVyHfBkTz8BEN2gjgnlL1Q9tFuFqxwZK44V4kaDGijgD
 JHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775074684; x=1775679484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jYDlzgPnnjYZuG+tzOHNfiGffF7GaOFfYwOhZf2SBPc=;
 b=rUUpo8zD52k5/37qZ0oCLDRHwuiEFHW83zkdUu1pNapzbz/hpMJVMzEHy8UGT2yiNA
 cYxn8oZ/OlbW6n42VNfCAjWbBNcnfiCJgMNgACDk2Zzrh3P+e/6Y4VNTVu3WhAHrxzCl
 lzGHk8ML6KNN0ZQuny2KCJRS8LVOGQfOeP09egqnP+UXB1WR1PYYfCpfkZvTtsCXm2zy
 lab9/BuIKpOqXXVgPboQOmNiKpot3mmzbSNH+AG3v3LVyxG/4mGL+J+YVDf2ANKC/FJo
 XAj07ZrNgbGfBNX9F8NKxUrEBsQlTVxhXXZcv3e6xBHa4wy7dRmUnC0qEGsGE/aG85ob
 a8/Q==
X-Gm-Message-State: AOJu0YwVFY4ULwKo9bKpwA/9ObfTDiSRh6Wldf0PM4OEKD287a46vuoX
 wDE0GxbVsX4c7CY/po7PELsIUcYdes0xrxPRbwkEgwZw/ImUko+MkvtsmRCUF4usAWE8OnRN1I6
 q2zor0mw=
X-Gm-Gg: ATEYQzxbikgXjNlgQjvBk3wIk6vtuFPGYKXJWP606FOlBuIZkQ5WgPSi8NLSIpankDe
 cZI6RkyNTfsdU+jJDqaj5ETiAQ53ECRj2O1eAnEcWJ42+AvSrTsbgwjA/xuB88SDY4qBFT/07DG
 kIOSBBmEDlNAAdBGrLQRSqGe7lahTPLsxaXtJgcXG1kwcLZkieQ3W6JMPoJIJ+HO76ZccZGBzYl
 eL+XMWgQEb0cYi5bw6DuomddfHp4W/M8949R1cFrHTqubCfS0QIL7VLzpllKD4ZUW38Lh0ZlQU7
 lmT3/s3ASshgQCtbH7zTa48TMx6jpeXIqS8zCll9Fn4g7zxH38GwYGnpeDkyJwxYM6UHdwOCKaW
 x+wAYTy+XFeLIMUsbQELPQvq02TYuy5ht35/+Rp+I+8ZLqj0ua1dt78VIjcNQpT6W6EUWujbFMW
 8DdoU0IM2h9dr8Q/h5oonFORJobYIrGYJf3BMP3xJVxt4ewm5PR+IfP6ewmxTiQetFXRdJIbrVb
 LlT1XLbHXo=
X-Received: by 2002:a05:600c:41c1:b0:488:8b52:f7de with SMTP id
 5b1f17b1804b1-4888b52f8d1mr6554095e9.12.1775074684000; 
 Wed, 01 Apr 2026 13:18:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e952b0bsm126418075e9.12.2026.04.01.13.18.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 13:18:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-riscv@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Anton Johansson <anjo@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 1/8] accel/kvm: Include missing 'exec/vaddr.h' header
Date: Wed,  1 Apr 2026 22:17:45 +0200
Message-ID: <20260401201753.92290-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401201753.92290-1-philmd@linaro.org>
References: <20260401201753.92290-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit b67be03e3ac ("accel/kvm: Widen pc/saved_insn for
kvm_sw_breakpoint") used the vaddr type in the kvm_sw_breakpoint
structure but forgot to include the header defining it. Do it
now in order to avoid when refactoring unrelated headers:

  include/system/kvm.h:404:5: error: unknown type name 'vaddr'
    404 |     vaddr pc;
        |     ^~~~~
  include/system/kvm.h:405:5: error: unknown type name 'vaddr'
    405 |     vaddr saved_insn;
        |     ^~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda3..12f7fc8fb58 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -17,6 +17,7 @@
 #define QEMU_KVM_H
 
 #include "exec/memattrs.h"
+#include "exec/vaddr.h"
 #include "qemu/accel.h"
 #include "qom/object.h"
 
-- 
2.53.0


