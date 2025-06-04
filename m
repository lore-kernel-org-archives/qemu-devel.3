Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9F4C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIt-0002Ee-Au; Tue, 03 Jun 2025 22:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIp-0002Da-Kp; Tue, 03 Jun 2025 22:56:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIo-0000RH-7K; Tue, 03 Jun 2025 22:56:31 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2320d06b728so54526615ad.1; 
 Tue, 03 Jun 2025 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005788; x=1749610588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cPu0mtekVksYgzSb8SFLIZhjgTCV3V/MOS6qVJu54E=;
 b=lsNyAYN/zH0nEdXLqJnBq4LGQfEcUj84Ks7nSps9uLlTw0JywAOzSlx2Q5PbPR3HPM
 i1x2zarfBHylaDdpOwgDhL55p/1RpmqW6wfscpLpcHpXQWfFVTME4WhHs1x6Cgc0m1mH
 vDK7iseiuQcwdUwS8bEQhKYdDzBrBDvm8/WsEpy30nk9RhV2lgxJKQtlOSG9wKnIy4Oy
 8BT8HfdpQT5Nl4Igs+eSm3gPvl0o+pNa6ueFft+kzMtnVary/yqXtEw4BCy0qF+YVAYN
 IdT2Ln9dTV22+l5mw9ppYv3N3wRUmskHBaBg8YvzxeKODYn0fiIb0jcrkdx1gNbMG3j8
 bqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005788; x=1749610588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0cPu0mtekVksYgzSb8SFLIZhjgTCV3V/MOS6qVJu54E=;
 b=BSveQVg8lYg7s1P2f+VdifwDsVCRfC/igjXDj8kcu7NFYjEkWeLYTAJ7dDx4f54/CC
 0n5RKWL6hHaIWSp5CpzjTrCdeLRzA4FRtYLuoPsJcL3GwOnnrKpLq3lCB53R/AKa8gmC
 cNU+9SMfX6NJOc6wHGlhNmnU5nybEZk7TGMDeopARpwFDYrBETFrAHNVwZECA700junx
 S6SlTIZXB7mxt6+zBRLvfFez+yDfFYGuxpjrBeIMEngJSQoFGBSYmlrW18iQ++YDek0u
 tf3XYbSqlEdTi9hRPRNS4u65Gzi0n7lamTleZSTXQi+oyxoaINhQ/LsDqHZ4Ron9T/eU
 CIYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCbeZ+CB5GqjOAJ0N7QQz43TvBEoqcr6RyFDZVHhZ1i5xj0r7reELfWvnBWJ6h4eWSi4iOZxoHJdQ+@nongnu.org
X-Gm-Message-State: AOJu0Yz7ijRJEuNWsYohrRv6fIYp4xYpnfsJvDvem/0LYC5yz0VxsW7G
 XEdOaFyaBfPyjNATvDifgNa0+42CjRRn1rEqUfNAHRBofhfPJVlkaQiO
X-Gm-Gg: ASbGnctM67WiHzNtV6kjt9RGyT6pkcR9Id9qdyJotiqMxwKXjRErPVmxBiZajQ5ftqh
 SdWyIygvTGIh4TIjMuUoNnMTsD9A2SYePtDpjzzfPCQq8m06B/3xu01mfWd5MMry0kI9k1BbSGf
 40pDPfUzlDJHyZx8iT9XPeUeNw3Iq9XowvxqOJTjPaqja+Qql6jJybzKABfTRTrBb+slwcuZMh+
 LPfh9RWSSHzt1iWZ2YrOIFJdBNQ0pQI3dIq4xnPnNDlR3pvgcVdtRr997gVt+FYFndcoEo1afmM
 WtF6Byw1/I92TJfGh7Jf4We0/fKEZ/ktP57ae0pFYWQQDzY4FhIf/lyqQZvvjA==
X-Google-Smtp-Source: AGHT+IFeRKR9b4x6GfqerkCJAcpkL1KCHjA7eI4OKRbTA6JHoEDzsyqprKBKr2pQIR6LQXejZnVN5A==
X-Received: by 2002:a17:902:ccd2:b0:22e:4db0:6b2 with SMTP id
 d9443c01a7336-235e1485adfmr15698805ad.9.1749005788386; 
 Tue, 03 Jun 2025 19:56:28 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:27 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/12] hw/riscv/virt: Use setprop_sized_cells for pcie
Date: Wed,  4 Jun 2025 12:24:48 +0930
Message-ID: <20250604025450.85327-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 67490c5c693a..47e573f85ab1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -894,8 +894,8 @@ static void create_fdt_pcie(RISCVVirtState *s,
     if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
         qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle);
     }
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0,
-        s->memmap[VIRT_PCIE_ECAM].base, 0, s->memmap[VIRT_PCIE_ECAM].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
+        s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].size);
     qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
         1, FDT_PCI_RANGE_IOPORT, 2, 0,
         2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
-- 
2.47.2


