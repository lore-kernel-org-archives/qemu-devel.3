Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FA8C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eEW-0004CQ-Hg; Tue, 29 Apr 2025 02:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDk-0002hY-NB; Tue, 29 Apr 2025 02:13:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDh-0005S4-9Z; Tue, 29 Apr 2025 02:13:31 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227c7e57da2so47536955ad.0; 
 Mon, 28 Apr 2025 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907207; x=1746512007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iktpIu7SWJtpnnDwsmtRLfc5OtKIy8xH5BFHKzvdoFE=;
 b=BI9ov5arGprxI4WclIbMYsYoFPi67l2V8H+7DzHAx1HxSJdEhreCqDTwbrqOi7lP1h
 8WU5RW+/0Ch/MBVQY5gUo7lyJGTlWywxgR7lsh6yysc0Tw3AxnqlsoFTUjZLi+mt/IX1
 AcxgHV+f1J5CWA7aAemsE1yNTV2zPx1iZkrTUx/n3Mt4ZKdr3Ugo6E394TqN1hyZ3LhY
 0o/9A00mUBUjuD1OvfR4l1g4pgz2dk708wozRWjoRYv3Md0f0mACWNNHI6g6xJMLhv2D
 vdT7tWJ07217M3ca8RDtPtTVA1oLUdNDodNveRqyYQrAY8kTCcCzPbgSQQmeXxCqZnie
 L8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907207; x=1746512007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iktpIu7SWJtpnnDwsmtRLfc5OtKIy8xH5BFHKzvdoFE=;
 b=suC7ZdP89D+jmQjKa3nYQCvlX1KtttrQX96cIRBZwPYlWg10WWKZ61zgpN5sVEF57c
 BC6d9XrCKWmt3qYBIvVc8qi2HBNfgLDgWi72Va9fWUhwVgSfj28uaRyIpznNnqX19M79
 4MkgZLZppKMCP1L2k5FHNEaG6H6geu8+EN+DPpDL8n82lJGtFpfJi0UgcI5aTlef9vqF
 ZIxOMkqhtxLh4fuTa/98l1m8ncw7Y64zniXDsUHwfcJK2n1O8f4ErmMt9m/E8DU9L22i
 DiAXDDYFwI9WYVjCPl7RcbVZ9eJQ5EOHjaELBgbXwT4jHVXbXW436uH7ycEgwqHKil06
 Ym6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZmIUTYCd03wYfBrYoqDRz4odroiOjawrPvOmJdTmNjOy3XmlJNiDSLnYQbVR+xWYjZDvH7SuXgIso@nongnu.org
X-Gm-Message-State: AOJu0Yz5Y2JiGkM84Pxmxch49GewggHpDVnR90zRQ1FGOOMB3S1NUqnc
 XPXr25mzzqDek3nK7pjrOyMJKT2B/wC9UD9KVJy7phhDaUHx46r9oddMPQ==
X-Gm-Gg: ASbGncsO7fJSzt5shH+hrwVpu1Vy06idbQ07STx3j/rKiMrBjVgrmOWZBaz85LnUrPO
 wtr9VCu/+VxqcepSwO1hIiXkpAxsj+y7lKi4deR0HYnfW9R3cfmTfyVuKz3fUBrD2qnSPB680hR
 9RLUehIJLs+kVgIxrGBwyzp2RTAsbjMpvbCpnGjAhA6lgkhtaE8jp2p2uWmXgS+LxgfXs5dErtb
 2rANc7tAWHIKwVozgfhQDjQIXv+nZ76XfzXgp/Q2e5Fu8UulhtTGVXCiWbi3qUDnADKaI/dW691
 EHZlWs2xike50QE+VjjyjRkzsUGwRn2rk6OJDW6XnUV4M7W9ss4=
X-Google-Smtp-Source: AGHT+IFgetI6sus7o9QHIx7THDiC5T3npX8Cf2qF2P25MrTljoQgDmdgruFQ5tFCrfQKY3VN1TtHyA==
X-Received: by 2002:a17:903:1b6b:b0:224:160d:3f5b with SMTP id
 d9443c01a7336-22dc6a827efmr179985605ad.49.1745907206776; 
 Mon, 28 Apr 2025 23:13:26 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:26 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/13] hw/riscv/virt: Use setprop_sized_cells for pcie
Date: Tue, 29 Apr 2025 15:42:21 +0930
Message-ID: <20250429061223.1457166-14-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f8943f81790c..cd19c266e62a 100644
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


