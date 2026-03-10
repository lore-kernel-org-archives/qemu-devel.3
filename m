Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88089EB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubq-0008An-Vp; Tue, 10 Mar 2026 06:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubb-0007qr-DZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubZ-0005tl-TY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-485345e1013so18326265e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139582; x=1773744382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w3BIlPw0CMfmgESexX1jy7Eew6qRZ790jhRyJ/45kFQ=;
 b=O284WygsowAUAogxdtmVvXjL4UJJt4d9iK6P+ba8CF7wJ1oxYimw8b9f0Dfj+iXa0w
 e6uKmguesBrueGKJzgHWBJUstGpasTBlinJCqDbxVlxpJbqAGgTRI0kSTuyvvbX8U6OU
 8Yl0zFLYklKcXJJO2ejlfUzLWpgSiqXxTSSBCZN6J/wkEEnybNtHUhUfDI5rGiX2klL/
 7fmu3ODz4/61zUdlqZaF8RrmiqpxZue7yqoHdbB+kRXfygya4xW9oI56TvWd+nY9yenx
 uEVecj/d6Ppa0TN/JZTgZiXsOFsssMgPwZdAtk0ZKhWKkYhxCHlVQTNtLqIDHY/Uf27+
 Tb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139582; x=1773744382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w3BIlPw0CMfmgESexX1jy7Eew6qRZ790jhRyJ/45kFQ=;
 b=hMFy305EVntiyRqpw27j+wlmph2n/O4aUBG7HJCravFuTbOrsCWoWLhrHovW92dtyS
 zi7I1hWbS99FMsnUSN5WDgFGs61YGbAUyve2Qcu2wTcFEfsvcm17e5Y18GsY4TsQ6671
 +IQbkA93mVjxH3awWsxldB1d5pLzv/AGFujT+k2nIPZXXcLG1e5aCFjd6R7kGOZ4eIq9
 m4GSqocbDw1s9pD1ol/bvccqyWgF/Ygg5EMOFeklSha6O26DyWMsFUMeljE4bj/3LWI9
 IMEPM6YuE5SDHMcSsKuUZD3uqeUVyPYXcbfXaEG18XLLQqFmPdu/7ZQxfd7AWSG2a5/8
 6R2g==
X-Gm-Message-State: AOJu0YwqqwNts5VLqp9khXw/3+g3vqChiL9I1va3/DdOwU2v3XmcnOvC
 98yK6Vv8EkyjRPAP68HeXz17OYl6S4hqpdkTE4qMBvj32SPkCAONaFEtbIZt9YvRi/VdF7Ye+Cy
 IS7OObeY=
X-Gm-Gg: ATEYQzxhkJandXPOehwCYoWYUqyuAHgR25W7qHd8Lo2/d1UCMuzKCXlP2o1dHNnq1md
 LNhZsPJVlV5Lvu/tjm/3VnJzaL9r1F/YhJml9tzP/zLz62sZEK8/zPolmkh6d2wF9WuZXIIpY9b
 eXMiOusA/ukgg3vPCgjQAti27s8bWqcA7S/QXFurPOKGel7JKZql9E4IdWm+42bPM2u+GtmDZiY
 yNucTgtDvGWa1/S9a4zV3oPp16RpJ70dSdCnVpQhDFyBwnoVZwnO/KBIH+X2RBaBcTfNCxOahFY
 SKuJ9xOr088wTYUhVh9Ly5SiumqKlCMXFNJwFMVKjJzIvf8lKQkpoPjx8o2vwWG2HdeBajp++NA
 UDSVf1hHFyU+7tU/djiY+piYUJgSPUTO/dsQ+3SXAfmyfOVz1uPfO7CquFFu/bdCJdKTkx+YfwT
 flmwdfHG31f3Ud6bNeq8dJIG7W31kmd/GQ6aL4/ZljmB0iF9/Vfwo5HGztz7PASKQUfiF4PxeW
X-Received: by 2002:a05:600c:4f8e:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-485419cc0c0mr39842485e9.8.1773139582363; 
 Tue, 10 Mar 2026 03:46:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a8d4desm65313945e9.8.2026.03.10.03.46.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:46:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] accel/kvm: Make kvm_irqchip*notifier() declaration non
 target-specific
Date: Tue, 10 Mar 2026 11:45:05 +0100
Message-ID: <20260310104511.12670-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260309174941.67624-2-philmd@linaro.org>
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


