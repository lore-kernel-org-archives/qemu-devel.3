Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3576FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EuP-00073q-UW; Thu, 02 Oct 2025 04:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuL-0006zq-10
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eu6-0000xJ-OJ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso4533685e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394583; x=1759999383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5PC+1TlVBTyXto+jnsJwdDvPaPiKj+lxKbw9om1DB0=;
 b=ikxfc83AXsiQ2LGEkbWgWu7L7Lcps85g4z5kijxpW4PNywrPwGHCwQ2AVPOv8RDSmT
 YRaXGgZPp/1WOhzQsvEPn9CZV0Nmw5nCQebVf41tbBj6/q7SskhKJkMiRSjhx3My0pJ/
 yVXlnKj438PGTt+VDNh5wQoOwBn3KLkX85Ct2lkQ513vqUF1H/nqhdn2fB45kIdV23vs
 Br0rB+ybifP8F0QZipqlrTmt4DNQX1i6sWoid2CiLxKMQaml+KGz5J2y+hqkDCW0dbCz
 XO5bf5Q9UF6NkbWCjdWUp/+uS2lqkBiywyQc3eBplcF7tsY5R4SNwVTxO10ZC9/4rFLI
 H5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394583; x=1759999383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5PC+1TlVBTyXto+jnsJwdDvPaPiKj+lxKbw9om1DB0=;
 b=duQr27nf1gQSTNAf9ebh7ciKyk0cB0mZEipOodKaVBQYcRcS69AjqHwi8ZEBl4tnNx
 qik2uNfZYMvW6c9WnctfJW7qv6uqdiye7zphdY2BgCAn4WF5D6tbCuoTPqdse4VTFyI1
 gur1q4fn0Wq3ZuD8Uv6X0WcnNiuXRmgPPoEnUu+b9RiBzh49YD+RSZi7WDMa65Ai2YhH
 9+LS9MPFAzDt0t+XlDuhVb/QDZaRpLP3FEXgR8qsIblP7VVN+xpVLRmjsUQ19vntxrcw
 IejDnqhoxgTKdMk2aK5nnOdJvuy7zxPzKeGYTpAmUj/X1ejtk9qDamOGmaCMXhqwG4Iz
 J0LQ==
X-Gm-Message-State: AOJu0YxKso3Rinp7sC+W2WKYUq6tulq4j9qIMFeB5fATK8nBygv/XfNi
 xYhZqKCcbM06eJ0ux+LQEeN3jRWlrhuThCu+T3/5u7qC01y95ZIR74yiDGqbf+k4exCorLIqBcy
 TvGqrFGJ3Ow==
X-Gm-Gg: ASbGncsvsn6wwJ9j/niOIf4+AnPRGYlK4Htibkan0ymy1+hZRp2+HCZP6/WNdh2EY2w
 yecAit8n+WismgVyC3PXd5z7edJeIVudVYeljlH4shmWhTnvHFAvWeh67OkoGfC7k1A7FHG0ucF
 AmrA8mycVC99BuwOfTmmC4TpID3cQsfL+v6SrFXKcuIqF5K7qfoJEiPUGxjrUioEDxwYw44jPiB
 k1Z4NHySVwazrwCny9jmgR4MTMoZo16a8P2oRjp1B43/+DBXyhLUc1mLSNhlFqvZR50Q3y/eMl8
 OuePeyJgTEJhX2addsyedAMFw5Ikvjn/VCeikSDB7jF8fVvcpB0wQooqfdb1ZncV2Agan06IJcS
 Om/UqvwrTkp3qoT2JXM0dRcvSIHWoQMPZv+HjSQ8Mm5mbZSm/EdT/yJBe/Q1CjpV3/qKnle0yNg
 t1FG1hb8qGsJcOmH1wqhejzEWG6QRcxw==
X-Google-Smtp-Source: AGHT+IG8Ma/4I60woYQn+sfaatxOnQXHwssxQgt8liAn1/sRa9HXbIzN6+J2l9ZCi0NeEjgUws6OFQ==
X-Received: by 2002:a05:600c:8119:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-46e6128617amr48211715e9.30.1759394582729; 
 Thu, 02 Oct 2025 01:43:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6917a867sm24739885e9.5.2025.10.02.01.43.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:43:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v4 12/17] hw/xen/hvm: Inline cpu_physical_memory_rw() in
 rw_phys_req_item()
Date: Thu,  2 Oct 2025 10:41:57 +0200
Message-ID: <20251002084203.63899-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

cpu_physical_memory_rw() is legacy, replace by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/xen/xen-hvm-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 78e0bc8f644..52e2cce397a 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -12,6 +12,7 @@
 #include "hw/xen/xen-bus.h"
 #include "hw/boards.h"
 #include "hw/xen/arch_hvm.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "system/xen.h"
@@ -279,8 +280,8 @@ static void do_outp(uint32_t addr,
  * memory, as part of the implementation of an ioreq.
  *
  * Equivalent to
- *   cpu_physical_memory_rw(addr + (req->df ? -1 : +1) * req->size * i,
- *                          val, req->size, 0/1)
+ *   address_space_rw(as, addr + (req->df ? -1 : +1) * req->size * i,
+ *                    attrs, val, req->size, 0/1)
  * except without the integer overflow problems.
  */
 static void rw_phys_req_item(hwaddr addr,
@@ -295,7 +296,8 @@ static void rw_phys_req_item(hwaddr addr,
     } else {
         addr += offset;
     }
-    cpu_physical_memory_rw(addr, val, req->size, rw);
+    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                     val, req->size, rw);
 }
 
 static inline void read_phys_req_item(hwaddr addr,
-- 
2.51.0


