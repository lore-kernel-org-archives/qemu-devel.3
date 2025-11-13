Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D9FCD8CAC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJawk-0001Vz-7t; Thu, 13 Nov 2025 12:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vJavo-0000XQ-Nc
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:16:32 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vJavl-0006an-1L
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:16:22 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-297f35be2ffso15790195ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763054179; x=1763658979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFnadgi9dD0Vz2iOn7f1bPoX8rdwHzVBdX7RAPpODaM=;
 b=InkVPVZ/WJRVoEN2WB5nl3OCdqsO7BfMO9C0TNXMNVAx/Nfz3hGFeonk0rfZNHkHVp
 lKOWFrCZrefZg9RI47LYB5BxsIBtJGOSY2KlS1+ikZz1dqEQisS0ZDHHzm5wurLMeigE
 kfTrGbCW3jbILqRbIt96RB/JR6nyzlBBNq7iSwF0t7cuaUCrhQwyScSTWXMLpSSmKWcf
 52hxLshhyQiry6bgQtVkpLjGM5mDB+cSS85bx2ko2WqpbXtlYcjlF5KzD24sLlHEixfO
 yJqubfUeberxBeQBZ5ItY0q57M3InhcjlNM/k24YtBz8YMtKGCOztNE8yRxWemEhB0hX
 9Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763054179; x=1763658979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jFnadgi9dD0Vz2iOn7f1bPoX8rdwHzVBdX7RAPpODaM=;
 b=PBIB/aUMaIqcFiUz1CPUDL77xo/DPH/BLH7LqpWRdjRAfzv19xm+t9bKIgOjQnqYbG
 jmTi7RAME3DYUZS/73s+/LJaV82UhRf7ze7MWRU+HjmhBm2/zOJds5W0U9WtH2/nF88X
 150Sh0cSEECfPIEZnAZGP0fxJj30BRKVx5VAVyU9wBZf+/qEg2fgXBDeOPWPjufQ7s0G
 BPJiRTi0+K4P/4dcQMVDopfAcPZVPnYOrJKNGnAcTnAFJoxunGIou9MvVRupL5eXhtib
 1s057b66rPdxdeFMmODJPARb3BsiWr32aZaNJYe3G5bCA7ORWiU2d1k6FOBHBHzKz6e7
 kq9g==
X-Gm-Message-State: AOJu0YxnwQ0k4pMg3SBi/AMSliSgfjRAdbqTqoQnMRNTTUislU3V/R5n
 FmZ6hXJ8ybueNHxE2sUXfTgNBMTiNJPD98e8Cq6gma+H64L6pgV9h26XQK5/f9K58hhGZXf73Ol
 106iA3Rxakxd/V1q91LEJYVCpXJoXbUMoYJpIdvrqLZWs2hhD2DbK+DIIrOZjvmwHsdfc4V8v0o
 O4RG4PLjq6FkvP9yxBh+PW4i2DNe5BryXbm/KFKaDuAA==
X-Gm-Gg: ASbGnctztB90hGpEYAa2/Y2fiwtUSv36KmiQPLHQgZ63wR5ncxBpWOJ5kx/Ij8VSDd7
 UKmc1+bBMosVOfs4nCMkSCF/xHcpQHygugvWuGnr+u7K0m+D8TM9STehlqKzkAvV8b0zuLgpFT2
 EFMrOSndghaUC4bEpKJa/KZzqjHQfCQuXTOqH+G/UQboBjL/A/4SBTG5yUui5MKwQSjPHc7P4o/
 QUrXBeOE7MVsOC8+UJ0a3EBEbi0AbRx3bvqtNDXz5gIh7pAfUR9bKQL5JOTRuJ7Rfjq7lmQ7qyW
 bjUrunPtvUNd4JZlsEu5QkbTaR9WLZo2kLxRIOUh1QvTzeiK1dWkAMWqp9FEoOks/IDyRuuN5wj
 K9MHAjIaER6e1AAFaL4uWoZ31DlF9xvBWDuwdyf1FVQJHtULvYiSpngKsu7jC/OPuVpSXXSSTa+
 fr1i7Aib2VcPThL13l/lByOSSYLufHe+PlolMTqR6HFAi6
X-Google-Smtp-Source: AGHT+IFbojOjpLnkgvJr0rAkuol23EQvKvB1sajTn1r7SezGyJvQYJyQFj3NNclHy9ZSXzDI+WM12A==
X-Received: by 2002:a17:90b:1c91:b0:340:ad5e:ca with SMTP id
 98e67ed59e1d1-343f9ec96d3mr49194a91.12.1763054179260; 
 Thu, 13 Nov 2025 09:16:19 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bc375081023sm2712992a12.21.2025.11.13.09.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:16:19 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Max Chou <max.chou@sifive.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>
Subject: [PATCH v3 3/3] target/riscv: vadc and vsbc are vm=0 instructions
Date: Fri, 14 Nov 2025 01:16:04 +0800
Message-ID: <20251113171604.3034161-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113171604.3034161-1-max.chou@sifive.com>
References: <20251113171604.3034161-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62b.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

We were marking vadc and vsbc as vm=1 instructions, which meant
vext_check_input_eew wouldn't detect mask vs source register
overlaps.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b341832e41f..3647ec7f941 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -459,14 +459,14 @@ vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
 vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
 vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
 vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
-vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_1
-vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_1
-vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_1
+vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_0
+vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_0
+vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_0
 vmadc_vvm       010001 . ..... ..... 000 ..... 1010111 @r_vm
 vmadc_vxm       010001 . ..... ..... 100 ..... 1010111 @r_vm
 vmadc_vim       010001 . ..... ..... 011 ..... 1010111 @r_vm
-vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_1
-vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_1
+vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_0
+vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_0
 vmsbc_vvm       010011 . ..... ..... 000 ..... 1010111 @r_vm
 vmsbc_vxm       010011 . ..... ..... 100 ..... 1010111 @r_vm
 vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
-- 
2.43.0


