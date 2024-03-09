Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3610C54E67
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2HB-0000Ap-D3; Sat, 09 Mar 2024 14:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2H9-0000AM-SN
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:31 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2H7-0002S4-NM
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:31 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so45046661fa.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012147; x=1710616947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v68VdV/ZTxTWOB82N2ZE0IksCha8mce59bQC7Dz3io=;
 b=y9EJGYm5tiwU7GvILWKfd+GRYVi0A0oTnRfXE26Mgv9cV3HJXpAKsg9vPuA2c18aYk
 YW9drXOHrP20ue/Vs7Yd6RWs0GOgAo79zy+HfTJpP6Qav29a6YsundROXXvP9VFzhJNG
 WoZl4BvgspQ0l4JP+ArxuJ6Fww7nJy7vBkUIGBqESHfqnCenX4sfiJfFe9HtzeaTV6Bs
 g/iYPNA7tixh+y2qjejPYXGmdIyYKwUHIlKoxYmAZDnUWuR5yj/6VAh+qwlWnh7Pjgx6
 DPO+qtmgCf3tiw/VYfWi88eay5P2kvfD/btzeIBoX4YoB9r9LGIU3yQ3NLl738/JIiX+
 vdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012147; x=1710616947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v68VdV/ZTxTWOB82N2ZE0IksCha8mce59bQC7Dz3io=;
 b=uX/Mn9bRKf6+RhB4qDJXBP/yz5ZuNhuzISWYvSKfsLtJolKzNM3Jthg/IIEY+Rw/NT
 +QM91AzS6h1v9kSRpFaO5thKoM2h3l507d//exjXFx4NojIO7SE6jKsZ1XFctDQHXoXP
 XG/rnjrn1Aly6lKgCmcI1IAKWdvG1t3wbXFM/tirpyyFxa0ZJ9CG5vFwsaTvZoB205Pd
 QkU6FwEgAbXmdsnJTApB8OgoWbGNvQ7zOehWCAeRyg9sLuORdis/ohX0QUxpLILUNXSQ
 Vdvzcz0/LhtH4UbG+9m2tm5rUf9uIvvOa095lhgemcF4K8z8QYc0zWR+xrIMB+Yl8UhB
 VIkA==
X-Gm-Message-State: AOJu0YzegXNRd2f/K0W2cMGRUl+Ii9+wd7eXclYVOfdqpQifcvJWdK+A
 JAEj84Kd54172EGz6RhsWDpY69ZQ3cojNC6jOIa5GI/HRfUlAn4ikkQFYkpgDAukrCUop+xWlDX
 Q
X-Google-Smtp-Source: AGHT+IEPUeAq3OvXQ6d5BNC7LVFINL5jOukf6dFmDeF5FkUQjdJ+zjK8mwm9i8o+ivn3j1gVM1bH4g==
X-Received: by 2002:ac2:43d2:0:b0:513:486a:57af with SMTP id
 u18-20020ac243d2000000b00513486a57afmr1542144lfl.7.1710012147310; 
 Sat, 09 Mar 2024 11:22:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 h27-20020a170906399b00b00a3ce60b003asm1185569eje.176.2024.03.09.11.22.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:22:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PULL 02/43] sysemu/xen: Forbid using Xen headers in user emulation
Date: Sat,  9 Mar 2024 20:21:29 +0100
Message-ID: <20240309192213.23420-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Xen is a system specific accelerator, it makes no sense
to include its headers in user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20231114143816.71079-3-philmd@linaro.org>
---
 include/sysemu/xen.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index bc13ad5692..a9f591f26d 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -10,6 +10,10 @@
 #ifndef SYSEMU_XEN_H
 #define SYSEMU_XEN_H
 
+#ifdef CONFIG_USER_ONLY
+#error Cannot include sysemu/xen.h from user emulation
+#endif
+
 #include "exec/cpu-common.h"
 
 #ifdef NEED_CPU_H
@@ -26,16 +30,13 @@ extern bool xen_allowed;
 
 #define xen_enabled()           (xen_allowed)
 
-#ifndef CONFIG_USER_ONLY
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
-#endif
 
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
-#ifndef CONFIG_USER_ONLY
 static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
     /* nothing */
@@ -45,7 +46,6 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 {
     g_assert_not_reached();
 }
-#endif
 
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
-- 
2.41.0


