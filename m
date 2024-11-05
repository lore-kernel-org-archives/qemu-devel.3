Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75534D2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JGD-000468-6X; Tue, 05 Nov 2024 08:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JG6-0003i1-L1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:11 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JG3-0002Yx-JZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:10 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so3137971f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811966; x=1731416766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz42cmMFB8jc7GreGUWRF6XY9EJ0BnYu9J8zOkqLmVs=;
 b=Yvd+TdA2OZ0srQfysSZYncN9VXypsibYwkQm5JWQvYAzvNW34b/6RMRLs0cGdi4hZE
 XYBQD0iVkBywoZqM9tPLtO3g2nxdFtRj95N4+uC7j8QNOrgk0lhYJ2bPO7J+33tPi25x
 BMC/+zZ1wDEge9ZgYys16PUE3/QtNXbVZ53QELIGQHNtPx6Pc8MZCBwQqrH1uehrL3j7
 oHfP2TYk/WhlHvQG1dVGhxgyY9kOoscUF+kUuzjOA6UVST7jp8y9H0aIRBmvVT82OKm2
 sdFM8b7NCT50nDWu8ghorYMn8fM7fZ/4ie5RKgH+ZFNFDGQvJKP56LfBsIeJLiTBqeiH
 2W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811966; x=1731416766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kz42cmMFB8jc7GreGUWRF6XY9EJ0BnYu9J8zOkqLmVs=;
 b=xL9FYHtySyjyjzkKu8+qIq3WLE0tjcYCKrJ5wFKFPxd/ebiYeH1qLblLo8VyPg2URf
 JpixuYxwHGKTh2/19/JJH2iBX7YouAkn08v9yq1hDPdM3ttB9IpK5i38E+MesIZeERrN
 T94ViGiz3m6rDNOVyfMs8Dd2Hje0+YFicBGia1/3Tf9SCxQuNDfKjgH5l0eQkFDkiedA
 y0OtD8i3atSPk4Og75HXef7dCLrClc8ow6bItSiggftRRXrSI1H1PdC/3zi2HiOJ2HxK
 YyByx+oo7I8Uy26w4HDzwW5Hy1cyCUCmy9Fg3/ObmOYyWNaxWr81Kb39MVnaqjjRGuCp
 E/ig==
X-Gm-Message-State: AOJu0YzJ0UstDKJgKKqmGvn23YZkO7fvFNpkGOFa90Fth9ZLwcT+XHNG
 s+/ZMFNG0qq/pbJRNhXtnV3B7cvOlGUtNes2YEWyxaJTfHlmzSDy7uOMSA+QbV3cs/nOZTtWqn3
 OSEA=
X-Google-Smtp-Source: AGHT+IFjPpt59jc3PMzqGL8qlZqC8i1HTvCBB/T0746z2N49HMz0D8zAb0mnuCzU/XPxcbxuerh6kA==
X-Received: by 2002:a05:6000:718:b0:37c:f561:1130 with SMTP id
 ffacd0b85a97d-381c149f129mr15229256f8f.18.1730811965862; 
 Tue, 05 Nov 2024 05:06:05 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7bb7sm16338383f8f.3.2024.11.05.05.06.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:06:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/19] hw/intc/xilinx_intc: Only expect big-endian accesses
Date: Tue,  5 Nov 2024 14:04:21 +0100
Message-ID: <20241105130431.22564-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Per the datasheet (reference added in file header, p.9)
'Programming Model' -> 'Register Data Types and Organization':

    "The XPS INTC registers are read as big-endian data"

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/xilinx_intc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 1762b34564e..71f743a1f14 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
  *
+ * https://docs.amd.com/v/u/en-US/xps_intc
+ * DS572: LogiCORE IP XPS Interrupt Controller (v2.01a)
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
@@ -143,12 +146,20 @@ static void pic_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pic_ops = {
     .read = pic_read,
     .write = pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    /* The XPS INTC registers are read as big-endian data. */
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
     .valid = {
+        /*
+         * All XPS INTC registers are accessed through the PLB interface.
+         * The base address for these registers is provided by the
+         * configuration parameter, C_BASEADDR. Each register is 32 bits
+         * although some bits may be unused and is accessed on a 4-byte
+         * boundary offset from the base address.
+         */
         .min_access_size = 4,
         .max_access_size = 4,
     },
-- 
2.45.2


