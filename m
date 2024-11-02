Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D372E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0t-0003AW-6e; Sat, 02 Nov 2024 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0b-000330-2C; Sat, 02 Nov 2024 09:17:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0Z-0001wj-4w; Sat, 02 Nov 2024 09:17:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so437680566b.0; 
 Sat, 02 Nov 2024 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553456; x=1731158256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODth02XHk2l2sGfVJHhWS3UJ9E3eRYVl7bEr+6Us9LU=;
 b=ht3NmocABLe47de56tPTqmi4JFIWi7LrAjf0G7ZvY4RZaLU0VvJzpxdd980jfZkjGv
 wW3eO/m+zNUWkDDot6aw3sPZXXX9gVcuVY2Lys4I4r/ft2rWYisgzeSyplZj3Yr1ZCkz
 qmcqOGdK4bOzNsaEsC+o84vQBNVKlNfh6hY95hBFEI1RiUK8QkMONq2dwGBPdpvxW0b4
 aXVgrh912LiwxnRKrCyZrvO4VBRZy5CJrUDQBzwlQa6VaXyu1I+9heRgW+LK0x+vZKQF
 C66DEL9UzkBS3v+las38nuukRzONHm5CPxlmYRo73Bc7O6zTLgwv3A3CpgHUs2cFiT/d
 MDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553456; x=1731158256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODth02XHk2l2sGfVJHhWS3UJ9E3eRYVl7bEr+6Us9LU=;
 b=c0wNoB3fXIvKmOnlpUq+bYhvfpG089QKHrMjWybGlmLTF7f71MoyFv2GApehrBzgIu
 s2ebpUsfCsOn3FL3KYaEz4N2aGuTbAgNXcQQFXwypS14CH4uE1Z+ORLJ9gkuQABNtcXf
 SXfzLB3pzjIZTy1KPA+ZWIrySpeYjf2Y7o7IdNNrpBQrrSrrJFdGgeAMf2nUmdnDUHmk
 rGr44rV9OooLQew19hvnURccjYEt9KJaDkTG/5FRIdzi9zIIEysnqOamck1tNivKtzhD
 h5u+EcZroc2eRMhseuz44EW3d2dwHsuacQ8twM3SJDeYYaWNGm5x5yxw6Ty2sW3RA7K1
 IHJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ5JK+BHR8QPysVxg8TTLrZ6jHg0Ki9goJe0zVrt6Tx2ErFH7X6ZcMgzzoSSozHolSlFLLSP1/etcj@nongnu.org,
 AJvYcCVEYWTHSZ52LMhULSKQqFAJxwTNbkYG5fsr7l5L9OzhPycD+ZSTj6nEBhm86U+bWR1NSvxNEKeHYfc=@nongnu.org
X-Gm-Message-State: AOJu0YxvFoeb9+FgrHUy4L7yDiQagTh4gXDTk8rHbpP0SUzv4OhdCxQl
 Ua4qVqwzOPqbURVdGuXQICtKfRDI7mjzdwYKn69FfWY4Ikn9m6rC4+frAg==
X-Google-Smtp-Source: AGHT+IGr+Keipjacd9uv6zZ0RF1WLIt5xvSWOFxT0zLaUtwAoNTLtlrvuVaD2xSPUDPvn8KdXRjm8w==
X-Received: by 2002:a17:907:3f23:b0:a9a:55de:11f4 with SMTP id
 a640c23a62f3a-a9e658bc988mr512896966b.54.1730553456094; 
 Sat, 02 Nov 2024 06:17:36 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:35 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 05/26] hw/ppc/e500: Add missing device tree properties to
 i2c controller node
Date: Sat,  2 Nov 2024 14:16:54 +0100
Message-ID: <20241102131715.548849-6-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When compiling a decompiled device tree blob created with dumpdtb, dtc complains
with:

  /soc@e0000000/i2c@3000: incorrect #address-cells for I2C bus
  /soc@e0000000/i2c@3000: incorrect #size-cells for I2C bus

Fix this by adding the missing device tree properties.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index ecaaab1558..a0c856568b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -196,6 +196,8 @@ static void dt_i2c_create(void *fdt, const char *soc, const char *mpic,
     qemu_fdt_setprop_cells(fdt, i2c, "cell-index", 0);
     qemu_fdt_setprop_cells(fdt, i2c, "interrupts", irq0, 0x2);
     qemu_fdt_setprop_phandle(fdt, i2c, "interrupt-parent", mpic);
+    qemu_fdt_setprop_cell(fdt, i2c, "#size-cells", 0);
+    qemu_fdt_setprop_cell(fdt, i2c, "#address-cells", 1);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, i2c);
 
     g_free(i2c);
-- 
2.47.0


