Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE54CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 22:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEEGA-0006Xz-9I; Wed, 29 Oct 2025 18:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEG7-0006Pr-Oe
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:03:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEFw-0000YP-D4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:03:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4298a028de6so1026833f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761775371; x=1762380171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5WTJOJ90ouZPZfgirhdorA0+I+5S3/ChJi6dZ472hg=;
 b=PuyAoEVQ15i+ouXuayMQEpjoRQureHrf85jWjPVFGzYaXv+OtmAIw8+gihmPcfNVuP
 qBoZGd5U8Td9Q1pa0CShYl37Q5/tS6mOcWb/LFKh5na3E+4xeVo1WXBzHS+4wF0v8qzQ
 BPy0WxWwyxpBRZ8XOFE3yl4eXo7fO5IGT9DS51hqNMx/glo0T8V97kzXvf/VHRTg4qYT
 MPxxlnZaI6uxdh8YPbusaELQtAtJ0LZYIA/1Oyo+uIhT8RPWb3DdgS7lWcbZZVW+Ovk3
 sz+EMbZqKhUR/cL2okbiaYhDVvLddbWhC01RTv4vT+Bm8xEYYgngLPj3FGD4auGzP9Bs
 DgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761775371; x=1762380171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5WTJOJ90ouZPZfgirhdorA0+I+5S3/ChJi6dZ472hg=;
 b=vXFVJBmO83WZR//y5FQ/ujaawXw+6bginnNLpOxWab2x1odRbuCkrSoS87+1aR2MZD
 /JWAaiIvJl3DwaDR++QrWJ8jviUsZZFlB8XGS4il7Atyk+52+pkjdew7mLh+EdMDahvY
 kcdvu4m+93xmRKDe+I9ZFR0OvGaw1hFgBYyI0cAJElfkuOVuygDH3ilc0GWWm7JdkLzS
 kufR8NKTRFKR+YzzhemghgKUHSKAy/UOs17TY+kfd6fDQq0lhMTDy5UzsqjJLAOCCI3G
 C2fq+HIaBaYKkuZoHcbpckWbuLe+eHC/GUNNPNk410WiUGtENAdepwsDiuuQDSlWjA2P
 HOCg==
X-Gm-Message-State: AOJu0Yz2CIuYJsPMHJoRmMRZj+gLjGgukgnLaLshq41pfZWQhw7pbC4o
 M0KhMEOGalZ4IweDwtpaiKEugP+XgXSPbJL8JoAxYzcDmgf8HBoeoYzqCuRzQum8btl2YHGi5gG
 HBjrfaVU=
X-Gm-Gg: ASbGncv2SgIeaytdbtzbcBOs0smA66vDbPohPS+QTz87vbvf8LouFn3tW8Oy3tQDPxF
 AjqbWOZd1SHset+U0102nOvXxgPJ07DZe14s3fiyVgMBT4iGMBSDoCRbkjLb4ntGUMhyFpRIsSw
 G4M8GC7fEAUm8/UOjfupqQZnPUTGAubx5RwUImNN8gYRERXI22nWTjcFKIBGouPE1L5NJZ/hdpu
 /WZpG2+9IVYvvE6Sv7omL4OFywI4oOxn8VKh1HBCBKSGY/byLU5JbWn1p9L55VcE3Tr5O6dZDjR
 zSoOZ1erxrmY/h26E+DGD+ccmtre4GBrBdjU+xjFjBKow6vqRI44M4U93UxAE9nC20mGRVXpk2m
 UXab5GVlRkcV2MCm6JmuizAn3lRfWkRoqzhxgSEPx6XtJxTd6Kg2n6AXQCGaM2fFBrgPnjFiyT1
 1l4rBJVncenPO046M6vqAs6kvG0gE6/6qg9WekhbjIJDYTK2gb+A==
X-Google-Smtp-Source: AGHT+IG55gEW4cTyrKappFPyhD2OJeyPRoKdvjjfZ7jhh54rR2ddxZavvlHcLaQuPUhm2TYFyHyuvQ==
X-Received: by 2002:a05:6000:1843:b0:425:86b1:113a with SMTP id
 ffacd0b85a97d-429b4c68afamr1090786f8f.16.1761775370842; 
 Wed, 29 Oct 2025 15:02:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728999a4bsm4832635e9.2.2025.10.29.15.02.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 15:02:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 21/23] hw/xen: Replace target_ulong by agnostic
 target_long_bits()
Date: Wed, 29 Oct 2025 22:39:58 +0100
Message-ID: <20251029214001.99824-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Both are equivalent:

  target_long_bits()

  sizeof(target_u?long) * BITS_PER_BYTE

Prefer the former which is target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20251022140114.72372-3-philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 258014370e1..b40ae0b3af0 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -2,8 +2,8 @@
 #include "qemu/units.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
-#include "exec/target_long.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
@@ -455,7 +455,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
                        req->addr, req->data, req->count, req->size);
 
     if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
-            (req->size < sizeof (target_ulong))) {
+            (req_size_bits < target_long_bits())) {
         req->data &= MAKE_64BIT_MASK(0, req_size_bits);
     }
 
-- 
2.51.0


