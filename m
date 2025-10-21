Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1C3CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHE-00063w-Mn; Tue, 21 Oct 2025 16:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHC-0005yM-MQ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJH9-00018o-6A
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so48892315e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079689; x=1761684489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vutle4YXIOFFrBvcNunmt19xjODe06KxvyMmRyQ1onQ=;
 b=Os/M8WOM/UQSyyEWo/mF3s4FzkiwXOoa+LZnJmLgroG9Z2qn7mxvV0qq1COkqpgBS/
 +kxS4nIorHTU75BIBsqedoMXKjukmIDfztPu0jiVRy8gOOgwtCpCQ/Iw4Mgzk8fMeeGz
 QGlRIhD0gMGjOqyxk+nJlmKhMoDqzEbX0nLleg8AeacZflbLLjoHryo/fgCr8M6kEygg
 I1KoPUJZHEpdKyzvTjToEaMkk8em5L8RDeye9q45dFTyreQtmPJK6b5Kui4iKUTHmdlF
 NnPjMtOZ1XeOEJ+XFcPj26YLP1CwdnPwufgi76vjiLSRvAjkvjRLJPq580FNitZr3kq1
 Tscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079689; x=1761684489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vutle4YXIOFFrBvcNunmt19xjODe06KxvyMmRyQ1onQ=;
 b=DAotKQ5cLjYF/Dj6hiNKM7n5MHWDh5/NNBlgHYV1peB7QhG7MxslCw5wyfPXSeHtvW
 Mzui5koYJdi3dcPcDwo63tX8ph0Ab8XD9qfVNSGw+p0k+wQf1t2b0hB4z7JYTHtJ7S3t
 WBELqn313yWZePSMod+HUR8FKWHaMq9zs8+6fInW+EzQ97X5A/YM8Q1/jJatqPBlPnMf
 BIQxHDYW8D3TAaC7IwVuiQqOun+e1eYuNjxNqCX9Wl0cCGARyDXHkD3KjuzJRpxyiVfF
 rgM4r3O5odbebgADBIs+QRBtUCuFYSsUiHEMCUlXdqlVLevzv2a+Q8qeY4LtL1oTx8LW
 X6cw==
X-Gm-Message-State: AOJu0YyiNys1Ot+x2tnlnPt1wtHEyRzWS79XYJuBTj9BJd99Dx7rauta
 RkM3U9utT8DgFsPipvd20YEWFCGYguEqkP1z916acjQP5xLNGzVURyhIBj0A+x9mKA4+9eyEI2x
 HMQAy370=
X-Gm-Gg: ASbGncsnrLautBb9qPsCqqtBHfvpWgEh/C3hIWkQb8AXH5fBoc5jhvAaT/U7g8sCbJ9
 9RBOgAx/2iahD7BfbIPZfcBUpUuQsKSRS1oU1f/E85QoDv5EQymyB2VgQuUzBpoR4DkpQ71HU8A
 xMJca4btLUq22UN+5jnz+bZw9yG0a7KKYHp581F6G5tV1dDXIE7wWR/B3Zj1IizJNh7+AECotFv
 gr3wDVxOOyPlYessaCh0/09PQAgSYUI99HAjX1iMl3OhpaKXrCTucTPFtzSvJETp/syhfLEPwyZ
 hwl7kSG5Mly6lbgDGbQzkVW+0onk+1hORzoEcK9FlDxnm+x7Ph3PYsCTWBwqyTdRZsXK4LCLP0T
 VvIF9086O70c+BYa8I2RB1q+hQgp4MA5l8uVuDZAJouZg863p8LaOA6H2C91i4nLH3vEh4kr9xa
 5iNWL1+NZ1+YLFzHBondkKJsYYCZpHjBLQeac6qMnJRaUn4dcPjMiObUCHY+fN
X-Google-Smtp-Source: AGHT+IHHhz0PfA4M2bG/xsFIM88eKoKfDlYj8m8DXImZxQr/P1sFLrzxhwCGvoejWOU2po78eDzrMg==
X-Received: by 2002:a05:600c:548a:b0:471:669:e95d with SMTP id
 5b1f17b1804b1-4711787dcc8mr120147665e9.12.1761079688803; 
 Tue, 21 Oct 2025 13:48:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a9a9sm22537515f8f.29.2025.10.21.13.48.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/45] hw/ppc/e500: Check for compatible CPU type instead of
 aborting ungracefully
Date: Tue, 21 Oct 2025 22:46:28 +0200
Message-ID: <20251021204700.56072-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
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

From: Thomas Huth <thuth@redhat.com>

When using the ppce500 machine with an embedded CPU type that has
the right MMU model, but is not part of the e500 CPU family, QEMU
currently aborts ungracefully:

 $ ./qemu-system-ppc -machine ppce500 -cpu e200z5 -nographic
 qemu-system-ppc: ../qemu/hw/core/gpio.c:108: qdev_get_gpio_in_named:
  Assertion `n >= 0 && n < gpio_list->num_in' failed.
 Aborted (core dumped)

The ppce500 machine expects a CPU with certain GPIO interrupt pins,
so let's replace the coarse check for the MMU_BOOKE206 model with
a more precise check that only allows CPUs from the e500 family.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20251015111243.1585018-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 723c97fad2e..3d69428f31c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -20,6 +20,7 @@
 #include "qemu/guest-random.h"
 #include "exec/target_page.h"
 #include "qapi/error.h"
+#include "cpu-models.h"
 #include "e500.h"
 #include "e500-ccsr.h"
 #include "net/net.h"
@@ -942,9 +943,8 @@ void ppce500_init(MachineState *machine)
         env = &cpu->env;
         cs = CPU(cpu);
 
-        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
-            error_report("MMU model %i not supported by this machine",
-                         env->mmu_model);
+        if (!(POWERPC_CPU_GET_CLASS(cpu)->svr & POWERPC_SVR_E500)) {
+            error_report("This machine needs a CPU from the e500 family");
             exit(1);
         }
 
-- 
2.51.0


