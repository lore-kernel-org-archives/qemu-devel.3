Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F31FCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzek6-0001T8-Gb; Mon, 09 Mar 2026 13:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzejs-0001Db-CQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:49:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzejq-000300-8f
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:49:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso5318525e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078592; x=1773683392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfOU74AZsB0BJ+9t5I5qi8V7Be00GDq0IJGiovLZCOM=;
 b=YqsdUAusbiH0xyBqxZK/VoSXtCcFNSAXPITsfQpzMhYN9ffOrzvRxSEQZbWbHGmKYf
 g3H/8zGAW8gWGTAwFMi9tGQt8svbP45gUMqiIGOybFsKRY2DW30He5mJDwCWWDJ489bK
 uDRlatyElGq7QhSmER9QUJcplkS/iNOHjvhHphRt0uimFYhzFa5Yvi1NWNaDtv06A2bK
 NIVwwIgIViQoMnaL/l2GDnvA/K+gWNjpvSeAyyUuC0eK3e5q846YT2wXXKaZ1Z7S7Kgp
 mBUNgKUPreFzVyq8cVRgznwL2W8i8uSWErsqKqZaMp23v5OLrKbn7th6vYeJiUi/np58
 ceIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078592; x=1773683392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FfOU74AZsB0BJ+9t5I5qi8V7Be00GDq0IJGiovLZCOM=;
 b=VgGAAnms+sPvzDQG2yCUGQEmKYdH9v7kp2wE5ZD7nEVjM6feDx3+GDhW+SWd7c3ckJ
 HCzbDuQXSA6N6IjvnTURr1ivXDx70SIApeAfpw6iJUUbda9yw8lhVkAjBdIiqf5MQMvN
 67ZTh8CRWoXQmlMVNfs3nfh57pEqNN/Q7RQW4UZUCdZQeL30Ly5WmHzQXxhATQS4KcGv
 O+A/rOww0NzgUyErcFCVeahQFXt1bkc76PBCRUO2YEvSXIepg0EFDw/qYMZQI1LQ7jI+
 L3wic20Z8Hh1mHpLnPgFSSgKrWtX+HnAUcbZV3Pel8UbjBwvTXnlxbJro3PlPcQQ0ZCE
 iVcg==
X-Gm-Message-State: AOJu0YzLnFT+ngrrKCJYx0B3pu1pzMSzCF6oJOd+gr7SQwWzL9eHJJBU
 UPBxGc59W7ydkAEYviTKOqO47B5juLVA3mGWq32UDeBTzFJFxPCxogEMsxJeRKpDa9mepB67UXd
 56QFf7DU=
X-Gm-Gg: ATEYQzzY82mu/Xgm2Qs+yB6LoVahvBM+PZICBXjw8qfTqPfA0uAs1cSCApLDrc9H/J1
 57aOhh/Y+Vmd8lnK3S5w0O7fpvN2A6DQUxNLfAYXImyrBuV11hrTx6w8ly7dwnB8n8gJw+bYX9B
 Rjp8gV9kFeGAvYuieme1SWEuPjtfGRIQg6t2AQmUQuQyFvB7TD5SR0237hHgLnie+V7LRcMMfyh
 8nC9C3RgPR+CkoaCLLXCUqyICbUevIaXpcAvM8aLq2nzIoC0hUx+ApRa5n424B5SMbx69xFf7xC
 TfoEtFjlCtN9J8Dk3k+1FPSMQAcnOPO/WNNeNJfG1XZ2cc16Z8Jrd/Twa6DC6/Rg0QQ0ThJtbor
 K9B8TmSyI20jwT3uxnz9nBwaKnA8Wo5wsi/Y506uhd5Gv1Fh2PLP5GVhgVaynL962MiQ9DcrP1m
 vijLITifzwVz7rlANyp5u6gfyawtFhSSTuIKp4ggZq5Tj0gRCmfSQG8uM2JE/3py0DqZVb1XB1
X-Received: by 2002:a05:600c:8b01:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-4852691989bmr200833445e9.3.1773078592217; 
 Mon, 09 Mar 2026 10:49:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a6bbcesm7670835e9.3.2026.03.09.10.49.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 10:49:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] system/kvm: Make kvm_irqchip*notifier() declaration
 non target-specific
Date: Mon,  9 Mar 2026 18:49:40 +0100
Message-ID: <20260309174941.67624-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174941.67624-1-philmd@linaro.org>
References: <20260309174941.67624-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Commit 3607715a308 ("kvm: Introduce KVM irqchip change notifier")
restricted the kvm_irqchip*notifier() declarations to target-specific
files, guarding them under the NEED_CPU_H (later renamed as
COMPILING_PER_TARGET) #ifdef check.

This however prohibit building the kvm-stub.c file once:

  ../accel/stubs/kvm-stub.c:70:6: error: no previous prototype for function 'kvm_irqchip_add_change_notifier' [-Werror,-Wmissing-prototypes]
     70 | void kvm_irqchip_add_change_notifier(Notifier *n)
        |      ^
  ../accel/stubs/kvm-stub.c:74:6: error: no previous prototype for function 'kvm_irqchip_remove_change_notifier' [-Werror,-Wmissing-prototypes]
     74 | void kvm_irqchip_remove_change_notifier(Notifier *n)
        |      ^
  ../accel/stubs/kvm-stub.c:78:6: error: no previous prototype for function 'kvm_irqchip_change_notify' [-Werror,-Wmissing-prototypes]
     78 | void kvm_irqchip_change_notify(void)
        |      ^

Since nothing in these prototype declarations is target specific,
move them around to be generically available, allowing to build
kvm-stub.c once for all targets in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 4b0e1b4ab14..5fa33eddda3 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -219,6 +219,10 @@ int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
 
 void kvm_flush_coalesced_mmio_buffer(void);
 
+void kvm_irqchip_add_change_notifier(Notifier *n);
+void kvm_irqchip_remove_change_notifier(Notifier *n);
+void kvm_irqchip_change_notify(void);
+
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
 
@@ -393,10 +397,6 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg);
 
 void kvm_irqchip_add_irq_route(KVMState *s, int gsi, int irqchip, int pin);
 
-void kvm_irqchip_add_change_notifier(Notifier *n);
-void kvm_irqchip_remove_change_notifier(Notifier *n);
-void kvm_irqchip_change_notify(void);
-
 struct kvm_guest_debug;
 struct kvm_debug_exit_arch;
 
-- 
2.53.0


