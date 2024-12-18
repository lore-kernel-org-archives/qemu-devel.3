Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292D6E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZH-00038T-OS; Wed, 18 Dec 2024 17:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZD-00035v-7L
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:55 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZB-0003EO-Op
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:54 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2156e078563so1507205ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561052; x=1735165852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfBsTLHHJAqAyiojHCc+AdM1qTiCchVJT8tynBYysmo=;
 b=XNksyxaxyYwDBBO8gtlkOrQxCAPT0ma1tU3Ie7AKnmt6a0bgoNvwAHRT329txN/v1q
 SuXIKQV5Y+X2WxRjRl8I1TnF+lnu1YhPBApMoJ01YXz2VDzv4sBEoKO7XdpAMXx7ZB4X
 6uqTTqi30/QhJHktLaRrkdthYh9rgkLNVX7ElH692iXZSekq1SkanCiHousNZgO0lF9w
 CRAsUIO3L9obS8qbdAY51Ij6JAFmDvFL8OHZQdorWg0x2SEhVZRDhXSX4EucIOJfeFgt
 dm+YEwST6zkH3KFpkCpxkaOHCiBs3yjuCDO47tmCYr8vb7+QCWub4KWXRByVjURSVi1e
 plZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561052; x=1735165852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfBsTLHHJAqAyiojHCc+AdM1qTiCchVJT8tynBYysmo=;
 b=U8UxtkmEip29jKpmWwIJ+ctIxmNlyzqw4I21isAlowbDGd6Vj89zwMFQSJd6YTkJXO
 C4Nq+GNe+o+t7dxFqxzVJIV8S3fmKk7HzCULLqjPoTmnF2/z/q6RPSQrDnXNZc9KYbP8
 hvFXuOIWWErvkrLnZzH4/f85k0uWeQ77fiuvTYNV3/GWB/sXFiBNqaN8IGOi6mzADXn+
 zp5l9ASjGT5kuRCdsA21qDKydV/Kz/1CEN+KRa+IU2Ev3aZLuPka5KVUgyp0CV17YO4w
 79umLJME1g5TViL/pStrBc1a7piP8zn3ULavZIOOHrhzWbH3RlNAIH15XwniSoE38a+T
 vfCA==
X-Gm-Message-State: AOJu0Yw20jIAB1xze7Wy5RB5N6RaIE9O65Md09pY9O+9MuUIW/A8lTHs
 +dZo/4hTnr5gNPOxpKYWKirR5uTY00QmGXPm8EuTJX9u1y1t1t5nGTh6Hs85
X-Gm-Gg: ASbGnctahRW8UNE4o6ewpfLtNogfEqueSlxUQxm70eTKYuWr7pWJug408lbLTE8Oyo0
 gvhqI4MObrCQAaM6lxKruBzp1ToV/OoowFD9tKdBbqac0M3u5A91/zwid21uKpToW+pOsZi388G
 Kne0T75Fv9woS4G+xBTpqoF5Iu75BgbYMXWLQZKD44OZk4JjRsz1eqqLmb4hDBTM+/RMOjZ0DnA
 +/2cmJasGqRxSTI9tH2rQl7OdGyjFSyMtquZ+mQq9WbBUte/xUaK9479l3LX2BBPFMxVwXeoYTL
 pFEVowUNZKvqcvVgV1iQ3Q9RE8r+RVGuxilbMW2Q59qEQQMKCNHwWXRC6VN7DlU=
X-Google-Smtp-Source: AGHT+IEGgCpMAx4JQ/oVktsslne4mSumHJuI0Itb4gIliA/h6dWXq3cN6fz1G76+gNd7R0Q6qCZlIQ==
X-Received: by 2002:a17:902:da87:b0:20c:9821:6998 with SMTP id
 d9443c01a7336-218d70fe3fdmr63676855ad.10.1734561051992; 
 Wed, 18 Dec 2024 14:30:51 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:51 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/39] hw/riscv/virt.c: reduce virt_use_kvm_aia() usage
Date: Thu, 19 Dec 2024 08:29:42 +1000
Message-ID: <20241218223010.1931245-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

In create_fdt_sockets() we have the following pattern:

    if (kvm_enabled() && virt_use_kvm_aia(s)) {
        (... do stuff ...)
    } else {
        (... do other stuff ...)
    }
    if (kvm_enabled() && virt_use_kvm_aia(s)) {
        (... do more stuff ...)
    } else {
        (... do more other stuff)
    }

Do everything in a single if/else clause to reduce the usage of
virt_use_kvm_aia() helper and to make the code a bit less repetitive.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5d058511be..e54e1257c0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -783,6 +783,10 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
                                 ms->smp.cpus);
+
+        *irq_mmio_phandle = xplic_phandles[0];
+        *irq_virtio_phandle = xplic_phandles[0];
+        *irq_pcie_phandle = xplic_phandles[0];
     } else {
         phandle_pos = ms->smp.cpus;
         for (socket = (socket_count - 1); socket >= 0; socket--) {
@@ -800,13 +804,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                         s->soc[socket].num_harts);
             }
         }
-    }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
-        *irq_mmio_phandle = xplic_phandles[0];
-        *irq_virtio_phandle = xplic_phandles[0];
-        *irq_pcie_phandle = xplic_phandles[0];
-    } else {
         for (socket = 0; socket < socket_count; socket++) {
             if (socket == 0) {
                 *irq_mmio_phandle = xplic_phandles[socket];
-- 
2.47.1


