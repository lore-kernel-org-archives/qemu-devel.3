Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C08AE77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvzI-00049E-Aw; Wed, 04 Dec 2024 15:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvz7-0003qt-MF
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:34 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvz2-0003ZX-7V
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:30 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so175831f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344106; x=1733948906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGN5RJQrSmW9JWKBkRR1K+I3aJFNDNbHIDvyy4lFcWM=;
 b=pIzrglZtozpJ2fOjAucVrt1WNYVu1lkujLAVwDF4TKcKB5HvtkAoqdntFkQEFMz8oB
 6rrXrlcJtk2/RrszW0SVrlGYNzobwt5bcVIiAP28UcUjNf/DBVR7Avf3yZQ/JZGwQit5
 hKRX/dadRY+n9tGznFnEhkX09c9LKYL6IL2DaErjc3AP96+mQV7iaclst+BDp2yvwb7Q
 reLWl8BIq/+tbHamWqCFvVCEljlFx3asiU9bzO3k0CIjYmWz+iMyP0ygtnr7kIf8o4bE
 1betJPtga88SYQ+9p3o529wHoj/AHoNy/8jHYw19igkHqjTCaRJpcljKpT9VFWEsP9qD
 JvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344106; x=1733948906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGN5RJQrSmW9JWKBkRR1K+I3aJFNDNbHIDvyy4lFcWM=;
 b=WIa3PQr5XP3e/8I/P3Tz46CiqJHSbeB+F6WRjUEpWjyLmZ9/BZZq+gTanGv5ND1p4x
 /Y7C3HtaXhTxcmtIdB+vDChXM1gFWbPRoGwmRQM9zO1qsDglIB/MVUluO3xgO7dpGrqP
 rvNKNi8Niqd5msdRfjjGyg8ounznX2SiKG/JUiKPctf1DFCq7PLVSkx5pBlykPvyAJLt
 vIaJKsA9tCJO86G9jrZ2STxY08SvM49XA3e6yfQdghs89CMx5dzCWf7bLF25AplnKW7Q
 29TkiYTkekbAnf1fo/yglBTRNtdjjJbMpHeM3yuH4zUfMDbrWgDygeARx1u6Pf+blo+B
 fUig==
X-Gm-Message-State: AOJu0Yybgpi2yyKvJJSw28PCvjbjxoiTXZOxSf3O16X/j2rXACqCYMin
 IQ6gz/VJOOCSJvY7frSJZ4K8hKOc8/PskZpTEswxyiDMRHwIo+YSNyH7JM3C36V0AqINPlgqY29
 6
X-Gm-Gg: ASbGncuzSzz0QWcNdLRDUhLJMc7AuHLJ3H4oyvxarDthc3umVVRur35vPGHlLbr+kh0
 zKr3A+QBtUoUWLu60/UZCXDCIFk12eKYSw5wwn1aKoH41kD6x/iqy3CpfZECQEEMx5d5tXlIXbC
 pFit2DEK1+Js+6wy1L1Z+0azjCZ5eTv1ggTPsGu1G7IIKKA6HDohutn9jl9IApPFCnSsyRJD4gB
 ImR7xzMXTWZSbZg2cWJsP9bYnmht+CHId4OkFCynXz5oYlIDP68sgdj66yBAGYz1puWkI78kgtw
 cF1x5OQwZ1ir2X5j2Jo2W4ek
X-Google-Smtp-Source: AGHT+IH/S3fZHlZzX/kr27toW1RLb1QXyLYo9TNenewW3f4YqXZzcSdz11tH2a+Z9U2wX82Jhc7Nkg==
X-Received: by 2002:a05:6000:1a87:b0:385:e4a7:df0a with SMTP id
 ffacd0b85a97d-385fd436393mr5816550f8f.54.1733344106323; 
 Wed, 04 Dec 2024 12:28:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dece67dasm16908928f8f.8.2024.12.04.12.28.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:28:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 19/20] hw/virtio: Use cpu_datapath_is_big_endian()
Date: Wed,  4 Dec 2024 21:26:01 +0100
Message-ID: <20241204202602.58083-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Rather that using the binary endianness, use the vCPU one.

The target affected by this change are MIPS, MicroBlaze, SH-4
and Xtensa. SPARC, RISC-V and RX could be affected later if
their CPUClass::datapath_is_big_endian() handler is fully
implemented.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b3dede476ed..c57845a16db 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2257,7 +2257,7 @@ static enum virtio_device_endian virtio_default_endian(void)
 
 static enum virtio_device_endian virtio_current_cpu_endian(void)
 {
-    if (cpu_virtio_is_big_endian(current_cpu)) {
+    if (cpu_datapath_is_big_endian(current_cpu)) {
         return VIRTIO_DEVICE_ENDIAN_BIG;
     } else {
         return VIRTIO_DEVICE_ENDIAN_LITTLE;
-- 
2.45.2


