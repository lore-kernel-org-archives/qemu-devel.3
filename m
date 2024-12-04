Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB4FE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvxH-0007b0-BH; Wed, 04 Dec 2024 15:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvxF-0007Ze-5y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvxC-00073u-KK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:36 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385eaecc213so114942f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733343993; x=1733948793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMiVeD+NvW1fa7vIzwk9nB4EqLDwXQxpVEw4CRgejIU=;
 b=YBpmGZDfstLpjl/RN4Vx/k5ltxLmhf7FgupLyh4t7ipmqbUttxjZapBrKzGg+MMJpB
 bmsFzmT0j7kgmhyu951vi14v+vIVhAY5+c0PsBZ8agooqEbJYuaNRm15J8bQXFB40Dv7
 owX3vlwpkcc2arFmlSZNE8b20Ev6aNpH7KeiGC5EPqUsalc49/OKstb/lNoYDEYINAOn
 9nUIGphkw429GfOUwq+mJKLiqfHeiHLh0TGvKNQ2SOjip9zdSps5HWCO18ddVsI+h9yp
 I7YXU3aEenTVbCt81QTHqmslaY8b27oA/Mdufpz+OBRsgWpnQrRNqL/FCmMIhSMYeIpy
 UCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733343993; x=1733948793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMiVeD+NvW1fa7vIzwk9nB4EqLDwXQxpVEw4CRgejIU=;
 b=iD3/lvzl4HKiHPq0jqakx+ZJTBMacv/fC3bb6DwfvvGkZYzM9Clu+sfkdK0eibhqMK
 8mt8to3MtqvufMc7MlO6ZTj1v92y39FiqPWHWlzOZn5nF4UjGVFzgafOYKpycvpIUkY8
 6+YyYxsoByBGJ/NPRTh5EGkPnVSqETkh4JSr6I0A4CgECG565DNVrdVEPkKDy9L0VtVf
 f5LKVrbzjhITQJzf2LUjfYscgUhvHoO8gQKieQGmJIsTqCmq3U8R/Ppw0XVlP42wqsz7
 kCBNT/kaYQDLrCHsjY9RH4COpg40SY9DYQj6LzHzRHuJPC+D98JAYnNgWBrW7smHCNa0
 sLgg==
X-Gm-Message-State: AOJu0Yy9bkRhXMI9l5aGPhcDvRjbtkBcu3fhdD9p/eeoy9eMmtX3RmP4
 w8YSAyBLO9zVIvK8dySBMDghtlLuZiyW1OhuiETpEBFs9N/hDOr5cXwQCK81khSCMtiKFJOF/RO
 J
X-Gm-Gg: ASbGncuWG4e0/EvZRqqqjdioN6Gzcjng3YNi5BkhmKlaIVMrLtArs39OWz4OHc2J7Lk
 eaQ9fBgx0u2R+nOXjVjGg8v6AvfRXHH95Vpb9VfuPa4PyFHMwT1xVL8x2ig0IvWUB+TnB6hyabf
 NR764LzwOXEvvyekv2VW2sIXt5yavvNz3qxdt3K3CCfVXxeFbsvoA8z8bA3CEWoxRKVbo5KR5P8
 HBKk0fuUkCFORmvCKu/ThK2f7TyQg2sk8H0AbOwTP7RRbgVZPf11oLPSuyhzGdNCOEVeaxKUvHe
 e7Rp6YhqVxXTUESFnx9Z+TKw
X-Google-Smtp-Source: AGHT+IGWhwjv2J2oO67dFvzI2OUj4axL/zRmbmzFJFjahHejUxN3c+TpGi6RU4aHAiB2lykmP3GeYA==
X-Received: by 2002:a05:6000:2cc:b0:385:e8e7:d09a with SMTP id
 ffacd0b85a97d-3861bb5a42bmr666212f8f.2.1733343992917; 
 Wed, 04 Dec 2024 12:26:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385f10a12dbsm10075187f8f.105.2024.12.04.12.26.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:26:32 -0800 (PST)
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
Subject: [PATCH 05/20] target/rx: Implement CPUClass::datapath_is_big_endian
Date: Wed,  4 Dec 2024 21:25:47 +0100
Message-ID: <20241204202602.58083-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

While on RX the endianness can be set at RESET, we
do not implement that; only little endianness is used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65a74ce720f..391f3214168 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -27,6 +27,15 @@
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 
+static bool rx_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    /*
+     * Endianness is sampled via a pin at reset,
+     * but we don't implement that yet.
+     */
+    return false;
+}
+
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
     RXCPU *cpu = RX_CPU(cs);
@@ -217,6 +226,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
+    cc->datapath_is_big_endian = rx_cpu_datapath_is_big_endian;
     cc->has_work = rx_cpu_has_work;
     cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
-- 
2.45.2


