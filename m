Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9CCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDMm-0001Tl-1h; Thu, 21 May 2026 20:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMg-0001Sq-Ee
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMd-0003DB-Jy
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso72358295ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408222; x=1780013022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzmrb2//Q/gLCR3bz7IsBU8u2c8FQ+I54Hlj/vG+0N4=;
 b=ldNs4A1B3wFWC+GBAIJypjnJ3O3CFUZNmDKexL83NraCFD9QkU1Jm8o6CqHDJHLAQo
 xpzj2dHgq35GGAaBnzex7kwpMqD04wxWAQtw0LDz5CmUyulmOGufZN0cM77wZag6sczK
 IvMOrZKdxu/qMHiEXsHFR09IJNToFqwJ0oHEjTQHGA7J1wJTzsdPVRnR/ArCwe6xvq51
 wo/LGT5HPcVI0OZR++tvCPICPKgkbfw///BuLsWy/mi4h5FsZI7iO1ZlaemnIeMzvkmS
 p5EKR1Qlve0KfAsI8S0GjF3lOFOW6ACB4b3sMxBBHQyaU43ITvBCvzpWoKWWMc+PPJau
 rFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408222; x=1780013022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzmrb2//Q/gLCR3bz7IsBU8u2c8FQ+I54Hlj/vG+0N4=;
 b=ACwNUEmE3wmW+CeREFLvR6htRUJXR5zwpQiLUTVGgjrDpYR2EKmoa7ccp7yuVxzD/C
 QzdOA4i6loPS5PTsbsEdMgfDdkdf6R05u17fZqGHCT1DMwkJxkOdw/dKZTrC3y9YzHNc
 P7mTHwy8iDHLcCQ0C1RE6FE6VHrB+PqH0FoyxFrA+hi3nB13ruKdqxyPmZE4oNbQqjAQ
 qIzoSDj7Skb6YujIco/TQy6GwfjDd84nCduUUXcsbA5S1D5AfkBhTw+8CkHmu77xO5Zk
 Y6GAapWWPwZvBvq8AmDgtTflaB3YsZZS/xMH8pveJvbec2mbBs6nJRDAeGowOEOVjmtW
 hJaw==
X-Gm-Message-State: AOJu0YwmXUhb2JmhyP0zsZLK1KaTuS9z0HG2eFS6YSU88kWLdVmGNJlr
 CQcyx+R8K1qhRU6YKRr07akC/OyJDORiE4W2nblJmWimUxvFraprhEqBTPYk6Whb
X-Gm-Gg: Acq92OFsecae8UFaXARs1cMrolP/CcdWFXsRCljZrOjLMBHV9vEsIH0ChiS9o7uOhiw
 TSK4Wn22lONIkrC2CX9B8jjwPdbMCLJ/0sFkSHmBKMDKaQb1wpjYe9+SStytln6P/v1V0hqbTSK
 g4MPtInqMfyy40WvCSOvECZKABdBWJpTt3gx6Vl50X6kNB741M6xTBpetfIfMiihI4p8PpyeTtH
 +zMe8wcppS0BqGVy1wDB3de1H3AnjkiNOQYAinM1O/DlOYFKFM4ojuCOZ7EN1URK7E1feYoe94+
 RkzsWiqNFkgpuHvylETj9J435dlAEYJoSGJZrPkmvXsgyXey2utG08t09J+D5cA7jXtk+ZBDMj8
 rV39idboJjnR6EjdUutNZDu6sCvPEgvS9b0Tz9FjloVuntyv0WYRZx4SNzFDYugbEiWGIQxZ8cW
 bRHRkNUTb272bua6V+l5tzjq0df8Dmo7y488lVhJ3SOLmopZbAgmRF
X-Received: by 2002:a17:902:ce92:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2beb06924e5mr11266125ad.29.1779408221570; 
 Thu, 21 May 2026 17:03:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:03:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 02/48] target/riscv: Deprecate the shakti_c machine
Date: Fri, 22 May 2026 10:02:38 +1000
Message-ID: <20260522000324.23255-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V shakti_c machine hasn't had meaningful contributions since 2021
and is currently unmaintained. The machine is scheduled to be removed as it
appears to have no users.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260430052218.771358-3-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst | 7 +++++++
 hw/riscv/shakti_c.c       | 1 +
 2 files changed, 8 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7771b98b72..97750f5edc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -242,6 +242,13 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
+RISC-V Shakti machine (since 11.1)
+''''''''''''''''''''''''''''''''''
+
+The RISC-V ``shakti_c`` machine hasn't had meaningful contributions since 2021
+and is currently unmaintained. The machine is scheduled to be removed as it
+appears to have no users.
+
 
 Backend options
 ---------------
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 49a39b3021..852d5b9797 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -83,6 +83,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, const void *data)
     mc->init = shakti_c_machine_state_init;
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->deprecation_reason = "Currently unmaintained with no known users";
     mc->default_ram_id = "riscv.shakti.c.ram";
 }
 
-- 
2.53.0


