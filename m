Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2D2C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9lZ-00026g-3t; Mon, 16 Jun 2025 09:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9lA-0001u7-3f
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9l7-0005RU-Pp
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-234fcadde3eso55877705ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080020; x=1750684820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lkf/OdEQSfxG2yHQ++B0CfVtDkkYN+xz19jFGvSBQ6U=;
 b=k7LTzeHPEw8X9Z7RowY6GoFU1VP8O9fcd5Bj0ZURm1wo1Cgae5IOX62xMlGo0cVISY
 NdmjGf8S+u7+KvmDjgOIpDMht0427ukevOPuBkTnNkmZcLdmXMAY5mUGreMRmqEN/LTE
 +5bKjVxbp0cSP9KHr8/YJxhISTQiwly5jxjPA3zwpOcIRa9dmXjN0MksJnicml/ruVP+
 yaBBhDy3NcZkM1sb9JAgVSTXOffg3aKesUj+cwUvoe2A9yL4gQh15fMknRRskaCqVqhf
 XNw0x/Ij5Fp6qK/KYCKtNVJfl7YnYRLIbl7S02QKeALuozdZZudm+2SPr5jOdzkUmzS7
 ID3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080020; x=1750684820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lkf/OdEQSfxG2yHQ++B0CfVtDkkYN+xz19jFGvSBQ6U=;
 b=cMbcp5DhXA7XqVm+or5dsCNqq6Mxr02ILrLNLKaYVlRfSEfAYfKEWkW1rgIcrqcSBs
 kujVW0M1/ljJ1XEKq0fiZ5wv9+rEqXSJah8ETQjYSRc+dY6MDTTEb6xljNm54164suQt
 WOBW0x+nVVcNRU+AIPtX/3wX/oAYctbGYkwLOpMXjcfR08/g4DGR/wjeYctpDXy307YT
 tjP9fPODGSWspopxsD08AwvLxSscIfOHBIjIDUrw+RXhXNioL2N1XOQsrxQ49Zw2PPel
 f7h89BlNA0RQvs8SrhXQSS0t1f2FnmmPSdY0CNMWIR8rOmfiCT5EVMIgDzxGV5uXWCi+
 5E7A==
X-Gm-Message-State: AOJu0YxCOapnlSMIZTaxKfSVPkdlsEtUiWkXPW/Jlc54YlUxNGePwbx9
 c1truRykKyponysAUd1qDwteEyeqU1s++NBo8LDcsPOVQw2YO3kDPdqh3DC/XCWeZ6DrxJS8bEI
 8r6NO
X-Gm-Gg: ASbGncumX4AdWgT7Zlp6t9hCJxZeQzMZlV0nYICEgUEYk6E3H7KhfNH0phaNIgomsSJ
 gjUoaA1tu9dh4yMajq+an0s4W+ulS9HLk+ZfyuYufqSLmGjUsY0X2FHX76dCmOoGUhvdP86XBdk
 g1mESqz+Sv5MV0CkdcOvNHhb0+YLFyqQ1jn06Bl/bGbN3fnoa4sv+cb22SNRZRilL3WW+4LE2nQ
 IJRgJ/Me7y4wlPzXRBwaPjRkGDz9QMEb8FRQmqYJQYTyrcUIYXdK781Rm4nlwZfgaiZfNhkQVhX
 ZZQ0VhoeTLhZnfFJvZWONcxPCoG4QZTiH75y7Qbjk33IvGfKD5yuuZbiKs/ELEx8DKdDsAP/EGY
 YmQ==
X-Google-Smtp-Source: AGHT+IFJjIvSu2YVYXgzAph1VFqVYENhN8dbtxLcpdoy3NyYUEgSm8dwYLskPlOusQ2jSHctan+idQ==
X-Received: by 2002:a17:902:d4c9:b0:235:f4f7:a633 with SMTP id
 d9443c01a7336-2366b3ac074mr160663695ad.28.1750080019963; 
 Mon, 16 Jun 2025 06:20:19 -0700 (PDT)
Received: from gromero0.. ([186.215.60.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365de781dfsm60848405ad.131.2025.06.16.06.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 06:20:19 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 3/8] hw/arm/virt: Simplify create_its()
Date: Mon, 16 Jun 2025 13:18:19 +0000
Message-Id: <20250616131824.425315-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616131824.425315-1-gustavo.romero@linaro.org>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x629.google.com
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

No need to strstr() check the class name when we can use
kvm_irqchip_in_kernel() to check if the ITS from the host can be used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 42a63a523e..d2cd79ca50 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -705,21 +705,18 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
 static void create_its(VirtMachineState *vms)
 {
-    const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    if (!strcmp(itsclass, "arm-gicv3-its")) {
-        if (!vms->tcg_its) {
-            itsclass = NULL;
-        }
-    }
-
-    if (!itsclass) {
-        /* Do nothing if not supported */
+    assert(vms->its);
+    if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
+        /*
+         * Do nothing if ITS is neither supported by the host nor emulated by
+         * the machine.
+         */
         return;
     }
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
-- 
2.34.1


