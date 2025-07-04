Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABB3C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeNC-0004wd-0Q; Fri, 04 Jul 2025 07:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMe-00038H-St
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:00 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMd-0004HD-7o
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2349f096605so12203595ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627634; x=1752232434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+R/Awp2kBJgi+4PesyqDmlqh5JMpztF609WYNFqZEVk=;
 b=IrWqZr2r+UfIFycspB5PMvHB6Mkofcf/Fvyg5GY/uASvALr8isT9MvyIrSR+T64MNc
 5uizVri53t8FSEweuizJczW7S+y4JDKPWXPxTjrTtMrF4IXaY2bhRHMCWnSKcd3wTx3S
 b+C5u1YoxapO5pRorT0GTE5yKDycUlBObI9oxeFgWLHA+6L+9UgOdvYH7Jwe7cx0BmJo
 aL05aqh57M1IFNgYnRYCWGKr1f6HhtSSE7cvAe62H5S28/OP9e7JLKPIezCWgo6raVbx
 B7ibbuvbl6658InfmlhPkNR73p9bnU51YIxj2VVFngsINR72YuZD2EVKe9C6V4d0Vdmf
 nQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627634; x=1752232434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+R/Awp2kBJgi+4PesyqDmlqh5JMpztF609WYNFqZEVk=;
 b=mG07k7HQia2UL27vAUBRQrpOldlbjtzrSJSQFaBm/PKDrNVbBiSWCq1v1RlhSbgnNj
 S5i2AOTyNVTmmBuTa0WJZWG5x/aGz/fAC/nrgOHIQCYmaIEtp8+Td3jKdItySuM6u7cF
 Svg69xCAGDGcyiMAs78WYUuKlbc0I+7qGD0T70bLZoNI1HIw6XpQ5u6MmiGulw0nJ2JI
 wVv1jh+tN04aVUZgrQpuKhN7zp+/VciTxBOC+PSAQlsrFwLgU4Tb7oiD7gJZwuJUTA7Z
 uqcQEniEO95tDMh8F9XNJ5NE7tyBaurO/kS/1I3uvUEtRYdxxBwpZJetUqsWcv2tNlkb
 iawg==
X-Gm-Message-State: AOJu0YwdRMPpZtu5vVeonpv7VmcbXHA81wRNHUh7MUTFKmfxw6Z9ijRO
 cgCmIz06Mwxf5l7oi6ZdE05fLFGj5Gucd4ZRJSKRvssTcuBluLvBdi/7dNEkIQ==
X-Gm-Gg: ASbGncsMBMj65ct3CErbHNxZ3qaDMZfFbU0oEKcocZFmk7o9z6IDI2+w9QCGAO0WlAn
 zGDAQlaWevk5rYUu0rY585YBikf0t9Th9XdvZUxsmHVCi3uplJjSrwkHz/sgwsUlSkgBzFeD9BN
 zNRFZywlfw4u2DXJfVCcQO9jELzO5u64WSMy1e7E+GaD8SHqOXOjVsIsKRDGoGNNIVX2Itp5c8s
 RvRactxKvKh4kfQMw71FQVpBSjU5o5sFONy+0OxscAOF9uC0taSelwoiBOxzltoG9NzcUrbMwh8
 d9oYot+oPseIs7rHANql8L6095m9ARPtpp4KsxpK6v1INsA/ZIZN/PzjSkivzxGUUF3FWdryktK
 jJSUow4DyUdoMrLwIPxNAyKwUywckaSj1Y1nBsKAbNXH//WCTfXw2k4FdSj2ihwJPaEg=
X-Google-Smtp-Source: AGHT+IFoLOHEEukzmZ9z5nNkReD2gKaQW0NMdmvJJ5e7kH7yYg8h5+P8aW86ZKKh0tDb4LC/E+i+ZA==
X-Received: by 2002:a17:903:1b0f:b0:234:be9b:539a with SMTP id
 d9443c01a7336-23c8759e7b1mr32723835ad.40.1751627633684; 
 Fri, 04 Jul 2025 04:13:53 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/40] hw/riscv/virt: Use setprop_sized_cells for reset
Date: Fri,  4 Jul 2025 21:11:55 +1000
Message-ID: <20250704111207.591994-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Joel Stanley <joel@jms.id.au>

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-9-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 851c7cc82a..b59f10dabe 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -932,8 +932,9 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
         qemu_fdt_setprop_string_array(ms->fdt, name, "compatible",
                                       (char **)&compat, ARRAY_SIZE(compat));
     }
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, s->memmap[VIRT_TEST].base, 0x0, s->memmap[VIRT_TEST].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+                                 2, s->memmap[VIRT_TEST].base,
+                                 2, s->memmap[VIRT_TEST].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
     test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
     g_free(name);
-- 
2.50.0


