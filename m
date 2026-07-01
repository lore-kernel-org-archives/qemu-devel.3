Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AB8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1z-0000x0-Bp; Wed, 01 Jul 2026 06:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1x-0000ry-M2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:57 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1w-0004jP-2c
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:57 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-139f1dfc9faso744953c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901135; x=1783505935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yq170tBvYJhjNl5jxtQqmp4Ji1n8Mlf/iO3gU/wXZDA=;
 b=HIH36gw6r7MUW8f7l9syFM1Q+YGHSvKGGaIQM9UP35+xKMEsC8fuIvzKxUflHDkUsX
 Wub+wT3ym2rGtxh2ARTY8uGUkiT4l0u7YYEwdokdGtdoiX2YcXz4CKTjmrXWYL6EOq6G
 xt9hnUw7oRNh2xUfuOXWknT24h/mSkGp00o78qpOnnftWGt3U8/vF7P3QKSxfBt74UvG
 IXz8Lnqb3VvtZxlCh46QmNYlZdNvUfbHOgYjSLoQy5Ci8jUXmT9XoYRgUb9WAJGE4Tw3
 AFRM8n2C+EeJVhSRF87pQPW6Mp1nOokfGks+cZHSfe07kqvfbJZ8wuRVvf2c2764l0Xj
 thqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901135; x=1783505935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yq170tBvYJhjNl5jxtQqmp4Ji1n8Mlf/iO3gU/wXZDA=;
 b=bqhHu6FAGohYVXUTByyD6zvcx4NPzvAHEdP7JrvJegp5PO0bsRMLHz4n3xSvDXxWmN
 pAFVA+ZvUitttqtI9dRQ5SxQszm/V8ehP3rsQse0YDRAb52ZfANzxgpzZ/I0Wb6NYujj
 edq+G+qR47b8u0mT2tSlN0d/p4esKIFJU5apIxHmfCGdchAZLV67fdgkE3gteP1mkhWS
 Thc4LMXvbZ9A7GkApmLZYnxrH4tbkyfuox8P2b28ms2i8KcJQrXur5g++Nj7GZSSchdy
 0K3QERIiTxvsChVMphFt/uVfxRVYN3KFwWeT+Nx5WkX1rf/5STWZdITCfaFQCDG6bcp4
 0Yxw==
X-Gm-Message-State: AOJu0YzFf6A88299I2uaCrdfb/M+TBnEkSNU27ilcA9CroKlbppU8X3h
 +hdmwjECNzsskfGsDDk6YuR1lcV6oiH+Zz70NnH0AOE/BQAIeTvj2nwu0iCktQ==
X-Gm-Gg: AfdE7cmYE/Tq1q8ZR4ZTaYaXPkA3CHiF6St2fBzY7hHZX5xP8WoG2Z7JH6cMXzVPUh4
 1V3JRrPBGqlmm/vSLpkAUd/7CA7GIaeWANGI7Yvy4NcerLW6Ka/mLlCpm6CSnSaK9dFgvIzHz4V
 cNx/mq0PfoIvGbBjMt7x7EwadcaqUUxJE+3sVP3g3XD4OYJifZGdSze5RfPR38vSK73hZXAdRj/
 ju8GlOllLy4nrORfudeoHcj41evwaTtowkHfrJJfctlHUN0gQ8ElHhyG6kuTEc2+qLVvGNcESjl
 rkJe2Q/j8Qx12KZegnJ3ekZ3JK0kUxzA8Sf7g/F3tWOVVK29WXcUHsui3UZz5/UO6Hx9MsGsr4e
 W/6pGgZANB5HC7eLL7vwDEjh+nGIFKDIpU5Nj62HyhaUwhFzoZCc3nwfRF5ebsd6JH76zlfPeR0
 mQpOg+AKi+KvrvT2Tt9CZgAEtIWofMFhQ=
X-Received: by 2002:a05:7022:45a8:b0:138:3742:fe4e with SMTP id
 a92af1059eb24-13b390d7003mr222641c88.10.1782901134694; 
 Wed, 01 Jul 2026 03:18:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/39] hw/riscv/sifive_u: add #address-cells in PLIC FDT
Date: Wed,  1 Jul 2026 20:17:28 +1000
Message-ID: <20260701101752.2522962-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122c.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

By Linux FDT docs in [1] the "address-cells" property is mandatory.  Set
it to zero.

While we're at it let's also put this new value and the interrupt-cells
value in macros, like the 'virt' board is doing.

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/sifive%2Cplic-1.0.0.txt

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260616235939.1358663-4-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_u.h | 2 ++
 hw/riscv/sifive_u.c         | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index e4c9860d50..aed966a62d 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -156,6 +156,8 @@ enum {
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
 #define SIFIVE_U_COMPUTE_CPU_COUNT      4
 
+#define SIFIVE_U_PLIC_ADDR_CELLS   0
+#define SIFIVE_U_PLIC_INT_CELLS    1
 #define SIFIVE_U_PLIC_NUM_SOURCES 54
 #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
 #define SIFIVE_U_PLIC_PRIORITY_BASE 0x00
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b3468254f5..7dfc18d3ec 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -213,7 +213,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
         (long)memmap[SIFIVE_U_DEV_PLIC].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
+                          SIFIVE_U_PLIC_INT_CELLS);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
+                          SIFIVE_U_PLIC_ADDR_CELLS);
     qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
         (char **)&plic_compat, ARRAY_SIZE(plic_compat));
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
-- 
2.54.0


