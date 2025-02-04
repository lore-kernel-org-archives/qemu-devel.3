Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C051DC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQsA-0001cK-15; Tue, 04 Feb 2025 16:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrv-0001YK-3V
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:07 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrt-0008Tn-B1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:06 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9bed1f521so2040696a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706044; x=1739310844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4SBoep/xPxJrFv8mDouvokBTO/0tkAwIyQsgJPv3zeU=;
 b=TtSo2SOZ94dC+1/ZBNEG4fJeVBi1QWwJR7BfQrLs7TVwlE91ShxTNfhJxfhMS7pJlr
 K06b3osStVeUT3rCB39MRCak8xUX5I3ggNlNrQ0vnOR/GHgS02elI8FG7aFJH0LIKZ8L
 mby6eLEkqH9VBxmCtEpijrd11wEKgRHLK3puOWZyP24qlghdXMBnTk5Cxlah3YjQJma9
 6yK5muqknH4BiUttkFvqGZEEN0+ePNUOHB6wl8nkdzlnZnLUSrSqZL/KHwvk2YO20shJ
 9bCUnoUELaXM80mP39hi9eB43kUON7tpCJIvv+4AI8A5XSYa/+Sl/RqzWfTpmvq7BKGB
 mQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706044; x=1739310844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SBoep/xPxJrFv8mDouvokBTO/0tkAwIyQsgJPv3zeU=;
 b=ptQ6+WcZ6cd/kfLx57OGbMeNhSJYc74SwpYM9FQcjC8lB4USn47MXPe3WenHY1RWNs
 L9sfemqBhJyIzyw/Szy/tmKKfuFR7fQX/CGmOsEFNq73hGqJ8+4wAtOTtii7aM17TetA
 CJwxLXt2wP9/16KqFWzYyxlcjVZuoF8Ky9gSfKVUOqurKKMRXsy8h0nbQFLPMZrayE2O
 efksmgfsqWv8uaMUBxiWDEoYOB/FZMuOKbdjS9j+aIJ7aEuLffrVC+D0SF1e/HXI/jQQ
 82SGBtlXkAb8SJwIL6+Q5pW53VTaoNwBMu4UkHFo5/kd9/fRsUy8ECa4gGholDPU1ADP
 Hxnw==
X-Gm-Message-State: AOJu0Yzv4/ZJ4fGv06PFdYhYcmKZcJ8i43dAGfdrdD6BQm7uOxBVGhe4
 Nt/wwBuE+PNJOusdvX8wnpldT/2AiNfLFgnOH4hn99/YwUGa16i7g4FjuMuqP+qK/EuvdqiHWrI
 c
X-Gm-Gg: ASbGncu19CtyIfMbnl8b7g+8XTO0x1/ZCM30QQwz2yab09xrbrHu8lYTtuc4C+Z9d7r
 QW6IkSAQHMsupvQPBCK5aylr5HWIy5OwGmYWpegz2O5P/mJjLlVwu9m1r4QQBx8Ja0iMrRHQasy
 5u6MQ6cyBcGQ/B6uAIzUHI/N5qAP91z54+yBEDG23JaJf1yQwqM9DzZ7rHlJ2wkhsUReWXuaxEz
 00juwtSf+8I7Xmbl+lrq2TjIPah5tDLFKQ98xGY6KRjbx5DWlKHI2DPnd4zjljyebb6soE06vud
 DW3gqCYcWp1Ngul1m4MDGkVMkh2IaUHLqX8hplalDwA9rK8=
X-Google-Smtp-Source: AGHT+IHcURON4+jqS5IUou39/iLd9DoK4HF+wUKFbn/PsbvJhxci5s58lgd7oURevLr7mJc9tEZxQg==
X-Received: by 2002:a17:90b:3842:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2f9e076162fmr603578a91.10.1738706043725; 
 Tue, 04 Feb 2025 13:54:03 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v3 04/12] meson: Disallow 64-bit on 32-bit KVM emulation
Date: Tue,  4 Feb 2025 13:53:51 -0800
Message-ID: <20250204215359.1238808-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Require a 64-bit host binary to spawn a 64-bit guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index b72114819b..5a40a2a629 100644
--- a/meson.build
+++ b/meson.build
@@ -277,21 +277,27 @@ else
   host_arch = cpu
 endif
 
-if cpu in ['x86', 'x86_64']
+if cpu == 'x86'
+  kvm_targets = ['i386-softmmu']
+elif cpu == 'x86_64'
   kvm_targets = ['i386-softmmu', 'x86_64-softmmu']
 elif cpu == 'aarch64'
   kvm_targets = ['aarch64-softmmu']
 elif cpu == 's390x'
   kvm_targets = ['s390x-softmmu']
-elif cpu in ['ppc', 'ppc64']
+elif cpu == 'ppc'
+  kvm_targets = ['ppc-softmmu']
+elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
-elif cpu in ['mips', 'mips64']
+elif cpu == 'mips'
+  kvm_targets = ['mips-softmmu', 'mipsel-softmmu']
+elif cpu == 'mips64'
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
-elif cpu in ['riscv32']
+elif cpu == 'riscv32'
   kvm_targets = ['riscv32-softmmu']
-elif cpu in ['riscv64']
+elif cpu == 'riscv64'
   kvm_targets = ['riscv64-softmmu']
-elif cpu in ['loongarch64']
+elif cpu == 'loongarch64'
   kvm_targets = ['loongarch64-softmmu']
 else
   kvm_targets = []
-- 
2.43.0


