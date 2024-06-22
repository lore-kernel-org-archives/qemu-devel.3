Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5008C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWI-0007yF-Rn; Sat, 22 Jun 2024 08:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWB-0007oE-Hb
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW8-0000KN-Fx
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-366df217347so593720f8f.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058011; x=1719662811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mDo+JBOeUoxcIeTzZxYoC2qPYwPf30n/5YLwDLvTy9M=;
 b=rAUu1e6elmoz90v1TjVdDP1nucpWZVfF45YIvU60+asxdoizaaGjb2mi0rigdV3McZ
 fZtEFfkEVXln/8pY7DtB2yz5PQ7dlUfRVOgVznPDzYaOhJ3QwD7vdcUdh+RA8eMg6p0F
 H4kgfc/jvQFA26tXEIp8SXxCagRRUcSEEeQV9PBZegLXI9DFwM2Np9NTEKgZ8Nr39eF6
 Vo+oMsrBSlh0JKZLLrMcochQ1fFcnqAVpFD3lvhpuC1lJVHifCve/Rmj+wFF5Oq1qXhy
 0VHzb8oDndFe0EbaWn69Vgcln7opTuzkDZb4QuCxxKM/FxDyX5o40ZNiBFn1k9MfchCT
 xvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058011; x=1719662811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDo+JBOeUoxcIeTzZxYoC2qPYwPf30n/5YLwDLvTy9M=;
 b=QzKNO2QeMv1XpNuIaN2RiBloUXEW+zoiqstMle17GYwykF5R2tSfx0sSPU7oKrqGKU
 L+tVUZC53TBLjXSPyjp1/tur/h1NOjw4TSRgP2Q8LzgNs4CHr5lCmmwir2m0akAYl+c+
 gh19q7BMUtZQI+ItS+vacmzczlAgF749ji4azIu0x5QBeLzeocaZMSyt9N3fZGGhUP/T
 ZvUYYbGhQtO4vYpbFwWZTXbNyR2gc7q8NyoBS/+LXUm/j8s/YUTEnq3SEk3+rCgNHZHT
 T/BUuFt2mqr7AFCEvIxwTbakhUVmf8AI0qJDWT+Ml79BKbFKy35R8c5O9kmQHSP5h3Qw
 SvWg==
X-Gm-Message-State: AOJu0YwwLuV3OgdjKoEK5QaMsp+uAumpx3b6WSyC4u3Y8dqAhuVP35IP
 aC0w8cBlsUuT+bgLmDNa+n/osTblRFslkhZAUdUpbPQSOx8pA5+j8gFCko+3yM/GPzN6698Q25L
 lHAA=
X-Google-Smtp-Source: AGHT+IHw19iEyk5fa6bKXJg1UTU2hfIu5EdfPb3B+hdsW1pjAiHSVc8j/Y0Jru1erXXau7yJMC66Rg==
X-Received: by 2002:a05:6000:143:b0:362:93f9:cb7f with SMTP id
 ffacd0b85a97d-36317c7eb8cmr8363263f8f.29.1719058010855; 
 Sat, 22 Jun 2024 05:06:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] hw/arm/virt: Add serial aliases in DTB
Date: Sat, 22 Jun 2024 13:06:37 +0100
Message-Id: <20240622120643.3797539-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

If there is more than one UART in the DTB, then there is no guarantee
on which order a guest is supposed to initialise them.  The standard
solution to this is "serialN" entries in the "/aliases" node of the
dtb which give the nodename of the UARTs.

At the moment we only have two UARTs in the DTB when one is for
the Secure world and one for the Non-Secure world, so this isn't
really a problem. However if we want to add a second NS UART we'll
need the aliases to ensure guests pick the right one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240610162343.2131524-2-peter.maydell@linaro.org
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c7a1f754e72..61a9d47c026 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -284,6 +284,8 @@ static void create_fdt(VirtMachineState *vms)
         }
     }
 
+    qemu_fdt_add_subnode(fdt, "/aliases");
+
     /* Clock node, for the benefit of the UART. The kernel device tree
      * binding documentation claims the PL011 node clock properties are
      * optional but in practice if you omit them the kernel refuses to
@@ -939,7 +941,9 @@ static void create_uart(const VirtMachineState *vms, int uart,
 
     if (uart == VIRT_UART) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
+        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
     } else {
+        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial1", nodename);
         /* Mark as not usable by the normal world */
         qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
         qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
-- 
2.34.1


