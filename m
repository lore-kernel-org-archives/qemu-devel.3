Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFF7CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9LW-0001f1-S0; Wed, 14 Oct 2026 20:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xH9LT-0001eN-W0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:29:20 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xH9LR-0000xM-AU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:29:18 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ac7a053626so128369a91.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792024156; x=1792628956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgVncG2NAYs4I+Cx+kp7rFgEZbzHj90F8O/5aLpub/I=;
 b=U4GDIRUDTzeFfEbVUmesqLXaqS/yPGZ2GyFj0+2Tc3oftBPsTwQoejN/IZUWqkj5kc
 ZHORmrflhhbDR3GoyJ36dRDJiaghQj20NewXZEujYOLbFlu5QoaaAMwAblQ1L/kmo+Dq
 aBQYHz0IGpxwxEhtKFEtgzy/aWjwGmGROhVIXzIa5ruURWkpgweuwaGUqbEFk8xGiYqV
 us+RtNNQ12vmoS1JQH90wBP3ajHdkNDXK/8b8v+zIMmNolaLB/gR1H+H062UVeWxQ4fh
 UIl+t+f9KPjmmwPx2jMRTxpX5i0O2cm5LWCatv8O93Jq4Q6qnxsQMw9nWtw3sP0Q5ks+
 bD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792024156; x=1792628956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EgVncG2NAYs4I+Cx+kp7rFgEZbzHj90F8O/5aLpub/I=;
 b=FA1C0AvyxSbdKQwYht2LpVV0yQr0+anfV/IGabRVdyatUdjtoHJ3slIt5ofuz3bP6J
 EMhNpzr5aC68gqDZqy+UbcuFpVBYzoBnTR3Sf9ZXbpiERAOhHem3YM7Zd9Lf5wODKVnO
 qXyf7HiWCe6vaKFqtiBohw1n+MzQrxhAtJ8Ev90E3sdApB+oZWuJs0+V/s9DL0/9c2r3
 Uykmo1iC4tPdpJe4dmo80nnCiMzczXwgqhuxsKrjFw6TuHqiuORIu59sDKbLhxchVzE2
 1igzzzxmK5IxYGqAQS/BFDOEz6UFRS6lbfOgEsxGxqM7RmZvcQgP9YFBcHGt6J8QXvRN
 HAmw==
X-Gm-Message-State: AFq9FYIAcUAoEJbO7ndsnOO3aYi/pGYOGNSdLdGFPnA2hQ2NXKjTnsy8
 OK/gyPL9zc2wTk4jrjz4TLNsCDCuEGLHI+m7MsPJ7L3GfOBc/t/vdHFL2ZgmtuHWie2A4Cg1rhx
 /9HoH6i4=
X-Gm-Gg: AYBFou3WznfyAZHRY4RiKDNhhnEzpyw+4MYTfW+swCH0PO4Z10QFy57rJIcB5JSQetN
 wmxKL6DKiEtWwDFpDMHN/RgL0/5OaSa1wtKPWcePesr5xhLQdRRjlIunqkXPjW93uNmTutzReye
 7ReMbSayhihAWKV/fNM/R3Pt93UMaFHuU5mivYF9hlp0opjKRk9Gt/ijLEtfPmP/M1Y7b2G7h97
 15rCfnBRubSMjnlS9N4cDM7y/JKn2mnPE+lU+BK8xYUxW1wdSV3Sn8/z0LuoZeYOxsMbUYxNPXv
 8RbmtR+Onl7+X4koy4uX6E8EBkusIJS7YPu8v7f2WaEGbPb/S5XFcmbaqGAhk+Iw1nYb+rpwjzR
 ikOxheIp/5dsB08TGn860T1I/tKbHDPvmEjWGGWdG22Gw6ZXExoHbtv4LFvL0geUAtY7CaePc0W
 LepYW3UQDqRq2EmQV9o85SB0v/clsOlHDSG8P5f5ScIHvEx1RhFnzd4LJS74LZOGw2LGGeXMxXt
 OqcxcVn1PYSG32hM1VuoHCmUi5X0Xiko0gOYSluJMYT+Wc=
X-Received: by 2002:a17:90a:d44d:b0:3a0:c162:51af with SMTP id
 98e67ed59e1d1-3ab39fed8b6mr23063896a91.0.1792024155483; 
 Wed, 14 Oct 2026 17:29:15 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a49d7bsm795730a91.0.2026.10.14.17.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:29:15 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v5 3/3] docs/atlantis: Update Atlantis UART documentation
Date: Thu, 15 Oct 2026 10:28:49 +1000
Message-ID: <20261015002849.1640109-4-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
References: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update Atlantis documentation to describe the DesignWare UART used.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/tt_atlantis.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index 539c22354f..d94d064f4f 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -13,7 +13,7 @@ tt-atlantis QEMU model features
 
 * 8-core Ascalon-X CPU Cluster
 * RISC-V compliant Advanced Interrupt Architecture
-* 16550A compatible UART
+* DW8250 compatible UART x5
 * 4 PRCMs (Clock and Reset Controllers)
 
 Known limitations
@@ -25,9 +25,8 @@ real platform. Notably:
 * There is no PCI host bridge, so virtio-pci devices cannot be
   attached. Boots that need block storage must use ``-initrd`` with
   an initramfs.
-* The DesignWare UART is modelled with QEMU's ns16550-compatible
-  ``serial_mm`` device; DesignWare-specific registers beyond that
-  set return 0.
+* The Atlantis platform has 5 UARTs but only ``UART1`` is currently exposed
+  on the command line serial interface. ``UART1`` is the Ascalon console.
 
 Supported software
 ------------------
-- 
2.43.0


