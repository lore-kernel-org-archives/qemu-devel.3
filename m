Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2F9C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMu-0004Rm-FP; Fri, 04 Jul 2025 07:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMb-00034A-Un
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMa-0004Gh-Dz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-234d366e5f2so13013005ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627631; x=1752232431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xxu/cdnHornKuK0QwVscYCwM6yePSasW7eC0BT78hNg=;
 b=WfSbz5S0myI16EHTZZ55gNBV47Q3rEynlb7yuXd+OijmBNYFmnEaihuuVmzkXeSW7P
 slh2ysCG9oWryuKpkOOxFSQIiFRNm5wHQRJnjp8z4b8RErTuuMIQJLfEGuF5oa9k6rGZ
 nhfr1enQFl/mfo1NU4z5eu/UffMiv4rkOb49Buhxloopvdq7eRuUtL1ytfkpQ5erxklE
 5YmUpWw1h7W0yO6jZbOELGTSIFOWKzmMZ/bh9632M3e8SUBOSPvWia+8afAru4GHO2+w
 SNoKT2rW1EM1os1vGvag/OedqGMMYJRvdmNnLq8y3JGQ9PQ/PaEGjV4ZhDTybfofLoKu
 9wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627631; x=1752232431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xxu/cdnHornKuK0QwVscYCwM6yePSasW7eC0BT78hNg=;
 b=DPXcuyy/OcFCXm6WcnhAhkjTJRfkVC9oQNL8zQcxbvn9t2/TIs65LftVJfGaZ+6Pf3
 GbLUdrQUEqU48T/AdLjhCGJi19waqesKluz8YJ5M8oawJIiUakysxkP81jW1P30WeiC8
 +5LdgMHYHO3IKer8JndPgGfLNpWmG6YXlihfrNpg0VashtitTqiuch6w2Drtwc6LeemN
 3eHtzLzU933yEa/rTFV3GGVdGuf47EXI/SrMhOZxTqd6VboM49MDsSON38YQ4t8PNVjO
 GiNsSAx09VWrAmUwePPNmYKkgaefv9ikArmqn+PZfq2Hx16QVroQBBX6MFEsUbPekFLu
 SGHA==
X-Gm-Message-State: AOJu0Yz3k+CqbBikJ/plYfvSwQdP4z6n2vNJ+3ont+8ovOTQBUGlgbnB
 Ia/maLVi1b1iwtd8RKKQIvfjNQPjzJnNQt4mGaBqbFzPOulkLAUS9Yq78DXC1g==
X-Gm-Gg: ASbGncuThch6DdNqxEZV846AJFhluqewmyoTtgJ2s3kfSGKbmsOtFYkRmllSr/0IkWf
 NxJlVdbnoIO19zPSDhmivs6JrHZQxj59iS6ICLTCdZqSCU7T9q15t+BkAorKqfsHsuB7KJVsicl
 8hYPXzc/nt8koOno821Jq/4wUXhqHg38j8QUexOzS9VAlW2SshOIbKlpiPolLxC6sK8vdWYi9+G
 DWAb6pf8PP7dpVExqTqmNo5P3YhQZ0dQIgU0fofvlw/7DkAIwpDCi09Pu8nxY4Onh0nOdu3DTjN
 D3fupQvFFXIW5bNKG4lv62ZX7hfZtAuKBl9bC8bvzp2yH9C5Oo9gaPEiCaEdKaQryTJ34Mf9vfm
 uwuHAu2miDYaqwWjjSf6JbfCadI3RgmxwQVh1XyaKdh4J0v7TiFGrarPDeFUSoYh4S0lhyPxZZe
 5wqA==
X-Google-Smtp-Source: AGHT+IE5W5LZiycotEa7VQdhxWPh+NCjdPWl5kmnmh0dgYZs4Yw55wZojqyiJ2WzGf7gAcRiyEYJDQ==
X-Received: by 2002:a17:902:f611:b0:234:a139:1216 with SMTP id
 d9443c01a7336-23c875b0929mr30677895ad.44.1751627630746; 
 Fri, 04 Jul 2025 04:13:50 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/40] hw/riscv/virt: Use setprop_sized_cells for virtio
Date: Fri,  4 Jul 2025 21:11:54 +1000
Message-ID: <20250704111207.591994-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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
Message-ID: <20250604025450.85327-8-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 67e60eec1f..851c7cc82a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -856,9 +856,7 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
 
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
-        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-                               0x0, addr,
-                               0x0, size);
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2, addr, 2, size);
         qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
             irq_virtio_phandle);
         if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-- 
2.50.0


