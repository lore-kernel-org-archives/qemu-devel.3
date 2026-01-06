Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D42CD0421
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd05l-00064M-PS; Tue, 06 Jan 2026 00:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05k-0005z9-Bt
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:52 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05i-0003LJ-Jf
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:52 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34c708702dfso717815a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679129; x=1768283929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCpIjpsrCUR2qMpdr14Fk1NscDt+wOkSEYl3ksgD64E=;
 b=WiIAxol84JubEgtY7dhLmY4VemoHWzPL/cBZrnJB9kkPHzXQw2RysQBJAki2vhZDoO
 kIW9dGHs4hMq4abj0kmf0ku9PCMGYnB2O9iGX/eZc0lLU/8Jyfv2kkv/bHRFsuSz716I
 xndiMlQeOSO9oRY2/zuGU+pK2AXkf/wY5I9n42bff+ar2AKMRSxrbJCb9bGdQF4Df5Mu
 /3YGwHR/CzOI8/JJBiNoSlh12E/YFzqgZd8i8YPr6hjdqC2Ib0QhyguKbHBRcGh5tnCj
 J/NUJzEKM941GF63uJnrocykPgMwKGo+r0sgvH9NwpfwY5e7xJhxcwZHnVYSGV4qgnKU
 LW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679129; x=1768283929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JCpIjpsrCUR2qMpdr14Fk1NscDt+wOkSEYl3ksgD64E=;
 b=JPVkDvjwomgI7B4aMWFL4FoGCxvgCGIMyhqemOEa7SR3l7upM9eNx5Ej3iIaO8Ic0d
 LexnnWHvOWlYicjiMYwf2SE/CV0SjyZ1iqS0y6aSSaNbX8zjJhYAR+zDhRcxud8VOZ2B
 8I8ibKG+dWWlM82Z6/JziVYUGbAGTTZwDyzOPAt0BdyKZUEc+ZSACLbr7SGaHvnbfzpZ
 jNG9naVFf9PXkln0yS4o4UWi3TVGtUu9vdiJNNofzhqWhI+mvti+6lg2Ua61pTJgXS3t
 1+Q0egS3Ss6bwwVtV6rnensVjK1a9MN74uCHdvpZcTsFLxarShRB+x1mU+V9MsKfToeh
 uduQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi4JaB8hEDY3DiC4I3Wqormb4kxmOvgocFavL1Tfrp6PMVA98MXb9ilw0walUuqBCASFHMmGS56PT0@nongnu.org
X-Gm-Message-State: AOJu0YzS7LbpMCdA6MpVWHPJymnHaBtcJEmoxzPwlzlQLE7iNCt+MJNt
 LXG272Z29qWKO5SC3d5NqsSjjEL868JnXXoMmpmpMQ+yGZA00b2OTs/y
X-Gm-Gg: AY/fxX4HUmecvjABVuA+1U+AvM8RkeSTszhip51CNOzpZThIf8O32+prrKAuJ4k4Xf8
 /mHcbFcK5M4KrQib9WVBbmw7OSy4NW9Gxmvjrcy3jQYe/G6CNfou5DHkMdkFP81hgVDCFKEuNXX
 CArG2E9sRmx5iMTFE9fQSDjitBCOblbpgnKku3tWSY/Iu/F/8yPud3bGRf/mn20cKU1nivWaP+P
 FUqbi4WLqG1g0bAi/qeTZa3f1lDHR9pYE8SP8XDV93wUyzD14sdr/4MpdE9AZjckMpFlLjNowaD
 8cIX+QQroqInoeCywpzwwGzp2iprHDh2ES+PLsQlgLOlXW2j3lF0se0Jt+e8/FLv3y2YhepXTKf
 WCSof3NLVnwX7CqUW7Cfs+MdVrSllNk5Q0u712k/NluqVVf5xb1mqFPAzEsYtkGv1BHvcKeDkRz
 DABS5StoVAH7pob4mxugvU
X-Google-Smtp-Source: AGHT+IEwO0RzMsTuRGwi8RKI5nod+MdjLGAjXq95v+boCVs90QVQA+O88QSSIRJfH+0qr7U77+7wPg==
X-Received: by 2002:a17:90b:1c07:b0:341:2b78:61b8 with SMTP id
 98e67ed59e1d1-34f5f301a25mr1538602a91.20.1767679129285; 
 Mon, 05 Jan 2026 21:58:49 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:58:48 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 16/16] hw/riscv/atlantis: Use halting kernel if there is no
 payload
Date: Tue,  6 Jan 2026 16:26:56 +1030
Message-ID: <20260106055658.209029-17-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

To avoid OpenSBI hanging with no messages if there is no kernel
provided, add the simple payload in that case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index f0ad7d574e03..5d6944b6411f 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -746,15 +746,15 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
                                                      firmware_name,
                                                      &start_addr, NULL);
 
+    kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                     firmware_end_addr);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
-                                                         firmware_end_addr);
         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
                           true, NULL);
-        kernel_entry = boot_info.image_low_addr;
     } else {
-        kernel_entry = 0;
+        riscv_setup_halting_payload(machine, &boot_info, kernel_start_addr);
     }
+    kernel_entry = boot_info.image_low_addr;
 
     fdt_load_addr = riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].base,
                                            s->memmap[TT_ATL_DDR_LO].size,
-- 
2.47.3


