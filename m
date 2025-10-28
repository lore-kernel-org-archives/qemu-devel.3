Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE3ECCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDej6-0000wr-Ul; Tue, 28 Oct 2025 04:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeiJ-0008M2-RY
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:05:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeiD-00018H-M6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:05:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso4158268f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638711; x=1762243511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLmkeQSs/VBwfVzEPmuGbOaGLChFkPJiX0fIN4S0l5E=;
 b=ERnlU5R6iqL5NWN7fq9piHLTjem5yA1oyLRHZ386MpyL4viJ4SadZgnq5vZ5WzfDeX
 VZfzsG79dwCBvkNhZWNJFQ9cY7jzV/PXl7YU57OKdf5uJEbZauheb2o/xi0QaTQgMA9L
 k1F11wac+GuPSZYaQbZx5ishp2vvuqRAPCsWJlhzjS7qNfkfqzw40cdjvo9K0I+AvBaU
 4yumqENXUDSG+kMGdE+svcgvq4+GSv2xCAFM5MWw/ibbfqkg/Guer70g7QK8fCKd19Km
 K9Pf/gVrQ1jOpgZ0XM31CK16JVBe50H10LqVzmu3M1uPPgFdvPzg2Gb7raP6XXvst8/Q
 k5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638711; x=1762243511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLmkeQSs/VBwfVzEPmuGbOaGLChFkPJiX0fIN4S0l5E=;
 b=rOX5i9W3lil4LJ+7ZA9mxiz9ugvuR4kJXp5zBs9rE2vfQSKdmp+V2VVu8JqTwPFI/f
 cC5PEVBLWrhSJCT+QkSaJItQu/7ffIkHnqr92zMNtb25aKlXqNaSBRGAj3fQK8wIdGGm
 vTSX0+aTX+x6g7dZj+WBsvpQ/rIEX+gCYbvDhPuPyt/FHfaofASMsT9rb2WESphFFOTt
 +wbzAL/hWlho7kmpHgMTOo/Rqa5hWm/9jTEsTqmfvR82PnI0MotaoItTQNgUEWBAekjO
 WU25mo8RV+ptd8D9+xslVOi+cxzi7Odkg0iMrwv9y8IQZtYS2tzwZRBYhPV1wePcArjE
 5ccQ==
X-Gm-Message-State: AOJu0YyUoqmtVHvUPso/rUIY5RManiX52tn8IiY6RQ/OrUNL0DEg1VU8
 yL34w2hJuqlG4jklsHp7ed8zsHpm8CV+lIk6NNpuXAmPijzzakbHblXqVIYQUh3C+kYcCFlZhL1
 5H6OZNHk=
X-Gm-Gg: ASbGncsRW3SxJEcN2EZqvf9M9pn70pZjCzVHD9Lrx9uQJ3UeBXAz3Tjmtk2ObLeyqIa
 snOimrku7d+aA2/rdrUBbQw/CRiVMhroHhaeb5Un8M6M0dkkurnOhdoreIZEQJfc+k/t8PP8zJI
 KxYoCooca0u4DVQM3Li3BN1V428/vGiqC3Gbt5nl64UdJVfiz3XVjzsm6a6fNlbKhOpnb4+urni
 HYe1mQw3t2/JoqmRDLt8QHgu1f3/R9l7og9kpDR4Cdbyf84piE4+CaBf2fVcjR1IWCOTC1Eq9Qe
 EQ1DQ83Pgb8r0/zLjqYJ/muiOZ9hVO4fkUb20CARnCqW+njlUaaKMXvXmgX8yxMBXzxi8qrDtlw
 KbHZfmlWTFCrvB3jzvbjdesXPcZdn5QbW+xlYE80CdbyHxHXjUbHZPOUpSFoIIrQwT7xYax12/U
 moVU3FNTij2ZV+iuXtSYcrBtehS0ftldmtj7NyrZKJpvNN+FNCwDYjjy5+t4aVrZIJ3g==
X-Google-Smtp-Source: AGHT+IEm4UO+ArAp4I0x0HhwWaEbKOmqewIUYrU1pqmrcvMN2x072Qa9ZTR2JoRQRO+Jpx4Yao1nWQ==
X-Received: by 2002:a05:600c:5295:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47717e6ac65mr22788165e9.32.1761638711619; 
 Tue, 28 Oct 2025 01:05:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cc5efsm184271135e9.16.2025.10.28.01.05.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 01:05:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] hw/ppc/e500: Use proper SysBus accessors
Date: Tue, 28 Oct 2025 09:02:56 +0100
Message-ID: <20251028080258.23309-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028080258.23309-1-philmd@linaro.org>
References: <20251028080258.23309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

SysBusDevice::mmio[] is kind of internal. Use the proper
sysbus_mmio_get_region() accessor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 8842f7f6b88..fe1aeffe676 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -887,7 +887,7 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
 
     s = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(ccsr, MPC8544_MPIC_REGS_OFFSET,
-                                s->mmio[0].memory);
+                                sysbus_mmio_get_region(s, 0));
 
     return dev;
 }
-- 
2.51.0


